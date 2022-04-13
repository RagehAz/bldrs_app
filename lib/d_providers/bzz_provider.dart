import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as FireBzOps;
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
class BzzProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// FETCHING BZZ

// -------------------------------------
  Future<BzModel> fetchBzModel({
    @required BuildContext context,
    @required String bzID
  }) async {

    /// 1 - search in entire LDBs for this bzModel
    /// 2 - if not found, search firebase
    ///   2.1 read firebase bz ops
    ///   2.2 if found on firebase, store in ldb sessionBzz

    blog('fetchBzModel : $bzID');

    BzModel _bz;

    /// 1 - search in entire LDBs for this bzModel
    for (final String doc in LDBDoc.bzModelsDocs) {
      final Map<String, Object> _map = await LDBOps.searchFirstMap(
        docName: doc,
        fieldToSortBy: 'id',
        searchField: 'id',
        searchValue: bzID,
      );

      if (_map != null && _map != <String, dynamic>{}) {
        _bz = BzModel.decipherBz(
          map: _map,
          fromJSON: true,
        );
        break;
      }
    }

    /// 2 - if not found, search firebase
    if (_bz == null) {
      /// 2.1 read firebase bz ops
      _bz = await FireBzOps.readBz(
        context: context,
        bzID: bzID,
      );

      /// 2.2 if found on firebase, store in ldb sessionBzz
      if (_bz != null) {
        await LDBOps.insertMap(
            input: _bz.toMap(toJSON: true),
            docName: LDBDoc.bzz,
            primaryKey: 'id');
      }
    }

    return _bz;
  }
// -------------------------------------
  Future<List<BzModel>> fetchBzzModels({
    @required BuildContext context,
    @required List<String> bzzIDs
  }) async {
    final List<BzModel> _bzz = <BzModel>[];

    if (Mapper.canLoopList(bzzIDs)) {
      for (final String bzID in bzzIDs) {
        final BzModel _bz = await fetchBzModel(context: context, bzID: bzID);

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
      if (Mapper.canLoopList(userModel.myBzzIDs)) {

        _bzz = await fetchBzzModels(
            context: context,
            bzzIDs: userModel.myBzzIDs
        );

      }
    }

    return _bzz;
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
  Future<void> getSetSponsors(BuildContext context) async {
    /// 1 - get sponsorsIDs from app state
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    final List<String> _sponsorsBzzIDs = _generalProvider.appState.sponsors;

    if (Mapper.canLoopList(_sponsorsBzzIDs)) {
      /// 2 - fetch bzz
      final List<BzModel> _bzzSponsors = await fetchBzzModels(
          context: context,
          bzzIDs: _sponsorsBzzIDs
      );

      _setSponsors(_bzzSponsors);
    }
  }
// -------------------------------------
  void _setSponsors(List<BzModel> bzz){
    _sponsors = bzz;
    notifyListeners();
  }
// -------------------------------------
  void clearSponsors(){
    _setSponsors(<BzModel>[]);
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
  Future<void> getSetMyBzz(BuildContext context) async {
    /// 1 - get userBzzIDs from userModel
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final List<String> _userBzzIDs = _usersProvider.myUserModel?.myBzzIDs;

    if (Mapper.canLoopList(_userBzzIDs)) {
      /// 2 - fetch bzz
      final List<BzModel> _bzz = await fetchBzzModels(context: context, bzzIDs: _userBzzIDs);

      _setMyBzz(_bzz);
    }
  }
// -------------------------------------
  void _setMyBzz(List<BzModel> bzz){
    _myBzz = bzz;
    notifyListeners();
  }
// -------------------------------------
  void clearMyBzz(){
    _setMyBzz(<BzModel>[]);
  }
// -------------------------------------
  Future<void> removeBzFromMyBzz({@required String bzID}) async {
    if (Mapper.canLoopList(_myBzz)) {
      await LDBOps.deleteMap(
        objectID: bzID,
        docName: LDBDoc.bzz,
      );

      final int _index =
          _myBzz.indexWhere((BzModel bzModel) => bzModel.id == bzID);
      _myBzz.removeAt(_index);

      notifyListeners();
    }
  }
// -------------------------------------
  void addBzToMyBzz(BzModel bzModel) {
    _myBzz.add(bzModel);
    notifyListeners();
  }
// -------------------------------------
  Future<void> updateBzInUserBzz(BzModel modifiedBz) async {
    if (Mapper.canLoopList(_myBzz)) {
      await LDBOps.updateMap(
        input: modifiedBz.toMap(toJSON: true),
        objectID: modifiedBz.id,
        docName: LDBDoc.bzz,
      );

      final int _indexOfOldTinyBz =
          _myBzz.indexWhere((BzModel bz) => modifiedBz.id == bz.id);
      _myBzz.removeAt(_indexOfOldTinyBz);
      _myBzz.insert(_indexOfOldTinyBz, modifiedBz);

      notifyListeners();
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
  Future<void> getsetFollowedBzz(BuildContext context) async {
    /// 1 - get user saved followed bzz IDs
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _usersProvider.myUserModel;
    final List<String> _followedBzzIDs = _myUserModel?.followedBzzIDs;

    if (Mapper.canLoopList(_followedBzzIDs)) {

      final List<BzModel> _bzz = await fetchBzzModels(
        context: context,
        bzzIDs: _followedBzzIDs,
      );

      _setFollowedBzz(_bzz);
    }
  }
// -------------------------------------
  void _setFollowedBzz(List<BzModel> bzz){
    _followedBzz = bzz;
    notifyListeners();
  }
// -------------------------------------
  void clearFollowedBzz(){
    _setFollowedBzz(<BzModel>[]);
  }
// -------------------------------------
  bool checkFollow({@required BuildContext context, @required String bzID}) {
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
// -----------------------------------------------------------------------------

  /// MY ACTIVE BZ

// -------------------------------------
  BzModel _myActiveBz;
  CountryModel _myActiveBzCountry;
  CityModel _myActiveBzCity;
  List<FlyerModel> _myActiveBzFlyers = <FlyerModel>[];
// -----------------------------------------------------------------------------
  BzModel get myActiveBz {
    return _myActiveBz;
  }
  CountryModel get myActiveBzCountry => _myActiveBzCountry;
  CityModel get myActiveBzCity => _myActiveBzCity;
  List<FlyerModel> get myActiveBzFlyers{
    return _myActiveBzFlyers;
  }
// -----------------------------------------------------------------------------
  void setActiveBz({
    @required BzModel bzModel,
    @required CountryModel bzCountry,
    @required CityModel bzCity,
  }) {
    blog('setting active bz to ${bzModel?.id}');
    _myActiveBz = bzModel;
    _myActiveBzCountry = bzCountry;
    _myActiveBzCity = bzCity;
    notifyListeners();
  }
// -------------------------------------
  Future<void> getsetActiveBzFlyers({
    @required BuildContext context,
    @required String bzID
  }) async {

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    final List<FlyerModel> _flyers = await _flyersProvider.fetchAllBzFlyersByBzID(context: context, bzID: bzID);

    _setActiveBzFlyers(_flyers);

  }
// -------------------------------------
  void _setActiveBzFlyers(List<FlyerModel> flyers){
    _myActiveBzFlyers = flyers;
    notifyListeners();
  }
// -------------------------------------
  void clearActiveBzFlyers(){
    _setActiveBzFlyers(<FlyerModel>[]);
  }
// -----------------------------------------------------------------------------
  void clearMyActiveBz(){
    setActiveBz(
      bzModel: null,
      bzCity: null,
      bzCountry: null,
    );
  }
// -----------------------------------------------------------------------------
}

/*

  // TASK : this technique to revert back the status if firestore operation fails needs to be adapted elsewhere
//   void _setFollowValue(bool newValue){
//     followIsOn = newValue;
//     notifyListeners();
//   }

  // Future<void> toggleFollow() async {
  //   final oldStatus = followIsOn;
  //   blog('oldStatus is : $oldStatus');
  //   _setFollowValue(!followIsOn);
  //   blog('new followIsOn is : $followIsOn');
  //   final url = 'https://bldrsnet.firebaseio.com/bzz/$bzID.json';
  //   blog('url is : $url');
  //   try {
  //     final response = await http.patch(url,
  //         body: json.encode({
  //           'followIsOn' : followIsOn,
  //         }));
  //     if (response.statusCode >= 400){
  //       _setFollowValue(oldStatus);
  //       blog('response.statusCode is : ${response.body}');
  //     } else {
  //     blog('followIsOn changed on server to : $followIsOn');
  //     // add the id in user's firebase document in  followedBzzIDs
  //     }
  //   } catch (error){
  //     _setFollowValue(oldStatus);
  //     blog('error is : $error');
  //
  //   }
  // }
// ###############################


 */
