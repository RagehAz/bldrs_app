import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/space/atlas.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:bldrs/a_models/a_user/sub/agenda_model.dart';
import 'package:bldrs/a_models/a_user/sub/deck_model.dart';
import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/a_models/e_notes/aa_topic_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:fire/super_fire.dart';
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
    required this.id,
    required this.signInMethod,
    required this.createdAt,
    required this.need,
    required this.name,
    required this.trigram,
    required this.picPath,
    required this.title,
    required this.company,
    required this.gender,
    required this.zone,
    required this.language,
    required this.location,
    required this.contacts,
    required this.contactsArePublic,
    required this.myBzzIDs,
    required this.isAuthor,
    required this.emailIsVerified,
    required this.isAdmin,
    required this.device,
    required this.fcmTopics,
    required this.savedFlyers,
    required this.followedBzz,
    required this.appState,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String? id;
  final SignInMethod? signInMethod;
  final DateTime? createdAt;
  final NeedModel? need;
  final String? name;
  final List<String>? trigram;
  final String? picPath; // path only
  final String? title;
  final String? company;
  final Gender? gender;
  final ZoneModel? zone;
  final String? language;
  final GeoPoint? location;
  final List<ContactModel>? contacts;
  final bool? contactsArePublic;
  final List<String>? myBzzIDs;
  final bool? isAuthor;
  final bool? emailIsVerified;
  final bool? isAdmin;
  final DeviceModel? device;
  final List<String>? fcmTopics;
  final DeckModel? savedFlyers;
  final AgendaModel? followedBzz;
  final AppStateModel? appState;
  final QueryDocumentSnapshot<Object?>? docSnapshot;
   // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel> createNewUserModelFromAuthModel({
    required AuthModel authModel,
  }) async {

    assert(authModel.signInMethod != SignInMethod.anonymous, 'user must not be anonymous');

    final ZoneModel? _currentZone = ZoneProvider.proGetCurrentZone(
      context: getMainContext(),
      listen: false,
    );

    final UserModel _userModel = UserModel(
      id: authModel.id,
      signInMethod: authModel.signInMethod,
      createdAt: DateTime.now(),
      need: NeedModel.createInitialNeed(userZone: _currentZone),
      // -------------------------
      name: authModel.name,
      trigram: Stringer.createTrigram(input: authModel.name),
      /// do not generate path here, it will be generated once we assign a user pic
      picPath: null, //BldrStorage.generateUserPicPath(user.uid),
      title: '',
      gender: null,
      zone: _currentZone,
      language: Localizer.getCurrentLangCode(),
      location: null,
      contacts: ContactModel.generateBasicContacts(
        email: authModel.email,
        phone: authModel.phone,
      ),
      contactsArePublic: true,
      // -------------------------
      myBzzIDs: const <String>[],
      isAuthor: false,
      emailIsVerified: authModel.data?['credential.user.emailVerified'] ?? authModel.data?['user.emailVerified'],
      isAdmin: false,
      company: null,
      device: await DeviceModel.generateDeviceModel(),
      savedFlyers: DeckModel.newDeck(),
      followedBzz: AgendaModel.newAgenda(),
      appState: await AppStateModel.createInitialModel(),
      fcmTopics: TopicModel.getAllPossibleUserTopicsIDs(),
    );

    // _userModel.blogUserModel(invoker: 'fromFirebaseUser');

    return _userModel;
  }
  // -----------------------------------------------------------------------------

  /// USER MODEL CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    required bool toJSON,
  }) {
    return <String, dynamic>{
      'id': id,
      'signInMethod': AuthModel.cipherSignInMethod(signInMethod),
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
      'isAuthor': Mapper.checkCanLoopList(myBzzIDs),
      'emailIsVerified': emailIsVerified,
      'isAdmin': isAdmin,
      'device': device?.toMap(),
      'fcmTopics': fcmTopics,
      'savedFlyers': savedFlyers?.toMap(),
      'followedBzz': followedBzz?.toMap(),
      'appState' : appState?.toMap(toUserModel: true),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherUsers({
    required List<UserModel> users,
    required bool toJSON,
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
  static UserModel? decipherUser({
    required Map<String, dynamic>? map,
    required bool fromJSON,
  }) {

    if (map == null){
      return null;
    }

    else {

      final List<String> _myBzzIDs = Stringer.getStringsFromDynamics(map['myBzzIDs'],);

      return UserModel(
        id: map['id'],
        signInMethod: AuthModel.decipherSignInMethod(map['signInMethod']),
        createdAt: Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        need: NeedModel.decipherNeed(map: map['need'], fromJSON: fromJSON),
        // -------------------------
        name: map['name'],
        trigram: Stringer.getStringsFromDynamics(map['trigram'],),
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
        myBzzIDs: _myBzzIDs,
        isAuthor: Mapper.checkCanLoopList(_myBzzIDs),
        emailIsVerified: map['emailIsVerified'],
        isAdmin: map['isAdmin'],
        device: DeviceModel.decipherDeviceModel(map['device']),
        fcmTopics: Stringer.getStringsFromDynamics(map['fcmTopics']),
        savedFlyers: DeckModel.decipher(map['savedFlyers']),
        followedBzz: AgendaModel.decipher(map['followedBzz']),
        appState: AppStateModel.fromMap(map: map['appState']),
        docSnapshot: map['docSnapshot']
    );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<UserModel> decipherUsers({
    required List<Map<String, dynamic>>? maps,
    required bool fromJSON,
  }) {
    final List<UserModel> _users = <UserModel>[];

    if (Mapper.checkCanLoopList(maps) == true) {
      for (final Map<String, dynamic> map in maps!) {

        final UserModel? _user = decipherUser(
            map: map,
            fromJSON: fromJSON
        );

        if (_user != null){
          _users.add(_user);
        }

      }
    }

    return _users;
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  UserModel copyWith({
    String? id,
    SignInMethod? signInMethod,
    DateTime? createdAt,
    NeedModel? need,
    String? name,
    List<String>? trigram,
    String? picPath,
    String? title,
    String? company,
    Gender? gender,
    ZoneModel? zone,
    String? language,
    GeoPoint? location,
    List<ContactModel>? contacts,
    bool? contactsArePublic,
    List<String>? myBzzIDs,
    bool? isAuthor,
    bool? emailIsVerified,
    bool? isAdmin,
    DeviceModel? device,
    DeckModel? savedFlyers,
    AgendaModel? followedBzz,
    AppStateModel? appState,
    List<String>? fcmTopics,
  }){
    return UserModel(
      id: id ?? this.id,
      signInMethod: signInMethod ?? this.signInMethod,
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
      isAuthor: isAuthor ?? this.isAuthor,
      emailIsVerified: emailIsVerified ?? this.emailIsVerified,
      isAdmin: isAdmin ?? this.isAdmin,
      device: device ?? this.device,
      savedFlyers: savedFlyers ?? this.savedFlyers,
      followedBzz: followedBzz ?? this.followedBzz,
      appState: appState ?? this.appState,
      fcmTopics: fcmTopics ?? this.fcmTopics,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  UserModel nullifyField({
    bool id = false,
    bool signInMethod = false,
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
    bool isAuthor = false,
    bool emailIsVerified = false,
    bool isAdmin = false,
    bool device = false,
    bool savedFlyers = false,
    bool followedBzz = false,
    bool appState = false,
    bool fcmTopics = false,
  }){
    return UserModel(
      id : id == true ? null : this.id,
      signInMethod : signInMethod == true ? null : this.signInMethod,
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
      isAuthor: isAuthor == true ? null : this.isAuthor,
      emailIsVerified : emailIsVerified == true ? null : this.emailIsVerified,
      isAdmin : isAdmin == true ? null : this.isAdmin,
      device : device == true ? null : this.device,
      savedFlyers : savedFlyers == true ? DeckModel.newDeck() : this.savedFlyers,
      followedBzz : followedBzz == true ? AgendaModel.newAgenda() : this.followedBzz,
      appState : appState == true ? null : this.appState,
      fcmTopics: fcmTopics == true ? const [] : this.fcmTopics,
    );
  }
  // -----------------------------------------------------------------------------

  /// GENDER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Gender? decipherGender(String? gender) {
    switch (gender) {
      case 'female' :   return Gender.female;
      case 'male'   :   return Gender.male;
      default:return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherGender(Gender? gender) {
    switch (gender) {
      case Gender.female:   return 'female';
      case Gender.male:     return 'male';
      default:              return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getGenderPhid(Gender? gender) {
    switch (gender) {
      case Gender.female:   return 'phid_female';
      case Gender.male:     return 'phid_male';
      default:              return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? genderIcon(Gender? gender){
    switch (gender) {
      case Gender.female:   return Iconz.female;
      case Gender.male:     return Iconz.male;
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
  static Verse generateUserJobLine(UserModel? userModel){
    return Verse(
      id: userModel == null ? null : '${userModel.title} @ ${userModel.company}',
      translate: false,
    );
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool userIsSignedUp(UserModel? userModel) {
    bool _userIsSignedUp = false;

    if (userModel != null && userModel.id != null) {
      _userIsSignedUp = userModel.signInMethod != SignInMethod.anonymous;
    }

    return _userIsSignedUp;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUserIsAuthor(UserModel? userModel) {
    bool _userIsAuthor = false;

    if (userModel != null && Mapper.checkCanLoopList(userModel.myBzzIDs)) {
      _userIsAuthor = true;
    }

    return _userIsAuthor;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkUsersContainUser({
    required List<UserModel>? usersModels,
    required UserModel? userModel,
  }){
    bool _contains = false;

    if (Mapper.checkCanLoopList(usersModels) == true && userModel != null){

      for (final UserModel user in usersModels!){

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
    required UserModel? userModel,
    required String bzID,
  }){

    return Stringer.checkStringsContainString(
        strings: userModel?.followedBzz?.all,
        string: bzID
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFlyerIsSaved({
    required UserModel? userModel,
    required String? flyerID,
  }){

    return Stringer.checkStringsContainString(
        strings: userModel?.savedFlyers?.all,
        string: flyerID
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkItIsMe(String? userID){
    final String? _myID = Authing.getUserID();

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
  static List<String> getUsersIDs(List<UserModel>? usersModels){
    final List<String> _usersIDs = <String>[];

    if (Mapper.checkCanLoopList(usersModels) == true){
      for (final UserModel user in usersModels!){

        if (user.id != null){
          _usersIDs.add(user.id!);
        }

      }
    }

    return _usersIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getUsersPics(List<UserModel>? usersModels){
    final List<String> _pics = <String>[];

    if (Mapper.checkCanLoopList(usersModels) == true){
      for (final UserModel user in usersModels!){
        if (user.picPath != null){
          _pics.add(user.picPath!);
        }
      }
    }

    return _pics;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getUserEmail(UserModel? user){
    if (user == null){
      return null;
    }
    else {
      return ContactModel.getContactFromContacts(
        contacts: user.contacts,
        type: ContactType.email,
      )?.value;
    }
  }
  // --------------------
  /// TASK TEST ME
  static List<UserModel> getSignedUpUsersOnly({
    required List<UserModel> users,
  }){
    final List<UserModel> _output = [];

    if (Mapper.checkCanLoopList(users) == true){

      for (final UserModel user in users){

        if (user.signInMethod != SignInMethod.anonymous){
          _output.add(user);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TASK TEST ME
  static UserModel? getFirstAnonymousUserFromUsers({
    required List<UserModel> users,
  }){
    UserModel? _output;

    if (Mapper.checkCanLoopList(users) == true){

      for (final UserModel user in users){

        if (user.signInMethod == SignInMethod.anonymous){
          _output = user;
          break;
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// USERS MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<UserModel> addOrRemoveUserToUsers({
    required List<UserModel>? usersModels,
    required UserModel? userModel,
  }){
    final List<UserModel> _output = <UserModel>[...?usersModels];

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
    required List<UserModel>? usersToGet,
    required UserModel? userToAdd,
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
    required List<UserModel>? usersToGet,
    required List<UserModel>? usersToAdd,
  }){

    List<UserModel> _output = [...?usersToGet];

    if (Mapper.checkCanLoopList(usersToAdd) == true){

      for (final UserModel user in usersToAdd!){

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
  static UserModel? addBzIDToUserBzzIDs({
    required UserModel? oldUser,
    required String? bzIDToAdd,
  }){

    final List<String> _newBzzIDs = Stringer.addStringToListIfDoesNotContainIt(
      strings: oldUser?.myBzzIDs,
      stringToAdd: bzIDToAdd,
    );

    final UserModel? _newUser = oldUser?.copyWith(
      myBzzIDs: _newBzzIDs,
    );

    return _newUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel? removeBzIDFromUserBzzIDs({
    required UserModel? oldUser,
    required String? bzIDToRemove,
  }){
    UserModel? _newUser = oldUser;

    if (Mapper.checkCanLoopList(oldUser?.myBzzIDs) == true && bzIDToRemove != null) {

      final List<String> _newList = Stringer.removeStringsFromStrings(
        removeFrom: oldUser!.myBzzIDs,
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
  static UserModel? addBzIDToUserFollows({
    required UserModel? oldUser,
    required BzModel? bzToFollow,
  }){

    final AgendaModel _newFollows = AgendaModel.addBz(
      bzModel: bzToFollow,
      oldAgenda: oldUser?.followedBzz,
    );

    final UserModel? _newUser = oldUser?.copyWith(
      followedBzz: _newFollows,
    );

    return _newUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel? removeBzIDFromUserFollows({
    required UserModel? oldUser,
    required String? bzIDToUnFollow,
  }){


    final AgendaModel _newFollows = AgendaModel.removeBzByID(
        oldAgenda: oldUser?.followedBzz,
        bzID: bzIDToUnFollow,
    );

    final UserModel? _newUser = oldUser?.copyWith(
      followedBzz: _newFollows,
    );

    return _newUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel? addFlyerToSavedFlyers({
    required UserModel? oldUser,
    required FlyerModel? flyerModel,
  }){

    final DeckModel _newSavedFlyers = DeckModel.addFlyer(
        flyer: flyerModel,
        oldDeck: oldUser?.savedFlyers,
    );

    final UserModel? _newUser = oldUser?.copyWith(
      savedFlyers: _newSavedFlyers,
    );

    return _newUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel? removeFlyerFromSavedFlyers({
    required UserModel? oldUser,
    required String? flyerIDToRemove,
  }){

    final DeckModel _newSavedFlyers = DeckModel.removeFlyerByID(
        oldDeck: oldUser?.savedFlyers,
        flyerID: flyerIDToRemove
    );

    final UserModel? _newUser = oldUser?.copyWith(
      savedFlyers: _newSavedFlyers,
    );

    return _newUser;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel? addAllBzTopicsToMyTopics({
    required UserModel? oldUser,
    required String? bzID,
  }){
    UserModel? _newUser = oldUser;

    if (bzID != null && _newUser != null){

      List<String> userTopics = <String>[...?_newUser.fcmTopics];

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
  static UserModel? removeAllBzTopicsFromMyTopics({
    required UserModel? oldUser,
    required String? bzID,
  }){
    UserModel? _newUser = oldUser;

    if (bzID != null && _newUser != null){

      List<String> userTopics = <String>[...?_newUser.fcmTopics];

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
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<UserModel> cleanDuplicateUsers({
    required List<UserModel>? users,
  }){
    final List<UserModel> _output = [];

    if (Mapper.checkCanLoopList(users) == true) {
      for (final UserModel model in users!) {
        final bool _contains = checkUsersContainUser(
          usersModels: _output,
          userModel: model,
        );

        if (_contains == false) {
          _output.add(model);
        }
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogUserModel({
    String? invoker = 'BLOGGING USER MODEL',
  }) {
    blog('$invoker : ---------------- START -- ');

    blog('id : $id');
    blog('signInMethod : $signInMethod');
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
    blog('isAuthor : $isAuthor');
    blog('isAdmin : $isAdmin');
    blog('emailIsVerified : $emailIsVerified');
    blog('docSnapshot : $docSnapshot');
    zone?.blogZone();
    need?.blogNeed();
    blog('contactsArePublic : $contactsArePublic');
    blog('savedFlyers : $savedFlyers');
    blog('followedBzz : $followedBzz');
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
    required List<UserModel> usersModels,
    String? invoker,
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
    required UserModel? user1,
    required UserModel? user2,
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

      if (user1.signInMethod != user2.signInMethod){
        blog('blogUserDifferences : [signInMethod] are not identical');
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

      if (user1.isAuthor != user2.isAuthor){
        blog('blogUserDifferences : [isAuthors] are not identical');
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

      if (AgendaModel.checkAgendasAreIdentical(agenda1: user1.followedBzz, agenda2: user2.followedBzz) == false){
        blog('blogUserDifferences : [followedBzz] are not identical');
      }

      if (AppStateModel.checkAppStatesAreIdentical(state1: user1.appState, state2: user2.appState, isInUserModel: true) == false){
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
  static UserModel dummyUserModel(){

    final UserModel _userModel = UserModel(
      id: 'dummy_user_model',
      signInMethod: SignInMethod.password,
      createdAt: Timers.createDate(year: 1987, month: 06, day: 10),
      need: NeedModel.dummyNeed(),
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
      isAuthor: false,
      emailIsVerified: true,
      isAdmin: true,
      device: null,
      savedFlyers: DeckModel.newDeck(),
      followedBzz: AgendaModel.newAgenda(),
      appState: AppStateModel.dummyAppState(),
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

  /// ANONYMOUS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<UserModel?> anonymousUser({
    required AuthModel? authModel,
  }) async {

    if (authModel == null){
      return null;
    }

    else {

      final ZoneModel? _currentZone = await ZoneProtocols.getZoneByIP();

      return UserModel(
        id: authModel.id,
        signInMethod: SignInMethod.anonymous,
        createdAt: DateTime.now(),
        need: NeedModel.createInitialNeed(userZone: _currentZone),
        name: authModel.name,
        trigram: const [],
        picPath: Iconz.anonymousUser,
        title: '',
        company: '',
        gender: null,
        zone: _currentZone,
        language: Localizer.getCurrentLangCode(),
        location: null,
        contacts: ContactModel.generateBasicContacts(
          email: authModel.email,
          phone: authModel.phone,
        ),
        contactsArePublic: false,
        myBzzIDs: const <String>[],
        isAuthor: false,
        emailIsVerified: false,
        isAdmin: false,
        device: await DeviceModel.generateDeviceModel(),
        fcmTopics: TopicModel.getAllPossibleUserTopicsIDs(),
        savedFlyers: DeckModel.newDeck(),
        followedBzz: AgendaModel.newAgenda(),
        /// BY THE TIME WE ARE CREATING AN ANONYMOUS USER, WE DON'T HAVE PERMISSION TO READ THIS
        appState: null, //await AppStateProtocols.fetchGlobalAppState(),
    );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String createAnonymousEmail(){
    final int _uniqueKey = Numeric.createUniqueID(maxDigitsCount: 10);
    return 'bldr_$_uniqueKey@bldrs.net';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? createAnonymousPassword({
    required String? anonymousEmail,
  }){
    String? _pass;

    final bool _isAnonymous = checkIsAnonymousEmail(
      email: anonymousEmail,
    );

    if (_isAnonymous == true){

      String? _source = TextMod.removeTextAfterLastSpecialCharacter(
          text: anonymousEmail,
          specialCharacter: '@',
      );

      _source = TextMod.removeTextBeforeFirstSpecialCharacter(
          text: _source,
          specialCharacter: '_',
      );

      final int? _num = Numeric.transformStringToInt(_source);

      if (_num != null){

        double? _figure = (_num * 2) / 7;
        _figure = Numeric.removeFractions(number: _figure);

        if (_figure != null){
          _figure = Numeric.removeFractions(number: _figure / 2);
          final String _stringified = Numeric.formatNumToSeparatedKilos(
            number: _figure,
            fractions: 0,
            separator: '&',
          );
          _pass = 'Bojo@$_stringified';
        }

      }

    }

    return _pass;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsAnonymousEmail({
    required String? email,
  }){

    if (email == null){
      return false;
    }
    else {

      final String? _bldr_ = TextMod.removeTextAfterFirstSpecialCharacter(
        text: email,
        specialCharacter: '_',
      );

      return _bldr_ == 'bldr';
    }

  }
  // -----------------------------------------------------------------------------

  /// CHECKUPS

  // --------------------
   /// TESTED : WORKS PERFECT
  static bool usersAreIdentical({
    required UserModel? user1,
    required UserModel? user2,
  }){
    bool _identical = false;

    if (user1 == null && user2 == null){
      _identical = true;
    }

    else if (user1 != null && user2 != null){

      if (
          user1.id == user2.id &&
          user1.signInMethod == user2.signInMethod &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: user1.createdAt, time2: user2.createdAt) == true &&
          NeedModel.checkNeedsAreIdentical(user1.need, user2.need) == true &&
          user1.name == user2.name &&
          Mapper.checkListsAreIdentical(list1: user1.trigram, list2: user2.trigram) == true &&
          user1.picPath == user2.picPath &&
          user1.title == user2.title &&
          user1.company == user2.company &&
          user1.gender == user2.gender &&
          ZoneModel.checkZonesIDsAreIdentical(zone1: user1.zone, zone2: user2.zone) == true &&
          user1.language == user2.language &&
          Atlas.checkPointsAreIdentical(point1: user1.location, point2: user2.location) == true &&
          ContactModel.checkContactsListsAreIdentical(contacts1: user1.contacts, contacts2: user2.contacts) == true &&
          user1.contactsArePublic == user2.contactsArePublic &&
          Mapper.checkListsAreIdentical(list1: user1.myBzzIDs, list2: user2.myBzzIDs) == true &&
          user1.isAuthor == user2.isAuthor &&
          user1.emailIsVerified == user2.emailIsVerified &&
          user1.isAdmin == user2.isAdmin &&
          DeckModel.checkDecksAreIdentical(deck1: user1.savedFlyers, deck2: user2.savedFlyers) == true &&
          AgendaModel.checkAgendasAreIdentical(agenda1: user1.followedBzz, agenda2: user2.followedBzz) == true &&
          AppStateModel.checkAppStatesAreIdentical(state1: user1.appState, state2: user2.appState, isInUserModel: true) == true &&
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
      signInMethod.hashCode^
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
      isAuthor.hashCode^
      emailIsVerified.hashCode^
      isAdmin.hashCode^
      device.hashCode^
      fcmTopics.hashCode^
      savedFlyers.hashCode^
      followedBzz.hashCode^
      appState.hashCode^
      docSnapshot.hashCode;
  // -----------------------------------------------------------------------------
}
