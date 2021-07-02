import 'package:bldrs/controllers/theme/keywordz.dart';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:flutter/cupertino.dart';

// enum SequenceType{
//   TwoKeywords, // for intersecting data structure : keyword 1 + keyword 2
//   OneKeyword, // for straight data structure : filterID / groupID / subGroupID / keyword
// }

class GroupModel {
  final bool sectionIsOn;
  final String groupID;
  final FilterModel secondKeywords;

  GroupModel({
    @required this.sectionIsOn,
    @required this.groupID, // groupID or keywordID will see
    this.secondKeywords, // if null, we go directly to KeywordFlyersPage
  });
// -----------------------------------------------------------------------------
  static List<GroupModel> getGroupsBySection({Section section}){
    List<GroupModel> _groups = new List();

    List<GroupModel> _allGroupsBySection =
    section == Section.RealEstate ? GroupModel.propertiesGroups :
    section == Section.Construction ? GroupModel.designsGroups :
    section == Section.Supplies ? GroupModel.productsGroups :
    [] ;

    _allGroupsBySection.forEach((group) {
      if(group.sectionIsOn == true){
        _groups.add(group);
      }
    });

    return _groups;
}
// -----------------------------------------------------------------------------
  static List<GroupModel> propertiesGroups = <GroupModel>[
    GroupModel(sectionIsOn: true, groupID: 'pt_apartment', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_furnishedApartment', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_loft', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_penthouse', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_chalet', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_twinhouse', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_bungalow', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_villa', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_condo', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_farm', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_townHome', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: false, groupID: 'pt_coop', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_sharedRoom', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_duplix', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_hotelApartment', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_studio', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_store', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_supermarket', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_warehouse', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_hall', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_bank', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_restaurant', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_pharmacy', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_studio', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_factory', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_office', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_school', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_hotel', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_football', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'pt_tennis', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'pt_basketball', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'pt_gym', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_gallery', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_theatre', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'space_spa', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pt_clinic', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'pf_building', secondKeywords: FilterModel.propertyLicenseFilter),
  ];
// -----------------------------------------------------------------------------
  static List<GroupModel> designsGroups = <GroupModel>[
    GroupModel(sectionIsOn: true, groupID: 'designType_architecture', secondKeywords: FilterModel.propertyLicenseFilter),
    GroupModel(sectionIsOn: true, groupID: 'designType_interior', secondKeywords: FilterModel.spaceTypeFilter),
    GroupModel(sectionIsOn: true, groupID: 'designType_facade', secondKeywords: FilterModel.propertyLicenseFilter),
    GroupModel(sectionIsOn: true, groupID: 'designType_urban', secondKeywords: FilterModel.propertyLicenseFilter),
    GroupModel(sectionIsOn: true, groupID: 'designType_landscape', secondKeywords: FilterModel.propertyAreaFilter),
    GroupModel(sectionIsOn: true, groupID: 'designType_structural', secondKeywords: FilterModel.propertyLicenseFilter),
    GroupModel(sectionIsOn: true, groupID: 'designType_kiosk', secondKeywords: FilterModel.kioskTypeFilter),
  ];
// -----------------------------------------------------------------------------
  static List<GroupModel> craftsGroups = <GroupModel>[
    GroupModel(sectionIsOn: true, groupID: 'con_trade_carpentry', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_electricity', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_insulation', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_masonry', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_plumbing', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_blacksmithing', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_labor', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_painting', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_plaster', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_landscape', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_hardscape', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_hvac', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_firefighting', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_elevators', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_tiling', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_transportation', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'con_trade_concrete', secondKeywords: null),
  ];
// -----------------------------------------------------------------------------
  static List<GroupModel> productsGroups = <GroupModel>[
    GroupModel(sectionIsOn: true, groupID: 'prdtype_walls', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_floors', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_structure', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_fireFighting', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_safety', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_stairs', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_roofing', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_doorsWindows', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_landscape', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_hvac', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_plumbing', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_lighting', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_electricity', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_security', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_poolSpa', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_smartHome', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_furniture', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_appliances', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_fireplaces', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_materials', secondKeywords: null),
    GroupModel(sectionIsOn: true, groupID: 'prdtype_tools', secondKeywords: null),
  ];
// -----------------------------------------------------------------------------
}