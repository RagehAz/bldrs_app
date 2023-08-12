import 'dart:async';

import 'package:basics/animators/widgets/scroller.dart';
import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/staging_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
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
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:flutter/material.dart';

class CountriesScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CountriesScreen({
    required this.zoneViewingEvent,
    required this.depth,
    required this.viewerCountryID,
    required this.selectedZone,
    this.canSetPlanetAsCurrentZone = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ViewingEvent zoneViewingEvent;
  final ZoneDepth depth;
  final String? viewerCountryID;
  final bool canSetPlanetAsCurrentZone;
  final ZoneModel? selectedZone;
  /// --------------------------------------------------------------------------
  @override
  _CountriesScreenState createState() => _CountriesScreenState();
  /// --------------------------------------------------------------------------
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

      /// SEARCH COUNTRIES FROM LOCAL PHRASES
      final List<Phrase> _byName = await ZoneProtocols.searchCountriesByNameFromLDBFlags(
        text: val?.toLowerCase(),
      );

      final List<Phrase> _byID = ZoneProtocols.searchCountriesByIDFromAllFlags(
        text: val?.toLowerCase(),
      );

       setNotifier(
         notifier: foundCountries,
         mounted: mounted,
         value: Phrase.insertPhrases(
           insertIn: _byName,
           phrasesToInsert: _byID,
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
  /// --------------------------------------------------------------------------

}

class _CountriesScreenState extends State<CountriesScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<Phrase>?> _foundCountries = ValueNotifier<List<Phrase>?>(null);
  // --------------------
  List<String> _shownCountriesIDs = <String>[];
  List<String> _notShownCountriesIDs = <String>[];
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

    // _countriesStages.blogStaging();

    /// SHOWN IDS
    final List<String>? _shownIDs = _countriesStages?.getIDsByViewingEvent(
      event: widget.zoneViewingEvent,
      countryID: null,
      viewerCountryID: widget.viewerCountryID,
    );

    /*
    THIS IS FOR PRESENTING ARAB COUNTRIES FOR APP STORE ONLY
    /// -->>>>>>
    _shownIDs = [
    "dza",  // Algeria
    "bhr",  // Bahrain
    "com",  // Comoros
    "dji",  // Djibouti
    "egy",  // Egypt
    "irq",  // Iraq
    "jor",  // Jordan
    "kwt",  // Kuwait
    "lbn",  // Lebanon
    "lby",  // Libya
    "mrt",  // Mauritania
    "mar",  // Morocco
    "omn",  // Oman
    "pse",  // Palestine
    "qat",  // Qatar
    "sau",  // Saudi Arabia
    "som",  // Somalia
    "sdn",  // Sudan
    "syr",  // Syria
    "tun",  // Tunisia
    "are",  // United Arab Emirates
    "yem"   // Yemen
  ];
    /// -->>>>>>
     */

    blog('CountriesScreen._loadCountries() : _shownIDs : $_shownIDs');

    /// NOT SHOWN IDS
    final List<String>? _notShownIDs = Stringer.removeStringsFromStrings(
      removeFrom: Flag.getAllCountriesIDs(),
      removeThis: _shownIDs,
    );

    /// FINAL IDS
    final List<String> _shown = Flag.sortCountriesNamesAlphabetically(
      countriesIDs: _shownIDs,
      langCode: Localizer.getCurrentLangCode(),
    );

    final List<String> _notShown = Flag.sortCountriesNamesAlphabetically(
      countriesIDs: _notShownIDs,
      langCode: Localizer.getCurrentLangCode(),
    );

    /// CENSUS
    final List<CensusModel> _countriesCensuses = await  CensusProtocols.fetchCountriesCensusesByIDs(
        countriesIDs: [...?_shownIDs, ...?_notShownIDs],
    );
    final CensusModel? _fetchedPlanetCensus = await CensusProtocols.fetchPlanetCensus();


    if (mounted) {
      setState(() {

        _shownCountriesIDs = _shown;
        _notShownCountriesIDs = _notShown;

        _censuses = _countriesCensuses;
        _planetCensus = _fetchedPlanetCensus;

      });
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
  Future<void> _onCountryTap(String? countryID) async {
    blog('onCountryTap : browse view : $countryID');
    await ZoneSelection.onSelectCountry(
      context: context,
      countryID: countryID,
      depth: widget.depth,
      zoneViewingEvent: widget.zoneViewingEvent,
      viewerCountryID: widget.viewerCountryID,
      selectedZone: ZoneModel(countryID: countryID,),
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
      skyType: SkyType.black,
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
                child: Scroller(
                  child: ValueListenableBuilder(
                    valueListenable: _isSearching,
                    builder: (BuildContext context, bool isSearching, Widget? child){

                      /// WHILE SEARCHING
                      if (isSearching == true){

                        return SelectCountryScreenSearchView(
                          foundCountries: _foundCountries,
                          shownCountriesIDs: _shownCountriesIDs,
                          countriesCensus: _censuses,
                          selectedZone: widget.selectedZone,
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
                          showPlanetButton: StagingModel.checkMayShowViewAllZonesButton(
                            zoneViewingEvent: widget.zoneViewingEvent,
                          ),
                          planetCensus: _planetCensus,
                          selectedZone: widget.selectedZone,
                          onPlanetTap: () async {
                            final bool _isSettingCurrentZone =
                                widget.zoneViewingEvent == ViewingEvent.homeView
                                    &&
                                    widget.canSetPlanetAsCurrentZone == true;
                            if (_isSettingCurrentZone == true){
                              await ZoneSelection.setCurrentZoneAndNavHome(
                                zone: null,
                              );
                            }
                            else {
                              await Nav.goBack(context: context);
                            }
                            },
                        );

                      }

                      },
                  ),
                ),
              );

            }

        }
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
