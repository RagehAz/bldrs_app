import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:mapper/mapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
class FlyersProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// MODIFY / DELETE FLYER FROM FLYERS PROVIDER

  // --------------------
  /// TESTED : WORKS PERFECT
  void removeFlyerFromProFlyers({
    @required String flyerID,
    @required bool notify,
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
    @required List<String> flyersIDs,
    @required bool notify,
  }){

    if (Mapper.checkCanLoopList(flyersIDs) == true){

      for (int i = 0; i < flyersIDs.length; i++){

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
    @required FlyerModel flyerModel,
    @required bool notify,
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
    @required BuildContext context,
    @required String keywordID,
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
  // --------------------
  ///
  Future<List<FlyerModel>> fetchFirstFlyersByBzModel({
    @required BuildContext context,
    @required BzModel bz,
    int limit = 3,
  }) async {

    final List<String> _flyersIDs = <String>[];
    final List<FlyerModel> _bzFlyers = <FlyerModel>[];

    if (bz != null && Mapper.checkCanLoopList(bz.flyersIDs) == true){

      final int _limit = bz.flyersIDs.length > limit ? limit : bz.flyersIDs.length;

      for (int i = 0; i < _limit; i++){
        _flyersIDs.add(bz.flyersIDs[i]);
      }


      for (final String flyerID in _flyersIDs){

        final FlyerModel _flyer = await FlyerProtocols.fetchFlyer(
          context: context,
          flyerID: flyerID,
        );

        _bzFlyers.add(_flyer);

      }

    }

    return _bzFlyers;
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
  void addFlyerToSelectedFlyers(FlyerModel flyer){

    final bool _flyersContainThisFlyer = FlyerModel.flyersContainThisID(
      flyers: _selectedFlyers,
      flyerID: flyer.id,
    );

    if (_flyersContainThisFlyer == false){
      _selectedFlyers = [...?_selectedFlyers, flyer];
      notifyListeners();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void removeFlyerFromSelectedFlyers(FlyerModel flyer){

    final bool _flyersContainThisFlyer = FlyerModel.flyersContainThisID(
      flyers: _selectedFlyers,
      flyerID: flyer.id,
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
    @required bool notify,
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
    @required bool notify,
  }){

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(getMainContext(), listen: false);

    /// _wallFlyers
    // _flyersProvider.clearWallFlyers(notify: false);

    /// _selectedFlyers
    _flyersProvider.clearSelectedFlyers(
      notify: true,
    );

  }
  // -----------------------------------------------------------------------------
}
