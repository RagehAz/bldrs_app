import 'package:bldrs/controllers/theme/keywordz.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/section_class.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:flutter/cupertino.dart';

// enum SequenceType{
//   TwoKeywords, // for intersecting data structure : keyword 1 + keyword 2
//   OneKeyword, // for straight data structure : filterID / groupID / subGroupID / keyword
// }

class GroupModel {
  final bool sectionIsOn;
  final String firstKeywordID;
  final FilterModel secondKeywords;

  GroupModel({
    @required this.sectionIsOn,
    @required this.firstKeywordID, // groupID or keywordID will see
    this.secondKeywords, // if null, we go directly to KeywordFlyersPage
  });
// -----------------------------------------------------------------------------
  static List<GroupModel> getGroupsBySection({Section section}){
    List<GroupModel> _groups = new List();

    List<GroupModel> _groupsBySection =
    section == Section.NewProperties ? GroupModel.propertiesGroups() :
    section == Section.ResaleProperties ? GroupModel.propertiesGroups() :
    section == Section.RentalProperties ? GroupModel.propertiesGroups() :

    section == Section.Designs ? GroupModel.designsGroups() :
    section == Section.Projects ? GroupModel.projectsGroups() :
    section == Section.Crafts ? GroupModel.craftsGroups() :

    section == Section.Products ? GroupModel.productsGroups() :
    section == Section.Equipment ? GroupModel.equipmentGroups() :

    [] ;


    return _groupsBySection;
}

// -----------------------------------------------------------------------------
//   static List<GroupModel> propertiesGroupsX(){
//     List<GroupModel> _propertiesGroups = new List();
//
//     List<KeywordModel> _propertyLicenses = KeywordModel.getKeywordsByGroupID('group_ppt_license');
//
//     List<String> _keywordsWithNoSecondKeyword = [
//       'pt_football',
//       'pt_tennis',
//       'pt_basketball',
//     ];
//
//     _propertyLicenses.forEach((keyword) {
//       _propertiesGroups.add(
//           GroupModel(
//             sectionIsOn: true,
//             firstKeyword: keyword.groupID,
//             secondKeywords: null,
//           ),
//       );
//     });
//
//     return _propertiesGroups;
//   }

  static List<GroupModel> propertiesGroups(){
    return
      <GroupModel>[
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_apartment', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_furnishedApartment', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_loft', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_penthouse', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_chalet', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_twinhouse', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_bungalow', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_villa', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_condo', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_farm', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_townHome', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_sharedRoom', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_duplix', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_hotelApartment', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_studio', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_store', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_supermarket', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_warehouse', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_hall', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_bank', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_restaurant', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_pharmacy', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_studio', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_factory', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_office', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_school', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_hotel', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_football', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_tennis', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_basketball', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_gym', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_gallery', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_theatre', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'space_spa', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pt_clinic', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'pf_building', secondKeywords: FilterModel.propertyLicenseFilter),
      ];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> designsGroups(){
    return
      <GroupModel>[
        GroupModel(sectionIsOn: true, firstKeywordID: 'designType_architecture', secondKeywords: FilterModel.propertyLicenseFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'designType_interior', secondKeywords: FilterModel.spaceTypeFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'designType_facade', secondKeywords: FilterModel.propertyLicenseFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'designType_urban', secondKeywords: FilterModel.propertyLicenseFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'designType_landscape', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'designType_structural', secondKeywords: FilterModel.propertyLicenseFilter),
        GroupModel(sectionIsOn: true, firstKeywordID: 'designType_kiosk', secondKeywords: FilterModel.kioskTypeFilter),
      ];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> projectsGroups(){
    return
    <GroupModel>[];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> craftsGroups(){
    return
      <GroupModel>[
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_carpentry', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_electricity', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_insulation', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_masonry', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_plumbing', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_blacksmithing', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_labor', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_painting', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_plaster', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_landscape', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_hardscape', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_hvac', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_firefighting', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_elevators', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_tiling', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_transportation', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeywordID: 'con_trade_concrete', secondKeywords: null),
      ];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> productsGroupsX(){
    List<GroupModel> _productsGroups = new List();

    List<KeywordModel> _productsKeywords = KeywordModel.getKeywordsByFlyerType(FlyerType.Product);

    _productsKeywords.forEach((keyword) {
      _productsGroups.add(
        GroupModel(
          sectionIsOn: true,
          firstKeywordID: keyword.keywordID,
          secondKeywords: null,
        ),
      );
    });

    return _productsGroups;
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> productsGroups(){
    return
    <GroupModel>[
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_walls', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_floors', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_structure', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_fireFighting', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_safety', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_stairs', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_roofing', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_doorsWindows', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_landscape', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_hvac', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_plumbing', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_lighting', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_electricity', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_security', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_poolSpa', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_smartHome', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_furniture', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_appliances', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_fireplaces', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_materials', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeywordID: 'group_prd_tools', secondKeywords: null),
    ];
    }
// -----------------------------------------------------------------------------
  static List<GroupModel> equipmentGroups(){
    return
        <GroupModel>[];
  }
// -----------------------------------------------------------------------------
}