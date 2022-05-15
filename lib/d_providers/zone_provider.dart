import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart' as Dialogz;
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/zone_ops.dart' as ZoneOps;
import 'package:bldrs/e_db/fire/search/zone_search.dart' as ZoneSearch;
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

// final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
class ZoneProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// FETCHING ZONES

// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<CountryModel> fetchCountryByID({
    @required BuildContext context,
    @required String countryID,
  }) async {
    /// 1 - search in entire LDBs for this CountryModel
    /// 2 - if not found, search firebase
    ///   2.1 read firebase country ops
    ///   2.2 if found on firebase, store in ldb sessionCountries
    CountryModel _countryModel;

    /// 1 - search in sessionCountries in LDB for this CountryModel
    final Map<String, Object> _map = await LDBOps.searchFirstMap(
      docName: LDBDoc.countries,
      fieldToSortBy: 'id',
      searchField: 'id',
      searchValue: countryID,
    );

    if (_map != null && _map != <String, Object>{}){
      blog('fetchCountryByID : country found in local db : ${LDBDoc.countries}');
      _countryModel = CountryModel.decipherCountryMap(
          map: _map,
          fromJSON: true
      );
    }

    /// 2 - if not found, search firebase
    if (_countryModel == null){
      blog('fetchCountryByID : country NOT found in local db');

      /// 2.1 read firebase country ops
      _countryModel = await ZoneOps.readCountryOps(
        context: context,
        countryID: countryID,
      );

      /// 2.2 if found on firebase, store in ldb sessionCountries
      if (_countryModel != null){
        blog('fetchCountryByID : country found in firestore db');

        await LDBOps.insertMap(
          input: _countryModel.toMap(toJSON: true),
          docName: LDBDoc.countries,
          primaryKey: 'id',
        );

      }

    }

    return _countryModel;
  }
// -------------------------------------
  Future<List<CountryModel>> fetchCountriesByIDs({
    @required BuildContext context,
    @required List<String> countriesIDs,
  }) async {

    final List<CountryModel> _countries = <CountryModel>[];

    if (Mapper.canLoopList(countriesIDs)){

      for (final String id in countriesIDs){

        final CountryModel _country = await fetchCountryByID(
            context: context,
            countryID: id,
        );

        _countries.add(_country);

      }

    }

    return _countries;
  }
// -------------------------------------
  Future<CityModel> fetchCityByID({
    @required BuildContext context,
    @required String cityID,
  }) async {
    /// 1 - search in entire LDBs for this CityModel
    /// 2 - if not found, search firebase
    ///   2.1 read firebase country ops
    ///   2.2 if found on firebase, store in ldb sessionCities
    CityModel _cityModel;

    if (cityID != null && cityID != ''){

      /// 1 - search in sessionCountries in LDB for this CountryModel
      final Map<String, Object> _map = await LDBOps.searchFirstMap(
        docName: LDBDoc.cities,
        fieldToSortBy: 'cityID',
        searchField: 'cityID',
        searchValue: cityID,
      );

      if (_map != null && _map != <String, dynamic>{}){
        blog('fetchCityByID : City found in local db : ${LDBDoc.cities}');
        _cityModel = CityModel.decipherCityMap(
            map: _map,
            fromJSON: true,
        );
      }

      /// 2 - if not found, search firebase
      if (_cityModel == null){
        blog('fetchCityByID : City NOT found in local db');

        /// 2.1 read firebase country ops
        _cityModel = await ZoneOps.readCityOps(
          context: context,
          cityID: cityID,
        );

        /// 2.2 if found on firebase, store in ldb sessionCountries
        if (_cityModel != null){
          blog('fetchCityByID : city found in firestore db');

          await LDBOps.insertMap(
            input: _cityModel.toMap(toJSON: true),
            docName: LDBDoc.cities,
            primaryKey: 'cityID',
          );

        }

      }

    }

    return _cityModel;
  }
// -------------------------------------
  Future<CityModel> fetchCityByName({
    @required BuildContext context,
    @required String cityName,
    @required String lingoCode,
    String countryID,
  }) async {

    CityModel _city;

    if (TextChecker.stringIsNotEmpty(cityName) == true){

      /// A - trial 1 : search by generated cityID
      if (countryID != null){
        final String _cityIDA = CityModel.createCityID(countryID: countryID, cityEnName: cityName);
        _city = await fetchCityByID(context: context, cityID: _cityIDA);
      }

      /// B - when trial 1 fails
      if (_city == null){

        List<CityModel> _foundCities;

        /// B-1 - trial 2 search ldb
        final List<Map<String, dynamic>> _ldbCitiesMaps = await LDBOps.searchLDBDocTrigram(
          searchValue: cityName,
          docName: LDBDoc.cities,
          lingoCode: lingoCode,
        );
        /// B-2 - if found results in ldb
        if (Mapper.canLoopList(_ldbCitiesMaps)){
          _foundCities = CityModel.decipherCitiesMaps(maps: _ldbCitiesMaps, fromJSON: true);
        }

        /// C - trial 3 search firebase if no result found in LDB
        if (Mapper.canLoopList(_foundCities) == false){

          /// C-1 - trial 3 if countryID is not available
          if (countryID == null){
            _foundCities = await ZoneSearch.citiesByCityName(
              context: context,
              cityName: cityName,
              lingoCode: lingoCode,
            );
          }

          /// C-1 - trial 3 if countryID is available
          else {
            _foundCities = await ZoneSearch.citiesByCityNameAndCountryID(
              context: context,
              cityName: cityName,
              countryID: countryID,
              lingoCode: lingoCode,
            );
          }

          /// C-2 - if firebase returned results
          if (Mapper.canLoopList(_foundCities) == true){

            /// insert all cities in ldb
            for (final CityModel city in _foundCities){
              await LDBOps.insertMap(
                input: city.toMap(toJSON: true),
                docName: LDBDoc.cities,
                primaryKey: 'cityID',
              );
            }

          }

        }

        /// D - if firebase or LDB found any cities
        if (Mapper.canLoopList(_foundCities) == true){

          blog('aho fetchCityByName : _foundCities.length = ${_foundCities.length}');

          /// D-1 if only one city found
          if (_foundCities.length == 1){
            _city = _foundCities[0];
          }

          /// D-2 if multiple cities found
          else {

            final CityModel _selectedCity = await Dialogz.confirmCityDialog(
              context: context,
              cities: _foundCities,
            );

            if (_selectedCity != null){
              _city = _selectedCity;
            }

          }

        }

      }

    }

    return _city;
  }
// -------------------------------------
  Future<List<CityModel>> fetchCitiesByIDs({
    @required BuildContext context,
    @required List<String> citiesIDs,
  }) async {

    final List<CityModel> _cities = <CityModel>[];

    if (Mapper.canLoopList(citiesIDs)){

      for (final String id in citiesIDs){

        final CityModel _city = await fetchCityByID(context: context, cityID: id);

        if (_city != null){

          _cities.add(_city);

        }

      }

    }

    return _cities;
  }
// -------------------------------------
  Future<List<Continent>> fetchContinents({@required BuildContext context}) async {

    List<Continent> _continents;

    /// 1 - search in sessionCountries in LDB for this CountryModel
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.continents,
    );

    if (Mapper.canLoopList(_maps)){
      blog('fetchCountryByID : country found in local db : ${LDBDoc.continents}');
      _continents = Continent.decipherContinents(_maps[0]);
    }

    /// 2 - if not found, search firebase
    if (_continents == null){
      blog('fetchCountryByID : country NOT found in local db');

      /// 2.1 read firebase country ops
      _continents = await ZoneOps.readContinentsOps(
        context: context,
      );

      /// 2.2 if found on firebase, store in ldb sessionCountries
      if (_continents != null){
        blog('fetchCountryByID : country found in firestore db');

        await LDBOps.insertMap(
          input: Continent.cipherContinents(_continents),
          docName: LDBDoc.continents,
          primaryKey: 'name',
        );

      }

    }

    return _continents;

  }
// -------------------------------------
  Future<List<CurrencyModel>> fetchCurrencies({@required BuildContext context}) async {

    List<CurrencyModel> _currencies;

    /// 1 - search in LDB
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.currencies,
    );

    if (Mapper.canLoopList(_maps)){
      blog('fetchCurrencies : currencies found in local db : ${LDBDoc.currencies}');
      _currencies = CurrencyModel.decipherCurrencies(_maps[0]);
    }

    /// 2 - if not found, search firebase
    if (_currencies == null){
      blog('fetchCurrencies : currencies NOT found in local db');

      /// 2.1 read firebase country ops
      _currencies = await ZoneOps.readCurrencies(context,);

      /// 2.2 if found on firebase, store in ldb LDBDoc.currencies
      if (_currencies != null){
        blog('fetchCurrencies : adding currencies from firestore to LDB');

        await LDBOps.insertMap(
          input: CurrencyModel.cipherCurrencies(_currencies),
          docName: LDBDoc.currencies,
          primaryKey: 'code',
        );

      }

    }

    return _currencies;

  }
// -----------------------------------------------------------------------------

  /// CONTINENTS

// -------------------------------------
  Continent _currentContinent;
// -------------------------------------
  Continent get currentContinent{
    return _currentContinent;
  }
// -------------------------------------
  Future<void> getsetContinentByCountryID({
    @required BuildContext context,
    @required String countryID
  }) async {
    final List<Continent> _allContinents = await fetchContinents(context: context);
    final Continent _continent = Continent.getContinentFromContinentsByCountryID(continents: _allContinents, countryID: countryID);

    _setCurrentContinent(_continent);
  }
// -------------------------------------
  void _setCurrentContinent(Continent continent){
    _currentContinent = continent;
    notifyListeners();
  }
// -------------------------------------
  void clearCurrentContinent(){
    _setCurrentContinent(null);
  }
// -------------------------------------
  Future<List<CountryModel>> getContinentActivatedCountries(BuildContext context) async {

    final List<String> _countriesIDs = _currentContinent.activatedCountriesIDs;

    final List<CountryModel> _countries = await fetchCountriesByIDs(
        context: context,
        countriesIDs: _countriesIDs,
    );

    return _countries;
  }
// -----------------------------------------------------------------------------

  /// USER COUNTRY MODEL

// -------------------------------------
  CountryModel _userCountyModel;
  CityModel _userCityModel;
// -------------------------------------
  CountryModel get userCountryModel{
    return _userCountyModel;
  }
  CityModel get userCityModel{
    return _userCityModel;
  }
// -------------------------------------
  Future<void> getsetUserCountryAndCity({
    @required BuildContext context,
    @required ZoneModel zone
  }) async {

    final CountryModel _country = await fetchCountryByID(
        context: context,
        countryID: zone.countryID
    );

    final CityModel _city = await fetchCityByID(
        context: context,
        cityID: zone.cityID,
    );

    _setUserCountryAndCityModels(_country, _city);

  }
// -------------------------------------
  void _setUserCountryAndCityModels(CountryModel country, CityModel city){
    _userCountyModel = country;
    _userCityModel = city;
    notifyListeners();
  }
// -------------------------------------
  void clearUserCountryModel(){
    _setUserCountryAndCityModels(null, null);
  }
// -----------------------------------------------------------------------------

  /// CURRENT ZONE & COUNTRY MODEL

// -------------------------------------
  ZoneModel _currentZone;
  CountryModel _currentCountryModel;
  CityModel _currentCityModel;
// -------------------------------------
  ZoneModel get currentZone{return _currentZone;}
  CountryModel get currentCountry{return _currentCountryModel;}
  CityModel get currentCity{return _currentCityModel;}
// -------------------------------------
  Future<void> getsetCurrentZoneAndCountryAndCity({
    @required BuildContext context,
    @required ZoneModel zone
  }) async {

    final CountryModel _country = await fetchCountryByID(
        context: context,
        countryID: zone.countryID,
    );

    final CityModel _city = await fetchCityByID(
        context: context,
        cityID: zone.cityID,
    );

    _currentZone = zone;
    _currentCountryModel = _country;
    _currentCityModel = _city;

    await _getSetAllCurrenciesAndCurrentCurrency(context: context);

    _setCurrentZoneAndCountryModelAndCityModel(
      zone: zone,
      country: _country,
      city: _city,
    );

  }
// -------------------------------------
  void _setCurrentZoneAndCountryModelAndCityModel({
    @required ZoneModel zone,
    @required CountryModel country,
    @required CityModel city,
  }){

    _currentZone = zone;
    _currentCountryModel = country;
    _currentCityModel = city;

    notifyListeners();

  }
// -------------------------------------
  void clearCurrentZoneAndCurrentCountryAndCurrentCity(){
    _setCurrentZoneAndCountryModelAndCityModel(
        zone: null,
        country: null,
        city: null
    );
  }
// -----------------------------------------------------------------------------

  /// ZONES NAMES

// -------------------------------------
  String getCurrentCountryNameByCurrentLingo(BuildContext context) {
    final String _name = superPhrase(context, _currentCountryModel.id);
    return _name;
  }
// -------------------------------------
  String getCurrentCityName(BuildContext context){
    final String _cityName = CityModel.getCityNameWithCurrentLingoIfPossible(context, _currentCityModel);
    return _cityName;
  }
// -----------------------------------------------------------------------------
  String getCityNameWithCurrentLingoIfPossible(BuildContext context, String cityID){

    final String _nameInCurrentLanguage = superPhrase(context, cityID);

    return _nameInCurrentLanguage ?? cityID;
  }
// -----------------------------------------------------------------------------
  Future<ZoneModel> getZoneModelByGeoPoint({
    @required BuildContext context,
    @required GeoPoint geoPoint
  }) async {

    ZoneModel _zoneModel;

    if (geoPoint != null){

      final List<Placemark> _marks = await ZoneOps.getAddressFromPosition(geoPoint: geoPoint);

      blog('_getCountryData : got place marks : ${_marks.length}');

      if (Mapper.canLoopList(_marks)){

        final Placemark _mark = _marks[0];

        blog('mark is : $_mark');

        final String _countryIso = _mark.isoCountryCode;
        final String _countryID = CountryIso.getCountryIDByIso(_countryIso);

        /// try by sub admin area
        final String _subAdministrativeArea = _mark.subAdministrativeArea;
        CityModel _foundCity = await fetchCityByName(
            context: context,
            countryID: _countryID,
            cityName: _subAdministrativeArea,
            lingoCode: 'en',
        );

        /// try by admin area
        if (_foundCity == null){
          final String _administrativeArea = _mark.administrativeArea;
          _foundCity = await fetchCityByName(
              context: context,
              countryID: _countryID,
              cityName: _administrativeArea,
              lingoCode: 'en',
          );
        }

        /// try by locality
        if (_foundCity == null){
          final String _locality = _mark.locality;
          _foundCity = await fetchCityByName(
              context: context,
              countryID: _countryID,
              cityName: _locality,
              lingoCode: 'en',
          );
        }

        _zoneModel = ZoneModel(
          countryID: _countryID,
          cityID: _foundCity?.cityID,
        );

      }

    }

    return _zoneModel;
  }
// -----------------------------------------------------------------------------

  /// CURRENCY

// -------------------------------------
  CurrencyModel _currentCurrency;
  List<CurrencyModel> _allCurrencies;
// -------------------------------------
  CurrencyModel get currentCurrency{
    return _currentCurrency;
  }
  List<CurrencyModel> get allCurrencies{
    return _allCurrencies;
  }
// -------------------------------------
  Future<void> _getSetAllCurrenciesAndCurrentCurrency({
    @required BuildContext context
  }) async {

    final List<CurrencyModel> _currencies = await fetchCurrencies(context: context);

    final CurrencyModel _currencyByCountryID = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
      currencies: _currencies,
      countryID: _currentCountryModel?.id,
    );

    _allCurrencies = _currencies;
    _currentCurrency = _currencyByCountryID;

    _setAllCurrenciesAndCurrentCurrency(
      allCurrencies: _currencies,
      currentCurrency: _currencyByCountryID,
    );
  }
// -------------------------------------
  void _setAllCurrenciesAndCurrentCurrency({
    @required List<CurrencyModel> allCurrencies,
    @required CurrencyModel currentCurrency,
  }){
    _allCurrencies = allCurrencies;
    _currentCurrency = currentCurrency;
    notifyListeners();
  }
// -------------------------------------
  void clearCurrentCurrencyAndAllCurrencies(){
    _setAllCurrenciesAndCurrentCurrency(
      currentCurrency: null,
      allCurrencies: null,
    );
  }
// -----------------------------------------------------------------------------

  /// SELECTED COUNTRY CITIES

// -------------------------------------
  List<CityModel> _selectedCountryCities = <CityModel>[];
// -------------------------------------
  List<CityModel> get selectedCountryCities => <CityModel>[..._selectedCountryCities];
// -------------------------------------
  Future<void> getSetSelectedCountryCities({
    @required BuildContext context,
    @required CountryModel countryModel,
  }) async {

    final List<CityModel> _fetchedCities = await fetchCitiesByIDs(
      context: context,
      citiesIDs: countryModel?.citiesIDs,
    );

    _setSelectedCountryCities(_fetchedCities);
    clearSearchedCities();

  }

  void _setSelectedCountryCities(List<CityModel> cities){
    _selectedCountryCities = cities;
    notifyListeners();
  }
// -------------------------------------
  void clearSelectedCountryCities(){
    _setSelectedCountryCities(<CityModel>[]);
  }
// -----------------------------------------------------------------------------

  /// SELECTED CITY DISTRICTS

// -------------------------------------
  List<DistrictModel> _selectedCityDistricts = <DistrictModel>[];
// -------------------------------------
  List<DistrictModel> get selectedCityDistricts => <DistrictModel>[..._selectedCityDistricts];
// -------------------------------------
  void setSelectedCityDistricts(List<DistrictModel> districts){
    _selectedCityDistricts = districts;
    clearSearchedDistricts();
    notifyListeners();
  }
// -------------------------------------
  void clearSelectedCityDistricts(){
    setSelectedCityDistricts(<DistrictModel>[]);
  }
// -----------------------------------------------------------------------------

  /// COUNTRIES PHRASES

// -------------------------------------
  /*
  /// mixed langs phrases
   List<Phrase> _countriesPhrases = <Phrase>[];
// -------------------------------------
   List<Phrase> get countriesPhrases => _countriesPhrases;
// -------------------------------------
   */
  Future<void> getSetActiveCountriesPhrases({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
    final List<Phrase> _phrases = await _phraseProvider.generateActiveCountriesMixedLangPhrases(
        context: context
    );

    blog('fetched ${_phrases.length} countries phrases');

    //
    // _countriesPhrases = _phrases;

    // if (notify == true){
    //   notifyListeners();
    // }

  }
// -------------------------------------
  Future<List<Phrase>> searchCountriesPhrasesByName({
    @required BuildContext context,
    @required String countryName,
    @required String lingoCode
  }) async {

    List<Phrase> _phrases = <Phrase>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.searchPhrasesDoc(
      docName: LDBDoc.countriesPhrases,
      lingCode: lingoCode,
      searchValue: countryName,
    );
    if (Mapper.canLoopList(_maps) == true){
      _phrases = Phrase.decipherMixedLangPhrases(maps: _maps,);
    }

    return _phrases;
  }
// -------------------------------------

  /// SEARCHED COUNTRIES

// -------------------------------------
  List<Phrase> _searchedCountries = <Phrase>[];
// -------------------------------------
  List<Phrase> get searchedCountries => <Phrase>[..._searchedCountries];
// -------------------------------------
  Future<void> getSetSearchedCountries({
    @required BuildContext context,
    @required String input,
  }) async {

    /// SEARCH COUNTRIES MODELS FROM FIREBASE
    // final List<CountryModel> _foundCountries = await ZoneSearch.countriesModelsByCountryName(
    //     context: context,
    //     countryName: input,
    //     lingoCode: TextChecker.concludeEnglishOrArabicLingo(input),
    // );

    /// SEARCH COUNTRIES FROM LOCAL PHRASES
    final List<Phrase> _foundCountries = await searchCountriesPhrasesByName(
      context: context,
      lingoCode: TextChecker.concludeEnglishOrArabicLang(input),
      countryName: input,
    );

    /// INSERT FOUND COUNTRIES TO LDB
    // if (_foundCountries.isNotEmpty){
    //   for (final CountryModel country in _foundCountries){
    //     await LDBOps.insertMap(
    //       input: country.toMap(toJSON: true),
    //       docName: LDBDoc.countries,
    //       primaryKey: 'id',
    //     );
    //   }
    // }

    /// SET FOUND COUNTRIES
    _setSearchedCountries(_foundCountries);
  }
// -------------------------------------
  void _setSearchedCountries(List<Phrase> countriesPhrases){
    _searchedCountries = countriesPhrases;
    notifyListeners();
  }
// -------------------------------------
  void clearSearchedCountries(){
    _setSearchedCountries(<Phrase>[]);
  }
// -----------------------------------------------------------------------------

  /// SEARCHED CITIES

// -------------------------------------
  List<CityModel> _searchedCities = <CityModel>[];
// -------------------------------------
  List<CityModel> get searchedCities => <CityModel>[..._searchedCities];
// -------------------------------------
  Future<void> getSetSearchedCities({
    @required BuildContext context,
    @required String input,
  }) async {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final List<CityModel> _selectedCountryCities = _zoneProvider.selectedCountryCities;

    /// SEARCH SELECTED COUNTRY CITIES
    final List<CityModel> _foundCities = CityModel.searchCitiesByName(
      context: context,
      sourceCities: _selectedCountryCities,
      inputText: input,
    );

    blog('getSetSearchedCities : '
        '_selectedCountryCities.length : '
        '${_selectedCountryCities.length} : '
        'input : $input : '
        '_foundCities : '
        '${_foundCities?.length}'
    );


    /// SET FOUND CITIES
    _setSearchedCities(_foundCities);

  }
  // -------------------------------------
  void _setSearchedCities(List<CityModel> cities){
    _searchedCities = cities;
    notifyListeners();
  }
  // -------------------------------------
  void clearSearchedCities(){
    _setSearchedCities(<CityModel>[]);
  }
// -----------------------------------------------------------------------------

  /// SEARCHED DISTRICTS

// -------------------------------------
  List<DistrictModel> _searchedDistricts = <DistrictModel>[];
// -------------------------------------
  List<DistrictModel> get searchedDistricts => <DistrictModel>[..._searchedDistricts];
// -------------------------------------
  void getSetSearchedDistricts({
    @required BuildContext context,
    @required String textInput,
  }){

    /// SEARCH SELECTED CITY DISTRICTS
    final List<DistrictModel> _foundDistricts = DistrictModel.searchDistrictsByCurrentLingoName(
      context: context,
      sourceDistricts: _selectedCityDistricts,
      inputText: textInput,
    );

    // blog('getSetSearchedCities : _selectedCountryCities.length : ${_selectedCountryCities.length} : input : $input : _foundCities : ${_foundCities.length}' );
    // blog('${_foundCities[0]}');

    /// SET FOUND CITIES
    _setSearchedDistricts(_foundDistricts);

  }
// -------------------------------------
  void _setSearchedDistricts(List<DistrictModel> districts){
    _searchedDistricts = districts;
    notifyListeners();
  }
// -------------------------------------
  void clearSearchedDistricts(){
    _setSearchedDistricts(<DistrictModel>[]);
  }
// -----------------------------------------------------------------------------
  void clearAllSearchesAndSelections(){

    _searchedCountries = [];
    _searchedCities = [];

    _selectedCountryCities = [];
    _selectedCityDistricts = [];

    notifyListeners();
  }
// -----------------------------------------------------------------------------

  /// PRO GETTERS

// -------------------------------------
  static Future<ZoneModel> proGetCompleteZoneModel({
    @required BuildContext context,
    @required ZoneModel incompleteZoneModel,
  }) async {
    /// incomplete zone model is what only has (countryID - cityID - districtID)
    /// complete zone model is that has all IDs  Models and Names initialized

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    final CountryModel _country = await _zoneProvider.fetchCountryByID(
        context: context,
        countryID: incompleteZoneModel.countryID,
    );
    final String _countryName = CountryModel.getTranslatedCountryName(
      context: context,
      countryID: incompleteZoneModel.countryID,
    );

    final CityModel _city = await _zoneProvider.fetchCityByID(
      context: context,
      cityID: incompleteZoneModel.cityID,
    );
    final String _cityName = CityModel.getTranslatedCityNameFromCity(
      context: context,
      city: _city,
    );

    final String _districtName = DistrictModel.getTranslatedDistrictNameFromCity(
      context: context,
      city: _city,
      districtID: incompleteZoneModel.districtID,
    );

    final ZoneModel _zone = ZoneModel(
      countryID: incompleteZoneModel.countryID,
      cityID: incompleteZoneModel.cityID,
      districtID: incompleteZoneModel.districtID,
      countryName: _countryName,
      cityName: _cityName,
      districtName: _districtName,
      countryModel: _country,
      cityModel: _city,
    );


    return _zone;
  }
// -------------------------------------

}
/// TASK : ACTIVATED & GLOBAL COUNTRIES

// List<ZoneModel> searchCountriesByNames({
//   @required String text,
// }){
//
//   // final List<String> _allCountriesIDs = CountryModel.getAllCountriesIDs();
//   //
//   // final List<Phrase> _enCountryPhrase = CountryModel.createCountriesPhrases(
//   //   langCode: 'en',
//   // );
//
// }
