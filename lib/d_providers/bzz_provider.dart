import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as BzFireOps;
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart' as LDBOps;
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
class BzzProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// FETCHING BZZ

// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<BzModel> fetchBzByID({
    @required BuildContext context,
    @required String bzID
  }) async {

    BzModel _bz = await BzLDBOps.readBz(bzID);

    if (_bz != null){
      blog('fetchBzByID : ($bzID) BzModel FOUND in LDB');
    }
    else {

      _bz = await BzFireOps.readBz(
        context: context,
        bzID: bzID,
      );

      if (_bz != null) {
        blog('fetchBzByID : ($bzID) BzModel FOUND in FIREBASE and inserted in LDB');
        await LDBOps.insertMap(
          input: _bz.toMap(toJSON: true),
          docName: LDBDoc.bzz,
        );
      }

    }

    if (_bz == null) {
      blog('fetchBzByID : ($bzID) BzModel NOT FOUND');
    }

    return _bz;
  }
// -------------------------------------
  Future<List<BzModel>> fetchBzzModels({
    @required BuildContext context,
    @required List<String> bzzIDs
  }) async {

    final List<BzModel> _bzz = <BzModel>[];

    if (Mapper.checkCanLoopList(bzzIDs)) {
      for (final String bzID in bzzIDs) {

        final BzModel _bz = await fetchBzByID(
            context: context,
            bzID: bzID,
        );

        if (_bz != null) {
          _bzz.add(_bz);
        }

      }
    }

    return _bzz;
  }
// -------------------------------------
  Future<List<BzModel>> fetchUserBzz({
    @required BuildContext context,
    @required UserModel userModel
  }) async {

     List<BzModel> _bzz = <BzModel>[];

    if (userModel != null) {
      if (Mapper.checkCanLoopList(userModel.myBzzIDs)) {

        _bzz = await fetchBzzModels(
            context: context,
            bzzIDs: userModel.myBzzIDs
        );

      }
    }

    return _bzz;
  }
// -------------------------------------
  static Future<BzModel> proFetchBzModel({
    @required BuildContext context,
    @required String bzID,
  }) async {
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    final BzModel _bzModel = await _bzzProvider.fetchBzByID(
      context: context,
      bzID: bzID,
    );
    return _bzModel;
  }
// -----------------------------------------------------------------------------

  /// SPONSORS

// -------------------------------------
  List<BzModel> _sponsors = <BzModel>[];
// -------------------------------------
  List<BzModel> get sponsors {
    return <BzModel>[..._sponsors];
  }
// -------------------------------------
  /// TASK : sponsors bzz should depend on which city
  /// FETCH SPONSORS
  /// 1 - get sponsors from app state
  /// 2 - fetch each bzID if found
  Future<void> fetchSetSponsors({
    @required BuildContext context,
    @required bool notify,
}) async {
    /// 1 - get sponsorsIDs from app state
    // final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    final List<String> _sponsorsBzzIDs = []; /// TASK : RESTRUCTURE SPONSORS THING

    if (Mapper.checkCanLoopList(_sponsorsBzzIDs)) {
      /// 2 - fetch bzz
      final List<BzModel> _bzzSponsors = await fetchBzzModels(
          context: context,
          bzzIDs: _sponsorsBzzIDs
      );

      _setSponsors(
        bzz: _bzzSponsors,
        notify: notify,
      );
    }
  }
// -------------------------------------
  void _setSponsors({
    @required List<BzModel> bzz,
    @required bool notify,
}){
    _sponsors = bzz;
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  void clearSponsors({
  @required bool notify,
}){
    _setSponsors(
      bzz: <BzModel>[],
      notify: notify,
    );

  }
// -------------------------------------
  void removeBzFromSponsors({
    @required String bzIDToRemove,
    @required bool notify,
}){

    final int _index = _sponsors.indexWhere((bz) => bz.id == bzIDToRemove);

    if (_index != -1){
      _sponsors.removeAt(_index);

      if (notify == true){
        notifyListeners();
      }

    }

  }
// -----------------------------------------------------------------------------

  /// USER BZZ

// -------------------------------------
  List<BzModel> _myBzz = <BzModel>[];
// -------------------------------------
  List<BzModel> get myBzz {
    return <BzModel>[..._myBzz];
  }
// -------------------------------------
  static List<BzModel> proGetMyBzz({
    @required BuildContext context,
    @required bool listen,
  }){
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: listen);
    final List<BzModel> _myBzz = _bzzProvider.myBzz;
    return _myBzz;
  }
// -------------------------------------
  static List<String> proGetMyBzzIDs({
    @required BuildContext context,
    @required bool listen,
  }){
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: listen);
    final List<BzModel> _myBzz = _bzzProvider.myBzz;
    final List<String> _myBzzIDs = BzModel.getBzzIDsFromBzz(_myBzz);
    return _myBzzIDs;
  }
// -------------------------------------
  Future<void> fetchSetMyBzz({
    @required BuildContext context,
    @required bool notify,
  }) async {

    /// 1 - get userBzzIDs from userModel
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final List<String> _userBzzIDs = _usersProvider.myUserModel?.myBzzIDs;

    if (Mapper.checkCanLoopList(_userBzzIDs)) {
      /// 2 - fetch bzz
      final List<BzModel> _bzz = await fetchBzzModels(context: context, bzzIDs: _userBzzIDs);

      _setMyBzz(
        bzz: _bzz,
        notify: notify,
      );

    }
  }
// -------------------------------------
  void _setMyBzz({
    @required List<BzModel> bzz,
    @required bool notify,
  }){

    blog('BZZ PROVIDER : _setMyBzz : new bz has been set');
    _myBzz = bzz;
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  void clearMyBzz({
  @required bool notify,
}){
    _setMyBzz(
      bzz: <BzModel>[],
      notify: notify,
    );
  }
// -------------------------------------
  void removeBzFromMyBzz({
    @required String bzID,
    @required bool notify,
  }) {

    if (Mapper.checkCanLoopList(_myBzz)) {

      final int _index = _myBzz.indexWhere((BzModel bzModel) => bzModel.id == bzID);
      _myBzz.removeAt(_index);

      if (notify == true){
        notifyListeners();
      }

    }
  }
// -------------------------------------
  void addBzToMyBzz({
    @required BzModel bzModel,
    @required bool notify,
  }) {
    _myBzz.add(bzModel);
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  void updateBzInMyBzz({
    @required BzModel modifiedBz,
    @required bool notify,
  }) {

    if (Mapper.checkCanLoopList(_myBzz)) {

      final int _index = _myBzz.indexWhere((BzModel bz) => modifiedBz.id == bz.id);

      if (_index != -1){

        final List<BzModel> _newList = <BzModel>[..._myBzz];
        _newList.removeAt(_index);
        _newList.insert(_index, modifiedBz);

        _setMyBzz(
          bzz: _newList,
          notify: notify,
        );

      }


    }

  }
// -----------------------------------------------------------------------------

  /// FOLLOWED BZZ

// -------------------------------------
  List<BzModel> _followedBzz = <BzModel>[];
// -------------------------------------
  List<BzModel> get followedBzz {
    return <BzModel>[..._followedBzz];
  }
// -------------------------------------
  Future<void> fetchSetFollowedBzz({
    @required BuildContext context,
    @required bool notify,
}) async {
    /// 1 - get user saved followed bzz IDs
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _usersProvider.myUserModel;
    final List<String> _followedBzzIDs = _myUserModel?.followedBzzIDs;

    if (Mapper.checkCanLoopList(_followedBzzIDs)) {

      final List<BzModel> _bzz = await fetchBzzModels(
        context: context,
        bzzIDs: _followedBzzIDs,
      );

      _setFollowedBzz(
        bzz: _bzz,
        notify: notify,
      );
    }
  }
// -------------------------------------
  void _setFollowedBzz({
    @required List<BzModel> bzz,
    @required bool notify,
  }){
    _followedBzz = bzz;
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  void clearFollowedBzz({
  @required bool notify,
}){
    _setFollowedBzz(
      bzz: <BzModel>[],
      notify: notify,
    );
  }
// -------------------------------------
  bool checkFollow({
    @required BuildContext context,
    @required String bzID,
  }) {
    bool _isFollowing = false;

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _usersProvider.myUserModel;

    final String _id = _myUserModel?.followedBzzIDs?.firstWhere((String id) => id == bzID, orElse: () => null);

    if (_id == null) {
      _isFollowing = false;
    }

    else {
      _isFollowing = true;
    }

    // blog('_isFollowing = $_isFollowing');

    return _isFollowing;
  }
// -------------------------------------
  void removeBzFromFollowedBzz({
    @required String bzIDToRemove,
    @required bool notify,
}){

    final int _index = _followedBzz.indexWhere((bz) => bz.id == bzIDToRemove);

    if (_index != -1){
      _followedBzz.removeAt(_index);

      if (notify == true){
        notifyListeners();
      }

    }

  }
// -----------------------------------------------------------------------------

  /// MY ACTIVE BZ

// -------------------------------------
  BzModel _myActiveBz;
  List<FlyerModel> _myActiveBzFlyers = <FlyerModel>[];
// -----------------------------------------------------------------------------
  BzModel get myActiveBz {
    return _myActiveBz;
  }
  List<FlyerModel> get myActiveBzFlyers{

    blog('GETTING _myActiveBzFlyers : ${_myActiveBzFlyers.length} flyers');

    return _myActiveBzFlyers;
  }
// -----------------------------------------------------------------------------
  Future<void> fetchSetActiveBzFlyers({
    @required BuildContext context,
    @required String bzID,
    @required bool notify,
  }) async {

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    final List<FlyerModel> _flyers = await _flyersProvider.fetchAllBzFlyersByBzID(
        context: context,
        bzID: bzID,
    );

    blog('getsetActiveBzFlyers : got ${_flyers?.length} flyers');

    setActiveBzFlyers(
      flyers: _flyers,
      notify: notify,
    );

  }
// -------------------------------------
  void setActiveBz({
    @required BzModel bzModel,
    @required bool notify,
  }) {

    blog('BZZ PROVIDER : setActiveBz : setting active bz to ${bzModel?.id}');

    _myActiveBz = bzModel;

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  void setActiveBzFlyers({
    @required List<FlyerModel> flyers,
    @required bool notify,
  }){

    blog('_setActiveBzFlyers : ${flyers.length} flyers');
    _myActiveBzFlyers = <FlyerModel>[...flyers];

    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  void updateFlyerInActiveBzFlyers({
    @required FlyerModel flyer,
    @required bool insertIfAbsent,
    @required bool notify,
  }){

    if (flyer != null){

      _myActiveBzFlyers = FlyerModel.replaceFlyerInFlyers(
        flyers: _myActiveBzFlyers,
        flyerToReplace: flyer,
        insertIfAbsent: insertIfAbsent,
      );

      if (notify == true){
        notifyListeners();
      }

    }

  }
// -------------------------------------
  void removeFlyerFromActiveBzFlyers({
    @required String flyerID,
    @required bool notify,
  }){

    if (flyerID != null){

      _myActiveBzFlyers = FlyerModel.removeFlyerFromFlyersByID(
        flyers: _myActiveBzFlyers,
        flyerIDToRemove: flyerID,
      );

      if (notify == true){
        notifyListeners();
      }

    }

  }
// -------------------------------------
  void removeFlyersFromActiveBzFlyers({
    @required List<String> flyersIDs,
    @required bool notify,
  }){

    if (Mapper.checkCanLoopList(flyersIDs) == true){

      for (int i = 0; i < flyersIDs.length; i++){

        bool _notify = false;
        if (i + 1 == flyersIDs.length){
          _notify = notify;
        }

        removeFlyerFromActiveBzFlyers(
          flyerID: flyersIDs[i],
          notify: _notify,
        );

      }

    }

  }
// -------------------------------------
  void clearActiveBzFlyers({
  @required bool notify,
}){
    setActiveBzFlyers(
      flyers: <FlyerModel>[],
      notify: notify,
    );
  }
// -----------------------------------------------------------------------------
  void clearMyActiveBz({
  @required bool notify,
}){
    setActiveBz(
      bzModel: null,
      notify: notify,
    );
  }
// -----------------------------------------------------------------------------

  /// PRO GETTERS

// --------------------------------
  static BzModel proGetActiveBzModel({
    @required BuildContext context,
    @required bool listen,
}) {
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: listen);
    return _bzzProvider.myActiveBz;
  }
// --------------------------------
  static List<FlyerModel> proGetActiveBzFlyers({
    @required BuildContext context,
    @required bool listen,
}){
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: listen);
    return _bzzProvider.myActiveBzFlyers;

}
// --------------------------------

}
