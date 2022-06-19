import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/secondary_models/alert_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart' as Atlas;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_directionerz.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  notes,
  targets,
  powers,
  network,
  settings,
}
/// ---------------------
@immutable
class BzModel{
  /// --------------------------------------------------------------------------
  const BzModel({
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
    this.docSnapshot,
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
  final List<String> scope;

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
  final int totalFollowers;
  final int totalSaves;
  final int totalShares;
  final int totalSlides;
  final int totalViews;
  final int totalCalls;
  final int totalFlyers;
  // -------------------------
  final List<String> flyersIDs;
  final DocumentSnapshot<Object> docSnapshot;
// -----------------------------------------------------------------------------

  /// CLONING

// ------------------------------------------
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
    bool showsTeam,
    bool isVerified,
    BzState bzState,
    int totalFollowers,
    int totalSaves,
    int totalShares,
    int totalSlides,
    int totalViews,
    int totalCalls,
    int totalFlyers,
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
      showsTeam : showsTeam ?? this.showsTeam,
      isVerified : isVerified ?? this.isVerified,
      bzState : bzState ?? this.bzState,
      totalFollowers : totalFollowers ?? this.totalFollowers,
      totalSaves : totalSaves ?? this.totalSaves,
      totalShares : totalShares ?? this.totalShares,
      totalSlides : totalSlides ?? this.totalSlides,
      totalViews : totalViews ?? this.totalViews,
      totalCalls : totalCalls ?? this.totalCalls,
      flyersIDs : flyersIDs ?? this.flyersIDs,
      totalFlyers : totalFlyers ?? this.totalFlyers,
      docSnapshot: docSnapshot ?? this.docSnapshot,
    );
}
// -----------------------------------------------------------------------------

  /// CYPHERS

// -------------------------------
  /// TESTED : WORKS PERFECT
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
// -------------------------------
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
// -------------------------------
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
        bzTypes: decipherBzTypes(map['bzTypes']),
        bzForm: decipherBzForm(map['bzForm']),
        createdAt:
            Timers.decipherTime(time: map['createdAt'], fromJSON: fromJSON),
        accountType: decipherBzAccountType(map['accountType']),
        // -------------------------
        name: map['name'],
        trigram: Mapper.getStringsFromDynamics(dynamics: map['trigram']),
        logo: map['logo'],
        scope: Mapper.getStringsFromDynamics(dynamics: map['scope']),
        zone: ZoneModel.decipherZoneMap(map['zone']),
        about: map['about'],
        position: Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
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
        docSnapshot: map['docSnapshot'],
      );
    }

    return _bzModel;
  }
// -------------------------------
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

// ------------------------------------------
  static BzModel convertFireUserDataIntoInitialBzModel(UserModel userModel) {
    return BzModel(
      id: null,
      name: userModel.company,
      trigram: TextGen.createTrigram(input: userModel.company),
      zone: userModel.zone,
      contacts: <ContactModel>[
        ContactModel(
            contactType: ContactType.email,
            value: ContactModel.getAContactValueFromContacts(
                contacts: userModel.contacts,
                contactType: ContactType.email,
            ),
        ),
        ContactModel(
            contactType: ContactType.phone,
            value: ContactModel.getAContactValueFromContacts(
                contacts: userModel.contacts,
                contactType: ContactType.phone
            ),
        ),
      ],
      authors: <AuthorModel>[
        AuthorModel.createAuthorFromUserModel(
          userModel: userModel,
          isMaster: true,
        )
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
      flyersIDs: const <String>[],
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

// ------------------------------------------
  static List<String> removeFlyerIDFromBzFlyersIDs({
    @required BzModel bzModel,
    @required String flyerIDToRemove,
}){
    final List<String> _ids = <String>[...bzModel.flyersIDs];

    if (Mapper.checkCanLoopList(_ids) == true && flyerIDToRemove != null){

      final int _index = _ids.indexWhere((id) => id == flyerIDToRemove);

      if (_index != -1){
        _ids.removeAt(_index);
      }

    }

    return _ids;
  }
// ------------------------------------------
  static List<BzModel> addOrRemoveBzToBzz({
    @required List<BzModel> bzzModels,
    @required BzModel bzModel,
  }){
    final List<BzModel> _output = <BzModel>[...bzzModels];

    if (bzModel != null){

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
// -----------------------------------
  static BzModel replaceAuthor({
    @required AuthorModel updatedAuthor,
    @required BzModel bzModel,
  }){

    BzModel _output = bzModel;

    if (updatedAuthor != null && bzModel != null){

      _output = bzModel.copyWith(
        authors: AuthorModel.replaceAuthorModelInAuthorsList(
          authorToReplace: updatedAuthor,
          authors: bzModel.authors,
        ),
      );

    }


    return _output;
  }
// -----------------------------------------------------------------------------

  /// BZ TYPE CYPHERS

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

    if (Mapper.checkCanLoopList(bzTypes) == true){

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

    if (Mapper.checkCanLoopList(bzTypes) == true){

      final List<String> _strings = Mapper.getStringsFromDynamics(dynamics: bzTypes);

      for (final String _string in _strings){
        final BzType _bzType = decipherBzType(_string);
        _bzTypes.add(_bzType);
      }

    }

    return _bzTypes;
  }
// -----------------------------------------------------------------------------

  /// BZ TYPE GETTERS

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
  static String getBzTypeIconOff(BzType bzType) {

    final String icon = bzType == BzType.developer ? Iconz.bxPropertiesOff
        :
    bzType == BzType.broker ? Iconz.bxPropertiesOff
        :
    bzType == BzType.manufacturer ? Iconz.bxProductsOff
        :
    bzType == BzType.supplier ? Iconz.bxProductsOff
        :
    bzType == BzType.designer ? Iconz.bxDesignsOff
        :
    bzType == BzType.contractor ? Iconz.bxProjectsOff
        :
    bzType == BzType.craftsman ? Iconz.bxCraftsOff
        :
    null;

    return icon;
  }
// ------------------------------------------
  static String getBzTypeIconOn(BzType bzType) {

    final String icon =
    bzType == BzType.developer ? Iconz.bxPropertiesOn
        :
    bzType == BzType.broker ? Iconz.bxPropertiesOn
        :
    bzType == BzType.manufacturer ? Iconz.bxProductsOn
        :
    bzType == BzType.supplier ? Iconz.bxProductsOn
        :
    bzType == BzType.designer ? Iconz.bxDesignsOn
        :
    bzType == BzType.contractor ? Iconz.bxProjectsOn
        :
    bzType == BzType.craftsman ? Iconz.bxCraftsOn
        :
    null;

    return icon;
  }
// -----------------------------------------------------------------------------

  /// BZ TYPE CHECKERS

// ------------------------------------------
  static bool checkBzTypesContainThisType({
    @required BzType bzType,
    @required List<BzType> bzTypes,
  }){
    bool _contains = false;

    if (Mapper.checkCanLoopList(bzTypes) == true){

      if (bzTypes.contains(bzType) == true){
        _contains = true;
      }

    }

    return _contains;
  }
// -----------------------------------------------------------------------------

  /// BZ TYPE TRANSLATIONS

// ------------------------------------------
  static String translateBzType({
    @required BuildContext context,
    @required BzType bzType,
    bool nounTranslation = true,
    bool pluralTranslation = true,
  }){

    /// NOUN
    if (nounTranslation == true){
      return
        bzType == BzType.developer ? superPhrase(context, 'phid_realEstateDevelopment') :
        bzType == BzType.broker ? superPhrase(context, 'phid_realEstateBrokerage') :
        bzType == BzType.designer ? superPhrase(context, 'phid_design') :
        bzType == BzType.contractor ? superPhrase(context, 'phid_contracting') :
        bzType == BzType.craftsman ? superPhrase(context, 'phid_craftsmanship') :
        bzType == BzType.manufacturer ? superPhrase(context, 'phid_manufacturing') :
        bzType == BzType.supplier ? superPhrase(context, 'phid_supplying') :
        'Builders';
    }

    /// NOT NOUN
    else {

      /// PLURAL
      if (pluralTranslation == true){
        return
          bzType == BzType.developer ? superPhrase(context, 'phid_realEstateDevelopers') :
          bzType == BzType.broker ? superPhrase(context, 'phid_realEstateBrokers') :
          bzType == BzType.designer ? superPhrase(context, 'phid_designers') :
          bzType == BzType.contractor ? superPhrase(context, 'phid_contractors') :
          bzType == BzType.craftsman ? superPhrase(context, 'phid_craftsmen') :
          bzType == BzType.manufacturer ? superPhrase(context, 'phid_manufacturers') :
          bzType == BzType.supplier ? superPhrase(context, 'phid_supplier') :
          'Builders';
      }

      /// SINGLE
      else {
        return
          bzType == BzType.developer ? superPhrase(context, 'phid_realEstateDeveloper') :
          bzType == BzType.broker ? superPhrase(context, 'phid_realEstateBroker') :
          bzType == BzType.designer ? superPhrase(context, 'phid_designer') :
          bzType == BzType.contractor ? superPhrase(context, 'phid_contractor') :
          bzType == BzType.craftsman ? superPhrase(context, 'phid_craftsman') :
          bzType == BzType.manufacturer ? superPhrase(context, 'phid_manufacturer') :
          bzType == BzType.supplier ? superPhrase(context, 'phid_suppliers') :
          'Builder';
      }

    }

  }
// ------------------------------------------
  static List<String> translateBzTypes({
    @required BuildContext context,
    @required List<BzType> bzTypes,
    bool pluralTranslation = true,
  }){
    final List<String> _strings = <String>[];

    if (Mapper.checkCanLoopList(bzTypes) == true){

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
// ------------------------------------------
  static String translateBzTypesIntoString({
    @required BuildContext context,
    @required List<BzType> bzTypes,
    @required BzForm bzForm,
  }){

    final List<String> _bzTypesStrings = BzModel.translateBzTypes(
      context: context,
      bzTypes: bzTypes,
      pluralTranslation: false,
    );

    final String _bzFormString = BzModel.translateBzForm(
        context: context,
        bzForm: bzForm,
    );

    final String _bzTypesOneString = TextGen.generateStringFromStrings(
      strings: _bzTypesStrings,
    );

    String _output = '$_bzTypesOneString\n$_bzFormString';

    if (appIsLeftToRight(context) == false){
      _output = '$_bzFormString\n$_bzTypesOneString';
    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// BZ TYPE CONCLUDERS

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
  static List<BzType> concludeInactiveBzTypesBySection({
    @required BzSection bzSection,
    List<BzType> initialBzTypes,
  }){

    /// INITIAL LIST OF ALL BZ TYPES
    final List<BzType> _bzTypes = <BzType>[...BzModel.bzTypesList];

    /// BZ TYPES BY SECTION
    final List<BzType> _bzTypesBySection = concludeBzTypeByBzSection(bzSection);

    /// REMOVE SELECTED BZ TYPES FROM THE LIST
    for (final BzType bzType in _bzTypesBySection){
      _bzTypes.remove(bzType);
    }

    /// ADD CRAFTSMEN IF STARTING WITH DESIGNERS OR CONTRACTORS
    if (Mapper.checkCanLoopList(initialBzTypes) == true){
      if (bzSection == BzSection.construction){
        if (
        initialBzTypes.contains(BzType.designer)
        ||
        initialBzTypes.contains(BzType.contractor)
        ){
          _bzTypes.add(BzType.craftsman);
        }
      }
    }

    return _bzTypes;
  }
// ------------------------------------------
  static List<BzType> concludeMixableBzTypes({
    @required BzType bzType,
}){

    List<BzType> _mixableTypes;

    /// DEVELOPER
    if (bzType == BzType.developer){
      _mixableTypes = <BzType>[
        BzType.broker
      ];
    }

    /// BROKER
    if (bzType == BzType.broker){
      _mixableTypes = <BzType>[
        BzType.developer
      ];
    }

    /// DESIGNER
    if (bzType == BzType.designer){
      _mixableTypes = <BzType>[
        BzType.contractor
      ];
    }

    /// CONTRACTOR
    if (bzType == BzType.contractor){
      _mixableTypes = <BzType>[
        BzType.designer
      ];
    }

    /// CRAFTSMAN
    if (bzType == BzType.craftsman){
      _mixableTypes = <BzType>[];
    }

    /// SUPPLIER
    if (bzType == BzType.supplier){
      _mixableTypes = <BzType>[
        BzType.manufacturer,
      ];
    }

    /// MANUFACTURER
    if (bzType == BzType.manufacturer){
      _mixableTypes = <BzType>[
        BzType.supplier,
      ];
    }

    return _mixableTypes;
  }
// ------------------------------------------
  static List<BzType> concludeInactiveBzTypesBySelectedType({
  @required BzType selectedBzType,
}){

    final List<BzType> _mixableTypes = concludeMixableBzTypes(
        bzType: selectedBzType
    );

    final List<BzType> _inactiveTypes = <BzType>[...bzTypesList];
    _inactiveTypes.remove(selectedBzType);

    /// REMOVE MIXABLE TYPES FROM ALL TYPE TO GET INACTIVE TYPES
    for (final BzType type in _mixableTypes){
      _inactiveTypes.remove(type);
    }

    return _inactiveTypes;
  }
// ------------------------------------------
  static List<BzType> concludeInactiveBzTypesBasedOnSelectedBzTypes({
    @required BzType newSelectedType,
    @required List<BzType> selectedBzTypes,
    @required BzSection selectedBzSection,
  }){

    List<BzType> _inactiveBzTypes;

    /// INACTIVATE BZ TYPES ACCORDING TO SECTION WHEN NOTHING IS SELECTED
    if (selectedBzTypes.isEmpty){
      _inactiveBzTypes = BzModel.concludeInactiveBzTypesBySection(
          bzSection: selectedBzSection,
      );

    }

    /// INACTIVATE BZ TYPES ACCORDING TO SELECTION
    else {
      _inactiveBzTypes = BzModel.concludeInactiveBzTypesBySelectedType(
        selectedBzType: newSelectedType,
      );
    }

    return _inactiveBzTypes;
  }
// -----------------------------------------------------------------------------

  /// BZ TYPE MODIFIERS

// ------------------------------------------
  static List<BzType> addOrRemoveBzTypeToBzzTypes({
    @required BzType newSelectedBzType,
    @required List<BzType> selectedBzTypes,
}){

    final List<BzType> _outputTypes = <BzType>[...selectedBzTypes];

    final bool _alreadySelected = BzModel.checkBzTypesContainThisType(
      bzTypes: selectedBzTypes,
      bzType: newSelectedBzType,
    );

    if (_alreadySelected == true){
      _outputTypes.remove(newSelectedBzType);
    }

    else {
      _outputTypes.add(newSelectedBzType);
    }

    return _outputTypes;
  }
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
// -----------------------------------------------------------------------------

  /// BZ FORM TRANSLATION

// ------------------------------------------
  static String translateBzForm({
    @required BuildContext context,
    @required BzForm bzForm,
  }){

    if (bzForm == BzForm.company){
      return superPhrase(context, 'phid_company');
    }

    else if (bzForm == BzForm.individual){
      return superPhrase(context, 'phid_professional');
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

    if (Mapper.checkCanLoopList(bzForms) == true){

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
// -----------------------------------------------------------------------------

  /// BZ FORM CHECKERS

// ------------------------------------------
  static bool bzFormsContainThisForm({
    @required List<BzForm> bzForms,
    @required BzForm bzForm,
  }){
    bool _contains = false;

    if (Mapper.checkCanLoopList(bzForms) == true){

      if (bzForms.contains(bzForm) == true){
        _contains = true;
      }

    }

    return _contains;
  }
// -----------------------------------------------------------------------------

  /// BZ FORM CHECKERS

// ------------------------------------------
  static List<BzForm> concludeInactiveBzFormsByBzTypes(List<BzType> selectedBzTypes){

    /// INITIAL LIST OF ALL BZ FORMS
    List<BzForm> _bzForms = <BzForm>[...BzModel.bzFormsList];

    if (Mapper.checkCanLoopList(selectedBzTypes) == true){

      /// MORE THAN ONE BZ TYPE
      if (selectedBzTypes.length > 1){
        _bzForms.remove(BzForm.company);
      }

      /// IF ONLY ONE BZ TYPE
      else {

        /// BZ FORMS BY SECTION
        final List<BzForm> _bzFormsBySection = concludeBzFormsByBzType(selectedBzTypes[0]);

        /// REMOVE SELECTED BZ FORMS FROM THE LIST
        for (final BzForm bzForm in _bzFormsBySection){
          _bzForms.remove(bzForm);
        }

      }

    }

    /// IF NO BZ TYPES SELECTED
    else {
      _bzForms = null;
    }

    return _bzForms;
  }
// ------------------------------------------
  static List<BzForm> concludeBzFormsByBzType(BzType selectedBzType){

    List<BzForm> _bzForm = <BzForm>[];

    /// DEVELOPER
    if (selectedBzType == BzType.developer){
      _bzForm = <BzForm>[BzForm.company];
    }

    /// BROKER
    else if (selectedBzType == BzType.broker){
      _bzForm = <BzForm>[BzForm.company, BzForm.individual];
    }

    /// DESIGNER
    else if (selectedBzType == BzType.designer){
      _bzForm = <BzForm>[BzForm.company, BzForm.individual];
    }

    /// CONTRACTOR
    else if (selectedBzType == BzType.contractor){
      _bzForm = <BzForm>[BzForm.company, BzForm.individual];
    }

    /// CRAFTSMAN
    else if (selectedBzType == BzType.craftsman){
      _bzForm = <BzForm>[BzForm.individual];
    }

    /// SUPPLIER
    else if (selectedBzType == BzType.supplier){
      _bzForm = <BzForm>[BzForm.company];
    }

    /// MANUFACTURER
    else if (selectedBzType == BzType.manufacturer){
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

    if (Mapper.checkCanLoopList(bzSections) == true){

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
  static BzSection concludeBzSectionByBzTypes(List<BzType> selectedBzTypes){

    BzType _bzType;
    if (Mapper.checkCanLoopList(selectedBzTypes) == true){
      _bzType = selectedBzTypes[0];
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
      bzTypes: const <BzType>[BzType.designer],
      zone: ZoneModel.dummyZone(),
      totalFollowers: 1000,
      totalFlyers: 10,
      bzState: BzState.online,
      position: Atlas.dummyLocation(),
      flyersIDs: const <String>[],
      authors: <AuthorModel>[
        AuthorModel.dummyAuthor(),
      ],
      contacts: ContactModel.dummyContacts(),
      bzForm: BzForm.company,
      accountType: BzAccountType.normal,
      createdAt: Timers.createDate(year: 1987, month: 10, day: 06),
      about: 'About biz',
      isVerified: true,
      scope: const <String>['phid_k_designType_architecture'],
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
  void blogBz({String methodName = 'blogBzModel'}) {
    final String _methodName = methodName ?? 'BZ';

    blog('$_methodName : blogING BZ MODEL ---------------- START -- ');

    blog('id : $id');
    blog('bzTypes : $bzTypes');
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

    blog('$_methodName : blogING BZ MODEL ---------------- END -- ');
  }
// ------------------------------------------
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
// -----------------------------------------------------------------------------

  /// BZ GETTERS

// ------------------------------------------
  static BzModel getBzFromBzzByBzID({
    @required List<BzModel> bzz,
    @required String bzID,
  }) {

    final BzModel _bz =
    bzz.singleWhere((BzModel _b) => _b.id == bzID, orElse: () => null);
    return _bz;

  }
// ------------------------------------------
  static List<String> getBzzIDsFromBzz(List<BzModel> bzzModels) {
    final List<String> _ids = <String>[];

    if (Mapper.checkCanLoopList(bzzModels)) {
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

    if (Mapper.checkCanLoopList(bzz) && bzType != null){
      for (final BzModel bz in bzz){

        final List<BzType> _bzTypesOfThisBz = bz.bzTypes;
        final bool _containsThisType = BzModel.checkBzTypesContainThisType(
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

  /// BZ CHECKERS

// ------------------------------------------
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
// ------------------------------------------
  /// TESTED : WORKS GOOD ISA
  static bool checkBzzAreIdentical({
    @required BzModel bz1,
    @required BzModel bz2,
  }){
    bool _areIdentical = false;

    if (bz1 != null && bz2 != null){

      if (
          bz1.id == bz2.id &&
          Mapper.checkListsAreTheSame(list1: bz1.bzTypes, list2: bz2.bzTypes) &&
          bz1.bzForm == bz2.bzForm &&
          Timers.timesAreTheSame(accuracy: Timers.TimeAccuracy.microSecond, timeA: bz1.createdAt, timeB: bz2.createdAt) &&
          bz1.accountType == bz2.accountType &&
          bz1.name == bz2.name &&
          Mapper.checkListsAreTheSame(list1: bz1.trigram, list2: bz2.trigram) &&
          bz1.logo == bz2.logo &&
          Mapper.checkListsAreTheSame(list1: bz1.scope, list2: bz2.scope) &&
          ZoneModel.checkZonesAreTheSame(zone1: bz1.zone, zone2: bz1.zone) &&
          bz1.about == bz2.about &&
          bz1.position == bz2.position &&
          ContactModel.checkContactsListsAreIdentical(contacts1: bz1.contacts, contacts2: bz2.contacts) &&
          AuthorModel.checkAuthorsListsAreIdentical(authors1: bz1.authors, authors2: bz2.authors) &&
          bz1.showsTeam == bz2.showsTeam &&
          bz1.isVerified == bz2.isVerified &&
          bz1.bzState == bz2.bzState &&
          bz1.totalFollowers == bz2.totalFollowers &&
          bz1.totalSaves == bz2.totalSaves &&
          bz1.totalShares == bz2.totalShares &&
          bz1.totalSlides == bz2.totalSlides &&
          bz1.totalViews == bz2.totalViews &&
          bz1.totalCalls == bz2.totalCalls &&
          Mapper.checkListsAreTheSame(list1: bz1.flyersIDs, list2: bz2.flyersIDs) &&
          bz1.totalFlyers == bz2.totalFlyers
      ){
        _areIdentical = true;
      }

    }

    blogBzzDifferences(
      bz1: bz1,
      bz2: bz2,
    );

    return _areIdentical;
  }
// ------------------------------------------
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
        blog('id is not identical');
      }
      if (Mapper.checkListsAreTheSame(list1: bz1.bzTypes, list2: bz2.bzTypes) == false){
        blog('bzTypes is not identical');
      }
      if (bz1.bzForm != bz2.bzForm){
        blog('bzForm is not identical');
      }
      if (Timers.timesAreTheSame(accuracy: Timers.TimeAccuracy.microSecond, timeA: bz1.createdAt, timeB: bz2.createdAt) == false){
        blog('createdAt is not identical');
      }
      if (bz1.accountType != bz2.accountType){
        blog('accountType is not identical');
      }
      if (bz1.name != bz2.name){
        blog('name is not identical');
      }
      if (Mapper.checkListsAreTheSame(list1: bz1.trigram, list2: bz2.trigram) == false){
        blog('trigram is not identical');
      }
      if (bz1.logo != bz2.logo){
        blog('logo is not identical');
      }
      if (Mapper.checkListsAreTheSame(list1: bz1.scope, list2: bz2.scope) == false){
        blog('scope is not identical');
      }
      if (ZoneModel.checkZonesAreTheSame(zone1: bz1.zone, zone2: bz1.zone) == false){
        blog('zone is not identical');
      }
      if (bz1.about != bz2.about){
        blog('about is not identical');
      }
      if (bz1.position != bz2.position){
        blog('position is not identical');
      }
      if (ContactModel.checkContactsListsAreIdentical(contacts1: bz1.contacts, contacts2: bz2.contacts) == false){
        blog('contacts is not identical');
      }
      if (AuthorModel.checkAuthorsListsAreIdentical(authors1: bz1.authors, authors2: bz2.authors) == false){
        blog('authors is not identical');
      }
      if (bz1.showsTeam != bz2.showsTeam){
        blog('showsTeam is not identical');
      }
      if (bz1.isVerified != bz2.isVerified){
        blog('isVerified is not identical');
      }
      if (bz1.bzState != bz2.bzState){
        blog('bzState is not identical');
      }
      if (bz1.totalFollowers != bz2.totalFollowers){
        blog('totalFollowers is not identical');
      }
      if (bz1.totalSaves != bz2.totalSaves){
        blog('totalSaves is not identical');
      }
      if (bz1.totalShares != bz2.totalShares){
        blog('totalShares is not identical');
      }
      if (bz1.totalSlides != bz2.totalSlides){
        blog('totalSlides is not identical');
      }
      if (bz1.totalViews != bz2.totalViews){
        blog('totalViews is not identical');
      }
      if (bz1.totalCalls != bz2.totalCalls){
        blog('totalCalls is not identical');
      }
      if (Mapper.checkListsAreTheSame(list1: bz1.flyersIDs, list2: bz2.flyersIDs) == false){
        blog('flyersIDs is not identical');
      }
      if (bz1.totalFlyers != bz2.totalFlyers){
        blog('totalFlyers is not identical');
      }

    }


    blog('ending blogBzzDifferences checkup');

  }
// -----------------------------------------------------------------------------

  /// BZ TABS

// ------------------------------------------
  static int getBzTabIndex(BzTab bzTab){
    final int _index = bzTabsList.indexWhere((tab) => tab == bzTab);
    return _index;
  }
// ------------------------------------------
  static const List<BzTab> bzTabsList = <BzTab>[
    BzTab.flyers,
    BzTab.about,
    BzTab.authors,
    BzTab.notes,
    BzTab.targets,
    BzTab.powers,
    BzTab.network,
    BzTab.settings,
  ];
// // ------------------------------------------
//   /// CAUTION : THESE TITLES CAN NOT BE TRANSLATED DUE TO THEIR USE IN WIDGET KEYS
//   static const List<String> bzPagesTabsTitlesInEnglishOnly = <String>[
//     'Flyers',
//     'About',
//     'Authors',
//     'Notifications',
//     'Targets',
//     'Powers',
//     'Network',
//     'settings',
//   ];
// ------------------------------------------
  static String getBzTabID({
    @required BzTab bzTab,
  }){
    switch(bzTab){
      case BzTab.flyers   : return 'Flyers '  ; break;
      case BzTab.about    : return 'Info  '  ; break;
      case BzTab.authors  : return 'Team'  ; break;
      case BzTab.notes    : return 'Notification'  ; break;
      case BzTab.targets  : return 'Targets'  ; break;
      case BzTab.powers   : return 'Powers'  ; break;
      case BzTab.network  : return 'Network'  ; break;
      case BzTab.settings : return 'Settings' ; break;
      default : return null;
    }
  }
// ------------------------------------------
  static String translateBzTab({
    @required BzTab bzTab,
    @required BuildContext context,
  }){
    switch(bzTab){
      case BzTab.flyers   : return 'Flyers '  ; break;
      case BzTab.about    : return 'Info  '  ; break;
      case BzTab.authors  : return 'Team'  ; break;
      case BzTab.notes    : return 'Notification'  ; break;
      case BzTab.targets  : return 'Targets'  ; break;
      case BzTab.powers   : return 'Powers'  ; break;
      case BzTab.network  : return 'Network'  ; break;
      case BzTab.settings : return 'Settings' ; break;
      default : return null;
    }
  }
// ------------------------------------------
  static String getBzTabIcon(BzTab bzTab){
    switch(bzTab){
      case BzTab.flyers   : return Iconz.flyerGrid  ; break;
      case BzTab.about    : return Iconz.info       ; break;
      case BzTab.authors  : return Iconz.bz         ; break;
      case BzTab.notes    : return Iconz.news       ; break;
      case BzTab.targets  : return Iconz.target     ; break;
      case BzTab.powers   : return Iconz.power      ; break;
      case BzTab.network  : return Iconz.follow     ; break;
      case BzTab.settings : return Iconz.gears      ; break;
      default : return null;
    }
  }
// ------------------------------------------
  static String getTabTitle({
    @required int index,
    @required BuildContext context,
  }){
    final BzTab _bzTab = BzModel.bzTabsList[index];
    final String _tabTitle = BzModel.translateBzTab(
      context: context,
      bzTab: _bzTab,
    );
    return _tabTitle;
  }
// -----------------------------------------------------------------------------

  /// BZ VALIDATION

// ------------------------------------------
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

    if (stringIsEmpty(bzModel?.name) == true){
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

    if (stringIsEmpty(bzModel?.zone?.countryID) == true){
      _invalidFields.add(
          const AlertModel(
            alertID: 'bzCountry',
            titlePhraseID: 'a_0011_bzCountryMissing_title',
            messagePhraseID: 'a_0012_bzCountryMissing_message',
          )
      );
    }

    if (stringIsEmpty(bzModel?.zone?.cityID) == true){
      _invalidFields.add(
          const AlertModel(
            alertID: 'bzCity',
            titlePhraseID: 'a_0013_bzCityMissing_title',
            messagePhraseID: 'a_0014_bzCityMissing_message',
          )
      );
    }

    if (stringIsEmpty(bzModel?.about) == true){
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

  /// BZ MODIFIERS

// ------------------------------------------
  static BzModel removeAuthor({
    @required BzModel bzModel,
    @required String authorID,
  }){

    BzModel _output;

    blog('removeAuthor : remove ($authorID) from (${AuthorModel.getAuthorsIDsFromAuthors(authors: bzModel.authors)})');

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

    blog('removeAuthor : _output is (${AuthorModel.getAuthorsIDsFromAuthors(authors: _output.authors)})');

    return _output ?? bzModel;
  }
// -----------------------------------------------------------------------------
}
