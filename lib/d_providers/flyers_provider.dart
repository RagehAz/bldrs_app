import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/flyer_promotion.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart' as FireFlyerOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/fire/search/flyer_search.dart' as FlyerSearch;
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
class FlyersProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// FETCHING FLYERS

// -------------------------------------
  Future<FlyerModel> fetchFlyerByID({
    @required BuildContext context,
    @required  String flyerID,
  }) async {

    /// 1 - search in entire LDBs for this flyerModel
    /// 2 - if not found, search firebase
    ///   2.1 read firebase flyer ops
    ///   2.2 if found on firebase, store in ldb sessionFlyers


    FlyerModel _flyer;

    /// 1 - search in entire LDBs for this flyerModel
    for (final String doc in LDBDoc.flyerModelsDocs){

      final Map<String, Object> _map = await LDBOps.searchFirstMap(
        docName: doc,
        fieldToSortBy: 'id',
        searchField: 'id',
        searchValue: flyerID,
      );

      if (_map != null && _map != <String, dynamic>{}){
        blog('fetchFlyerByID : flyer found in local db : $doc');
        _flyer = FlyerModel.decipherFlyer(
            map: _map,
            fromJSON: true,
        );
        break;
      }

    }

    /// 2 - if not found, search firebase
    if (_flyer == null){
      blog('fetchFlyerByID : flyer NOT found in local db');

      /// 2.1 read firebase flyer ops
      _flyer = await FireFlyerOps.readFlyerOps(
        context: context,
        flyerID: flyerID,
      );

      /// 2.2 if found on firebase, store in ldb sessionFlyers
      if (_flyer != null){
        blog('fetchFlyerByID : flyer found in firestore db');

        await LDBOps.insertMap(
          input: _flyer.toMap(toJSON: true),
          docName: LDBDoc.flyers,
        );

      }

    }

    return _flyer;
  }
// -------------------------------------
  Future<List<FlyerModel>> fetchFlyersByIDs({
    @required BuildContext context,
    @required List<String> flyersIDs,
  }) async {
    final List<FlyerModel> _flyers = <FlyerModel>[];

    if (Mapper.canLoopList(flyersIDs)){

      for (final String flyerID in flyersIDs){

        final FlyerModel _flyer = await fetchFlyerByID(context: context, flyerID: flyerID);

        if (_flyer != null){

          _flyers.add(_flyer);

        }

      }

    }

    return _flyers;
  }
// -------------------------------------
  Future<List<FlyerModel>> fetchAllBzFlyersByBzID({
    @required BuildContext context,
    @required String bzID,
  }) async {

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    final BzModel _activeBz = _bzzProvider.myActiveBz;
    final List<String> _bzFlyersIDs = _activeBz?.flyersIDs;

    List<FlyerModel> _flyers = <FlyerModel>[];

    if (Mapper.canLoopList(_bzFlyersIDs)) {

      _flyers = await fetchFlyersByIDs(
          context: context,
          flyersIDs: _bzFlyersIDs,
      );

      blog('fetchAllBzFlyersByBzID : ${_flyers?.length} flyers');
    }

    return _flyers;
  }
// -----------------------------------------------------------------------------

  /// REMOVE FLYER FROM FLYERS PROVIDER

// -------------------------------------
  void removeFlyerFromFlyersProvider({
    @required String flyerID,
    @required bool notify,
  }) {

    _savedFlyers = FlyerModel.removeFlyerFromFlyersByID(
        flyers: _savedFlyers,
        flyerIDToRemove: flyerID,
    );
    _promotedFlyers = FlyerModel.removeFlyerFromFlyersByID(
      flyers: _promotedFlyers,
      flyerIDToRemove: flyerID,
    );
    _wallFlyers = FlyerModel.removeFlyerFromFlyersByID(
      flyers: _wallFlyers,
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
// -----------------------------------------------------------------------------

  /// SAVED FLYERS

// -------------------------------------
  List<FlyerModel> _savedFlyers = <FlyerModel>[];
// -------------------------------------
  List<FlyerModel> get savedFlyers {
    return <FlyerModel>[..._savedFlyers];
  }
// -------------------------------------
  Future<void> fetchSetSavedFlyers({
    @required BuildContext context,
    @required bool notify,
  }) async {

    /// 1 - get user saved flyers IDs
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _usersProvider.myUserModel;
    final List<String> _savedFlyersIDs = _myUserModel?.savedFlyersIDs;

    if (Mapper.canLoopList(_savedFlyersIDs)){

      final List<FlyerModel> _flyers = await fetchFlyersByIDs(
        context: context,
        flyersIDs: _savedFlyersIDs,
      );

      _setSavedFlyers(
        flyers: _flyers,
        notify: notify,
      );

    }

  }
// -------------------------------------
  void _setSavedFlyers({
    @required List<FlyerModel> flyers,
    @required bool notify,
  }){
    _savedFlyers = flyers ?? <FlyerModel>[];
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  void clearSavedFlyers({
  @required bool notify,
}){
    _setSavedFlyers(
      flyers: <FlyerModel>[],
      notify: notify,
    );
  }
// -------------------------------------
  bool checkFlyerIsSaved(String flyerID){
    bool _ankhIsOn = false;

    final FlyerModel _flyer = _savedFlyers?.firstWhere((FlyerModel flyer) => flyer.id == flyerID, orElse: () => null);

    if(_flyer == null){
      _ankhIsOn = false;
    } else {
      _ankhIsOn = true;
    }

    return _ankhIsOn;
  }
// -------------------------------------
  Future<void> saveOrUnSaveFlyer({
    @required BuildContext context,
    @required FlyerModel inputFlyer,
    @required bool notify,
  }) async {

    final FlyerModel _savedFlyer =
    _savedFlyers.singleWhere((FlyerModel tf) => tf.id == inputFlyer.id, orElse: ()=> null);

    final List<String> _savedFlyersIDs = FlyerModel.getFlyersIDsFromFlyers(_savedFlyers);

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);


    if (_savedFlyer == null){
      /// so flyer is not already saved, so we save it
      _savedFlyers.add(inputFlyer);

      /// insert flyer in ldb
      await LDBOps.insertMap(
        docName: LDBDoc.flyers,
        input: inputFlyer.toMap(toJSON: true),
      );

      /// updated saved flyers ids in firebase
      await UserFireOps.addFlyerIDToSavedFlyersIDs(
        context: context,
        userID: _usersProvider.myUserModel.id,
        flyerID: inputFlyer.id,
        savedFlyersIDs: _savedFlyersIDs,

      );

    }

    else {
      /// so flyer is already saved, so we remove it
      final int _savedFlyerIndex =
      _savedFlyers.indexWhere((FlyerModel tf) => tf.id == inputFlyer.id, );
      _savedFlyers.removeAt(_savedFlyerIndex);

      /// no need to remove flyer from LDB.flyers
      // await LDBOps.deleteMap(
      //     docName: LDBDoc.mySavedFlyers,
      //     objectID: inputFlyer.id,
      // );

      /// remove from saved flyersIDs in firebase
      await UserFireOps.removeFlyerIDFromSavedFlyersIDs(
        context: context,
        userID: _usersProvider.myUserModel.id,
        flyerID: inputFlyer.id,
        savedFlyersIDs: _savedFlyersIDs,
      );

    }

    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// PROMOTED FLYERS

// -------------------------------------
  List<FlyerModel> _promotedFlyers = <FlyerModel>[];
// -------------------------------------
  List<FlyerModel> get promotedFlyers {
    return [..._promotedFlyers];
  }
// -------------------------------------
  Future<void> fetchSetPromotedFlyers({
    @required BuildContext context,
    @required bool notify,
}) async {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final CityModel _currentCity = _zoneProvider.currentCity;

    if (_currentCity != null){

      final List<FlyerPromotion> _promotions = await FlyerSearch.flyerPromotionsByCity(
        context: context,
        cityID: _currentCity.cityID,
      );

      final List<String> _flyersIDs = FlyerPromotion.getFlyersIDsFromFlyersPromotions(promotions: _promotions);

      final List<FlyerModel> _flyers = await fetchFlyersByIDs(context: context, flyersIDs: _flyersIDs);

      _setPromotedFlyers(
        flyers: _flyers,
        notify: notify,
      );
    }

  }
// -------------------------------------
  void _setPromotedFlyers({
    @required List<FlyerModel> flyers,
    @required bool notify,
  }){
    _promotedFlyers = flyers;

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  void clearPromotedFlyers({
  @required bool notify,
}){
    _setPromotedFlyers(
      flyers: <FlyerModel>[],
      notify: notify,
    );
  }
// -----------------------------------------------------------------------------

  /// WALL FLYERS

// -------------------------------------
  List<FlyerModel> _wallFlyers = <FlyerModel>[];
// -------------------------------------
  List<FlyerModel> get wallFlyers {
    return <FlyerModel>[..._wallFlyers];
  }
// -------------------------------------
  Future<void> paginateWallFlyers(BuildContext context) async {

    final ZoneModel _currentZone = ZoneProvider.proGetCurrentZoneIDs(context);

    final FlyerModel _lastWallFlyer = Mapper.canLoopList(_wallFlyers) == true ?
    _wallFlyers.last
        :
    null;

    final List<FlyerModel> _flyers = await FireFlyerOps.paginateFlyers(
      context: context,
      countryID: _currentZone.countryID,
      cityID: _currentZone.cityID,
      // districtID: _currentZone.districtID,
      auditState: AuditState.verified,
      publishState: PublishState.published,
      specs: <String>[ChainsProvider.proGetHomeWallPhid(context)],
      flyerType: ChainsProvider.proGetHomeWallFlyerType(context),
      limit: 6,
      startAfter: _lastWallFlyer?.docSnapshot,
    );

    _addToWallFlyers(
      flyers: _flyers,
      notify: true,
    );

  }
// -------------------------------------
  void _addToWallFlyers({
    @required List<FlyerModel> flyers,
    @required bool notify,
  }) {
    _wallFlyers.addAll(flyers);
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  void clearWallFlyers({
  @required bool notify,
}){
    _wallFlyers = <FlyerModel>[];
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// SEARCHERS

// -------------------------------------
  Future<List<FlyerModel>> fetchFlyersByCurrentZoneAndKeyword({
    @required BuildContext context,
    @required String keywordID,
    int limit = 3,
  }) async {
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final ZoneModel _currentZone = _zoneProvider.currentZone;

    /// TASK : think this through.. can it be fetch instead of just search ? I don't think soooooo
    final List<FlyerModel> _flyers = await FlyerSearch.flyersByZoneAndKeywordID(
      context: context,
      zone: _currentZone,
      keywordID: keywordID,
      limit: limit,
    );

    return _flyers;
  }
// -------------------------------------
  Future<List<FlyerModel>> fetchFirstFlyersByBzModel({
    @required BuildContext context,
    @required BzModel bz,
    int limit = 3,
  }) async {

    final List<String> _flyersIDs = <String>[];
    final List<FlyerModel> _bzFlyers = <FlyerModel>[];

    if (bz != null && Mapper.canLoopList(bz.flyersIDs) == true){

      final int _limit = bz.flyersIDs.length > limit ? limit : bz.flyersIDs.length;

      for (int i = 0; i < _limit; i++){
        _flyersIDs.add(bz.flyersIDs[i]);
      }


      for (final String flyerID in _flyersIDs){

        final FlyerModel _flyer = await fetchFlyerByID(context: context, flyerID: flyerID);
        _bzFlyers.add(_flyer);
      }

    }

    return _bzFlyers;
  }
// -----------------------------------------------------------------------------

  /// SELECTED FLYERS

// -------------------------------------
  List<FlyerModel> _selectedFlyers = <FlyerModel>[];
// -------------------------------------
  List<FlyerModel> get selectedFlyers {
    return <FlyerModel>[..._selectedFlyers];
  }
// -------------------------------------
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
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------

  /// PRO GETTERS

// -------------------------------------
static Future<List<FlyerModel>> proFetchFlyers({
  @required BuildContext context,
  @required List<String> flyersIDs,
}) async {

  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  final List<FlyerModel> _flyers = await _flyersProvider.fetchFlyersByIDs(
      context: context,
      flyersIDs: flyersIDs,
  );

  return _flyers;
}
// -------------------------------------
static Future<FlyerModel> proFetchFlyer({
  @required BuildContext context,
  @required String flyerID,
}) async {

  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  final FlyerModel _flyer = await _flyersProvider.fetchFlyerByID(
      context: context,
      flyerID: flyerID,
  );

  return _flyer;
}
// -------------------------------------
}
