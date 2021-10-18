import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/keywords/keywordz.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/district_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Keywords are grouped into Group class
class GroupModel{
  final String groupID;
  final bool canPickMany;
  final List<Keyword> keywords;

  GroupModel({
    @required this.groupID,
    @required this.canPickMany,
    @required this.keywords,
  });
// -----------------------------------------------------------------------------
  static List<GroupModel> getGroupBySection({Section section}){

    final List<GroupModel> _group =
        section == Section.NewProperties ? getPropertiesGroups() :
        section == Section.ResaleProperties ? getPropertiesGroups() :
        section == Section.RentalProperties ? getPropertiesGroups() :

        section == Section.Designs ? getDesignsGroups() :
        section == Section.Projects ? getProjectsGroups() :
        section == Section.Crafts ? getCraftsGroups() :

        section == Section.Products ? getProductsGroups() :
        section == Section.Equipment ? getEquipmentGroups() :
        null;

        return _group;
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> getGroupsByFlyerType({FlyerType flyerType}){

    print('getGroupsByFlyerType : flyerType : $flyerType');

    switch (flyerType){
      case FlyerType.newProperty      :   return getPropertiesGroups();  break;
      case FlyerType.rentalProperty   :   return getPropertiesGroups();  break;
      case FlyerType.resaleProperty   :   return getPropertiesGroups();  break;

      case FlyerType.design           :   return getDesignsGroups();     break;
      case FlyerType.project          :   return getProjectsGroups();    break;
      case FlyerType.craft            :   return getCraftsGroups();      break;

      case FlyerType.product          :   return getProductsGroups();    break;
      case FlyerType.equipment        :   return getEquipmentGroups();   break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static final GroupModel propertyFormsGroups = GroupModel(groupID: 'group_ppt_form', canPickMany: false, keywords: FilterKeywords.propertyForms());
  static final GroupModel propertyTypesGroup = GroupModel(groupID: 'group_ppt_type', canPickMany: false, keywords: FilterKeywords.propertyTypes());
  static final GroupModel propertyAreaGroup = GroupModel(groupID: 'group_ppt_area', canPickMany: false, keywords: FilterKeywords.propertyArea());
  static final GroupModel propertySpacesGroup = GroupModel(groupID: 'group_ppt_spaces', canPickMany: true, keywords: FilterKeywords.spaceTypes());
  static final GroupModel propertyFeaturesGroup = GroupModel(groupID: 'group_ppt_features', canPickMany: true, keywords: FilterKeywords.propertyFeatures());
  static final GroupModel propertyPricesGroup = GroupModel(groupID: 'group_ppt_price', canPickMany: true, keywords: FilterKeywords.propertyPrices());
  static final GroupModel propertyLicenseGroup = GroupModel(groupID: 'group_ppt_license', canPickMany: false, keywords: FilterKeywords.propertyLicenses());
// -----------------------------------------------------------------------------
  static final GroupModel designTypesGroup = GroupModel(groupID: 'group_dz_type', canPickMany: false, keywords: FilterKeywords.designTypes());
  static final GroupModel architecturalStylesGroup = GroupModel(groupID: 'group_dz_style', canPickMany: false, keywords: FilterKeywords.architecturalStyles());
  static final GroupModel spaceTypeGroup = GroupModel(groupID: 'group_space_type', canPickMany: true, keywords: FilterKeywords.spaceTypes());
  static final GroupModel kioskTypeGroup = GroupModel(groupID: 'group_dz_kioskType', canPickMany: false, keywords: FilterKeywords.kioskTypes());
// -----------------------------------------------------------------------------
  static final GroupModel constructionTradesGroup = GroupModel(groupID: 'group_craft_trade', canPickMany: true, keywords: FilterKeywords.constructionTrades());
// -----------------------------------------------------------------------------
  static final GroupModel productsGroup = GroupModel(groupID: 'product', canPickMany: true, keywords: FilterKeywords.products());
  static final GroupModel productPricesGroup = GroupModel(groupID: 'productPrices', canPickMany: true, keywords: FilterKeywords.productPrices());
// -----------------------------------------------------------------------------
  static GroupModel getGroupFromCurrentDistricts(BuildContext context){

    final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: true);
    final CountryModel _currentCountry = _zoneProvider.currentCountry;
    final String _cityID = _zoneProvider.currentZone.cityID;
    final List<DistrictModel> _districts = DistrictModel.getDistrictsFromCountryModel(country: _currentCountry, cityID: _cityID);

    final List<Keyword> _districtsAsKeywords = Keyword.getKeywordsModelsFromDistricts(_districts);

    final GroupModel _group = GroupModel(
        groupID: _districtsAsKeywords[0].groupID,
        canPickMany: false,
        keywords: _districtsAsKeywords
    );

    return _group;
  }
// -----------------------------------------------------------------------------
  static GroupModel zoneDistrictsAsGroup (BuildContext context){
    final GroupModel _zoneDistrictsGroup = getGroupFromCurrentDistricts(context);
    return _zoneDistrictsGroup;
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> getAllGroups(){
    final List<GroupModel> _allGroups = <GroupModel>[
      ...getPropertiesGroups(),
      ...getDesignsGroups(),
      ...getProjectsGroups(),
      ...getCraftsGroups(),
      ...getProductsGroups(),
    ];

    return _allGroups;
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> getPropertiesGroups(){
    return <GroupModel>[
      propertyFormsGroups,
      propertyTypesGroup,
      propertyAreaGroup,
      propertySpacesGroup,
      propertyFeaturesGroup,
      propertyPricesGroup,
      propertyLicenseGroup,
    ];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> getDesignsGroups(){
    return
     <GroupModel>[
        designTypesGroup,
        architecturalStylesGroup,
        spaceTypeGroup,
        propertyAreaGroup,
        productsGroup,
      ];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> getProjectsGroups(){
    return
      <GroupModel>[
        constructionTradesGroup,
        designTypesGroup,
        spaceTypeGroup,
        propertyAreaGroup,
        productsGroup,
      ];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> getCraftsGroups(){
    return <GroupModel>[
      constructionTradesGroup,
      spaceTypeGroup,
      productsGroup,
    ];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> getProductsGroups(){
    return <GroupModel>[
      productsGroup,
      productPricesGroup,
    ];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> getEquipmentGroups(){
    return <GroupModel>[
      productsGroup,
      productPricesGroup,
    ];
  }
// -----------------------------------------------------------------------------
  static bool getCanGroupPickManyByKeyword(Keyword keyword){

    bool _canPickMany;
    final GroupModel _group = getGroupByKeyword(keyword);

    if (_group == null){
      // keep can pick many null
    }
    else {
      _canPickMany = _group.canPickMany;
    }

    return _canPickMany;
  }
// -----------------------------------------------------------------------------
  static GroupModel getGroupByKeyword(Keyword keyword){
    final GroupModel _group = getAllGroups().firstWhere((filter) => filter.groupID == keyword.groupID, orElse: () => null);
    return _group;
  }
// -----------------------------------------------------------------------------

}
