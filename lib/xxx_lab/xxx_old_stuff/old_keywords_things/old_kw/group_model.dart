// import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
// import 'package:bldrs/a_models/keywords/keyword_model.dart';
// import 'package:bldrs/a_models/keywords/keywordz.dart';
// import 'package:bldrs/a_models/keywords/section_class.dart';
// import 'package:bldrs/a_models/zone/city_model.dart';
// import 'package:bldrs/a_models/zone/district_model.dart';
// import 'package:bldrs/d_providers/zone_provider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// /// Keywords are grouped into Group class, and used as secondary keywords in sequences
// class GroupModel{
//   final String groupID;
//   final bool canPickMany;
//   final List<Keyword> keywords;
//
//   GroupModel({
//     @required this.groupID,
//     @required this.canPickMany,
//     @required this.keywords,
//   });
// // -----------------------------------------------------------------------------
//   static List<GroupModel> getGroupBySection({Section section}){
//
//     final List<GroupModel> _group =
//         section == Section.NewProperties ? getPropertiesGroups() :
//         section == Section.ResaleProperties ? getPropertiesGroups() :
//         section == Section.RentalProperties ? getPropertiesGroups() :
//
//         section == Section.Designs ? getDesignsGroups() :
//         section == Section.Projects ? getProjectsGroups() :
//         section == Section.Crafts ? getCraftsGroups() :
//
//         section == Section.Products ? getProductsGroups() :
//         section == Section.Equipment ? getEquipmentGroups() :
//         null;
//
//         return _group;
//   }
// // -----------------------------------------------------------------------------
//   static List<GroupModel> getGroupsByFlyerType({FlyerType flyerType}){
//
//     print('getGroupsByFlyerType : flyerType : $flyerType');
//
//     switch (flyerType){
//       case FlyerType.newProperty      :   return getPropertiesGroups();  break;
//       case FlyerType.rentalProperty   :   return getPropertiesGroups();  break;
//       case FlyerType.resaleProperty   :   return getPropertiesGroups();  break;
//
//       case FlyerType.design           :   return getDesignsGroups();     break;
//       case FlyerType.project          :   return getProjectsGroups();    break;
//       case FlyerType.craft            :   return getCraftsGroups();      break;
//
//       case FlyerType.product          :   return getProductsGroups();    break;
//       case FlyerType.equipment        :   return getEquipmentGroups();   break;
//       default : return   null;
//     }
//   }
// // -----------------------------------------------------------------------------
//   static final GroupModel propertyFormsGroups = GroupModel(groupID: 'group_ppt_form', canPickMany: false, keywords: Keywordz.propertyForms());
//   static final GroupModel propertyTypesGroup = GroupModel(groupID: 'group_ppt_type', canPickMany: false, keywords: Keywordz.propertyTypes());
//   static final GroupModel propertyAreaGroup = GroupModel(groupID: 'group_ppt_area', canPickMany: false, keywords: Keywordz.propertyArea());
//   static final GroupModel propertySpacesGroup = GroupModel(groupID: 'group_ppt_spaces', canPickMany: true, keywords: Keywordz.spaceTypes());
//   static final GroupModel propertyFeaturesGroup = GroupModel(groupID: 'group_ppt_features', canPickMany: true, keywords: Keywordz.propertyFeatures());
//   static final GroupModel propertyPricesGroup = GroupModel(groupID: 'group_ppt_price', canPickMany: true, keywords: Keywordz.propertyPrices());
//   static final GroupModel propertyLicenseGroup = GroupModel(groupID: 'group_ppt_license', canPickMany: false, keywords: Keywordz.propertyLicenses());
// // -----------------------------------------------------------------------------
//   static final GroupModel designTypesGroup = GroupModel(groupID: 'group_dz_type', canPickMany: false, keywords: Keywordz.designTypes());
//   static final GroupModel architecturalStylesGroup = GroupModel(groupID: 'group_dz_style', canPickMany: false, keywords: Keywordz.architecturalStyles());
//   static final GroupModel spaceTypeGroup = GroupModel(groupID: 'group_space_type', canPickMany: true, keywords: Keywordz.spaceTypes());
//   static final GroupModel kioskTypeGroup = GroupModel(groupID: 'group_dz_kioskType', canPickMany: false, keywords: Keywordz.kioskTypes());
// // -----------------------------------------------------------------------------
//   static final GroupModel constructionTradesGroup = GroupModel(groupID: 'group_craft_trade', canPickMany: true, keywords: Keywordz.constructionTrades());
// // -----------------------------------------------------------------------------
//   static final GroupModel productsGroup = GroupModel(groupID: 'product', canPickMany: true, keywords: Keywordz.products());
//   static final GroupModel productPricesGroup = GroupModel(groupID: 'productPrices', canPickMany: true, keywords: Keywordz.productPrices());
// // -----------------------------------------------------------------------------
//   static GroupModel getGroupFromCurrentDistricts(BuildContext context){
//
//     final ZoneProvider _zoneProvider =  Provider.of<ZoneProvider>(context, listen: true);
//     // final CountryModel _currentCountry = _zoneProvider.currentCountry;
//     final CityModel _currentCity = _zoneProvider.currentCity;
//
//     // final String _cityID = _zoneProvider.currentZone.cityID;
//     final List<DistrictModel> _districts = _currentCity.districts;
//
//     final List<Keyword> _districtsAsKeywords = Keyword.getKeywordsModelsFromDistricts(_districts);
//     final String _keywordGroupID = _districtsAsKeywords.length > 0 ? _districtsAsKeywords[0].groupID : null;
//
//     final GroupModel _group = GroupModel(
//         groupID: _keywordGroupID,
//         canPickMany: false,
//         keywords: _districtsAsKeywords
//     );
//
//     return _group;
//   }
// // -----------------------------------------------------------------------------
//   static GroupModel zoneDistrictsAsGroup (BuildContext context){
//     final GroupModel _zoneDistrictsGroup = getGroupFromCurrentDistricts(context);
//     return _zoneDistrictsGroup;
//   }
// // -----------------------------------------------------------------------------
//   static List<GroupModel> getAllGroups(){
//     final List<GroupModel> _allGroups = <GroupModel>[
//       ...getPropertiesGroups(),
//       ...getDesignsGroups(),
//       ...getProjectsGroups(),
//       ...getCraftsGroups(),
//       ...getProductsGroups(),
//     ];
//
//     return _allGroups;
//   }
// // -----------------------------------------------------------------------------
//   static List<GroupModel> getPropertiesGroups(){
//     return <GroupModel>[
//       propertyFormsGroups,
//       propertyTypesGroup,
//       propertyAreaGroup,
//       propertySpacesGroup,
//       propertyFeaturesGroup,
//       propertyPricesGroup,
//       propertyLicenseGroup,
//     ];
//   }
// // -----------------------------------------------------------------------------
//   static List<GroupModel> getDesignsGroups(){
//     return
//      <GroupModel>[
//         designTypesGroup,
//         architecturalStylesGroup,
//         spaceTypeGroup,
//         propertyAreaGroup,
//         productsGroup,
//       ];
//   }
// // -----------------------------------------------------------------------------
//   static List<GroupModel> getProjectsGroups(){
//     return
//       <GroupModel>[
//         constructionTradesGroup,
//         designTypesGroup,
//         spaceTypeGroup,
//         propertyAreaGroup,
//         productsGroup,
//       ];
//   }
// // -----------------------------------------------------------------------------
//   static List<GroupModel> getCraftsGroups(){
//     return <GroupModel>[
//       constructionTradesGroup,
//       spaceTypeGroup,
//       productsGroup,
//     ];
//   }
// // -----------------------------------------------------------------------------
//   static List<GroupModel> getProductsGroups(){
//     return <GroupModel>[
//       productsGroup,
//       productPricesGroup,
//     ];
//   }
// // -----------------------------------------------------------------------------
//   static List<GroupModel> getEquipmentGroups(){
//     return <GroupModel>[
//       productsGroup,
//       productPricesGroup,
//     ];
//   }
// // -----------------------------------------------------------------------------
//   static bool getCanGroupPickManyByKeyword(Keyword keyword){
//
//     bool _canPickMany;
//     final GroupModel _group = getGroupByKeyword(keyword);
//
//     if (_group == null){
//       // keep can pick many null
//     }
//     else {
//       _canPickMany = _group.canPickMany;
//     }
//
//     return _canPickMany;
//   }
// // -----------------------------------------------------------------------------
//   static GroupModel getGroupByKeyword(Keyword keyword){
//     final GroupModel _group = getAllGroups().firstWhere((filter) => filter.groupID == keyword.groupID, orElse: () => null);
//     return _group;
//   }
// // -----------------------------------------------------------------------------
//
// }