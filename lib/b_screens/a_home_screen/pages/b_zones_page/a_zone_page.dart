import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/strings/searching.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/models/flag_model.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/b_zones_page/b_country_view.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/b_zones_page/c_city_view.dart';
import 'package:bldrs/b_screens/d_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/c_protocols/census_protocols/census_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/b_zone_search_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_protocols.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:flutter/material.dart';

class ZonePage extends StatefulWidget {
  // --------------------------------------------------------------------------
  const ZonePage({
    super.key
  });
  // --------------------
  @override
  State<ZonePage> createState() => _ZonePageState();
  // --------------------------------------------------------------------------
}

class _ZonePageState extends State<ZonePage> {
  // -----------------------------------------------------------------------------
  ZoneModel? _viewerZone;
  ZoneModel? _newZone;
  bool _isShowingCounties = true;
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

    _viewerZone = UsersProvider.proGetUserZone(context: context, listen: false);

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

    _isSearchingCountries.dispose();
    _foundCountries.dispose();
    _loading.dispose();

    _isSearchingCities.dispose();
    _foundCities.dispose();
    _countryCities.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// COUNTRIES VARIABLES

  // --------------------
  final ValueNotifier<bool> _isSearchingCountries = ValueNotifier<bool>(false);
  final ValueNotifier<List<Phrase>?> _foundCountries = ValueNotifier<List<Phrase>?>(null);
  // --------------------
  List<String> _activeCountriesIDs = <String>[];
  List<String> _disabledCountriesIDs = <String>[];
  // --------------------
  List<CensusModel>? _countriesCensuses;
  CensusModel? _planetCensus;
  // -----------------------------------------------------------------------------

  /// LOADING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadCountries() async {

    /// COUNTRIES STAGES
    final StagingModel? _countriesStages = await StagingProtocols.fetchCountriesStaging();

    if (_countriesStages != null && mounted){
      // --------------------

      /// SHOWN COUNTRIES IDS

      // --------------------
      /// ACTIVE IDS
      List<String> _activeIDs = _countriesStages.getIDsByViewingEvent(
        event: ViewingEvent.homeView,
        countryID: null,
        viewerCountryID: UsersProvider.proGetUserZone(context: getMainContext(), listen: false)?.countryID,
      );
      /// ACTIVATE MY COUNTRY ID
      _activeIDs = StagingModel.addMyCountryIDToActiveCountries(
        shownCountriesIDs: _activeIDs,
        myCountryID: UsersProvider.proGetUserZone(context: getMainContext(), listen: false)?.countryID,
        event: ViewingEvent.homeView,
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
      final List<CensusModel> _censuses = await  CensusProtocols.fetchCountriesCensusesByIDs(
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
          _countriesCensuses = _censuses;
          _planetCensus = _fetchedPlanetCensus;
          // Stringer.blogStrings(strings: _shownCountriesIDs, invoker: 'loadCountries');
        });
      }
      // --------------------
    }

  }
  // -----------------------------------------------------------------------------

  /// SEARCH COUNTRIES

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchCountry(String? val) async {

    await CountriesScreen.onSearchCountry(
      mounted: mounted,
      foundCountries: _foundCountries,
      isSearching: _isSearchingCountries,
      loading: _loading,
      val: val,
    );

  }
  // -----------------------------------------------------------------------------

  /// COUNTRIES NAVIGATION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onCountryTap(String countryID) async {

    await Keyboard.closeKeyboard();

    final ZoneModel? _zoneWithCountry = await ZoneProtocols.completeZoneModel(
        invoker: 'onSelectCountry',
        incompleteZoneModel: ZoneModel(
          countryID: countryID,
        ),
      );

    ///
    if (countryID == Flag.planetID || countryID == 'usa'){

      await _setZoneAndGo(
        zone: _zoneWithCountry,
      );

    }

    /// Go to Cities Screen
    else {

      setState(() {
        _newZone = _zoneWithCountry;
        _isShowingCounties = false;
      });

      await _loadCities();

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPlanetTap() async {

    await Keyboard.closeKeyboard();

    final ZoneModel? _zoneWithCountry = await ZoneProtocols.completeZoneModel(
      invoker: 'onSelectCountry',
      incompleteZoneModel: const ZoneModel(
        countryID: Flag.planetID,
      ),
    );

    await _setZoneAndGo(
      zone: _zoneWithCountry,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDeactivatedCountryTap(String? countryID) async {

    await Dialogs.zoneIsNotAvailable();

  }
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearchingCities = ValueNotifier<bool>(false);
  final ValueNotifier<List<CityModel>> _countryCities = ValueNotifier<List<CityModel>>(<CityModel>[]);
  final ValueNotifier<List<CityModel>?> _foundCities = ValueNotifier<List<CityModel>?>(null);
  List<String>? _shownCitiesIDs = <String>[];
  // --------------------
  List<CensusModel>? _citiesCensuses;
  CensusModel? _countryCensus;
  // -----------------------------------------------------------------------------

  /// LOAD

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadCities() async {

    await _triggerLoading(setTo: true);

    final StagingModel? _citiesStages = await StagingProtocols.fetchCitiesStaging(
      countryID: _newZone?.countryID,
      invoker: '_loadCities',
    );

    if (_citiesStages != null){

      // _citiesStages.blogStaging();

      final List<CityModel> _cities = await ZoneProtocols.fetchCitiesOfCountryByIDs(
        citiesIDsOfThisCountry: _citiesStages.getAllIDs(),
      );

      if (mounted == true){

        /// SHOWN CITIES IDS
        final List<String> _idsToView = _citiesStages.getIDsByViewingEvent(
          event: ViewingEvent.homeView,
          countryID: _newZone?.countryID,
          viewerCountryID: _viewerZone?.countryID,
        );
        final List<String> _shownIDs = StagingModel.addMyCityIDToShownCities(
          shownIDs: _idsToView,
          event: ViewingEvent.homeView,
          myCityID: _viewerZone?.cityID,
        );

        // Stringer.blogStrings(strings: _shownIDs, invoker: 'shownCities');

        /// SHOWN CITIES MODEL
        final List<CityModel> _orderedShownCities = CityModel.sortCitiesAlphabetically(
          langCode: Localizer.getCurrentLangCode(),
          cities: CityModel.getCitiesFromCitiesByIDs(
            citiesModels: _cities,
            citiesIDs: _shownIDs,
          ),
        );
        /// NOT SHOWN CITIES IDS
        final List<String>? _notShownIDs = Stringer.removeStringsFromStrings(
          removeFrom: CityModel.getCitiesIDs(_cities),
          removeThis: _shownIDs,
        );
        /// NOT SHOWN CITIES MODELS
        final List<CityModel> _orderedNotShownCities = CityModel.sortCitiesAlphabetically(
          langCode: Localizer.getCurrentLangCode(),
          cities: CityModel.getCitiesFromCitiesByIDs(
            citiesModels: _cities,
            citiesIDs: _notShownIDs,
          ),
        );

        final List<CensusModel> _censuses = await CensusProtocols.fetchCitiesCensuses(
            citiesIDs: <String>[..._shownIDs, ...?_notShownIDs]
        );
        final CensusModel? _censusOfCountry = await CensusProtocols.fetchCountryCensus(
          countryID: _newZone?.countryID,
        );

        if (mounted == true){

          setState(() {
            _shownCitiesIDs = _shownIDs;
            // _stages = _citiesStages;
            _citiesCensuses = _censuses;
            _countryCensus = _censusOfCountry;
          });

        }

        setNotifier(
          notifier: _countryCities,
          mounted: mounted,
          value: <CityModel>[..._orderedShownCities, ..._orderedNotShownCities],
        );
      }

    }

    await _triggerLoading(setTo: false);
  }
  // --------------------
  /// TESTED : WORKS PERFECT : KEPT FOR REFERENCE
  /*
  Future<void> _oldLoadCities() async {

    /// COMPLETE CURRENT ZONE
    _currentZone.value  = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: _currentZone.value,
    );

    List<CityModel> _growingList = <CityModel>[];
    final List<CityModel> _fetchedCities = await ZoneProtocols.fetchCities(
      citiesIDs: _currentZone.value.countryModel?.citiesIDs?.getAllIDs(),
      onCityRead: (CityModel city) async {

        if (mounted == true){

          _growingList = CityModel.addCityToCities(
            cities: _countryCities.value,
            city: city,
          );

          final List<CityModel> _ordered = CityModel.sortCitiesAlphabetically(
            context: context,
            cities: _growingList,
          );

          _countryCities.value  = <CityModel>[..._ordered];

        }

      },
    );

    if (mounted == true){
      final List<CityModel> _ordered = CityModel.sortCitiesAlphabetically(
        context: context,
        cities: _fetchedCities,
      );
      _countryCities.value  = <CityModel>[..._ordered];
    }

  }
   */
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchCity(String? inputText) async {

    Searching.triggerIsSearchingNotifier(
      text: inputText,
      isSearching: _isSearchingCities,
      mounted: mounted,
    );

    /// WHILE SEARCHING
    if (_isSearchingCities.value  == true){

      /// START LOADING
      await _triggerLoading(setTo: true);

      /// CLEAR PREVIOUS SEARCH RESULTS
      setNotifier(
        notifier: _foundCities,
        mounted: mounted,
        value: <CityModel>[],
      );

      /// SEARCH COUNTRIES FROM LOCAL PHRASES
      final List<CityModel> _cities = await searchCitiesByName(
        context: context,
        input: TextMod.fixCountryName(input: inputText),
      );

      setNotifier(
        notifier: _foundCities,
        mounted: mounted,
        value: _cities,
      );

      /// CLOSE LOADING
      await _triggerLoading(setTo: false);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<CityModel>> searchCitiesByName({
    required BuildContext context,
    required String? input,
  }) async {

    /// SEARCH SELECTED COUNTRY CITIES
    final List<CityModel> _searchResult = ZoneSearchOps.searchCitiesByNameFromCities(
      context: context,
      sourceCities: _countryCities.value,
      inputText: input,
    );

    /// SET FOUND CITIES
    return _searchResult;

  }
  // -----------------------------------------------------------------------------

  /// NAV

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onCitySelected(String? cityID) async {

    final String? _countryID = CityModel.getCountryIDFromCityID(cityID);

    ZoneModel? _zoneWithCity;
    await Keyboard.closeKeyboard();

    if (_countryID != null && cityID != null){
      _zoneWithCity = await ZoneProtocols.completeZoneModel(
        invoker: 'onSelectCity',
        incompleteZoneModel: ZoneModel(
          countryID: _countryID,
          cityID: cityID,
        ),
      );
    }

    await _setZoneAndGo(zone: _zoneWithCity);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDeactivatedCityTap(String? cityID) async {

    blog('onDeactivatedCityTap : browseView : cityID : $cityID');

    await Dialogs.zoneIsNotAvailable();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onTapAllCities() async {

    final String? _countryID = _newZone?.countryID;

    ZoneModel? _zoneWithCity;
    await Keyboard.closeKeyboard();

    if (_countryID != null){
      _zoneWithCity = await ZoneProtocols.completeZoneModel(
        invoker: 'onSelectCity',
        incompleteZoneModel: ZoneModel(
          countryID: _countryID,
          cityID: Flag.allCitiesID,
        ),
      );
    }

    await _setZoneAndGo(zone: _zoneWithCity);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _setZoneAndGo({
    required ZoneModel? zone
  }) async {

    await ZoneProvider.proSetCurrentZone(
      zone: zone,
    );

    await MirageNav.goTo(tab: BldrsTab.home);

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// COUNTRIES VIEW
    if (_isShowingCounties == true){
      return SelectCountryView(
        loading: _loading,
        isSearching: _isSearchingCountries,
        activeCountriesIDs: _activeCountriesIDs,
        censuses: _countriesCensuses,
        disabledCountriesIDs: _disabledCountriesIDs,
        foundCountries: _foundCountries,
        onCountryTap: _onCountryTap,
        onDeactivatedCountryTap: _onDeactivatedCountryTap,
        onPlanetTap: _onPlanetTap,
        onSearch: _onSearchCountry,
        planetCensus: _planetCensus,
      );
    }

    /// CITIES VIEW
    else {
      return SelectCityView(
        selectedZone: _newZone!,
        onSearch: _onSearchCity,
        isSearching: _isSearchingCities,
        loading: _loading,
        zoneViewingEvent: ViewingEvent.homeView,
        citiesCensuses: _citiesCensuses,
        countryCensus: _countryCensus,
        countryCities: _countryCities,
        foundCities: _foundCities,
        onCityDeactivatedTap: _onDeactivatedCityTap,
        onCitySelected: _onCitySelected,
        onTapAllCities: _onTapAllCities,
        shownCitiesIDs: _shownCitiesIDs,
        appBarType: AppBarType.basic,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
