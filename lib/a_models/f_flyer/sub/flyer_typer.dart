import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
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
/// => TAMAM
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
  static FlyerType? decipherFlyerType(String? x) {
    switch (x) {
      case 'general'    : return FlyerType.general;
      case 'property'   : return FlyerType.property;
      case 'design'     : return FlyerType.design;
      case 'undertaking': return FlyerType.undertaking;
      case 'trade'      : return FlyerType.trade;
      case 'product'    : return FlyerType.product;
      case 'equipment'  : return FlyerType.equipment;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherFlyerType(FlyerType? x) {
    switch (x) {
      case FlyerType.general      : return 'general';
      case FlyerType.property     : return 'property';
      case FlyerType.design       : return 'design';
      case FlyerType.undertaking  : return 'undertaking';
      case FlyerType.trade        : return 'trade';
      case FlyerType.product      : return 'product';
      case FlyerType.equipment    : return 'equipment';
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> cipherFlyersTypes(List<FlyerType> flyersTypes){
    final List<String> _strings = <String>[];

    if (Lister.checkCanLoop(flyersTypes) == true){

      for (final FlyerType type in flyersTypes){
        final String? _str = cipherFlyerType(type);
        if (_str != null){
          _strings.add(_str);
        }
      }

    }

    return _strings;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerType> decipherFlyersTypes(List<dynamic> strings){
    final List<FlyerType> _flyersTypes = <FlyerType>[];

    if (Lister.checkCanLoop(strings) == true){
      for (final String str in strings){
        final FlyerType? _type = decipherFlyerType(str);
        if (_type != null){
          _flyersTypes.add(_type);
        }
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
  static String? flyerTypeIcon({
    required FlyerType? flyerType,
    required bool isOn,
  }) {

    /// ON ICONS
    if (isOn == true){
      switch (flyerType) {
        case FlyerType.general      : return Iconz.flyer;
        case FlyerType.property     : return Iconz.bxPropertiesOn;
        case FlyerType.design       : return Iconz.bxDesignsOn;
        case FlyerType.undertaking  : return Iconz.bzUndertakingOn;
        case FlyerType.trade        : return Iconz.bxTradesOn;
        case FlyerType.product      : return Iconz.bxProductsOn;
        case FlyerType.equipment    : return Iconz.bxEquipmentOn;
        default: return null;
      }
    }

    /// OFF ICONS
    else {
      switch (flyerType) {
        case FlyerType.general      : return Iconz.flyer;
        case FlyerType.property     : return Iconz.bxPropertiesOff;
        case FlyerType.design       : return Iconz.bxDesignsOff;
        case FlyerType.undertaking  : return Iconz.bxUndertakingOff;
        case FlyerType.trade        : return Iconz.bxTradesOff;
        case FlyerType.product      : return Iconz.bxProductsOff;
        case FlyerType.equipment    : return Iconz.bxEquipmentOff;
        default: return null;
      }
    }

  }
  // -----------------------------------------------------------------------------

  /// BZ TYPE <--> FLYER TYPE : CONCLUDERS

  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static FlyerType concludeFlyerTypeByBzType(BzType bzType) {
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
    required BzType? bzType
  }) {
    switch (bzType) {
      case BzType.developer:    return <FlyerType>[FlyerType.property];
      case BzType.broker:       return <FlyerType>[FlyerType.property];
      case BzType.designer:     return <FlyerType>[FlyerType.design];
      case BzType.contractor:   return <FlyerType>[FlyerType.undertaking];
      case BzType.artisan:      return <FlyerType>[FlyerType.trade];
      /// product or equipment for author to choose while creating flyer
      case BzType.manufacturer: return <FlyerType>[FlyerType.product, FlyerType.equipment];
      /// product or equipment for author to choose while creating flyer
      case BzType.supplier:     return <FlyerType>[FlyerType.product, FlyerType.equipment];
      default: return [];
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FlyerType> concludePossibleFlyerTypesByBzTypes({
    required List<BzType>? bzTypes
  }){
    final List<FlyerType> _flyerTypes = <FlyerType>[];

    if (Lister.checkCanLoop(bzTypes) == true){

      for (final BzType bzType in bzTypes!){

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
    required BzModel? bzModel,
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
    required FlyerType flyerType,
    required List<FlyerType> flyerTypes,
  }){
    bool _includes = false;

    if (Lister.checkCanLoop(flyerTypes) == true){
      if (flyerTypes.contains(flyerType) == true){
        _includes = true;
      }
    }

    return _includes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFlyerTypesAreIdentical(List<FlyerType> types1, List<FlyerType> types2){

    final List<String> _a = cipherFlyersTypes(types1);
    final List<String> _b = cipherFlyersTypes(types2);

    return Lister.checkListsAreIdentical(list1: _a, list2: _b);
  }
  // -----------------------------------------------------------------------------

  /// TRANSLATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFlyerTypePhid({
    required FlyerType? flyerType,
    bool pluralTranslation = true,
  }){

    /// PLURAL
    if (pluralTranslation == true){

      switch (flyerType) {
        case FlyerType.general      : return 'phid_generalFlyers';
        case FlyerType.property     : return 'phid_properties'   ;
        case FlyerType.design       : return 'phid_designs'      ;
        case FlyerType.undertaking  : return 'phid_undertakings' ;
        case FlyerType.trade        : return 'phid_trades'       ;
        case FlyerType.product      : return 'phid_products'     ;
        case FlyerType.equipment    : return 'phid_equipments'   ;
        default: return null;
      }

    }

    /// SINGLE
    else {

      switch (flyerType) {
        case FlyerType.general      : return  'phid_generalFlyer'     ;
        case FlyerType.property     : return  'phid_propertyFlyer'    ;
        case FlyerType.design       : return  'phid_designFlyer'      ;
        case FlyerType.undertaking  : return  'phid_undertakingFlyer' ;
        case FlyerType.trade        : return  'phid_tradeFlyer'       ;
        case FlyerType.product      : return  'phid_productFlyer'     ;
        case FlyerType.equipment    : return  'phid_equipmentFlyer'   ;
        default: return null;
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> translateFlyerTypes({
    required BuildContext context,
    required List<FlyerType> flyerTypes,
    bool pluralTranslation = true,
  }){
    final List<String> _translations = <String>[];

    if (Lister.checkCanLoop(flyerTypes) == true){

      for (final FlyerType type in flyerTypes){

        final String? _phid = getFlyerTypePhid(
          flyerType: type,
          pluralTranslation: pluralTranslation,
        );

        final String? _translation = getWord(_phid);

        if (_translation != null){
          _translations.add(_translation);
        }

      }

    }

    return _translations;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static String translateFlyerTypeByBzType({
    required BuildContext context,
    required BzType bzType,
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
  static String? translateFlyerTypeDescription({
    required FlyerType? flyerType,
  }){

    switch (flyerType) {
      case FlyerType.general      : return 'phid_generalDescription';
      case FlyerType.property     : return 'phid_propertiesDescription';
      case FlyerType.design       : return 'phid_designsDescription';
      case FlyerType.undertaking  : return 'phid_projectsDescription';
      case FlyerType.trade        : return 'phid_tradesDescription';
      case FlyerType.product      : return 'phid_productsDescription';
      case FlyerType.equipment    : return 'phid_equipmentDescription';
      default: return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// CHAIN <--> FLYER TYPE : CONCLUDERS

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static FlyerType? concludeFlyerTypeByRootID({
    required String? rootID,
  }){
    switch (rootID) {
    /// REAL ESTATE
      case rootIdProperties:      return FlyerType.property;
    /// CONSTRUCTION
      case rootIdDesigns:         return FlyerType.design;
      case rootIDUndertakings:    return FlyerType.undertaking;
      case rootIdTrades:          return FlyerType.trade;
    /// SUPPLIES
      case rootIdProducts:        return FlyerType.product;
      case rootIdEquipment:       return FlyerType.equipment;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? concludeRootIDByFlyerType({
    required FlyerType? flyerType,
  }){
    String? _chainID;

    if (flyerType == null) {
      return null;
    }
    else {

      switch(flyerType){
        case FlyerType.general      : _chainID = null;                break;
        case FlyerType.property     : _chainID = rootIdProperties;    break;
        case FlyerType.design       : _chainID = rootIdDesigns;       break;
        case FlyerType.undertaking  : _chainID = rootIDUndertakings;  break;
        case FlyerType.trade        : _chainID = rootIdTrades;        break;
        case FlyerType.product      : _chainID = rootIdProducts;      break;
        case FlyerType.equipment    : _chainID = rootIdEquipment;     break;
      }
    }

    return _chainID;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? concludeSectionPhidByFlyerTypeRootID({
    required String? rootID,
  }){
    switch (rootID) {
      /// REAL ESTATE
      case rootIdProperties:    return 'phid_realEstate';
      /// CONSTRUCTION
      case rootIdDesigns:       return 'phid_construction';
      case rootIDUndertakings:  return 'phid_construction';
      case rootIdTrades:        return 'phid_construction';
      /// SUPPLIES
      case rootIdProducts:      return 'phid_supplies';
      case rootIdEquipment:     return 'phid_supplies';
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// ROOTS IDS

  // --------------------
  static const String rootIdProperties =    'phid_k_flyer_type_property';
  static const String rootIdDesigns =       'phid_k_flyer_type_design';
  static const String rootIDUndertakings =  'phid_k_flyer_type_undertaking';
  static const String rootIdTrades =        'phid_k_flyer_type_trades';
  static const String rootIdProducts =      'phid_k_flyer_type_product';
  static const String rootIdEquipment =     'phid_k_flyer_type_equipment';
  // --------------------
  static List<String> keywordsRootsIDs = <String>[
    rootIdProperties,
    rootIdDesigns,
    rootIDUndertakings,
    rootIdTrades,
    rootIdProducts,
    rootIdEquipment,
  ];

  // --------------------
  ///
  static String? getRootIcon(dynamic icon){
    String? _output;

    if (icon != null && icon is String){
      for (final String rootID in keywordsRootsIDs){

        final bool _has = TextCheck.stringContainsSubString(
            string: icon,
            subString: rootID
        );

        if (_has){
          final FlyerType _flyerType = concludeFlyerTypeByRootID(rootID: rootID)!;
          _output = flyerTypeIcon(flyerType: _flyerType, isOn: false);
          break;
        }

      }
    }



    return _output;
  }
  // -----------------------------------------------------------------------------

  /// ROOTS IDS COMPOSITIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getRootsIDsPerViewingEvent({
    required FlyerType? flyerType,
    required ViewingEvent? event,
  }){

    switch(event){

      case ViewingEvent.admin :
        return _allRootsIDs(flyerType: flyerType);

      case ViewingEvent.homeView :
        return _homeWallRootsIDs(flyerType);

      case ViewingEvent.flyerEditor :
        return _flyerCreatorRootsIDs(flyerType);

      case ViewingEvent.bzEditor :
        return bzCreatorRootsIDs(flyerType);

      default: return  [];
    }

  }
  // --------------------
  /// TASK : SEE ME
  static List<String> _allRootsIDs({
    required FlyerType? flyerType,
  }){

    // final List<PickerModel> _pickers = ChainsProvider.proGetPickersByFlyerType(
    //   context: getMainContext(),
    //   listen: false,
    //   flyerType: flyerType,
    //   sort: true,
    // );
    //
    // final List<String> _chainsIDs = PickerModel.getPickersChainsIDs(_pickers);
    //
    // Stringer.blogStrings(strings: _chainsIDs, invoker: 'chains IDs for : ($flyerType)');
    //
    // return _chainsIDs;

    return _homeWallRootsIDs(flyerType);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> _homeWallRootsIDs(FlyerType? flyerType){

    String? _keywordsRootID;

    switch (flyerType){
      // case FlyerType.general      : return <String>[]; break;
    // --------------------
      case FlyerType.property     : _keywordsRootID = rootIdProperties; break;
    // --------------------
      case FlyerType.design       : _keywordsRootID = rootIdDesigns; break;
    // --------------------
      case FlyerType.undertaking  : _keywordsRootID = rootIDUndertakings; break;
    // --------------------
      case FlyerType.trade        : _keywordsRootID = rootIdTrades; break;
    // --------------------
      case FlyerType.product      : _keywordsRootID = rootIdProducts; break;
    // --------------------
      case FlyerType.equipment    : _keywordsRootID = rootIdEquipment; break;
    // --------------------
      default: return [];
    }

    return [_keywordsRootID];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> _flyerCreatorRootsIDs(FlyerType? flyerType){

    switch (flyerType){
      case FlyerType.general      :
        return <String>[];
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
        ];
    // --------------------
      case FlyerType.design       :
        return <String>[
          'phid_k_flyer_type_design',
          'phid_s_group_space_type',
          'phid_s_style',
          'phid_s_propertyForm',
          'phid_s_propertyLicense',
        ];
    // --------------------
      case FlyerType.undertaking  :
        return <String>[
          'phid_s_propertyLicense',
          'phid_s_propertyForm',
          'phid_s_group_space_type',
          'phid_k_flyer_type_trades',
          'phid_k_flyer_type_product',
        ];
    // --------------------
      case FlyerType.trade        :
        return <String>[
          'phid_k_flyer_type_trades',
          // 'phid_s_constructionActivityMeasurementMethod',
        ];
    // --------------------
      case FlyerType.product      :
        return <String>[
          'phid_k_flyer_type_product',
          'phid_s_contractType',
          'phid_s_paymentMethod',
        ];
    // --------------------
      case FlyerType.equipment    :
        return <String>[
          'phid_k_flyer_type_equipment',
          'phid_s_contractType',
          'phid_s_paymentMethod',
        ];
    // --------------------
      default: return <String>[];
    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> bzCreatorRootsIDs(FlyerType? flyerType){

    switch (flyerType){
      case FlyerType.general      :
        return <String>[];
    // --------------------
      case FlyerType.property     :
        return <String>[
          'phid_k_flyer_type_property',
          'phid_s_propertyLicense',
        ];
    // --------------------
      case FlyerType.design       :
        return <String>[
          'phid_k_flyer_type_design',
          'phid_s_propertyLicense',
        ];
    // --------------------
      case FlyerType.undertaking  :
        return <String>[
          'phid_s_propertyLicense',
        ];
    // --------------------
      case FlyerType.trade        :
        return <String>[
          'phid_k_flyer_type_trades',
        ];
    // --------------------
      case FlyerType.product      :
        return <String>[
          'phid_k_flyer_type_product',
        ];
    // --------------------
      case FlyerType.equipment    :
        return <String>[
          'phid_k_flyer_type_equipment',
        ];
    // --------------------
      default: return <String>[];
    }


  }
  // --------------------
  /// NOT USED
  /*
  /// TESTED : WORKS PERFECT
  static List<String> getChainsIDsPerBzType({
    required BzType bzType,
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
