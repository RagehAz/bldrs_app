import 'package:bldrs/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String userID;

  DatabaseService({this.userID});

  // collection reference
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData({
    String userID,
    List<dynamic> savedFlyersIDs,
    List<dynamic> followedBzzIDs,
    List<dynamic> publishedFlyersIDs, // maybe remove this initially and when user becomes author we create it for him ?
    String name,
    String pic,
    String title,
    String city,
    String country,
    bool whatsAppIsOn,
    // List<Map<String, Object>> contacts,
    GeoPoint position,
    // DateTime joinedAt,
    String gender,
    String language,
    int userStatus,
  }) async {
    return usersCollection.doc(userID).set({
      'userID'              : userID                ,
      'savedFlyersIDs'      : savedFlyersIDs        ,
      'followedBzzIDs'      : followedBzzIDs        ,
      'publishedFlyersIDs'  : publishedFlyersIDs    ,
      'name'                : name                  ,
      'pic'                 : pic                   ,
      'title'               : title                 ,
      'city'                : city                  ,
      'country'             : country               ,
      'whatsAppIsOn'        : whatsAppIsOn          ,
      // 'contacts'            : contacts              ,
      'position'            : position              ,
      // 'joinedAt'            : joinedAt              ,
      'gender'              : gender                ,
      'language'            : language              ,
      'userStatus'          : userStatus            ,
    });
  }

  // users list from snapshot
  List<UserModel> _usersListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      print(doc.data()['savedFlyersIDs']);
      List<dynamic> _savedFlyersIDs = doc.data()['savedFlyersIDs'] as List<dynamic>;
      List<dynamic> _followedBzzIDs = doc.data()['followedBzzIDs'] as List<dynamic>;
      List<dynamic> _publishedFlyersIDs = doc.data()['publishedFlyersIDs'] as List<dynamic>;
      return UserModel(
          userID              : doc.data()['userID']                  ?? '',
          savedFlyersIDs      : _savedFlyersIDs                       ?? [''],
          followedBzzIDs      : _followedBzzIDs                       ?? [''],
          publishedFlyersIDs  : _publishedFlyersIDs                   ?? [''],
          name                : doc.data()['name']                    ?? '',
          pic                 : doc.data()['pic']                     ?? '',
          title               : doc.data()['title']                   ?? '',
          city                : doc.data()['city']                    ?? '',
          country             : doc.data()['country']                 ?? '',
          whatsAppIsOn        : doc.data()['whatsAppIsOn']            ?? false,
          // contacts            : doc.data()['contacts']                ?? [{'type': '', 'value': '', 'show': false}],
          position            : doc.data()['position']                ?? GeoPoint(0, 0),
          // joinedAt            : doc.data()['joinedAt']                ?? DateTime.june,
          gender              : doc.data()['gender']                  ?? '',
          language            : doc.data()['language']                ?? '',
          userStatus          : doc.data()['userStatus']              ?? 1,
      );
    }).toList();
  }

  // get user streams
Stream<List<UserModel>> get userStream {
    return usersCollection.snapshots()
        .map(_usersListFromSnapshot);
}

}