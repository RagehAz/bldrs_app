import 'package:bldrs/a_models/a_user/sub/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart' as fireDB;

class CensusModel {
  /// --------------------------------------------------------------------------
  CensusModel({
    @required this.totalUsers,
    @required this.totalBzz,
    @required this.totalAuthors,
    @required this.totalFlyers,
    @required this.totalSlides,
    @required this.bzSectionRealEstate,
    @required this.bzSectionConstruction,
    @required this.bzSectionSupplies,
    @required this.bzTypeDeveloper,
    @required this.bzTypeBroker,
    @required this.bzTypeDesigner,
    @required this.bzTypeContractor,
    @required this.bzTypeArtisan,
    @required this.bzTypeManufacturer,
    @required this.bzTypeSupplier,
    @required this.bzFormIndividual,
    @required this.bzFormCompany,
    @required this.bzAccountTypeStandard,
    @required this.bzAccountTypePro,
    @required this.bzAccountTypeMaster,
    @required this.flyerTypeProperty,
    @required this.flyerTypeDesign,
    @required this.flyerTypeProject,
    @required this.flyerTypeProduct,
    @required this.flyerTypeTrade,
    @required this.flyerTypeEquipment,
    @required this.needTypeSeekProperty,
    @required this.needTypePlanConstruction,
    @required this.needTypeFinishConstruction,
    @required this.needTypeFurnish,
    @required this.needTypeOfferProperty,
  });
  /// --------------------------------------------------------------------------
  final int totalUsers;
  final int totalBzz;
  final int totalAuthors;
  final int totalFlyers;
  final int totalSlides;
  final int bzSectionRealEstate;
  final int bzSectionConstruction;
  final int bzSectionSupplies;
  final int bzTypeDeveloper;
  final int bzTypeBroker;
  final int bzTypeDesigner;
  final int bzTypeContractor;
  final int bzTypeArtisan;
  final int bzTypeManufacturer;
  final int bzTypeSupplier;
  final int bzFormIndividual;
  final int bzFormCompany;
  final int bzAccountTypeStandard;
  final int bzAccountTypePro;
  final int bzAccountTypeMaster;
  final int flyerTypeProperty;
  final int flyerTypeDesign;
  final int flyerTypeProject;
  final int flyerTypeProduct;
  final int flyerTypeTrade;
  final int flyerTypeEquipment;
  final int needTypeSeekProperty;
  final int needTypePlanConstruction;
  final int needTypeFinishConstruction;
  final int needTypeFurnish;
  final int needTypeOfferProperty;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  CensusModel copyWith({
    int totalUsers,
    int totalBzz,
    int totalAuthors,
    int totalFlyers,
    int totalSlides,
    int bzSectionRealEstate,
    int bzSectionConstruction,
    int bzSectionSupplies,
    int bzTypeDeveloper,
    int bzTypeBroker,
    int bzTypeDesigner,
    int bzTypeContractor,
    int bzTypeArtisan,
    int bzTypeManufacturer,
    int bzTypeSupplier,
    int bzFormIndividual,
    int bzFormCompany,
    int bzAccountTypeStandard,
    int bzAccountTypePro,
    int bzAccountTypeMaster,
    int flyerTypeProperty,
    int flyerTypeDesign,
    int flyerTypeProject,
    int flyerTypeProduct,
    int flyerTypeTrade,
    int flyerTypeEquipment,
    int needTypeSeekProperty,
    int needTypePlanConstruction,
    int needTypeFinishConstruction,
    int needTypeFurnish,
    int needTypeOfferProperty,
  }){

    return CensusModel(
      totalUsers: totalUsers ?? this.totalUsers,
      totalBzz: totalBzz ?? this.totalBzz,
      totalAuthors: totalAuthors ?? this.totalAuthors,
      totalFlyers: totalFlyers ?? this.totalFlyers,
      totalSlides: totalSlides ?? this.totalSlides,
      bzSectionRealEstate: bzSectionRealEstate ?? this.bzSectionRealEstate,
      bzSectionConstruction: bzSectionConstruction ?? this.bzSectionConstruction,
      bzSectionSupplies: bzSectionSupplies ?? this.bzSectionSupplies,
      bzTypeDeveloper: bzTypeDeveloper ?? this.bzTypeDeveloper,
      bzTypeBroker: bzTypeBroker ?? this.bzTypeBroker,
      bzTypeDesigner: bzTypeDesigner ?? this.bzTypeDesigner,
      bzTypeContractor: bzTypeContractor ?? this.bzTypeContractor,
      bzTypeArtisan: bzTypeArtisan ?? this.bzTypeArtisan,
      bzTypeManufacturer: bzTypeManufacturer ?? this.bzTypeManufacturer,
      bzTypeSupplier: bzTypeSupplier ?? this.bzTypeSupplier,
      bzFormIndividual: bzFormIndividual ?? this.bzFormIndividual,
      bzFormCompany: bzFormCompany ?? this.bzFormCompany,
      bzAccountTypeStandard: bzAccountTypeStandard ?? this.bzAccountTypeStandard,
      bzAccountTypePro: bzAccountTypePro ?? this.bzAccountTypePro,
      bzAccountTypeMaster: bzAccountTypeMaster ?? this.bzAccountTypeMaster,
      flyerTypeProperty: flyerTypeProperty ?? this.flyerTypeProperty,
      flyerTypeDesign: flyerTypeDesign ?? this.flyerTypeDesign,
      flyerTypeProject: flyerTypeProject ?? this.flyerTypeProject,
      flyerTypeProduct: flyerTypeProduct ?? this.flyerTypeProduct,
      flyerTypeTrade: flyerTypeTrade ?? this.flyerTypeTrade,
      flyerTypeEquipment: flyerTypeEquipment ?? this.flyerTypeEquipment,
      needTypeSeekProperty: needTypeSeekProperty ?? this.needTypeSeekProperty,
      needTypePlanConstruction: needTypePlanConstruction ?? this.needTypePlanConstruction,
      needTypeFinishConstruction: needTypeFinishConstruction ?? this.needTypeFinishConstruction,
      needTypeFurnish: needTypeFurnish ?? this.needTypeFurnish,
      needTypeOfferProperty: needTypeOfferProperty ?? this.needTypeOfferProperty,
    );

  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'totalUsers': totalUsers,
      'totalBzz': totalBzz,
      'totalAuthors': totalAuthors,
      'totalFlyers': totalFlyers,
      'totalSlides': totalSlides,
      'bzSectionRealEstate': bzSectionRealEstate,
      'bzSectionConstruction': bzSectionConstruction,
      'bzSectionSupplies': bzSectionSupplies,
      'bzTypeDeveloper': bzTypeDeveloper,
      'bzTypeBroker': bzTypeBroker,
      'bzTypeDesigner': bzTypeDesigner,
      'bzTypeContractor': bzTypeContractor,
      'bzTypeArtisan': bzTypeArtisan,
      'bzTypeManufacturer': bzTypeManufacturer,
      'bzTypeSupplier': bzTypeSupplier,
      'bzFormIndividual': bzFormIndividual,
      'bzFormCompany': bzFormCompany,
      'bzAccountTypeStandard': bzAccountTypeStandard,
      'bzAccountTypePro': bzAccountTypePro,
      'bzAccountTypeMaster': bzAccountTypeMaster,
      'flyerTypeProperty': flyerTypeProperty,
      'flyerTypeDesign': flyerTypeDesign,
      'flyerTypeProject': flyerTypeProject,
      'flyerTypeProduct': flyerTypeProduct,
      'flyerTypeTrade': flyerTypeTrade,
      'flyerTypeEquipment': flyerTypeEquipment,
      'needTypeSeekProperty': needTypeSeekProperty,
      'needTypePlanConstruction': needTypePlanConstruction,
      'needTypeFinishConstruction': needTypeFinishConstruction,
      'needTypeFurnish': needTypeFurnish,
      'needTypeOfferProperty': needTypeOfferProperty,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CensusModel decipher(Map<String, dynamic> map){
    CensusModel _output;

    if (map != null){

      _output = CensusModel(
        totalUsers: map['totalUsers'],
        totalBzz: map['totalBzz'],
        totalAuthors: map['totalAuthors'],
        totalFlyers: map['totalFlyers'],
        totalSlides: map['totalSlides'],
        bzSectionRealEstate: map['bzSectionRealEstate'],
        bzSectionConstruction: map['bzSectionConstruction'],
        bzSectionSupplies: map['bzSectionSupplies'],
        bzTypeDeveloper: map['bzTypeDeveloper'],
        bzTypeBroker: map['bzTypeBroker'],
        bzTypeDesigner: map['bzTypeDesigner'],
        bzTypeContractor: map['bzTypeContractor'],
        bzTypeArtisan: map['bzTypeArtisan'],
        bzTypeManufacturer: map['bzTypeManufacturer'],
        bzTypeSupplier: map['bzTypeSupplier'],
        bzFormIndividual: map['bzFormIndividual'],
        bzFormCompany: map['bzFormCompany'],
        bzAccountTypeStandard: map['bzAccountTypeStandard'],
        bzAccountTypePro: map['bzAccountTypePro'],
        bzAccountTypeMaster: map['bzAccountTypeMaster'],
        flyerTypeProperty: map['flyerTypeProperty'],
        flyerTypeDesign: map['flyerTypeDesign'],
        flyerTypeProject: map['flyerTypeProject'],
        flyerTypeProduct: map['flyerTypeProduct'],
        flyerTypeTrade: map['flyerTypeTrade'],
        flyerTypeEquipment: map['flyerTypeEquipment'],
        needTypeSeekProperty: map['needTypeSeekProperty'],
        needTypePlanConstruction: map['needTypePlanConstruction'],
        needTypeFinishConstruction: map['needTypeFinishConstruction'],
        needTypeFurnish: map['needTypeFurnish'],
        needTypeOfferProperty: map['needTypeOfferProperty'],
      );

    }

    return _output;
  }
  // --------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> completeMapForIncrementation(Map<String, dynamic> input){
    Map<String, dynamic> _output;

    /// NOTE : THIS METHOD MAKES SURE THAT NO FIELD IN CENSUS MODEL IS NULL ON CENSUS PROTOCOLS

    if (input != null){

      _output = {};
      final Map<String, dynamic> _fullMap = createEmptyModel().toMap();
      final List<String> _allKeys = _fullMap.keys.toList();

      for (final String _key in _allKeys){

        /// WHEN KEY IS ABSENT
        if (input[_key] == null){
          _output = Mapper.insertPairInMap(
              map: _output,
              key: _key,
              value: fireDB.ServerValue.increment(0), /// ADD NO INCREMENTATION IN THIS FIELD
          );
        }

        /// KEY IS DEFINED
        else {
          _output = Mapper.insertPairInMap(
            map: _output,
            key: _key,
            value: input[_key], /// ADD THE FIELD THAT'S ALREADY DEFINED BY PREVIOUS METHODS
          );
        }


      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static CensusModel createEmptyModel(){
    return CensusModel(
      totalUsers: 0,
      totalBzz: 0,
      totalAuthors: 0,
      totalFlyers: 0,
      totalSlides: 0,
      bzSectionRealEstate: 0,
      bzSectionConstruction: 0,
      bzSectionSupplies: 0,
      bzTypeDeveloper: 0,
      bzTypeBroker: 0,
      bzTypeDesigner: 0,
      bzTypeContractor: 0,
      bzTypeArtisan: 0,
      bzTypeManufacturer: 0,
      bzTypeSupplier: 0,
      bzFormIndividual: 0,
      bzFormCompany: 0,
      bzAccountTypeStandard: 0,
      bzAccountTypePro: 0,
      bzAccountTypeMaster: 0,
      flyerTypeProperty: 0,
      flyerTypeDesign: 0,
      flyerTypeProject: 0,
      flyerTypeProduct: 0,
      flyerTypeTrade: 0,
      flyerTypeEquipment: 0,
      needTypeSeekProperty: 0,
      needTypePlanConstruction: 0,
      needTypeFinishConstruction: 0,
      needTypeFurnish: 0,
      needTypeOfferProperty: 0,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getNeedTypeFieldName(NeedType needType){
    switch (needType) {
      case NeedType.seekProperty :       return 'needTypeSeekProperty'; break;
      case NeedType.planConstruction :   return 'needTypePlanConstruction'; break;
      case NeedType.finishConstruction : return 'needTypeFinishConstruction'; break;
      case NeedType.furnish :            return 'needTypeFurnish'; break;
      case NeedType.offerProperty :      return 'needTypeOfferProperty'; break;
      default:return null;
      }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzSectionFieldName(BzSection bzSection){
    switch (bzSection) {
      case BzSection.realestate :   return 'bzSectionRealEstate';   break;
      case BzSection.construction : return 'bzSectionConstruction'; break;
      case BzSection.supplies :     return 'bzSectionSupplies';     break;
      default:                      return null;
      }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzTypeFieldName(BzType bzType){
    switch (bzType) {
      case BzType.developer :     return 'bzTypeDeveloper';     break;
      case BzType.broker :        return 'bzTypeBroker';        break;
      case BzType.designer :      return 'bzTypeDesigner';      break;
      case BzType.contractor :    return 'bzTypeContractor';    break;
      case BzType.artisan :       return 'bzTypeArtisan';       break;
      case BzType.manufacturer :  return 'bzTypeManufacturer';  break;
      case BzType.supplier :      return 'bzTypeSupplier';      break;
      default:                    return null;
      }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzFormFieldName(BzForm bzForm){
    switch (bzForm) {
      case BzForm.individual :  return 'bzFormIndividual';  break;
      case BzForm.company :     return 'bzFormCompany';     break;
      default:                  return null;
      }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzAccountTypeFieldName(BzAccountType bzAccountType){
    switch (bzAccountType) {
      case BzAccountType.standard :  return 'bzAccountTypeStandard';  break;
      case BzAccountType.pro :       return 'bzAccountTypePro';       break;
      case BzAccountType.master :    return 'bzAccountTypeMaster';    break;
      default:                       return null;
      }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getFlyerTypeFieldName(FlyerType flyerType){
    switch (flyerType) {
      case FlyerType.property   : return 'flyerTypeProperty';  break;
      case FlyerType.design     : return 'flyerTypeDesign';    break;
      case FlyerType.product    : return 'flyerTypeProduct';   break;
      case FlyerType.undertaking    : return 'flyerTypeProject';   break;
      case FlyerType.trade      : return 'flyerTypeTrade';     break;
      case FlyerType.equipment  : return 'flyerTypeEquipment'; break;
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///
  static bool checkShouldUpdateUserCensus({
    @required UserModel oldUser,
    @required UserModel newUser,
  }){
    bool _shouldUpdate = false;

    if (newUser != null){

      if (
        ZoneModel.checkZonesIDsAreIdentical(zone1: oldUser?.zone, zone2: newUser.zone) == false ||
        NeedModel.checkNeedsAreIdentical(oldUser?.need, newUser.need) == false
      ){
        _shouldUpdate = true;
      }


    }

    return _shouldUpdate;
  }
  // --------------------
  ///
  static bool checkShouldUpdateBzCensus({
    @required BzModel oldBz,
    @required BzModel newBz,
  }){
    bool _shouldUpdate = false;

    if (newBz != null){

      if (
      oldBz?.authors?.length != newBz.authors.length ||
      BzTyper.checkBzTypesAreIdentical(oldBz?.bzTypes, newBz.bzTypes) == false ||
      oldBz?.bzForm != newBz.bzForm ||
      oldBz?.accountType != newBz.accountType
      ){
        _shouldUpdate = true;
      }

    }

    return _shouldUpdate;
  }
  // --------------------
  ///
  static bool checkShouldUpdateFlyerCensus({
    @required FlyerModel oldFlyer,
    @required FlyerModel newFlyer,
  }){
    bool _shouldUpdate = false;

    if (newFlyer != null){

      if (
      oldFlyer?.slides?.length != newFlyer.slides.length ||
      oldFlyer?.flyerType != newFlyer.flyerType
      ){
        _shouldUpdate = true;
      }

    }

    return _shouldUpdate;
  }
  // -----------------------------------------------------------------------------

  /// CREATOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> createUserCensusMap({
    @required UserModel userModel,
    @required bool isIncrementing,
  }){

    final int _increment = isIncrementing ? 1 : -1;

    Map<String, dynamic> _map = {
      /// TOTAL USERS
      'totalUsers' : fireDB.ServerValue.increment(_increment),
    };

    if (userModel?.need?.needType != null){
      /// NEED TYPES
      _map = Mapper.insertPairInMap(
          map: _map,
          key: CensusModel.getNeedTypeFieldName(userModel?.need?.needType),
          value: fireDB.ServerValue.increment(_increment)
      );
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> createBzCensusMap({
    @required BzModel bzModel,
    @required bool isIncrementing,
  }){

    final int _increment = isIncrementing ? 1 : -1;

    Map<String, dynamic> _map = {
      /// TOTAL BZZ
      'totalBzz' : fireDB.ServerValue.increment(_increment),
      /// TOTAL AUTHORS
      'totalAuthors' : fireDB.ServerValue.increment(bzModel.authors.length * _increment),
    };

    /// SECTION
    _map = Mapper.insertPairInMap(
        map: _map,
        key: CensusModel.getBzSectionFieldName(BzTyper.concludeBzSectionByBzTypes(bzModel.bzTypes)),
        value: fireDB.ServerValue.increment(_increment)
    );

    /// TYPE
    for (final BzType bzType in bzModel.bzTypes){
      _map = Mapper.insertPairInMap(
          map: _map,
          key: CensusModel.getBzTypeFieldName(bzType),
          value: fireDB.ServerValue.increment(_increment)
      );
    }

    /// FORM
    _map = Mapper.insertPairInMap(
        map: _map,
        key: CensusModel.getBzFormFieldName(bzModel.bzForm),
        value: fireDB.ServerValue.increment(_increment)
    );

    /// ACCOUNT TYPE
    _map = Mapper.insertPairInMap(
        map: _map,
        key: CensusModel.getBzAccountTypeFieldName(bzModel.accountType),
        value: fireDB.ServerValue.increment(_increment)
    );

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> createFlyerCensusMap({
    @required FlyerModel flyerModel,
    @required bool isIncrementing,
  }){

    final int _increment = isIncrementing ? 1 : -1;

    final Map<String, dynamic> _map = {
      /// TOTAL FLYERS
      'totalFlyers' : fireDB.ServerValue.increment(_increment),
      /// TOTAL SLIDES
      'totalSlides' : fireDB.ServerValue.increment(flyerModel.slides.length * _increment),
    };

    /// FLYER TYPE
    return Mapper.insertPairInMap(
        map: _map,
        key: CensusModel.getFlyerTypeFieldName(flyerModel.flyerType),
        value: fireDB.ServerValue.increment(_increment)
    );

  }
  // -----------------------------------------------------------------------------
}
