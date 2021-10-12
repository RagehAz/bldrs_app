import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/db/firestore/bz_ops.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
class BzzProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------
  /// FETCHING BZZ
  /// 1 - search in entire LDBs for this bzModel
  /// 2 - if not found, search firebase
  ///   2.1 read firebase bz ops
  ///   2.2 if found on firebase, store in ldb sessionBzz
  Future<BzModel> fetchBzModel({@required BuildContext context, @required  String bzID}) async {

    BzModel _bz;

    /// 1 - search in entire LDBs for this bzModel
    for (String doc in LDBDoc.bzModelsDocs){

      final Map<String, Object> _map = await LDBOps.searchMap(
        docName: doc,
        fieldToSortBy: 'bzID',
        searchField: 'bzID',
        searchValue: bzID,
      );

      if (_map != null && _map != {}){
        _bz = BzModel.decipherBzMap(
          map: _map,
          fromJSON: true,
        );
        break;
      }

    }

    /// 2 - if not found, search firebase
    if (_bz == null){

      /// 2.1 read firebase bz ops
      _bz = await BzOps.readBzOps(
        context: context,
        bzID: bzID,
      );

      /// 2.2 if found on firebase, store in ldb sessionBzz
      if (_bz != null){
        await LDBOps.insertMap(
          input: _bz.toMap(toJSON: true),
          docName: LDBDoc.sessionBzz,
        );
      }

    }

    return _bz;
  }
// -------------------------------------
  Future<List<BzModel>> fetchBzzModels({@required BuildContext context, @required List<String> bzzIDs}) async {

    List<BzModel> _bzz = <BzModel>[];

    if (Mapper.canLoopList(bzzIDs)){

      for (String bzID in bzzIDs){

        final BzModel _bz = await fetchBzModel(context: context, bzID: bzID);

        if (_bz != null){

          _bzz.add(_bz);

        }

      }

    }

    return _bzz;
  }
// -----------------------------------------------------------------------------
  /// SPONSORS
  List<TinyBz> _sponsors = <TinyBz>[];
// -------------------------------------
  List<TinyBz> get sponsors {
    return <TinyBz> [..._sponsors];
  }
// -------------------------------------
  /// TASK : sponsors tiny bzz should depend on which city
  /// FETCH SPONSORS
  /// 1 - get sponsors from app state
  /// 2 - fetch each bzID if found
  Future<void> fetchSponsors(BuildContext context) async {

    /// 1 - get sponsorsIDs from app state
    final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    final List<String> _sponsorsBzzIDs = _generalProvider.appState.sponsors;

    if (Mapper.canLoopList(_sponsorsBzzIDs)){

      /// 2 - fetch bzz
      List<BzModel> _bzzSponsors = await fetchBzzModels(context: context, bzzIDs: _sponsorsBzzIDs);

      List<TinyBz> _tinyBzz = TinyBz.getTinyBzzFromBzzModels(_bzzSponsors);

      _sponsors = _tinyBzz;
      notifyListeners();

    }

  }
// -----------------------------------------------------------------------------
  /// USER BZZ
  List<TinyBz> _userTinyBzz = <TinyBz>[];
// -------------------------------------
  List<TinyBz> get userTinyBzz {
    return <TinyBz> [..._userTinyBzz];
  }
// -------------------------------------
  Future<void> fetchUserBzz(BuildContext context) async {

    /// 1 - get userBzzIDs from userModel
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final List<String> _userBzzIDs = _usersProvider.myUserModel.myBzzIDs;

    if (Mapper.canLoopList(_userBzzIDs)){

      /// 2 - fetch bzz
      List<BzModel> _userBzz = await fetchBzzModels(context: context, bzzIDs: _userBzzIDs);

      List<TinyBz> _tinyBzz = TinyBz.getTinyBzzFromBzzModels(_userBzz);

      _sponsors = _tinyBzz;
      notifyListeners();


    }
  }
// -------------------------------------
  void removeTinyBzFromUserTinyBzz({String bzID}){

    if (Mapper.canLoopList(_userTinyBzz)){
      final int _index = _userTinyBzz.indexWhere((tinyBz) => tinyBz.bzID == bzID);
      _userTinyBzz.removeAt(_index);
      notifyListeners();
    }
  }
// -------------------------------------
  void addTinyBzToUserTinyBzz(TinyBz tinyBz){
    _userTinyBzz.add(tinyBz);
    notifyListeners();
  }
// -------------------------------------
  void updateTinyBzInUserTinyBzz(TinyBz modifiedTinyBz){
    final int _indexOfOldTinyBz = _userTinyBzz.indexWhere((bz) => modifiedTinyBz.bzID == bz.bzID);
    _userTinyBzz.removeAt(_indexOfOldTinyBz);
    _userTinyBzz.insert(_indexOfOldTinyBz, modifiedTinyBz);
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// FOLLOWED BZZ
  List<TinyBz> _followedBzz;
// -------------------------------------
  List<TinyBz> get followedBzz{
    return <TinyBz>[..._followedBzz];
  }
// -------------------------------------
  Future<void> fetchFollowedBzz(BuildContext context) async {

    /// 1 - get user saved followed bzz IDs
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _usersProvider.myUserModel;
    final List<String> _followedBzzIDs = _myUserModel?.followedBzzIDs;

    if (Mapper.canLoopList(_followedBzzIDs)){

      final List<BzModel> _bz = await fetchBzzModels(
        context: context,
        bzzIDs: _followedBzzIDs,
      );

      final List<TinyBz> _tinyBzz = TinyBz.getTinyBzzFromBzzModels(_bz);

      _followedBzz = _tinyBzz;
      notifyListeners();

    }

  }
// -------------------------------------
  bool checkFollow({BuildContext context, String bzID}){
    bool _isFollowing = false;

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _usersProvider.myUserModel;


    final String _id = _myUserModel.followedBzzIDs?.firstWhere((id) => id == bzID, orElse: () => null);

    if(_id == null){
      _isFollowing = false;
    } else {
      _isFollowing = true;
    }
    // print('_isFollowing = $_isFollowing');

    return _isFollowing;
  }
// -----------------------------------------------------------------------------
  /// ACTIVE BZ
  BzModel _activeBz;
// -----------------------------------------------------------------------------
  BzModel get activeBz{
    return _activeBz;
  }
// -----------------------------------------------------------------------------
  Future<void> setActiveBz(BzModel bzModel) async {
    print('setting active bz to ${bzModel.bzID}');
    _activeBz = bzModel;
    notifyListeners();
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
  //   print('oldStatus is : $oldStatus');
  //   _setFollowValue(!followIsOn);
  //   print('new followIsOn is : $followIsOn');
  //   final url = 'https://bldrsnet.firebaseio.com/bzz/$bzID.json';
  //   print('url is : $url');
  //   try {
  //     final response = await http.patch(url,
  //         body: json.encode({
  //           'followIsOn' : followIsOn,
  //         }));
  //     if (response.statusCode >= 400){
  //       _setFollowValue(oldStatus);
  //       print('response.statusCode is : ${response.body}');
  //     } else {
  //     print('followIsOn changed on server to : $followIsOn');
  //     // add the id in user's firebase document in  followedBzzIDs
  //     }
  //   } catch (error){
  //     _setFollowValue(oldStatus);
  //     print('error is : $error');
  //
  //   }
  // }
// ###############################


 */