import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/firestore/crud/user_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/sub_models/http_exceptions.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:bldrs/xxx_temp_hard_database/db_bzz.dart';
import 'package:bldrs/xxx_temp_hard_database/db_flyer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'users_provider.dart';
// -----------------------------------------------------------------------------
class FlyersProvider with ChangeNotifier {
  List<FlyerModel> _loadedFlyers = geebAllFlyers();
  List<BzModel> _loadedBzz = geebAllBzz();
  List<TinyBz> _loadedTinyBzz = geebAllTinyBzz();
// ############################################################################
  List<FlyerModel> get getAllFlyers {
    return [..._loadedFlyers];
  }
// ---------------------------------------------------------------------------
  List<BzModel> get getAllBzz {
    return [..._loadedBzz];
  }
// ---------------------------------------------------------------------------
  List<TinyBz> get getAllTinyBzz {
    return [..._loadedTinyBzz];
  }
// ---------------------------------------------------------------------------
  List<FlyerModel> get getSavedFlyers {
    return _loadedFlyers.where((fl) => fl.ankhIsOn).toList();
  }
  // ---------------------------------------------------------------------------
  /// this reads db/users/userID/saves/followedBzz document
  /// TASK: get user followed bzz from firestore as document
  List<TinyBz> get getFollowedBzz{
    List<TinyBz> _followedBzz = new List();
    return _followedBzz;
  }
// ############################################################################
  FlyerModel getFlyerByFlyerID (String flyerID){
    FlyerModel flyer = _loadedFlyers?.firstWhere((x) => x.flyerID == flyerID, orElse: ()=>null);
    return flyer;
  }
// ---------------------------------------------------------------------------
  List<FlyerModel> getFlyersByFlyersIDs(List<dynamic> flyersIDs){
    List<FlyerModel> flyers = new List();
    flyersIDs?.forEach((id) {flyers.add(getFlyerByFlyerID(id));});
    return flyers;
  }
// ---------------------------------------------------------------------------
  List<String> getFlyersIDsByFlyerType(FlyerType flyerType){
    List<String> flyersIDs = new List();
    _loadedFlyers?.forEach((fl) {
      if(fl.flyerType == flyerType){flyersIDs.add(fl.flyerID);}
    });
    return flyersIDs;
  }
// ---------------------------------------------------------------------------
  List<FlyerModel> getFlyersByFlyerType(FlyerType flyerType){
    List<FlyerModel> flyers = new List();
    List<String> flyersIDs = getFlyersIDsByFlyerType(flyerType);
    flyersIDs.forEach((fID) {
      flyers.add(getFlyerByFlyerID(fID));
    });
    return flyers;
  }
// ---------------------------------------------------------------------------
  bool getAnkhByFlyerID(String flyerID, String useID){
    bool ankhIsOn = false;
    FlyerModel flyer = getFlyerByFlyerID(flyerID);
    if (flyer.ankhIsOn == true){ankhIsOn = true;}else{ankhIsOn = false;}
    return ankhIsOn;
  }
// ---------------------------------------------------------------------------
  List<FlyerModel> getSavedFlyersFromFlyersList (List<FlyerModel> inputList, String userID){
    List<FlyerModel> savedFlyers = new List();
    List<FlyerModel> _inputList = inputList.isEmpty || inputList == null ? [] : inputList;
    _inputList.forEach((flyer) {
      if (getAnkhByFlyerID(flyer.flyerID, userID) == true){savedFlyers.add(flyer);}
    });
    return savedFlyers;
  }
// ---------------------------------------------------------------------------
  List<FlyerModel> getFlyersByAuthorID(String authorID){
    List<FlyerModel> authorFlyers = new List();
    for (FlyerModel fl in _loadedFlyers){
      if (fl.authorID == authorID){
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
// ---------------------------------------------------------------------------
  BzModel getBzByBzID(String bzID){
    BzModel bz = _loadedBzz?.firstWhere((bz) => bz.bzID == bzID, orElse: ()=>null);
    return bz;
  }
// ---------------------------------------------------------------------------
List<BzModel> getBzzOfFlyersList(List<FlyerModel> flyersList){
    List<BzModel> bzz = new List();
    flyersList.forEach((fl) {
      bzz.add(getBzByBzID(fl.tinyBz.bzID));
    });
    return bzz;
}
// ---------------------------------------------------------------------------
List<BzModel> getBzzByBzzIDs(List<String> bzzIDs){
List<BzModel> bzz = new List();
bzzIDs.forEach((bzID) {bzz.add(getBzByBzID(bzID));});
return bzz;
}
// ############################################################################
  /// add flyer to local list
  void addFlyerToLocalFlyersList(FlyerModel flyer){
    _loadedFlyers.add(flyer);
    notifyListeners();
  }
// ############################################################################
/// BZZ ON FIRE STORE
// ---------------------------------------------------------------------------
/// bzz collection reference
final CollectionReference bzzCollection = FirebaseFirestore.instance.collection(FireStoreCollection.bzz);
// ---------------------------------------------------------------------------
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
    bzTotalJoints: bz.bzTotalJoints,
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
  await UserCRUD().createUserDoc(userModel: _newUserModel);

  /// add the local bzModel to the local list of bzModels _loadedBzz
  _loadedBzz.add(_newBz);

  /// for sure never forget
  notifyListeners();

}

// === === === === === === === === === === === === === === === === === === ===
Future<void> deleteBzDocument(BzModel bzModel) async {
  DocumentReference _bzDocument = getFirestoreDocumentReference(FireStoreCollection.bzz, bzModel.bzID);
  await _bzDocument.delete();
}
// === === === === === === === === === === === === === === === === === === ===
  Future<void> updateFirestoreBz(BzModel bz) async {
    final bzIndex = _loadedBzz.indexWhere((bzModel) => bzModel.bzID == bz.bzID);
    if (bzIndex >= 0){

      bzzCollection.doc(bz.bzID).set(bz.toMap());

      // final url = 'https://bldrsnet.firebaseio.com/bzz/${bz.bzID}.json';
      // await http.patch(url, body: json.encode({
      //   'bzID': bz.bzID,
      //   // -------------------------
      //   'bzType': cipherBzType(bz.bzType),
      //   'bzForm': cipherBzForm(bz.bzForm),
      //   'bldrBirth': cipherDateTimeToString(bz.bldrBirth),
      //   'accountType': cipherBzAccountType(bz.accountType),
      //   'bzURL': bz.bzURL,
      //   // -------------------------
      //   'bzName': bz.bzName,
      //   'bzLogo': bz.bzLogo,
      //   'bzScope': bz.bzScope,
      //   'bzCountry': bz.bzCountry,
      //   'bzProvince': bz.bzProvince,
      //   'bzArea': bz.bzArea,
      //   'bzAbout': bz.bzAbout,
      //   'bzPosition': bz.bzPosition,
      //   'bzContacts': cipherContactsModels(bz.bzContacts),
      //   'bzAuthors': cipherAuthorsModels(bz.bzAuthors),
      //   'bzShowsTeam': bz.bzShowsTeam,
      //   // -------------------------
      //   'bzIsVerified': bz.bzIsVerified,
      //   'bzAccountIsDeactivated': bz.bzAccountIsDeactivated,
      //   'bzAccountIsBanned': bz.bzAccountIsBanned,
      //   // -------------------------
      //   'bzTotalFollowers': bz.bzTotalFollowers,
      //   'bzTotalSaves': bz.bzTotalSaves,
      //   'bzTotalShares': bz.bzTotalShares,
      //   'bzTotalSlides': bz.bzTotalSlides,
      //   'bzTotalViews': bz.bzTotalViews,
      //   'bzTotalCalls': bz.bzTotalCalls,
      //   'bzTotalJoints': bz.bzTotalJoints,
      //   // -------------------------
      //   'jointsBzzIDs': bz.jointsBzzIDs,
        // -------------------------
        // 'followIsOn': bz.followIsOn,
        // will change in later max lessons to be user based
      // }
    // )
    // );

      _loadedBzz[bzIndex] = bz;
      notifyListeners();
    } else {
      print('could not update this fucking bz : ${bz.bzName} : ${bz.bzID}');
    }
  }
// === === === === === === === === === === === === === === === === === === ===
  /// get bz doc stream
  Stream<BzModel> getBzStream(String bzID) {
    Stream<DocumentSnapshot> _bzSnapshot = getFirestoreDocumentSnapshots(FireStoreCollection.bzz, bzID);
    Stream<BzModel> _bzStream = _bzSnapshot.map(_bzModelFromSnapshot);
    return _bzStream;
  }

  BzModel _bzModelFromSnapshot(DocumentSnapshot doc){
  var map = doc.data();
  BzModel _bzModel = decipherBzMap(map['bzID'], map);
  return _bzModel;
  }
// ---------------------------------------------------------------------------
  /// READs all Bzz in firebase realtime database
  Future<void> fetchAndSetBzz(BuildContext context) async {

    await tryAndCatch(
        context: context,
        functions: () async {

          /// READ data from cloud Firestore bzz collection
          List<QueryDocumentSnapshot> _fireStoreBzzMaps = await getFireStoreCollectionMaps(FireStoreCollection.bzz);
          final List<BzModel> _fireStoreBzzModels = decipherBzMapsFromFireStore(_fireStoreBzzMaps);

          /// TASK : BOOMMM : should be _loadedBzz = _loadedBzzFromDB,, but this bom bom crash crash
          _loadedBzz.addAll(_fireStoreBzzModels);

          /// READ data from cloud Firestore flyers collection
          List<QueryDocumentSnapshot> _fireStoreFlyersMaps = await getFireStoreCollectionMaps(FireStoreCollection.flyers);
          final List<FlyerModel> _fireStoreFlyersModels = decipherFlyersMapsFromFireStore(_fireStoreFlyersMaps);

         /// TASK : after migrating local flyers to firestore, _loadedFlyers should = _fireStoreFlyersModels;
          _loadedFlyers.addAll(_fireStoreFlyersModels);

          notifyListeners();
          print('_loadedBzz :::: --------------- $_loadedBzz');

        }
    );

  }
// ############################################################################

}
// -----------------------------------------------------------------------------
BzModel getBzFromBzzByBzID(List<BzModel> bzz, String bzID){
  BzModel _bz = bzz.singleWhere((_b) => _b.bzID == bzID, orElse: ()=> null);
  return _bz;
}
// -----------------------------------------------------------------------------
