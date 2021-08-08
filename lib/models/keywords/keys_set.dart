import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keywordz.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/district_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeysSet{
  final String groupID;
  final bool canPickMany;
  final List<Keyword> keywords;

  KeysSet({
    @required this.groupID,
    @required this.canPickMany,
    @required this.keywords,
  });
// -----------------------------------------------------------------------------
  static List<KeysSet> getKeysSetBySection({Section section}){

    List<KeysSet> _filters =
        section == Section.NewProperties ? propertiesKeysSets :
        section == Section.ResaleProperties ? propertiesKeysSets :
        section == Section.RentalProperties ? propertiesKeysSets :

        section == Section.Designs ? designsKeysSets :
        section == Section.Projects ? projectsKeysSets :
        section == Section.Crafts ? craftsKeysSets :

        section == Section.Products ? productsKeysSets :
        section == Section.Equipment ? equipmentKeysSets :
        null;

        return _filters;
  }
// -----------------------------------------------------------------------------
  static List<KeysSet> getKeysSetsByFlyerType({FlyerType flyerType}){

    print('getKeysSetsByFlyerType : flyerType : $flyerType');

    switch (flyerType){
      case FlyerType.Property   :   return propertiesKeysSets;  break;

      case FlyerType.Design     :   return designsKeysSets;     break;
      case FlyerType.Project    :   return projectsKeysSets;    break;
      case FlyerType.Craft      :   return craftsKeysSets;      break;

      case FlyerType.Product    :   return productsKeysSets;    break;
      case FlyerType.Equipment  :   return equipmentKeysSets;   break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static KeysSet propertyFormsKeysSet = KeysSet(groupID: 'group_ppt_form', canPickMany: false, keywords: FilterKeys.propertyForms());
  static KeysSet propertyTypesKeysSet = KeysSet(groupID: 'group_ppt_type', canPickMany: false, keywords: FilterKeys.propertyTypes());
  static KeysSet propertyAreaKeysSet = KeysSet(groupID: 'group_ppt_area', canPickMany: false, keywords: FilterKeys.propertyArea());
  static KeysSet propertySpacesKeysSet = KeysSet(groupID: 'group_ppt_spaces', canPickMany: true, keywords: FilterKeys.spaceTypes());
  static KeysSet propertyFeaturesKeysSet = KeysSet(groupID: 'group_ppt_features', canPickMany: true, keywords: FilterKeys.propertyFeatures());
  static KeysSet propertyPricesKeysSet = KeysSet(groupID: 'group_ppt_price', canPickMany: true, keywords: FilterKeys.propertyPrices());
  static KeysSet propertyLicenseKeysSet = KeysSet(groupID: 'group_ppt_license', canPickMany: false, keywords: FilterKeys.propertyLicenses());
// -----------------------------------------------------------------------------
  static KeysSet designTypesKeysSet = KeysSet(groupID: 'group_dz_type', canPickMany: false, keywords: FilterKeys.designTypes());
  static KeysSet architecturalStylesKeysSet = KeysSet(groupID: 'group_dz_style', canPickMany: false, keywords: FilterKeys.architecturalStyles());
  static KeysSet spaceTypeKeysSet = KeysSet(groupID: 'group_space_type', canPickMany: true, keywords: FilterKeys.spaceTypes());
  static KeysSet kioskTypeKeysSet = KeysSet(groupID: 'group_dz_kioskType', canPickMany: false, keywords: FilterKeys.kioskTypes());
// -----------------------------------------------------------------------------
  static KeysSet constructionTradesKeysSet = KeysSet(groupID: 'group_craft_trade', canPickMany: true, keywords: FilterKeys.constructionTrades());
// -----------------------------------------------------------------------------
  static KeysSet productsKeysSet = KeysSet(groupID: 'product', canPickMany: true, keywords: FilterKeys.products());
  static KeysSet productPricesKeysSet = KeysSet(groupID: 'productPrices', canPickMany: true, keywords: FilterKeys.productPrices());
// -----------------------------------------------------------------------------
  static KeysSet getKeysSetFromCurrentDistricts(BuildContext context){

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _provinceID = _countryPro.currentCityID;
    List<District> _districts = _countryPro.getDistrictsByCityID(context, _provinceID);

    List<Keyword> _districtsAsKeywords = Keyword.getKeywordsModelsFromDistricts(_districts);

    KeysSet _keysSet = KeysSet(
        groupID: _districtsAsKeywords[0].groupID,
        canPickMany: false,
        keywords: _districtsAsKeywords
    );

    return _keysSet;
  }
// -----------------------------------------------------------------------------
  static KeysSet zoneDistrictsAsKeysSet (BuildContext context){
    KeysSet _zoneDistrictsKeysSet = getKeysSetFromCurrentDistricts(context);
    return _zoneDistrictsKeysSet;
  }
// -----------------------------------------------------------------------------
  static List<KeysSet> propertiesKeysSets = <KeysSet>[
    propertyFormsKeysSet,
    propertyTypesKeysSet,
    propertyAreaKeysSet,
    propertySpacesKeysSet,
    propertyFeaturesKeysSet,
    propertyPricesKeysSet,
    propertyLicenseKeysSet,
  ];
// -----------------------------------------------------------------------------
  static List<KeysSet> designsKeysSets = <KeysSet>[
    designTypesKeysSet,
    architecturalStylesKeysSet,
    spaceTypeKeysSet,
    propertyAreaKeysSet,
    productsKeysSet,
  ];
// -----------------------------------------------------------------------------
  static List<KeysSet> projectsKeysSets = <KeysSet>[
    constructionTradesKeysSet,
    designTypesKeysSet,
    spaceTypeKeysSet,
    propertyAreaKeysSet,
    productsKeysSet,
  ];
// -----------------------------------------------------------------------------
  static List<KeysSet> craftsKeysSets = <KeysSet>[
    constructionTradesKeysSet,
    spaceTypeKeysSet,
    productsKeysSet,
  ];
// -----------------------------------------------------------------------------
  static List<KeysSet> productsKeysSets = <KeysSet>[
    productsKeysSet,
    productPricesKeysSet,
  ];
// -----------------------------------------------------------------------------
  static List<KeysSet> equipmentKeysSets = <KeysSet>[
    productsKeysSet,
    productPricesKeysSet,
  ];
// -----------------------------------------------------------------------------
  static bool getCanKeysSetPickManyByKeyword(Keyword keywordModel){
    List<KeysSet> _allFilters = <KeysSet>[
      ...propertiesKeysSets,
      ...designsKeysSets,
      ...projectsKeysSets,
      ...craftsKeysSets,
      ...productsKeysSets,
    ];

    bool _canPickMany = _allFilters.firstWhere((filter) => filter.groupID == keywordModel.flyerType).canPickMany;

    return _canPickMany;
  }
// -----------------------------------------------------------------------------
}
