import 'package:bldrs/controllers/theme/keywordz.dart';
import 'package:bldrs/models/bldrs_sections.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:flutter/cupertino.dart';

// enum SequenceType{
//   TwoKeywords, // for intersecting data structure : keyword 1 + keyword 2
//   OneKeyword, // for straight data structure : filterID / groupID / subGroupID / keyword
// }

class SectionGroupModel {
  final bool sectionIsOn;
  final String keywordID;
  final FilterModel secondKeywords;

  SectionGroupModel({
    @required this.sectionIsOn,
    @required this.keywordID, // groupID or keywordID will see
    this.secondKeywords, // if null, we go directly to KeywordFlyersPage
  });

  static List<SectionGroupModel> propertiesGroups = <SectionGroupModel>[
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_apartment', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_furnishedApartment', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_loft', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_penthouse', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_chalet', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_twinhouse', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_bungalow', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_villa', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_condo', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_farm', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_townHome', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_coop', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_sharedRoom', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_duplix', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_hotelApartment', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_studio', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_store', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_supermarket', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_warehouse', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_hall', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_bank', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_restaurant', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_pharmacy', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_studio', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_factory', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_office', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_school', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_hotel', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_football', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_tennis', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_basketball', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_gym', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_gallery', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_theatre', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'space_spa', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pt_clinic', secondKeywords: FilterModel.propertyAreaFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'pf_building', secondKeywords: FilterModel.propertyLicenseFilter),
  ];

  static List<SectionGroupModel> designsGroups = <SectionGroupModel>[
    SectionGroupModel(sectionIsOn: true, keywordID: 'designType_architecture', secondKeywords: FilterModel.propertyLicenseFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'designType_interior', secondKeywords: FilterModel.spaceTypeFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'designType_facade', secondKeywords: FilterModel.propertyLicenseFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'designType_urban', secondKeywords: FilterModel.propertyLicenseFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'designType_landscape', secondKeywords: FilterModel.spaceTypeFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'designType_structural', secondKeywords: FilterModel.propertyLicenseFilter),
    SectionGroupModel(sectionIsOn: true, keywordID: 'designType_kiosk', secondKeywords: FilterModel.kioskTypeFilter),
  ];

  static List<SectionGroupModel> craftsGroups = <SectionGroupModel>[
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_carpentry', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_electricity', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_insulation', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_masonry', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_plumbing', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_blacksmithing', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_labor', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_painting', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_plaster', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_landscape', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_hardscape', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_hvac', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_firefighting', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_elevators', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_tiling', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_transportation', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'con_trade_concrete', secondKeywords: null),
  ];

  static List<SectionGroupModel> productsGroups = <SectionGroupModel>[
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_walls', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_floors', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_structure', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_fireFighting', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_safety', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_stairs', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_roofing', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_doorsWindows', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_landscape', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_hvac', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_plumbing', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_lighting', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_electricity', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_security', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_poolSpa', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_smartHome', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_furniture', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_appliances', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_fireplaces', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_materials', secondKeywords: null),
    SectionGroupModel(sectionIsOn: true, keywordID: 'prdtype_tools', secondKeywords: null),
  ];

}

/*

Realestate
home list : property license

Construction


Supplies


 */