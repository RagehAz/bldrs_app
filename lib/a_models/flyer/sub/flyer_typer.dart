import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
enum FlyerType {
  all,
  property,
  design,
  project,
  trade,
  product,
  equipment,
  non,
}

class FlyerTyper{
// -----------------------------------------------------------------------------

  const FlyerTyper();

// -----------------------------------------------------------------------------
  static const List<FlyerType> flyerTypesList = <FlyerType>[
    FlyerType.property,
    FlyerType.design, /// TASK : SHOULD COMBINE DESIGN WITH PROJECT
    FlyerType.project,
    FlyerType.product,
    FlyerType.trade,
    FlyerType.equipment,
  ];
// -----------------------------------------------------------------------------

  /// CYPHERS

// -------------------------------------
  static FlyerType decipherFlyerType(String x) {
    switch (x) {
      case 'all'      : return FlyerType.all;       break; // 1
      case 'property' : return FlyerType.property;  break; // 1
      case 'design'   : return FlyerType.design;    break; // 2
      case 'product'  : return FlyerType.product;   break; // 3
      case 'project'  : return FlyerType.project;   break; // 4
      case 'trade'    : return FlyerType.trade;     break; // 5
      case 'equipment': return FlyerType.equipment; break; // 6
      default: return null;
    }
  }
// -------------------------------------
  static String cipherFlyerType(FlyerType x) {
    switch (x) {
      case FlyerType.all        : return 'all';       break;
      case FlyerType.property   : return 'property';  break;
      case FlyerType.design     : return 'design';    break;
      case FlyerType.product    : return 'product';   break;
      case FlyerType.project    : return 'project';   break;
      case FlyerType.trade      : return 'trade';     break;
      case FlyerType.equipment  : return 'equipment'; break;
      default: return null;
    }
  }
// -------------------------------------
  static List<String> cipherFlyersTypes(List<FlyerType> flyersTypes){

    final List<String> _strings = <String>[];

    if (Mapper.checkCanLoopList(flyersTypes) == true){

      for (final FlyerType type in flyersTypes){
        _strings.add(cipherFlyerType(type));
      }

    }
    return _strings;
  }
// -------------------------------------
  static List<FlyerType> decipherFlyersTypes(List<dynamic> strings){

    final List<FlyerType> _flyersTypes = <FlyerType>[];

    if (Mapper.checkCanLoopList(strings) == true){
      for (final String str in strings){
        _flyersTypes.add(decipherFlyerType(str));
      }
    }

    return _flyersTypes;
  }
// -----------------------------------------------------------------------------

  /// TABS

// -------------------------------------
  static const List<FlyerType> savedFlyersTabs = <FlyerType>[
    FlyerType.all,
    FlyerType.property,
    FlyerType.design,
    FlyerType.product,
    FlyerType.project,
    FlyerType.trade,
    FlyerType.equipment,
  ];
// -------------------------------------
  static int getFlyerTypeIndexFromSectionsTabs(FlyerType flyerType){
    final int _index = savedFlyersTabs.indexWhere((type) => type == flyerType);
    return _index;
  }
// -----------------------------------------------------------------------------

  /// ICONS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String flyerTypeIconOn(FlyerType flyerType) {

    final String icon =
    flyerType == FlyerType.property ? Iconz.bxPropertiesOn
        :
    flyerType == FlyerType.design ? Iconz.bxDesignsOn
        :
    flyerType == FlyerType.project ? Iconz.bxProjectsOn
        :
    flyerType == FlyerType.trade ? Iconz.bxTradesOn
        :
    flyerType == FlyerType.product ? Iconz.bxProductsOn
        :
    flyerType == FlyerType.equipment ? Iconz.bxEquipmentOn
        :
    null;

    return icon;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String flyerTypeIconOff(FlyerType flyerType) {

    final String _icon =
    flyerType == FlyerType.property ? Iconz.bxPropertiesOff
        :
    flyerType == FlyerType.design ? Iconz.bxDesignsOff
        :
    flyerType == FlyerType.project ? Iconz.bxProjectsOff
        :
    flyerType == FlyerType.trade ? Iconz.bxTradesOff
        :
    flyerType == FlyerType.product ? Iconz.bxProductsOff
        :
    flyerType == FlyerType.equipment ? Iconz.bxEquipmentOff
        :
    null;

    return _icon;
  }
// -------------------------------------
  /*
String getSectionIcon({
  @required FlyerType section,
  @required bool inActiveMode
}){

  String _icon;

  if (inActiveMode == true) {
    _icon = FlyerTyper.flyerTypeIconOff(section);
  } else {
    _icon = FlyerTyper.flyerTypeIconOn(section);
  }

  return _icon;
}
 */
// -----------------------------------------------------------------------------

  /// BZ TYPE <--> FLYER TYPE : CONCLUDERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static FlyerType concludeFlyerTypeByBzType(BzType bzType) {
    switch (bzType) {
      case BzType.developer: return FlyerType.property; break;
      case BzType.broker: return FlyerType.property; break;
      case BzType.designer: return FlyerType.design; break;
      case BzType.contractor: return FlyerType.project; break;
      case BzType.artisan: return FlyerType.trade; break;
      case BzType.manufacturer: return FlyerType.product; break; // product or equipment for author to choose while creating flyer
      case BzType.supplier: return FlyerType.product; break; // product or equipment for author to choose while creating flyer
      default: return null;
    }
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerType> concludePossibleFlyerTypesByBzType({
    @required BzType bzType
  }) {
    switch (bzType) {
      case BzType.developer: return <FlyerType>[FlyerType.property]; break;
      case BzType.broker: return <FlyerType>[FlyerType.property]; break;
      case BzType.designer: return <FlyerType>[FlyerType.design]; break;
      case BzType.contractor: return <FlyerType>[FlyerType.project]; break;
      case BzType.artisan: return <FlyerType>[FlyerType.trade]; break;
      case BzType.manufacturer: return <FlyerType>[FlyerType.product, FlyerType.equipment]; break; // product or equipment for author to choose while creating flyer
      case BzType.supplier: return <FlyerType>[FlyerType.product, FlyerType.equipment]; break; // product or equipment for author to choose while creating flyer
      default: return null;
    }
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerType> concludePossibleFlyerTypesByBzTypes({
    @required List<BzType> bzTypes
  }){
    final List<FlyerType> _flyerTypes = <FlyerType>[];

    if (Mapper.checkCanLoopList(bzTypes) == true){

      for (final BzType bzType in bzTypes){

        final List<FlyerType> _types = concludePossibleFlyerTypesByBzType(
          bzType: bzType,
        );

        for (final FlyerType type in _types){
          if (_flyerTypes.contains(type) == false){
            _flyerTypes.add(type);
          }
        }

      }

    }

    return _flyerTypes;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerType> concludeInactiveFlyerTypesByBzModel({
    @required BzModel bzModel,
  }){

    final List<FlyerType> _allowableTypes = concludePossibleFlyerTypesByBzTypes(
      bzTypes: bzModel.bzTypes,
    );

    final List<FlyerType> _output = <FlyerType>[];

    for (final FlyerType flyerType in flyerTypesList){
      if (_allowableTypes.contains(flyerType) == false){
        _output.add(flyerType);
      }
    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  static bool checkFlyerTypesIncludeThisType({
    @required FlyerType flyerType,
    @required List<FlyerType> flyerTypes,
  }){
    bool _includes = false;

    if (Mapper.checkCanLoopList(flyerTypes) == true){
      if (flyerTypes.contains(flyerType) == true){
        _includes = true;
      }
    }

    return _includes;
  }
// -----------------------------------------------------------------------------

  /// TRANSLATION

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String translateFlyerType({
    @required BuildContext context,
    @required FlyerType flyerType,
    bool pluralTranslation = true,
  }){

    /// PLURAL
    if (pluralTranslation == true){
      return
        flyerType == FlyerType.all         ? xPhrase(context, 'phid_all_flyer_types') :
        flyerType == FlyerType.property    ? xPhrase(context, 'phid_properties')    :
        flyerType == FlyerType.design      ? xPhrase(context, 'phid_designs')    :
        flyerType == FlyerType.product     ? xPhrase(context, 'phid_products')    :
        flyerType == FlyerType.project     ? xPhrase(context, 'phid_projects')    :
        flyerType == FlyerType.equipment   ? xPhrase(context, 'phid_equipments')    :
        flyerType == FlyerType.trade       ? xPhrase(context, 'phid_trades')    :
        xPhrase(context, 'phid_general');
    }

    /// SINGLE
    else {
      return
        flyerType == FlyerType.all              ? xPhrase(context, 'phid_all_flyer_types') :
        flyerType == FlyerType.property         ? xPhrase(context, 'phid_propertyFlyer')    :
        flyerType == FlyerType.design           ? xPhrase(context, 'phid_designFlyer')    :
        flyerType == FlyerType.product          ? xPhrase(context, 'phid_productFlyer')    :
        flyerType == FlyerType.project          ? xPhrase(context, 'phid_projectFlyer')    :
        flyerType == FlyerType.equipment        ? xPhrase(context, 'phid_equipmentFlyer')    :
        flyerType == FlyerType.trade            ? xPhrase(context, 'phid_tradeFlyer')    :
        xPhrase(context, 'phid_general');
    }

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> translateFlyerTypes({
    @required BuildContext context,
    @required List<FlyerType> flyerTypes,
    bool pluralTranslation = true,
  }){
    final List<String> _strings = <String>[];

    if (Mapper.checkCanLoopList(flyerTypes) == true){

      for (final FlyerType type in flyerTypes){

        final String _translation = translateFlyerType(
          context: context,
          flyerType: type,
          pluralTranslation: pluralTranslation,
        );

        _strings.add(_translation);

      }

    }

    return _strings;
  }
// -------------------------------------
  static String translateFlyerTypeByBzType({
    @required BuildContext context,
    @required BzType bzType,
    bool pluralTranslation = true,
  }){

    final FlyerType _concludedFlyerType = concludeFlyerTypeByBzType(bzType);

    final String _translation = translateFlyerType(
      context: context,
      flyerType: _concludedFlyerType,
      pluralTranslation: pluralTranslation,
    );

    return _translation;
  }
// -------------------------------------
  static String translateFlyerTypeDescription({
    @required BuildContext context,
    @required FlyerType flyerType,
  }){

    final String _description =
    flyerType == FlyerType.property ? 'By RealEstate Developers & Brokers.' : //Wordz.realEstateTagLine(context) :
    flyerType == FlyerType.design ? 'By Architects & Designers' : //Wordz.constructionTagLine(context) :
    flyerType == FlyerType.project ? 'By Contractors' : //Wordz.constructionTagLine(context) :
    flyerType == FlyerType.trade ? 'By Artisans, Craftsmen & Technicians.' : //Wordz.constructionTagLine(context) :
    flyerType == FlyerType.product ? 'By Manufacturers & Suppliers.' : //Wordz.suppliesTagLine(context) :
    flyerType == FlyerType.equipment ? 'By Manufacturers & Suppliers.' : //Wordz.constructionTagLine(context) :

    Words.bldrsShortName(context);

    return _description;
  }

// -----------------------------------------------------------------------------

  /// CHAIN <--> FLYER TYPE : CONCLUDERS

// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static FlyerType concludeFlyerTypeByChainID({
    @required String chainID,
  }){
    switch (chainID) {
    /// REAL ESTATE
      case Chain.propertyChainID:  return FlyerType.property; break;
    /// CONSTRUCTION
      case Chain.designChainID:    return FlyerType.design; break;
      case Chain.tradesChainID:    return FlyerType.trade; break;
    /// SUPPLIES
      case Chain.productChainID:   return FlyerType.product; break;
      case Chain.equipmentChainID: return FlyerType.equipment; break;
      default: return null;
    }
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String concludeChainIDByFlyerType({
    @required FlyerType flyerType,
  }){

    String _chainID = 'phid_sections'; /// TASK : REVISE THIS

    switch(flyerType){
      case FlyerType.property   : _chainID = Chain.propertyChainID;   break;
      case FlyerType.design     : _chainID = Chain.designChainID;     break;
      case FlyerType.project    : _chainID = Chain.designChainID;     break;
      case FlyerType.trade      : _chainID = Chain.tradesChainID;     break;
      case FlyerType.product    : _chainID = Chain.productChainID;    break;
      case FlyerType.equipment  : _chainID = Chain.equipmentChainID;  break;
      case FlyerType.all        : _chainID = 'phid_sections';   break; /// TASK : REVISE THIS
      case FlyerType.non        : _chainID = 'phid_sections';   break; /// TASK : REVISE THIS
    }

    return _chainID;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String getGroupIDByChainKSonID({
    @required BuildContext context,
    @required String chainKSonID,
  }){
    switch (chainKSonID) {
    /// REAL ESTATE
      case Chain.propertyChainID:  return 'phid_realEstate';   break;
    /// CONSTRUCTION
      case Chain.designChainID:    return 'phid_construction'; break;
      case Chain.tradesChainID:    return 'phid_construction'; break;
    /// SUPPLIES
      case Chain.productChainID:   return 'phid_supplies';     break;
      case Chain.equipmentChainID: return 'phid_supplies';     break;
      default: return null;
    }
  }
// -------------------------------------
}
