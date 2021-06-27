import 'package:bldrs/controllers/theme/keywordz.dart';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
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
  static List<FilterModel> propertiesFilters = <FilterModel>[
    FilterModel(filterID: 'propertyForm', canPickMany: false, keywordModels: Keywordz.propertyForm),
    FilterModel(filterID: 'propertyType', canPickMany: false, keywordModels: Keywordz.propertyType),
    FilterModel(filterID: 'area', canPickMany: false, keywordModels: Keywordz.area),
    FilterModel(filterID: 'spaces', canPickMany: true, keywordModels: Keywordz.spaces),
    FilterModel(filterID: 'propertyFeatures', canPickMany: true, keywordModels: Keywordz.propertyFeatures),
    FilterModel(filterID: 'propertyPrice', canPickMany: true, keywordModels: Keywordz.propertyPrice),
  ];
// -----------------------------------------------------------------------------
  static List<FilterModel> designsFilters = <FilterModel>[
    FilterModel(filterID: 'designType', canPickMany: false, keywordModels: Keywordz.designType),
    FilterModel(filterID: 'architecturalStyle', canPickMany: false, keywordModels: Keywordz.architecturalStyle),
    FilterModel(filterID: 'spaceType', canPickMany: true, keywordModels: Keywordz.spaceType),
    FilterModel(filterID: 'area', canPickMany: true, keywordModels: Keywordz.area),
    FilterModel(filterID: 'product', canPickMany: true, keywordModels: Keywordz.product),
  ];
// -----------------------------------------------------------------------------
  static List<FilterModel> projectsFiltersIDs = <FilterModel>[
    FilterModel(filterID: 'constructionTrade', canPickMany: true, keywordModels: Keywordz.constructionTrade),
    FilterModel(filterID: 'designType', canPickMany: false, keywordModels: Keywordz.designType),
    FilterModel(filterID: 'spaceType', canPickMany: true, keywordModels: Keywordz.spaceType),
    FilterModel(filterID: 'area', canPickMany: true, keywordModels: Keywordz.area),
    FilterModel(filterID: 'product', canPickMany: true, keywordModels: Keywordz.product),
  ];
// -----------------------------------------------------------------------------
  static List<FilterModel> craftsFiltersIDs = <FilterModel>[
    FilterModel(filterID: 'constructionTrade', canPickMany: true, keywordModels: Keywordz.constructionTrade),
    FilterModel(filterID: 'spaceType', canPickMany: true, keywordModels: Keywordz.spaceType),
    FilterModel(filterID: 'product', canPickMany: true, keywordModels: Keywordz.product),
  ];
// -----------------------------------------------------------------------------
  static List<FilterModel> productsFiltersIDs = <FilterModel>[
    FilterModel(filterID: 'product', canPickMany: false, keywordModels: Keywordz.product),
    /// TASK : Add product price filter
  ];
// -----------------------------------------------------------------------------
}
