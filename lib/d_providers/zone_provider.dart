import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart' as Dialogz;
import 'package:bldrs/e_db/fire/ops/zone_ops.dart' as ZoneFireOps;
import 'package:bldrs/e_db/fire/search/zone_search.dart' as ZoneFireSearch;
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart' as LDBOps;
import 'package:bldrs/e_db/ldb/ops/zone_ldb_ops.dart';
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

    CountryModel _countryModel = await ZoneLDBOps.readCountry(countryID);

    if (_countryModel != null){
      blog('fetchCountryByID : ($countryID) CountryModel FOUND in LDB');
    }

    else {

      _countryModel = await ZoneFireOps.readCountryOps(
        context: context,
        countryID: countryID,
      );

      if (_countryModel != null){
        blog('fetchCountryByID : ($countryID) CountryModel FOUND in FIRESTORE and inserted in LDB');

        await ZoneLDBOps.insertCountry(_countryModel);

      }

    }

    if (_countryModel == null){
      blog('fetchCountryByID : ($countryID) CountryModel NOT FOUND');
    }

    return _countryModel;
  }
// -------------------------------------
  Future<List<CountryModel>> fetchCountriesByIDs({
    @required BuildContext context,
    @required List<String> countriesIDs,
  }) async {

    final List<CountryModel> _countries = <CountryModel>[];

    if (Mapper.checkCanLoopList(countriesIDs)){

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

    CityModel _cityModel = await ZoneLDBOps.readCity(cityID);

    if (_cityModel != null){
      blog('fetchCityByID : ($cityID) CityModel FOUND in LDB');
    }

    else {

      _cityModel = await ZoneFireOps.readCityOps(
        context: context,
        cityID: cityID,
      );

      if (_cityModel != null){
        blog('fetchCityByID : ($cityID) CityModel FOUND in FIRESTORE and inserted in LDB');

        await ZoneLDBOps.insertCity(_cityModel);

      }

    }

    if (_cityModel == null){
      blog('fetchCityByID : ($cityID) CityModel NOT FOUND');
    }

    return _cityModel;
  }
// -------------------------------------
  Future<CityModel> fetchCityByName({
    @required BuildContext context,
    @required String cityName,
    @required String langCode,
    String countryID,
  }) async {

    CityModel _city;

    if (TextChecker.stringIsNotEmpty(cityName) == true){

      /// A - trial 1 : search by generated cityID
      if (countryID != null){

        final String _cityID = CityModel.createCityID(
            countryID: countryID,
            cityEnName: cityName,
        );

        _city = await fetchCityByID(
            context: context,
            cityID: _cityID,
        );

      }

      /// B - when trial 1 fails
      if (_city == null){

        List<CityModel> _foundCities = await ZoneLDBOps.searchCitiesByName(
            cityName: cityName,
            langCode: langCode,
        );

        /// C - trial 3 search firebase if no result found in LDB
        if (Mapper.checkCanLoopList(_foundCities) == false){

          /// C-1 - trial 3 if countryID is not available
          if (countryID == null){
            _foundCities = await ZoneFireSearch.citiesByCityName(
              context: context,
              cityName: cityName,
              lingoCode: langCode,
            );
          }

          /// C-1 - trial 3 if countryID is available
          else {
            _foundCities = await ZoneFireSearch.citiesByCityNameAndCountryID(
              context: context,
              cityName: cityName,
              countryID: countryID,
              lingoCode: langCode,
            );
          }

          /// C-2 - if firebase returned results
          if (Mapper.checkCanLoopList(_foundCities) == true){

            /// insert all cities in ldb
            for (final CityModel city in _foundCities){
              await LDBOps.insertMap(
                input: city.toMap(toJSON: true),
                docName: LDBDoc.cities,
              );
            }

          }

        }

        /// D - if firebase or LDB found any cities
        if (Mapper.checkCanLoopList(_foundCities) == true){

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
    ValueChanged<CityModel> onCityLoaded,
  }) async {

    final List<CityModel> _cities = <CityModel>[];

    if (Mapper.checkCanLoopList(citiesIDs)){

      for (final String id in citiesIDs){

        final CityModel _city = await fetchCityByID(context: context, cityID: id);

        if (_city != null){

          _cities.add(_city);

          if (onCityLoaded != null){
            onCityLoaded(_city);
          }

        }

      }

    }

    return _cities;
  }
// -------------------------------------
  Future<List<Continent>> fetchContinents({
    @required BuildContext context,
  }) async {

    List<Continent> _continents = await ZoneLDBOps.readContinents();

    if (Mapper.checkCanLoopList(_continents) == true){
      blog('fetchContinents : All Continents FOUND in LDB');
    }

    else {

      _continents = await ZoneFireOps.readContinentsOps(
        context: context,
      );

      if (_continents != null){
        blog('fetchContinents : All Continents FOUND in FIREBASE and inserted in LDB');

        await ZoneLDBOps.insertContinents(_continents);

      }

    }

    if (_continents == null){
      blog('fetchContinents : All Continents NOT FOUND');
    }

    return _continents;

  }
// -------------------------------------
  Future<List<CurrencyModel>> fetchCurrencies({
    @required BuildContext context,
  }) async {

    List<CurrencyModel> _currencies = await ZoneLDBOps.readCurrencies();

    if (Mapper.checkCanLoopList(_currencies) == true){
      blog('fetchCurrencies : All CurrencyModels FOUND in LDB');
    }

    else {

      _currencies = await ZoneFireOps.readCurrencies(context);

      if (Mapper.checkCanLoopList(_currencies) == true){
        blog('fetchCurrencies : All CurrencyModels FOUND in FIREBASE and inserted in LDB');
        await ZoneLDBOps.insertCurrencies(_currencies);
      }

    }

    if (Mapper.checkCanLoopList(_currencies) == false){
      blog('fetchCurrencies : currencies NOT FOUND');
    }

    return _currencies;

  }
// -------------------------------------
  Future<ZoneModel> fetchCompleteZoneModel({
    @required BuildContext context,
    @required ZoneModel incompleteZoneModel,
  }) async {

    /// incomplete zone model is what only has (countryID - cityID - districtID)
    /// complete zone model is that has all IDs  Models and Names initialized

    ZoneModel _output = incompleteZoneModel;

    if (incompleteZoneModel != null){

      final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

      /// BZ COUNTRY
      if (incompleteZoneModel.countryModel == null){
        final CountryModel _bzCountry = await _zoneProvider.fetchCountryByID(
          context: context,
          countryID: incompleteZoneModel.countryID,
        );
        _output = _output.copyWith(
          countryModel: _bzCountry,
        );
      }

      /// BZ CITY
      if (incompleteZoneModel.cityModel == null){
        final CityModel _bzCity = await _zoneProvider.fetchCityByID(
          context: context,
          cityID: incompleteZoneModel.cityID,
        );
        _output = _output.copyWith(
          cityModel: _bzCity,
        );

      }

      /// COUNTRY NAME
      if (incompleteZoneModel.countryName == null || incompleteZoneModel.countryName == '...'){

        // superPhrase(context, _zone.countryID);
        final String _countryName = CountryModel.getTranslatedCountryName(
          context: context,
          countryID: incompleteZoneModel.countryID,
        );
        _output = _output.copyWith(
          countryName: _countryName,
        );
      }

      /// CITY NAME
      if (incompleteZoneModel.cityName == null || incompleteZoneModel.cityName == '...'){

        // superPhrase(context, _zone.cityID);
        final String _cityName = CityModel.getTranslatedCityNameFromCity(
          context: context,
          city: _output.cityModel,
        );
        _output = _output.copyWith(
          cityName: _cityName,
        );
      }

      /// DISTRICT NAME
      if (incompleteZoneModel.districtName == null || incompleteZoneModel.districtName == '...'){
        final String _districtName = DistrictModel.getTranslatedDistrictNameFromCity(
          context: context,
          city: _output.cityModel,
          districtID: incompleteZoneModel.districtID,
        );
        _output = _output.copyWith(
          districtName: _districtName,
        );
      }

    }

    return _output;
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
  Future<void> fetchSetContinentByCountryID({
    @required BuildContext context,
    @required String countryID,
    @required bool notify,
  }) async {

    final List<Continent> _allContinents = await fetchContinents(context: context);
    final Continent _continent = Continent.getContinentFromContinentsByCountryID(
        continents: _allContinents,
        countryID: countryID,
    );

    _setCurrentContinent(
      continent: _continent,
      notify: notify,
    );
  }
// -------------------------------------
  void _setCurrentContinent({
    @required Continent continent,
    @required bool notify,
  }){
    _currentContinent = continent;
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  void clearCurrentContinent({
  @required bool notify,
}){
    _setCurrentContinent(
      continent: null,
      notify: notify,
    );
  }
// -------------------------------------
  Future<List<CountryModel>> fetchContinentActivatedCountries(BuildContext context) async {

    final List<String> _countriesIDs = _currentContinent.activatedCountriesIDs;

    final List<CountryModel> _countries = await fetchCountriesByIDs(
        context: context,
        countriesIDs: _countriesIDs,
    );

    return _countries;
  }
// -----------------------------------------------------------------------------

  /// CURRENT ZONE & COUNTRY MODEL

// -------------------------------------
  ZoneModel _currentZone;
  ZoneModel get currentZone => _currentZone;
// -------------------------------------
  static ZoneModel proGetCurrentZone({
    @required BuildContext context,
    @required bool listen,
  }){
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: listen);
    return _zoneProvider.currentZone;
  }
// -------------------------------------
  Future<void> fetchSetCurrentCompleteZone({
    @required BuildContext context,
    @required ZoneModel zone,
    @required bool notify,
  }) async {

    final ZoneModel _completeZone = await fetchCompleteZoneModel(
        context: context,
        incompleteZoneModel: zone,
    );

    await _fetchSetAllCurrenciesAndCurrentCurrency(
      context: context,
      notify: false,
    );

    await fetchSetContinentByCountryID(
      context: context,
      countryID: zone.countryID,
      notify: false,
    );

    setCurrentZone(
      zone: _completeZone,
      notify: notify,
    );

  }
// -------------------------------------
  void setCurrentZone({
    @required ZoneModel zone,
    @required bool notify,
  }){
    _currentZone = zone;
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  void clearCurrentZone({
  @required bool notify,
}){
    setCurrentZone(
      zone: null,
      notify: notify,
    );
  }
// -----------------------------------------------------------------------------

  /// ZONES NAMES

// -------------------------------------
//   String translateCurrentCountryNameByCurrentLingo(BuildContext context) {
//     final String _name = superPhrase(context, _currentCountryModel.id);
//     return _name;
//   }
// -------------------------------------
//   String translateCurrentCityName(BuildContext context){
//     final String _cityName = CityModel.translateCityNameWithCurrentLingoIfPossible(context, _currentCityModel);
//     return _cityName;
//   }
// -----------------------------------------------------------------------------
//   String translateCityNameWithCurrentLingoIfPossible(BuildContext context, String cityID){
//
//     final String _nameInCurrentLanguage = superPhrase(context, cityID);
//
//     return _nameInCurrentLanguage ?? cityID;
//   }
// -----------------------------------------------------------------------------
  Future<ZoneModel> fetchZoneModelByGeoPoint({
    @required BuildContext context,
    @required GeoPoint geoPoint
  }) async {

    ZoneModel _zoneModel;

    if (geoPoint != null){

      final List<Placemark> _marks = await ZoneFireOps.getAddressFromPosition(geoPoint: geoPoint);

      blog('_getCountryData : got place marks : ${_marks.length}');

      if (Mapper.checkCanLoopList(_marks)){

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
            langCode: 'en',
        );

        /// try by admin area
        if (_foundCity == null){
          final String _administrativeArea = _mark.administrativeArea;
          _foundCity = await fetchCityByName(
              context: context,
              countryID: _countryID,
              cityName: _administrativeArea,
              langCode: 'en',
          );
        }

        /// try by locality
        if (_foundCity == null){
          final String _locality = _mark.locality;
          _foundCity = await fetchCityByName(
              context: context,
              countryID: _countryID,
              cityName: _locality,
              langCode: 'en',
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
  Future<void> _fetchSetAllCurrenciesAndCurrentCurrency({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final List<CurrencyModel> _currencies = await fetchCurrencies(context: context);

    final CurrencyModel _currencyByCountryID = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
      currencies: _currencies,
      countryID: _currentZone?.countryID,
    );

    _allCurrencies = _currencies;
    _currentCurrency = _currencyByCountryID;

    _setAllCurrenciesAndCurrentCurrency(
      allCurrencies: _currencies,
      currentCurrency: _currencyByCountryID,
      notify: notify,
    );

  }
// -------------------------------------
  void _setAllCurrenciesAndCurrentCurrency({
    @required List<CurrencyModel> allCurrencies,
    @required CurrencyModel currentCurrency,
    @required bool notify,
  }){
    _allCurrencies = allCurrencies;
    _currentCurrency = currentCurrency;
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  void clearCurrentCurrencyAndAllCurrencies({
  @required bool notify,
}){
    _setAllCurrenciesAndCurrentCurrency(
      currentCurrency: null,
      allCurrencies: null,
      notify: notify,
    );
  }
// -------------------------------------
  static List<CurrencyModel> proGetAllCurrencies(BuildContext context){
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    return _zoneProvider.allCurrencies;
  }
// -----------------------------------------------------------------------------

  /// PRO GETTERS

// -------------------------------------
  static Future<ZoneModel> proFetchCompleteZoneModel({
    @required BuildContext context,
    @required ZoneModel incompleteZoneModel,
  }) async {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    final ZoneModel _output = await _zoneProvider.fetchCompleteZoneModel(
        context: context,
        incompleteZoneModel: incompleteZoneModel,
    );

    return _output;
  }
// -------------------------------------
  static ZoneModel proGetCurrentZoneIDs(BuildContext context){
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    return _zoneProvider.currentZone;
  }
// -------------------------------------
  static Future<CountryModel> proFetchCountry({
    @required BuildContext context,
    @required String countryID,
}) async {
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final CountryModel _country = await _zoneProvider.fetchCountryByID(
        context: context,
        countryID: countryID,
    );
    return _country;
  }
// -----------------------------------------------------------------------------

  /// WIPE OUT

// -------------------------------------
  static void wipeOut({
    @required BuildContext context,
    @required bool notify,
  }){

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    /// _currentContinent
    _zoneProvider.clearCurrentContinent(notify: false);

    /// _currentZone
    _zoneProvider.clearCurrentZone(
      notify: false,
    );

    /// _allCurrencies - currentCurrency
    _zoneProvider._setAllCurrenciesAndCurrentCurrency(
      allCurrencies: <CurrencyModel>[],
      currentCurrency: null,
      notify: false,
    );


  }
// -----------------------------------------------------------------------------
}
/// TASK : ACTIVATED & GLOBAL COUNTRIES
