import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/a_user/sub/deck_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/general_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum Gender {
  male,
  female,
}

/// => TAMAM
@immutable
class UserModel {
  /// --------------------------------------------------------------------------
  const UserModel({
    @required this.id,
    @required this.authBy,
    @required this.createdAt,
    @required this.need,
    @required this.name,
    @required this.trigram,
    @required this.picPath,
    @required this.title,
    @required this.company,
    @required this.gender,
    @required this.zone,
    @required this.language,
    @required this.location,
    @required this.contacts,
    @required this.contactsArePublic,
    @required this.myBzzIDs,
    @required this.emailIsVerified,
    @required this.isAdmin,
    @required this.device,
    @required this.fcmTopics,
    @required this.savedFlyers,
    @required this.followedBzzIDs,
    @required this.appState,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final AuthType authBy;
  final DateTime createdAt;
  final NeedModel need;
  final String name;
  final List<String> trigram;
  final String picPath; // path only
  final String title;
  final String company;
  final Gender gender;
  final ZoneModel zone;
  final String language;
  final GeoPoint location;
  final List<ContactModel> contacts;
  final bool contactsArePublic;
  final List<String> myBzzIDs;
  final bool emailIsVerified;
  final bool isAdmin;
  final DeviceModel device;
  final List<String> fcmTopics;
  final DeckModel savedFlyers;
  final List<String> followedBzzIDs;
  final AppState appState;
  final DocumentSnapshot docSnapshot;
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> fromFirebaseUser({
    @required BuildContext context,
    @required User user,
    @required ZoneModel zone,
    @required AuthType authBy,
  }) async {

    assert(!user.isAnonymous, 'user must not be anonymous');
    assert(await user.getIdToken() != null, 'user token must not be null');

    final UserModel _userModel = UserModel(
      id: user.uid,
      authBy: authBy,
      createdAt: DateTime.now(),
      need: NeedModel.createInitialNeed(context: context, userZone: zone),
      // -------------------------
      name: user.displayName,
      trigram: Stringer.createTrigram(input: user.displayName),
      /// do not generate path here, it will be generated once we assign an a user pic
      picPath: null, //Storage.generateUserPicPath(user.uid),
      title: '',
      gender: Gender.male,
      zone: zone,
      language: '', //Wordz.languageCode(context),
      location: null,
      contacts: ContactModel.generateContactsFromFirebaseUser(user),
      contactsArePublic: true,
      // -------------------------
      myBzzIDs: const <String>[],
      emailIsVerified: user.emailVerified,
      isAdmin: false,
      company: null,
      device: null,
      savedFlyers: DeckModel.newDeck(),
      followedBzzIDs: const <String>[],
      appState: await GeneralProvider.fetchGlobalAppState(
        context: context,
        assignToUser: true,
      ),
      fcmTopics: TopicModel.getAllPossibleUserTopicsIDs(),
    );

    _userModel.blogUserModel(invoker: 'fromFirebaseUser');

    return _userModel;
  }
  // -----------------------------------------------------------------------------

  /// USER MODEL CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }) {
    return <String, dynamic>{
      'id': id,
      'authBy': AuthModel.cipherAuthBy(authBy),
      'createdAt': Timers.cipherTime(time: createdAt, toJSON: toJSON),
      'need': need?.toMap(toJSON: toJSON),
// -------------------------
      'name': name,
      'trigram': trigram,
      'picPath': picPath,
      'title': title,
      'company': company,
      'gender': cipherGender(gender),
      'zone': zone?.toMap(),
      'language': language,
      'location': Atlas.cipherGeoPoint(point: location, toJSON: toJSON),
      'contacts': ContactModel.cipherContacts(contacts),
      'contactsArePublic': contactsArePublic,
// -------------------------
      'myBzzIDs': myBzzIDs ?? <String>[],
      'emailIsVerified': emailIsVerified,
      'isAdmin': isAdmin,
      'device': device?.toMap(),
      'fcmTopics': fcmTopics,
      'savedFlyers': savedFlyers?.toMap(),
      'followedBzzIDs': followedBzzIDs ?? <String>[],
      'appState' : appState.toMap(),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherUsers({
    @required List<UserModel> users,
    @required bool toJSON,
  }){

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.checkCanLoopList(users) == true){

      for (final UserModel user in users){

        final Map<String, dynamic> _map = user.toMap(toJSON: toJSON);
        _maps.add(_map);

      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel decipherUser({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }) {
    return map == null ? null :
    UserModel(
        id: map['id'],
        authBy: AuthModel.decipherAuthBy(map['authBy']),
        createdAt: Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        need: NeedModel.decipherNeed(map: map['need'], fromJSON: fromJSON),
        // -------------------------
        name: map['name'],
        trigram: Stringer.getStringsFromDynamics(dynamics: map['trigram'],),
        picPath: map['picPath'],
        title: map['title'],
        company: map['company'],
        gender: decipherGender(map['gender']),
        zone: ZoneModel.decipherZone(map['zone']),
        language: map['language'] ?? 'en',
        location: Atlas.decipherGeoPoint(point: map['location'], fromJSON: fromJSON),
        contacts: ContactModel.decipherContacts(map['contacts']),
        contactsArePublic: map['contactsArePublic'],
        // -------------------------
        myBzzIDs: Stringer.getStringsFromDynamics(dynamics: map['myBzzIDs'],),
        emailIsVerified: map['emailIsVerified'],
        isAdmin: map['isAdmin'],
        device: DeviceModel.decipherFCMToken(map['device']),
        fcmTopics: Stringer.getStringsFromDynamics(dynamics: map['fcmTopics']),
        savedFlyers: DeckModel.decipher(map['savedFlyers']),
        followedBzzIDs: Stringer.getStringsFromDynamics(dynamics: map['followedBzzIDs'],),
        appState: AppState.fromMap(map['appState']),
        docSnapshot: map['docSnapshot']
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<UserModel> decipherUsers({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<UserModel> _users = <UserModel>[];

    if (Mapper.checkCanLoopList(maps)) {
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

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  UserModel copyWith({
    String id,
    AuthType authBy,
    DateTime createdAt,
    NeedModel need,
    String name,
    List<String> trigram,
    String picPath,
    String title,
    String company,
    Gender gender,
    ZoneModel zone,
    String language,
    GeoPoint location,
    List<ContactModel> contacts,
    bool contactsArePublic,
    List<String> myBzzIDs,
    bool emailIsVerified,
    bool isAdmin,
    DeviceModel device,
    DeckModel savedFlyers,
    List<String> followedBzzIDs,
    AppState appState,
    List<String> fcmTopics,
  }){
    return UserModel(
      id: id ?? this.id,
      authBy: authBy ?? this.authBy,
      createdAt: createdAt ?? this.createdAt,
      need: need ?? this.need,
      name: name ?? this.name,
      trigram: trigram ?? this.trigram,
      picPath: picPath ?? this.picPath,
      title: title ?? this.title,
      company: company ?? this.company,
      gender: gender ?? this.gender,
      zone: zone ?? this.zone,
      language: language ?? this.language,
      location: location ?? this.location,
      contacts: contacts ?? this.contacts,
      contactsArePublic: contactsArePublic ?? this.contactsArePublic,
      myBzzIDs: myBzzIDs ?? this.myBzzIDs,
      emailIsVerified: emailIsVerified ?? this.emailIsVerified,
      isAdmin: isAdmin ?? this.isAdmin,
      device: device ?? this.device,
      savedFlyers: savedFlyers ?? this.savedFlyers,
      followedBzzIDs: followedBzzIDs ?? this.followedBzzIDs,
      appState: appState ?? this.appState,
      fcmTopics: fcmTopics ?? this.fcmTopics,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  UserModel nullifyField({
    bool id = false,
    bool authBy = false,
    bool createdAt = false,
    bool need = false,
    bool name = false,
    bool trigram = false,
    bool picPath = false,
    bool title = false,
    bool company = false,
    bool gender = false,
    bool zone = false,
    bool language = false,
    bool location = false,
    bool contacts = false,
    bool contactsArePublic = false,
    bool myBzzIDs = false,
    bool emailIsVerified = false,
    bool isAdmin = false,
    bool device = false,
    bool savedFlyers = false,
    bool followedBzzIDs = false,
    bool appState = false,
    bool fcmTopics = false,
  }){
    return UserModel(
      id : id == true ? null : this.id,
      authBy : authBy == true ? null : this.authBy,
      createdAt : createdAt == true ? null : this.createdAt,
      need : need == true ? null : this.need,
      name : name == true ? null : this.name,
      trigram : trigram == true ? const [] : this.trigram,
      picPath : picPath == true ? null : this.picPath,
      title : title == true ? null : this.title,
      company : company == true ? null : this.company,
      gender : gender == true ? null : this.gender,
      zone : zone == true ? null : this.zone,
      language : language == true ? null : this.language,
      location : location == true ? null : this.location,
      contacts : contacts == true ? const [] : this.contacts,
      contactsArePublic : contactsArePublic == true ? null : this.contactsArePublic,
      myBzzIDs : myBzzIDs == true ? const [] : this.myBzzIDs,
      emailIsVerified : emailIsVerified == true ? null : this.emailIsVerified,
      isAdmin : isAdmin == true ? null : this.isAdmin,
      device : device == true ? null : this.device,
      savedFlyers : savedFlyers == true ? DeckModel.newDeck() : this.savedFlyers,
      followedBzzIDs : followedBzzIDs == true ? const [] : this.followedBzzIDs,
      appState : appState == true ? null : this.appState,
      fcmTopics: fcmTopics == true ? const [] : this.fcmTopics,
    );
  }
  // -----------------------------------------------------------------------------

  /// GENDER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Gender decipherGender(String gender) {
    switch (gender) {
      case 'female' :   return Gender.female; break;
      case 'male'   :   return Gender.male;   break;
      default:return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherGender(Gender gender) {
    switch (gender) {
      case Gender.female:   return 'female';    break;
      case Gender.male:     return 'male';      break;
      default:              return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getGenderPhid(Gender gender) {
    switch (gender) {
      case Gender.female:   return 'phid_female';    break;
      case Gender.male:     return 'phid_male';      break;
      default:              return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String genderIcon(Gender gender){
    switch (gender) {
      case Gender.female:   return Iconz.female;    break;
      case Gender.male:     return Iconz.male;      break;
      default:              return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static const List<Gender> gendersList = <Gender>[
    Gender.male,
    Gender.female,
  ];
  // -----------------------------------------------------------------------------

  /// GENERATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse generateUserJobLine(UserModel userModel){
    return Verse(
      text: userModel == null ? null : '${userModel?.title} @ ${userModel?.company}',
      translate: false,
    );
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUserIsAuthor(UserModel userModel) {
    bool _userIsAuthor = false;

    if (userModel != null && Mapper.checkCanLoopList(userModel?.myBzzIDs)) {
      _userIsAuthor = true;
    }

    return _userIsAuthor;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUsersContainUser({
    @required List<UserModel> usersModels,
    @required UserModel userModel,
  }){
    bool _contains = false;

    if (Mapper.checkCanLoopList(usersModels) == true && userModel != null){

      for (final UserModel user in usersModels){

        if (user.id == userModel.id){
          _contains = true;
          break;
        }

      }

    }

    return _contains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUserFollowsBz({
    @required UserModel userModel,
    @required String bzID,
  }){

    return Stringer.checkStringsContainString(
        strings: userModel.followedBzzIDs,
        string: bzID
    );

  }
  // --------------------
  /// TASK : TEST ME
  static bool checkFlyerIsSaved({
    @required UserModel userModel,
    @required String flyerID,
  }){

    return Stringer.checkStringsContainString(
        strings: userModel?.savedFlyers?.all,
        string: flyerID
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkItIsMe(String userID){
    final String _myID = AuthFireOps.superUserID();

    if (_myID != null && userID != null){
      return userID == _myID;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getUsersIDs(List<UserModel> usersModels){
    final List<String> _usersIDs = <String>[];

    if (Mapper.checkCanLoopList(usersModels) == true){
      for (final UserModel user in usersModels){
        _usersIDs.add(user.id);
      }
    }

    return _usersIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getUsersPics(List<UserModel> usersModels){
    final List<String> _pics = <String>[];

    if (Mapper.checkCanLoopList(usersModels) == true){
      for (final UserModel user in usersModels){
        _pics.add(user.picPath);
      }
    }

    return _pics;
  }
  // -----------------------------------------------------------------------------

  /// USERS MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<UserModel> addUniqueUsersToUsers({
    @required List<UserModel> usersToGet,
    @required List<UserModel> usersToAdd,
  }){

    List<UserModel> _output = usersToGet;

    if (Mapper.checkCanLoopList(usersToAdd) == true){

      for (final UserModel user in usersToAdd){

        _output = addUniqueUserToUsers(
            usersToGet: usersToGet,
            userToAdd: user
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// USER MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel addBzIDToUserBzzIDs({
    @required UserModel oldUser,
    @required String bzIDToAdd,
  }){

    final List<String> _newBzzIDs = Stringer.addStringToListIfDoesNotContainIt(
      strings: oldUser.myBzzIDs,
      stringToAdd: bzIDToAdd,
    );

    final UserModel _newUser = oldUser.copyWith(
      myBzzIDs: _newBzzIDs,
    );

    return _newUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel removeBzIDFromUserBzzIDs({
    @required UserModel oldUser,
    @required String bzIDToRemove,
  }){
    UserModel _newUser = oldUser;

    if (Mapper.checkCanLoopList(oldUser?.myBzzIDs) == true) {

      final List<String> _newList = Stringer.removeStringsFromStrings(
        removeFrom: oldUser.myBzzIDs,
        removeThis: <String>[bzIDToRemove],
      );

      _newUser = oldUser.copyWith(
        myBzzIDs: _newList,
      );

    }

    return _newUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel addBzIDToUserFollows({
    @required UserModel oldUser,
    @required String bzIDToFollow,
  }){

    final List<String> _newBzzIDs = Stringer.addStringToListIfDoesNotContainIt(
      strings: oldUser.followedBzzIDs,
      stringToAdd: bzIDToFollow,
    );

    final UserModel newUser = oldUser.copyWith(
      followedBzzIDs: _newBzzIDs,
    );

    return newUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel removeBzIDFromUserFollows({
    @required UserModel oldUser,
    @required String bzIDToUnFollow,
  }){
    UserModel _newUser = oldUser;

    if (Mapper.checkCanLoopList(oldUser?.followedBzzIDs) == true) {

      final List<String> _newList = Stringer.removeStringsFromStrings(
        removeFrom: oldUser.followedBzzIDs,
        removeThis: <String>[bzIDToUnFollow],
      );

      _newUser = oldUser.copyWith(
        followedBzzIDs: _newList,
      );

    }

    return _newUser;
  }
  // --------------------
  /// TASK : TEST ME
  static UserModel addFlyerToSavedFlyers({
    @required UserModel oldUser,
    @required FlyerModel flyerModel,
  }){

    final DeckModel _newSavedFlyers = DeckModel.addFlyer(
        flyer: flyerModel,
        oldDeck: oldUser?.savedFlyers,
    );

    final UserModel _newUser = oldUser?.copyWith(
      savedFlyers: _newSavedFlyers,
    );

    return _newUser;
  }
  // --------------------
  /// TASK : TEST ME
  static UserModel removeFlyerFromSavedFlyers({
    @required UserModel oldUser,
    @required String flyerIDToRemove,
  }){

    final DeckModel _newSavedFlyers = DeckModel.removeFlyerByID(
        oldDeck: oldUser?.savedFlyers,
        flyerID: flyerIDToRemove
    );

    final UserModel _newUser = oldUser.copyWith(
      savedFlyers: _newSavedFlyers,
    );

    return _newUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel addAllBzTopicsToMyTopics({
    @required UserModel oldUser,
    @required String bzID,
  }){
    UserModel _newUser = oldUser;

    if (bzID != null && _newUser != null){

      List<String> userTopics = <String>[..._newUser.fcmTopics];

      userTopics = Stringer.addStringsToStringsIfDoNotContainThem(
        listToTake: userTopics,
        listToAdd: TopicModel.getAllPossibleBzTopicsIDs(bzID: bzID),
      );

      _newUser = _newUser.copyWith(
        fcmTopics: userTopics,
      );

    }

    return _newUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel removeAllBzTopicsFromMyTopics({
    @required UserModel oldUser,
    @required String bzID,
  }){
    UserModel _newUser = oldUser;

    if (bzID != null && _newUser != null){

      List<String> userTopics = <String>[..._newUser.fcmTopics];

      userTopics = Stringer.removeStringsFromStrings(
        removeFrom: userTopics,
        removeThis: TopicModel.getAllPossibleBzTopicsIDs(bzID: bzID),
      );

      _newUser = _newUser.copyWith(
        fcmTopics: userTopics,
      );

    }

    return _newUser;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogUserModel({
    String invoker = 'BLOGGING USER MODEL',
  }) {
    blog('$invoker : ---------------- START -- ');

    blog('id : $id');
    blog('authBy : $authBy');
    blog('createdAt : $createdAt');
    blog('name : $name');
    blog('trigram : $trigram');
    blog('pic : $picPath');
    blog('title : $title');
    blog('company : $company');
    blog('gender : $gender');
    blog('language : $language');
    blog('location : $location');
    blog('myBzzIDs : $myBzzIDs');
    blog('followedBzzIDs : $followedBzzIDs');
    blog('isAdmin : $isAdmin');
    blog('emailIsVerified : $emailIsVerified');
    blog('docSnapshot : $docSnapshot');
    zone?.blogZone();
    need?.blogNeed();
    blog('contactsArePublic : $contactsArePublic');
    blog('savedFlyers : ${savedFlyers?.toString()}');
    ContactModel.blogContacts(
      contacts: contacts,
      invoker: 'user contacts',
    );
    device?.blogDevice();
    Stringer.blogStrings(strings: fcmTopics, invoker: 'user fcmTopics');
    appState?.blogAppState();

    blog('$invoker : ---------------- END -- ');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogUsersModels({
    @required List<UserModel> usersModels,
    String invoker,
  }){

    if (Mapper.checkCanLoopList(usersModels) == true){

      for (final UserModel user in usersModels){
        user.blogUserModel(invoker: invoker);
      }

    }
    else {
      blog('No User Model to blog');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogUsersDifferences({
    @required UserModel user1,
    @required UserModel user2,
  }){

    if (user1 == null){
      blog('blogUsersDifferences : user1 is null');
    }

    if (user2 == null){
      blog('blogUsersDifferences : user2 is null');
    }

    if (user1 != null && user2 != null){

      if (user1.id != user2.id){
        blog('blogUserDifferences : [id] are not identical');
      }

      if (user1.authBy != user2.authBy){
        blog('blogUserDifferences : [authBy] are not identical');
      }

      if (Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: user1.createdAt, time2: user2.createdAt) == false){
        blog('blogUserDifferences : [createdAt] are not identical');
      }

      if (NeedModel.checkNeedsAreIdentical(user1.need, user2.need) == false){
        blog('blogUserDifferences : [needs] are not identical');
      }

      if (user1.name != user2.name){
        blog('blogUserDifferences : [name] are not identical');
      }

      if (Mapper.checkListsAreIdentical(list1: user1.trigram, list2: user2.trigram) == false){
        blog('blogUserDifferences : [trigram] are not identical');
      }

      if (user1.picPath != user2.picPath){
        blog('blogUserDifferences : [pic] are not identical');
      }

      if (user1.title != user2.title){
        blog('blogUserDifferences : [title] are not identical');
      }

      if (user1.company != user2.company){
        blog('blogUserDifferences : [company] are not identical');
      }

      if (user1.gender != user2.gender){
        blog('blogUserDifferences : [gender] are not identical');
      }

      if (ZoneModel.checkZonesIDsAreIdentical(zone1: user1.zone, zone2: user2.zone) == false){
        blog('blogUserDifferences : [zone] are not identical');
      }

      if (user1.language != user2.language){
        blog('blogUserDifferences : [language] are not identical');
      }

      if (Atlas.checkPointsAreIdentical(point1: user1.location, point2: user2.location) == false){
        blog('blogUserDifferences : [location] are not identical');
      }

      if (ContactModel.checkContactsListsAreIdentical(contacts1: user1.contacts, contacts2: user2.contacts) == false){
        blog('blogUserDifferences : [contacts] are not identical');
      }

      if (user1.contactsArePublic != user2.contactsArePublic){
        blog('blogUserDifferences : [contactsArePublic] are not identical');
      }

      if (Mapper.checkListsAreIdentical(list1: user1.myBzzIDs, list2: user2.myBzzIDs) == false){
        blog('blogUserDifferences : [myBzzIDs] are not identical');
      }

      if (user1.emailIsVerified != user2.emailIsVerified){
        blog('blogUserDifferences : [emailIsVerified] are not identical');
      }

      if (user1.isAdmin != user2.isAdmin){
        blog('blogUserDifferences : [isAdmin] are not identical');
      }

      if (DeckModel.checkDecksAreIdentical(deck1: user1.savedFlyers, deck2: user2.savedFlyers) == false){
        blog('blogUserDifferences : [savedFlyers] are not identical');
      }

      if (Mapper.checkListsAreIdentical(list1: user1.followedBzzIDs, list2: user2.followedBzzIDs) == false){
        blog('blogUserDifferences : [followedBzzIDs] are not identical');
      }

      if (AppState.checkAppStatesAreIdentical(appState1: user1.appState, appState2: user2.appState) == false){
        blog('blogUserDifferences : [appState] are not identical');
      }

      if (DeviceModel.checkDevicesAreIdentical(device1: user1.device, device2: user2.device) == false){
        blog('blogUserDifferences : [device] are not identical');
      }

      if (Mapper.checkListsAreIdentical(list1: user1.fcmTopics, list2: user2.fcmTopics) == false){
        blog('blogUserDifferences : [fcmTopics] are not identical');
      }

      if (NeedModel.checkNeedsAreIdentical(user1.need, user2.need) == false){
        blog('blogUserDifferences : [need] are not identical');
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel dummyUserModel(BuildContext context){

    final UserModel _userModel = UserModel(
      id: 'dummy_user_model',
      authBy: AuthType.emailSignIn,
      createdAt: Timers.createDate(year: 1987, month: 06, day: 10),
      need: NeedModel.dummyNeed(context),
      name: 'Donald duck',
      trigram: const <String>[],
      picPath: Iconz.dvRageh,
      title: 'CEO',
      company: 'Bldrs.LLC',
      gender: Gender.male,
      zone: ZoneModel.dummyZone(),
      language: 'en',
      location: Atlas.dummyLocation(),
      contacts: ContactModel.dummyContacts(),
      contactsArePublic: true,
      myBzzIDs: const <String>[],
      emailIsVerified: true,
      isAdmin: true,
      device: null,
      savedFlyers: DeckModel.newDeck(),
      followedBzzIDs: const <String>[],
      appState: AppState.dummyAppState(),
      fcmTopics: TopicModel.getAllPossibleUserTopicsIDs(),
    );

    return _userModel;
  }
  // --------------------
  /*
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
   */
  // --------------------
  /*
  static Future<UserModel> futureDummyUserModel() async {

    final UserModel _user = await UserFireOps.readUser(
      userID: '60a1SPzftGdH6rt15NF96m0j9Et2',
    );

    return _user;
  }
   */
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool usersAreIdentical({
    @required UserModel user1,
    @required UserModel user2,
  }){
    bool _identical = false;

    if (user1 == null && user2 == null){
      _identical = true;
    }

    else if (user1 != null && user2 != null){

      if (
      user1.id == user2.id &&
          user1.authBy == user2.authBy &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: user1.createdAt, time2: user2.createdAt) == true &&
          NeedModel.checkNeedsAreIdentical(user1.need, user2.need) == true &&
          user1.name == user2.name &&
          Mapper.checkListsAreIdentical(list1: user1.trigram, list2: user2.trigram) == true &&
          user1.picPath == user2.picPath &&
          user1.title == user2.title &&
          user1.company == user2.company &&
          user1.gender == user2.gender &&
          ZoneModel.checkZonesAreIdentical(zone1: user1.zone, zone2: user2.zone) == true &&
          user1.language == user2.language &&
          Atlas.checkPointsAreIdentical(point1: user1.location, point2: user2.location) == true &&
          ContactModel.checkContactsListsAreIdentical(contacts1: user1.contacts, contacts2: user2.contacts) == true &&
          user1.contactsArePublic == user2.contactsArePublic &&
          Mapper.checkListsAreIdentical(list1: user1.myBzzIDs, list2: user2.myBzzIDs) == true &&
          user1.emailIsVerified == user2.emailIsVerified &&
          user1.isAdmin == user2.isAdmin &&
          DeckModel.checkDecksAreIdentical(deck1: user1.savedFlyers, deck2: user2.savedFlyers) == true &&
          Mapper.checkListsAreIdentical(list1: user1.followedBzzIDs, list2: user2.followedBzzIDs) == true &&
          AppState.checkAppStatesAreIdentical(appState1: user1.appState, appState2: user2.appState) == true &&
          DeviceModel.checkDevicesAreIdentical(device1: user1.device, device2: user2.device) == true &&
          Mapper.checkListsAreIdentical(list1: user1.fcmTopics, list2: user2.fcmTopics) == true
      // DocumentSnapshot docSnapshot;

      ){
        _identical = true;
      }

    }

    // if (_identical == false){
    //   blogUsersDifferences(
    //     user1: user1,
    //     user2: user2,
    //   );
    //
    // }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is UserModel){
      _areIdentical = usersAreIdentical(
        user1: this,
        user2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      authBy.hashCode^
      createdAt.hashCode^
      need.hashCode^
      name.hashCode^
      trigram.hashCode^
      picPath.hashCode^
      title.hashCode^
      company.hashCode^
      gender.hashCode^
      zone.hashCode^
      language.hashCode^
      location.hashCode^
      contacts.hashCode^
      contactsArePublic.hashCode^
      myBzzIDs.hashCode^
      emailIsVerified.hashCode^
      isAdmin.hashCode^
      device.hashCode^
      fcmTopics.hashCode^
      savedFlyers.hashCode^
      followedBzzIDs.hashCode^
      appState.hashCode^
      docSnapshot.hashCode;
  // -----------------------------------------------------------------------------
}
