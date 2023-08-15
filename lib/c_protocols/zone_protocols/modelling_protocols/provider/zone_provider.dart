import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/x_money/currency_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
class ZoneProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// INITIALIZATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> setCurrentZone({
    required ZoneModel? zone,
    required bool setCountryOnly,
    required bool notify,
    required String invoker,
  }) async {

    ZoneModel? _completeZone = await ZoneProtocols.completeZoneModel(
      incompleteZoneModel: zone,
    );

    _completeZone ??= ZoneModel.planetZone;

    _completeZone.blogZone(invoker: 'this shit has become : $invoker');

    _setZone(
      zone: _completeZone,
      setCountryOnly: setCountryOnly,
      notify: notify,
      invoker: invoker,
    );

    /// CURRENCIES
    await _fetchSetCountryCurrency(
      countryID: _completeZone.countryID,
      notify: false,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _fetchSetCountryCurrency({
    required String? countryID,
    required bool notify,
  }) async {

    List<CurrencyModel> _currencies;
    if (Mapper.checkCanLoopList(_allCurrencies) == true){
      _currencies = _allCurrencies!;
    }
    else {
      _currencies = await ZoneProtocols.fetchCurrencies();
    }


    final CurrencyModel? _currencyByCountryID = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
      currencies: _currencies,
      countryID: countryID,
    );

    _allCurrencies = _currencies;
    _currentCurrency = _currencyByCountryID;

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// CURRENT ZONE

  // --------------------
  ZoneModel? _currentZone;
  ZoneModel? get currentZone => _currentZone;
  bool _isViewingPlanet = false;
  bool get isViewingPlanet => _currentZone == null ? true : _isViewingPlanet;
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZoneModel proGetCurrentZone({
    required BuildContext context,
    required bool listen,
  }){
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: listen);
    return
      _zoneProvider.currentZone ??
          UsersProvider.proGetMyUserModel(
            context: getMainContext(),
            listen: false,
          )?.zone ??
    ZoneModel.planetZone;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setZone({
    required ZoneModel zone,
    required bool setCountryOnly,
    required bool notify,
    required String invoker,
  }){

    if (setCountryOnly == true){
      _currentZone = zone.nullifyField(
        cityID: true,
        cityName: true,
        cityModel: true,
      );
    }
    else {
      _currentZone = zone;
    }

    if (_currentZone == ZoneModel.planetZone){
      _isViewingPlanet = true;
    }
    else {
      _isViewingPlanet = false;
    }

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// CURRENCY

  // --------------------
  /// TASK: REMOVE_ALL_CURRENCIES
  /// REMOVE ALL CURRENCIES FOR MEMORY OPTIMIZATION AND LET IT BE FETCHED FROM JSON INSTEAD WHEN
  /// NEEDED
  List<CurrencyModel>? _allCurrencies = <CurrencyModel>[];
  List<CurrencyModel>? get allCurrencies => _allCurrencies;
  // --------------------
  CurrencyModel? _currentCurrency;
  CurrencyModel? get currentCurrency => _currentCurrency;
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CurrencyModel> proGetAllCurrencies({
    required BuildContext context,
    required bool listen,
  }){
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: listen);
    return _zoneProvider.allCurrencies ?? [];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CurrencyModel? proGetCurrencyByCountryID({
    required BuildContext context,
    required String? countryID,
    required bool listen,
  }){

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: listen);

    final CurrencyModel? _currency = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
        currencies: _zoneProvider.allCurrencies,
        countryID: countryID,
    );

    return _currency;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CurrencyModel? proGetCurrencyByCurrencyID({
    required BuildContext context,
    required String? currencyID,
    required bool listen,
  }){
    CurrencyModel? _currency;

    if (currencyID != null) {

      final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: listen);

      _currency = CurrencyModel.getCurrencyByID(
        allCurrencies: _zoneProvider.allCurrencies,
        currencyID: currencyID,
      );

    }

    return _currency;
  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  void _wipeOut({
    required bool notify,
  }){

    _currentZone = ZoneModel.planetZone;
    _isViewingPlanet = true;
    // _allCurrencies = [];
    _currentCurrency = null;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void wipeOut({
    required bool notify,
  }){

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(getMainContext(), listen: false);
    _zoneProvider._wipeOut(
      notify: notify,
    );

  }
  // -----------------------------------------------------------------------------
}
