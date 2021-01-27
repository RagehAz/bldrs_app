import 'package:bldrs/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider {
  final String userID;

  UserProvider({this.userID});

  /// collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData({
    String userID,
    List<dynamic> savedFlyersIDs,
    List<dynamic> followedBzzIDs,
    String name,
    String pic,
    String title,
    String city,
    String country,
    // List<Map<String, Object>> contacts,
    GeoPoint position,
    // DateTime joinedAt,
    String gender,
    String language,
    UserStatus userStatus,
  }) async {
    return await usersCollection.doc(userID).set({
      'userID'              : userID                ,
      'savedFlyersIDs'      : savedFlyersIDs        ,
      'followedBzzIDs'      : followedBzzIDs        ,
      'name'                : name                  ,
      'pic'                 : pic                   ,
      'title'               : title                 ,
      'city'                : city                  ,
      'country'             : country               ,
      // 'contacts'            : contacts              ,
      'position'            : position              ,
      // 'joinedAt'            : joinedAt              ,
      'gender'              : gender                ,
      'language'            : language              ,
      'userStatus'          : cipherUserStatus(userStatus)            ,
    });
  }

  /// users list from snapshot
  List<UserModel> _usersListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      // print(doc.data()['savedFlyersIDs']);
      List<dynamic> _savedFlyersIDs = doc.data()['savedFlyersIDs'] as List<dynamic>;
      List<dynamic> _followedBzzIDs = doc.data()['followedBzzIDs'] as List<dynamic>;
      List<dynamic> _publishedFlyersIDs = doc.data()['publishedFlyersIDs'] as List<dynamic>;
      return UserModel(
          userID              : doc.data()['userID']                  ?? '',
          savedFlyersIDs      : _savedFlyersIDs                       ?? [''],
          followedBzzIDs      : _followedBzzIDs                       ?? [''],
          name                : doc.data()['name']                    ?? '',
          pic                 : doc.data()['pic']                     ?? '',
          title               : doc.data()['title']                   ?? '',
          city                : doc.data()['city']                    ?? '',
          country             : doc.data()['country']                 ?? '',
          // contacts            : doc.data()['contacts']                ?? [{'type': '', 'value': '', 'show': false}],
          position            : doc.data()['position']                ?? GeoPoint(0, 0),
          // joinedAt            : doc.data()['joinedAt']                ?? DateTime.june,
          gender              : doc.data()['gender']                  ?? '',
          language            : doc.data()['language']                ?? '',
          userStatus          : decipherUserStatus(doc.data()['userStatus']?? 1),
      );
    }).toList();
  }

  /// UserModel from Snapshot
  UserModel _userModelFromSnapshot(DocumentSnapshot doc){
    List<dynamic> _savedFlyersIDs = doc.data()['savedFlyersIDs'] as List<dynamic>;
    List<dynamic> _followedBzzIDs = doc.data()['followedBzzIDs'] as List<dynamic>;
    List<dynamic> _publishedFlyersIDs = doc.data()['publishedFlyersIDs'] as List<dynamic>;
    return UserModel(
      userID              : doc.data()['userID']                  ?? '',
      savedFlyersIDs      : _savedFlyersIDs                       ?? [''],
      followedBzzIDs      : _followedBzzIDs                       ?? [''],
      name                : doc.data()['name']                    ?? '',
      pic                 : doc.data()['pic']                     ?? '',
      title               : doc.data()['title']                   ?? '',
      city                : doc.data()['city']                    ?? '',
      country             : doc.data()['country']                 ?? '',
      // contacts            : doc.data()['contacts']                ?? [{'type': '', 'value': '', 'show': false}],
      position            : doc.data()['position']                ?? GeoPoint(0, 0),
      // joinedAt            : doc.data()['joinedAt']                ?? DateTime.june,
      gender              : doc.data()['gender']                  ?? '',
      language            : doc.data()['language']                ?? '',
      userStatus          : decipherUserStatus(doc.data()['userStatus']?? 1),
    );
  }

  /// get user streams
Stream<List<UserModel>> get userStream {
    return usersCollection.snapshots()
        .map(_usersListFromSnapshot);
}

/// get user doc stream
Stream<UserModel> get userData {
    return usersCollection.doc(userID).snapshots()
        .map(_userModelFromSnapshot);
}

}