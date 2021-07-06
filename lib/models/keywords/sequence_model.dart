import 'package:bldrs/models/keywords/keyword_model.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:flutter/cupertino.dart';

enum SequenceType{
  byKeyID, // for intersecting data structure : keyword 1 + keyword 2
  byGroupID, // for straight data structure : filterID / groupID / subGroupID / keyword
}

class Sequence {
  final String id;
  final SequenceType idType;
  final bool isActive;
  final FilterModel secondKeywords;

  Sequence({
    @required this.id,
    @required this.idType,
    @required this.isActive,
    this.secondKeywords, // if null, we go directly to KeywordFlyersPage
  });
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

    List<Sequence> _activeSequences = new List();

    _sequencesBySection.forEach((sequence) {
      if(sequence.isActive == true){
        _activeSequences.add(sequence);
      }
    });
    
    return _activeSequences;
}
// -----------------------------------------------------------------------------
  static String getSequenceNameBySequenceAndSection({BuildContext context, Section section, Sequence sequence}){
    KeywordModel _keyword;
    String _nameInCurrentLang;

    /// where GroupModel.firstKeyword is keywordID
    if (section == Section.NewProperties ||
        section == Section.ResaleProperties ||
        section == Section.RentalProperties ||
        section == Section.Designs ||
        section == Section.Crafts
    ){
      _keyword = KeywordModel.getKeywordByKeywordID(sequence?.id);
      _nameInCurrentLang = Name.getNameWithCurrentLanguageFromListOfNames(context, _keyword.names);
    }

    else if (section == Section.Products){
      /// where GroupModel.firstKeyword is groupID
      _nameInCurrentLang = KeywordModel.getGroupNameByGroupID(context, sequence?.id);
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

        if(sequence.id == firstKeyID){
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

    if (_sequencesFirstKeyIDsUsingZoneDistrictsAsSecondKeywords.contains(group.id)){
      _groupSecondKeysAreZoneDistricts = true;
    }

    return _groupSecondKeysAreZoneDistricts;
  }
// -----------------------------------------------------------------------------
  static List<Sequence> propertiesSequences(BuildContext context){
    return
      <Sequence>[
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_apartment', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_furnishedApartment', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_loft', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_penthouse', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_chalet', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_twinhouse', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_bungalow', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_villa', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_condo', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_farm', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_townHome', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_sharedRoom', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_duplix', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_hotelApartment', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_studio', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_store', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_supermarket', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_warehouse', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_hall', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_bank', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_restaurant', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_pharmacy', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_studio', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_factory', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_office', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_school', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_hotel', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_football', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_tennis', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_basketball', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_gym', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_gallery', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_theatre', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'space_spa', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pt_clinic', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'pf_building', secondKeywords: FilterModel.propertyLicenseFilter),
      ];
  }
// -----------------------------------------------------------------------------
  static List<Sequence> designsSequences(){
    return
      <Sequence>[
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'designType_architecture', secondKeywords: FilterModel.propertyLicenseFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'designType_interior', secondKeywords: FilterModel.spaceTypeFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'designType_facade', secondKeywords: FilterModel.propertyLicenseFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'designType_urban', secondKeywords: FilterModel.propertyLicenseFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'designType_landscape', secondKeywords: FilterModel.propertyAreaFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'designType_structural', secondKeywords: FilterModel.propertyLicenseFilter),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'designType_kiosk', secondKeywords: FilterModel.kioskTypeFilter),
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
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_carpentry', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_electricity', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_insulation', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_masonry', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_plumbing', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_blacksmithing', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_labor', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_painting', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_plaster', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_landscape', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_hardscape', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_hvac', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_firefighting', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: false, id: 'con_trade_elevators', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_tiling', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_transportation', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
        Sequence(idType: SequenceType.byKeyID, isActive: true, id: 'con_trade_concrete', secondKeywords: FilterModel.zoneDistrictsAsFilter(context)),
      ];
  }
// -----------------------------------------------------------------------------
  static List<Sequence> productsSequence(){
    return
    <Sequence>[
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_walls', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_floors', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_structure', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_fireFighting', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_safety', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_stairs', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_roofing', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_doors', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_landscape', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_hvac', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_plumbing', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_lighting', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_electricity', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_security', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_poolSpa', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_smartHome', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_furniture', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_appliances', secondKeywords: null),
      Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_prd_materials', secondKeywords: null),
    ];
    }
// -----------------------------------------------------------------------------
  static List<Sequence> equipmentSequences(){
    return
        <Sequence>[
          Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_equip_handheld', secondKeywords: null),
          Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_equip_handling', secondKeywords: null),
          Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_equip_heavy', secondKeywords: null),
          Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_equip_prep', secondKeywords: null),
          Sequence(idType: SequenceType.byGroupID, isActive: true, id: 'group_equip_vehicle', secondKeywords: null),
        ];
  }
// -----------------------------------------------------------------------------
}




