import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keywordz.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/planet/district_model.dart';
import 'package:bldrs/providers/country_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Keywords are grouped into Group class
class Group{
  final String groupID;
  final bool canPickMany;
  final List<Keyword> keywords;

  Group({
    @required this.groupID,
    @required this.canPickMany,
    @required this.keywords,
  });
// -----------------------------------------------------------------------------
  static List<Group> getGroupBySection({Section section}){

    List<Group> _group =
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
  static List<Group> getGroupsByFlyerType({FlyerType flyerType}){

    print('getGroupsByFlyerType : flyerType : $flyerType');

    switch (flyerType){
      case FlyerType.Property   :   return getPropertiesGroups();  break;

      case FlyerType.Design     :   return getDesignsGroups();     break;
      case FlyerType.Project    :   return getProjectsGroups();    break;
      case FlyerType.Craft      :   return getCraftsGroups();      break;

      case FlyerType.Product    :   return getProductsGroups();    break;
      case FlyerType.Equipment  :   return getEquipmentGroups();   break;
      default : return   null;
    }
  }
// -----------------------------------------------------------------------------
  static Group propertyFormsGroups = Group(groupID: 'group_ppt_form', canPickMany: false, keywords: FilterKeywords.propertyForms());
  static Group propertyTypesGroup = Group(groupID: 'group_ppt_type', canPickMany: false, keywords: FilterKeywords.propertyTypes());
  static Group propertyAreaGroup = Group(groupID: 'group_ppt_area', canPickMany: false, keywords: FilterKeywords.propertyArea());
  static Group propertySpacesGroup = Group(groupID: 'group_ppt_spaces', canPickMany: true, keywords: FilterKeywords.spaceTypes());
  static Group propertyFeaturesGroup = Group(groupID: 'group_ppt_features', canPickMany: true, keywords: FilterKeywords.propertyFeatures());
  static Group propertyPricesGroup = Group(groupID: 'group_ppt_price', canPickMany: true, keywords: FilterKeywords.propertyPrices());
  static Group propertyLicenseGroup = Group(groupID: 'group_ppt_license', canPickMany: false, keywords: FilterKeywords.propertyLicenses());
// -----------------------------------------------------------------------------
  static Group designTypesGroup = Group(groupID: 'group_dz_type', canPickMany: false, keywords: FilterKeywords.designTypes());
  static Group architecturalStylesGroup = Group(groupID: 'group_dz_style', canPickMany: false, keywords: FilterKeywords.architecturalStyles());
  static Group spaceTypeGroup = Group(groupID: 'group_space_type', canPickMany: true, keywords: FilterKeywords.spaceTypes());
  static Group kioskTypeGroup = Group(groupID: 'group_dz_kioskType', canPickMany: false, keywords: FilterKeywords.kioskTypes());
// -----------------------------------------------------------------------------
  static Group constructionTradesGroup = Group(groupID: 'group_craft_trade', canPickMany: true, keywords: FilterKeywords.constructionTrades());
// -----------------------------------------------------------------------------
  static Group productsGroup = Group(groupID: 'product', canPickMany: true, keywords: FilterKeywords.products());
  static Group productPricesGroup = Group(groupID: 'productPrices', canPickMany: true, keywords: FilterKeywords.productPrices());
// -----------------------------------------------------------------------------
  static Group getGroupFromCurrentDistricts(BuildContext context){

    CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: true);
    String _provinceID = _countryPro.currentCityID;
    List<District> _districts = _countryPro.getDistrictsByCityID(context, _provinceID);

    List<Keyword> _districtsAsKeywords = Keyword.getKeywordsModelsFromDistricts(_districts);

    Group _group = Group(
        groupID: _districtsAsKeywords[0].groupID,
        canPickMany: false,
        keywords: _districtsAsKeywords
    );

    return _group;
  }
// -----------------------------------------------------------------------------
  static Group zoneDistrictsAsGroup (BuildContext context){
    Group _zoneDistrictsGroup = getGroupFromCurrentDistricts(context);
    return _zoneDistrictsGroup;
  }
// -----------------------------------------------------------------------------
  static List<Group> getAllGroups(){
    List<Group> _allGroups = <Group>[
      ...getPropertiesGroups(),
      ...getDesignsGroups(),
      ...getProjectsGroups(),
      ...getCraftsGroups(),
      ...getProductsGroups(),
    ];

    return _allGroups;
  }
// -----------------------------------------------------------------------------
  static List<Group> getPropertiesGroups(){
    return <Group>[
      propertyFormsGroups,
      propertyTypesGroup,
      propertyAreaGroup,
      propertySpacesGroup,
      propertyFeaturesGroup,
      propertyPricesGroup,
      propertyLicenseGroup,
    ];;
  }
// -----------------------------------------------------------------------------
  static List<Group> getDesignsGroups(){
    return
     <Group>[
        designTypesGroup,
        architecturalStylesGroup,
        spaceTypeGroup,
        propertyAreaGroup,
        productsGroup,
      ];
  }
// -----------------------------------------------------------------------------
  static List<Group> getProjectsGroups(){
    return
      <Group>[
        constructionTradesGroup,
        designTypesGroup,
        spaceTypeGroup,
        propertyAreaGroup,
        productsGroup,
      ];
  }
// -----------------------------------------------------------------------------
  static List<Group> getCraftsGroups(){
    return <Group>[
      constructionTradesGroup,
      spaceTypeGroup,
      productsGroup,
    ];
  }
// -----------------------------------------------------------------------------
  static List<Group> getProductsGroups(){
    return <Group>[
      productsGroup,
      productPricesGroup,
    ];
  }
// -----------------------------------------------------------------------------
  static List<Group> getEquipmentGroups(){
    return <Group>[
      productsGroup,
      productPricesGroup,
    ];
  }
// -----------------------------------------------------------------------------
  static bool getCanGroupPickManyByKeyword(Keyword keyword){

    bool _canPickMany;
    Group _group = getGroupByKeyword(keyword);

    if (_group == null){
      // keep can pick many null
    }
    else {
      _canPickMany = _group.canPickMany;
    }

    return _canPickMany;
  }
// -----------------------------------------------------------------------------
  static Group getGroupByKeyword(Keyword keyword){

    Group _group = getAllGroups().firstWhere((filter) => filter.groupID == keyword.groupID, orElse: () => null);
    return _group;
  }
// -----------------------------------------------------------------------------

}
