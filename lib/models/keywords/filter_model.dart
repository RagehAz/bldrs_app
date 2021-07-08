import 'package:bldrs/models/keywords/keywordz.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/district_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
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
        section == Section.NewProperties ? propertiesFilters :
        section == Section.ResaleProperties ? propertiesFilters :
        section == Section.RentalProperties ? propertiesFilters :

        section == Section.Designs ? designsFilters :
        section == Section.Projects ? projectsFiltersIDs :
        section == Section.Crafts ? craftsFiltersIDs :

        section == Section.Products ? productsFiltersIDs :
        section == Section.Equipment ? equipmentFiltersIDs :
        null;

        return _filters;
  }
// -----------------------------------------------------------------------------
  static KeysSet propertyFormsFilter = KeysSet(titleID: 'group_ppt_form', canPickMany: false, keywords: FilterKeys.propertyForms());
  static KeysSet propertyTypesFilter = KeysSet(titleID: 'propertyType', canPickMany: false, keywords: FilterKeys.propertyTypes());
  static KeysSet propertySpacesFilter = KeysSet(titleID: 'spaces', canPickMany: true, keywords: FilterKeys.spaceTypes());
  static KeysSet propertyFeaturesFilter = KeysSet(titleID: 'propertyFeatures', canPickMany: true, keywords: FilterKeys.propertyFeatures());
  static KeysSet propertyPricesFilter = KeysSet(titleID: 'propertyPrice', canPickMany: true, keywords: FilterKeys.propertyPrices());
  static KeysSet propertyAreaFilter = KeysSet(titleID: 'area', canPickMany: false, keywords: FilterKeys.propertyArea());
  static KeysSet propertyLicenseFilter = KeysSet(titleID: 'propertyLicense', canPickMany: false, keywords: FilterKeys.propertyLicenses());
// -----------------------------------------------------------------------------
  static KeysSet designTypesFilter = KeysSet(titleID: 'designType', canPickMany: false, keywords: FilterKeys.designTypes());
  static KeysSet architecturalStylesFilter = KeysSet(titleID: 'architecturalStyle', canPickMany: false, keywords: FilterKeys.architecturalStyles());
  static KeysSet spaceTypeFilter = KeysSet(titleID: 'spaceType', canPickMany: true, keywords: FilterKeys.spaceTypes());
  static KeysSet kioskTypeFilter = KeysSet(titleID: 'kioskType', canPickMany: false, keywords: FilterKeys.kioskTypes());
// -----------------------------------------------------------------------------
  static KeysSet constructionTradesFilter = KeysSet(titleID: 'constructionTrade', canPickMany: true, keywords: FilterKeys.constructionTrades());
// -----------------------------------------------------------------------------
  static KeysSet productsFilter = KeysSet(titleID: 'product', canPickMany: true, keywords: FilterKeys.products());
  static KeysSet productPricesFilter = KeysSet(titleID: 'productPrices', canPickMany: true, keywords: FilterKeys.productPrices());
// -----------------------------------------------------------------------------
  static KeysSet getFilterModelFromCurrentDistricts(BuildContext context){

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _provinceID = _countryPro.currentProvinceID;
    List<District> _districts = _countryPro.getDistrictsByProvinceID(context, _provinceID);

    List<Keyword> _districtsAsKeywords = Keyword.getKeywordsModelsFromDistricts(_districts);

    KeysSet _filterModel = KeysSet(
        titleID: _districtsAsKeywords[0].groupID,
        canPickMany: false,
        keywords: _districtsAsKeywords
    );

    return _filterModel;
  }
// -----------------------------------------------------------------------------
  static KeysSet zoneDistrictsAsFilter (BuildContext context){
    KeysSet _zoneDistrictsFilter = getFilterModelFromCurrentDistricts(context);
    return _zoneDistrictsFilter;
  }
// -----------------------------------------------------------------------------
  static List<KeysSet> propertiesFilters = <KeysSet>[
    propertyFormsFilter,
    propertyTypesFilter,
    propertyAreaFilter,
    propertySpacesFilter,
    propertyFeaturesFilter,
    propertyPricesFilter,
  ];
// -----------------------------------------------------------------------------
  static List<KeysSet> designsFilters = <KeysSet>[
    designTypesFilter,
    architecturalStylesFilter,
    spaceTypeFilter,
    propertyAreaFilter,
    productsFilter,
  ];
// -----------------------------------------------------------------------------
  static List<KeysSet> projectsFiltersIDs = <KeysSet>[
    constructionTradesFilter,
    designTypesFilter,
    spaceTypeFilter,
    propertyAreaFilter,
    productsFilter,
  ];
// -----------------------------------------------------------------------------
  static List<KeysSet> craftsFiltersIDs = <KeysSet>[
    constructionTradesFilter,
    spaceTypeFilter,
    productsFilter,
  ];
// -----------------------------------------------------------------------------
  static List<KeysSet> productsFiltersIDs = <KeysSet>[
    productsFilter,
    productPricesFilter,
  ];
// -----------------------------------------------------------------------------
  static List<KeysSet> equipmentFiltersIDs = <KeysSet>[
    productsFilter,
    productPricesFilter,
  ];
// -----------------------------------------------------------------------------
  static bool getCanFilterPickManyByKeyword(Keyword keywordModel){
    List<KeysSet> _allFilters = <KeysSet>[
      ...propertiesFilters,
      ...designsFilters,
      ...projectsFiltersIDs,
      ...craftsFiltersIDs,
      ...productsFiltersIDs,
    ];

    bool _canPickMany = _allFilters.firstWhere((filter) => filter.titleID == keywordModel.flyerType).canPickMany;

    return _canPickMany;
  }
// -----------------------------------------------------------------------------
}
