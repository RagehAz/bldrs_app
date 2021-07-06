import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:flutter/cupertino.dart';

// enum SequenceType{
//   TwoKeywords, // for intersecting data structure : keyword 1 + keyword 2
//   OneKeyword, // for straight data structure : filterID / groupID / subGroupID / keyword
// }

class GroupModel {
  final bool sectionIsOn;
  final String firstKeyID;
  final FilterModel secondKeywords;

  GroupModel({
    @required this.sectionIsOn,
    @required this.firstKeyID, // groupID or keywordID will see
    this.secondKeywords, // if null, we go directly to KeywordFlyersPage
  });
// -----------------------------------------------------------------------------
  static List<GroupModel> getGroupsBySection({BuildContext context, Section section}){
    List<GroupModel> _groups = new List();

    List<GroupModel> _groupsBySection =
    section == Section.NewProperties ? GroupModel.propertiesGroups() :
    section == Section.ResaleProperties ? GroupModel.propertiesGroups() :
    section == Section.RentalProperties ? GroupModel.propertiesGroups() :

    section == Section.Designs ? GroupModel.designsGroups() :
    section == Section.Projects ? GroupModel.projectsGroups() :
    section == Section.Crafts ? GroupModel.craftsGroups(context) :

    section == Section.Products ? GroupModel.productsGroups() :
    section == Section.Equipment ? GroupModel.equipmentGroups() :

    [] ;


    return _groupsBySection;
}
// -----------------------------------------------------------------------------
  static String getGroupNameBySectionAndGroupModel({BuildContext context, Section section, GroupModel groupModel}){
    KeywordModel _keyword;
    String _nameInCurrentLang;

    /// where GroupModel.firstKeyword is keywordID
    if (section == Section.NewProperties ||
        section == Section.ResaleProperties ||
        section == Section.RentalProperties ||
        section == Section.Designs ||
        section == Section.Crafts
    ){
      _keyword = KeywordModel.getKeywordByKeywordID(groupModel?.firstKeyID);
      _nameInCurrentLang = Name.getNameWithCurrentLanguageFromListOfNames(context, _keyword.names);
    }

    else if (section == Section.Products){
      /// where GroupModel.firstKeyword is groupID
      _nameInCurrentLang = getGroupNameByGroupID(context, groupModel?.firstKeyID);
    }

    else {
      // nothing
    }

    return _nameInCurrentLang;
  }
// -----------------------------------------------------------------------------
  static String getSubGroupNameByKeywordID(BuildContext context, String keywordID){
    KeywordModel _keyword = KeywordModel.getKeywordByKeywordID(keywordID);

    Namez _names = KeywordModel.allSubGroupsNamez().firstWhere((name) => name.id == _keyword.subGroupID, orElse: () => null);

    String _nameInCurrentLang = Name.getNameWithCurrentLanguageFromListOfNames(context, _names.names);

    return _nameInCurrentLang;
  }
// -----------------------------------------------------------------------------
  static String getGroupNameByGroupID(BuildContext context, String groupID){
    Namez _names = KeywordModel.allGroupsNamez().firstWhere((name) => name.id == groupID, orElse: () => null);
    String _nameInCurrentLang = Name.getNameWithCurrentLanguageFromListOfNames(context, _names?.names);
    return _nameInCurrentLang;
  }
// -----------------------------------------------------------------------------
  static bool groupsContainThisFirstKeyID({BuildContext context, List<GroupModel> groups, String firstKeyID}){
    bool _groupsContainThisFirstKeyID = false;

    for(GroupModel group in groups){

      if(_groupsContainThisFirstKeyID = true){
        break;
      }

      else {

        if(group.firstKeyID == firstKeyID){
          _groupsContainThisFirstKeyID = true;
        }

      }

    }

    return _groupsContainThisFirstKeyID;
  }
// -----------------------------------------------------------------------------
  static bool groupSecondKeysAreZoneAreas(GroupModel group){
    List<String> _groupsUsingZoneAreasAsSecondKeywords = <String>[
      'con_trade_carpentry',
      'con_trade_electricity',
      'con_trade_insulation',
      'con_trade_masonry',
      'con_trade_plumbing',
      'con_trade_blacksmithing',
      'con_trade_labor',
      'con_trade_painting',
      'con_trade_plaster',
      'con_trade_landscape',
      'con_trade_hardscape',
      'con_trade_hvac',
      'con_trade_firefighting',
      'con_trade_elevators',
      'con_trade_tiling',
      'con_trade_transportation',
      'con_trade_concrete',
    ];

    bool _groupSecondKeysAreZoneAreas = false;

    if (_groupsUsingZoneAreasAsSecondKeywords.contains(group.firstKeyID)){
      _groupSecondKeysAreZoneAreas = true;
    }

    return _groupSecondKeysAreZoneAreas;
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> propertiesGroups(){
    return
      <GroupModel>[
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_apartment', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_furnishedApartment', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_loft', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_penthouse', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_chalet', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_twinhouse', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_bungalow', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_villa', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_condo', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_farm', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_townHome', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_sharedRoom', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_duplix', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_hotelApartment', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_studio', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_store', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_supermarket', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_warehouse', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_hall', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_bank', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_restaurant', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_pharmacy', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_studio', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_factory', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_office', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_school', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_hotel', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_football', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_tennis', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_basketball', secondKeywords: null),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_gym', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_gallery', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_theatre', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'space_spa', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pt_clinic', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'pf_building', secondKeywords: FilterModel.propertyLicenseFilter),
      ];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> designsGroups(){
    return
      <GroupModel>[
        GroupModel(sectionIsOn: true, firstKeyID: 'designType_architecture', secondKeywords: FilterModel.propertyLicenseFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'designType_interior', secondKeywords: FilterModel.spaceTypeFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'designType_facade', secondKeywords: FilterModel.propertyLicenseFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'designType_urban', secondKeywords: FilterModel.propertyLicenseFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'designType_landscape', secondKeywords: FilterModel.propertyAreaFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'designType_structural', secondKeywords: FilterModel.propertyLicenseFilter),
        GroupModel(sectionIsOn: true, firstKeyID: 'designType_kiosk', secondKeywords: FilterModel.kioskTypeFilter),
      ];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> projectsGroups(){
    return
    <GroupModel>[];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> craftsGroups(BuildContext context){
    return
      <GroupModel>[
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_carpentry', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_electricity', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_insulation', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_masonry', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_plumbing', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_blacksmithing', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_labor', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_painting', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_plaster', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_landscape', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_hardscape', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_hvac', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_firefighting', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_elevators', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_tiling', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_transportation', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
        GroupModel(sectionIsOn: true, firstKeyID: 'con_trade_concrete', secondKeywords: FilterModel.zoneAreasAsFilter(context)),
      ];
  }
// -----------------------------------------------------------------------------
  static List<GroupModel> productsGroups(){
    return
    <GroupModel>[
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_walls', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_floors', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_structure', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_fireFighting', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_safety', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_stairs', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_roofing', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_doors', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_landscape', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_hvac', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_plumbing', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_lighting', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_electricity', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_security', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_poolSpa', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_smartHome', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_furniture', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_appliances', secondKeywords: null),
      GroupModel(sectionIsOn: true, firstKeyID: 'group_prd_materials', secondKeywords: null),
    ];
    }
// -----------------------------------------------------------------------------
  static List<GroupModel> equipmentGroups(){
    return
        <GroupModel>[
          GroupModel(sectionIsOn: true, firstKeyID: 'group_equip_handheld', secondKeywords: null),
          GroupModel(sectionIsOn: true, firstKeyID: 'group_equip_handling', secondKeywords: null),
          GroupModel(sectionIsOn: true, firstKeyID: 'group_equip_heavy', secondKeywords: null),
          GroupModel(sectionIsOn: true, firstKeyID: 'group_equip_prep', secondKeywords: null),
          GroupModel(sectionIsOn: true, firstKeyID: 'group_equip_vehicle', secondKeywords: null),
        ];
  }
// -----------------------------------------------------------------------------
}




