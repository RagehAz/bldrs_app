import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// => TAMAM
@immutable
class DraftUser {
  /// --------------------------------------------------------------------------
  const DraftUser({
    @required this.id,
    @required this.authBy,
    @required this.createdAt,
    @required this.need,
    @required this.name,
    @required this.trigram,
    @required this.picModel,
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
    @required this.savedFlyersIDs,
    @required this.followedBzzIDs,
    @required this.appState,
    @required this.hasNewPic,
    @required this.nameController,
    @required this.titleController,
    @required this.companyController,
    @required this.emailController,
    @required this.phoneController,
    @required this.nameNode,
    @required this.titleNode,
    @required this.companyNode,
    @required this.emailNode,
    @required this.phoneNode,
    @required this.formKey,
    @required this.canPickImage,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final AuthType authBy;
  final DateTime createdAt;
  final NeedModel need;
  final String name;
  final List<String> trigram;
  final PicModel picModel;
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
  final List<String> savedFlyersIDs;
  final List<String> followedBzzIDs;
  final AppState appState;
  final bool hasNewPic;
  final TextEditingController nameController;
  final TextEditingController titleController;
  final TextEditingController companyController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final FocusNode nameNode;
  final FocusNode titleNode;
  final FocusNode companyNode;
  final FocusNode emailNode;
  final FocusNode phoneNode;
  final GlobalKey<FormState> formKey;
  final bool canPickImage;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftUser> createDraftUser({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {
    DraftUser _draft;

    if (userModel != null){

      final List<ContactModel> _contacts = ContactModel.prepareContactsForEditing(
        contacts: userModel.contacts,
        countryID: userModel.zone.countryID,
      );

      final String _email = ContactModel.getContactFromContacts(
        contacts: userModel.contacts,
        type: ContactType.email,
      )?.value;

      final String _phone = ContactModel.getContactFromContacts(
        contacts: userModel.contacts,
        type: ContactType.phone,
      )?.value;

      _draft = DraftUser(
        id: userModel.id,
        authBy: userModel.authBy,
        createdAt: userModel.createdAt,
        need: userModel.need,
        name: userModel.name,
        trigram: userModel.trigram,
        picModel: await PicProtocols.fetchPic(userModel.picPath),
        title: userModel.title,
        company: userModel.company,
        gender: userModel.gender,
        zone: await ZoneModel.prepareZoneForEditing(
          context: context,
          zoneModel: userModel.zone,
        ),
        language: userModel.language,
        location: userModel.location,
        contacts: _contacts,
        contactsArePublic: userModel.contactsArePublic,
        myBzzIDs: userModel.myBzzIDs,
        emailIsVerified: userModel.emailIsVerified,
        isAdmin: userModel.isAdmin,
        device: userModel.device,
        fcmTopics: userModel.fcmTopics,
        savedFlyersIDs: userModel.savedFlyersIDs,
        followedBzzIDs: userModel.followedBzzIDs,
        appState: userModel.appState,
        hasNewPic: false,
        canPickImage: true,
        formKey: GlobalKey<FormState>(),
          nameController: TextEditingController(text: userModel.name),
          titleController: TextEditingController(text: userModel.title),
          companyController: TextEditingController(text: userModel.company),
          emailController: TextEditingController(text: _email),
          phoneController: TextEditingController(text: _phone),
        companyNode: FocusNode(),
        emailNode: FocusNode(),
        nameNode: FocusNode(),
        phoneNode: FocusNode(),
        titleNode: FocusNode(),
      );

    }

    return _draft;
  }

  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  /// TESTED : WORKS PERFECT
  void dispose(){
    nameNode.dispose();
    titleNode.dispose();
    companyNode.dispose();
    emailNode.dispose();
    phoneNode.dispose();
    nameController.dispose();
    titleController.dispose();
    companyController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  DraftUser copyWith({
    String id,
    AuthType authBy,
    DateTime createdAt,
    NeedModel need,
    String name,
    List<String> trigram,
    PicModel picModel,
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
    List<String> savedFlyersIDs,
    List<String> followedBzzIDs,
    AppState appState,
    List<String> fcmTopics,
    bool hasNewPic,
    FocusNode nameNode,
    FocusNode titleNode,
    FocusNode companyNode,
    FocusNode emailNode,
    FocusNode phoneNode,
    GlobalKey<FormState> formKey,
    bool canPickImage,
    TextEditingController nameController,
    TextEditingController titleController,
    TextEditingController companyController,
    TextEditingController emailController,
    TextEditingController phoneController,
  }){
    return DraftUser(
      id: id ?? this.id,
      authBy: authBy ?? this.authBy,
      createdAt: createdAt ?? this.createdAt,
      need: need ?? this.need,
      name: name ?? this.name,
      trigram: trigram ?? this.trigram,
      picModel: picModel ?? this.picModel,
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
      savedFlyersIDs: savedFlyersIDs ?? this.savedFlyersIDs,
      followedBzzIDs: followedBzzIDs ?? this.followedBzzIDs,
      appState: appState ?? this.appState,
      fcmTopics: fcmTopics ?? this.fcmTopics,
      hasNewPic: hasNewPic ?? this.hasNewPic,
      nameController: nameController ?? this.nameController,
      titleController: titleController ?? this.titleController,
      companyController: companyController ?? this.companyController,
      emailController: emailController ?? this.emailController,
      phoneController: phoneController ?? this.phoneController,
      nameNode: nameNode ?? this.nameNode,
      titleNode: titleNode ?? this.titleNode,
      companyNode: companyNode ?? this.companyNode,
      emailNode: emailNode ?? this.emailNode,
      phoneNode: phoneNode ?? this.phoneNode,
      formKey: formKey ?? this.formKey,
      canPickImage: canPickImage ?? this.canPickImage,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  DraftUser nullifyField({
    bool id = false,
    bool authBy = false,
    bool createdAt = false,
    bool need = false,
    bool name = false,
    bool trigram = false,
    bool picModel = false,
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
    bool savedFlyersIDs = false,
    bool followedBzzIDs = false,
    bool appState = false,
    bool fcmTopics = false,
    bool hasNewPic = false,
    bool nameController,
    bool titleController,
    bool companyController,
    bool emailController,
    bool phoneController,
    bool nameNode = false,
    bool titleNode = false,
    bool companyNode = false,
    bool emailNode = false,
    bool phoneNode = false,
    bool formKey = false,
    bool canPickImage = false,
  }){
    return DraftUser(
      id : id == true ? null : this.id,
      authBy : authBy == true ? null : this.authBy,
      createdAt : createdAt == true ? null : this.createdAt,
      need : need == true ? null : this.need,
      name : name == true ? null : this.name,
      trigram : trigram == true ? const [] : this.trigram,
      picModel : picModel == true ? null : this.picModel,
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
      savedFlyersIDs : savedFlyersIDs == true ? const [] : this.savedFlyersIDs,
      followedBzzIDs : followedBzzIDs == true ? const [] : this.followedBzzIDs,
      appState : appState == true ? null : this.appState,
      fcmTopics: fcmTopics == true ? const [] : this.fcmTopics,
      hasNewPic: hasNewPic == true ? null : this.hasNewPic,
      nameController: nameController == true ? null : this.nameController,
      titleController: titleController == true ? null : this.titleController,
      companyController: companyController == true ? null : this.companyController,
      emailController: emailController == true ? null : this.emailController,
      phoneController: phoneController == true ? null : this.phoneController,
      nameNode: nameNode == true ? null : this.nameNode,
      titleNode: titleNode == true ? null : this.titleNode,
      companyNode: companyNode == true ? null : this.companyNode,
      emailNode: emailNode == true ? null : this.emailNode,
      phoneNode: phoneNode == true ? null : this.phoneNode,
      formKey: formKey == true ? null : this.formKey,
      canPickImage: canPickImage == true ? null : this.canPickImage,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toLDB() {
    return <String, dynamic>{
      'id': id,
      'authBy': AuthModel.cipherAuthBy(authBy),
      'createdAt': Timers.cipherTime(time: createdAt, toJSON: true),
      'need': need?.toMap(toJSON: true),
      // -------------------------
      'name': nameController.text ?? name,
      'trigram': trigram,
      'picModel': PicModel.cipherToLDB(picModel),
      'title': titleController.text ?? title,
      'company': companyController.text ?? company,
      'gender': UserModel.cipherGender(gender),
      'zone': zone?.toMap(),
      'language': language,
      'location': Atlas.cipherGeoPoint(point: location, toJSON: true),
      'contacts': ContactModel.cipherContacts(contacts),
      'contactsArePublic': contactsArePublic,
      // -------------------------
      'myBzzIDs': myBzzIDs ?? <String>[],
      'emailIsVerified': emailIsVerified,
      'isAdmin': isAdmin,
      'device': device?.toMap(),
      'fcmTopics': fcmTopics,
      'savedFlyersIDs': savedFlyersIDs ?? <String>[],
      'followedBzzIDs': followedBzzIDs ?? <String>[],
      'appState' : appState.toMap(),
      'hasNewPic' : hasNewPic,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DraftUser fromLDB(Map<String, dynamic> map) {
    return map == null ? null :
    DraftUser(
      id: map['id'],
      authBy: AuthModel.decipherAuthBy(map['authBy']),
      createdAt: Timers.decipherTime(time: map['createdAt'], fromJSON: true),
      need: NeedModel.decipherNeed(map: map['need'], fromJSON: true),
      name: map['name'],
      trigram: Stringer.getStringsFromDynamics(dynamics: map['trigram'],),
      picModel: PicModel.decipherFromLDB(map['picModel']),
      title: map['title'],
      company: map['company'],
      gender: UserModel.decipherGender(map['gender']),
      zone: ZoneModel.decipherZone(map['zone']),
      language: map['language'] ?? 'en',
      location: Atlas.decipherGeoPoint(point: map['location'], fromJSON: true),
      contacts: ContactModel.decipherContacts(map['contacts']),
      contactsArePublic: map['contactsArePublic'],
      myBzzIDs: Stringer.getStringsFromDynamics(dynamics: map['myBzzIDs'],),
      emailIsVerified: map['emailIsVerified'],
      isAdmin: map['isAdmin'],
      device: DeviceModel.decipherFCMToken(map['device']),
      fcmTopics: Stringer.getStringsFromDynamics(dynamics: map['fcmTopics']),
      savedFlyersIDs: Stringer.getStringsFromDynamics(dynamics: map['savedFlyersIDs'],),
      followedBzzIDs: Stringer.getStringsFromDynamics(dynamics: map['followedBzzIDs'],),
      appState: AppState.fromMap(map['appState']),
      hasNewPic: map['hasNewPic'],
      nameController: null,
      titleController: null,
      companyController: null,
      emailController: null,
      phoneController: null,
      nameNode: null,
      titleNode: null,
      companyNode: null,
      emailNode: null,
      phoneNode: null,
      formKey: null,
      canPickImage: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static UserModel toUserModel({
    @required BuildContext context,
    @required DraftUser draft,
  }){

    final String _name = draft.nameController.text ?? draft.name;



    return UserModel(

      /// NEEDS BAKING
      picPath: draft.picModel.path,
      contacts: ContactModel.bakeContactsAfterEditing(
        contacts: draft.contacts,
        countryID: draft.zone.countryID,
      ),


      /// NO BAKING NEEDED
      id: draft.id,
      authBy: draft.authBy,
      createdAt: draft.createdAt,
      need: draft.need,
      name: _name,
      trigram: Stringer.createTrigram(input: _name),
      title: draft.titleController.text ?? draft.title,
      company: draft.companyController.text ?? draft.company,
      gender: draft.gender,
      zone: draft.zone,
      language: draft.language ?? Words.languageCode(context),
      location: draft.location,
      contactsArePublic: draft.contactsArePublic,
      myBzzIDs: draft.myBzzIDs,
      emailIsVerified: draft.emailIsVerified,
      isAdmin: draft.isAdmin,
      device: draft.device,
      fcmTopics: draft.fcmTopics,
      savedFlyersIDs: draft.savedFlyersIDs,
      followedBzzIDs: draft.followedBzzIDs,
      appState: draft.appState,
    );

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static void triggerCanPickImage({
    @required ValueNotifier<DraftUser> draftUser,
    @required bool setTo,
    @required bool mounted,
  }){

    setNotifier(
        notifier: draftUser,
        mounted: mounted,
        value: draftUser.value.copyWith(
          canPickImage: setTo,
        ),
    );

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAreIdentical({
    @required DraftUser draft1,
    @required DraftUser draft2,
  }){
    bool _identical = false;

    if (draft1 == null && draft2 == null){
      _identical = true;
    }

    else if (draft1 != null && draft2 != null){

      if (
          draft1.id == draft2.id &&
          draft1.authBy == draft2.authBy &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: draft1.createdAt, time2: draft2.createdAt) == true &&
          NeedModel.checkNeedsAreIdentical(draft1.need, draft2.need) == true &&
          draft1.name == draft2.name &&
          Mapper.checkListsAreIdentical(list1: draft1.trigram, list2: draft2.trigram) == true &&
          PicModel.checkPicsAreIdentical(pic1: draft1.picModel, pic2: draft2.picModel) == true &&
          draft1.title == draft2.title &&
          draft1.company == draft2.company &&
          draft1.gender == draft2.gender &&
          ZoneModel.checkZonesAreIdentical(zone1: draft1.zone, zone2: draft2.zone) == true &&
          draft1.language == draft2.language &&
          Atlas.checkPointsAreIdentical(point1: draft1.location, point2: draft2.location) == true &&
          ContactModel.checkContactsListsAreIdentical(contacts1: draft1.contacts, contacts2: draft2.contacts) == true &&
          draft1.contactsArePublic == draft2.contactsArePublic &&
          Mapper.checkListsAreIdentical(list1: draft1.myBzzIDs, list2: draft2.myBzzIDs) == true &&
          draft1.emailIsVerified == draft2.emailIsVerified &&
          draft1.isAdmin == draft2.isAdmin &&
          Mapper.checkListsAreIdentical(list1: draft1.savedFlyersIDs, list2: draft2.savedFlyersIDs) == true &&
          Mapper.checkListsAreIdentical(list1: draft1.followedBzzIDs, list2: draft2.followedBzzIDs) == true &&
          AppState.checkAppStatesAreIdentical(appState1: draft1.appState, appState2: draft2.appState) == true &&
          DeviceModel.checkDevicesAreIdentical(device1: draft1.device, device2: draft2.device) == true &&
          Mapper.checkListsAreIdentical(list1: draft1.fcmTopics, list2: draft2.fcmTopics) == true &&
          draft1.nameController.text == draft2.nameController.text &&
          draft1.titleController.text == draft2.titleController.text &&
          draft1.companyController.text == draft2.companyController.text &&
          draft1.emailController.text == draft2.emailController.text &&
          draft1.phoneController.text == draft2.phoneController.text &&
          draft1.hasNewPic == draft2.hasNewPic
      ){
        _identical = true;
      }

    }

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
    if (other is DraftUser){
      _areIdentical = checkAreIdentical(
        draft1: this,
        draft2: other,
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
      picModel.hashCode^
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
      savedFlyersIDs.hashCode^
      followedBzzIDs.hashCode^
      appState.hashCode^
      hasNewPic.hashCode^
      nameController.hashCode^
      titleController.hashCode^
      companyController.hashCode^
      emailController.hashCode^
      phoneController.hashCode^
      nameNode.hashCode^
      titleNode.hashCode^
      companyNode.hashCode^
      emailNode.hashCode^
      phoneNode.hashCode^
      formKey.hashCode^
      canPickImage.hashCode;
  /// --------------------------------------------------------------------------
}