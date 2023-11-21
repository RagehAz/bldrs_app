import 'dart:async';

import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:basics/helpers/models/phrase_model.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/aa_countries_screen_browse_view.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/aa_countries_screen_search_view.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/census_protocols/census_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_protocols.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';

class CountriesScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const CountriesScreen({
    required this.zoneViewingEvent,
    required this.depth,
    required this.viewerZone,
    required this.selectedZone,
    super.key
  });
  // --------------------
  final ViewingEvent zoneViewingEvent;
  final ZoneDepth depth;
  final ZoneModel? viewerZone;
  final ZoneModel? selectedZone;
  // --------------------
  @override
  _CountriesScreenState createState() => _CountriesScreenState();
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onSearchCountry({
    required String? val,
    required ValueNotifier<bool> isSearching,
    required bool mounted,
    required ValueNotifier<bool> loading,
    required ValueNotifier<List<Phrase>?> foundCountries,
  }) async {

    TextCheck.triggerIsSearchingNotifier(
      text: val,
      isSearching: isSearching,
      mounted: mounted,
      minCharLimit: 2,
    );

    /// WHILE SEARCHING
    if (isSearching.value  == true){

      /// START LOADING
      setNotifier(
        notifier: loading,
        mounted: mounted,
        value: true,
      );

      /// CLEAR PREVIOUS SEARCH RESULTS
      setNotifier(
        notifier: foundCountries,
        mounted: mounted,
        value: <Phrase>[],
      );

      final String? _searchText = val?.toLowerCase();
      List<Phrase> _phrasesToInsert = [];


      if (America.searchTextIsExactlyUSA(_searchText) == true){
        _phrasesToInsert = America.createAllStatesPhrases();
      }

      else if (TextCheck.isEmpty(_searchText) == false){

        /// SEARCH COUNTRIES FROM LOCAL PHRASES
        final List<Phrase> _byName = await ZoneProtocols.searchCountriesByNameFromLDBFlags(
          text: _searchText,
        );

        final List<Phrase> _byID = ZoneProtocols.searchCountriesByIDFromAllFlags(
          text: _searchText,
        );

        final List<Phrase> _usStatesByName = America.searchStatesByName(
            text: _searchText,
            withISO2: false,
        );
        final List<Phrase> _usStateByISO2 = America.searchStatesByISO2(
            text: _searchText,
        );

        _phrasesToInsert = [..._byName, ..._byID, ..._usStatesByName, ..._usStateByISO2];
        _phrasesToInsert = Phrase.sortNamesAlphabetically(_phrasesToInsert);

      }

      setNotifier(
        notifier: foundCountries,
        mounted: mounted,
        value: Phrase.insertPhrases(
          insertIn: [],
          phrasesToInsert: _phrasesToInsert,
          overrideDuplicateID: true,
          allowDuplicateIDs: false,
        ),
      );

       /// CLOSE LOADING
      setNotifier(
        notifier: loading,
        mounted: mounted,
        value: false,
      );

    }

  }
  // --------------------------------------------------------------------------
}

class _CountriesScreenState extends State<CountriesScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<Phrase>?> _foundCountries = ValueNotifier<List<Phrase>?>(null);
  // --------------------
  List<String> _activeCountriesIDs = <String>[];
  List<String> _disabledCountriesIDs = <String>[];
  // --------------------
  List<CensusModel>? _censuses;
  CensusModel? _planetCensus;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
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
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        await Future.delayed(const Duration(milliseconds: 400));

        await _loadCountries();

        await _triggerLoading(setTo: false);
      });

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
    final StagingModel? _countriesStages = await StagingProtocols.fetchCountriesStaging();

    if (_countriesStages != null){
      // --------------------

      /// SHOWN COUNTRIES IDS

      // --------------------
      /// ACTIVE IDS
      List<String> _activeIDs = _countriesStages.getIDsByViewingEvent(
        event: widget.zoneViewingEvent,
        countryID: null,
        viewerCountryID: widget.viewerZone?.countryID,
      );
      /// ACTIVATE MY COUNTRY ID
      _activeIDs = StagingModel.addMyCountryIDToActiveCountries(
        shownCountriesIDs: _activeIDs,
        myCountryID: widget.viewerZone?.countryID,
        event: widget.zoneViewingEvent,
      );
      /// SHOW USA IF A STATE IS SHOWN
      _activeIDs = America.addUSAIDToCountriesIDsIfContainsAStateID(
          countriesIDs: _activeIDs,
      );
      // --------------------

      /// DISABLED COUNTRIES IDS

      // --------------------
      /// DISABLED IDS
      List<String> _disabledIDs = Stringer.removeStringsFromStrings(
        removeFrom: _countriesStages.getAllIDs(),
        removeThis: _activeIDs,
      );
      /// ADD USA IF NOT ADDED
      if (_activeIDs.contains('usa') == false){
        _disabledIDs = America.addUSAIDToCountriesIDsIfContainsAStateID(
          countriesIDs: _disabledIDs,
        );
      }
      // --------------------

      /// SORT COUNTRIES

      // --------------------
      /// SORT SHOWN
      _activeIDs = CountryModel.sortCountriesNamesAlphabetically(
        countriesIDs: _activeIDs,
        langCode: Localizer.getCurrentLangCode(),
      );
      /// SORT NOT SHOWN
      _disabledIDs = CountryModel.sortCountriesNamesAlphabetically(
        countriesIDs: _disabledIDs,
        langCode: Localizer.getCurrentLangCode(),
      );
      // --------------------

      /// CENSUS

      // --------------------
      /// CENSUS
      final List<CensusModel> _countriesCensuses = await  CensusProtocols.fetchCountriesCensusesByIDs(
        countriesIDs: [..._activeIDs, ..._disabledIDs],
      );
      final CensusModel? _fetchedPlanetCensus = await CensusProtocols.fetchPlanetCensus();
      // --------------------

      /// SET DATA

      // --------------------
      if (mounted == true) {
        setState(() {
          _activeCountriesIDs = _activeIDs;
          _disabledCountriesIDs = _disabledIDs;
          _censuses = _countriesCensuses;
          _planetCensus = _fetchedPlanetCensus;
          // Stringer.blogStrings(strings: _shownCountriesIDs, invoker: 'loadCountries');
        });
      }
      // --------------------
    }

  }
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchCountry(String? val) async {

    await CountriesScreen.onSearchCountry(
      mounted: mounted,
      foundCountries: _foundCountries,
      isSearching: _isSearching,
      loading: _loading,
      val: val,
    );

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
      viewerZone: widget.viewerZone,
      selectedZone: countryID == widget.selectedZone?.countryID ?
      widget.selectedZone
          :
      ZoneModel(
        countryID: countryID,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPlanetTap() async {

    await ZoneSelection.onSelectCountry(
      context: context,
      countryID: Flag.planetID,
      depth: widget.depth,
      zoneViewingEvent: widget.zoneViewingEvent,
      viewerZone: widget.viewerZone,
      selectedZone: ZoneModel.planetZone,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDeactivatedCountryTap(String? countryID) async {

    blog('onDeactivatedCountryTap : browse view : $countryID');

    await Dialogs.zoneIsNotAvailable();

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      canSwipeBack: true,
      skyType: SkyType.grey,
      appBarType: AppBarType.search,
      searchButtonIsOn: false,
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
      child: ValueListenableBuilder(
          valueListenable: _loading,
          builder: (BuildContext context, bool loading, Widget? child){

            if (loading == true){
              return const LoadingFullScreenLayer();
            }

            else {

              return WidgetFader(
                fadeType: FadeType.fadeIn,
                child: ValueListenableBuilder(
                  valueListenable: _isSearching,
                  builder: (BuildContext context, bool isSearching, Widget? child){

                    /// WHILE SEARCHING
                    if (isSearching == true){

                      return CountriesScreenSearchView(
                        foundCountries: _foundCountries,
                        activeCountriesIDs: _activeCountriesIDs,
                        disabledCountriesIDs: _disabledCountriesIDs,
                        countriesCensus: _censuses,
                        selectedZone: widget.selectedZone,
                        onCountryTap: _onCountryTap,
                        onDisabledCountryTap: _onDeactivatedCountryTap,
                      );

                    }

                    /// WHILE BROWSING
                    else {
                      return CountriesScreenBrowseView(
                        shownCountriesIDs: _activeCountriesIDs,
                        disabledCountriesIDs: _disabledCountriesIDs,
                        countriesCensus: _censuses,
                        planetCensus: _planetCensus,
                        selectedZone: widget.selectedZone,
                        onCountryTap: _onCountryTap,
                        onDisabledCountryTap: _onDeactivatedCountryTap,
                        onPlanetTap: _onPlanetTap,
                        showPlanetButton: StagingModel.checkMayShowViewAllZonesButton(
                          zoneViewingEvent: widget.zoneViewingEvent,
                        ),
                      );

                    }

                    },
                ),
              );

            }

        }
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
