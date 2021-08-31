import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/keywords/groups.dart';
import 'package:flutter/cupertino.dart';

enum SequenceType{
  byKeyID, // for intersecting data structure : keyword 1 + keyword 2
  byGroupID, // for straight data structure : filterID / groupID / subGroupID / keyword
}

class Sequence {
  final String titleID;
  final SequenceType idType;
  final bool isActive;
  final Group secondKeywords;

  Sequence({
    @required this.titleID,
    @required this.idType,
    @required this.isActive,
    this.secondKeywords, // if null, we go directly to KeywordFlyersPage
  });
// -----------------------------------------------------------------------------
  static String getSequenceImage(String id){
    String _path = 'assets/keywords/$id.jpg';

    return _path;
  }
// -----------------------------------------------------------------------------
  static List<Sequence> getActiveSequencesBySection({BuildContext context, Section section}){

    List<Sequence> _sequencesBySection =
    section == Section.NewProperties ? Sequence.propertiesSequences(context) :
    section == Section.ResaleProperties ? Sequence.propertiesSequences(context) :
    section == Section.RentalProperties ? Sequence.propertiesSequences(context) :

    section == Section.Designs ? Sequence.designsSequences() :
    section == Section.Projects ? Sequence.projectsSequences() :
    section == Section.Crafts ? Sequence.craftsSequences(context) :

    section == Section.Products ? Sequence.productsSequence() :
    section == Section.Equipment ? Sequence.equipmentSequences() :

    [] ;

    List<Sequence> _activeSequences = [];

    _sequencesBySection.forEach((sequence) {
      if(sequence.isActive == true){
        _activeSequences.add(sequence);
      }
    });
    
    return _activeSequences;
}
// -----------------------------------------------------------------------------
  static String getSequenceNameBySequenceAndSection({BuildContext context, Section section, Sequence sequence}){
    Keyword _keyword;
    String _nameInCurrentLang;

    /// where GroupModel.firstKeyword is keywordID
    if (section == Section.NewProperties ||
        section == Section.ResaleProperties ||
        section == Section.RentalProperties ||
        section == Section.Designs ||
        section == Section.Crafts
    ){
      _keyword = Keyword.getKeywordByKeywordID(sequence?.titleID);
      _nameInCurrentLang = Name.getNameByCurrentLingoFromNames(context, _keyword.names);
    }

    else if (section == Section.Products){
      /// where GroupModel.firstKeyword is groupID
      _nameInCurrentLang = Keyword.getGroupNameInCurrentLingoByGroupID(context, sequence?.titleID);
    }

    else {
      // nothing
    }

    return _nameInCurrentLang;
  }
// -----------------------------------------------------------------------------
  static bool sequencesContainThisFirstKeyID({BuildContext context, List<Sequence> sequences, String firstKeyID}){
    bool _sequenceContainThisFirstKeyID = false;

    for(Sequence sequence in sequences){

      if(_sequenceContainThisFirstKeyID = true){
        break;
      }

      else {

        if(sequence.titleID == firstKeyID){
          _sequenceContainThisFirstKeyID = true;
        }

      }

    }

    return _sequenceContainThisFirstKeyID;
  }
// -----------------------------------------------------------------------------
  static bool sequenceSecondKeysAreZoneDistricts(Sequence group){
    List<String> _sequencesFirstKeyIDsUsingZoneDistrictsAsSecondKeywords = <String>[
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

    bool _groupSecondKeysAreZoneDistricts = false;

    if (_sequencesFirstKeyIDsUsingZoneDistrictsAsSecondKeywords.contains(group.titleID)){
      _groupSecondKeysAreZoneDistricts = true;
    }

    return _groupSecondKeysAreZoneDistricts;
  }
// -----------------------------------------------------------------------------
  static List<Sequence> propertiesSequences(BuildContext context){
    return
      <Sequence>[
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_apartment', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_furnishedApartment', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_loft', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_penthouse', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_chalet', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_twinhouse', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_bungalow', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_villa', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_condo', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_farm', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_townHome', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_sharedRoom', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_duplix', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_hotelApartment', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_studio', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_store', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_supermarket', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_warehouse', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_hall', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_bank', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_restaurant', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_pharmacy', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_studio', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_factory', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_office', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_school', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_hotel', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_football', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_tennis', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_basketball', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_gym', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_gallery', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_theatre', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'space_spa', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pt_clinic', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'pf_building', secondKeywords: Group.propertyLicenseGroup),
      ];
  }
// -----------------------------------------------------------------------------
  static List<Sequence> designsSequences(){
    return
      <Sequence>[
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'designType_architecture', secondKeywords: Group.propertyLicenseGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'designType_interior', secondKeywords: Group.spaceTypeGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'designType_facade', secondKeywords: Group.propertyLicenseGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'designType_urban', secondKeywords: Group.propertyLicenseGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'designType_landscape', secondKeywords: Group.propertyAreaGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'designType_structural', secondKeywords: Group.propertyLicenseGroup),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'designType_kiosk', secondKeywords: Group.kioskTypeGroup),
      ];
  }
// -----------------------------------------------------------------------------
  static List<Sequence> projectsSequences(){
    return
    <Sequence>[];
  }
// -----------------------------------------------------------------------------
  static List<Sequence> craftsSequences(BuildContext context){
    return
      <Sequence>[
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_carpentry', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_electricity', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_insulation', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_masonry', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_plumbing', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_blacksmithing', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_labor', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_painting', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_plaster', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_landscape', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_hardscape', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_hvac', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_firefighting', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: false, titleID: 'con_trade_elevators', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_tiling', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_transportation', secondKeywords: Group.zoneDistrictsAsGroup(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, titleID: 'con_trade_concrete', secondKeywords: Group.zoneDistrictsAsGroup(context)),
      ];
  }
// -----------------------------------------------------------------------------
  static List<Sequence> productsSequence(){
    return
    <Sequence>[
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_walls', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_floors', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_structure', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_fireFighting', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_safety', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_stairs', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_roofing', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_doors', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_landscape', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_hvac', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_plumbing', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_lighting', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_electricity', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_security', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_poolSpa', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_smartHome', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_furniture', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_appliances', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_prd_materials', secondKeywords: null),
    ];
    }
// -----------------------------------------------------------------------------
  static List<Sequence> equipmentSequences(){
    return
        <Sequence>[
          Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_equip_handheld', secondKeywords: null),
          Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_equip_handling', secondKeywords: null),
          Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_equip_heavy', secondKeywords: null),
          Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_equip_prep', secondKeywords: null),
          Sequence(idType: SequenceType.byGroupID, isActive: true, titleID: 'group_equip_vehicle', secondKeywords: null),
        ];
  }
// -----------------------------------------------------------------------------
}




