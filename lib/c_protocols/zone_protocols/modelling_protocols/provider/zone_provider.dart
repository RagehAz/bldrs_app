import 'package:bldrs/a_models/c_keywords/zone_phids_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_phids_protocols/zone_phids_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
class ZoneProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> proSetCurrentZone({
    required ZoneModel? zone,
  }) async {

    final BuildContext context = getMainContext();
    final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    /// ZONE PHIDS
    await zoneProvider._fetchSetZonePhidsModel(
        zone: zone,
        notify: false,
    );

    /// SET ZONE + CURRENCY
    await zoneProvider._setCurrentZone(
      zone: zone,
      notify: true,
      invoker: 'ZoneSelection.setCurrentZoneProtocol',
    );

  }
  // -----------------------------------------------------------------------------

  /// CURRENT ZONE

  // --------------------
  ZoneModel? _currentZone;
  ZoneModel? get currentZone => _currentZone;
  bool get isViewingPlanet {

    if (_currentZone == null || _currentZone == ZoneModel.planetZone){
      return true;
    }
    else {
      return false;
    }

  }
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
  Future<void> _setCurrentZone({
    required ZoneModel? zone,
    required bool notify,
    required String invoker,
  }) async {

    final ZoneModel? _completeZone = await ZoneProtocols.completeZoneModel(
      invoker: 'setCurrentZone : $invoker',
      incompleteZoneModel: zone,
    );

    _currentZone = _completeZone ?? ZoneModel.planetZone;

    /// NOTIFY
    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// ZONE PHIDS MODEL

  // --------------------
  ZonePhidsModel? _zonePhidsModel;
  ZonePhidsModel? get zonePhidsModel => _zonePhidsModel;
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZonePhidsModel? proGetZonePhids({
    required BuildContext context,
    required bool listen,
  }){
    final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    return zoneProvider.zonePhidsModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _fetchSetZonePhidsModel({
    required bool notify,
    required ZoneModel? zone,
  }) async {

    final ZonePhidsModel? _model = await ZonePhidsProtocols.fetch(zoneModel: zone);

    _zonePhidsModel = _model;
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
    /// ZONE PHID COUNTERS
    _zonePhidsModel = null;

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
