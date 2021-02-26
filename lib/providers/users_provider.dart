import 'package:bldrs/models/sub_models/contact_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/drafters/timerz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider{
  final String userID;

  UserProvider({this.userID});

  /// collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  /// create user document
  Future updateUserData({
    String userID,
    DateTime joinedAt,
    UserStatus userStatus,
// -------------------------
    String name,
    String pic,
    String title,
    String company,
    Gender gender,
    String country,
    String province,
    String area,
    String language,
    GeoPoint position,
    List<ContactModel> contacts,
// -------------------------
    List<dynamic> savedFlyersIDs,
    List<dynamic> followedBzzIDs,
  }) async {
    return await usersCollection.doc(userID).set({
      'userID' : userID,
      'joinedAt' : cipherDateTimeToString(joinedAt),
      'userStatus' : cipherUserStatus(userStatus),
// -------------------------
      'name' : name,
      'pic' : pic,
      'title' : title,
      'company' : company,
      'gender' : cipherGender(gender),
      'country' : country,
      'province' : province,
      'area' : area,
      'language' : language,
      'position' : position,
      'contacts' : cipherContactsModels(contacts),
// -------------------------
      'savedFlyersIDs' : savedFlyersIDs,
      'followedBzzIDs' : followedBzzIDs,
    });
  }

  /// users list from snapshot
  List<UserModel> _usersListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      // print(doc.data()['savedFlyersIDs']);
      List<dynamic> _savedFlyersIDs = doc.data()['savedFlyersIDs'] as List<dynamic>;
      List<dynamic> _followedBzzIDs = doc.data()['followedBzzIDs'] as List<dynamic>;
      // List<dynamic> _publishedFlyersIDs = doc.data()['publishedFlyersIDs'] as List<dynamic>;
      return UserModel(
        userID : doc.data()['userID'] ?? '',
        joinedAt : decipherDateTimeString(doc.data()['joinedAt'] ?? ''),
        userStatus : decipherUserStatus(doc.data()['userStatus']?? 1),
        // -------------------------
        name : doc.data()['name'] ?? '',
        pic : doc.data()['pic'] ?? '',
        title : doc.data()['title'] ?? '',
        company : doc.data()['company'] ?? '',
        gender : decipherGender(doc.data()['gender'] ?? 2),
        country : doc.data()['country'] ?? '',
        province :  doc.data()['province'] ?? '',
        area :  doc.data()['area'] ?? '',
        language : doc.data()['language'] ?? 'en',
        position : doc.data()['position'] ?? GeoPoint(0, 0),
        contacts : decipherContactsMaps(doc.data()['contacts'] ?? []),
        // -------------------------
        savedFlyersIDs : _savedFlyersIDs ?? [''],
        followedBzzIDs : _followedBzzIDs ?? [''],
      );
    }).toList();
  }

  /// UserModel from Snapshot
  UserModel _userModelFromSnapshot(DocumentSnapshot doc){

    // List<ContactModel> bolbol = decipherContactsMaps(doc.data()['contacts'] ?? []);
    // print('kos om ommak = ${bolbol[2].contact}');

    try{
      var _doc = doc.data();
      List<dynamic> _savedFlyersIDs = _doc['savedFlyersIDs'] as List<dynamic>;
      List<dynamic> _followedBzzIDs = _doc['followedBzzIDs'] as List<dynamic>;
      // List<dynamic> _publishedFlyersIDs = doc.data()['publishedFlyersIDs'] as List<dynamic>;
      return UserModel(
        userID : _doc['userID'] ?? '',
        joinedAt : decipherDateTimeString(_doc['joinedAt'] ?? ''),
        userStatus : decipherUserStatus(_doc['userStatus']?? 1),
        // -------------------------
        name : _doc['name'] ?? '',
        pic : _doc['pic'] ?? '',
        title : _doc['title'] ?? '',
        company : _doc['company'] ?? '',
        gender : decipherGender(doc.data()['gender'] ?? 2),
        country : doc.data()['country'] ?? '',
        province :  doc.data()['province'] ?? '',
        area :  doc.data()['area'] ?? '',
        language : doc.data()['language'] ?? 'en',
        position : doc.data()['position'] ?? GeoPoint(0, 0),
        contacts : decipherContactsMaps(doc.data()['contacts'] ?? []),
        // -------------------------
        savedFlyersIDs : _savedFlyersIDs ?? [''],
        followedBzzIDs : _followedBzzIDs ?? [''],
      );

    } catch(error){
      print('error is $error');
      throw(error);
    }
  }

  /// get users streams
  Stream<List<UserModel>> get allUsersStream {
    return usersCollection.snapshots()
        .map(_usersListFromSnapshot);
  }

  /// get user doc stream
  Stream<UserModel> get userData {
    return usersCollection.doc(userID).snapshots()
        .map(_userModelFromSnapshot);
  }

UserModel getUserModel(){
  Stream<DocumentSnapshot> docStream = usersCollection.doc(userID).snapshots();
  UserModel user;
  docStream.listen((DocumentSnapshot snap) {
    user = _userModelFromSnapshot(snap);
  });
  return user;
}

}
