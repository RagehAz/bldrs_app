import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/b_bz/sub/pending_author_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_utilities/alert_model.dart';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class BzModel{
  /// --------------------------------------------------------------------------
  const BzModel({
    @required this.id,
    @required this.bzTypes,
    @required this.bzForm,
    @required this.createdAt,
    @required this.accountType,
    @required this.name,
    @required this.trigram,
    @required this.logo,
    @required this.scope,
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
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final List<BzType> bzTypes;
  final BzForm bzForm;
  final DateTime createdAt;
  final BzAccountType accountType;
  final String name;
  final List<String> trigram;
  final dynamic logo;
  final List<String> scope;
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
  final DocumentSnapshot<Object> docSnapshot;
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future <BzModel> initializeModelForEditing({
    @required BuildContext context,
    @required BzModel oldBz,
    @required bool firstTimer,
    @required UserModel userModel,
  }) async {

    final BzModel _initialBzModel = firstTimer == true ?
    BzModel.convertFireUserDataIntoInitialBzModel(userModel)
        :
    oldBz;

    return _initialBzModel.copyWith(
      logo: await FileModel.preparePicForEditing(
          pic: _initialBzModel.logo,
          fileName: oldBz?.id
      ),//FileModel(url: _initialBzModel.logo, fileName: _initialBzModel.id, size: null),

      zone: await ZoneModel.prepareZoneForEditing(
        context: context,
        zoneModel: _initialBzModel.zone,
      ),
      contacts: ContactModel.prepareContactsForEditing(
        contacts: oldBz?.contacts,
        countryID: oldBz?.zone?.countryID,
      ),
    );

  }
  // --------------------
  ///
  static BzModel backEditorVariablesToUpload({
    @required ValueNotifier<List<SpecModel>> selectedScopes,
    @required BzModel oldBz,
    @required ValueNotifier<BzModel> tempBz,
  }){

    final BzModel _bzModel = BzModel(
      id: oldBz?.id, /// WILL BE OVERRIDDEN IN CREATE BZ OPS
      bzTypes: tempBz.value.bzTypes,
      bzForm: tempBz.value.bzForm,
      createdAt: oldBz?.createdAt, /// WILL BE OVERRIDDEN
      accountType: oldBz?.accountType, /// NEVER CHANGED
      name: tempBz.value.name,
      trigram: Stringer.createTrigram(input: tempBz.value.name),
      logo: FileModel.bakeFileForUpload(
        newFile: tempBz.value.logo,
        existingPic: oldBz?.logo,
      ),
      scope: SpecModel.getSpecsIDs(selectedScopes.value),
      zone: tempBz.value.zone,
      about: tempBz.value.about,
      position: tempBz.value.position,
      contacts: ContactModel.bakeContactsAfterEditing(
        contacts: tempBz.value.contacts,
        countryID: tempBz.value.zone?.countryID,
      ),
      authors: oldBz?.authors, /// NEVER CHANGED
      pendingAuthors: oldBz?.pendingAuthors, /// NEVER CHANGED
      showsTeam: oldBz?.showsTeam, /// NEVER CHANGED
      isVerified: oldBz?.isVerified, /// NEVER CHANGED
      bzState: oldBz?.bzState, /// NEVER CHANGED
      flyersIDs: oldBz?.flyersIDs, /// NEVER CHANGED
    );

    return _bzModel;
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  BzModel copyWith({
    String id,
    List<BzType> bzTypes,
    BzForm bzForm,
    DateTime createdAt,
    BzAccountType accountType,
    String name,
    List<String> trigram,
    dynamic logo,
    List<String> scope,
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
    DocumentSnapshot<Object> docSnapshot,
  }){

    return BzModel(
      id : id ?? this.id,
      bzTypes : bzTypes ?? this.bzTypes,
      bzForm : bzForm ?? this.bzForm,
      createdAt : createdAt ?? this.createdAt,
      accountType : accountType ?? this.accountType,
      name : name ?? this.name,
      trigram : trigram ?? this.trigram,
      logo : logo ?? this.logo,
      scope : scope ?? this.scope,
      zone : zone ?? this.zone,
      about : about ?? this.about,
      position : position ?? this.position,
      contacts : contacts ?? this.contacts,
      authors : authors ?? this.authors,
      pendingAuthors: pendingAuthors ?? this.pendingAuthors,
      showsTeam : showsTeam ?? this.showsTeam,
      isVerified : isVerified ?? this.isVerified,
      bzState : bzState ?? this.bzState,
      flyersIDs : flyersIDs ?? this.flyersIDs,
      docSnapshot: docSnapshot ?? this.docSnapshot,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  BzModel nullifyField({
    bool id = false,
    bool bzTypes = false,
    bool bzForm = false,
    bool createdAt = false,
    bool accountType = false,
    bool name = false,
    bool trigram = false,
    bool logo = false,
    bool scope = false,
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
    bool docSnapshot = false,
  }){
    return BzModel(
      id : id == true ? null : this.id,
      bzTypes : bzTypes == true ? [] : this.bzTypes,
      bzForm : bzForm == true ? null : this.bzForm,
      createdAt : createdAt == true ? null : this.createdAt,
      accountType : accountType == true ? null : this.accountType,
      name : name == true ? null : this.name,
      trigram : trigram == true ? [] : this.trigram,
      logo : logo == true ? null : this.logo,
      scope : scope == true ? [] : this.scope,
      zone : zone == true ? null : this.zone,
      about : about == true ? null : this.about,
      position : position == true ? null : this.position,
      contacts : contacts == true ? [] : this.contacts,
      authors : authors == true ? [] : this.authors,
      pendingAuthors: pendingAuthors == true ? [] : this.pendingAuthors,
      showsTeam : showsTeam == true ? null : this.showsTeam,
      isVerified : isVerified == true ? null : this.isVerified,
      bzState : bzState == true ? null : this.bzState,
      flyersIDs : flyersIDs == true ? [] : this.flyersIDs,
      docSnapshot : docSnapshot == true ? null : this.docSnapshot,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }) {
    return <String, dynamic>{
      'id': id,
      // -------------------------
      'bzTypes': BzTyper.cipherBzTypes(bzTypes),
      'bzForm': BzTyper.cipherBzForm(bzForm),
      'createdAt': Timers.cipherTime(time: createdAt, toJSON: toJSON),
      'accountType': BzTyper.cipherBzAccountType(accountType),
      // -------------------------
      'name': name,
      'trigram': trigram,
      'logo': logo,
      'scope': scope,
      'zone': zone?.toMap(),
      'about': about,
      'position': Atlas.cipherGeoPoint(point: position, toJSON: toJSON),
      'contacts': ContactModel.cipherContacts(contacts),
      'authors': AuthorModel.cipherAuthors(authors),
      'pendingAuthors': PendingAuthor.cipherPendingAuthors(pendingAuthors),
      'showsTeam': showsTeam,
      // -------------------------
      'isVerified': isVerified,
      'bzState': BzTyper.cipherBzState(bzState),
      // -------------------------
      'flyersIDs': flyersIDs,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherBzz({
    @required List<BzModel> bzz,
    @required bool toJSON,
  }) {

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.checkCanLoopList(bzz) == true){

      for (final BzModel bz in bzz){

        _maps.add(bz.toMap(toJSON: toJSON));

      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzModel decipherBz({
    @required dynamic map,
    @required bool fromJSON,
  }) {
    BzModel _bzModel;

    if (map != null) {
      _bzModel = BzModel(
        id: map['id'],
        // -------------------------
        bzTypes: BzTyper.decipherBzTypes(map['bzTypes']),
        bzForm: BzTyper.decipherBzForm(map['bzForm']),
        createdAt:
        Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        accountType: BzTyper.decipherBzAccountType(map['accountType']),
        // -------------------------
        name: map['name'],
        trigram: Stringer.getStringsFromDynamics(dynamics: map['trigram']),
        logo: map['logo'],
        scope: Stringer.getStringsFromDynamics(dynamics: map['scope']),
        zone: ZoneModel.decipherZone(map['zone']),
        about: map['about'],
        position: Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
        contacts: ContactModel.decipherContacts(map['contacts']),
        authors: AuthorModel.decipherAuthors(map['authors']),
        pendingAuthors: PendingAuthor.decipherPendingAuthors(map['pendingAuthors']),
        showsTeam: map['showsTeam'],
        // -------------------------
        isVerified: map['isVerified'],
        bzState: BzTyper.decipherBzState(map['bzState']),
        // -------------------------
        flyersIDs: Stringer.getStringsFromDynamics(dynamics: map['flyersIDs']),
        docSnapshot: map['docSnapshot'],
      );
    }

    return _bzModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzModel> decipherBzz({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<BzModel> _bzList = <BzModel>[];

    for (final Map<String, dynamic> map in maps) {
      _bzList.add(decipherBz(
        map: map,
        fromJSON: fromJSON,
      ));
    }

    return _bzList;
  }
  // -----------------------------------------------------------------------------

  /// BZ CONVERTERS

  // --------------------
  static BzModel convertFireUserDataIntoInitialBzModel(UserModel userModel) {
    return BzModel(
      id: 'newBz',
      name: userModel?.company,
      trigram: Stringer.createTrigram(input: userModel?.company),
      zone: userModel?.zone,
      contacts: <ContactModel>[
        ContactModel(
          type: ContactType.email,
          value: ContactModel.getValueFromContacts(
            contacts: userModel.contacts,
            contactType: ContactType.email,
          ),
        ),
        ContactModel(
          type: ContactType.phone,
          value: ContactModel.getValueFromContacts(
              contacts: userModel.contacts,
              contactType: ContactType.phone
          ),
        ),
      ],
      authors: <AuthorModel>[
        AuthorModel.createAuthorFromUserModel(
          userModel: userModel,
          isCreator: true,
        )
      ],
      pendingAuthors: const <PendingAuthor>[],
      showsTeam: true,
      // -------------------------
      isVerified: false,
      bzState: BzState.offline,
      // -------------------------
      flyersIDs: const <String>[],
      createdAt: DateTime.now(),
      accountType: BzAccountType.normal,
      about: '',
      bzForm: BzForm.individual,
      logo: userModel.pic,
      position: null,
      scope: null,
      bzTypes: null,
    );
  }
  // --------------------
  static BzModel convertDocSnapshotIntoBzModel(DocumentSnapshot<Object> doc) {

    final DocumentSnapshot<Object> _docSnap = doc.data();
    final Map<String, dynamic> _map = Mapper.getMapFromDocumentSnapshot(
      docSnapshot: _docSnap,
      addDocID: false,
      addDocSnapshot: true,
    );

    final BzModel _bzModel = BzModel.decipherBz(
      map: _map,
      fromJSON: false,
    );

    blog(' map the bz Model is $_bzModel');

    return _bzModel;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static BzModel removeFlyerIDFromBzAndAuthor({
    @required BzModel bzModel,
    @required FlyerModel flyer,
  }){

    final List<String> _bzFlyersIDs = Stringer.removeStringsFromStrings(
      removeFrom: bzModel.flyersIDs,
      removeThis: <String>[flyer.id],
    );

    final List<AuthorModel> _updatedAuthors = AuthorModel.removeFlyerIDFromAuthor(
      flyerID: flyer.id,
      authorID: flyer.authorID,
      authors: bzModel.authors,
    );

    final BzModel _updatedBzModel = bzModel.copyWith(
      flyersIDs: _bzFlyersIDs,
      authors: _updatedAuthors,
    );

    return _updatedBzModel;
  }
  // --------------------
  /*
  static BzModel removeFlyersIDs({
    @required List<String> flyersIDs,
    @required BzModel bzModel,
  }){

    BzModel _output;


    if (bzModel != null && Mapper.checkCanLoopList(flyersIDs) == true){

      final List<String> _updatedFlyersIDs = Mapper.removeStringsFromStrings(
        removeFrom: bzModel.flyersIDs,
        removeThis: flyersIDs,
      );

      _output = bzModel.copyWith(
        flyersIDs: _updatedFlyersIDs,
      );

    }

    return _output;


  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzModel> addOrRemoveBzToBzz({
    @required List<BzModel> bzzModels,
    @required BzModel bzModel,
  }){
    final List<BzModel> _output = <BzModel>[];

    if (bzModel != null){

      if (Mapper.checkCanLoopList(bzzModels) == true){
        _output.addAll(bzzModels);
      }

      final bool _alreadySelected = checkBzzContainThisBz(
          bzz: _output,
          bzModel: bzModel
      );

      if (_alreadySelected == true){
        _output.removeWhere((bz) => bz.id == bzModel.id);
      }
      else {
        _output.add(bzModel);
      }

    }

    return _output;
  }
  // --------------------
  static BzModel replaceAuthor({
    @required AuthorModel updatedAuthor,
    @required BzModel bzModel,
  }){

    BzModel _output = bzModel;

    if (updatedAuthor != null && bzModel != null){

      _output = bzModel.copyWith(
        authors: AuthorModel.replaceAuthorModelInAuthorsListByID(
          authorToReplace: updatedAuthor,
          authors: bzModel.authors,
        ),
      );

    }


    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzModel removeAuthor({
    @required BzModel bzModel,
    @required String authorID,
  }){

    BzModel _output;

    // blog('removeAuthor : remove ($authorID) from (${AuthorModel.getAuthorsIDsFromAuthors(authors: bzModel.authors)})');

    if (bzModel != null && authorID != null){

      final List<AuthorModel> _authors = bzModel.authors;

      final List<AuthorModel> _updated = AuthorModel.removeAuthorFromAuthors(
        authors: _authors,
        authorIDToRemove: authorID,
      );

      _output = bzModel.copyWith(
        authors: _updated,
      );

    }

    // blog('removeAuthor : _output is (${AuthorModel.getAuthorsIDsFromAuthors(authors: _output.authors)})');

    return _output ?? bzModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static BzModel addNewUserAsAuthor({
    @required BzModel oldBzModel,
    @required UserModel userModel,
  }){

    final List<AuthorModel> _newAuthors = AuthorModel.addNewUserToAuthors(
      authors: oldBzModel.authors,
      newUserModel: userModel,
    );

    final BzModel _newBzModel = oldBzModel.copyWith(
      authors: _newAuthors,
    );

    return _newBzModel;
  }
  // -----------------------------------------------------------------------------

  /// BZ DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static BzModel dummyBz(String bzID) {
    final String _bzID = bzID ?? 'ytLfMwdqK565ByP1p56G';

    return BzModel(
      id: _bzID,
      logo: Iconz.bz, //'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bzLogos%2Far1.jpg?alt=media&token=f68673f8-409a-426a-9a80-f1026715c469'
      name: 'Business Name That os a bit too kinda tall and little bit extra tall aho',
      trigram: Stringer.createTrigram(input: 'Business Name'),
      bzTypes: const <BzType>[BzType.designer, BzType.broker, BzType.contractor, BzType.artisan],
      zone: ZoneModel.dummyZone(),
      bzState: BzState.online,
      position: Atlas.dummyLocation(),
      flyersIDs: const <String>[],
      authors: <AuthorModel>[
        AuthorModel.dummyAuthor(),
      ],
      pendingAuthors: const <PendingAuthor>[],
      contacts: ContactModel.dummyContacts(),
      bzForm: BzForm.company,
      accountType: BzAccountType.normal,
      createdAt: Timers.createDate(year: 1987, month: 10, day: 06),
      about: 'About biz',
      isVerified: true,
      scope: const <String>['phid_k_designType_architecture'],
      showsTeam: true,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<BzModel> dummyBzz({int length = 4}){

    final List<BzModel> _dummies = <BzModel>[];

    for (int i = 0; i <= length; i++){
      _dummies.add(dummyBz('bzID_$i'));
    }

    return _dummies;
  }
  // -----------------------------------------------------------------------------

  /// BZ BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogBz({String methodName = ''}) {
    final String _methodName = methodName ?? 'BZ';

    blog('BZZZZZZZ ===> $_methodName : BLOGGING BZ MODEL -------------------------------- START -- ');

    blog('name : $name'); // fakes trigram
    blog('id : $id : accountType : $accountType : createdAt : $createdAt');
    blog('bzForm : $bzForm : bzTypes : $bzTypes');
    blog('logo : $logo');
    blog('scope : $scope');
    blog('about : $about');
    blog('position : $position');
    blog('showsTeam : $showsTeam : isVerified : $isVerified : bzState : $bzState');
    blog('flyersIDs : $flyersIDs');
    PendingAuthor.blogPendingAuthors(pendingAuthors);
    zone?.blogZone(methodName: 'BZ MODEL ($id)');
    AuthorModel.blogAuthors(authors: authors, methodName: 'BZ MODEL ($id)');
    ContactModel.blogContacts(contacts: contacts);

    blog('BZZZZZZZ ===> $_methodName : BLOGGING BZ MODEL -------------------------------- END -- ');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogBzz({
    @required List<BzModel> bzz,
    String methodName,
  }){

    if (Mapper.checkCanLoopList(bzz)){

      for (final BzModel bz in bzz){
        bz.blogBz(methodName: methodName);
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogBzzDifferences({
    @required BzModel bz1,
    @required BzModel bz2,
  }){

    blog('staring blogBzzDifferences checkup ');

    if (bz1 == null){
      blog('blogBzzDifferences : bz1 = null');
    }

    if (bz2 == null){
      blog('blogBzzDifferences : bz2 = null');
    }

    if (bz1 != null && bz2 != null){

      if (bz1.id != bz2.id){
        blog('ids are not identical');
      }
      if (Mapper.checkListsAreIdentical(list1: bz1.bzTypes, list2: bz2.bzTypes) == false){
        blog('bzTypes are not identical');
      }
      if (bz1.bzForm != bz2.bzForm){
        blog('bzForms are not identical');
      }
      if (Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: bz1.createdAt, time2: bz2.createdAt) == false){
        blog('createdAts are not identical');
      }
      if (bz1.accountType != bz2.accountType){
        blog('accountTypes are not identical');
      }
      if (bz1.name != bz2.name){
        blog('names are not identical');
      }
      if (Mapper.checkListsAreIdentical(list1: bz1.trigram, list2: bz2.trigram) == false){
        blog('trigrams are not identical');
      }
      if (bz1.logo != bz2.logo){
        blog('logos are not identical');
      }
      if (Mapper.checkListsAreIdentical(list1: bz1.scope, list2: bz2.scope) == false){
        blog('scopes are not identical');
      }
      if (ZoneModel.checkZonesAreIdentical(zone1: bz1.zone, zone2: bz1.zone) == false){
        blog('zones are not identical');
      }
      if (bz1.about != bz2.about){
        blog('abouts are not identical');
      }
      if (bz1.position != bz2.position){
        blog('positions are not identical');
      }
      if (ContactModel.checkContactsListsAreIdentical(contacts1: bz1.contacts, contacts2: bz2.contacts) == false){
        blog('contacts are not identical');
      }
      if (AuthorModel.checkAuthorsListsAreIdentical(authors1: bz1.authors, authors2: bz2.authors) == false){
        blog('authors are not identical');
      }
      if (PendingAuthor.checkPendingAuthorsListsAreIdentical(list1: bz1.pendingAuthors, list2: bz2.pendingAuthors) == false){
        blog('pending authors are not identical');
      }
      if (bz1.showsTeam != bz2.showsTeam){
        blog('showsTeams are not identical');
      }
      if (bz1.isVerified != bz2.isVerified){
        blog('isVerifieds are not identical');
      }
      if (bz1.bzState != bz2.bzState){
        blog('bzStates are not identical');
      }
      if (Mapper.checkListsAreIdentical(list1: bz1.flyersIDs, list2: bz2.flyersIDs) == false){
        blog('flyersIDs are not identical');
      }

    }

    blog('ending blogBzzDifferences checkup');

  }
  // -----------------------------------------------------------------------------

  /// BZ GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static BzModel getBzFromBzzByBzID({
    @required List<BzModel> bzz,
    @required String bzID,
  }) {

    final BzModel _bz =
    bzz.singleWhere((BzModel _b) => _b.id == bzID, orElse: () => null);
    return _bz;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getBzzIDs(List<BzModel> bzzModels) {
    final List<String> _ids = <String>[];

    if (Mapper.checkCanLoopList(bzzModels)) {
      for (final BzModel bz in bzzModels) {
        _ids.add(bz.id);
      }
    }

    return _ids;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getBzzLogos(List<BzModel> bzzModels) {
    final List<String> _pics = <String>[];

    if (Mapper.checkCanLoopList(bzzModels)) {
      for (final BzModel bz in bzzModels) {
        _pics.add(bz.logo);
      }
    }

    return _pics;
  }
  // --------------------
  ///
  static List<BzModel> getBzzFromBzzByBzType({
    @required List<BzModel> bzz,
    @required BzType bzType,
  }){

    final List<BzModel> _output = <BzModel>[];

    if (Mapper.checkCanLoopList(bzz) && bzType != null){
      for (final BzModel bz in bzz){

        final List<BzType> _bzTypesOfThisBz = bz.bzTypes;
        final bool _containsThisType = BzTyper.checkBzTypesContainThisType(
          bzTypes: _bzTypesOfThisBz,
          bzType: bzType,
        );

        if (_containsThisType == true){
          _output.add(bz);
        }

      }
    }

    return _output;
  }
  // --------------------
  ///
  static List<String> getBzTeamIDs(BzModel bzModel) {
    final List<AuthorModel> _authors = bzModel.authors;
    final List<String> _bzTeamIDs = <String>[];

    if (_authors != null) {
      for (final AuthorModel author in _authors) {
        _bzTeamIDs.add(author.userID);
      }
    }

    return _bzTeamIDs;
  }
  // --------------------
  ///
  static List<BzModel> getBzzByCreatorID({
    @required List<BzModel> bzzModels,
    @required String creatorID,
  }){
    final List<BzModel> _bzzModels = <BzModel>[];

    if (creatorID != null && Mapper.checkCanLoopList(bzzModels) == true){

      for (final BzModel bzModel in bzzModels){

        final AuthorModel _creator = AuthorModel.getCreatorAuthorFromBz(bzModel);

        if (_creator.userID == creatorID){
          _bzzModels.add(bzModel);
        }

      }

    }

    return _bzzModels;
  }
  // --------------------
  ///
  static List<BzModel> getBzzIDidNotCreate({
    @required List<BzModel> bzzModels,
    @required String userID,
  }){
    final List<BzModel> _bzzModels = <BzModel>[];

    if (userID != null && Mapper.checkCanLoopList(bzzModels) == true){

      for (final BzModel bzModel in bzzModels){

        final AuthorModel _creator = AuthorModel.getCreatorAuthorFromBz(bzModel);

        if (_creator.userID != userID){
          _bzzModels.add(bzModel);
        }

      }

    }

    return _bzzModels;
  }
  // -----------------------------------------------------------------------------

  /// BZ CHECKERS

  // --------------------
  /// TESTED : WORKS GOOD
  static bool checkBzzContainThisBz({
    @required List<BzModel> bzz,
    @required BzModel bzModel,
  }) {
    bool _contains = false;

    if (Mapper.checkCanLoopList(bzz) && bzModel != null) {
      for (final BzModel bz in bzz) {
        if (bz.id == bzModel.id) {
          _contains = true;
          break;
        }
      }
    }

    return _contains;
  }
  // --------------------
  /// TESTED : WORKS GOOD
  static bool checkBzzAreIdentical({
    @required BzModel bz1,
    @required BzModel bz2,
  }){
    bool _areIdentical = false;

    if (bz1 == null && bz2 == null){
      _areIdentical = true;
    }

    else if (bz1 != null && bz2 != null){

      if (
          bz1.id == bz2.id &&
          Mapper.checkListsAreIdentical(list1: bz1.bzTypes, list2: bz2.bzTypes) == true &&
          bz1.bzForm == bz2.bzForm &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.microSecond, time1: bz1.createdAt, time2: bz2.createdAt) == true &&
          bz1.accountType == bz2.accountType &&
          bz1.name == bz2.name &&
          Mapper.checkListsAreIdentical(list1: bz1.trigram, list2: bz2.trigram) == true &&
          bz1.logo == bz2.logo &&
          Mapper.checkListsAreIdentical(list1: bz1.scope, list2: bz2.scope) == true &&
          ZoneModel.checkZonesAreIdentical(zone1: bz1.zone, zone2: bz2.zone) == true &&
          bz1.about == bz2.about &&
          bz1.position == bz2.position &&
          ContactModel.checkContactsListsAreIdentical(contacts1: bz1.contacts, contacts2: bz2.contacts) == true &&
          AuthorModel.checkAuthorsListsAreIdentical(authors1: bz1.authors, authors2: bz2.authors) == true &&
          PendingAuthor.checkPendingAuthorsListsAreIdentical(list1: bz1.pendingAuthors, list2: bz2.pendingAuthors) == true &&
          bz1.showsTeam == bz2.showsTeam &&
          bz1.isVerified == bz2.isVerified &&
          bz1.bzState == bz2.bzState &&
          Mapper.checkListsAreIdentical(list1: bz1.flyersIDs, list2: bz2.flyersIDs) == true
      ){
        _areIdentical = true;
      }

    }

    if (_areIdentical == false){
      blogBzzDifferences(
        bz1: bz1,
        bz2: bz2,
      );
    }

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS GOOD
  static bool checkBzHasContacts({
    @required BzModel bzModel,
  }){
    bool _hasContacts = false;

    if (bzModel != null){

      if (Mapper.checkCanLoopList(bzModel.contacts) == true){
        _hasContacts = true;
      }
      else {

        for (final AuthorModel author in bzModel.authors){

          if (Mapper.checkCanLoopList(author.contacts) == true){
            _hasContacts = true;
            break;
          }

        }

      }

    }

    return _hasContacts;
  }
  // -----------------------------------------------------------------------------

  /// BZ VALIDATION

  // --------------------
  static List<AlertModel> requiredFields(BzModel bzModel){
    final List<AlertModel> _invalidFields = <AlertModel>[];

    //     _bzNameTextController.text.length < 3 ||
    //     _bzScopeTextController.text.length < 3 ||
    //     _currentBzDistrict == null ||
    //     _bzAboutTextController.text.length < 6
    //     // _currentBzContacts.length == 0 ||

    if (Mapper.checkCanLoopList(bzModel?.bzTypes) == false){
      _invalidFields.add(
          const AlertModel(
            alertID: 'bzType',
            titlePhraseID: 'phid_a_1_bzTypeMissing_title',
            messagePhraseID:'phid_a_bzTypeMissing_message',
          )
      );
    }

    if (bzModel?.bzForm == null){
      _invalidFields.add(
          const AlertModel(
            alertID: 'bzForm',
            titlePhraseID: 'phid_a_bzFormMissing_title',
            messagePhraseID: 'phid_a_bzFormMissing_message',
          )
      );
    }

    if (TextCheck.isEmpty(bzModel?.name) == true){
      _invalidFields.add(
          const AlertModel(
            alertID: 'bzName',
            titlePhraseID: 'phid_a_bzNameMissing_title',
            messagePhraseID: 'phid_a_bzNameMissing_message',
          )
      );
    }

    if (bzModel?.logo == null){
      _invalidFields.add(
          const AlertModel(
            alertID: 'bzLogo',
            titlePhraseID: 'phid_a_bzLogoMissing_title',
            messagePhraseID: 'phid_a_bzLogoMissing_message',
          )
      );
    }

    if (Mapper.checkCanLoopList(bzModel?.scope) == false){
      _invalidFields.add(
          const AlertModel(
            alertID: 'bzScope',
            titlePhraseID: 'phid_a_bzScopeMissing_title',
            messagePhraseID: 'phid_a_bzScopeMissing_message',
          )
      );
    }

    if (TextCheck.isEmpty(bzModel?.zone?.countryID) == true){
      _invalidFields.add(
          const AlertModel(
            alertID: 'bzCountry',
            titlePhraseID: 'a_0011_bzCountryMissing_title',
            messagePhraseID: 'a_0012_bzCountryMissing_message',
          )
      );
    }

    if (TextCheck.isEmpty(bzModel?.zone?.cityID) == true){
      _invalidFields.add(
          const AlertModel(
            alertID: 'bzCity',
            titlePhraseID: 'a_0013_bzCityMissing_title',
            messagePhraseID: 'a_0014_bzCityMissing_message',
          )
      );
    }

    if (TextCheck.isEmpty(bzModel?.about) == true){
      _invalidFields.add(
          const AlertModel(
            alertID: 'bzAbout',
            titlePhraseID: 'a_0015_bzAboutMissing_title',
            messagePhraseID: 'a_0016_bzAboutMissing_message',
          )
      );
    }

    return _invalidFields;
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
    if (other is BzModel){
      _areIdentical = checkBzzAreIdentical(
        bz1: this,
        bz2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      bzTypes.hashCode^
      bzForm.hashCode^
      createdAt.hashCode^
      accountType.hashCode^
      name.hashCode^
      trigram.hashCode^
      logo.hashCode^
      scope.hashCode^
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
      docSnapshot.hashCode;
// -----------------------------------------------------------------------------
}
