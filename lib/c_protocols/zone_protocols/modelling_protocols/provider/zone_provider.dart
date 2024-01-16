import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
class ZoneProvider extends ChangeNotifier {
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

    return  _zoneProvider.currentZone
            ??
            UsersProvider.proGetMyUserModel(
              context: getMainContext(),
              listen: false,
            )?.zone
            ??
            ZoneModel.planetZone;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? proGetCurrentCountryID({
    required BuildContext context,
    required bool listen,
  }){

    final ZoneModel? _currentZone = proGetCurrentZone(
        context: context,
        listen: listen,
    );

    return _currentZone?.countryID;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proSetCurrentZone({
    required ZoneModel? zone,
  }) async {

    final BuildContext context = getMainContext();
    final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    /// SET ZONE + CURRENCY
    await zoneProvider._setCurrentZone(
      zone: zone,
      setCountryOnly: false,
      notify: true,
      invoker: 'ZoneSelection.setCurrentZoneProtocol',
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _setCurrentZone({
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
    /// NOTIFY
    if (notify == true){
      notifyListeners();
    }

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

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  void _wipeOut({
    required bool notify,
  }){

    _currentZone = ZoneModel.planetZone;
    _isViewingPlanet = true;

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
