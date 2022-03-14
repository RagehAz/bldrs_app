import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/fcm_token.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/f_helpers/drafters/atlas.dart' as Atlas;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
class UserModel {
  /// --------------------------------------------------------------------------
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
  /// --------------------------------------------------------------------------
  final String id;
  final AuthType authBy;
  final DateTime createdAt;
  final UserStatus status;
  // -------------------------
  final String name;
  final List<String> trigram;
  final dynamic pic;
  final String title;
  final String company;
  final Gender gender;
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
  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }) {
    return <String, dynamic>{
      'id': id,
      'authBy': AuthModel.cipherAuthBy(authBy),
      'createdAt': Timers.cipherTime(time: createdAt, toJSON: toJSON),
      'status': cipherUserStatus(status),
// -------------------------
      'name': name,
      'pic': pic,
      'title': title,
      'company': company,
      'gender': cipherGender(gender),
      'zone': zone?.toMap(),
      'language': language,
      'position': Atlas.cipherGeoPoint(point: position, toJSON: toJSON),
      'contacts': ContactModel.cipherContacts(contacts),
// -------------------------
      'myBzzIDs': myBzzIDs ?? <String>[],
      'emailIsVerified': emailIsVerified,
      'isAdmin': isAdmin,
      'fcmToken': fcmToken?.toMap(toJSON: toJSON),
      'savedFlyersIDs': savedFlyersIDs ?? <String>[],
      'followedBzzIDs': followedBzzIDs ?? <String>[],
    };
  }
// ----------------------------------------------------------------------------
  static UserModel decipherUserMap({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }) {
    return map == null ? null :
    UserModel(
      id: map['id'],
      authBy: AuthModel.decipherAuthBy(map['authBy']),
      createdAt:
      Timers.decipherTime(
          time: map['createdAt'],
          fromJSON: fromJSON
      ),
      status: decipherUserStatus(map['status']),
      // -------------------------
      name: map['name'],
      trigram: Mapper.getStringsFromDynamics(
          dynamics: map['trigram'],
      ),
      pic: map['pic'],
      title: map['title'],
      company: map['company'],
      gender: decipherGender(map['gender']),
      zone: ZoneModel.decipherZoneMap(map['zone']),
      language: map['language'] ?? 'en',
      position: Atlas.decipherGeoPoint(
          point: map['position'],
          fromJSON: fromJSON
      ),
      contacts: ContactModel.decipherContacts(map['contacts']),
      // -------------------------
      myBzzIDs: Mapper.getStringsFromDynamics(
          dynamics: map['myBzzIDs'],
      ),
      emailIsVerified: map['emailIsVerified'],
      isAdmin: map['isAdmin'],
      fcmToken: FCMToken.decipherFCMToken(
          map: map['fcmToken'],
          fromJSON: fromJSON,
      ),
      savedFlyersIDs: Mapper.getStringsFromDynamics(
          dynamics: map['savedFlyersIDs'],
      ),
      followedBzzIDs: Mapper.getStringsFromDynamics(
          dynamics: map['followedBzzIDs'],
      ),
    );

  }
// -----------------------------------------------------------------------------
  static List<UserModel> decipherUsersMaps({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<UserModel> _users = <UserModel>[];

    if (Mapper.canLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {
        _users.add(decipherUserMap(
            map: map,
            fromJSON: fromJSON
        )
        );
      }
    }

    return _users;
  }
// -----------------------------------------------------------------------------
  static UserStatus decipherUserStatus(String status) {
    switch (status) {
      case 'normal':      return UserStatus.normal;       break;
      case 'searching':   return UserStatus.searching;    break;
      case 'finishing':   return UserStatus.finishing;    break;
      case 'planning':    return UserStatus.planning;     break;
      case 'building':    return UserStatus.building;     break;
      case 'selling':     return UserStatus.selling;      break;
      case 'bzAuthor':    return UserStatus.bzAuthor;     break;
      case 'deactivated': return UserStatus.deactivated;  break;
      default :           return null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherUserStatus(UserStatus status) {
    switch (status) {
      case UserStatus.normal:       return 'normal';      break;
      case UserStatus.searching:    return 'searching';   break;
      case UserStatus.finishing:    return 'finishing';   break;
      case UserStatus.planning:     return 'planning';    break;
      case UserStatus.building:     return 'building';    break;
      case UserStatus.selling:      return 'selling';     break;
      case UserStatus.bzAuthor:     return 'bzAuthor';    break;
      case UserStatus.deactivated:  return 'deactivated'; break;
      default:
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static const List<Gender> gendersList = <Gender>[
    Gender.male,
    Gender.female,
    Gender.other,
  ];
// -----------------------------------------------------------------------------
  static String translateGender(Gender gender) {
    switch (gender) {
      case Gender.female:   return 'Female';    break;
      case Gender.male:     return 'Male';      break;
      case Gender.other:    return 'Other';     break;
      default:              return null;
    }
  }
// -----------------------------------------------------------------------------
  static Gender decipherGender(String gender) {
    switch (gender) {
      case 'female' :   return Gender.female; break;
      case 'male'   :   return Gender.male;   break;
      case 'other'    :   return Gender.other;    break;
      default:return null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherGender(Gender gender) {
    switch (gender) {
      case Gender.female:   return 'female';    break;
      case Gender.male:     return 'male';      break;
      case Gender.other:    return 'other';     break;
      default:              return null;
    }
  }
// -----------------------------------------------------------------------------
  static bool userIsAuthor(UserModel userModel) {
    bool _userIsAuthor = false;

    if (userModel != null && Mapper.canLoopList(userModel?.myBzzIDs)) {
      _userIsAuthor = true;
    }

    return _userIsAuthor;
  }
// -----------------------------------------------------------------------------
  static const List<UserStatus> userTypesList = <UserStatus>[
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
  static List<String> removeIDFromIDs(List<String> ids, String id) {
    final int _idIndex = ids.indexWhere((String _id) => _id == id,);

    if (_idIndex != null) {
      ids.removeAt(_idIndex);
      return ids;
    }

    else {
      return null;
    }

  }
// -----------------------------------------------------------------------------
  /// create user object based on firebase user
  static UserModel initializeUserModelStreamFromUser() {
    final User _user = FireAuthOps.superFirebaseUser();

    return _user == null ? null :
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
      gender: Gender.other,
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
    AuthType authBy,
  }) async {

    assert(!user.isAnonymous, 'user must not be anonymous');
    blog('createInitialUserModelFromUser : !_user.isAnonymous : ${!user.isAnonymous}');

    assert(await user.getIdToken() != null, 'user token must not be null');
    blog('createInitialUserModelFromUser : _user.getIdToken() != null : ${user.getIdToken() != null}');

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
      gender: Gender.other,
      zone: zone,
      language: '', //Wordz.languageCode(context),
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

    _userModel.blogUserModel(methodName: 'createInitialUserModelFromUser');

    return _userModel;
  }
// -----------------------------------------------------------------------------
  static List<String> missingFields(UserModel userModel) {
    final List<String> _missingFields = <String>[];

    /*
    -> NOT required : status,
    -> NOT required : position,
    -> NOT required : contacts,
    -> NOT required : myBzzIDs,
    -> NOT required : savedFlyersIDs,
    -> NOT required : followedBzzIDs,
    ---------------------------------->
    -> generated : id,
    -> generated : authBy,
    -> generated : createdAt,
    -> generated : trigram,
    -> generated : language,
    -> generated : emailIsVerified,
    -> generated : isAdmin,
    -> generated : fcmToken,
    ---------------------------------->
    -> required : name,
    -> required : pic,
    -> required : title,
    -> required : company,
    -> required : gender,
    -> required : zone,
    ---------------------------------->
    */

    if (stringIsEmpty(userModel?.name) == true) {
      _missingFields.add('Name');
    }

    if (userModel?.pic == null) {
      _missingFields.add('Picture');
    }

    if (stringIsEmpty(userModel?.title) == true) {
      _missingFields.add('Job Title');
    }

    if (stringIsEmpty(userModel?.company) == true) {
      _missingFields.add('Company');
    }

    if (userModel?.gender == null) {
      _missingFields.add('Gender');
    }

    if (stringIsEmpty(userModel?.zone?.countryID) == true) {
      _missingFields.add('Country');
    }

    if (stringIsEmpty(userModel?.zone?.cityID) == true) {
      _missingFields.add('City');
    }

    return _missingFields;
  }
// -----------------------------------------------------------------------------
  static bool thereAreMissingFields(UserModel userModel){
    bool _thereAreMissingFields;

    final List<String> _missingFields = UserModel.missingFields(userModel);

    if (Mapper.canLoopList(_missingFields) == true){
      _thereAreMissingFields = true;
    }

    else {
      _thereAreMissingFields = false;
    }

    return _thereAreMissingFields;
  }
// -----------------------------------------------------------------------------
  void blogUserModel({String methodName = 'PRINTING USER MODEL'}) {
    blog('$methodName : ---------------- START -- ');

    blog('id : $id');
    blog('authBy : $authBy');
    blog('createdAt : $createdAt');
    blog('userStatus : $status');
    blog('name : $name');
    blog('pic : $pic');
    blog('title : $title');
    blog('company : $company');
    blog('gender : $gender');
    zone.blogZone();
    blog('language : $language');
    blog('position : $position');
    ContactModel.blogContacts(contacts);
    blog('myBzzIDs : $myBzzIDs');
    blog('emailIsVerified : $emailIsVerified');
    blog('fcmToken : ${fcmToken?.createdAt}');

    blog('$methodName : ---------------- END -- ');
  }
// -----------------------------------------------------------------------------
  static Future<UserModel> futureDummyUserModel(BuildContext context) async {

    final UserModel _user = await UserFireOps.readUser(
      context: context,
      userID: '60a1SPzftGdH6rt15NF96m0j9Et2',
    );

    return _user;
  }
// -----------------------------------------------------------------------------
  static UserModel dummyUserModel(BuildContext context){

    final UserModel _userModel = UserModel(
        id: 'dummy_user_model',
        authBy: AuthType.emailSignIn,
        createdAt: Timers.createDate(year: 1987, month: 06, day: 10),
        status: UserStatus.normal,
        name: 'Donald duck',
        trigram: <String>[],
        pic: Iconz.dvDonaldDuck,
        title: 'CEO',
        company: 'Bldrs.LLC',
        gender: Gender.male,
        zone: ZoneModel.dummyZone(),
        language: 'en',
        position: Atlas.dummyPosition(),
        contacts: ContactModel.dummyContacts(),
        myBzzIDs: <String>[],
        emailIsVerified: true,
        isAdmin: true,
        fcmToken: null,
        savedFlyersIDs: <String>[],
        followedBzzIDs: <String>[],
    );

    return _userModel;
  }
// -----------------------------------------------------------------------------
  static List<UserModel> dummyUsers({
    int numberOfUsers
  }) {

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

    if (numberOfUsers != null) {

      final List<int> _randomIndexes = Numeric.getRandomIndexes(
          numberOfIndexes: numberOfUsers,
          maxIndex: _users.length - 1,
      );

      final List<UserModel> _finalList = <UserModel>[];

      for (int i = 0; i < _randomIndexes.length; i++) {
        _finalList.add(_users[_randomIndexes[i]]);
      }

      _users = _finalList;
    }

    return _users;
  }
// -----------------------------------------------------------------------------
  static String userJobLine(UserModel userModel){
    return '${userModel.title} @ ${userModel.company}';
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
  other,
}
// -----------------------------------------------------------------------------
enum UserTab {
  profile,
  status,
  notifications,
  following,
}
// -----------------------------------------------------------------------------
List<UserTab> userProfileTabsList = <UserTab>[
  UserTab.profile,
  UserTab.status,
  UserTab.notifications,
  UserTab.following,
];
// -----------------------------------------------------------------------------
/// CAUTION : THIS HAS TO REMAIN IN ENGLISH ONLY WITH NO TRANSLATIONS
String cipherUserTabInEnglishOnly(UserTab userTab){
  /// BECAUSE THESE VALUES ARE USED IN WIDGETS KEYS
  switch(userTab){
    case UserTab.profile        : return  'Profile'       ; break;
    case UserTab.status         : return  'Status'        ; break;
    case UserTab.notifications  : return  'Notifications' ; break;
    case UserTab.following      : return  'Following'     ; break;
    default: return null;
  }
}
// -----------------------------------------------------------------------------
int getUserTabIndex(UserTab userTab){
  final int _index = userProfileTabsList.indexWhere((tab) => tab == userTab);
  return _index;
}
// -----------------------------------------------------------------------------
