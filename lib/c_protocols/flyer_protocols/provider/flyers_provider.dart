import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_promotion.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_search.dart' as FlyerSearch;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
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

    _promotedFlyers = FlyerModel.removeFlyerFromFlyersByID(
      flyers: _promotedFlyers,
      flyerIDToRemove: flyerID,
    );

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

    _promotedFlyers = FlyerModel.replaceFlyerInFlyers(
      flyers: _promotedFlyers,
      flyerToReplace: flyerModel,
      insertIfAbsent: false,
    );

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

  /// PROMOTED FLYERS

  // --------------------
  List<FlyerModel> _promotedFlyers = <FlyerModel>[];
  // --------------------
  List<FlyerModel> get promotedFlyers {
    return [..._promotedFlyers];
  }
  // --------------------
  Future<void> fetchSetPromotedFlyers({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final CityModel _currentCity = _zoneProvider.currentZone?.cityModel;

    if (_currentCity != null){

      final List<FlyerPromotion> _promotions = await FlyerSearch.flyerPromotionsByCity(
        cityID: _currentCity.cityID,
      );

      final List<String> _flyersIDs = FlyerPromotion.getFlyersIDsFromFlyersPromotions(promotions: _promotions);

      final List<FlyerModel> _flyers = await FlyerProtocols.fetchFlyers(
        context: context,
        flyersIDs: _flyersIDs,
      );

      _setPromotedFlyers(
        flyers: _flyers,
        notify: notify,
      );
    }

  }
  // --------------------
  void _setPromotedFlyers({
    @required List<FlyerModel> flyers,
    @required bool notify,
  }){
    _promotedFlyers = flyers;

    if (notify == true){
      notifyListeners();
    }

  }
  // --------------------
  void clearPromotedFlyers({
    @required bool notify,
  }){
    _setPromotedFlyers(
      flyers: <FlyerModel>[],
      notify: notify,
    );
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
      _selectedFlyers.add(flyer);
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
      _selectedFlyers.remove(flyer);
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
    @required BuildContext context,
    @required bool notify,
  }){

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

    /// _promotedFlyers
    _flyersProvider.clearPromotedFlyers(notify: false);

    /// _wallFlyers
    // _flyersProvider.clearWallFlyers(notify: false);

    /// _selectedFlyers
    _flyersProvider.clearSelectedFlyers(
      notify: true,
    );

  }
  // -----------------------------------------------------------------------------
}
