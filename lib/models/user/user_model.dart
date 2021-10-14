import 'package:bldrs/controllers/drafters/atlas.dart';
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/controllers/theme/dumz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/db/firestore/user_ops.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/fcm_token.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class UserModel {
  final String userID;
  final AuthBy authBy;
  final DateTime createdAt;
  final UserStatus userStatus;
  // -------------------------
  final String name;
  final dynamic pic;
  final String title;
  final String company;
  final Gender gender; // should be both gender and name tittle Mr, Mrs, Ms, Dr, Eng, Arch, ...
  final Zone zone;
  final String language;
  final GeoPoint position;
  final List<ContactModel> contacts;
  // -------------------------
  final List<String> myBzzIDs;
  final bool emailIsVerified;
  final bool isAdmin;
  final FCMToken fcmToken;
  final List<String> savedFlyersIDs;
  final List<String> followedBzzIDs;
// ###############################
  const UserModel({
    this.userID,
    this.authBy,
    this.createdAt,
    this.userStatus,
    // -------------------------
    this.name,
    this.pic,
    this.title,
    this.company,
    this.gender,
    this.zone,
    this.language,
    this.position,
    this.contacts,
    // -------------------------
    this.myBzzIDs,
    this.emailIsVerified,
    this.isAdmin,
    this.fcmToken,
    this.savedFlyersIDs,
    this.followedBzzIDs,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){

    return {
      'userID' : userID,
      'authBy' : cipherAuthBy(authBy),
      'createdAt' : Timers.cipherTime(time: createdAt, toJSON: toJSON),
      'userStatus' : cipherUserStatus(userStatus),
// -------------------------
      'name' : name,
      'pic' : pic,
      'title' : title,
      'company' : company,
      'gender' : cipherGender(gender),
      'zone' : zone.toMap(),
      'language' : language,
      'position' : Atlas.cipherGeoPoint(point: position, toJSON: toJSON),
      'contacts' : ContactModel.cipherContactsModels(contacts),
// -------------------------
      'myBzzIDs' : myBzzIDs,
      'emailIsVerified' : emailIsVerified,
      'isAdmin': isAdmin,
      'fcmToken' : fcmToken.toMap(toJSON: toJSON),
      'savedFlyersIDs' : savedFlyersIDs,
      'followedBzzIDs' : followedBzzIDs,
    };
  }
// -----------------------------------------------------------------------------
  static UserModel decipherUserMap({@required Map<String, dynamic> map, @required bool fromJSON}){

    return
      map == null ? null :
      UserModel(
        userID : map['userID'] ?? '',
        authBy: decipherAuthBy(map['authBy'] ?? 0),
        createdAt : Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        userStatus : decipherUserStatus(map['userStatus'] ?? 1),
        // -------------------------
        name : map['name'] ?? '',
        pic : map['pic'] ?? '',
        title : map['title'] ?? '',
        company : map['company'] ?? '',
        gender : decipherGender(map['gender'] ?? 2),
        zone : Zone.decipherZoneMap(map['zone']) ?? '',
        language : map['language'] ?? 'en',
        position : Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
        contacts : ContactModel.decipherContactsMaps(map['contacts'] ?? []),
        // -------------------------
        myBzzIDs: Mapper.getStringsFromDynamics(dynamics: map['myBzzIDs']),
        emailIsVerified : map['emailIsVerified'],
        isAdmin: map['isAdmin'],
        fcmToken: FCMToken.decipherFCMToken(map: map['fcmToken'], fromJSON: fromJSON),
        savedFlyersIDs: map['savedFlyersIDs'],
        followedBzzIDs: map['followedBzzIDs'],
      );

  }
// -----------------------------------------------------------------------------
  static List<UserModel> decipherUsersMaps({@required List<dynamic> maps, @required bool fromJSON}){
    final List<UserModel> _users = <UserModel>[];

    if (Mapper.canLoopList(maps)){

      for (var map in maps){

        _users.add(decipherUserMap(map: map, fromJSON: fromJSON));

      }

    }
    return _users;
  }
// -----------------------------------------------------------------------------
  static UserStatus decipherUserStatus (int userStatus){
    switch (userStatus){
      case 1:   return   UserStatus.Normal;                 break;
      case 2:   return   UserStatus.SearchingThinking;      break;
      case 3:   return   UserStatus.Finishing;              break;
      case 4:   return   UserStatus.PlanningTalking;        break;
      case 5:   return   UserStatus.Building;               break;
      case 6:   return   UserStatus.Selling;                break;
      case 7:   return   UserStatus.BzAuthor;               break;
      case 8:   return   UserStatus.Deactivated;            break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherUserStatus (UserStatus userStatus){
    switch (userStatus){
      case UserStatus.Normal              :  return 1; break ;
      case UserStatus.SearchingThinking   :  return 2; break ;
      case UserStatus.Finishing           :  return 3; break ;
      case UserStatus.PlanningTalking     :  return 4; break ;
      case UserStatus.Building            :  return 5; break ;
      case UserStatus.Selling             :  return 6; break ;
      case UserStatus.BzAuthor            :  return 7; break ;
      case UserStatus.Deactivated         :  return 8; break ;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static Gender decipherGender (int gender){
    switch (gender){
      case 0:   return   Gender.female; break;
      case 1:   return   Gender.male; break;
      case 2:   return   Gender.any; break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherGender(Gender gender){
    switch (gender){
      case Gender.female : return 0; break ;
      case Gender.male : return 1; break ;
      case Gender.any : return 2; break ;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static AuthBy decipherAuthBy (int authBy){
    switch (authBy){
      case 0:   return   AuthBy.email; break;
      case 1:   return   AuthBy.facebook; break;
      case 2:   return   AuthBy.apple; break;
      case 3:   return   AuthBy.google; break;
      default : return   AuthBy.Unknown;
    }
  }
// -----------------------------------------------------------------------------
  static int cipherAuthBy(AuthBy authBy){
    switch (authBy){
      case AuthBy.email       : return 0; break ;
      case AuthBy.facebook    : return 1; break ;
      case AuthBy.apple       : return 2; break ;
      case AuthBy.google      : return 3; break ;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static bool userIsAuthor(UserModel userModel){
    bool _userIsAuthor = false;

    if (userModel != null && Mapper.canLoopList(userModel?.myBzzIDs)){
      _userIsAuthor = true;
    }

    return
      _userIsAuthor;
  }
// -----------------------------------------------------------------------------
  static const List<UserStatus> userTypesList = const <UserStatus>[
    UserStatus.Normal,
    UserStatus.SearchingThinking,
    UserStatus.Finishing,
    UserStatus.PlanningTalking,
    UserStatus.Building,
    UserStatus.Selling,
    UserStatus.BzAuthor,
    UserStatus.Deactivated,
  ];
// -----------------------------------------------------------------------------
  static List<String> removeIDFromIDs(List<String> ids, String id){
    final int _idIndex = ids.indexWhere((_id) => _id == id,);

    if (_idIndex != null){
      ids.removeAt(_idIndex);
      return ids;
    } else {
      return null;
    }

  }
// -----------------------------------------------------------------------------
  /// create user object based on firebase user
  static UserModel initializeUserModelStreamFromUser(User user) {

    return
      user == null ? null :
      UserModel(
        userID: user.uid,
        authBy: null,
        createdAt: DateTime.now(),
        userStatus: UserStatus.Normal,
        // -------------------------
        name: user.displayName,
        pic: user.photoURL,
        title: '',
        gender: Gender.any,
        zone: null,
        language: 'en',
        position: GeoPoint(0, 0),
        contacts: <ContactModel>[],
        // -------------------------
        myBzzIDs: <String>[],
        emailIsVerified: user.emailVerified,
        isAdmin: false,
        fcmToken: null,
        company: null,
        savedFlyersIDs: <String>[],
        followedBzzIDs: <String>[],
      );

  }
// -----------------------------------------------------------------------------
  static Future<UserModel> createInitialUserModelFromUser({
    BuildContext context,
    User user,
    Zone zone,
    AuthBy authBy,
  }) async {

    assert(!user.isAnonymous);
    print('createInitialUserModelFromUser : !_user.isAnonymous : ${!user.isAnonymous}');

    assert(await user.getIdToken() != null);
    print('createInitialUserModelFromUser : _user.getIdToken() != null : ${user.getIdToken() != null}');


    final UserModel _userModel = UserModel(
      userID: user.uid,
      authBy: authBy,
      createdAt: DateTime.now(),
      userStatus: UserStatus.Normal,
      // -------------------------
      name: user.displayName,
      pic: user.photoURL,
      title: '',
      gender: Gender.any,
      zone: zone,
      language: '',//Wordz.languageCode(context),
      position: null,
      contacts: ContactModel.getContactsFromFirebaseUser(user),
      // -------------------------
      myBzzIDs: <String>[],
      emailIsVerified: user.emailVerified,
      isAdmin: false,
      company: null,
      fcmToken: null,
      savedFlyersIDs: <String>[],
      followedBzzIDs: <String>[],
    );

    _userModel.printUserModel(methodName: 'createInitialUserModelFromUser');

    return _userModel;
}
// -----------------------------------------------------------------------------
  static List<String> missingFields(UserModel userModel){
    final List<String> _missingFields = <String>[];

    if (userModel?.name == null || userModel?.name == ''){_missingFields.add('name');}
    if (userModel?.pic == null || userModel?.pic == ''){_missingFields.add('pic');}
    if (userModel?.title == null || userModel?.title == ''){_missingFields.add('title');}
    if (userModel?.company == null || userModel?.company == ''){_missingFields.add('company');}
    if (userModel?.zone?.countryID == null || userModel?.zone?.countryID == ''){_missingFields.add('country');}
    if (userModel?.zone?.cityID == null || userModel?.zone?.cityID == ''){_missingFields.add('city');}

    return _missingFields;
  }
// -----------------------------------------------------------------------------
  void printUserModel({@required String methodName}){

    print('$methodName : PRINTING USER MODEL ---------------- START -- ');

    print('userID : $userID');
    print('authBy : $authBy');
    print('createdAt : $createdAt');
    print('userStatus : $userStatus');
    print('name : $name');
    print('pic : $pic');
    print('title : $title');
    print('company : $company');
    print('gender : $gender');
    print('zone : $zone');
    print('language : $language');
    print('position : $position');
    print('contacts : $contacts');
    print('myBzzIDs : $myBzzIDs');
    print('emailIsVerified : $emailIsVerified');
    print('fcmToken : ${fcmToken?.createdAt}');

    print('$methodName : PRINTING USER MODEL ---------------- END -- ');

  }
// -----------------------------------------------------------------------------
  static Future<UserModel> dummyUserModel(BuildContext context) async {

    final UserModel _user = await UserOps.readUserOps(
      context: context,
      userID: '60a1SPzftGdH6rt15NF96m0j9Et2',
    );

    return _user;
  }
// -----------------------------------------------------------------------------
  static List<UserModel> dummyUsers({int numberOfUsers}){

    List<UserModel> _users = const <UserModel>[
      const UserModel(
        name: 'Ahmad Ali',
        pic: Iconz.DumAuthorPic,
        userID: '1',
        title: 'CEO and Founder',
      ),
      const UserModel(
        name: 'Morgan Darwish',
        pic: Dumz.XXabohassan_author,
        userID: '2',
        title: 'Chairman',
      ),
      const UserModel(
        name: 'Zahi Fayez',
        pic: Dumz.XXzah_author,
        userID: '3',
        title: ' Marketing Director',
      ),
      const UserModel(
        name: 'Hani Wani',
        pic: Dumz.XXhs_author,
        userID: '4',
        title: 'Operations Manager',
      ),
      const UserModel(
        name: 'Nada Mohsen',
        pic: Dumz.XXmhdh_author,
        userID: '5',
        title: 'Planning and cost control engineer',
      ),
    ];

    if (numberOfUsers != null){
      final List<int> _randomIndexes = Numeric.getRandomIndexes(numberOfIndexes: numberOfUsers, maxIndex: _users.length - 1);
      final List<UserModel> _finalList = <UserModel>[];

      for (int i = 0; i < _randomIndexes.length; i++){
        _finalList.add(_users[_randomIndexes[i]]);
      }

      _users = _finalList;
    }

    return _users;
  }
// -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
enum UserStatus {
  Normal,
  SearchingThinking,
  Finishing,
  PlanningTalking,
  Building,
  Selling,
  BzAuthor,
  Deactivated,
}
// -----------------------------------------------------------------------------
enum Gender {
  male,
  female,
  any,
}
// -----------------------------------------------------------------------------
enum AuthBy {
  email,
  facebook,
  google,
  apple,
  Unknown,
}
// -----------------------------------------------------------------------------
