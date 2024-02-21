import 'dart:async';
import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/searching.dart';
import 'package:basics/models/america.dart';
import 'package:basics/models/flag_model.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/b_screens/d_zoning/a_countries_screen/aa_countries_screen_browse_view.dart';
import 'package:bldrs/b_screens/d_zoning/a_countries_screen/aa_countries_screen_search_view.dart';
import 'package:bldrs/b_screens/d_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/z_components/buttons/editors_buttons/editor_confirm_button.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
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
    required this.selectedCountries,
    this.ignoreCensusAndStaging = false,
    this.multipleSelection = false,
    super.key
  });
  // --------------------
  final ViewingEvent zoneViewingEvent;
  final ZoneDepth depth;
  final ZoneModel? viewerZone;
  final List<String>? selectedCountries;
  final bool ignoreCensusAndStaging;
  final bool multipleSelection;
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

    Searching.triggerIsSearchingNotifier(
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

      /// SEARCH IS PHONE CODE STARTS WITH +
      if (TextCheck.stringStartsExactlyWith(text: _searchText, startsWith: '+') == true){
        _phrasesToInsert = _searchCountriesByPhoneCode(
          phoneCode: _searchText,
        );
      }

      /// NORMAL TEXT SEARCH
      else if (TextCheck.isEmpty(_searchText) == false){

        _phrasesToInsert = await _searchCountriesByText(
          searchText: _searchText,
        );

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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Phrase>> _searchCountriesByText({
    required String? searchText,
  }) async {

    List<Phrase> _phrasesToInsert = [];

    if (TextCheck.isEmpty(searchText) == false){

      /// BY NAME
      final List<Phrase> _byName = await ZoneProtocols.searchCountriesByNameFromLDBFlags(
        text: searchText,
      );

      /// BY ID (ISO3)
      final List<Phrase> _byID = ZoneProtocols.searchCountriesByIDFromAllFlags(
        text: searchText,
      );

      /// BY ISO 2
      final List<Phrase> _byISO2 = ZoneProtocols.searchCountriesByISO2FromAllFlags(
        text: searchText,
      );

      /// US STATES
      final List<Phrase> _states = _getUSAStates(searchText: searchText);

      /// IF EMIRATES (UAE)
      final List<Phrase> _uae  = _getUAE(searchText: searchText);

      /// IF SAUDI (KSA)
      final List<Phrase> _sau  = _getSAU(searchText: searchText);

      /// STATES BY NAME
      final List<Phrase> _usStatesByName = America.searchStatesByName(
        text: searchText,
        withISO2: false,
      );

      /// STATES BY ISO2
      final List<Phrase> _usStateByISO2 = America.searchStatesByISO2(
        text: searchText,
      );

      _phrasesToInsert = [
        ..._byName,
        ..._byID,
        ..._byISO2,
        ..._states,
        ..._uae,
        ..._sau,
        ..._usStatesByName,
        ..._usStateByISO2
      ];
      _phrasesToInsert = Phrase.sortNamesAlphabetically(_phrasesToInsert);

    }

    return _phrasesToInsert;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> _getUSAStates({
    required String? searchText,
  }){
    return America.searchTextIsExactlyUSA(searchText) ?
    America.createAllStatesPhrases()
        :
    [];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> _getUAE({
    required String? searchText,
  }){

    List<Phrase> _output = [];

    if (TextCheck.stringContainsSubString(string: 'uae', subString: searchText) == true){

      Phrase? _phrase = CountryModel.getCountryPhrase(
        countryID: 'are',
        langCode: Localizer.getCurrentLangCode(),
      );
      _phrase ??= CountryModel.getCountryPhrase(
        countryID: 'are',
        langCode: 'en',
      );

      if (_phrase != null){
        _output = [_phrase];
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> _getSAU({
    required String? searchText,
  }){

    List<Phrase> _output = [];

    if (TextCheck.stringContainsSubString(string: 'ksa', subString: searchText) == true){

      Phrase? _phrase = CountryModel.getCountryPhrase(
        countryID: 'sau',
        langCode: Localizer.getCurrentLangCode(),
      );
      _phrase ??= CountryModel.getCountryPhrase(
        countryID: 'sau',
        langCode: 'en',
      );

      if (_phrase != null){
        _output = [_phrase];
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Phrase> _searchCountriesByPhoneCode({
    required String? phoneCode,
  }){

    final List<String> _countriesIDs = Flag.searchCountriesByPhoneCode(
      phoneCode: phoneCode,
    );

    return CountryModel.getCountriesPhrases(
        countriesIDs: _countriesIDs,
        langCode: Localizer.getCurrentLangCode(),
    );

  }
  // --------------------------------------------------------------------------
}

class _CountriesScreenState extends State<CountriesScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<Phrase>?> _foundCountries = ValueNotifier<List<Phrase>?>(null);
  // --------------------
  final ValueNotifier<List<String>> selectedCountries = ValueNotifier([]);
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

    selectedCountries.value = widget.selectedCountries ?? const [];

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {

        // await Future.delayed(const Duration(milliseconds: 400));

        if (widget.ignoreCensusAndStaging == true){
          await _loadCountriesIgnoreCensusAndStaging();
        }
        else {
          await _loadCountries();
        }

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
    selectedCountries.dispose();
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
          Stringer.blogStrings(strings: _activeCountriesIDs, invoker: 'loadCountries');
        });
      }
      // --------------------
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadCountriesIgnoreCensusAndStaging() async {

    // --------------------

    /// SHOWN COUNTRIES IDS

    // --------------------
    /// ACTIVE IDS
    List<String> _activeIDs = [...Flag.getAllCountriesIDs(), ...America.getStatesIDs()];
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
    List<String> _disabledIDs = [];
    /// ADD USA IF NOT ADDED
    // if (_activeIDs.contains('usa') == false){
    //   _disabledIDs = America.addUSAIDToCountriesIDsIfContainsAStateID(
    //     countriesIDs: _disabledIDs,
    //   );
    // }
    // --------------------

    /// SORT COUNTRIES

    // --------------------
    /// SORT SHOWN
    _activeIDs = CountryModel.sortCountriesNamesAlphabetically(
      countriesIDs: _activeIDs,
      langCode: Localizer.getCurrentLangCode(),
    );
    /// SORT NOT SHOWN
    _disabledIDs = [];
    // --------------------

    /// CENSUS

    // --------------------
    /// CENSUS
    final List<CensusModel> _countriesCensuses = [];
    const CensusModel? _fetchedPlanetCensus = null;
    // --------------------

    /// SET DATA

    // --------------------
    if (mounted == true) {
      setState(() {
        _activeCountriesIDs = _activeIDs;
        _disabledCountriesIDs = _disabledIDs;
        _censuses = _countriesCensuses;
        _planetCensus = _fetchedPlanetCensus;
        Stringer.blogStrings(strings: _activeCountriesIDs, invoker: 'loadCountries');
      });
    }
    // --------------------

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

    if (widget.multipleSelection == true){

      final List<String> _newIDs = Stringer.addOrRemoveStringToStrings(
          strings: selectedCountries.value,
          string: countryID,
      );

      setNotifier(notifier: selectedCountries, mounted: mounted, value: _newIDs);

    }

    else {

      final String? _selectedCountryID = selectedCountries.value.firstOrNull;
      final ZoneModel? _selectedZone = _selectedCountryID == null ? null : ZoneModel(countryID: _selectedCountryID);

      await ZoneSelection.onSelectCountry(
        context: context,
        countryID: countryID,
        depth: widget.depth,
        zoneViewingEvent: widget.zoneViewingEvent,
        viewerZone: widget.viewerZone,
        selectedZone: _selectedZone,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPlanetTap() async {

    if (widget.multipleSelection == true){

      setNotifier(notifier: selectedCountries, mounted: mounted, value: <String>[]);

    }

    else {

      await ZoneSelection.onSelectCountry(
        context: context,
        countryID: Flag.planetID,
        depth: widget.depth,
        zoneViewingEvent: widget.zoneViewingEvent,
        viewerZone: widget.viewerZone,
        selectedZone: ZoneModel.planetZone,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDeactivatedCountryTap(String? countryID) async {

    blog('onDeactivatedCountryTap : browse view : $countryID');

    await Dialogs.zoneIsNotAvailable();

  }
  // -----------------------------------------------------------------------------
  Widget? _getConfirmButton(){

    if (widget.multipleSelection == false){
      return null;
    }
    else {


      return ValueListenableBuilder(
          valueListenable: selectedCountries,
          builder: (BuildContext context, List<String> theSelectedCountries, Widget? child){

            final String? _confirmText = getWord('phid_confirm');
            final int _length = theSelectedCountries.length;
            final String? _count = _length == 0 ? '' : ' $_length';

            return ConfirmButton(
              enAlignment: Alignment.bottomCenter,
              confirmButtonModel: ConfirmButtonModel(
                firstLine: Verse.plain('$_confirmText$_count'),
                secondLine: _length == 0 ? getVerse('phid_the_entire_world') : null,
                onSkipTap: () => Nav.goBack(context: context),
                isWide: true,
                onTap: () => Nav.goBack(
                  context: context,
                  passedData: theSelectedCountries,
                ),
              ),
            );
          }
      );

    }

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
      confirmButton: _getConfirmButton(),
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
                    valueListenable: selectedCountries,
                    builder: (BuildContext context, List<String> theSelectedCountries, Widget? child){


                      return ValueListenableBuilder(
                        valueListenable: _isSearching,
                        builder: (BuildContext context, bool isSearching, Widget? child){

                          /// WHILE SEARCHING
                          if (isSearching == true){
                            return CountriesScreenSearchView(
                              foundCountries: _foundCountries,
                              activeCountriesIDs: _activeCountriesIDs,
                              disabledCountriesIDs: _disabledCountriesIDs,
                              countriesCensus: _censuses,
                              selectedCountries: theSelectedCountries,
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
                              selectedCountries: theSelectedCountries,
                              onCountryTap: _onCountryTap,
                              onDisabledCountryTap: _onDeactivatedCountryTap,
                              onPlanetTap: _onPlanetTap,
                              showPlanetButton: StagingModel.checkMayShowViewAllZonesButton(
                                zoneViewingEvent: widget.zoneViewingEvent,
                              ),
                            );
                          }

                          },
                      );
                    }
                    ),
              );

            }

        }
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
