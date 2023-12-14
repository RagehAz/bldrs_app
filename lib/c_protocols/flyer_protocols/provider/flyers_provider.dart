import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
class FlyersProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// MODIFY / DELETE FLYER FROM FLYERS PROVIDER

  // --------------------
  /// TESTED : WORKS PERFECT
  void removeFlyerFromProFlyers({
    required String flyerID,
    required bool notify,
  }) {

    _selectedFlyers = FlyerModel.removeFlyerFromFlyersByID(
      flyers: _selectedFlyers,
      flyerIDToRemove: flyerID,
    );

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void removeFlyersFromProFlyers({
    required List<String>? flyersIDs,
    required bool notify,
  }){

    if (Lister.checkCanLoopList(flyersIDs) == true){

      for (int i = 0; i < flyersIDs!.length; i++){

        final String _flyerIDToRemove = flyersIDs[i];

        bool _notify = false;
        if (i + 1 == flyersIDs.length){
          _notify = notify;
        }

        removeFlyerFromProFlyers(
          flyerID: _flyerIDToRemove,
          notify: _notify,
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void updateFlyerInAllProFlyers({
    required FlyerModel flyerModel,
    required bool notify,
  }){

    _selectedFlyers = FlyerModel.replaceFlyerInFlyers(
      flyers: _selectedFlyers,
      flyerToReplace: flyerModel,
      insertIfAbsent: false,
    );

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// SEARCHERS

  // --------------------
  /*
  Future<List<FlyerModel>> fetchFlyersByCurrentZoneAndKeyword({
    required BuildContext context,
    required String keywordID,
    int limit = 3,
  }) async {
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final ZoneModel _currentZone = _zoneProvider.currentZone;

    /// TASK : think this through.. can it be fetch instead of just search ? I don't think soooooo
    final List<FlyerModel> _flyers = await FlyerSearch.flyersByZoneAndKeywordID(
      zone: _currentZone,
      keywordID: keywordID,
      limit: limit,
    );

    return _flyers;
  }
   */
  // -----------------------------------------------------------------------------

  /// ZOOMED FLYER

  // --------------------
  FlyerModel? _zoomedFlyer;
  FlyerModel? get zoomedFlyer => _zoomedFlyer;
  // --------------------
  static FlyerModel? proGetZoomedFlyer({
    required bool listen,
    required BuildContext context,
  }){
    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    return _flyersProvider.zoomedFlyer;
  }
  // --------------------
  static void proSetZoomedFlyer({
    required BuildContext context,
    required FlyerModel? flyerModel,
    required bool notify,
  }){

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    _flyersProvider.setZoomedFlyer(
        flyerModel: flyerModel,
        notify: notify
    );

  }
  // --------------------
  void setZoomedFlyer({
    required FlyerModel? flyerModel,
    required bool notify,
  }) {

    if (_zoomedFlyer != flyerModel){
      _zoomedFlyer = flyerModel;
      if (notify == true){
        notifyListeners();
      }
    }


  }
  // -----------------------------------------------------------------------------

  /// SELECTED FLYERS

  // --------------------
  List<FlyerModel> _selectedFlyers = <FlyerModel>[];
  // --------------------
  List<FlyerModel> get selectedFlyers {
    return <FlyerModel>[..._selectedFlyers];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void addFlyerToSelectedFlyers(FlyerModel? flyer){

    final bool _flyersContainThisFlyer = FlyerModel.flyersContainThisID(
      flyers: _selectedFlyers,
      flyerID: flyer?.id,
    );

    if (_flyersContainThisFlyer == false && flyer != null){
      _selectedFlyers = [..._selectedFlyers, flyer];
      notifyListeners();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void removeFlyerFromSelectedFlyers(FlyerModel? flyer){

    final bool _flyersContainThisFlyer = FlyerModel.flyersContainThisID(
      flyers: _selectedFlyers,
      flyerID: flyer?.id,
    );

    if (_flyersContainThisFlyer == true){

      _selectedFlyers = FlyerModel.removeFlyerFromFlyersByID(
        flyers: _selectedFlyers,
        flyerIDToRemove: flyer?.id,
      );

      notifyListeners();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void clearSelectedFlyers({
    required bool notify,
  }){
    _selectedFlyers = <FlyerModel>[];

    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE OUT

  // --------------------
  /// TESTED : WORKS PERFECT
  static void wipeOut({
    required bool notify,
  }){

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(getMainContext(), listen: false);

    /// _wallFlyers
    // _flyersProvider.clearWallFlyers(notify: false);

    /// _selectedFlyers
    _flyersProvider.clearSelectedFlyers(
      notify: false,
    );

    /// _zoomedFLyer
    _flyersProvider.setZoomedFlyer(flyerModel: null, notify: notify);

  }
  // -----------------------------------------------------------------------------
}
