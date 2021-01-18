import 'package:cloud_firestore/cloud_firestore.dart';
// ---------------------------------------------------------------------------

// class UserModel{
//   final String iD;
//   final String name;
//   final String pic;
//   final String title;
//   final String city;
//   final String country;
//   final bool userWhatsAppIsOn;
//
//   UserModel({
//     @required this.iD,
//     @required this.name,
//     @required this.pic,
//     @required this.title,
//     @required this.city,
//     @required this.country,
//     this.userWhatsAppIsOn,
// });
// }
// ---------------------------------------------------------------------------
class UserModel {
  final String iD;
  /// should we save a List<String> savedFlyersIDs or List<MoFlyer> savedFlyers 3alatool
  List<String> savedFlyersIDs;
  /// should we save a List<String> followedBzIDs or List<MoBz> followedBzz 3alatool
  /// take care,, if 1000 people saved a single flyer,, this flyer's data will occupy db storage space
  /// totalStorage = (flyerDataSizeInBytes * n) where n is number of saves
  /// which is a77a,, what if n is 15'000 for 1000 flyers,, mat2olleesh ye7ellaha 7allal
  /// or u will have much money in future these are not valid points
  /// for value-engineering sake,, we only save savedFlyersIDs and same goes with followedBzIDs
  /// and when the user opens the app from the start, we fetch them while opening the app and
  /// this initial startup fetch should be called
  /// the INITIALFETCH
  ///
  /// can as well be store like this [userFollowsMaps]
  List<String> followedBzzIDs;

  /// for the user in case became author to a bz, and to be called in flyer when
  /// showing the bzGallery of authors flyers
  /// if the user is not author, this will always be empty list,, which is stupid
  /// a3mel eh ?
  List<String> publishedFlyersIDs;
  final String name;
  final String lastName;
  final String pic;
  final String title;
  final String city;
  final String country;
  final bool whatsAppIsOn;
  /// same as [bzContacts] in [BzDocument]
  final List<Map<String, Object>> contacts;
  final GeoPoint position;
  final DateTime joinedAt;
  final String gender;
  final String language;
  final int userStatus;


  UserModel({
    this.iD,
    this.savedFlyersIDs,
    this.followedBzzIDs,
    this.publishedFlyersIDs,
    this.name,
    this.lastName,
    this.pic,
    this.title,
    this.city,
    this.country,
    this.whatsAppIsOn,
    this.contacts,
    this.position,
    this.joinedAt,
    this.gender,
    this.language,
    this.userStatus,
  });
}
// ---------------------------------------------------------------------------
/// to save the time and current state,,
/// but we should simple delete the map when unfollowed,, why keep it,,
/// for statistical reasons,, to monitor the life cycle of the user in the app
List<Map<String,Object>> userFollowsMaps = [
  {'bzID' : ''  ,'followTime' : ''  ,'followState' : 'following'  ,'unFollowTime' : ''},
  {'bzID' : ''  ,'followTime' : ''  ,'followState' : 'unFollowed' ,'unFollowTime' : ''},
];
// ---------------------------------------------------------------------------
