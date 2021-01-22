import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bldrs/ambassadors/services/database.dart';
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

/// any changes in this model should reflect on this [DatabaseService]
class UserModel {
  final String userID;
  /// should we save a List<String> savedFlyersIDs or List<MoFlyer> savedFlyers 3alatool
  List<dynamic> savedFlyersIDs;
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
  List<dynamic> followedBzzIDs;

  /// for the user in case became author to a bz, and to be called in flyer when
  /// showing the bzGallery of authors flyers
  /// if the user is not author, this will always be empty list,, which is stupid
  /// a3mel eh ?
  List<dynamic> publishedFlyersIDs;
  final String name;
  final String pic;
  final String title;
  final String city;
  final String country;
  final bool whatsAppIsOn;
  // /// same as [bzContacts] in [BzDocument]
  // final List<Map<String, Object>> contacts;
  final GeoPoint position;
  // final DateTime joinedAt;
  final String gender;
  final String language;
  final int userStatus;


  UserModel({
    this.userID,
    this.savedFlyersIDs,
    this.followedBzzIDs,
    this.publishedFlyersIDs,
    this.name,
    this.pic,
    this.title,
    this.city,
    this.country,
    this.whatsAppIsOn,
    // this.contacts,
    this.position,
    // this.joinedAt,
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
// ignore: unused_element
List<Map<String,Object>> _bzContactsSample = [
  {'type' : 'whatsapp'  , 'value' : '01554555107'             , 'show' : true    },
  {'type' : 'email'     , 'value' : 'rageh-@hotmail.com'      , 'show' : true    },
  {'type' : 'website'   , 'value' : 'bldrs.net'               , 'show' : true    },
  {'type' : 'facebook'  , 'value' : 'www.facebook.com/rageh'  , 'show' : true    },
  {'type' : 'twitter'   , 'value' : 'www.twitter.com/rageh'   , 'show' : true    },
  {'type' : 'linkedIn'  , 'value' : 'www.linkedIn.com/rageh'  , 'show' : true    },
  {'type' : 'pinterest' , 'value' : 'www.pinterest.com/rageh' , 'show' : false   },
  {'type' : 'tiktok'    , 'value' : 'www.tiktok.com/rageh'    , 'show' : false   },
  {'type' : 'instagram' , 'value' : 'www.instagram.com/rageh' , 'show' : true    },
  {'type' : 'snapchat'  , 'value' : 'www.snapchat.com/rageh'  , 'show' : false   },
  {'type' : 'email'     , 'value' : 'rageh.az@gmail.com'      , 'show' : true    },
  {'type' : 'phone'     , 'value' : '07775000'                , 'show' : true    },
  {'type' : '3afreet'   , 'value' : 'www.3afreet.com/rageh'   , 'show' : false   },
];
// ---------------------------------------------------------------------------
