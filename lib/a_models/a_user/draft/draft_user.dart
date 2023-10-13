import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/space/atlas.dart';
import 'package:bldrs/a_models/a_user/sub/agenda_model.dart';
import 'package:bldrs/a_models/a_user/sub/deck_model.dart';
import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/e_notes/aa_device_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_secondary/app_state_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/time/timers.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';

/// => TAMAM
@immutable
class DraftUser {
  /// --------------------------------------------------------------------------
  const DraftUser({
    required this.id,
    required this.signInMethod,
    required this.createdAt,
    required this.need,
    required this.name,
    required this.trigram,
    required this.picModel,
    required this.title,
    required this.company,
    required this.gender,
    required this.zone,
    required this.language,
    required this.location,
    required this.contacts,
    required this.contactsArePublic,
    required this.myBzzIDs,
    required this.emailIsVerified,
    required this.isAdmin,
    required this.device,
    required this.fcmTopics,
    required this.savedFlyers,
    required this.followedBzz,
    required this.appState,
    required this.hasNewPic,
    required this.nameController,
    required this.titleController,
    required this.companyController,
    required this.emailController,
    required this.phoneController,
    required this.nameNode,
    required this.titleNode,
    required this.companyNode,
    required this.emailNode,
    required this.phoneNode,
    required this.formKey,
    required this.canPickImage,
  });
  /// --------------------------------------------------------------------------
  final String? id;
  final SignInMethod? signInMethod;
  final DateTime? createdAt;
  final NeedModel? need;
  final String? name;
  final List<String>? trigram;
  final PicModel? picModel;
  final String? title;
  final String? company;
  final Gender? gender;
  final ZoneModel? zone;
  final String? language;
  final GeoPoint? location;
  final List<ContactModel>? contacts;
  final bool? contactsArePublic;
  final List<String>? myBzzIDs;
  final bool? emailIsVerified;
  final bool? isAdmin;
  final DeviceModel? device;
  final List<String>? fcmTopics;
  final DeckModel? savedFlyers;
  final AgendaModel? followedBzz;
  final AppStateModel? appState;
  final bool? hasNewPic;
  final TextEditingController? nameController;
  final TextEditingController? titleController;
  final TextEditingController? companyController;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;
  final FocusNode? nameNode;
  final FocusNode? titleNode;
  final FocusNode? companyNode;
  final FocusNode? emailNode;
  final FocusNode? phoneNode;
  final GlobalKey<FormState>? formKey;
  final bool? canPickImage;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftUser?> createDraftUser({
    required BuildContext context,
    required UserModel? userModel,
    required bool firstTimer,
  }) async {
    DraftUser? _draft;

    if (userModel != null){

      final List<ContactModel> _contacts = ContactModel.prepareContactsForEditing(
        contacts: userModel.contacts,
        countryID: userModel.zone?.countryID,
      );

      final String? _email = UserModel.getUserEmail(userModel);

      final String? _phone = ContactModel.getContactFromContacts(
        contacts: userModel.contacts,
        type: ContactType.phone,
      )?.value;
      
      final PicModel? _picModel = await _createPicFromUserModelForDraft(
        firstTimer: firstTimer,
        userModel: userModel,
      );

      _draft = DraftUser(
        id: userModel.id,
        signInMethod: userModel.signInMethod,
        createdAt: userModel.createdAt,
        need: userModel.need,
        name: userModel.name,
        trigram: userModel.trigram,
        picModel: _picModel,
        title: userModel.title,
        company: userModel.company,
        gender: userModel.gender,
        zone: await ZoneModel.prepareZoneForEditing(
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
        savedFlyers: userModel.savedFlyers,
        followedBzz: userModel.followedBzz,
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<PicModel?> _createPicFromUserModelForDraft({
    required UserModel? userModel,
    required bool firstTimer,
  }) async {
    PicModel? _output;

    if (userModel != null){

      // bool _shouldFetch = false;
      // switch (userModel.signInMethod){
      //   case SignInMethod.anonymous: _shouldFetch = false; break;
      //   case SignInMethod.password:  _shouldFetch = false; break;
      //   case SignInMethod.google:    _shouldFetch = true; break;
      //   case SignInMethod.facebook:  _shouldFetch = true; break;
      //   case SignInMethod.apple:     _shouldFetch = true; break;
      //   default: _shouldFetch = false;
      // }
      //
      // if (_shouldFetch == true){
        _output = await PicProtocols.fetchPic(userModel.picPath);
      // }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  /// TESTED : WORKS PERFECT
  void dispose(){
    nameNode?.dispose();
    titleNode?.dispose();
    companyNode?.dispose();
    emailNode?.dispose();
    phoneNode?.dispose();
    nameController?.dispose();
    titleController?.dispose();
    companyController?.dispose();
    emailController?.dispose();
    phoneController?.dispose();
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  DraftUser copyWith({
    String? id,
    SignInMethod? signInMethod,
    DateTime? createdAt,
    NeedModel? need,
    String? name,
    List<String>? trigram,
    PicModel? picModel,
    String? title,
    String? company,
    Gender? gender,
    ZoneModel? zone,
    String? language,
    GeoPoint? location,
    List<ContactModel>? contacts,
    bool? contactsArePublic,
    List<String>? myBzzIDs,
    bool? emailIsVerified,
    bool? isAdmin,
    DeviceModel? device,
    DeckModel? savedFlyers,
    AgendaModel? followedBzz,
    AppStateModel? appState,
    List<String>? fcmTopics,
    bool? hasNewPic,
    FocusNode? nameNode,
    FocusNode? titleNode,
    FocusNode? companyNode,
    FocusNode? emailNode,
    FocusNode? phoneNode,
    GlobalKey<FormState>? formKey,
    bool? canPickImage,
    TextEditingController? nameController,
    TextEditingController? titleController,
    TextEditingController? companyController,
    TextEditingController? emailController,
    TextEditingController? phoneController,
  }){
    return DraftUser(
      id: id ?? this.id,
      signInMethod: signInMethod ?? this.signInMethod,
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
      savedFlyers: savedFlyers ?? this.savedFlyers,
      followedBzz: followedBzz ?? this.followedBzz,
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
    bool signInMethod = false,
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
    bool savedFlyers = false,
    bool followedBzz = false,
    bool appState = false,
    bool fcmTopics = false,
    bool hasNewPic = false,
    bool nameController = false,
    bool titleController = false,
    bool companyController = false,
    bool emailController = false,
    bool phoneController = false,
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
      signInMethod : signInMethod == true ? null : this.signInMethod,
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
      savedFlyers : savedFlyers == true ? DeckModel.newDeck() : this.savedFlyers,
      followedBzz : followedBzz == true ? AgendaModel.newAgenda() : this.followedBzz,
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
      'signInMethod': AuthModel.cipherSignInMethod(signInMethod),
      'createdAt': Timers.cipherTime(time: createdAt, toJSON: true),
      'need': need?.toMap(toJSON: true),
      // -------------------------
      'name': nameController?.text ?? name,
      'trigram': trigram,
      'picModel': PicModel.cipherToLDB(picModel),
      'title': titleController?.text ?? title,
      'company': companyController?.text ?? company,
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
      'savedFlyers': savedFlyers?.toMap(),
      'followedBzz': followedBzz?.toMap(),
      'appState' : appState?.toMap(toUserModel: true),
      'hasNewPic' : hasNewPic,
      // -------------------------
      // nameController: null,
      // titleController: null,
      // companyController: null,
      // emailController: null,
      // phoneController: null,
      // nameNode: null,
      // titleNode: null,
      // companyNode: null,
      // emailNode: null,
      // phoneNode: null,
      // formKey: null,
      // canPickImage: true,

    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DraftUser? fromLDB(Map<String, dynamic>? map) {
    return map == null ? null :
    DraftUser(
      id: map['id'],
      signInMethod: AuthModel.decipherSignInMethod(map['signInMethod']),
      createdAt: Timers.decipherTime(time: map['createdAt'], fromJSON: true),
      need: NeedModel.decipherNeed(map: map['need'], fromJSON: true),
      // -------------------------
      name: map['name'],
      trigram: Stringer.getStringsFromDynamics(map['trigram']),
      picModel: PicModel.decipherFromLDB(map['picModel']),
      title: map['title'],
      company: map['company'],
      gender: UserModel.decipherGender(map['gender']),
      zone: ZoneModel.decipherZone(map['zone']),
      language: map['language'] ?? 'en',
      location: Atlas.decipherGeoPoint(point: map['location'], fromJSON: true),
      contacts: ContactModel.decipherContacts(map['contacts']),
      contactsArePublic: map['contactsArePublic'],
      // -------------------------
      myBzzIDs: Stringer.getStringsFromDynamics(map['myBzzIDs']),
      emailIsVerified: map['emailIsVerified'],
      isAdmin: map['isAdmin'],
      device: DeviceModel.decipherDeviceModel(map['device']),
      fcmTopics: Stringer.getStringsFromDynamics(map['fcmTopics']),
      savedFlyers: DeckModel.decipher(map['savedFlyers']),
      followedBzz: AgendaModel.decipher(map['followedBzz']),
      appState: AppStateModel.fromMap(map: map['appState']),
      hasNewPic: map['hasNewPic'],
      // -------------------------
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
  static UserModel? toUserModel({
    required DraftUser? draft,
  }){

    final String? _name = draft?.nameController?.text ?? draft?.name;

    return UserModel(

      /// NEEDS BAKING
      picPath: draft?.picModel?.path,
      contacts: ContactModel.bakeContactsAfterEditing(
        contacts: draft?.contacts,
        countryID: draft?.zone?.countryID,
      ),


      /// NO BAKING NEEDED
      id: draft?.id,
      signInMethod: draft?.signInMethod,
      createdAt: draft?.createdAt,
      need: draft?.need,
      name: _name,
      trigram: Stringer.createTrigram(input: _name),
      title: draft?.titleController?.text ?? draft?.title,
      company: draft?.companyController?.text ?? draft?.company,
      gender: draft?.gender,
      zone: draft?.zone,
      language: draft?.language ?? Localizer.getCurrentLangCode(),
      location: draft?.location,
      contactsArePublic: draft?.contactsArePublic,
      myBzzIDs: draft?.myBzzIDs,
      isAuthor: Mapper.checkCanLoopList(draft?.myBzzIDs),
      emailIsVerified: draft?.emailIsVerified,
      isAdmin: draft?.isAdmin,
      device: draft?.device,
      fcmTopics: draft?.fcmTopics,
      savedFlyers: draft?.savedFlyers,
      followedBzz: draft?.followedBzz,
      appState: draft?.appState,
    );

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static void triggerCanPickImage({
    required ValueNotifier<DraftUser?> draftUser,
    required bool setTo,
    required bool mounted,
  }){

    setNotifier(
        notifier: draftUser,
        mounted: mounted,
        value: draftUser.value?.copyWith(
          canPickImage: setTo,
        ),
    );

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAreIdentical({
    required DraftUser? draft1,
    required DraftUser? draft2,
  }){
    bool _identical = false;

    if (draft1 == null && draft2 == null){
      _identical = true;
    }

    else if (draft1 != null && draft2 != null){

      if (
          draft1.id == draft2.id &&
          draft1.signInMethod == draft2.signInMethod &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: draft1.createdAt, time2: draft2.createdAt) == true &&
          NeedModel.checkNeedsAreIdentical(draft1.need, draft2.need) == true &&
          draft1.name == draft2.name &&
          Mapper.checkListsAreIdentical(list1: draft1.trigram, list2: draft2.trigram) == true &&
          PicModel.checkPicsAreIdentical(pic1: draft1.picModel, pic2: draft2.picModel) == true &&
          draft1.title == draft2.title &&
          draft1.company == draft2.company &&
          draft1.gender == draft2.gender &&
          ZoneModel.checkZonesIDsAreIdentical(zone1: draft1.zone, zone2: draft2.zone) == true &&
          draft1.language == draft2.language &&
          Atlas.checkPointsAreIdentical(point1: draft1.location, point2: draft2.location) == true &&
          ContactModel.checkContactsListsAreIdentical(contacts1: draft1.contacts, contacts2: draft2.contacts) == true &&
          draft1.contactsArePublic == draft2.contactsArePublic &&
          Mapper.checkListsAreIdentical(list1: draft1.myBzzIDs, list2: draft2.myBzzIDs) == true &&
          draft1.emailIsVerified == draft2.emailIsVerified &&
          draft1.isAdmin == draft2.isAdmin &&
          DeckModel.checkDecksAreIdentical(deck1: draft1.savedFlyers, deck2: draft2.savedFlyers) == true &&
          AgendaModel.checkAgendasAreIdentical(agenda1: draft1.followedBzz, agenda2: draft2.followedBzz) == true &&
          AppStateModel.checkAppStatesAreIdentical(state1: draft1.appState, state2: draft2.appState, isInUserModel: true) == true &&
          DeviceModel.checkDevicesAreIdentical(device1: draft1.device, device2: draft2.device) == true &&
          Mapper.checkListsAreIdentical(list1: draft1.fcmTopics, list2: draft2.fcmTopics) == true &&
          draft1.nameController?.text == draft2.nameController?.text &&
          draft1.titleController?.text == draft2.titleController?.text &&
          draft1.companyController?.text == draft2.companyController?.text &&
          draft1.emailController?.text == draft2.emailController?.text &&
          draft1.phoneController?.text == draft2.phoneController?.text &&
          draft1.hasNewPic == draft2.hasNewPic
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void blogDraftUser(){

    blog('DraftUser(');
    blog('  id: $id,');
    blog('  signInMethod: $signInMethod,');
    blog('  createdAt: $createdAt,');
    blog('  need: $need,');
    blog('  name: $name,');
    blog('  trigram: $trigram,');
    blog('  picModel: ${picModel?.path} | ${picModel?.bytes?.length} bytes | ${picModel?.meta?.width} | ${picModel?.meta?.height} | ${picModel?.meta?.ownersIDs},');
    blog('  title: $title,');
    blog('  company: $company,');
    blog('  gender: $gender,');
    blog('  zone: $zone,');
    blog('  language: $language,');
    blog('  location: $location,');
    blog('  contacts: $contacts,');
    blog('  contactsArePublic: $contactsArePublic,');
    blog('  myBzzIDs: $myBzzIDs,');
    blog('  emailIsVerified: $emailIsVerified,');
    blog('  isAdmin: $isAdmin,');
    blog('  device: $device,');
    blog('  fcmTopics: $fcmTopics,');
    blog('  savedFlyers: $savedFlyers,');
    blog('  followedBzz: $followedBzz,');
    blog('  appState: $appState,');
    blog('  hasNewPic: $hasNewPic,');
    blog('  nameController: $nameController,');
    blog('  titleController: $titleController,');
    blog('  companyController: $companyController,');
    blog('  emailController: $emailController,');
    blog('  phoneController: $phoneController,');
    blog('  nameNode: $nameNode,');
    blog('  titleNode: $titleNode,');
    blog('  companyNode: $companyNode,');
    blog('  emailNode: $emailNode,');
    blog('  phoneNode: $phoneNode,');
    blog('  formKey: $formKey,');
    blog('  canPickImage: $canPickImage,');
    blog(');');


  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
   @override
   String toString(){

    final String _draft =
    '''
    DraftUser(
      id: $id,
      signInMethod: $signInMethod,
      createdAt: $createdAt,
      need: $need,
      name: $name,
      trigram: $trigram,
      picModel: ${picModel?.path} | ${picModel?.bytes?.length} bytes | ${picModel?.meta?.width} x
       ${picModel?.meta?.height} | ${picModel?.meta?.ownersIDs},
      title: $title,
      company: $company,
      gender: $gender,
      zone: $zone,
      language: $language,
      location: $location,
      contacts: $contacts,
      contactsArePublic: $contactsArePublic,
      myBzzIDs: $myBzzIDs,
      emailIsVerified: $emailIsVerified,
      isAdmin: $isAdmin,
      device: $device,
      fcmTopics: $fcmTopics,
      savedFlyers: $savedFlyers,
      followedBzz: $followedBzz,
      appState: $appState,
      hasNewPic: $hasNewPic,
      nameController: $nameController,
      titleController: $titleController,
      companyController: $companyController,
      emailController: $emailController,
      phoneController: $phoneController,
      nameNode: $nameNode,
      titleNode: $titleNode,
      companyNode: $companyNode,
      emailNode: $emailNode,
      phoneNode: $phoneNode,
      formKey: $formKey,
      canPickImage: $canPickImage,
    );
    ''';

    return _draft;
   }
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
      signInMethod.hashCode^
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
      savedFlyers.hashCode^
      followedBzz.hashCode^
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
