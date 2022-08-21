import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/continent_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/currency_model.dart';
import 'package:bldrs/a_models/zone/flag_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/e_db/fire/ops/zone_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/zone_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

// final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
class ZoneProvider extends ChangeNotifier {
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

    final List<Continent> _allContinents = await ZoneProtocols.fetchContinents(context: context);
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

    final List<CountryModel> _countries = await ZoneProtocols.fetchCountries(
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

    final ZoneModel _completeZone = await ZoneProtocols.completeZoneModel(
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
  /*
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
   */
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
        CityModel _foundCity = await ZoneProtocols.fetchCityByName(
            context: context,
            countryID: _countryID,
            cityName: _subAdministrativeArea,
            langCode: 'en',
        );

        /// try by admin area
        if (_foundCity == null){
          final String _administrativeArea = _mark.administrativeArea;
          _foundCity = await ZoneProtocols.fetchCityByName(
              context: context,
              countryID: _countryID,
              cityName: _administrativeArea,
              langCode: 'en',
          );
        }

        /// try by locality
        if (_foundCity == null){
          final String _locality = _mark.locality;
          _foundCity = await ZoneProtocols.fetchCityByName(
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
  static ZoneModel proGetCurrentZoneIDs(BuildContext context){
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    return _zoneProvider.currentZone;
  }
// -------------------------------------
  /*
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
   */
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
