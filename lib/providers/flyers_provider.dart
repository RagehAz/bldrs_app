import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/crud/bz_ops.dart';
import 'package:bldrs/firestore/crud/flyer_ops.dart';
import 'package:bldrs/firestore/crud/record_ops.dart';
import 'package:bldrs/firestore/crud/user_ops.dart';
import 'package:bldrs/firestore/fire_search.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/records/save_model.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_flyer.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
// -----------------------------------------------------------------------------
/// this provides tiny flyers and tiny bzz
class FlyersProvider with ChangeNotifier {
  List<TinyBz> _sponsors;
  List<TinyBz> _userTinyBzz;
  List<FlyerModel> _loadedFlyers;
  List<TinyFlyer> _loadedTinyFlyers;
  List<BzModel> _loadedBzz;
  List<TinyBz> _loadedTinyBzz;
  List<TinyFlyer> _loadedSavedFlyers;
  List<String> _loadedFollows;
  List<FlyerModel> _bzOldFlyers;
// -----------------------------------------------------------------------------
  List<TinyBz> get getSponsors {
    return <TinyBz> [..._sponsors];
  }
// -----------------------------------------------------------------------------
  List<TinyBz> get getUserTinyBzz {
    return <TinyBz> [..._userTinyBzz];
  }
// -----------------------------------------------------------------------------
  List<FlyerModel> get getAllFlyers {
    return <FlyerModel>[..._loadedFlyers];
  }
// -----------------------------------------------------------------------------
  List<TinyFlyer> get getAllTinyFlyers {
    return <TinyFlyer>[..._loadedTinyFlyers];
  }
// -----------------------------------------------------------------------------
  List<BzModel> get getAllBzz {
    return <BzModel>[..._loadedBzz];
  }
// -----------------------------------------------------------------------------
  List<TinyBz> get getAllTinyBzz {
    return <TinyBz>[..._loadedTinyBzz];
  }
// -----------------------------------------------------------------------------
  List<TinyFlyer> get getSavedTinyFlyers {
    return <TinyFlyer>[..._loadedSavedFlyers];
  }
// -----------------------------------------------------------------------------
  List<String> get getFollows{
    return <String>[..._loadedFollows];
  }
// -----------------------------------------------------------------------------
  List<FlyerModel> get getBzOldFlyers{
    return <FlyerModel>[..._bzOldFlyers];
  }
// -----------------------------------------------------------------------------
  /// this sets app sponsors if any
  /// TASK : sponsors tiny bzz should depend on which city
  Future<void> fetchAndSetSponsors(BuildContext context) async {

    /// 1 - get sponsors map from db/admin/sponsors
    Map<String, dynamic> _sponsorsIDsMap = await Fire.readDoc(
      context: context,
      collName: FireCollection.admin,
      docName: AdminDoc.sponsors,
    );

    /// 2 - transform sponsors map into list<String>
    List<String> _sponsorsIDs = getValuesFromValueAndTrueMap(_sponsorsIDsMap);

    /// 3- get tinyBz for each id
    List<TinyBz> _sponsorsTinyBzz = new List();
    for (var id in _sponsorsIDs){
      TinyBz _tinyBz = await BzCRUD().readTinyBzOps(context: context, bzID: id);
      _sponsorsTinyBzz.add(_tinyBz);
    }

    _sponsors = _sponsorsTinyBzz;
    print(_sponsors.length);
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// if a user is an Author, this READs & sets user tiny bzz form db/users/userID['myBzzIDs']
  Future<void> fetchAndSetUserTinyBzz(BuildContext context) async {
    String _userID = superUserID();

    Map<String, dynamic> _userMap = await Fire.readDoc(
      context: context,
      collName: FireCollection.users,
      docName: _userID,
    );

    UserModel _userModel = UserModel.decipherUserMap(_userMap);

    List<dynamic> _userBzzIDs = _userModel.myBzzIDs;

    List<TinyBz> _userTinyBzzList = new List();

    for (var id in _userBzzIDs){
      dynamic _tinyBzMap = await Fire.readDoc(
        context: context,
        collName: FireCollection.tinyBzz,
        docName: id,
      );

      if (_tinyBzMap != null){
        TinyBz _tinyBz = TinyBz.decipherTinyBzMap(_tinyBzMap);
        _userTinyBzzList.add(_tinyBz);
      }

    }

    _userTinyBzz = _userTinyBzzList;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// READs and sets  db/users/userID/saves/flyers document
  Future<void> fetchAndSetSavedFlyers(BuildContext context) async {

    /// read user's saves doc
    List<SaveModel> _userSaveModels = await RecordCRUD.readUserSavesOps(context);

    /// from saveModels, get a list of saved tinyFlyers
    List<TinyFlyer> _savedTinyFlyers = new List();
    for (var saveModel in _userSaveModels){
      if (saveModel.saveState == SaveState.Saved) {
        TinyFlyer _tinyFlyer = await FlyerCRUD().readTinyFlyerOps(context: context, flyerID: saveModel.flyerID);

        if (_tinyFlyer != null){
          _savedTinyFlyers.add(_tinyFlyer);
        }

      }
    }

    /// assign the value to local variable
    _loadedSavedFlyers = _savedTinyFlyers;

    notifyListeners();
    print('_loadedSavedFlyers :::: --------------- ${_loadedSavedFlyers.toString()}');

  }
// -----------------------------------------------------------------------------
  /// READs and sets db/users/userID/saves/bzz document
  Future<void> fetchAndSetFollows(BuildContext context) async {

    /// read user's follows list
    List<String> _follows = await RecordCRUD.readUserFollowsOps(context);

    _loadedFollows = _follows ?? [];
    print('_loadedFollows = $_loadedFollows');
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  /// READs all TinyBzz in firebase realtime database
  Future<void> fetchAndSetTinyBzzAndTinyFlyers(BuildContext context) async {

    await tryAndCatch(
        context: context,
        functions: () async {

          /// READ data from cloud Firestore bzz collection
          List<dynamic> _fireStoreTinyBzzMaps = await Fire.readCollectionDocs(FireCollection.tinyBzz);
          final List<TinyBz> _fireStoreTinyBzzModels = TinyBz.decipherTinyBzzMaps(_fireStoreTinyBzzMaps);

          /// TASK : BOOMMM : should be _loadedTinyBzz = _fireStoreTinyBzzModels,, but this bom bom crash crash
          // _loadedTinyBzz.addAll(_fireStoreTinyBzzModels);
          _loadedTinyBzz = _fireStoreTinyBzzModels;

          /// READ data from cloud Firestore flyers collection
          List<dynamic> _fireStoreTinyFlyersMaps = await Fire.readCollectionDocs(FireCollection.tinyFlyers);
          final List<TinyFlyer> _fireStoreTinyFlyersModels = TinyFlyer.decipherTinyFlyersMaps(_fireStoreTinyFlyersMaps);

          /// TASK : after migrating local flyers to firestore, _loadedTinyFlyers = _fireStoreTinyFlyersModels;;
          // _loadedTinyFlyers.addAll(_fireStoreTinyFlyersModels);
          _loadedTinyFlyers = _fireStoreTinyFlyersModels;

          notifyListeners();
          print('_loadedTinyBzz :::: --------------- $_loadedTinyBzz');

        }
    );

  }
// -----------------------------------------------------------------------------
  /// READs all TinyBzz in firebase realtime database
  Future<void> fetchAndSetOldBzFlyers(BuildContext context, BzModel bzModel) async {

    final TinyBz _tinyBz = TinyBz.getTinyBzFromBzModel(bzModel);
    /// get all flyers from db/flyer/{where flyer.tinyBz.bzID == bzID}

    final CollectionReference _flyersColl = Fire.getCollectionRef(FireCollection.flyers);

    final List<dynamic> maps = await FireSearch.mapsByFieldValue(
      context: context,
      addDocsIDs: false,
      collRef: _flyersColl,
      field: 'tinyBz',
      compareValue: _tinyBz.toMap(),
      valueIs: ValueIs.EqualTo,
    );

    final List<FlyerModel> _oldFlyers = FlyerModel.decipherFlyersMaps(maps);

    _bzOldFlyers = _oldFlyers;
    notifyListeners();

    // _flyersColl.get([GetOptions()])
    //
    // Future<List<DocumentSnapshot>> getSuggestion(String suggestion) =>
    //     Firestore.instance
    //         .collection('your-collection')
    //         .orderBy('your-document')
    //         .startAt([searchkey])
    //         .endAt([searchkey + '\uf8ff'])
    //         .getDocuments()
    //         .then((snapshot) {
    //       return snapshot.documents;
    //     });

  }
// -----------------------------------------------------------------------------
  void removeTinyFlyerFromLocalList(String flyerID){
    int _index = _loadedTinyFlyers.indexWhere((tinyFlyer) => tinyFlyer.flyerID == flyerID);
    _loadedTinyFlyers.removeAt(_index);
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void removeTinyBzFromLocalList(String bzID){
    int _index = _loadedTinyBzz.indexWhere((tinyBz) => tinyBz.bzID == bzID);
    _loadedTinyBzz.removeAt(_index);
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  void removeTinyBzFromLocalUserTinyBzz(String bzID){
    int _index = _userTinyBzz.indexWhere((tinyBz) => tinyBz.bzID == bzID);
    _userTinyBzz.removeAt(_index);
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  FlyerModel getFlyerByFlyerID (String flyerID){
    FlyerModel _flyer = _loadedFlyers?.firstWhere((x) => x.flyerID == flyerID, orElse: ()=>null);
    return _flyer;
  }
// -----------------------------------------------------------------------------
  TinyFlyer getTinyFlyerByFlyerID (String flyerID){
    TinyFlyer _tinyFlyer = _loadedTinyFlyers?.firstWhere((x) => x.flyerID == flyerID, orElse: ()=>null);
    return _tinyFlyer;
  }
// -----------------------------------------------------------------------------
  List<FlyerModel> getFlyersByFlyersIDs(List<dynamic> flyersIDs){
    List<FlyerModel> flyers = new List();
    flyersIDs?.forEach((id) {flyers.add(getFlyerByFlyerID(id));});
    return flyers;
  }
// -----------------------------------------------------------------------------
  List<String> getTinyFlyersIDsByFlyerType(FlyerType flyerType){
    List<String> flyersIDs = new List();
    _loadedTinyFlyers?.forEach((fl) {
      if(fl.flyerType == flyerType){flyersIDs.add(fl.flyerID);}
    });
    return flyersIDs;
  }
// -----------------------------------------------------------------------------
  List<FlyerModel> getFlyersByFlyerType(FlyerType flyerType){
    List<FlyerModel> _flyers = new List();
    List<String> _flyersIDs = getTinyFlyersIDsByFlyerType(flyerType);
    _flyersIDs.forEach((fID) {
      _flyers.add(getFlyerByFlyerID(fID));
    });
    return _flyers;
  }
// -----------------------------------------------------------------------------
  List<TinyFlyer> getTinyFlyersByFlyerType(FlyerType flyerType){
    List<TinyFlyer> _tinyFlyers = new List();
    List<String> _flyersIDs = getTinyFlyersIDsByFlyerType(flyerType);
    _flyersIDs.forEach((fID) {
      _tinyFlyers.add(getTinyFlyerByFlyerID(fID));
    });
    return _tinyFlyers;
  }
// -----------------------------------------------------------------------------
  bool checkAnkh(String flyerID){
    bool _ankhIsOn = false;

      TinyFlyer _tinyFlyer = _loadedSavedFlyers?.firstWhere((flyer) => flyer.flyerID == flyerID, orElse: () => null);

      if(_tinyFlyer == null){
        _ankhIsOn = false;
      } else {
        _ankhIsOn = true;
      }

    return _ankhIsOn;
  }
// -----------------------------------------------------------------------------
  bool checkFollow(String bzID){
    bool _followIsOn = false;

    String _id = _loadedFollows?.firstWhere((id) => id == bzID, orElse: () => null);

    if(_id == null){
      _followIsOn = false;
    } else {
      _followIsOn = true;
    }
    print('_followIsOn = $_followIsOn');

    return _followIsOn;
  }
// -----------------------------------------------------------------------------
//   List<FlyerModel> getSavedFlyersFromFlyersList (List<FlyerModel> inputList, String userID){
//     List<FlyerModel> savedFlyers = new List();
//     List<FlyerModel> _inputList = inputList.isEmpty || inputList == null ? [] : inputList;
//     _inputList.forEach((flyer) {
//       if (getAnkhByFlyerID(flyer.flyerID, userID) == true){savedFlyers.add(flyer);}
//     });
//     return savedFlyers;
//   }
// -----------------------------------------------------------------------------
  List<FlyerModel> getFlyersByAuthorID(String authorID){
    List<FlyerModel> authorFlyers = new List();
    for (FlyerModel fl in _loadedFlyers){
      if (fl.tinyAuthor.userID == authorID){
        authorFlyers.add(fl);
      }
    }
    return authorFlyers;
  }
// ############################################################################
//   List<FlyerModel> getFlyersByBzModel(BzModel bz){
//     List<dynamic> bzFlyersIDs = new List();
//     bz?.bzAuthors?.forEach((au) {
//       List<dynamic> _publishedFlyersIDs = new List();
//       if(au?.publishedFlyersIDs == null || _publishedFlyersIDs == [])
//       {_publishedFlyersIDs = [];}
//       else {_publishedFlyersIDs = au?.publishedFlyersIDs;}
//       bzFlyersIDs.addAll(_publishedFlyersIDs);
//     });
//     List<FlyerModel> flyers = new List();
//     print('bzFlyersIDs = $bzFlyersIDs');
//     bzFlyersIDs?.forEach((id) {flyers.add(getFlyerByFlyerID(id));});
//     return flyers;
//   }
// -----------------------------------------------------------------------------
  BzModel getBzByBzID(String bzID){
    BzModel bz = _loadedBzz?.firstWhere((bz) => bz.bzID == bzID, orElse: ()=>null);
    return bz;
  }

  // Future<BzModel> getBzByBzID(String bzID) async {
  //   // BzModel bz = _loadedBzz?.firstWhere((bz) => bz.bzID == bzID, orElse: ()=>null);
  //   BzModel bz = await BzCRUD.readBzOps(bzID: bzID);
  //   return bz;
  // }


// -----------------------------------------------------------------------------
  TinyBz getTinyBzByBzID(String bzID){
    TinyBz _tinyBz = _loadedTinyBzz?.firstWhere((bz) => bz.bzID == bzID, orElse: ()=>null);
    return _tinyBz;
  }
// -----------------------------------------------------------------------------

  List<BzModel> getBzzOfFlyersList(List<FlyerModel> flyersList){
    List<BzModel> _bzz = new List();
    flyersList.forEach((fl) {
      _bzz.add(getBzByBzID(fl.tinyBz.bzID));
    });
    return _bzz;
}
// -----------------------------------------------------------------------------
  List<TinyBz> getTinyBzzOfTinyFlyersList(List<TinyFlyer> tinyFlyersList){
    List<TinyBz> _tinyBzz = new List();
    tinyFlyersList.forEach((fl) {
      _tinyBzz.add(getTinyBzByBzID(fl?.tinyBz?.bzID));
    });
    return _tinyBzz;
  }
// -----------------------------------------------------------------------------
  List<BzModel> getBzzByBzzIDs(List<String> bzzIDs){
List<BzModel> bzz = new List();
bzzIDs.forEach((bzID) {bzz.add(getBzByBzID(bzID));});
return bzz;
}
// ############################################################################
//   /// add bz to local list
//   void addBzModelToLocalList(BzModel bzModel){
//     _loadedBzz.add(bzModel);
//     notifyListeners();
//   }
// ############################################################################
  /// add TinyBz to local list
  void addTinyBzToLocalList(TinyBz tinyBz){
    _loadedTinyBzz.add(tinyBz);
    notifyListeners();
  }
// ############################################################################
  void addTinyBzToUserTinyBzz(TinyBz tinyBz){
    _userTinyBzz.add(tinyBz);
    notifyListeners();
  }
// ############################################################################
  void updateTinyBzInLocalList(TinyBz modifiedTinyBz){
    int _indexOfOldTinyBz = _loadedTinyBzz.indexWhere((bz) => modifiedTinyBz.bzID == bz.bzID);
    _loadedTinyBzz.removeAt(_indexOfOldTinyBz);
    _loadedTinyBzz.insert(_indexOfOldTinyBz, modifiedTinyBz);
    notifyListeners();
  }
// ############################################################################
  void updateTinyBzInUserTinyBzz(TinyBz modifiedTinyBz){
    int _indexOfOldTinyBz = _userTinyBzz.indexWhere((bz) => modifiedTinyBz.bzID == bz.bzID);
    _userTinyBzz.removeAt(_indexOfOldTinyBz);
    _userTinyBzz.insert(_indexOfOldTinyBz, modifiedTinyBz);
    notifyListeners();
  }
// ############################################################################
  /// add flyer to local list
  void addFlyerModelToLocalList(FlyerModel flyer){
    _loadedFlyers.add(flyer);
    notifyListeners();
  }
// ############################################################################
  void addTinyFlyerToLocalList(TinyFlyer tinyFlyer){
    _loadedTinyFlyers.add(tinyFlyer);
    notifyListeners();
  }
// ############################################################################
  void addOrDeleteTinyFlyerInLocalSavedTinyFlyers(TinyFlyer _inputTinyFlyer){

    TinyFlyer _savedTinyFlyer =
    _loadedSavedFlyers.singleWhere((tf) => tf.flyerID == _inputTinyFlyer.flyerID, orElse: ()=> null);

    if (_savedTinyFlyer == null){
      /// so flyer is not already saved, so we save it
      _loadedSavedFlyers.add(_inputTinyFlyer);
    } else {
      /// so flyer is already saved, so we remove it
      int _savedTinyFlyerIndex =
      _loadedSavedFlyers.indexWhere((tf) => tf.flyerID == _inputTinyFlyer.flyerID, );

      _loadedSavedFlyers.removeAt(_savedTinyFlyerIndex);
    }

    notifyListeners();
  }
// ############################################################################
  void updatedFollowsInLocalList(List<String> updatedFollows){
    _loadedFollows = updatedFollows;
    notifyListeners();
  }
// ############################################################################
  void replaceTinyFlyerInLocalList(TinyFlyer tinyFlyer){
    int _tinyFlyerIndex = _loadedTinyFlyers.indexWhere((t) => t.flyerID == tinyFlyer.flyerID);
    _loadedTinyFlyers.removeAt(_tinyFlyerIndex);
    _loadedTinyFlyers.insert(_tinyFlyerIndex, tinyFlyer);
    notifyListeners();
  }
// ############################################################################
/// BZZ ON FIRE STORE
// -----------------------------------------------------------------------------
  /// bzz collection reference
  final CollectionReference bzzCollection =
  FirebaseFirestore.instance.collection(FireCollection.bzz);
// -----------------------------------------------------------------------------
  /// create Bz document
  Future<void> createBzDocument(BzModel bz, UserModel userModel) async {

  /// add bz to firestore
  DocumentReference _docRef = bzzCollection.doc();
  await _docRef.set(bz.toMap());

  /// get back the document id and patch/update the document with id value
  String bzID = _docRef.id;
  await bzzCollection.doc(bzID).update({'bzID' : bzID});

  /// create local bzModel adding the bzId
  final BzModel _newBz = BzModel(
    bzID: bzID,
    // -------------------------
    bzType: bz.bzType,
    bzForm: bz.bzForm,
    bldrBirth: bz.bldrBirth,
    accountType: bz.accountType,
    bzURL: bz.bzURL,
    // -------------------------
    bzName: bz.bzName,
    bzLogo: bz.bzLogo,
    bzScope: bz.bzScope,
    bzCountry: bz.bzCountry,
    bzProvince: bz.bzProvince,
    bzArea: bz.bzArea,
    bzAbout: bz.bzAbout,
    bzPosition: bz.bzPosition,
    bzContacts: bz.bzContacts,
    bzAuthors: bz.bzAuthors,
    bzShowsTeam: bz.bzShowsTeam,
    // -------------------------
    bzIsVerified: bz.bzIsVerified,
    bzAccountIsDeactivated: bz.bzAccountIsDeactivated,
    bzAccountIsBanned: bz.bzAccountIsBanned,
    // -------------------------
    bzTotalFollowers: bz.bzTotalFollowers,
    bzTotalSaves: bz.bzTotalSaves,
    bzTotalShares: bz.bzTotalShares,
    bzTotalSlides: bz.bzTotalSlides,
    bzTotalViews: bz.bzTotalViews,
    bzTotalCalls: bz.bzTotalCalls,
    // -------------------------
    bzFlyers: bz.bzFlyers,
  );

  /// add this bz in author's userModel['myBzz']
  userModel.myBzzIDs.insert(0, bzID);
  List<String> _newMyBzzIDsList = userModel.myBzzIDs;

  /// create new userModel with the new list of tempFollowedBzzIDs
  UserModel _newUserModel = UserModel(
    // -------------------------
    userID : userModel.userID,
    joinedAt : userModel.joinedAt,
    userStatus : UserStatus.BzAuthor,
    // -------------------------
    name : userModel.name,
    pic : userModel.pic,
    title : userModel.title,
    company : userModel.company,
    gender : userModel.gender,
    country : userModel.country,
    province : userModel.province,
    area : userModel.area,
    language : userModel.language,
    position : userModel.position,
    contacts : userModel.contacts,
    // -------------------------
    myBzzIDs: _newMyBzzIDsList,
  );

  /// update firestore with the _newUserModel
  /// when firebase finds the same userID
  await UserCRUD().updateUserOps(updatedUserModel: _newUserModel, oldUserModel: userModel);

  /// add the local bzModel to the local list of bzModels _loadedBzz
  _loadedBzz.add(_newBz);

  /// for sure never forget
  notifyListeners();

}
// === === === === === === === === === === === === === === === === === === ===
  Future<void> deleteBzDocument(BzModel bzModel) async {
  DocumentReference _bzDocument = Fire.getDocRef(FireCollection.bzz, bzModel.bzID);
  await _bzDocument.delete();
}
// === === === === === === === === === === === === === === === === === === ===
  Future<void> updateFirestoreBz(BzModel bz) async {
    final bzIndex = _loadedBzz.indexWhere((bzModel) => bzModel.bzID == bz.bzID);
    if (bzIndex >= 0){

      bzzCollection.doc(bz.bzID).set(bz.toMap());

      _loadedBzz[bzIndex] = bz;
      notifyListeners();
    } else {
      print('could not update this fucking bz : ${bz.bzName} : ${bz.bzID}');
    }
  }
// === === === === === === === === === === === === === === === === === === ===
  /// get flyer doc stream
  Stream<FlyerModel> getFlyerStream(String flyerID) {
    Stream<DocumentSnapshot> _flyerSnapshot = Fire.streamDoc(FireCollection.flyers, flyerID);
    Stream<FlyerModel> _flyerStream = _flyerSnapshot.map(_flyerModelFromSnapshot);
    return _flyerStream;
  }
// -----------------------------------------------------------------------------
  /// get bz doc stream
  Stream<BzModel> getBzStream(String bzID) {
    Stream<DocumentSnapshot> _bzSnapshot = Fire.streamDoc(FireCollection.bzz, bzID);
    Stream<BzModel> _bzStream = _bzSnapshot.map(_bzModelFromSnapshot);
    return _bzStream;
  }
// -----------------------------------------------------------------------------
  /// get bz doc stream
  Stream<TinyBz> getTinyBzStream(String bzID) {
    Stream<DocumentSnapshot> _bzSnapshot = Fire.streamDoc(FireCollection.tinyBzz, bzID);
    Stream<TinyBz> _tinyBzStream = _bzSnapshot.map(_tinyBzModelFromSnapshot);
    return _tinyBzStream;
  }
// -----------------------------------------------------------------------------
  FlyerModel _flyerModelFromSnapshot(DocumentSnapshot doc){
    var _map = doc.data();
    FlyerModel _flyerModel = FlyerModel.decipherFlyerMap(_map);
    return _flyerModel;
  }
// -----------------------------------------------------------------------------
  BzModel _bzModelFromSnapshot(DocumentSnapshot doc){
  var _map = doc.data();
  BzModel _bzModel = BzModel.decipherBzMap(_map['bzID'], _map);
  return _bzModel;
  }
// -----------------------------------------------------------------------------
  TinyBz _tinyBzModelFromSnapshot(DocumentSnapshot doc){
    var _map = doc.data();
    TinyBz _tinyBz = TinyBz.decipherTinyBzMap(_map);
    return _tinyBz;
  }
// -----------------------------------------------------------------------------
  /// READs all Bzz in firebase realtime database
  Future<void> fetchAndSetBzz(BuildContext context) async {

    await tryAndCatch(
        context: context,
        functions: () async {

          /// READ data from cloud Firestore bzz collection
          List<QueryDocumentSnapshot> _fireStoreBzzMaps = await Fire.readCollectionDocs(FireCollection.bzz);
          final List<BzModel> _fireStoreBzzModels = BzModel.decipherBzzMapsFromFireStore(_fireStoreBzzMaps);

          /// TASK : BOOMMM : should be _loadedBzz = _loadedBzzFromDB,, but this bom bom crash crash
          // _loadedBzz.addAll(_fireStoreBzzModels);
          _loadedBzz = _fireStoreBzzModels;

          /// READ data from cloud Firestore flyers collection
          List<QueryDocumentSnapshot> _fireStoreFlyersMaps = await Fire.readCollectionDocs(FireCollection.flyers);
          final List<FlyerModel> _fireStoreFlyersModels = FlyerModel.decipherFlyersMaps(_fireStoreFlyersMaps);

         /// TASK : after migrating local flyers to firestore, _loadedFlyers should = _fireStoreFlyersModels;
         //  _loadedFlyers.addAll(_fireStoreFlyersModels);
          _loadedFlyers = _fireStoreFlyersModels;

          notifyListeners();
          print('_loadedBzz :::: --------------- $_loadedBzz');

        }
    );

  }
}
