import 'package:basics/helpers/models/flag_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
class ZoneProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------
// technique
  /// INITIALIZATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proInitializeAllCurrencies() async {
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(getMainContext(), listen: false);
    await _zoneProvider._initializeAllCurrencies(
      notify: true,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _initializeAllCurrencies({
    required bool notify,
  }) async {
    final List<CurrencyModel> _currencies = await ZoneProtocols.fetchCurrencies();
    _allCurrencies = _currencies;
    if (notify == true){
      notifyListeners();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> setCurrentZone({
    required ZoneModel? zone,
    required bool setCountryOnly,
    required bool notify,
    required String invoker,
  }) async {

    /// DEFINE ZONE
    ZoneModel? _completeZone = await ZoneProtocols.completeZoneModel(
      invoker: 'setCurrentZone : $invoker',
      incompleteZoneModel: zone,
    );
    _completeZone ??= ZoneModel.planetZone;
    /// SET ZONE
    _setZone(
      zone: _completeZone,
      setCountryOnly: setCountryOnly,
      notify: false,
      invoker: invoker,
    );
    /// ZONE CURRENCY
    final CurrencyModel? _currencyByCountryID = proGetCurrencyByCountryID(
      listen: false,
      context: getMainContext(),
      countryID: _completeZone.countryID,
    );
    _currentCurrency = _currencyByCountryID;
    /// NOTIFY
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
  static Future<void> proSetCurrentZone({
    required ZoneModel? zone,
  }) async {

    final BuildContext context = getMainContext();
    final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    /// SET ZONE + CURRENCY
    await zoneProvider.setCurrentZone(
      zone: zone,
      setCountryOnly: false,
      notify: true,
      invoker: 'ZoneSelection.setCurrentZoneProtocol',
    );

    // /// SET CHAINS
    // final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    // await _chainsProvider.changeHomeWallFlyerType(
    //   notify: true,
    //   flyerType: null,
    //   phid: null,
    // );
    // await _chainsProvider.reInitializeZoneChains();

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

    final String _countryID = countryID == Flag.planetID ? 'usa'
        :
    America.checkCountryIDIsStateID(countryID) == true ? 'usa'
        :
    countryID ?? 'usa';

    final CurrencyModel? _currency = CurrencyModel.getCurrencyFromCurrenciesByCountryID(
        currencies: _zoneProvider.allCurrencies,
        countryID: _countryID,
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
