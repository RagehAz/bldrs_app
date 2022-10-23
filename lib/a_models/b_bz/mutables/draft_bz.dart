import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class DraftBz {

  const DraftBz({
    @required this.id,
    @required this.createdAt,
    @required this.accountType,
    @required this.name,
    @required this.trigram,
    @required this.zone,
    @required this.about,
    @required this.position,
    @required this.contacts,
    @required this.authors,
    @required this.pendingAuthors,
    @required this.showsTeam,
    @required this.isVerified,
    @required this.bzState,
    @required this.flyersIDs,

    @required this.bzSection,
    @required this.bzTypes,
    @required this.inactiveBzTypes,
    @required this.bzForm,
    @required this.inactiveBzForms,

    @required this.scope,
    @required this.scopeSpecs,

    @required this.oldLogoURL,
    @required this.newLogoFile,
    @required this.canPickImage,

    @required this.canValidate,
    @required this.nameNode,
    @required this.aboutNode,
    @required this.emailNode,
    @required this.websiteNode,
    @required this.phoneNode,
    @required this.formKey,
    @required this.firstTimer,
  });

  final String id;
  final DateTime createdAt;
  final BzAccountType accountType;
  final String name;
  final List<String> trigram;
  final ZoneModel zone;
  final String about;
  final GeoPoint position;
  final List<ContactModel> contacts;
  final List<AuthorModel> authors;
  final List<PendingAuthor> pendingAuthors;
  final bool showsTeam;
  final bool isVerified;
  final BzState bzState;
  final List<String> flyersIDs;

  final BzSection bzSection;
  final List<BzType> bzTypes;
  final List<BzType> inactiveBzTypes;

  final BzForm bzForm;
  final List<BzForm> inactiveBzForms;

  final List<String> scope;
  final List<SpecModel> scopeSpecs;

  final String oldLogoURL;
  final FileModel newLogoFile;
  final bool canPickImage;

  final FocusNode nameNode;
  final FocusNode aboutNode;
  final FocusNode emailNode;
  final FocusNode websiteNode;
  final FocusNode phoneNode;
  final bool canValidate;
  final GlobalKey<FormState> formKey;
  final bool firstTimer;
  // -----------------------------------------------------------------------------

  /// CLONING

  // -------------------
  DraftBz copyWith({
    String id,
    DateTime createdAt,
    BzAccountType accountType,
    String name,
    List<String> trigram,
    ZoneModel zone,
    String about,
    GeoPoint position,
    List<ContactModel> contacts,
    List<AuthorModel> authors,
    List<PendingAuthor> pendingAuthors,
    bool showsTeam,
    bool isVerified,
    BzState bzState,
    List<String> flyersIDs,
    BzSection bzSection,
    List<BzType> bzTypes,
    List<BzType> inactiveBzTypes,
    BzForm bzForm,
    List<BzForm> inactiveBzForms,
    List<String> scope,
    List<SpecModel> scopeSpecs,
    String oldLogoURL,
    FileModel newLogoFile,
    bool canPickImage,
    bool canValidate,
    FocusNode nameNode,
    FocusNode aboutNode,
    FocusNode emailNode,
    FocusNode websiteNode,
    FocusNode phoneNode,
    GlobalKey<FormState> formKey,
    bool firstTimer,
  }){
    return DraftBz(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      accountType: accountType ?? this.accountType,
      name: name ?? this.name,
      trigram: trigram ?? this.trigram,
      zone: zone ?? this.zone,
      about: about ?? this.about,
      position: position ?? this.position,
      contacts: contacts ?? this.contacts,
      authors: authors ?? this.authors,
      pendingAuthors: pendingAuthors ?? this.pendingAuthors,
      showsTeam: showsTeam ?? this.showsTeam,
      isVerified: isVerified ?? this.isVerified,
      bzState: bzState ?? this.bzState,
      flyersIDs: flyersIDs ?? this.flyersIDs,
      bzSection: bzSection ?? this.bzSection,
      bzTypes: bzTypes ?? this.bzTypes,
      inactiveBzTypes: inactiveBzTypes ?? this.inactiveBzTypes,
      bzForm: bzForm ?? this.bzForm,
      inactiveBzForms: inactiveBzForms ?? this.inactiveBzForms,
      scope: scope ?? this.scope,
      scopeSpecs: scopeSpecs ?? this.scopeSpecs,
      oldLogoURL: oldLogoURL ?? this.oldLogoURL,
      newLogoFile: newLogoFile ?? this.newLogoFile,
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
  DraftBz nullifyField({
    bool id = false,
    bool createdAt = false,
    bool accountType = false,
    bool name = false,
    bool trigram = false,
    bool zone = false,
    bool about = false,
    bool position = false,
    bool contacts = false,
    bool authors = false,
    bool pendingAuthors = false,
    bool showsTeam = false,
    bool isVerified = false,
    bool bzState = false,
    bool flyersIDs = false,
    bool bzSection = false,
    bool bzTypes = false,
    bool inactiveBzTypes = false,
    bool bzForm = false,
    bool inactiveBzForms = false,
    bool scope = false,
    bool scopeSpecs = false,
    bool oldLogoURL = false,
    bool newLogoFile = false,
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
      name: name == true ? null : this.name,
      trigram: trigram == true ? [] : this.trigram,
      zone: zone == true ? null : this.zone,
      about: about == true ? null : this.about,
      position: position == true ? null : this.position,
      contacts: contacts == true ? [] : this.contacts,
      authors: authors == true ? [] : this.authors,
      pendingAuthors: pendingAuthors == true ? [] : this.pendingAuthors,
      showsTeam: showsTeam == true ? null : this.showsTeam,
      isVerified: isVerified == true ? null : this.isVerified,
      bzState: bzState == true ? null : this.bzState,
      flyersIDs: flyersIDs == true ? [] : this.flyersIDs,
      bzSection: bzSection == true ? null : this.bzSection,
      bzTypes: bzTypes == true ? [] : this.bzTypes,
      inactiveBzTypes: inactiveBzTypes == true ? [] : this.inactiveBzTypes,
      bzForm: bzForm == true ? null : this.bzForm,
      inactiveBzForms: inactiveBzForms == true ? [] : this.inactiveBzForms,
      scope: scope == true ? [] : this.scope,
      scopeSpecs: scopeSpecs == true ? [] : this.scopeSpecs,
      oldLogoURL: oldLogoURL == true ? null : this.oldLogoURL,
      newLogoFile: newLogoFile == true ? null : this.newLogoFile,
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

  /// CREATION

  // -------------------
  ///
  static DraftBz createNewDraftBz({
    @required UserModel creatorUser,
  }){

    assert(creatorUser != null, 'Creator user can not be null');

    final List<ContactModel> _contacts = ContactModel.prepareContactsForEditing(
      countryID: creatorUser.zone?.countryID,
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

    return DraftBz(
      id: 'draftBzOfUser_${creatorUser.id}',
      createdAt: null,
      accountType: BzAccountType.normal,
      name: '',
      trigram: const [],
      zone: creatorUser.zone,
      about: '',
      position: null,
      contacts: _contacts,
      authors: <AuthorModel>[
        AuthorModel.createAuthorFromUserModel(
          userModel: creatorUser,
          isCreator: true,
        )
      ],
      pendingAuthors: const [],
      showsTeam: true,
      isVerified: false,
      bzState: BzState.offline,
      flyersIDs: const [],
      bzSection: null,
      bzTypes: const [],
      inactiveBzTypes: BzTyper.concludeDeactivatedBzTypesBySection(
        bzSection: null,
        initialBzTypes: [],
      ),
      bzForm: null,
      inactiveBzForms: BzTyper.concludeInactiveBzFormsByBzTypes([]),
      scope: const [],
      scopeSpecs: const [],
      oldLogoURL: null,
      newLogoFile: null,
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
  ///
  static DraftBz createDraftFromBz({
    @required BuildContext context,
    @required BzModel bzModel,
  }){

    assert(bzModel != null, 'BzModel can not be null here');

    final BzSection _bzSection = BzTyper.concludeBzSectionByBzTypes(bzModel.bzTypes);

    return DraftBz(
      id: bzModel.id,
      createdAt: bzModel.createdAt,
      accountType: bzModel.accountType,
      name: bzModel.name,
      trigram: bzModel.trigram,
      zone: bzModel.zone,
      about: bzModel.about,
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
      flyersIDs: bzModel.flyersIDs,
      bzSection: _bzSection,
      bzTypes: bzModel.bzTypes,
      inactiveBzTypes: BzTyper.concludeDeactivatedBzTypesBySection(
        bzSection: _bzSection,
        initialBzTypes: bzModel.bzTypes,
      ),
      bzForm: bzModel.bzForm,
      inactiveBzForms: BzTyper.concludeInactiveBzFormsByBzTypes(bzModel.bzTypes),
      scope: bzModel.scope,
      scopeSpecs: SpecModel.generateSpecsByPhids(
        context: context,
        phids: bzModel.scope,
      ),
      oldLogoURL: bzModel.logo,
      newLogoFile: null,
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
  // -----------------------------------------------------------------------------

  /// BAKING

  // -------------------
  ///
  static BzModel bakeDraftForLDB({
    @required DraftBz draft,
  }){

    final BzModel _bzModel = bakeDraftForFirestore(
        draft: draft,
    );

    return _bzModel.copyWith(
      logo: FileModel.bakeFileForLDB(draft.newLogoFile ?? draft.oldLogoURL),
    );

  }
  // -------------------
  ///
  static BzModel bakeDraftForFirestore({
    @required DraftBz draft,
  }){

    assert(draft != null, 'Draft can not be null');

    return BzModel(
      /// WILL BE OVERRIDDEN
      id: draft.id,
      createdAt: draft.createdAt,

      /// MIGHT HAVE CHANGED
      bzTypes: draft.bzTypes,
      bzForm: draft.bzForm,
      name: draft.name,
      trigram: Stringer.createTrigram(input: draft.name),
      logo: FileModel.bakeFileForUpload(
        newFile: draft.newLogoFile,
        existingPic: draft.oldLogoURL,
      ),
      scope: SpecModel.getSpecsIDs(draft.scopeSpecs),
      zone: draft.zone,
      about: draft.about,
      position: draft.position,
      contacts: ContactModel.bakeContactsAfterEditing(
        contacts: draft.contacts,
        countryID: draft.zone.countryID,
      ),

      /// NEVER CHANGED IN BZ EDITOR
      accountType: draft.accountType,
      authors: draft.authors,
      pendingAuthors: draft.pendingAuthors,
      showsTeam: draft.showsTeam,
      isVerified: draft.isVerified,
      bzState: draft.bzState,
      flyersIDs: draft.flyersIDs,
    );

  }
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // -------------------
  ///
  void disposeDraftBzFocusNodes(){
    nameNode.dispose();
    aboutNode.dispose();
    emailNode.dispose();
    websiteNode.dispose();
    phoneNode.dispose();
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // -------------------
  ///
  static bool checkDraftsAreIdentical({
    @required DraftBz draft1,
    @required DraftBz draft2,
  }){
    bool _areIdentical = false;

    if (draft1 == null && draft2 == null){
      _areIdentical = true;
    }

    else if (draft1 != null && draft2 != null){

      if (
          draft1.id == draft2.id &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: draft1.createdAt, time2: draft2.createdAt) == true &&
          draft1.accountType == draft2.accountType &&
          draft1.name == draft2.name &&
          Mapper.checkListsAreIdentical(list1: draft1.trigram, list2: draft2.trigram) == true &&
          ZoneModel.checkZonesAreIdentical(zone1: draft1.zone, zone2: draft2.zone) == true &&
          draft1.about == draft2.about &&
          Atlas.checkPointsAreIdentical(point1: draft1.position, point2: draft2.position) &&
          ContactModel.checkContactsListsAreIdentical(contacts1: draft1.contacts, contacts2: draft2.contacts) == true &&
          AuthorModel.checkAuthorsListsAreIdentical(authors1: draft1.authors, authors2: draft2.authors) == true &&
          PendingAuthor.checkPendingAuthorsListsAreIdentical(list1: draft1.pendingAuthors, list2: draft2.pendingAuthors) == true &&
          draft1.showsTeam == draft2.showsTeam &&
          draft1.isVerified == draft2.isVerified &&
          draft1.bzState == draft2.bzState &&
          Mapper.checkListsAreIdentical(list1: draft1.flyersIDs, list2: draft2.flyersIDs) == true &&
          draft1.bzSection == draft2.bzSection &&
          Mapper.checkListsAreIdentical(list1: draft1.bzTypes, list2: draft2.bzTypes) == true &&
          Mapper.checkListsAreIdentical(list1: draft1.inactiveBzTypes, list2: draft2.inactiveBzTypes) == true &&
          draft1.bzForm == draft2.bzForm &&
          Mapper.checkListsAreIdentical(list1: draft1.inactiveBzForms, list2: draft2.inactiveBzForms) == true &&
          Mapper.checkListsAreIdentical(list1: draft1.scope, list2: draft2.scope) == true &&
          SpecModel.checkSpecsListsAreIdentical(draft1.scopeSpecs, draft2.scopeSpecs) == true &&
          draft1.oldLogoURL == draft2.oldLogoURL &&
          FileModel.checkFileModelsAreIdentical(model1: draft1.newLogoFile, model2: draft2.newLogoFile) == true &&
          draft1.canPickImage == draft2.canPickImage &&
          draft1.canValidate == draft2.canValidate &&
          draft1.firstTimer == draft2.firstTimer
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
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
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
      name.hashCode^
      trigram.hashCode^
      zone.hashCode^
      about.hashCode^
      position.hashCode^
      contacts.hashCode^
      authors.hashCode^
      pendingAuthors.hashCode^
      showsTeam.hashCode^
      isVerified.hashCode^
      bzState.hashCode^
      flyersIDs.hashCode^
      bzSection.hashCode^
      bzTypes.hashCode^
      inactiveBzTypes.hashCode^
      bzForm.hashCode^
      inactiveBzForms.hashCode^
      scope.hashCode^
      scopeSpecs.hashCode^
      oldLogoURL.hashCode^
      newLogoFile.hashCode^
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
