import 'package:bldrs/controllers/theme/keywordz.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/section_class.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/zone_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class FilterModel{
  final String groupID;
  final bool canPickMany;
  final List<KeywordModel> keywordModels;

  FilterModel({
    @required this.groupID,
    @required this.canPickMany,
    @required this.keywordModels,
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
  static FilterModel propertyFormsFilter = FilterModel(groupID: 'group_ppt_form', canPickMany: false, keywordModels: Keywordz.propertyForms);
  static FilterModel propertyTypesFilter = FilterModel(groupID: 'propertyType', canPickMany: false, keywordModels: Keywordz.propertyTypes);
  static FilterModel propertySpacesFilter = FilterModel(groupID: 'spaces', canPickMany: true, keywordModels: Keywordz.spaces);
  static FilterModel propertyFeaturesFilter = FilterModel(groupID: 'propertyFeatures', canPickMany: true, keywordModels: Keywordz.propertyFeatures);
  static FilterModel propertyPricesFilter = FilterModel(groupID: 'propertyPrice', canPickMany: true, keywordModels: Keywordz.propertyPrices);
  static FilterModel propertyAreaFilter = FilterModel(groupID: 'area', canPickMany: false, keywordModels: Keywordz.propertyAreas);
  static FilterModel propertyLicenseFilter = FilterModel(groupID: 'propertyLicense', canPickMany: false, keywordModels: Keywordz.propertyLicenses);
// -----------------------------------------------------------------------------
  static FilterModel designTypesFilter = FilterModel(groupID: 'designType', canPickMany: false, keywordModels: Keywordz.designTypes);
  static FilterModel architecturalStylesFilter = FilterModel(groupID: 'architecturalStyle', canPickMany: false, keywordModels: Keywordz.architecturalStyles);
  static FilterModel spaceTypeFilter = FilterModel(groupID: 'spaceType', canPickMany: true, keywordModels: Keywordz.spaceTypes);
  static FilterModel kioskTypeFilter = FilterModel(groupID: 'kioskType', canPickMany: false, keywordModels: Keywordz.kioskTypes);
// -----------------------------------------------------------------------------
  static FilterModel constructionTradesFilter = FilterModel(groupID: 'constructionTrade', canPickMany: true, keywordModels: Keywordz.constructionTrades);
// -----------------------------------------------------------------------------
  static FilterModel productsFilter = FilterModel(groupID: 'product', canPickMany: true, keywordModels: Keywordz.products);
  static FilterModel productPricesFilter = FilterModel(groupID: 'productPrices', canPickMany: true, keywordModels: Keywordz.productPrices);
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
  static List<FilterModel> equipmentFiltersIDs = <FilterModel>[
    productsFilter,
    productPricesFilter,
  ];

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
}
