import 'package:bldrs/models/keywords/keywordz.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/district_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

class KeysSet{
  final String titleID;
  final bool canPickMany;
  final List<Keyword> keywords;

  KeysSet({
    @required this.titleID,
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
  static KeysSet propertyFormsKeysSet = KeysSet(titleID: 'group_ppt_form', canPickMany: false, keywords: FilterKeys.propertyForms());
  static KeysSet propertyTypesKeysSet = KeysSet(titleID: 'propertyType', canPickMany: false, keywords: FilterKeys.propertyTypes());
  static KeysSet propertySpacesKeysSet = KeysSet(titleID: 'spaces', canPickMany: true, keywords: FilterKeys.spaceTypes());
  static KeysSet propertyFeaturesKeysSet = KeysSet(titleID: 'propertyFeatures', canPickMany: true, keywords: FilterKeys.propertyFeatures());
  static KeysSet propertyPricesKeysSet = KeysSet(titleID: 'propertyPrice', canPickMany: true, keywords: FilterKeys.propertyPrices());
  static KeysSet propertyAreaKeysSet = KeysSet(titleID: 'area', canPickMany: false, keywords: FilterKeys.propertyArea());
  static KeysSet propertyLicenseKeysSet = KeysSet(titleID: 'propertyLicense', canPickMany: false, keywords: FilterKeys.propertyLicenses());
// -----------------------------------------------------------------------------
  static KeysSet designTypesKeysSet = KeysSet(titleID: 'designType', canPickMany: false, keywords: FilterKeys.designTypes());
  static KeysSet architecturalStylesKeysSet = KeysSet(titleID: 'architecturalStyle', canPickMany: false, keywords: FilterKeys.architecturalStyles());
  static KeysSet spaceTypeKeysSet = KeysSet(titleID: 'spaceType', canPickMany: true, keywords: FilterKeys.spaceTypes());
  static KeysSet kioskTypeKeysSet = KeysSet(titleID: 'kioskType', canPickMany: false, keywords: FilterKeys.kioskTypes());
// -----------------------------------------------------------------------------
  static KeysSet constructionTradesKeysSet = KeysSet(titleID: 'constructionTrade', canPickMany: true, keywords: FilterKeys.constructionTrades());
// -----------------------------------------------------------------------------
  static KeysSet productsKeysSet = KeysSet(titleID: 'product', canPickMany: true, keywords: FilterKeys.products());
  static KeysSet productPricesKeysSet = KeysSet(titleID: 'productPrices', canPickMany: true, keywords: FilterKeys.productPrices());
// -----------------------------------------------------------------------------
  static KeysSet getKeysSetFromCurrentDistricts(BuildContext context){

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _provinceID = _countryPro.currentCityID;
    List<District> _districts = _countryPro.getDistrictsByCityID(context, _provinceID);

    List<Keyword> _districtsAsKeywords = Keyword.getKeywordsModelsFromDistricts(_districts);

    KeysSet _keysSet = KeysSet(
        titleID: _districtsAsKeywords[0].groupID,
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

    bool _canPickMany = _allFilters.firstWhere((filter) => filter.titleID == keywordModel.flyerType).canPickMany;

    return _canPickMany;
  }
// -----------------------------------------------------------------------------
}
