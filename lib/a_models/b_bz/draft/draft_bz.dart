import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/atlas.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/time/timers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_secondary/scope_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
@immutable
class DraftBz {
  // -----------------------------------------------------------------------------
  const DraftBz({
    required this.id,
    required this.createdAt,
    required this.accountType,
    required this.nameController,
    required this.trigram,
    required this.zone,
    required this.aboutController,
    required this.position,
    required this.contacts,
    required this.authors,
    required this.pendingAuthors,
    required this.showsTeam,
    required this.isVerified,
    required this.bzState,
    required this.publication,
    required this.bzSection,
    required this.bzTypes,
    required this.inactiveBzTypes,
    required this.bzForm,
    required this.inactiveBzForms,
    required this.scopes,
    required this.logoPicModel,
    required this.hasNewLogo,
    required this.canPickImage,
    required this.canValidate,
    required this.nameNode,
    required this.aboutNode,
    required this.emailNode,
    required this.websiteNode,
    required this.phoneNode,
    required this.formKey,
    required this.firstTimer,
  });
  // -----------------------------------------------------------------------------
  final String? id;
  final DateTime? createdAt;
  final BzAccountType? accountType;
  final TextEditingController? nameController;
  final List<String>? trigram;
  final ZoneModel? zone;
  final TextEditingController? aboutController;
  final GeoPoint? position;
  final List<ContactModel>? contacts;
  final List<AuthorModel>? authors;
  final List<PendingAuthor>? pendingAuthors;
  final bool? showsTeam;
  final bool? isVerified;
  final BzState? bzState;
  final PublicationModel publication;
  final BzSection? bzSection;
  final List<BzType>? bzTypes;
  final List<BzType>? inactiveBzTypes;
  final BzForm? bzForm;
  final List<BzForm>? inactiveBzForms;
  final ScopeModel? scopes;
  final MediaModel? logoPicModel;
  final bool? hasNewLogo;
  final bool? canPickImage;
  final FocusNode? nameNode;
  final FocusNode? aboutNode;
  final FocusNode? emailNode;
  final FocusNode? websiteNode;
  final FocusNode? phoneNode;
  final bool? canValidate;
  final GlobalKey<FormState>? formKey;
  final bool? firstTimer;
  // -----------------------------------------------------------------------------

  /// CREATION

  // -------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftBz> createDraftBz({
    required BzModel? oldBz,
  }) async {

    DraftBz? _output;

    /// FIRST TIMER
    if (oldBz == null){

      _output = await _createNewDraftBz();

    }

    else {

      _output = await _createDraftBzFromBzModel(
        bzModel: oldBz,
      );

    }


    return _output;
  }
  // -------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftBz> _createNewDraftBz() async {

    final UserModel? creatorUser = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    assert(creatorUser != null, 'Creator user can not be null');

    final List<ContactModel> _contacts = ContactModel.prepareContactsForEditing(
      countryID: creatorUser!.zone?.countryID,
      contacts: <ContactModel>[
        ContactModel(
          type: ContactType.email,
          value: ContactModel.getValueFromContacts(
            contacts: creatorUser.contacts,
            contactType: ContactType.email,
          ),
        ),
        ContactModel(
          type: ContactType.phone,
          value: ContactModel.getValueFromContacts(
              contacts: creatorUser.contacts,
              contactType: ContactType.phone
          ),
        ),
      ],
    );


    final AuthorModel? _author = await AuthorModel.createAuthorFromUserModel(
      userModel: creatorUser,
      isCreator: true,
      bzID: null,
    );

    assert(_author != null, 'Author can not be null');

    return DraftBz(
      id: 'newDraft',
      createdAt: null,
      accountType: BzAccountType.basic,
      nameController: TextEditingController(),
      trigram: const [],
      zone: creatorUser.zone,
      aboutController: TextEditingController(),
      position: null,
      contacts: _contacts,
      authors: <AuthorModel>[_author!],
      pendingAuthors: const [],
      showsTeam: true,
      isVerified: false,
      bzState: BzState.offline,
      publication: PublicationModel.emptyModel,
      bzSection: null,
      bzTypes: const [],
      inactiveBzTypes: BzTyper.concludeDeactivatedBzTypesBySection(
        bzSection: null,
        initialBzTypes: [],
      ),
      bzForm: null,
      inactiveBzForms: BzTyper.concludeInactiveBzFormsByBzTypes([]),
      scopes: ScopeModel.emptyModel,
      logoPicModel: null,
      hasNewLogo: false,
      canPickImage: true,
      canValidate: false,
      nameNode: FocusNode(),
      aboutNode: FocusNode(),
      emailNode: FocusNode(),
      websiteNode: FocusNode(),
      phoneNode: FocusNode(),
      formKey: GlobalKey<FormState>(),
      firstTimer: true,
    );

  }
  // -------------------
  /// TESTED : WORKS PERFECT
  static Future<DraftBz> _createDraftBzFromBzModel({
    required BzModel bzModel,
  }) async {

    final BzSection? _bzSection = BzTyper.concludeBzSectionByBzTypes(bzModel.bzTypes);
    blog('bzModel.bzTypes : ${bzModel.bzTypes} : _bzSection : $_bzSection');

    return DraftBz(
      id: bzModel.id,
      createdAt: bzModel.createdAt,
      accountType: bzModel.accountType,
      nameController: TextEditingController(text: bzModel.name),
      trigram: bzModel.trigram,
      zone: await ZoneModel.prepareZoneForEditing(
        zoneModel: bzModel.zone,
      ),
      aboutController: TextEditingController(text: bzModel.about),
      position: bzModel.position,
      contacts: ContactModel.prepareContactsForEditing(
        countryID: bzModel.zone?.countryID,
        contacts: bzModel.contacts,
      ),
      authors: bzModel.authors,
      pendingAuthors: bzModel.pendingAuthors,
      showsTeam: bzModel.showsTeam,
      isVerified: bzModel.isVerified,
      bzState: bzModel.bzState,
      publication: bzModel.publication,
      bzSection: _bzSection,
      bzTypes: bzModel.bzTypes,
      inactiveBzTypes: BzTyper.concludeDeactivatedBzTypesBySection(
        bzSection: _bzSection,
        initialBzTypes: bzModel.bzTypes,
      ),
      bzForm: bzModel.bzForm,
      inactiveBzForms: BzTyper.concludeInactiveBzFormsByBzTypes(bzModel.bzTypes),
      scopes: bzModel.scopes,
      logoPicModel: await PicProtocols.fetchPic(StoragePath.bzz_bzID_logo(bzModel.id)),
      hasNewLogo: false,
      canPickImage: true,
      canValidate: false,
      nameNode: FocusNode(),
      aboutNode: FocusNode(),
      emailNode: FocusNode(),
      websiteNode: FocusNode(),
      phoneNode: FocusNode(),
      formKey: GlobalKey<FormState>(),
      firstTimer: false,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DraftBz? reAttachNodes({
    required DraftBz? draftFromLDB,
    required DraftBz? originalDraft,
  }){
    return draftFromLDB?.copyWith(
      nameNode: originalDraft?.nameNode,
      aboutNode: originalDraft?.aboutNode,
      emailNode: originalDraft?.emailNode,
      websiteNode: originalDraft?.websiteNode,
      phoneNode: originalDraft?.phoneNode,
      formKey: originalDraft?.formKey,
      nameController: originalDraft?.nameController,
      aboutController: originalDraft?.aboutController,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // -------------------
  /// TESTED : WORKS PERFECT
  static BzModel? toBzModel(DraftBz? draft){

    if (draft == null){
      return null;
    }
    else {
      return BzModel(
      /// WILL BE OVERRIDDEN
      id: draft.id,
      createdAt: draft.createdAt,

      /// MIGHT HAVE CHANGED
      bzTypes: draft.bzTypes,
      bzForm: draft.bzForm,
      name: draft.nameController?.text,
      trigram: Stringer.createTrigram(input: draft.nameController?.text),
      logoPath: draft.logoPicModel?.path,
      scopes: draft.scopes,
      zone: draft.zone,
      about: draft.aboutController?.text,
      position: draft.position,
      contacts: ContactModel.bakeContactsAfterEditing(
        contacts: draft.contacts,
        countryID: draft.zone?.countryID,
      ),

      /// NEVER CHANGED IN BZ EDITOR
      accountType: draft.accountType,
      authors: draft.authors,
      pendingAuthors: draft.pendingAuthors,
      showsTeam: draft.showsTeam,
      isVerified: draft.isVerified,
      bzState: draft.bzState,
      publication: draft.publication,
    );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toLDB(){

    return {
      'id': id,
      'createdAt': Timers.cipherTime(time: createdAt, toJSON: true),
      'accountType': BzTyper.cipherBzAccountType(accountType),
      'name': nameController?.text,
      'trigram': trigram,
      'zone': zone?.toMap(),
      'about': aboutController?.text,
      'position': Atlas.cipherGeoPoint(point: position, toJSON: true),
      'contacts': ContactModel.cipherContacts(contacts),
      'authors': AuthorModel.cipherAuthors(authors),
      'pendingAuthors': PendingAuthor.cipherPendingAuthors(pendingAuthors),
      'showsTeam': showsTeam,
      'isVerified': isVerified,
      'bzState': BzTyper.cipherBzState(bzState),
      'publication': PublicationModel.cipherToMap(publication: publication),
      'bzSection': BzTyper.cipherBzSection(bzSection),
      'bzTypes': BzTyper.cipherBzTypes(bzTypes),
      'inactiveBzTypes': BzTyper.cipherBzTypes(inactiveBzTypes),
      'bzForm': BzTyper.cipherBzForm(bzForm),
      'inactiveBzForms': BzTyper.cipherBzForms(inactiveBzForms),
      'scopes': scopes?.toMap(),
      'logoPicModel': MediaModel.cipherToLDB(logoPicModel),
      'hasNewLogo': hasNewLogo,
      'canPickImage': canPickImage,
      'canValidate': canValidate,
      // 'nameNode': nameNode,
      // 'aboutNode': aboutNode,
      // 'emailNode': emailNode,
      // 'websiteNode': websiteNode,
      // 'phoneNode': phoneNode,
      // 'formKey': formKey,
      'firstTimer': firstTimer,
    };

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DraftBz fromLDB({
    required BuildContext context,
    required Map<String, dynamic> map,
  }){

    final List<BzType> _bzTypes = BzTyper.decipherBzTypes(map['bzTypes']);
    final BzSection? _bzSection = BzTyper.decipherBzSection(map['bzSection']);

    return DraftBz(
      id: map['id'],
      createdAt: Timers.decipherTime(time: map['createdAt'], fromJSON: true),
      accountType: BzTyper.decipherBzAccountType(map['accountType']),
      nameController: TextEditingController(text: map['name']),
      trigram: Stringer.getStringsFromDynamics(map['trigram']),
      zone: ZoneModel.decipherZone(map['zone']),
      aboutController: TextEditingController(text: map['about']),
      position: Atlas.decipherGeoPoint(point: map['position'], fromJSON: true),
      contacts: ContactModel.decipherContacts(map['contacts']),
      authors: AuthorModel.decipherAuthors(map['authors']),
      pendingAuthors: PendingAuthor.decipherPendingAuthors(map['pendingAuthors']),
      showsTeam: map['showsTeam'],
      isVerified: map['isVerified'],
      bzState: BzTyper.decipherBzState(map['bzState']),
      publication: PublicationModel.decipher(map['publication']),
      bzSection: _bzSection,
      bzTypes: _bzTypes,
      inactiveBzTypes: BzTyper.concludeDeactivatedBzTypesBySection(
        bzSection: _bzSection,
        initialBzTypes: _bzTypes,
      ),
      bzForm: BzTyper.decipherBzForm(map['bzForm']),
      inactiveBzForms: BzTyper.concludeInactiveBzFormsByBzTypes(_bzTypes),
      scopes: ScopeModel.decipher(map['scopes']),
      logoPicModel: MediaModel.decipherFromLDB(map['logoPicModel']),
      hasNewLogo: map['hasNewLogo'],
      canPickImage: true,
      canValidate: false,
      nameNode: null,
      aboutNode: null,
      emailNode: null,
      websiteNode: null,
      phoneNode: null,
      formKey: null,
      firstTimer: map['firstTimer'],
    );

  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // -------------------
  /// TESTED : WORKS PERFECT
  DraftBz copyWith({
    String? id,
    DateTime? createdAt,
    BzAccountType? accountType,
    TextEditingController? nameController,
    List<String>? trigram,
    ZoneModel? zone,
    TextEditingController? aboutController,
    GeoPoint? position,
    List<ContactModel>? contacts,
    List<AuthorModel>? authors,
    List<PendingAuthor>? pendingAuthors,
    bool? showsTeam,
    bool? isVerified,
    BzState? bzState,
    PublicationModel? publication,
    BzSection? bzSection,
    List<BzType>? bzTypes,
    List<BzType>? inactiveBzTypes,
    BzForm? bzForm,
    List<BzForm>? inactiveBzForms,
    ScopeModel? scopes,
    MediaModel? logoPicModel,
    bool? hasNewLogo,
    bool? canPickImage,
    bool? canValidate,
    FocusNode? nameNode,
    FocusNode? aboutNode,
    FocusNode? emailNode,
    FocusNode? websiteNode,
    FocusNode? phoneNode,
    GlobalKey<FormState>? formKey,
    bool? firstTimer,
  }){
    return DraftBz(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      accountType: accountType ?? this.accountType,
      nameController: nameController ?? this.nameController,
      trigram: trigram ?? this.trigram,
      zone: zone ?? this.zone,
      aboutController: aboutController ?? this.aboutController,
      position: position ?? this.position,
      contacts: contacts ?? this.contacts,
      authors: authors ?? this.authors,
      pendingAuthors: pendingAuthors ?? this.pendingAuthors,
      showsTeam: showsTeam ?? this.showsTeam,
      isVerified: isVerified ?? this.isVerified,
      bzState: bzState ?? this.bzState,
      publication: publication ?? this.publication,
      bzSection: bzSection ?? this.bzSection,
      bzTypes: bzTypes ?? this.bzTypes,
      inactiveBzTypes: inactiveBzTypes ?? this.inactiveBzTypes,
      bzForm: bzForm ?? this.bzForm,
      inactiveBzForms: inactiveBzForms ?? this.inactiveBzForms,
      scopes: scopes ?? this.scopes,
      logoPicModel: logoPicModel ?? this.logoPicModel,
      hasNewLogo: hasNewLogo ?? this.hasNewLogo,
      canPickImage: canPickImage ?? this.canPickImage,
      canValidate: canValidate ?? this.canValidate,
      nameNode: nameNode ?? this.nameNode,
      aboutNode: aboutNode ?? this.aboutNode,
      emailNode: emailNode ?? this.emailNode,
      websiteNode: websiteNode ?? this.websiteNode,
      phoneNode: phoneNode ?? this.phoneNode,
      formKey: formKey ?? this.formKey,
      firstTimer: firstTimer ?? this.firstTimer,
    );
  }
  // -------------------
  /// TESTED : WORKS PERFECT
  DraftBz nullifyField({
    bool id = false,
    bool createdAt = false,
    bool accountType = false,
    bool nameController = false,
    bool trigram = false,
    bool zone = false,
    bool aboutController = false,
    bool position = false,
    bool contacts = false,
    bool authors = false,
    bool pendingAuthors = false,
    bool showsTeam = false,
    bool isVerified = false,
    bool bzState = false,
    bool publication = false,
    bool bzSection = false,
    bool bzTypes = false,
    bool inactiveBzTypes = false,
    bool bzForm = false,
    bool inactiveBzForms = false,
    bool scopes = false,
    bool logoPicModel = false,
    bool hasNewLogo = false,
    bool canPickImage = false,
    bool canValidate = false,
    bool nameNode = false,
    bool aboutNode = false,
    bool emailNode = false,
    bool websiteNode = false,
    bool phoneNode = false,
    bool formKey = false,
    bool firstTimer = false,
  }){
    return DraftBz(
      id: id == true ? null : this.id,
      createdAt: createdAt == true ? null : this.createdAt,
      accountType: accountType == true ? null : this.accountType,
      nameController: nameController == true ? null : this.nameController,
      trigram: trigram == true ? [] : this.trigram,
      zone: zone == true ? null : this.zone,
      aboutController: aboutController == true ? null : this.aboutController,
      position: position == true ? null : this.position,
      contacts: contacts == true ? [] : this.contacts,
      authors: authors == true ? [] : this.authors,
      pendingAuthors: pendingAuthors == true ? [] : this.pendingAuthors,
      showsTeam: showsTeam == true ? null : this.showsTeam,
      isVerified: isVerified == true ? null : this.isVerified,
      bzState: bzState == true ? null : this.bzState,
      publication: publication == true ? PublicationModel.emptyModel : this.publication,
      bzSection: bzSection == true ? null : this.bzSection,
      bzTypes: bzTypes == true ? [] : this.bzTypes,
      inactiveBzTypes: inactiveBzTypes == true ? [] : this.inactiveBzTypes,
      bzForm: bzForm == true ? null : this.bzForm,
      inactiveBzForms: inactiveBzForms == true ? [] : this.inactiveBzForms,
      scopes: scopes == true ? null : this.scopes,
      logoPicModel: logoPicModel == true ? null : this.logoPicModel,
      hasNewLogo: hasNewLogo == true ? null : this.hasNewLogo,
      canPickImage: canPickImage == true ? null : this.canPickImage,
      canValidate: canValidate == true ? null : this.canValidate,
      nameNode: nameNode == true ? null : this.nameNode,
      aboutNode: aboutNode == true ? null : this.aboutNode,
      emailNode: emailNode == true ? null : this.emailNode,
      websiteNode: websiteNode == true ? null : this.websiteNode,
      phoneNode: phoneNode == true ? null : this.phoneNode,
      formKey: formKey == true ? null : this.formKey,
      firstTimer: firstTimer == true ? null : this.firstTimer,
    );
  }
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // -------------------
  /// TESTED : WORKS PERFECT
  void disposeDraftBzFocusNodes(){
    nameNode?.dispose();
    aboutNode?.dispose();
    emailNode?.dispose();
    websiteNode?.dispose();
    phoneNode?.dispose();
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // -------------------
  /// TESTED : WORKS PERFECT
  static DraftBz? overrideBzID({
    required DraftBz? draft,
    required String? bzID,
  }){
    DraftBz? _output;

    if (draft != null && bzID != null){

      final List<AuthorModel>? _authors = AuthorModel.overrideAuthorsBzID(
        authors: draft.authors,
        bzID: bzID,
      );

      final MediaModel? _picModel = draft.logoPicModel?.copyWith(
        path: StoragePath.bzz_bzID_logo(bzID),
      );

      _output = draft.copyWith(
        id: bzID,
        authors: _authors,
        logoPicModel: _picModel,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // -------------------
  /// TESTED : WORKS PERFECT
  List<String> getLogoOwners(){
    final AuthorModel? _author = AuthorModel.getCreatorAuthorFromAuthors(authors);
    if (_author?.userID == null){
      return <String>[];
    }
    else {
      return <String>[_author!.userID!];
    }
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // -------------------
  /// TESTED : WORKS PERFECT
  void blogDraft(){

    blog('blogDraftBz ------------------------------------> START');

    blog('id : $id');
    Timers.blogDateTime(createdAt);
    blog('accountType : ${BzTyper.cipherBzAccountType(accountType)}');
    blog('name : ${nameController?.text}');
    blog('trigram : $trigram');
    zone?.blogZone(invoker: 'DraftBz');
    blog('about : ${aboutController?.text}');
    Atlas.blogGeoPoint(point: position, invoker: 'DraftBz');
    ContactModel.blogContacts(contacts: contacts);
    AuthorModel.blogAuthors(authors: authors, invoker: 'DraftBz');
    PendingAuthor.blogPendingAuthors(pendingAuthors);
    blog('showsTeam : $showsTeam');
    blog('isVerified : $isVerified');
    blog('bzState : ${BzTyper.cipherBzState(bzState)}');
    PublicationModel.blogPublications(publication: publication);
    blog('bzSection : ${BzTyper.cipherBzSection(bzSection)}');
    blog('bzTypes : ${BzTyper.cipherBzTypes(bzTypes)}');
    blog('inactiveBzTypes : ${BzTyper.cipherBzTypes(inactiveBzTypes)}');
    blog('bzForm : ${BzTyper.cipherBzForm(bzForm)}');
    blog('inactiveBzForms : ${BzTyper.cipherBzForms(inactiveBzForms)}');
    blog('scopes: $scopes');
    logoPicModel?.blogPic(invoker: 'DraftBz');
    blog('hasNewLogo : $hasNewLogo');
    blog('canPickImage : $canPickImage');
    blog('canValidate : $canValidate');
    blog('nameNode exists : ${nameNode != null} : '
        'aboutNode exists : ${aboutNode != null} : '
        'emailNode exists : ${emailNode != null} : '
        'websiteNode exists : ${websiteNode != null} : '
        'phoneNode exists : ${phoneNode != null}');
    blog('formKey exists : ${formKey != null}');
    blog('firstTimer : $firstTimer');

    blog('blogDraftBz ------------------------------------> END');

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // -------------------
  /// TESTED : WORKS PERFECT
  static bool checkDraftsAreIdentical({
    required DraftBz? draft1,
    required DraftBz? draft2,
    bool blogDiffs = false,
  }){
    bool _areIdentical = false;

    // if (blogDiffs == true){
    //   Mapper.blogMapsDifferences(
    //     map1: draft1?.toLDB(),
    //     map2: draft2?.toLDB(),
    //     invoker: 'checkDraftsAreIdentical',
    //   );
    // }

    if (draft1 == null && draft2 == null){
      _areIdentical = true;
    }

    else if (draft1 != null && draft2 != null){

      if (
      draft1.id == draft2.id &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: draft1.createdAt, time2: draft2.createdAt) == true &&
          draft1.accountType == draft2.accountType &&
          draft1.nameController?.text   == draft2.nameController?.text &&
          Lister.checkListsAreIdentical(list1: draft1.trigram, list2: draft2.trigram) == true &&
          ZoneModel.checkZonesAreIdentical(zone1: draft1.zone, zone2: draft2.zone) == true &&
          draft1.aboutController?.text == draft2.aboutController?.text &&
          Atlas.checkPointsAreIdentical(point1: draft1.position, point2: draft2.position) &&
          ContactModel.checkContactsListsAreIdentical(contacts1: draft1.contacts, contacts2: draft2.contacts) == true &&
          AuthorModel.checkAuthorsListsAreIdentical(authors1: draft1.authors, authors2: draft2.authors) == true &&
          PendingAuthor.checkPendingAuthorsListsAreIdentical(list1: draft1.pendingAuthors, list2: draft2.pendingAuthors) == true &&
          draft1.showsTeam == draft2.showsTeam &&
          draft1.isVerified == draft2.isVerified &&
          draft1.bzState == draft2.bzState &&
          PublicationModel.checkPublicationsAreIdentical(pub1: draft1.publication, pub2: draft2.publication) == true &&
          draft1.bzSection == draft2.bzSection &&
          Lister.checkListsAreIdentical(list1: draft1.bzTypes, list2: draft2.bzTypes) == true &&
          Lister.checkListsAreIdentical(list1: draft1.inactiveBzTypes, list2: draft2.inactiveBzTypes) == true &&
          draft1.bzForm == draft2.bzForm &&
          Lister.checkListsAreIdentical(list1: draft1.inactiveBzForms, list2: draft2.inactiveBzForms) == true &&
          ScopeModel.checkScopesAreIdentical(scope1: draft1.scopes, scope2: draft2.scopes) == true &&
          MediaModel.checkPicsAreIdentical(pic1: draft1.logoPicModel, pic2: draft2.logoPicModel) == true &&
          draft1.hasNewLogo == draft2.hasNewLogo &&
          draft1.canPickImage == draft2.canPickImage &&
          draft1.firstTimer == draft2.firstTimer

          // draft1.canValidate == draft2.canValidate && // no need
          // FocusNode nameNode,
          // FocusNode aboutNode,
          // FocusNode emailNode,
          // FocusNode websiteNode,
          // FocusNode phoneNode,
          // GlobalKey<FormState> formKey,

      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // ----------------------------------------
   @override
   String toString() =>
       '''
       DraftBz(
           id: $id,
           createdAt: $createdAt,
           accountType: ${BzTyper.cipherBzAccountType(accountType)},
           nameController: ${nameController?.text},
           trigram: $trigram,
           zone: $zone,
           aboutController: ${aboutController?.text},
           position: $position,
           contacts: ${contacts?.length} contacts,
           authors: $authors,
           pendingAuthors: $pendingAuthors,
           showsTeam: $showsTeam,
           isVerified: $isVerified,
           bzState: ${BzTyper.cipherBzState(bzState)},
           publication: ${PublicationModel.cipherToMap(publication: publication)},
           bzSection: ${BzTyper.cipherBzSection(bzSection)},
           bzTypes: ${BzTyper.cipherBzTypes(bzTypes)},
           inactiveBzTypes: ${BzTyper.cipherBzTypes(inactiveBzTypes)},
           bzForm: ${BzTyper.cipherBzForm(bzForm)},
           inactiveBzForms: ${BzTyper.cipherBzForms(inactiveBzForms)},
           scopes: $scopes,
           logoPicModel: $logoPicModel,
           hasNewLogo: $hasNewLogo,
           canPickImage: $canPickImage,
           canValidate: $canValidate,
           nameNode: $nameNode,
           aboutNode: $aboutNode,
           emailNode: $emailNode,
           websiteNode: $websiteNode,
           phoneNode: $phoneNode,
           formKey: $formKey,
           firstTimer: $firstTimer,
       )''';
  // ----------------------------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is DraftBz){
      _areIdentical = checkDraftsAreIdentical(
        draft1: this,
        draft2: other,
      );
    }

    return _areIdentical;
  }
  // ----------------------------------------
  @override
  int get hashCode =>
      id.hashCode^
      createdAt.hashCode^
      accountType.hashCode^
      nameController.hashCode^
      trigram.hashCode^
      zone.hashCode^
      aboutController.hashCode^
      position.hashCode^
      contacts.hashCode^
      authors.hashCode^
      pendingAuthors.hashCode^
      showsTeam.hashCode^
      isVerified.hashCode^
      bzState.hashCode^
      publication.hashCode^
      bzSection.hashCode^
      bzTypes.hashCode^
      inactiveBzTypes.hashCode^
      bzForm.hashCode^
      inactiveBzForms.hashCode^
      scopes.hashCode^
      logoPicModel.hashCode^
      hasNewLogo.hashCode^
      canPickImage.hashCode^
      canValidate.hashCode^
      nameNode.hashCode^
      aboutNode.hashCode^
      emailNode.hashCode^
      websiteNode.hashCode^
      phoneNode.hashCode^
      formKey.hashCode^
      firstTimer.hashCode;
  // -----------------------------------------------------------------------------
}
