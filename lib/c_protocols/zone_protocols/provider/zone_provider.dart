import 'package:bldrs/a_models/d_zone/x_planet/continent_model.dart';
import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
class ZoneProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// CONTINENTS

  // --------------------
  Continent _currentContinent;
  Continent get currentContinent => _currentContinent;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> fetchSetContinentByCountryID({
    @required String countryID,
    @required bool notify,
  }) async {

    final List<Continent> _allContinents = await ZoneProtocols.readAllContinents();

    final Continent _continent = Continent.getContinentFromContinentsByCountryID(
      continents: _allContinents,
      countryID: countryID,
    );

    _setCurrentContinent(
      continent: _continent,
      notify: notify,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setCurrentContinent({
    @required Continent continent,
    @required bool notify,
  }){
    _currentContinent = continent;
    if (notify == true){
      notifyListeners();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void clearCurrentContinent({
    @required bool notify,
  }){
    _setCurrentContinent(
      continent: null,
      notify: notify,
    );
  }
  // --------------------
  /// DEPRECATED
  /*
  Future<List<CountryModel>> fetchContinentActivatedCountriesXS() async {

    final List<String> _countriesIDs = _currentContinent.activatedCountriesIDs;

    final List<CountryModel> _countries = await ZoneProtocols.fetchCountries(
      countriesIDs: _countriesIDs,
    );

    return _countries;
  }
   */
  // -----------------------------------------------------------------------------

  /// CURRENT ZONE

  // --------------------
  ZoneModel _currentZone;
  ZoneModel get currentZone => _currentZone;
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZoneModel proGetCurrentZone({
    @required BuildContext context,
    @required bool listen,
  }){
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: listen);
    return _zoneProvider.currentZone;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZoneModel proGetCurrentZoneIDs({
    @required BuildContext context,
    @required bool listen,
  }){
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: listen);
    return _zoneProvider.currentZone;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> fetchSetCurrentCompleteZone({
    @required BuildContext context,
    @required ZoneModel zone,
    @required bool notify,
  }) async {

    final ZoneModel _completeZone = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: zone,
    );

    await Future.wait(<Future>[

      /// CURRENCIES
      _fetchSetAllCurrenciesAndCurrentCurrency(
        countryID: zone.countryID,
        notify: false,
      ),

      /// CONTINENTS
      fetchSetContinentByCountryID(
        countryID: zone.countryID,
        notify: false,
      ),

    ]);

    setCurrentZone(
      zone: _completeZone,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void setCurrentZone({
    @required ZoneModel zone,
    @required bool notify,
  }){

    blog('setCurrentZone START : zone = $zone');

    zone?.blogZone(invoker: 'setCurrentZone');

    _currentZone = zone;
    if (notify == true){
      notifyListeners();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void clearCurrentZone({
    @required bool notify,
  }){
    setCurrentZone(
      zone: null,
      notify: notify,
    );
  }
  // -----------------------------------------------------------------------------

  /// CURRENCY

  // --------------------
  List<CurrencyModel> _allCurrencies = <CurrencyModel>[];
  List<CurrencyModel> get allCurrencies => _allCurrencies;
  // --------------------
  CurrencyModel _currentCurrency;
  CurrencyModel get currentCurrency => _currentCurrency;
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CurrencyModel> proGetAllCurrencies({
    @required BuildContext context,
    @required bool listen,
  }){
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: listen);
    return _zoneProvider.allCurrencies;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CurrencyModel proGetCurrencyByCountryID({
    @required BuildContext context,
    @required String countryID,
    @required bool listen,
  }){

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: listen);

    final CurrencyModel _currency = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
        currencies: _zoneProvider.allCurrencies,
        countryID: countryID
    );

    return _currency;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CurrencyModel proGetCurrencyByCurrencyID({
    @required BuildContext context,
    @required String currencyID,
    @required bool listen,
  }){

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: listen);

    final CurrencyModel _currency = CurrencyModel.getCurrencyByID(
      allCurrencies: _zoneProvider.allCurrencies,
      currencyID: currencyID,
    );

    return _currency;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _fetchSetAllCurrenciesAndCurrentCurrency({
    @required String countryID,
    @required bool notify,
  }) async {

    // blog('_fetchSetAllCurrenciesAndCurrentCurrency : START');

    final List<CurrencyModel> _currencies = await ZoneProtocols.fetchCurrencies();

    final CurrencyModel _currencyByCountryID = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
      currencies: _currencies,
      countryID: countryID,
    );

    _allCurrencies = _currencies;
    _currentCurrency = _currencyByCountryID;

    _setAllCurrenciesAndCurrentCurrency(
      allCurrencies: _currencies,
      currentCurrency: _currencyByCountryID,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void getSetCurrentCurrency({
    @required ZoneModel zone,
    @required bool notify,
  }){

    if (zone != null && zone.countryID != null){

      final CurrencyModel _currencyByCountryID = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
        currencies: _allCurrencies,
        countryID: _currentZone?.countryID,
      );

      if (_currencyByCountryID != null){
        _currentCurrency = _currencyByCountryID;
      }

      if (notify == true){
        notifyListeners();
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
  void clearCurrentCurrencyAndAllCurrencies({
    @required bool notify,
  }){
    _setAllCurrenciesAndCurrentCurrency(
      currentCurrency: null,
      allCurrencies: null,
      notify: notify,
    );
  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
/// TASK : ACTIVATED & GLOBAL COUNTRIES
  // --------------------
/// ZONES NAMES
  // --------------------
/*
//   String translateCurrentCountryNameByCurrentLingo(BuildContext context) {
//     final String _name = superPhrase(context, _currentCountryModel.id);
//     return _name;
//   }
  // --------------------
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
  // --------------------
