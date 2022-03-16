import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart' as Atlas;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/theme/wordz.dart' as Wordz;

/// ---------------------
//
/// Bz account has limited amount of available slides, with each published slide,
/// credit decreases,
/// slides can be purchased or rewarded
/// int credit; <------
/// List<Map<String,Object>> bzProgressMaps = [
///   {'challenge' : 'completeAccount',     'progress' : 100 , 'claimed' : true},
///   {'challenge' : 'verifyAccount',       'progress' : 0   , 'claimed' : false},
///   {'challenge' : 'publish 10 flyers',   'progress' : 90  , 'claimed' : false},
///   {'challenge' : 'publish 100 flyers',  'progress' : 9   , 'claimed' : false},
/// ];
/// List<Map<String,Object>> progress; <------
//
/// ---------------------
enum BzSection {
  realestate,
  construction,
  supplies,
}
/// ---------------------
enum BzType {
  developer, // dv -> pp (property flyer - property source flyer)
  broker, // br -> pp (property flyer)

  designer, // dr - ds (design flyer)
  contractor, // cn - pj (project flyer)
  craftsman, // ar - cr (craft flyer)

  manufacturer, // mn - pd (product flyer - product source flyer)
  supplier, // sp - pd (product flyer)
}
/// ---------------------
enum BzForm {
  individual,
  company,
}
/// ---------------------
enum BzAccountType {
  normal,
  premium,
  sphinx,
}
/// ---------------------
enum BzState {
  online,
  offline,
  deactivated,
  deleted,
  banned,
}
/// ---------------------
enum BzTab{
  flyers,
  about,
  authors,
  targets,
  powers,
  network,
}
/// ---------------------
class BzModel{
  /// --------------------------------------------------------------------------
  BzModel({
    @required this.id,
    // -------------------------
    @required this.bzTypes,
    @required this.bzForm,
    @required this.createdAt,
    @required this.accountType,
    // -------------------------
    @required this.name,
    @required this.trigram,
    @required this.logo,
    @required this.scope,
    @required this.zone,
    @required this.about,
    @required this.position,
    @required this.contacts,
    @required this.authors,
    @required this.showsTeam,
    // -------------------------
    @required this.isVerified,
    @required this.bzState,
    // -------------------------
    @required this.totalFollowers,
    @required this.totalSaves,
    @required this.totalShares,
    @required this.totalSlides,
    @required this.totalViews,
    @required this.totalCalls,
    // -------------------------
    @required this.flyersIDs,
    @required this.totalFlyers,
  });
  /// --------------------------------------------------------------------------
  final String id;
  // -------------------------
  final List<BzType> bzTypes;
  final BzForm bzForm;
  final DateTime createdAt;
  final BzAccountType accountType;
  // -------------------------
  final String name;
  final List<String> trigram;
  final dynamic logo;
  final String scope;

  final ZoneModel zone;
  final String about;
  final GeoPoint position;
  final List<ContactModel> contacts;
  final List<AuthorModel> authors;
  final bool showsTeam;
  // -------------------------
  final bool isVerified;

  final BzState bzState;
  // -------------------------
  int totalFollowers;
  int totalSaves;
  int totalShares;
  int totalSlides;
  int totalViews;
  int totalCalls;
  int totalFlyers;
  // -------------------------
  final List<String> flyersIDs;
  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }) {
    return <String, dynamic>{
      'id': id,
      // -------------------------
      'bzTypes': cipherBzTypes(bzTypes),
      'bzForm': cipherBzForm(bzForm),
      'createdAt': Timers.cipherTime(time: createdAt, toJSON: toJSON),
      'accountType': cipherBzAccountType(accountType),
      // -------------------------
      'name': name,
      'trigram': trigram,
      'logo': logo,
      'scope': scope,
      'zone': zone.toMap(),
      'about': about,
      'position': Atlas.cipherGeoPoint(point: position, toJSON: toJSON),
      'contacts': ContactModel.cipherContacts(contacts),
      'authors': AuthorModel.cipherAuthors(authors),
      'showsTeam': showsTeam,
      // -------------------------
      'isVerified': isVerified,
      'bzState': cipherBzState(bzState),
      // -------------------------
      'totalFollowers': totalFollowers,
      'totalSaves': totalSaves,
      'totalShares': totalShares,
      'totalSlides': totalSlides,
      'totalViews': totalViews,
      'totalCalls': totalCalls,
      'totalFlyers': totalFlyers,
      // -------------------------
      'flyersIDs': flyersIDs,
    };
  }
// -----------------------------------------------------------------------------
  static BzModel decipherBz({
    @required dynamic map,
    @required bool fromJSON,
  }) {
    BzModel _bzModel;

    if (map != null) {
      _bzModel = BzModel(
        id: map['id'],
        // -------------------------
        bzTypes: decipherBzTypes(map['bzTypes']),
        bzForm: decipherBzForm(map['bzForm']),
        createdAt:
            Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        accountType: decipherBzAccountType(map['accountType']),
        // -------------------------
        name: map['name'],
        trigram: Mapper.getStringsFromDynamics(dynamics: map['trigram']),
        logo: map['logo'],
        scope: map['scope'],
        zone: ZoneModel.decipherZoneMap(map['zone']),
        about: map['about'],
        position:
            Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
        contacts: ContactModel.decipherContacts(map['contacts']),
        authors: AuthorModel.decipherAuthors(map['authors']),
        showsTeam: map['showsTeam'],
        // -------------------------
        isVerified: map['isVerified'],
        bzState: decipherBzState(map['bzState']),
        // -------------------------
        totalFollowers: map['totalFollowers'],
        totalSaves: map['totalSaves'],
        totalShares: map['totalShares'],
        totalSlides: map['totalSlides'],
        totalViews: map['totalViews'],
        totalCalls: map['totalCalls'],
        // -------------------------
        flyersIDs: Mapper.getStringsFromDynamics(dynamics: map['flyersIDs']),
        totalFlyers: map['totalFlyers'],
      );
    }

    return _bzModel;
  }
// -----------------------------------------------------------------------------
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

  /// BZ INITIALIZERS

// ------------------------------------------
  static BzModel createInitialBzModelFromUserData(UserModel userModel) {
    return BzModel(
      id: null,
      name: userModel.company,
      trigram: TextGen.createTrigram(input: userModel.company),
      zone: userModel.zone,
      contacts: <ContactModel>[
        ContactModel(
            contact: ContactModel.getAContactValueFromContacts(
                userModel.contacts,
                ContactType.email
            ),
            contactType: ContactType.email),
        ContactModel(
            contact: ContactModel.getAContactValueFromContacts(
                userModel.contacts,
                ContactType.phone
            ),
            contactType: ContactType.phone
        ),
      ],
      authors: <AuthorModel>[
        AuthorModel.createMasterAuthorModelFromUserModel(userModel)
      ],
      showsTeam: true,
      // -------------------------
      isVerified: false,
      bzState: BzState.offline,
      // -------------------------
      totalFollowers: 0,
      totalSaves: 0,
      totalShares: 0,
      totalSlides: 0,
      totalViews: 0,
      totalCalls: 0,
      // -------------------------
      flyersIDs: <String>[],
      totalFlyers: 0,
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
// ------------------------------------------
  static BzModel getBzModelFromSnapshot(DocumentSnapshot<Object> doc) {
    final DocumentSnapshot<Object> _map = doc.data();
    final BzModel _bzModel = BzModel.decipherBz(
      map: _map,
      fromJSON: false,
    );

    blog(' map the bz Model is $_bzModel');

    return _bzModel;
  }
// -----------------------------------------------------------------------------

  /// BZ TYPE

// ------------------------------------------
  static String cipherBzType(BzType x) {
    switch (x) {
      case BzType.developer       :  return 'developer'     ; break;
      case BzType.broker          :  return 'broker'        ; break;
      case BzType.designer        :  return 'designer'      ; break;
      case BzType.contractor      :  return 'contractor'    ; break;
      case BzType.craftsman       :  return 'craftsman'     ; break;
      case BzType.manufacturer    :  return 'manufacturer'  ; break;
      case BzType.supplier        :  return 'supplier'      ; break;
      default:  return null;
    }
  }
// ------------------------------------------
  static List<String> cipherBzTypes(List<BzType> bzTypes){
    final List<String> _bzTypes = <String>[];

    if (Mapper.canLoopList(bzTypes) == true){

      for (final BzType bzType in bzTypes){
        final String _ciphered = cipherBzType(bzType);
        _bzTypes.add(_ciphered);
      }

    }

    return _bzTypes;
  }
// ------------------------------------------
  static BzType decipherBzType(String x) {
    switch (x) {
      case 'developer'      : return BzType.developer;      break;
      case 'broker'         : return BzType.broker;         break;
      case 'designer'       : return BzType.designer;       break;
      case 'contractor'     : return BzType.contractor;     break;
      case 'craftsman'      : return BzType.craftsman;      break;
      case 'manufacturer'   : return BzType.manufacturer;   break;
      case 'supplier'       : return BzType.supplier;       break;
      default:  return null;
    }
  }
// ------------------------------------------
  static List<BzType> decipherBzTypes(List<dynamic> bzTypes){
    final List<BzType> _bzTypes = <BzType>[];

    if (Mapper.canLoopList(bzTypes) == true){

      final List<String> _strings = Mapper.getStringsFromDynamics(dynamics: bzTypes);

      for (final String _string in _strings){
        final BzType _bzType = decipherBzType(_string);
        _bzTypes.add(_bzType);
      }

    }

    return _bzTypes;
  }
// ------------------------------------------
  static List<BzType> getBzTypesListWithoutOneType(BzType removeThisType){
    const List<BzType> _allTypes = bzTypesList;
    final List<BzType> _output = <BzType>[];

    for (final BzType bzType in _allTypes){
      if (bzType != removeThisType){
        _output.add(bzType);
      }
    }

    return _output;
  }
// ------------------------------------------
  static bool bzTypesContainThisType({
    @required BzType bzType,
    @required List<BzType> bzTypes,
  }){
    bool _contains = false;

    if (Mapper.canLoopList(bzTypes) == true){

      if (bzTypes.contains(bzType) == true){
        _contains = true;
      }

    }

    return _contains;
  }
// ------------------------------------------
  static String translateBzType({
    @required BuildContext context,
    @required BzType bzType,
    bool pluralTranslation = true,
  }){

    /// PLURAL
    if (pluralTranslation == true){
      return
        bzType == BzType.developer ? Wordz.realEstateDevelopers(context) :
        bzType == BzType.broker ? Wordz.brokers(context) :
        bzType == BzType.designer ? Wordz.designers(context) :
        bzType == BzType.contractor ? Wordz.contractors(context) :
        bzType == BzType.craftsman ? Wordz.craftsmen(context) :
        bzType == BzType.manufacturer ? Wordz.manufacturers(context) :
        bzType == BzType.supplier ? Wordz.suppliers(context) :
        'Builders';
    }

    /// SINGLE
    else {
      return
        bzType == BzType.developer ? Wordz.realEstateDeveloper(context) :
        bzType == BzType.broker ? Wordz.realEstateBroker(context) :
        bzType == BzType.designer ? Wordz.designer(context) :
        bzType == BzType.contractor ? Wordz.contractor(context) :
        bzType == BzType.craftsman ? Wordz.craftsman(context) :
        bzType == BzType.manufacturer ? Wordz.manufacturer(context) :
        bzType == BzType.supplier ? Wordz.supplier(context) :
        'Builder';
    }

  }
// ------------------------------------------
  static List<String> translateBzTypes({
    @required BuildContext context,
    @required List<BzType> bzTypes,
    bool pluralTranslation = true,
  }){
    final List<String> _strings = <String>[];

    if (Mapper.canLoopList(bzTypes) == true){

      for (final BzType type in bzTypes){

        final String _translation = translateBzType(
          context: context,
          bzType: type,
          pluralTranslation: pluralTranslation,
        );

        _strings.add(_translation);

      }

    }

    return _strings;
  }

  static String generateTranslatedBzTypesString({
    @required BuildContext context,
    @required List<BzType> bzTypes,
  }){

    final List<String> _bzTypesStrings = BzModel.translateBzTypes(
      context: context,
      bzTypes: bzTypes,
      pluralTranslation: false,
    );

    final String _bzTypesOneString =
    TextGen.generateStringFromStrings(_bzTypesStrings);

    return _bzTypesOneString;
  }
// ------------------------------------------
  static List<BzType> concludeBzTypeByBzSection(BzSection bzSection){

    List<BzType> _bzTypes = <BzType>[];

    /// REAL ESTATE BZ TYPES
    if (bzSection == BzSection.realestate){
      _bzTypes = <BzType>[BzType.developer, BzType.broker];
    }

    /// CONSTRUCTION BZ TYPES
    else if (bzSection == BzSection.construction){
      _bzTypes = <BzType>[BzType.designer, BzType.contractor, BzType.craftsman];
    }

    /// SUPPLIES BZ TYPES
    else {
      _bzTypes = <BzType>[BzType.supplier, BzType.manufacturer];
    }

    return _bzTypes;
  }
// ------------------------------------------
  static List<BzType> generateInactiveBzTypes(BzSection bzSection){

    /// INITIAL LIST OF ALL BZ TYPES
    final List<BzType> _bzTypes = <BzType>[...BzModel.bzTypesList];

    /// BZ TYPES BY SECTION
    final List<BzType> _bzTypesBySection = concludeBzTypeByBzSection(bzSection);

    /// REMOVE SELECTED BZ TYPES FROM THE LIST
    for (final BzType bzType in _bzTypesBySection){
      _bzTypes.remove(bzType);
    }

    return _bzTypes;
  }
// ------------------------------------------
  static const List<BzType> bzTypesList = <BzType>[
    BzType.developer,
    BzType.broker,
    BzType.designer,
    BzType.contractor,
    BzType.craftsman,
    BzType.manufacturer,
    BzType.supplier,
  ];
// -----------------------------------------------------------------------------

  /// BZ ACCOUNT TYPE

// ------------------------------------------
  static String cipherBzAccountType(BzAccountType bzAccountType) {
    switch (bzAccountType) {
      case BzAccountType.normal:  return 'normal';  break;
      case BzAccountType.premium: return 'premium'; break;
      case BzAccountType.sphinx:  return 'sphinx';  break;
      default:  return null;
    }
  }
// ------------------------------------------
  static BzAccountType decipherBzAccountType(String bzAccountType) {
    switch (bzAccountType) {
      case 'normal'   : return BzAccountType.normal   ; break; // 1
      case 'premium'  : return BzAccountType.premium  ; break; // 2
      case 'sphinx'   : return BzAccountType.sphinx   ; break; // 3
      default:return null;
    }
  }
// ------------------------------------------
  static const List<BzAccountType> bzAccountTypesList = <BzAccountType>[
    BzAccountType.normal,
    BzAccountType.premium,
    BzAccountType.sphinx,
  ];
// -----------------------------------------------------------------------------

  /// BZ FORM

// ------------------------------------------
  static String cipherBzForm(BzForm x) {
    switch (x) {
      case BzForm.individual  : return 'individual' ; break;
      case BzForm.company     : return 'company'    ; break;
      default:  return null;
    }
  }
// ------------------------------------------
  static BzForm decipherBzForm(String x) {
    switch (x) {
      case 'individual' :  return BzForm.individual ; break; // 1
      case 'company'    :  return BzForm.company    ; break; // 2
      default:  return null;
    }
  }
// ------------------------------------------
  static String translateBzForm({
    @required BuildContext context,
    @required BzForm bzForm,
  }){

    if (bzForm == BzForm.company){
      return Wordz.company(context);
    }

    else if (bzForm == BzForm.individual){
      return Wordz.individual(context);
    }

    else {
      return null;
    }

  }
// ------------------------------------------
  static List<String> translateBzForms({
    @required BuildContext context,
    @required List<BzForm> bzForms,
  }){
    final List<String> _strings = <String>[];

    if (Mapper.canLoopList(bzForms) == true){

      for (final BzForm bzForm in bzForms){
        final String _translation = translateBzForm(
          context: context,
          bzForm: bzForm,
        );
        _strings.add(_translation);
      }

    }

    return _strings;
  }
// ------------------------------------------
  static bool bzFormsContainThisForm({
    @required List<BzForm> bzForms,
    @required BzForm bzForm,
  }){
    bool _contains = false;

    if (Mapper.canLoopList(bzForms) == true){

      if (bzForms.contains(bzForm) == true){
        _contains = true;
      }

    }

    return _contains;
  }
// ------------------------------------------
  static List<BzForm> generateInactiveBzForms(List<BzType> bzTypes){

    /// INITIAL LIST OF ALL BZ FORMS
    List<BzForm> _bzForms = <BzForm>[...BzModel.bzFormsList];

    if (Mapper.canLoopList(bzTypes) == true){

      /// MORE THAN ONE BZ TYPE
      if (bzTypes.length > 1){

      }

      /// IF ONLY ONE BZ TYPE
      else if (bzTypes.length == 1){

        /// BZ FORMS BY SECTION
        final List<BzForm> _bzFormsBySection = concludeBzFormsByBzType(bzTypes[0]);

        /// REMOVE SELECTED BZ FORMS FROM THE LIST
        for (final BzForm bzForm in _bzFormsBySection){
          _bzForms.remove(bzForm);
        }

      }

      /// IF NO BZ TYPES SELECTED
      else {
        _bzForms = <BzForm>[];
      }

    }

    return _bzForms;
  }
// ------------------------------------------
  static List<BzForm> concludeBzFormsByBzType(BzType bzType){

    List<BzForm> _bzForm = <BzForm>[];

    /// DEVELOPER
    if (bzType == BzType.developer){
      _bzForm = <BzForm>[BzForm.company];
    }

    /// BROKER
    else if (bzType == BzType.broker){
      _bzForm = <BzForm>[BzForm.company, BzForm.individual];
    }

    /// DESIGNER
    else if (bzType == BzType.designer){
      _bzForm = <BzForm>[BzForm.company, BzForm.individual];
    }

    /// CONTRACTOR
    else if (bzType == BzType.contractor){
      _bzForm = <BzForm>[BzForm.company, BzForm.individual];
    }

    /// CRAFTSMAN
    else if (bzType == BzType.craftsman){
      _bzForm = <BzForm>[BzForm.individual];
    }

    /// SUPPLIER
    else if (bzType == BzType.supplier){
      _bzForm = <BzForm>[BzForm.company];
    }

    /// MANUFACTURER
    else if (bzType == BzType.manufacturer){
      _bzForm = <BzForm>[BzForm.company];
    }

    else {
      _bzForm = <BzForm>[BzForm.company, BzForm.individual];
    }

    return _bzForm;
  }
// ------------------------------------------
  static const List<BzForm> bzFormsList = <BzForm>[
    BzForm.individual,
    BzForm.company,
  ];
// -----------------------------------------------------------------------------

  /// BZ STATE

// ------------------------------------------
  static String cipherBzState(BzState state) {
    switch (state) {
      case BzState.online       : return 'online'     ; break;
      case BzState.offline      : return 'offline'    ; break;
      case BzState.deactivated  : return 'deactivated'; break;
      case BzState.deleted      : return 'deleted'    ; break;
      case BzState.banned       : return 'banned'     ;  break;
      default:  return null;
    }
  }
// ------------------------------------------
  static BzState decipherBzState(String state) {
    switch (state) {
      case 'online'       : return BzState.online       ; break;
      case 'offline'      : return BzState.offline      ; break;
      case 'deactivated'  : return BzState.deactivated  ; break;
      case 'deleted'      : return BzState.deleted      ; break;
      case 'banned'       : return BzState.banned       ; break;
      default:  return null;
    }
  }
// ------------------------------------------
  static const List<BzState> bzStatesList = <BzState>[
    BzState.online,
    BzState.offline,
    BzState.deactivated,
    BzState.deleted,
    BzState.banned,
  ];
// -----------------------------------------------------------------------------

  /// BZ SECTION

// ------------------------------------------
  static String translateBzSection({
    @required BuildContext context,
    @required BzSection bzSection,
  }){
    final String _translation =
    bzSection == BzSection.realestate ? 'Real-Estate'
        :
    bzSection == BzSection.construction ? 'Construction'
        :
    bzSection == BzSection.supplies ? 'Supplies'
        :
    'Bldrs';

    return _translation;
  }
// ------------------------------------------
  static List<String> translateBzSections({
    @required BuildContext context,
    @required List<BzSection> bzSections,
  }){
    final List<String> _strings = <String>[];

    if (Mapper.canLoopList(bzSections) == true){

      for (final BzSection section in bzSections){
        final String _translation = translateBzSection(
          context: context,
          bzSection: section,
        );
        _strings.add(_translation);
      }

    }

    return _strings;
  }
// ------------------------------------------
  static BzSection concludeBzSectionByBzTypes(List<BzType> bzTypes){

    BzType _bzType;
    if (Mapper.canLoopList(bzTypes) == true){
      _bzType = bzTypes[0];
    }

    switch (_bzType){

      case BzType.developer: return BzSection.realestate; break;
      case BzType.broker: return BzSection.realestate; break;

      case BzType.designer: return BzSection.construction; break;
      case BzType.contractor: return BzSection.construction; break;
      case BzType.craftsman: return BzSection.construction; break;

      case BzType.supplier: return BzSection.construction; break;
      case BzType.manufacturer: return BzSection.construction; break;

      default : return null;
    }

  }
// ------------------------------------------
  static  const List<BzSection> bzSectionsList = <BzSection>[
    BzSection.realestate,
    BzSection.construction,
    BzSection.supplies,
  ];
// -----------------------------------------------------------------------------

  /// BZ DUMMIES

// ------------------------------------------
  static BzModel dummyBz(String bzID) {
    final String _bzID = bzID ?? 'ytLfMwdqK565ByP1p56G';

    return BzModel(
      id: _bzID,
      logo: Iconz.dumBusinessLogo, //'https://firebasestorage.googleapis.com/v0/b/bldrsnet.appspot.com/o/bzLogos%2Far1.jpg?alt=media&token=f68673f8-409a-426a-9a80-f1026715c469'
      name: 'Business Name',
      trigram: TextGen.createTrigram(input: 'Business Name'),
      bzTypes: <BzType>[BzType.designer],
      zone: ZoneModel.dummyZone(),
      totalFollowers: 1000,
      totalFlyers: 10,
      bzState: BzState.online,
      position: Atlas.dummyPosition(),
      flyersIDs: <String>[],
      authors: <AuthorModel>[],
      contacts: <ContactModel>[],
      bzForm: BzForm.company,
      accountType: BzAccountType.normal,
      createdAt: Timers.createDate(year: 1987, month: 10, day: 06),
      about: 'About biz',
      isVerified: true,
      scope: 'Scope of Bz',
      showsTeam: true,
      totalCalls: 1,
      totalSaves: 2,
      totalShares: 3,
      totalSlides: 4,
      totalViews: 5,
    );
  }
// ------------------------------------------
  static List<BzModel> dummyBzz({int length = 4}){

    final List<BzModel> _dummies = <BzModel>[];

    for (int i = 0; i <= length; i++){
      _dummies.add(dummyBz('bzID_$i'));
    }

    return _dummies;
  }
// -----------------------------------------------------------------------------

  /// BZ BLOGGING

// ------------------------------------------
  void blogBz({String methodName = 'printBzModel'}) {
    final String _methodName = methodName ?? 'BZ';

    blog('$_methodName : PRINTING BZ MODEL ---------------- START -- ');

    blog('id : $id');
    blog('bzType : $bzTypes');
    blog('bzForm : $bzForm');
    blog('createdAt : $createdAt');
    blog('accountType : $accountType');
    blog('mame : $name');
    blog('logo : $logo');
    blog('scope : $scope');
    blog('zone : $zone');
    blog('about : $about');
    blog('position : $position');
    blog('contacts : $contacts');
    blog('authors : $authors');
    blog('showsTeam : $showsTeam');
    blog('isVerified : $isVerified');
    blog('bzState : $bzState');
    blog('totalFollowers : $totalFollowers');
    blog('totalSaves : $totalSaves');
    blog('totalShares : $totalShares');
    blog('totalSlides : $totalSlides');
    blog('totalViews : $totalViews');
    blog('totalCalls : $totalCalls');
    blog('flyersIDs : $flyersIDs');
    blog('totalFlyers : $totalFlyers');

    blog('$_methodName : PRINTING BZ MODEL ---------------- END -- ');
  }
// ------------------------------------------
  static void blogBzz({
    @required List<BzModel> bzz,
    String methodName,
  }){

    if (Mapper.canLoopList(bzz)){

      for (final BzModel bz in bzz){
        bz.blogBz(methodName: methodName);
      }

    }

  }
// -----------------------------------------------------------------------------

  /// BZ SEARCHERS

// ------------------------------------------
  static BzModel getBzFromBzzByBzID(List<BzModel> bzz, String bzID) {
    final BzModel _bz =
    bzz.singleWhere((BzModel _b) => _b.id == bzID, orElse: () => null);
    return _bz;
  }
// ------------------------------------------
  static List<String> getBzzIDsFromBzz(List<BzModel> bzzModels) {
    final List<String> _ids = <String>[];

    if (Mapper.canLoopList(bzzModels)) {
      for (final BzModel bz in bzzModels) {
        _ids.add(bz.id);
      }
    }

    return _ids;
  }
// ------------------------------------------
  static List<BzModel> getBzzFromBzzByBzType({
    @required List<BzModel> bzz,
    @required BzType bzType,
  }){

    final List<BzModel> _output = <BzModel>[];

    if (Mapper.canLoopList(bzz) && bzType != null){
      for (final BzModel bz in bzz){

        final List<BzType> _bzTypesOfThisBz = bz.bzTypes;
        final bool _containsThisType = BzModel.bzTypesContainThisType(
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
// ------------------------------------------
  static bool bzzContainThisBz({
    @required List<BzModel> bzz,
    @required BzModel bzModel,
  }) {
    bool _contains = false;

    if (Mapper.canLoopList(bzz) && bzModel != null) {
      for (final BzModel bz in bzz) {
        if (bz.id == bzModel.id) {
          _contains = true;
          break;
        }
      }
    }

    return _contains;
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------

  /// BZ TABS

// ------------------------------------------
  static int getBzTabIndex(BzTab bzTab){
    final int _index = bzTabsList.indexWhere((tab) => tab == bzTab);
    return _index;
  }
// ------------------------------------------
  static List<BzTab> bzTabsList = <BzTab>[
    BzTab.flyers,
    BzTab.about,
    BzTab.authors,
    BzTab.targets,
    BzTab.powers,
    BzTab.network,
  ];
// ------------------------------------------
  /// CAUTION : THESE TITLES CAN NOT BE TRANSLATED DUE TO THEIR USE IN WIDGET KEYS
  static const List<String> bzPagesTabsTitlesInEnglishOnly = <String>[
    'Flyers',
    'About',
    'Authors',
    'Targets',
    'Powers',
    'Network',
  ];
// -----------------------------------------------------------------------------

  /// BZ VALIDATION

// ------------------------------------------
  static List<String> requiredFields(BzModel bzModel){
    final List<String> _invalidFields = <String>[];

    if (Mapper.canLoopList(bzModel?.bzTypes) == false){
      _invalidFields.add('Business Type');
    }

    if (bzModel?.bzForm == null){
      _invalidFields.add('Business Form');
    }

    if (stringIsEmpty(bzModel?.name) == true){
      _invalidFields.add('Business Name');
    }

    if (bzModel?.logo == null){
      _invalidFields.add('Business Logo');
    }

    if (stringIsEmpty(bzModel?.scope) == true){
      _invalidFields.add('Business Scope');
    }

    if (stringIsEmpty(bzModel?.zone?.countryID) == true){
      _invalidFields.add('Business Country');
    }

    if (stringIsEmpty(bzModel?.zone?.cityID) == true){
      _invalidFields.add('Business City');
    }

    if (stringIsEmpty(bzModel?.about) == true){
      _invalidFields.add('About Business');
    }

    return _invalidFields;
  }
// -----------------------------------------------------------------------------

}
