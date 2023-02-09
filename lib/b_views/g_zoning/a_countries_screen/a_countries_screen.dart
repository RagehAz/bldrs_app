import 'dart:async';

import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/aa_countries_screen_browse_view.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/aa_countries_screen_search_view.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/protocols/census_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:stringer/stringer.dart';

class CountriesScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CountriesScreen({
    @required this.zoneViewingEvent,
    @required this.depth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ViewingEvent zoneViewingEvent;
  final ZoneDepth depth;
  /// --------------------------------------------------------------------------
  @override
  _CountriesScreenState createState() => _CountriesScreenState();
  /// --------------------------------------------------------------------------
}

class _CountriesScreenState extends State<CountriesScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<Phrase>> _foundCountries = ValueNotifier<List<Phrase>>(null);
  // --------------------
  List<String> _shownCountriesIDs = <String>[];
  List<String> _notShownCountriesIDs = <String>[];
  // --------------------
  List<CensusModel> _censuses;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        await _loadCountries();

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _isSearching.dispose();
    _foundCountries.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LOADING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadCountries() async {

    /// COUNTRIES STAGES
    final Staging _countriesStages = await StagingProtocols.fetchCountriesStaging();

    /// SHOWN IDS
    final List<String> _shownIDs = _countriesStages.getIDsByViewingEvent(
      event: widget.zoneViewingEvent,
    );

    /// NOT SHOWN IDS
    final List<String> _notShownIDs = Stringer.removeStringsFromStrings(
      removeFrom: Flag.getAllCountriesIDs(),
      removeThis: _shownIDs,
    );

    /// CENSUS
    final List<CensusModel> _countriesCensuses = await  CensusProtocols.fetchCountriesCensusesByIDs(
        countriesIDs: [...?_shownIDs, ...?_notShownIDs],
    );

    if (mounted) {
      setState(() {

        _shownCountriesIDs = Flag.sortCountriesNamesAlphabetically(
          context: context,
          countriesIDs: _shownIDs,
        );

        _notShownCountriesIDs = Flag.sortCountriesNamesAlphabetically(
          context: context,
          countriesIDs: _notShownIDs,
        );

        _censuses = _countriesCensuses;

      });
    }


  }
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchCountry(String val) async {

    TextCheck.triggerIsSearchingNotifier(
      text: val,
      isSearching: _isSearching,
      mounted: mounted,
    );

    /// WHILE SEARCHING
    if (_isSearching.value  == true){

      /// START LOADING
      await _triggerLoading(setTo: true);

      /// CLEAR PREVIOUS SEARCH RESULTS
      setNotifier(
          notifier: _foundCountries,
          mounted: mounted,
          value: <Phrase>[],
      );

      /// SEARCH COUNTRIES FROM LOCAL PHRASES
       final List<Phrase> _byName = await ZoneProtocols.searchCountriesByNameFromLDBFlags(
        text: val,
      );

       final List<Phrase> _byID = ZoneProtocols.searchCountriesByIDFromAllFlags(
         text: val,
       );

      setNotifier(
          notifier: _foundCountries,
          mounted: mounted,
          value: Phrase.insertPhrases(
            insertIn: _byName,
            phrasesToInsert: _byID,
            overrideDuplicateID: true,
            allowDuplicateIDs: false,
          ),
      );

      /// CLOSE LOADING
      await _triggerLoading(setTo: false);

    }

  }
  // -----------------------------------------------------------------------------

  /// NAVIGATION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onCountryTap(String countryID) async {

    await ZoneSelection.onSelectCountry(
        context: context,
        countryID: countryID,
        depth: widget.depth,
        zoneViewingEvent: widget.zoneViewingEvent,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDeactivatedCountryTap(String countryID) async {

    blog('onDeactivatedCountryTap : browse view : $countryID');

    await Dialogs.zoneIsNotAvailable(
      context: context,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      historyButtonIsOn: false,
      onSearchSubmit: _onSearchCountry,
      onSearchChanged: _onSearchCountry,
      title: const Verse(
        id: 'phid_select_a_country',
        translate: true,
      ),
      pyramidsAreOn: true,
      onBack: () => Nav.goBack(
        context: context,
        invoker: 'SelectCountryScreen.BACK with null',
      ),
      searchHintVerse: const Verse(
        id: 'phid_search_countries',
        translate: true,
      ),
      loading: _loading,
      child: Scroller(
        child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (BuildContext context, bool isSearching, Widget child){

            /// WHILE SEARCHING
            if (isSearching == true){

              return SelectCountryScreenSearchView(
                loading: _loading,
                foundCountries: _foundCountries,
                shownCountriesIDs: _shownCountriesIDs,
                countriesCensus: _censuses,
                onCountryTap: _onCountryTap,
                onDeactivatedCountryTap: _onDeactivatedCountryTap,
              );

            }

            /// NOT SEARCHING
            else {

              return CountriesScreenBrowseView(
                shownCountriesIDs: _shownCountriesIDs,
                notShownCountriesIDs: _notShownCountriesIDs,
                countriesCensus: _censuses,
                onCountryTap: _onCountryTap,
                onDeactivatedCountryTap: _onDeactivatedCountryTap,
              );

            }

          },
        ),
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
