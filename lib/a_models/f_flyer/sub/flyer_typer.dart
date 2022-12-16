import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

enum FlyerType {
  general,
  property,
  design,
  undertaking,
  trade,
  product,
  equipment,
}

class FlyerTyper{
  // -----------------------------------------------------------------------------

  const FlyerTyper();

  // -----------------------------------------------------------------------------
  static const List<FlyerType> flyerTypesList = <FlyerType>[
    // FlyerType.general,
    FlyerType.property,
    FlyerType.design,
    FlyerType.undertaking,
    FlyerType.trade,
    FlyerType.product,
    FlyerType.equipment,
  ];
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerType decipherFlyerType(String x) {
    switch (x) {
      case 'general'    : return FlyerType.general;     break;
      case 'property'   : return FlyerType.property;    break;
      case 'design'     : return FlyerType.design;      break;
      case 'undertaking': return FlyerType.undertaking; break;
      case 'trade'      : return FlyerType.trade;       break;
      case 'product'    : return FlyerType.product;     break;
      case 'equipment'  : return FlyerType.equipment;   break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherFlyerType(FlyerType x) {
    switch (x) {
      case FlyerType.general      : return 'general';     break;
      case FlyerType.property     : return 'property';    break;
      case FlyerType.design       : return 'design';      break;
      case FlyerType.undertaking  : return 'undertaking'; break;
      case FlyerType.trade        : return 'trade';       break;
      case FlyerType.product      : return 'product';     break;
      case FlyerType.equipment    : return 'equipment';   break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> cipherFlyersTypes(List<FlyerType> flyersTypes){
    final List<String> _strings = <String>[];

    if (Mapper.checkCanLoopList(flyersTypes) == true){

      for (final FlyerType type in flyersTypes){
        _strings.add(cipherFlyerType(type));
      }

    }

    return _strings;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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

  // --------------------
  static const List<FlyerType> savedFlyersTabs = <FlyerType>[
    // FlyerType.general,
    FlyerType.property,
    FlyerType.design,
    FlyerType.undertaking,
    FlyerType.trade,
    FlyerType.product,
    FlyerType.equipment,
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getFlyerTypeIndexFromSectionsTabs(FlyerType flyerType){
    final int _index = savedFlyersTabs.indexWhere((type) => type == flyerType);
    return _index;
  }
  // -----------------------------------------------------------------------------

  /// ICONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String flyerTypeIcon({
    @required FlyerType flyerType,
    @required bool isOn,
  }) {

    /// ON ICONS
    if (isOn == true){
      switch (flyerType) {
        case FlyerType.general      : return Iconz.flyer;           break;
        case FlyerType.property     : return Iconz.bxPropertiesOn;  break;
        case FlyerType.design       : return Iconz.bxDesignsOn;     break;
        case FlyerType.undertaking  : return Iconz.bzUndertakingOn; break;
        case FlyerType.trade        : return Iconz.bxTradesOn;      break;
        case FlyerType.product      : return Iconz.bxProductsOn;    break;
        case FlyerType.equipment    : return Iconz.bxEquipmentOn;   break;
        default: return null;
      }
    }

    /// OFF ICONS
    else {
      switch (flyerType) {
        case FlyerType.general      : return Iconz.flyer;             break;
        case FlyerType.property     : return Iconz.bxPropertiesOff;   break;
        case FlyerType.design       : return Iconz.bxDesignsOff;      break;
        case FlyerType.undertaking  : return Iconz.bxUndertakingOff;  break;
        case FlyerType.trade        : return Iconz.bxTradesOff;       break;
        case FlyerType.product      : return Iconz.bxProductsOff;     break;
        case FlyerType.equipment    : return Iconz.bxEquipmentOff;    break;
        default: return null;
      }
    }

  }
  // -----------------------------------------------------------------------------

  /// BZ TYPE <--> FLYER TYPE : CONCLUDERS

  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static FlyerType XconcludeFlyerTypeByBzType(BzType bzType) {
    switch (bzType) {
      case BzType.developer:    return FlyerType.property;    break;
      case BzType.broker:       return FlyerType.property;    break;
      case BzType.designer:     return FlyerType.design;      break;
      case BzType.contractor:   return FlyerType.undertaking; break;
      case BzType.artisan:      return FlyerType.trade;       break;
      case BzType.manufacturer: return FlyerType.product;     break; // product or equipment for author to choose while creating flyer
      case BzType.supplier:     return FlyerType.product;     break; // product or equipment for author to choose while creating flyer
      default: return null;
    }
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerType> concludePossibleFlyerTypesByBzType({
    @required BzType bzType
  }) {
    switch (bzType) {
      case BzType.developer:    return <FlyerType>[FlyerType.property];                     break;
      case BzType.broker:       return <FlyerType>[FlyerType.property];                     break;
      case BzType.designer:     return <FlyerType>[FlyerType.design];                       break;
      case BzType.contractor:   return <FlyerType>[FlyerType.undertaking];                  break;
      case BzType.artisan:      return <FlyerType>[FlyerType.trade];                        break;
      /// product or equipment for author to choose while creating flyer
      case BzType.manufacturer: return <FlyerType>[FlyerType.product, FlyerType.equipment]; break;
      /// product or equipment for author to choose while creating flyer
      case BzType.supplier:     return <FlyerType>[FlyerType.product, FlyerType.equipment]; break;
      default: return null;
    }
  }
  // --------------------
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerType> concludeInactiveFlyerTypesByBzModel({
    @required BzModel bzModel,
  }){

    final List<FlyerType> _allowableTypes = concludePossibleFlyerTypesByBzTypes(
      bzTypes: bzModel?.bzTypes,
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

  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /// TASK : TEST ME
  static bool checkFlyerTypesAreIdentical(List<FlyerType> types1, List<FlyerType> types2){

    final List<String> _a = cipherFlyersTypes(types1);
    final List<String> _b = cipherFlyersTypes(types2);

    return Mapper.checkListsAreIdentical(list1: _a, list2: _b);
  }
  // -----------------------------------------------------------------------------

  /// TRANSLATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getFlyerTypePhid({
    @required FlyerType flyerType,
    bool pluralTranslation = true,
  }){

    /// PLURAL
    if (pluralTranslation == true){

      switch (flyerType) {
        case FlyerType.general      : return 'phid_generalFlyers'     ; break;
        case FlyerType.property     : return 'phid_properties'  ; break;
        case FlyerType.design       : return 'phid_designs'     ; break;
        case FlyerType.undertaking  : return 'phid_undertakings'; break;
        case FlyerType.trade        : return 'phid_trades'      ; break;
        case FlyerType.product      : return 'phid_products'    ; break;
        case FlyerType.equipment    : return 'phid_equipments'  ; break;
        default: return null;
      }

    }

    /// SINGLE
    else {

      switch (flyerType) {
        case FlyerType.general      : return  'phid_generalFlyer'     ; break;
        case FlyerType.property     : return  'phid_propertyFlyer'    ; break;
        case FlyerType.design       : return  'phid_designFlyer'      ; break;
        case FlyerType.undertaking  : return  'phid_undertakingFlyer' ; break;
        case FlyerType.trade        : return  'phid_tradeFlyer'       ; break;
        case FlyerType.product      : return  'phid_productFlyer'     ; break;
        case FlyerType.equipment    : return  'phid_equipmentFlyer'   ; break;
        default: return null;
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> translateFlyerTypes({
    @required BuildContext context,
    @required List<FlyerType> flyerTypes,
    bool pluralTranslation = true,
  }){
    final List<String> _translations = <String>[];

    if (Mapper.checkCanLoopList(flyerTypes) == true){

      for (final FlyerType type in flyerTypes){

        final String _phid = getFlyerTypePhid(
          flyerType: type,
          pluralTranslation: pluralTranslation,
        );

        final String _translation = xPhrase(context, _phid);

        _translations.add(_translation);

      }

    }

    return _translations;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static String XtranslateFlyerTypeByBzType({
    @required BuildContext context,
    @required BzType bzType,
    bool pluralTranslation = true,
  }){

    final FlyerType _concludedFlyerType = concludeFlyerTypeByBzType(bzType);

    final String _translation = getFlyerTypePhid(
      flyerType: _concludedFlyerType,
      pluralTranslation: pluralTranslation,
    );

    return _translation;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static String translateFlyerTypeDescription({
    @required BuildContext context,
    @required FlyerType flyerType,
  }){

    switch (flyerType) {
      case FlyerType.general      : return 'phid_generalDescription';     break;
      case FlyerType.property     : return 'phid_propertiesDescription';  break;
      case FlyerType.design       : return 'phid_designsDescription';     break;
      case FlyerType.undertaking  : return 'phid_projectsDescription';    break;
      case FlyerType.trade        : return 'phid_tradesDescription';      break;
      case FlyerType.product      : return 'phid_productsDescription';    break;
      case FlyerType.equipment    : return 'phid_equipmentDescription';   break;
      default: return null;
    }

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
      case propertyChainID:     return FlyerType.property;    break;
    /// CONSTRUCTION
      case designChainID:       return FlyerType.design;      break;
      case undertakingChainID:  return FlyerType.undertaking; break;
      case tradesChainID:       return FlyerType.trade;       break;
    /// SUPPLIES
      case productChainID:      return FlyerType.product;     break;
      case equipmentChainID:    return FlyerType.equipment;   break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String concludeChainIDByFlyerType({
    @required FlyerType flyerType,
  }){
    String _chainID;

    switch(flyerType){
      case FlyerType.general      : _chainID = null;              break;
      case FlyerType.property     : _chainID = propertyChainID;   break;
      case FlyerType.design       : _chainID = designChainID;     break;
      case FlyerType.undertaking  : _chainID = designChainID;     break;
      case FlyerType.trade        : _chainID = tradesChainID;     break;
      case FlyerType.product      : _chainID = productChainID;    break;
      case FlyerType.equipment    : _chainID = equipmentChainID;  break;
    }

    return _chainID;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String concludeSectionPhidByFlyerTypeChainID({
    @required BuildContext context,
    @required String flyerTypeChainID,
  }){
    switch (flyerTypeChainID) {
    /// REAL ESTATE
      case propertyChainID:  return 'phid_realEstate';   break;
    /// CONSTRUCTION
      case designChainID:    return 'phid_construction'; break;
      case tradesChainID:    return 'phid_construction'; break;
    /// SUPPLIES
      case productChainID:   return 'phid_supplies';     break;
      case equipmentChainID: return 'phid_supplies';     break;
      default: return null;
    }
  }
  // --------------------
  /// TASK : TEST ME
  static List<FlyerType> concludePossibleFlyerTypesByChains(List<Chain> chains){
    final List<FlyerType> _types = <FlyerType>[];

    if (Mapper.checkCanLoopList(chains) == true){

      Chain.blogChains(chains);

      for (final FlyerType flyerType in flyerTypesList){

        final String _chainID = concludeChainIDByFlyerType(
            flyerType: flyerType
        );

        final bool _includePhid = Chain.checkChainsIncludeThisPhid(
            chains: chains,
            phid: _chainID,
        );

        if (_includePhid == true){
          _types.add(flyerType);
        }


      }


    }


    return _types;
  }
  // -----------------------------------------------------------------------------

  /// CHAINS IDS

  // --------------------
  static const String propertyChainID =     'phid_k_flyer_type_property';
  static const String designChainID =       'phid_s_group_dz_type';
  static const String undertakingChainID =  'phid_s_propertyLicense';
  static const String tradesChainID =       'phid_k_flyer_type_trades';
  static const String productChainID =      'phid_k_flyer_type_product';
  static const String equipmentChainID =    'phid_k_flyer_type_equipment';
  // --------------------
  static List<String> chainKSonsIDs = <String>[
    propertyChainID,
    designChainID,
    undertakingChainID,
    tradesChainID,
    productChainID,
    equipmentChainID,
  ];
  // -----------------------------------------------------------------------------

  /// CHAINS IDS COMPOSITIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getChainsIDsPerViewingEvent({
    @required BuildContext context,
    @required FlyerType flyerType,
    @required ViewingEvent event,
  }){

    switch(event){

      case ViewingEvent.admin :
        return _allChainsIDs(context: context, flyerType: flyerType,);
        break;

      case ViewingEvent.homeView :
        return _homeWallChainsIDs(flyerType);
        break;

      case ViewingEvent.flyerEditor :
        return _flyerCreatorChainsIDs(flyerType,);
        break;

      case ViewingEvent.bzEditor :
        return _bzCreatorChainsIDs(flyerType,);
        break;

      default: return  null;
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> _allChainsIDs({
    @required BuildContext context,
    @required FlyerType flyerType,
  }){
    final List<PickerModel> _pickers = ChainsProvider.proGetPickersByFlyerType(
      context: context,
      flyerType: flyerType,
      listen: false,
      sort: true,
    );

    final List<String> _chainsIDs = PickerModel.getPickersChainsIDs(_pickers);

    Stringer.blogStrings(strings: _chainsIDs, invoker: 'chains IDs for : ($flyerType)');

    return _chainsIDs;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> _homeWallChainsIDs(FlyerType flyerType){

    List<String> _output = [];

    String _parentChainID;

    switch (flyerType){
      // case FlyerType.general      : return <String>[]; break;
    // --------------------
      case FlyerType.property     : _parentChainID = propertyChainID; break;
    // --------------------
      case FlyerType.design       : _parentChainID = designChainID; break;
    // --------------------
      case FlyerType.undertaking  : _parentChainID = undertakingChainID; break;
    // --------------------
      case FlyerType.trade        : _parentChainID = tradesChainID; break;
    // --------------------
      case FlyerType.product      : _parentChainID = productChainID; break;
    // --------------------
      case FlyerType.equipment    : _parentChainID = equipmentChainID; break;
    // --------------------
      default: return null;
    }

    if (_parentChainID != null){
      _output = [_parentChainID];
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> _flyerCreatorChainsIDs(FlyerType flyerType){

    switch (flyerType){
      case FlyerType.general      :
        return <String>[]; break;
    // --------------------
      case FlyerType.property     :
        return <String>[
          'phid_k_flyer_type_property',
          'phid_s_propertyForm',
          'phid_s_propertyLicense',
          'phid_s_contractType',
          'phid_s_paymentMethod',
          'phid_s_group_space_type',
          'phid_s_propertyView',
          'phid_s_sub_ppt_feat_indoor',
          'phid_s_sub_ppt_feat_finishing',
          'phid_s_propertyDecorationStyle',
          'phid_s_sub_ppt_feat_compound',
          'phid_s_sub_ppt_feat_amenities',
          'phid_s_sub_ppt_feat_services',
        ]; break;
    // --------------------
      case FlyerType.design       :
        return <String>[
          'phid_k_flyer_type_design',
          'phid_s_group_space_type',
          'phid_s_style',
          'phid_s_propertyForm',
          'phid_s_propertyLicense',
        ]; break;
    // --------------------
      case FlyerType.undertaking  :
        return <String>[
          'phid_s_propertyLicense',
          'phid_s_propertyForm',
          'phid_s_group_space_type',
          'phid_k_flyer_type_trades',
          'phid_k_flyer_type_product',
        ]; break;
    // --------------------
      case FlyerType.trade        :
        return <String>[
          'phid_k_flyer_type_trades',
          // 'phid_s_constructionActivityMeasurementMethod',
        ]; break;
    // --------------------
      case FlyerType.product      :
        return <String>[
          'phid_k_flyer_type_product',
          'phid_s_contractType',
          'phid_s_paymentMethod',
        ]; break;
    // --------------------
      case FlyerType.equipment    :
        return <String>[
          'phid_k_flyer_type_equipment',
          'phid_s_contractType',
          'phid_s_paymentMethod',
        ]; break;
    // --------------------
      default: return <String>[];
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> _bzCreatorChainsIDs(FlyerType flyerType){

    switch (flyerType){
      case FlyerType.general      :
        return <String>[]; break;
    // --------------------
      case FlyerType.property     :
        return <String>[
          'phid_k_flyer_type_property',
          'phid_s_propertyLicense',
        ]; break;
    // --------------------
      case FlyerType.design       :
        return <String>[
          'phid_k_flyer_type_design',
          'phid_s_propertyLicense',
        ]; break;
    // --------------------
      case FlyerType.undertaking  :
        return <String>[
          'phid_s_propertyLicense',
        ]; break;
    // --------------------
      case FlyerType.trade        :
        return <String>[
          'phid_k_flyer_type_trades',
        ]; break;
    // --------------------
      case FlyerType.product      :
        return <String>[
          'phid_k_flyer_type_product',
        ]; break;
    // --------------------
      case FlyerType.equipment    :
        return <String>[
          'phid_k_flyer_type_equipment',
        ]; break;
    // --------------------
      default: return <String>[];
    }


  }
  // --------------------
  /// NOT USED
  /*
  /// TESTED : WORKS PERFECT
  static List<String> getChainsIDsPerBzType({
    @required BzType bzType,
  }){

    switch (bzType){
    // --------------------
      case BzType.developer     :
        return <String>[
          'phid_k_flyer_type_property',
          'phid_s_propertyLicense',
        ]; break;
    // --------------------
      case BzType.broker     :
        return <String>[
          'phid_k_flyer_type_property',
          'phid_s_propertyLicense',
        ]; break;
    // --------------------
      case BzType.designer     :
        return <String>[
          'phid_k_flyer_type_design',
          'phid_s_propertyLicense',
        ]; break;
    // --------------------
      case BzType.contractor     :
        return <String>[
          'phid_s_propertyLicense',
        ]; break;
    // --------------------
      case BzType.artisan        :
        return <String>[
          'phid_k_flyer_type_trades',
        ]; break;
    // --------------------
      case BzType.supplier      :
        return <String>[
          'phid_k_flyer_type_product',
          'phid_k_flyer_type_equipment',
        ]; break;
    // --------------------
      case BzType.manufacturer      :
        return <String>[
          'phid_k_flyer_type_product',
          'phid_k_flyer_type_equipment',
        ]; break;
    // --------------------
      default: return <String>[];
    }


  }
   */
  // -----------------------------------------------------------------------------
}
