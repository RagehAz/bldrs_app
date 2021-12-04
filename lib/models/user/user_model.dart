import 'package:bldrs/controllers/drafters/atlas.dart' as Atlas;
import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/controllers/drafters/text_generators.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart';
import 'package:bldrs/db/fire/ops/user_ops.dart';
import 'package:bldrs/models/secondary_models/contact_model.dart';
import 'package:bldrs/models/user/fcm_token.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class UserModel {
  final String id;
  final AuthBy authBy;
  final DateTime createdAt;
  final UserStatus status;
  // -------------------------
  final String name;
  final List<String> trigram;
  final dynamic pic;
  final String title;
  final String company;
  final Gender gender; // should be both gender and name tittle Mr, Mrs, Ms, Dr, Eng, Arch, ...
  final ZoneModel zone;
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
    @required this.id,
    @required this.authBy,
    @required this.createdAt,
    @required this.status,
    // -------------------------
    @required this.name,
    @required this.trigram,
    @required this.pic,
    @required this.title,
    @required this.company,
    @required this.gender,
    @required this.zone,
    @required this.language,
    @required this.position,
    @required this.contacts,
    // -------------------------
    @required this.myBzzIDs,
    @required this.emailIsVerified,
    @required this.isAdmin,
    @required this.fcmToken,
    @required this.savedFlyersIDs,
    @required this.followedBzzIDs,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}){

    return <String, dynamic>{
      'id' : id,
      'authBy' : cipherAuthBy(authBy),
      'createdAt' : Timers.cipherTime(time: createdAt, toJSON: toJSON),
      'status' : cipherUserStatus(status),
// -------------------------
      'name' : name,
      'pic' : pic,
      'title' : title,
      'company' : company,
      'gender' : cipherGender(gender),
      'zone' : zone?.toMap(),
      'language' : language,
      'position' : Atlas.cipherGeoPoint(point: position, toJSON: toJSON),
      'contacts' : ContactModel.cipherContacts(contacts),
// -------------------------
      'myBzzIDs' : myBzzIDs ?? <String>[],
      'emailIsVerified' : emailIsVerified,
      'isAdmin': isAdmin,
      'fcmToken' : fcmToken?.toMap(toJSON: toJSON),
      'savedFlyersIDs' : savedFlyersIDs ?? <String>[],
      'followedBzzIDs' : followedBzzIDs ?? <String>[],
    };
  }
// -----------------------------------------------------------------------------
  static UserModel decipherUserMap({@required Map<String, dynamic> map, @required bool fromJSON}){

    return
      map == null ? null :
      UserModel(
        id : map['id'],
        authBy: decipherAuthBy(map['authBy']),
        createdAt : Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        status : decipherUserStatus(map['status']),
        // -------------------------
        name : map['name'],
        trigram: Mapper.getStringsFromDynamics(dynamics: map['trigram']),
        pic : map['pic'],
        title : map['title'],
        company : map['company'],
        gender : decipherGender(map['gender']),
        zone : ZoneModel.decipherZoneMap(map['zone']),
        language : map['language'] ?? 'en',
        position : Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
        contacts : ContactModel.decipherContacts(map['contacts']),
        // -------------------------
        myBzzIDs: Mapper.getStringsFromDynamics(dynamics: map['myBzzIDs']),
        emailIsVerified : map['emailIsVerified'],
        isAdmin: map['isAdmin'],
        fcmToken: FCMToken.decipherFCMToken(map: map['fcmToken'], fromJSON: fromJSON),
        savedFlyersIDs: Mapper.getStringsFromDynamics(dynamics: map['savedFlyersIDs']),
        followedBzzIDs: Mapper.getStringsFromDynamics(dynamics: map['followedBzzIDs']),
      );

  }
// -----------------------------------------------------------------------------
  static List<UserModel> decipherUsersMaps({@required List<Map<String, dynamic>> maps, @required bool fromJSON}){
    final List<UserModel> _users = <UserModel>[];

    if (Mapper.canLoopList(maps)){

      for (Map<String, dynamic> map in maps){

        _users.add(decipherUserMap(map: map, fromJSON: fromJSON));

      }

    }
    return _users;
  }
// -----------------------------------------------------------------------------
  static UserStatus decipherUserStatus (String status){
    switch (status){
      case 'normal'     :   return   UserStatus.normal      ;   break;
      case 'searching'  :   return   UserStatus.searching   ;   break;
      case 'finishing'  :   return   UserStatus.finishing   ;   break;
      case 'planning'   :   return   UserStatus.planning    ;   break;
      case 'building'   :   return   UserStatus.building    ;   break;
      case 'selling'    :   return   UserStatus.selling     ;   break;
      case 'bzAuthor'   :   return   UserStatus.bzAuthor    ;   break;
      case 'deactivated':   return   UserStatus.deactivated ;   break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherUserStatus (UserStatus status){
    switch (status){
      case UserStatus.normal              :  return 'normal'     ; break ;
      case UserStatus.searching           :  return 'searching'  ; break ;
      case UserStatus.finishing           :  return 'finishing'  ; break ;
      case UserStatus.planning            :  return 'planning'   ; break ;
      case UserStatus.building            :  return 'building'   ; break ;
      case UserStatus.selling             :  return 'selling'    ; break ;
      case UserStatus.bzAuthor            :  return 'bzAuthor'   ; break ;
      case UserStatus.deactivated         :  return 'deactivated'; break ;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static Gender decipherGender (String gender){
    switch (gender){
      case 'female':   return   Gender.female; break;
      case 'male':   return   Gender.male; break;
      case 'Gender.any':   return   Gender.any; break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherGender(Gender gender){
    switch (gender){
      case Gender.female  : return 'female' ; break ;
      case Gender.male    : return 'male'   ; break ;
      case Gender.any     : return 'any'    ; break ;
      default : return null;
    }
  }
// -----------------------------------------------------------------------------
  static AuthBy decipherAuthBy (String authBy){
    switch (authBy){
      case 'email'   :   return   AuthBy.email; break;
      case 'facebook':   return   AuthBy.facebook; break;
      case 'apple'   :   return   AuthBy.apple; break;
      case 'google'  :   return   AuthBy.google; break;
      default : return   AuthBy.Unknown;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherAuthBy(AuthBy authBy){
    switch (authBy){
      case AuthBy.email       : return 'email'    ;     break ;
      case AuthBy.facebook    : return 'facebook' ;     break ;
      case AuthBy.apple       : return 'apple'    ;     break ;
      case AuthBy.google      : return 'google'   ;     break ;
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
    UserStatus.normal,
    UserStatus.searching,
    UserStatus.finishing,
    UserStatus.planning,
    UserStatus.building,
    UserStatus.selling,
    UserStatus.bzAuthor,
    UserStatus.deactivated,
  ];
// -----------------------------------------------------------------------------
  static List<String> removeIDFromIDs(List<String> ids, String id){
    final int _idIndex = ids.indexWhere((String _id) => _id == id,);

    if (_idIndex != null){
      ids.removeAt(_idIndex);
      return ids;
    } else {
      return null;
    }

  }
// -----------------------------------------------------------------------------
  /// create user object based on firebase user
  static UserModel initializeUserModelStreamFromUser() {

    final User _user = superFirebaseUser();

    return
      _user == null ? null :
      UserModel(
        id: _user.uid,
        authBy: null,
        createdAt: DateTime.now(),
        status: UserStatus.normal,
        // -------------------------
        name: _user.displayName,
        trigram: TextGen.createTrigram(input: _user.displayName),
        pic: _user.photoURL,
        title: '',
        gender: Gender.any,
        zone: null,
        language: 'en',
        position: const GeoPoint(0, 0),
        contacts: <ContactModel>[],
        // -------------------------
        myBzzIDs: <String>[],
        emailIsVerified: _user.emailVerified,
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
    ZoneModel zone,
    AuthBy authBy,
  }) async {

    assert(!user.isAnonymous);
    print('createInitialUserModelFromUser : !_user.isAnonymous : ${!user.isAnonymous}');

    assert(await user.getIdToken() != null);
    print('createInitialUserModelFromUser : _user.getIdToken() != null : ${user.getIdToken() != null}');

    final UserModel _userModel = UserModel(
      id: user.uid,
      authBy: authBy,
      createdAt: DateTime.now(),
      status: UserStatus.normal,
      // -------------------------
      name: user.displayName,
      trigram: TextGen.createTrigram(input: user.displayName),
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

    if (userModel?.name == null || userModel?.name == ''){
      _missingFields.add('name');
    }

    if (userModel?.pic == null || userModel?.pic == ''){
      _missingFields.add('pic');
    }

    if (userModel?.title == null || userModel?.title == ''){
      _missingFields.add('title');
    }

    if (userModel?.company == null || userModel?.company == ''){
      _missingFields.add('company');
    }

    if (userModel?.zone?.countryID == null || userModel?.zone?.countryID == ''){
      _missingFields.add('country');
    }

    if (userModel?.zone?.cityID == null || userModel?.zone?.cityID == ''){
      _missingFields.add('city');
    }

    return _missingFields;
  }
// -----------------------------------------------------------------------------
  void printUserModel({String methodName = 'PRINTING USER MODEL'}){

    print('$methodName : ---------------- START -- ');

    print('id : $id');
    print('authBy : $authBy');
    print('createdAt : $createdAt');
    print('userStatus : $status');
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

    print('$methodName : ---------------- END -- ');

  }
// -----------------------------------------------------------------------------
  static Future<UserModel> dummyUserModel(BuildContext context) async {

    final UserModel _user = await UserFireOps.readUser(
      context: context,
      userID: '60a1SPzftGdH6rt15NF96m0j9Et2',
    );

    return _user;
  }
// -----------------------------------------------------------------------------
  static List<UserModel> dummyUsers({int numberOfUsers}){

    List<UserModel> _users = <UserModel>[
      // UserModel(
      //   authBy: AuthBy.email,
      //   trigram: TextMod.createTrigram(input: 'Ahmad Ali'),
      //
      //   name: 'Ahmad Ali',
      //   pic: Iconz.DumAuthorPic,
      //   userID: '1',
      //   title: 'CEO and Founder',
      // ),
      // const UserModel(
      //   name: 'Morgan Darwish',
      //   pic: Dumz.XXabohassan_author,
      //   userID: '2',
      //   title: 'Chairman',
      // ),
      // const UserModel(
      //   name: 'Zahi Fayez',
      //   pic: Dumz.XXzah_author,
      //   userID: '3',
      //   title: ' Marketing Director',
      // ),
      // const UserModel(
      //   name: 'Hani Wani',
      //   pic: Dumz.XXhs_author,
      //   userID: '4',
      //   title: 'Operations Manager',
      // ),
      // const UserModel(
      //   name: 'Nada Mohsen',
      //   pic: Dumz.XXmhdh_author,
      //   userID: '5',
      //   title: 'Planning and cost control engineer',
      // ),
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
  normal,
  searching,
  finishing,
  planning,
  building,
  selling,
  bzAuthor,
  deactivated,
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
