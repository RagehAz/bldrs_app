import 'package:bldrs/a_models/a_user/need_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart' as fireDB;

class CensusModel {
  /// --------------------------------------------------------------------------
  CensusModel({
    @required this.totalUsers,
    @required this.totalBzz,
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
  ///
  CensusModel copyWith({
    int totalUsers,
    int totalBzz,
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
  ///
  Map<String, dynamic> toMap(){
    return {
      'totalUsers': totalUsers,
      'totalBzz': totalBzz,
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
  ///
  static CensusModel decipher(Map<String, dynamic> map){
    CensusModel _output;

    if (map != null){

      _output = CensusModel(
        totalUsers: map['totalUsers'],
        totalBzz: map['totalBzz'],
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
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
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
  // -----------------------------------------------------------------------------

  /// CREATOR

  // --------------------
  ///
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

  // -----------------------------------------------------------------------------
  void f(){}
}
