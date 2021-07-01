import 'package:bldrs/controllers/theme/keywordz.dart';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FilterModel{
  final String filterID;
  final bool canPickMany;
  final List<KeywordModel> keywordModels;

  FilterModel({
    @required this.filterID,
    @required this.canPickMany,
    @required this.keywordModels,
  });
// -----------------------------------------------------------------------------
  static List<FilterModel> getFiltersBySectionAndFlyerType({BldrsSection bldrsSection, FlyerType flyerType}){

    List<FilterModel> _filters =
        bldrsSection == BldrsSection.RealEstate ? propertiesFilters :
        bldrsSection == BldrsSection.Construction && flyerType == FlyerType.Design ? designsFilters :
        bldrsSection == BldrsSection.Construction && flyerType == FlyerType.Project ? projectsFiltersIDs :
        bldrsSection == BldrsSection.Construction && flyerType == FlyerType.Craft ? craftsFiltersIDs :
        bldrsSection == BldrsSection.Supplies ? productsFiltersIDs : null;

        return _filters;
  }
// -----------------------------------------------------------------------------
  static FlyerType getDefaultFlyerTypeBySection({BldrsSection bldrsSection}){

    FlyerType _defaultFlyerType =
    bldrsSection == BldrsSection.RealEstate ? FlyerType.Property :
    bldrsSection == BldrsSection.Construction ? FlyerType.Design :
    bldrsSection == BldrsSection.Supplies ? FlyerType.Product : null;

    return _defaultFlyerType;
  }
// -----------------------------------------------------------------------------
  static FilterModel propertyFormsFilter = FilterModel(filterID: 'propertyForm', canPickMany: false, keywordModels: Keywordz.propertyForms);
  static FilterModel propertyTypesFilter = FilterModel(filterID: 'propertyType', canPickMany: false, keywordModels: Keywordz.propertyTypes);
  static FilterModel propertySpacesFilter = FilterModel(filterID: 'spaces', canPickMany: true, keywordModels: Keywordz.spaces);
  static FilterModel propertyFeaturesFilter = FilterModel(filterID: 'propertyFeatures', canPickMany: true, keywordModels: Keywordz.propertyFeatures);
  static FilterModel propertyPricesFilter = FilterModel(filterID: 'propertyPrice', canPickMany: true, keywordModels: Keywordz.propertyPrices);
  static FilterModel propertyAreaFilter = FilterModel(filterID: 'area', canPickMany: false, keywordModels: Keywordz.propertyAreas);
  static FilterModel propertyLicenseFilter = FilterModel(filterID: 'propertyLicense', canPickMany: false, keywordModels: Keywordz.propertyLicenses);
// -----------------------------------------------------------------------------
  static FilterModel designTypesFilter = FilterModel(filterID: 'designType', canPickMany: false, keywordModels: Keywordz.designTypes);
  static FilterModel architecturalStylesFilter = FilterModel(filterID: 'architecturalStyle', canPickMany: false, keywordModels: Keywordz.architecturalStyles);
  static FilterModel spaceTypeFilter = FilterModel(filterID: 'spaceType', canPickMany: true, keywordModels: Keywordz.spaceTypes);
  static FilterModel kioskTypeFilter = FilterModel(filterID: 'kioskType', canPickMany: false, keywordModels: Keywordz.kioskTypes);
// -----------------------------------------------------------------------------
  static FilterModel constructionTradesFilter = FilterModel(filterID: 'constructionTrade', canPickMany: true, keywordModels: Keywordz.constructionTrades);
// -----------------------------------------------------------------------------
  static FilterModel productsFilter = FilterModel(filterID: 'product', canPickMany: true, keywordModels: Keywordz.products);
  static FilterModel productPricesFilter = FilterModel(filterID: 'productPrices', canPickMany: true, keywordModels: Keywordz.productPrices);
// -----------------------------------------------------------------------------
  static FilterModel zoneAreasAsFilter (BuildContext context){
    FilterModel _zoneAreaFilter = Zone.getFilterModelFromCurrentZoneAreas(context);
    return null;
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
  static bool getCanFilterPickManyByKeyword(KeywordModel keywordModel){
    List<FilterModel> _allFilters = <FilterModel>[
      ...propertiesFilters,
      ...designsFilters,
      ...projectsFiltersIDs,
      ...craftsFiltersIDs,
      ...productsFiltersIDs,
    ];

    bool _canPickMany = _allFilters.firstWhere((filter) => filter.filterID == keywordModel.filterID).canPickMany;

    return _canPickMany;
  }
}
