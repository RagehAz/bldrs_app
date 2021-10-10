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
  final List<dynamic> myBzzIDs;
  final bool emailIsVerified;
  final bool isAdmin;
  final FCMToken fcmToken;
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
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'authBy' : cipherAuthBy(authBy),
      'createdAt' : createdAt,
      'userStatus' : cipherUserStatus(userStatus),
// -------------------------
      'name' : name,
      'pic' : pic,
      'title' : title,
      'company' : company,
      'gender' : cipherGender(gender),
      'zone' : zone.toMap(),
      'language' : language,
      'position' : position,
      'contacts' : ContactModel.cipherContactsModels(contacts),
// -------------------------
      'myBzzIDs' : myBzzIDs,
      'emailIsVerified' : emailIsVerified,
      'isAdmin': isAdmin,
      'fcmToken' : fcmToken.toMap(),
    };
  }
// -----------------------------------------------------------------------------
  static UserModel decipherUserMap(Map<String, dynamic> map){

    // List<dynamic> _myBzzIDs = map['myBzzIDs'] ?? [];

    return
      map == null ? null :
      UserModel(
        userID : map['userID'] ?? '',
        authBy: decipherAuthBy(map['authBy'] ?? 0),
        createdAt : map['createdAt'].toDate() ?? null,
        userStatus : decipherUserStatus(map['userStatus'] ?? 1),
        // -------------------------
        name : map['name'] ?? '',
        pic : map['pic'] ?? '',
        title : map['title'] ?? '',
        company : map['company'] ?? '',
        gender : decipherGender(map['gender'] ?? 2),
        zone : Zone.decipherZoneMap(map['zone']) ?? '',
        language : map['language'] ?? 'en',
        position : map['position'] ?? GeoPoint(0, 0),
        contacts : ContactModel.decipherContactsMaps(map['contacts'] ?? []),
        // -------------------------
        myBzzIDs: map['myBzzIDs'],
        emailIsVerified : map['emailIsVerified'],
        isAdmin: map['isAdmin'],
        fcmToken: FCMToken.decipherFCMToken(map['fcmToken']),
      );

  }
// -----------------------------------------------------------------------------
  static List<UserModel> decipherUsersMaps(List<dynamic> maps){
    final List<UserModel> _users = <UserModel>[];

    if (maps != null && maps.length != 0){

      for (var map in maps){

        _users.add(decipherUserMap(map));

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

    if (userModel != null && userModel.myBzzIDs != null && userModel.myBzzIDs.length > 0){
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
  static List<dynamic> removeBzIDFromMyBzzIDs(List<dynamic> myBzzIDs, String bzID){
    final int _bzIndex = myBzzIDs.indexWhere((id) => id == bzID,);

    if (_bzIndex != null){
      myBzzIDs.removeAt(_bzIndex);
      return myBzzIDs;
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
    if (userModel?.zone?.cityID == null || userModel?.zone?.cityID == ''){_missingFields.add('province');}

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

    final UserModel _user = await UserOps().readUserOps(
      context: context,
      userID: '60a1SPzftGdH6rt15NF96m0j9Et2',
    );

    return _user;
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
