// import 'package:bldrs/a_models/keywords/keyword_model.dart';
// import 'package:bldrs/a_models/helpers/phrase_model.dart';
// import 'package:bldrs/a_models/keywords/section_class.dart';
// import 'package:bldrs/a_models/keywords/group_model.dart';
// import 'package:flutter/cupertino.dart';
//
// enum SequenceType{
//   byKeyID, // for intersecting data structure : keyword 1 + keyword 2
//   byGroupID, // for straight data structure : sequenceID / groupID / subGroupID / keyword
// }
//
// /// is a subgroup of a section "flyer type",
// class Sequence {
//   final String titleID;
//   final SequenceType sequenceType;
//   final bool isActive;
//   final GroupModel secondKeywords;
//
//   const Sequence({
//     @required this.titleID,
//     @required this.sequenceType,
//     @required this.isActive,
//     this.secondKeywords, // if null, we go directly to KeywordFlyersPage
//   });
// // -----------------------------------------------------------------------------
//   static String getSequenceImage(String id){
//     final String _path = 'assets/keywords/$id.jpg';
//     return _path;
//   }
// // -----------------------------------------------------------------------------
//   static List<Sequence> getActiveSequencesBySection({BuildContext context, Section section}){
//
//     final List<Sequence> _sequencesBySection =
//     section == Section.NewProperties ? Sequence.propertiesSequences(context) :
//     section == Section.ResaleProperties ? Sequence.propertiesSequences(context) :
//     section == Section.RentalProperties ? Sequence.propertiesSequences(context) :
//
//     section == Section.Designs ? Sequence.designsSequences() :
//     section == Section.Projects ? Sequence.projectsSequences() :
//     section == Section.Crafts ? Sequence.craftsSequences(context) :
//
//     section == Section.Products ? Sequence.productsSequence() :
//     section == Section.Equipment ? Sequence.equipmentSequences() :
//
//     <Sequence>[] ;
//
//     final List<Sequence> _activeSequences = <Sequence>[];
//
//     _sequencesBySection.forEach((sequence) {
//       if(sequence.isActive == true){
//         _activeSequences.add(sequence);
//       }
//     });
//
//     return _activeSequences;
// }
// // -----------------------------------------------------------------------------
//   static String getSequenceNameBySequenceAndSection({BuildContext context, Section section, Sequence sequence}){
//     Keyword _keyword;
//     String _nameInCurrentLang;
//
//     /// where GroupModel.firstKeyword is keywordID
//     if (section == Section.NewProperties ||
//         section == Section.ResaleProperties ||
//         section == Section.RentalProperties ||
//         section == Section.Designs ||
//         section == Section.Crafts
//     ){
//       _keyword = Keyword.getKeywordByKeywordID(sequence?.titleID);
//       _nameInCurrentLang = Name.getNameByCurrentLingoFromNames(context, _keyword.names);
//     }
//
//     else if (section == Section.Products){
//       /// where GroupModel.firstKeyword is groupID
//       _nameInCurrentLang = Keyword.getGroupNameInCurrentLingoByGroupID(context, sequence?.titleID);
//     }
//
//     else {
//       // nothing
//     }
//
//     return _nameInCurrentLang;
//   }
// // -----------------------------------------------------------------------------
//   static bool sequencesContainThisFirstKeyID({BuildContext context, List<Sequence> sequences, String firstKeyID}){
//     bool _sequenceContainThisFirstKeyID = false;
//
//     for(Sequence sequence in sequences){
//
//       if(_sequenceContainThisFirstKeyID = true){
//         break;
//       }
//
//       else {
//
//         if(sequence.titleID == firstKeyID){
//           _sequenceContainThisFirstKeyID = true;
//         }
//
//       }
//
//     }
//
//     return _sequenceContainThisFirstKeyID;
//   }
// // -----------------------------------------------------------------------------
//   static bool sequenceSecondKeysAreZoneDistricts(Sequence group){
//     const List<String> _sequencesFirstKeyIDsUsingZoneDistrictsAsSecondKeywords = const <String>[
//       'con_trade_carpentry',
//       'con_trade_electricity',
//       'con_trade_insulation',
//       'con_trade_masonry',
//       'con_trade_plumbing',
//       'con_trade_blacksmithing',
//       'con_trade_labor',
//       'con_trade_painting',
//       'con_trade_plaster',
//       'con_trade_landscape',
//       'con_trade_hardscape',
//       'con_trade_hvac',
//       'con_trade_firefighting',
//       'con_trade_elevators',
//       'con_trade_tiling',
//       'con_trade_transportation',
//       'con_trade_concrete',
//     ];
//
//     bool _groupSecondKeysAreZoneDistricts = false;
//
//     if (_sequencesFirstKeyIDsUsingZoneDistrictsAsSecondKeywords.contains(group.titleID)){
//       _groupSecondKeysAreZoneDistricts = true;
//     }
//
//     return _groupSecondKeysAreZoneDistricts;
//   }
// // -----------------------------------------------------------------------------
//   static List<Sequence> propertiesSequences(BuildContext context){
//     return
//       <Sequence>[
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_apartment', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_furnishedApartment', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_loft', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_penthouse', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_chalet', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_twinhouse', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_bungalow', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_villa', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_condo', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_farm', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_townHome', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_sharedRoom', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_duplix', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_hotelApartment', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_studio', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_store', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_supermarket', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_warehouse', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_hall', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_bank', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_restaurant', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_pharmacy', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_studio', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_factory', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_office', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_school', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_hotel', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_football', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_tennis', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_basketball', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_gym', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_gallery', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_theatre', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'space_spa', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pt_clinic', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'pf_building', secondKeywords: GroupModel.propertyLicenseGroup),
//       ];
//   }
// // -----------------------------------------------------------------------------
//   static List<Sequence> designsSequences(){
//     return
//       <Sequence>[
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'designType_architecture', secondKeywords: GroupModel.propertyLicenseGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'designType_interior', secondKeywords: GroupModel.spaceTypeGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'designType_facade', secondKeywords: GroupModel.propertyLicenseGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'designType_urban', secondKeywords: GroupModel.propertyLicenseGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'designType_landscape', secondKeywords: GroupModel.propertyAreaGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'designType_structural', secondKeywords: GroupModel.propertyLicenseGroup),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'designType_kiosk', secondKeywords: GroupModel.kioskTypeGroup),
//       ];
//   }
// // -----------------------------------------------------------------------------
//   static List<Sequence> projectsSequences(){
//     return
//     <Sequence>[];
//   }
// // -----------------------------------------------------------------------------
//   static List<Sequence> craftsSequences(BuildContext context){
//     return
//       <Sequence>[
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_carpentry', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_electricity', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_insulation', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_masonry', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_plumbing', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_blacksmithing', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_labor', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_painting', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_plaster', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_landscape', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_hardscape', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_hvac', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_firefighting', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: false, titleID: 'con_trade_elevators', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_tiling', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_transportation', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//         Sequence(sequenceType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_concrete', secondKeywords: GroupModel.zoneDistrictsAsGroup(context)),
//       ];
//   }
// // -----------------------------------------------------------------------------
//   static List<Sequence> productsSequence(){
//     return
//     <Sequence>[
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_walls', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_floors', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_structure', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_fireFighting', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_safety', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_stairs', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_roofing', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_doors', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_landscape', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_hvac', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_plumbing', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_lighting', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_electricity', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_security', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_poolSpa', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_smartHome', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_furniture', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_appliances', secondKeywords: null),
//       Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_materials', secondKeywords: null),
//     ];
//     }
// // -----------------------------------------------------------------------------
//   static List<Sequence> equipmentSequences(){
//     return
//         <Sequence>[
//           Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_equip_handheld', secondKeywords: null),
//           Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_equip_handling', secondKeywords: null),
//           Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_equip_heavy', secondKeywords: null),
//           Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_equip_prep', secondKeywords: null),
//           Sequence(sequenceType: SequenceType.byGroupID, isActive: true, titleID: 'group_equip_vehicle', secondKeywords: null),
//         ];
//   }
// // -----------------------------------------------------------------------------
// }
//
//
//
//
