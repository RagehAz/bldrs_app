import 'package:bldrs/models/keywords/keywordz.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/district_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';

class FilterModel{
  final String groupID;
  final bool canPickMany;
  final List<KeywordModel> keywords;

  FilterModel({
    @required this.groupID,
    @required this.canPickMany,
    @required this.keywords,
  });
// -----------------------------------------------------------------------------
  static List<FilterModel> getFiltersBySection({Section section}){

    List<FilterModel> _filters =
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
  static FilterModel propertyFormsFilter = FilterModel(groupID: 'group_ppt_form', canPickMany: false, keywords: FilterKeys.propertyForms());
  static FilterModel propertyTypesFilter = FilterModel(groupID: 'propertyType', canPickMany: false, keywords: FilterKeys.propertyTypes());
  static FilterModel propertySpacesFilter = FilterModel(groupID: 'spaces', canPickMany: true, keywords: FilterKeys.spaceTypes());
  static FilterModel propertyFeaturesFilter = FilterModel(groupID: 'propertyFeatures', canPickMany: true, keywords: FilterKeys.propertyFeatures());
  static FilterModel propertyPricesFilter = FilterModel(groupID: 'propertyPrice', canPickMany: true, keywords: FilterKeys.propertyPrices());
  static FilterModel propertyAreaFilter = FilterModel(groupID: 'area', canPickMany: false, keywords: FilterKeys.propertyArea());
  static FilterModel propertyLicenseFilter = FilterModel(groupID: 'propertyLicense', canPickMany: false, keywords: FilterKeys.propertyLicenses());
// -----------------------------------------------------------------------------
  static FilterModel designTypesFilter = FilterModel(groupID: 'designType', canPickMany: false, keywords: FilterKeys.designTypes());
  static FilterModel architecturalStylesFilter = FilterModel(groupID: 'architecturalStyle', canPickMany: false, keywords: FilterKeys.architecturalStyles());
  static FilterModel spaceTypeFilter = FilterModel(groupID: 'spaceType', canPickMany: true, keywords: FilterKeys.spaceTypes());
  static FilterModel kioskTypeFilter = FilterModel(groupID: 'kioskType', canPickMany: false, keywords: FilterKeys.kioskTypes());
// -----------------------------------------------------------------------------
  static FilterModel constructionTradesFilter = FilterModel(groupID: 'constructionTrade', canPickMany: true, keywords: FilterKeys.constructionTrades());
// -----------------------------------------------------------------------------
  static FilterModel productsFilter = FilterModel(groupID: 'product', canPickMany: true, keywords: FilterKeys.products());
  static FilterModel productPricesFilter = FilterModel(groupID: 'productPrices', canPickMany: true, keywords: FilterKeys.productPrices());
// -----------------------------------------------------------------------------
  static FilterModel getFilterModelFromCurrentDistricts(BuildContext context){

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _provinceID = _countryPro.currentProvinceID;
    List<District> _districts = _countryPro.getDistrictsByProvinceID(context, _provinceID);

    List<KeywordModel> _districtsAsKeywords = KeywordModel.getKeywordsModelsFromDistricts(_districts);

    FilterModel _filterModel = FilterModel(
        groupID: _districtsAsKeywords[0].groupID,
        canPickMany: false,
        keywords: _districtsAsKeywords
    );

    return _filterModel;
  }
// -----------------------------------------------------------------------------
  static FilterModel zoneDistrictsAsFilter (BuildContext context){
    FilterModel _zoneDistrictsFilter = getFilterModelFromCurrentDistricts(context);
    return _zoneDistrictsFilter;
  }
// -----------------------------------------------------------------------------
  static List<FilterModel> propertiesFilters = <FilterModel>[
    propertyFormsFilter,
    propertyTypesFilter,
    propertyAreaFilter,
    propertySpacesFilter,
    propertyFeaturesFilter,
    propertyPricesFilter,
  ];
// -----------------------------------------------------------------------------
  static List<FilterModel> designsFilters = <FilterModel>[
    designTypesFilter,
    architecturalStylesFilter,
    spaceTypeFilter,
    propertyAreaFilter,
    productsFilter,
  ];
// -----------------------------------------------------------------------------
  static List<FilterModel> projectsFiltersIDs = <FilterModel>[
    constructionTradesFilter,
    designTypesFilter,
    spaceTypeFilter,
    propertyAreaFilter,
    productsFilter,
  ];
// -----------------------------------------------------------------------------
  static List<FilterModel> craftsFiltersIDs = <FilterModel>[
    constructionTradesFilter,
    spaceTypeFilter,
    productsFilter,
  ];
// -----------------------------------------------------------------------------
  static List<FilterModel> productsFiltersIDs = <FilterModel>[
    productsFilter,
    productPricesFilter,
  ];
// -----------------------------------------------------------------------------
  static List<FilterModel> equipmentFiltersIDs = <FilterModel>[
    productsFilter,
    productPricesFilter,
  ];
// -----------------------------------------------------------------------------
  static bool getCanFilterPickManyByKeyword(KeywordModel keywordModel){
    List<FilterModel> _allFilters = <FilterModel>[
      ...propertiesFilters,
      ...designsFilters,
      ...projectsFiltersIDs,
      ...craftsFiltersIDs,
      ...productsFiltersIDs,
    ];

    bool _canPickMany = _allFilters.firstWhere((filter) => filter.groupID == keywordModel.flyerType).canPickMany;

    return _canPickMany;
  }
// -----------------------------------------------------------------------------
}
