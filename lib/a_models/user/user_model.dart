import 'package:bldrs/a_models/secondary_models/app_state.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/fcm_token.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
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
    @required this.location,
    @required this.contacts,
    // -------------------------
    @required this.myBzzIDs,
    @required this.emailIsVerified,
    @required this.isAdmin,
    @required this.fcmToken,
    @required this.savedFlyersIDs,
    @required this.followedBzzIDs,
    @required this.appState,
    this.docSnapshot,
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
  final GeoPoint location;
  final List<ContactModel> contacts;
  // -------------------------
  final List<String> myBzzIDs;
  final bool emailIsVerified;
  final bool isAdmin;
  final FCMToken fcmToken;
  final List<String> savedFlyersIDs;
  final List<String> followedBzzIDs;
  final AppState appState;
  final DocumentSnapshot docSnapshot;

// -----------------------------------------------------------------------------

  /// INITIALIZATION

// -----------------------------------
  /// create user object based on firebase user
  static UserModel initializeUserModelStreamFromUser() {
    final User _user = AuthFireOps.superFirebaseUser();

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
      gender: Gender.male,
      zone: null,
      language: 'en',
      location: const GeoPoint(0, 0),
      contacts: <ContactModel>[],
      // -------------------------
      myBzzIDs: <String>[],
      emailIsVerified: _user.emailVerified,
      isAdmin: false,
      fcmToken: null,
      company: null,
      savedFlyersIDs: <String>[],
      followedBzzIDs: <String>[],
      appState: AppState.initialState(),
    );
  }
// -----------------------------------------------------------------------------
  static Future<UserModel> createInitialUserModelFromUser({
    @required BuildContext context,
    @required User user,
    @required ZoneModel zone,
    @required AuthType authBy,
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
      gender: Gender.male,
      zone: zone,
      language: '', //Wordz.languageCode(context),
      location: null,
      contacts: ContactModel.getContactsFromFirebaseUser(user),
      // -------------------------
      myBzzIDs: <String>[],
      emailIsVerified: user.emailVerified,
      isAdmin: false,
      company: null,
      fcmToken: null,
      savedFlyersIDs: <String>[],
      followedBzzIDs: <String>[],
      appState: await GeneralProvider.fetchGlobalAppState(
        context: context,
        assignToUser: true,
      ),
    );

    _userModel.blogUserModel(methodName: 'createInitialUserModelFromUser');

    return _userModel;
  }
// -----------------------------------------------------------------------------

  /// CLONING

// -----------------------------------
  /// TAMAM : WORKS PERFECT
    UserModel copyWith({
      String id,
      AuthType authBy,
      DateTime createdAt,
      UserStatus status,
      String name,
      List<String> trigram,
      dynamic pic,
      String title,
      String company,
      Gender gender,
      ZoneModel zone,
      String language,
      GeoPoint location,
      List<ContactModel> contacts,
      List<String> myBzzIDs,
      bool emailIsVerified,
      bool isAdmin,
      FCMToken fcmToken,
      List<String> savedFlyersIDs,
      List<String> followedBzzIDs,
      AppState appState,
}){
    return UserModel(
      id: id ?? this.id,
      authBy: authBy ?? this.authBy,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      name: name ?? this.name,
      trigram: trigram ?? this.trigram,
      pic: pic ?? this.pic,
      title: title ?? this.title,
      company: company ?? this.company,
      gender: gender ?? this.gender,
      zone: zone ?? this.zone,
      language: language ?? this.language,
      location: location ?? this.location,
      contacts: contacts ?? this.contacts,
      myBzzIDs: myBzzIDs ?? this.myBzzIDs,
      emailIsVerified: emailIsVerified ?? this.emailIsVerified,
      isAdmin: isAdmin ?? this.isAdmin,
      fcmToken: fcmToken ?? this.fcmToken,
      savedFlyersIDs: savedFlyersIDs ?? this.savedFlyersIDs,
      followedBzzIDs: followedBzzIDs ?? this.followedBzzIDs,
      appState: appState ?? this.appState,
    );
}
// -----------------------------------------------------------------------------

  /// USER MODEL CYPHERS

// -----------------------------------
  /// TAMAM : WORKS PERFECT
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
      'trigram': trigram,
      'pic': pic,
      'title': title,
      'company': company,
      'gender': cipherGender(gender),
      'zone': zone?.toMap(),
      'language': language,
      'location': Atlas.cipherGeoPoint(point: location, toJSON: toJSON),
      'contacts': ContactModel.cipherContacts(contacts),
// -------------------------
      'myBzzIDs': myBzzIDs ?? <String>[],
      'emailIsVerified': emailIsVerified,
      'isAdmin': isAdmin,
      'fcmToken': fcmToken?.toMap(toJSON: toJSON),
      'savedFlyersIDs': savedFlyersIDs ?? <String>[],
      'followedBzzIDs': followedBzzIDs ?? <String>[],
      'appState' : appState.toMap(),
    };
  }
// -----------------------------------
  /// TAMAM : WORKS PERFECT
  static List<Map<String, dynamic>> cipherUsers({
    @required List<UserModel> users,
    @required bool toJSON,
  }){

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.canLoopList(users) == true){

      for (final UserModel user in users){

        final Map<String, dynamic> _map = user.toMap(toJSON: toJSON);
        _maps.add(_map);

      }

    }

    return _maps;
  }
// -----------------------------------
  /// TAMAM : WORKS PERFECT
  static UserModel decipherUser({
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
      trigram: Mapper.getStringsFromDynamics(dynamics: map['trigram'],),
      pic: map['pic'],
      title: map['title'],
      company: map['company'],
      gender: decipherGender(map['gender']),
      zone: ZoneModel.decipherZoneMap(map['zone']),
      language: map['language'] ?? 'en',
      location: Atlas.decipherGeoPoint(
          point: map['location'],
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
      appState: AppState.fromMap(map['appState']),
      docSnapshot: map['docSnapshot']
    );

  }
// -----------------------------------
  /// TAMAM : WORKS PERFECT
  static List<UserModel> decipherUsers({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<UserModel> _users = <UserModel>[];

    if (Mapper.canLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {
        _users.add(decipherUser(
            map: map,
            fromJSON: fromJSON
        )
        );
      }
    }

    return _users;
  }
// -----------------------------------------------------------------------------

  /// USER STATUS CYPHERS

// -----------------------------------
  /// TAMAM : WORKS PERFECT
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
// -----------------------------------
  /// TAMAM : WORKS PERFECT
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

  /// GENDER

// -----------------------------------
  static Gender decipherGender(String gender) {
    switch (gender) {
      case 'female' :   return Gender.female; break;
      case 'male'   :   return Gender.male;   break;
      default:return null;
    }
  }
// -----------------------------------
  static String cipherGender(Gender gender) {
    switch (gender) {
      case Gender.female:   return 'female';    break;
      case Gender.male:     return 'male';      break;
      default:              return null;
    }
  }
// -----------------------------------
  static String translateGender(Gender gender) {
    switch (gender) {
      case Gender.female:   return 'Female';    break;
      case Gender.male:     return 'Male';      break;
      default:              return null;
    }
  }
// -----------------------------------
  static const List<Gender> gendersList = <Gender>[
    Gender.male,
    Gender.female,
  ];
// -----------------------------------------------------------------------------

  /// GENERATORS

// -----------------------------------
  static String generateUserJobLine(UserModel userModel){
    return userModel == null ? null : '${userModel?.title} @ ${userModel?.company}';
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -----------------------------------
  /// TAMAM : WORKS PERFECT
  static bool checkUserIsAuthor(UserModel userModel) {
    bool _userIsAuthor = false;

    if (userModel != null && Mapper.canLoopList(userModel?.myBzzIDs)) {
      _userIsAuthor = true;
    }

    return _userIsAuthor;
  }
// -----------------------------------
  static bool checkMissingFields(UserModel userModel){
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
// -----------------------------------
  static bool checkUsersContainUser({
    @required List<UserModel> usersModels,
    @required UserModel userModel,
  }){
    bool _contains = false;

    if (Mapper.canLoopList(usersModels) == true && userModel != null){

      for (final UserModel user in usersModels){

        if (user.id == userModel.id){
          _contains = true;
          break;
        }

      }

    }

    return _contains;
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// -----------------------------------
  static List<String> missingFields(UserModel userModel) {
    final List<String> _missingFields = <String>[];

    /*
    -> NOT required : status,
    -> NOT required : location,
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

  /// MODIFIERS

// -----------------------------------
  static List<UserModel> addOrRemoveUserToUsers({
    @required List<UserModel> usersModels,
    @required UserModel userModel,
  }){
    final List<UserModel> _output = <UserModel>[...usersModels];

    if (userModel != null){

      final bool _alreadySelected = checkUsersContainUser(
          usersModels: _output,
          userModel: userModel
      );

      if (_alreadySelected == true){
        _output.removeWhere((user) => user.id == userModel.id);
      }
      else {
        _output.add(userModel);
      }

    }

    return _output;
  }
// -----------------------------------
  static List<UserModel> addUniqueUserToUsers({
    @required List<UserModel> usersToGet,
    @required UserModel userToAdd,
  }){

    final List<UserModel> _output = usersToGet ?? <UserModel>[];

    if (userToAdd != null){

      final bool _contains = checkUsersContainUser(
          usersModels: _output,
          userModel: userToAdd,
      );

      if (_contains == false){
        _output.add(userToAdd);
      }

    }

    return _output;
  }
// -----------------------------------
  static List<UserModel> addUniqueUsersToUsers({
    @required List<UserModel> usersToGet,
    @required List<UserModel> usersToAdd,
  }){

    List<UserModel> _output = usersToGet;

    if (Mapper.canLoopList(usersToAdd) == true){

      for (final UserModel user in usersToAdd){

        _output = addUniqueUserToUsers(
            usersToGet: usersToGet,
            userToAdd: user
        );

      }

    }

    return _output;
  }
// -----------------------------------
  /*
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
   */
// -----------------------------------------------------------------------------

  /// BLOGGING

// -----------------------------------
  void blogUserModel({
    String methodName = 'PRINTING USER MODEL',
  }) {
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
    blog('location : $location');
    ContactModel.blogContacts(
      contacts: contacts,
      methodName: 'blogUserModel',
    );
    blog('myBzzIDs : $myBzzIDs');
    blog('emailIsVerified : $emailIsVerified');
    blog('fcmToken : ${fcmToken?.createdAt}');
    appState.blogAppState();

    blog('$methodName : ---------------- END -- ');
  }
// -----------------------------------
  static void blogUsersModels({
    @required List<UserModel> usersModels,
    String methodName,
  }){

    if (Mapper.canLoopList(usersModels) == true){

      for (final UserModel user in usersModels){
        user.blogUserModel(methodName: methodName);
      }

    }
    else {
      blog('No User Model to blog');
    }

  }
// -----------------------------------------------------------------------------

  /// DUMMIES

// -----------------------------------
  static UserModel dummyUserModel(BuildContext context){

    final UserModel _userModel = UserModel(
      id: 'dummy_user_model',
      authBy: AuthType.emailSignIn,
      createdAt: Timers.createDate(year: 1987, month: 06, day: 10),
      status: UserStatus.normal,
      name: 'Donald duck',
      trigram: <String>[],
      pic: Iconz.dvRageh,
      title: 'CEO',
      company: 'Bldrs.LLC',
      gender: Gender.male,
      zone: ZoneModel.dummyZone(),
      language: 'en',
      location: Atlas.dummyLocation(),
      contacts: ContactModel.dummyContacts(),
      myBzzIDs: <String>[],
      emailIsVerified: true,
      isAdmin: true,
      fcmToken: null,
      savedFlyersIDs: <String>[],
      followedBzzIDs: <String>[],
      appState: AppState.dummyAppState(),
    );

    return _userModel;
  }
// -----------------------------------
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

      final List<int> _randomIndexes = Numeric.createRandomIndexes(
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
// -----------------------------------
  static Future<UserModel> futureDummyUserModel(BuildContext context) async {

    final UserModel _user = await UserFireOps.readUser(
      context: context,
      userID: '60a1SPzftGdH6rt15NF96m0j9Et2',
    );

    return _user;
  }
// -----------------------------------------------------------------------------

  /// USER TYPES

// -----------------------------------
  static const List<UserStatus> userStatuses = <UserStatus>[
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
  /*
  Recon
   */
}
// -----------------------------------------------------------------------------
enum Gender {
  male,
  female,
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
String _userTabPhraseID(UserTab userTab){
  switch(userTab){
    case UserTab.profile        : return  'phid_profile'       ; break;
    case UserTab.status         : return  'phid_status'        ; break;
    case UserTab.notifications  : return  'phid_notifications' ; break;
    case UserTab.following      : return  'phid_followed_bz'     ; break;
    default: return null;
  }
}
// -----------------------------------------------------------------------------
String translateUserTab({
  @required BuildContext context,
  @required UserTab userTab,
}){
  final String _tabPhraseID = _userTabPhraseID(userTab);
  return superPhrase(context, _tabPhraseID);
}
// -----------------------------------------------------------------------------
int getUserTabIndex(UserTab userTab){
  final int _index = userProfileTabsList.indexWhere((tab) => tab == userTab);
  return _index;
}
// -----------------------------------------------------------------------------
