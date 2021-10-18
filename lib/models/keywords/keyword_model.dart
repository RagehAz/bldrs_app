import 'package:bldrs/controllers/localization/lingo.dart';
import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/models/keywords/group_model.dart';
import 'package:bldrs/models/keywords/sequence_model.dart';
import 'package:bldrs/models/zone/district_model.dart';
import 'package:bldrs/models/helpers/namez_model.dart';
import 'package:bldrs/models/keywords/section_class.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Keyword {
  final String keywordID;
  final FlyerType flyerType;
  final String groupID;
  final String subGroupID;
  final int uses;
  final List<Name> names;

  const Keyword({
    @required this.keywordID,
    @required this.flyerType,
    @required this.groupID,
    @required this.subGroupID,
    @required this.uses,
    this.names,
});

  void printKeyword({String methodName = 'PRINTING KEYWORD'}){

    print('$methodName ------------------------------- START');

    print('keywordID : ${keywordID}');
    print('flyerType : ${flyerType}');
    print('groupID : ${groupID}');
    print('subGroupID : ${subGroupID}');
    print('uses : ${uses}');
    print('names : ${names}');

    print('${methodName} ------------------------------- END');
  }

// -----------------------------------------------------------------------------
  static String getKeywordArabicName(Keyword keyword){
    List<Name> _names = keyword.names;

    final Name _arabicName = _names.firstWhere((name) => name.code == Lingo.arabicLingo.code, orElse: () => null);
    final String _name = _arabicName == null ? null : _arabicName.value;

    return _name;
  }
// -----------------------------------------------------------------------------
//   static Map<String, dynamic> cipherKeyword(Keyword keyword){
//     Map<String, dynamic> _map;
//
//     if(keyword != null){
//       _map = {
//         'keywordID': keyword.keywordID,
//         'flyerType': FlyerTypeClass.cipherFlyerType(keyword.flyerType),
//         'groupID': keyword.groupID,
//         'subGroupID': keyword.subGroupID,
//         'uses': keyword.uses,
//         'names': Name.cipherNamezz(keyword.names),
//       };
//
//     }
//
//     return _map;
//   }
// -----------------------------------------------------------------------------
  static List<String> cipherKeywordsToKeywordsIds(List<Keyword> keywords){
    final List<String> _ids = <String>[];

    if (keywords != null){
      if (keywords.length != 0){
        for (var keyword in keywords){

          _ids.add(keyword.keywordID);
        }
      }
    }

    return _ids;
  }
// -----------------------------------------------------------------------------
//   static Keyword decipherKeyword(Map<String, dynamic> map){
//     Keyword _keyword;
//
//     if (map != null){
//       _keyword = Keyword(
//         flyerType: FlyerTypeClass.decipherFlyerType(map['flyerType']),
//         groupID: map['groupID'],
//         keywordID: map['keywordID'],
//         subGroupID: map['subGroupID'],
//         uses: map['uses'],
//         names: Name.decipherNamezzMaps(map['names']),
//       );
//     }
//
//     return _keyword;
//   }
// -----------------------------------------------------------------------------
  static List<Keyword> decipherKeywordsIDsToKeywords(List<dynamic> ids){
    final List<Keyword> _keywords = <Keyword>[];

    if (ids != null){
      if(ids.length != null){
        for (var id in ids){

          final Keyword _keyword = Keyword.getKeywordByKeywordID(id);

          if(_keyword != null){
            _keywords.add(_keyword);
          }

        }
      }
    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static String getImagePath(Keyword keyword){
    final String _keywordID = keyword.keywordID;
    String _path;

    if(isIconless(keyword) == true){
      // path will be null
    }

    else {
      _path = 'assets/keywords/$_keywordID.jpg';
    }

    return _path;
  }
// -----------------------------------------------------------------------------
  static bool KeywordsAreTheSame(Keyword _firstKeyword, Keyword _secondKeyword){
    final bool _keywordsAreTheSame =
        _firstKeyword == null || _secondKeyword == null ? false
        :
        _firstKeyword.flyerType == _secondKeyword.flyerType &&
        // _firstKeyword.name == _secondKeyword.name &&
        _firstKeyword.keywordID == _secondKeyword.keywordID &&
        _firstKeyword.groupID == _secondKeyword.groupID &&
        _firstKeyword.subGroupID == _secondKeyword.subGroupID &&
        _firstKeyword.uses == _secondKeyword.uses ?
            true : false;

    return _keywordsAreTheSame;
  }
// -----------------------------------------------------------------------------
  static bool KeywordsListsAreTheSame(List<Keyword> listA, List<Keyword> listB){
    bool _same;

    if(listA != null && listB != null){
      if (listA.length == listB.length){
        for (int i = 0; i < listA.length; i++){

          if (KeywordsAreTheSame(listA[i], listB[i]) == true){
            _same = true;
          }
          else {
            _same = false;
            break;
          }
        }
      }
    }

    return _same;
  }
// -----------------------------------------------------------------------------
  static bool isIconless(Keyword keywordModel){
    final bool _isIconless =
    keywordModel.groupID == 'numberOfRooms' ? true :
    keywordModel.groupID == 'numberOfBathrooms' ? true :
    keywordModel.groupID == 'parkingLots' ? true :
    keywordModel.groupID == 'group_ppt_area' ? true :
    keywordModel.groupID == 'group_ppt_features' ? true :
    keywordModel.groupID == 'group_ppt_license' ? true :
    keywordModel.groupID == 'group_ppt_price' ? true :
    keywordModel.groupID == 'group_ppt_spaces' ? true :
    keywordModel.groupID == 'group_prd_price' ? true :
    keywordModel.groupID == 'lotArea' ? true :
    keywordModel.groupID == 'inCompound' ? true :
    keywordModel.groupID == 'numberOfFloor' ? true :
    keywordModel.groupID == 'buildingAge' ? true :
    keywordModel.groupID == 'group_dz_kioskType' ? true : /// TASK : this is temp until i add kiosk types images
    false;

    return _isIconless;
  }
// -----------------------------------------------------------------------------
  static bool keywordsContainThisFlyerType({List<Keyword> keywords, FlyerType flyerType}){

    bool _keywordsContainThisFlyerType = false;

    keywords.forEach((keyword) {
      if(keyword.flyerType == flyerType){
        _keywordsContainThisFlyerType = true;
      }
    });

    return _keywordsContainThisFlyerType;
  }
// -----------------------------------------------------------------------------
  static bool keywordsContainThisGroupID({List<Keyword> keywords, String groupID}){
    bool _keywordsHaveIt = false;

    if (keywords != null && groupID != null){
      if(keywords.length != 0){

        // for

        for (Keyword keyword in keywords){
          if(keyword.groupID == groupID){
            _keywordsHaveIt = true;
            break;
          }
        }
      }
    }

    return _keywordsHaveIt;
  }
// -----------------------------------------------------------------------------
  static bool keywordsContainThisKeyword({List<Keyword> keywords, Keyword keyword}){
    bool _wordIsSelected = false;

    if (keywords != null){
      if(keywords.length != 0){
        _wordIsSelected = keywords.contains(keyword) == true ? true : false;
      }
    }

    return _wordIsSelected;
  }
// -----------------------------------------------------------------------------
  static String translateKeyword(BuildContext context, String id){
    String _keywordName;
    Keyword _keywordModel;

    final List<Keyword> _allKeywords = bldrsKeywords();

    final Keyword _resultIfSearchedByGroup = _allKeywords.firstWhere((keyword) => keyword.groupID == id, orElse: ()=> null);

    if (_resultIfSearchedByGroup == null){
      /// so given id is not GroupID but keywordID
      _keywordModel = _allKeywords.firstWhere((keyword) => keyword.keywordID == id, orElse: ()=> null);
      _keywordName = Name.getNameByCurrentLingoFromNames(context, _keywordModel?.names);
    }

    else {
      _keywordModel = _resultIfSearchedByGroup;
      _keywordName = Keyword.getGroupNameInCurrentLingoByGroupID(context, _keywordModel?.groupID);
    }

    return _keywordName;
  }
// -----------------------------------------------------------------------------
  static String getTranslatedKeywordTitleBySequence(BuildContext context,Sequence sequence){

    String _title;

    if(sequence.idType == SequenceType.byGroupID){
      final String _groupID = sequence.titleID;
      final FlyerType _flyerType = Keyword.bldrsKeywords().firstWhere(
              (keyword) => keyword.groupID == _groupID, orElse: () => null).flyerType;

      if (_flyerType == FlyerType.product){
        _title = 'Product Type';
      }

      else if (_flyerType == FlyerType.equipment){
        _title = 'Equipment type';
      }

      else {
        _title = '${Keyword.getGroupNameInCurrentLingoByGroupID(context, _groupID)}';
      }

    }

    else {
      final String _keywordID = sequence.titleID;
      final Keyword _keyword = Keyword.getKeywordByKeywordID(_keywordID);

      _title = Keyword.getGroupNameInCurrentLingoByGroupID(context, _keyword.groupID);
    }

    return _title;
  }
// =============================================================================

  /// GET KEYWORDS

// ------------------o
  /// this is weird, I don't know why I wrote it
  static List<Keyword> getKeywordsByGroupIDFomGroup({GroupModel group, String groupID}){
    final List<Keyword> _keywords = <Keyword>[];

    group.keywords.forEach((keyword) {
      if(!_keywords.contains(keyword) && keyword.groupID == groupID){
        _keywords.add(keyword);
      }
    });

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> getKeywordsBySubGroupIDFromKeywords({List<Keyword>keywords, String subGroupID}){
    final List<Keyword> _keywords = <Keyword>[];

    for (Keyword keyword in keywords){
      if(keyword.subGroupID == subGroupID){
        _keywords.add(keyword);
      }
    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> getKeywordsBySection(Section section){
    final List<Keyword> _keywords = <Keyword>[];

    final FlyerType _flyerType = FlyerTypeClass.getFlyerTypeBySection(section: section);

    bldrsKeywords().forEach((keyword) {
      if (keyword.flyerType == _flyerType){
        _keywords.add(keyword);
      }
    });

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> getKeywordsByFlyerType(FlyerType flyerType){
    final List<Keyword> _keywords = <Keyword>[];

    bldrsKeywords().forEach((keyword) {
      if (keyword.flyerType == flyerType){
        _keywords.add(keyword);
      }
    });

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> getKeywordsByGroupID(String groupID){
    final List<Keyword> _keywords = <Keyword>[];

    bldrsKeywords().forEach((keyword) {
      if (keyword.groupID == groupID){
        _keywords.add(keyword);
      }
    });

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> getKeywordsBySubGroupID(String subGroupID){
    final List<Keyword> _keywords = <Keyword>[];

    bldrsKeywords().forEach((keyword) {
      if (keyword.subGroupID == subGroupID){
        _keywords.add(keyword);
      }
    });

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static Keyword getKeywordByKeywordID(String keywordID){
    final Keyword _keyword = bldrsKeywords().firstWhere((keyword) => keyword.keywordID == keywordID, orElse: () => null);
    return
      _keyword;
  }
// -----------------------------------------------------------------------------
  static String getKeywordNameByKeywordID(BuildContext context, String keywordID){
    final Keyword _keyword = getKeywordByKeywordID(keywordID);

    final String _nameWithCurrentLanguage = Name.getNameByCurrentLingoFromNames(context, _keyword?.names);
    return _nameWithCurrentLanguage;
  }
// -----------------------------------------------------------------------------
  static Keyword getKeywordModelFromDistrict(DistrictModel district){

    final Keyword _keywordModel = Keyword(
      keywordID: district.districtID,
      flyerType: FlyerType.non,
      groupID: district.countryID,
      subGroupID: district.cityID,
      // name: area.name,
      uses: 0,
    );

    return _keywordModel;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> getKeywordsModelsFromDistricts(List<DistrictModel> districts){
    final List<Keyword> _keywords = <Keyword>[];

    for (DistrictModel district in districts){
      _keywords.add(getKeywordModelFromDistrict(district));
    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<String> getKeywordsIDsFromKeywords(List<Keyword> keywords){
    final List<String> _keywordIDs = <String>[];

    keywords.forEach((key) {
      _keywordIDs.add(key.keywordID);
    });

    return _keywordIDs;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> getKeywordsByKeywordsIDs(List<String> keywordsIDs){
    final List<Keyword> _keywords = <Keyword>[];

    if (keywordsIDs != null && keywordsIDs.length != 0){

      for (String id in keywordsIDs){

        final _Keyword = getKeywordByKeywordID(id);

        if (_Keyword != null){
          _keywords.add(_Keyword);
        }
      }

    }

    return _keywords;
  }
// =============================================================================

  /// GET GROUPS

// ------------------o
  static List<String> getGroupsIDsFromGroup(GroupModel group){
    final List<String> _groupsIDs = <String>[];

    final List<Keyword> _keywords = group.keywords;

    _keywords.forEach((keyword) {

      final String _groupID = keyword.groupID;

      if(!_groupsIDs.contains(_groupID) && _groupID != ''){
        _groupsIDs.add(keyword.groupID);
      }
    });

    return _groupsIDs;
  }
// -----------------------------------------------------------------------------
  static List<String> getGroupsIDsByFlyerType(FlyerType flyerType){
    final List<String> _groupsIDs = <String>[];

    bldrsKeywords().forEach((keyword) {
      if (keyword.flyerType == flyerType && !_groupsIDs.contains(keyword.groupID)){
        _groupsIDs.add(keyword.groupID);
      }
    });

    return _groupsIDs;
  }
// -----------------------------------------------------------------------------
  static String getGroupNameInCurrentLingoByGroupID(BuildContext context, String groupID){
    final Namez _names = getGroupNamezByGroupID(groupID);
    final String _nameInCurrentLang = Name.getNameByCurrentLingoFromNames(context, _names?.names);
    return _nameInCurrentLang;
  }
// -----------------------------------------------------------------------------
  static Namez getGroupNamezByGroupID(String groupID){
    final Namez _namez = Keyword.allGroupsNamez().firstWhere((name) => name.id == groupID, orElse: () => null);
    return _namez;
  }
// -----------------------------------------------------------------------------
  static List<Namez> allGroupsNamez(){
    return
      const <Namez>[
        const Namez(id: 'group_prd_walls',names: <Name>[Name(code: 'en', value: 'Walls & Room Partitions'), Name(code: 'ar', value: 'حوائط و فواصل غرف')]),
        const Namez(id: 'group_prd_floors',names: <Name>[Name(code: 'en', value: 'Floors & ٍSkirting'), Name(code: 'ar', value: 'أرضيات و وزر')]),
        const Namez(id: 'group_prd_structure',names: <Name>[Name(code: 'en', value: 'Light Structures'), Name(code: 'ar', value: 'هياكل و منشآت خفيفة')]),
        const Namez(id: 'group_prd_fireFighting',names: <Name>[Name(code: 'en', value: 'Fire Fighting'), Name(code: 'ar', value: 'مقاومة حريق')]),
        const Namez(id: 'group_prd_safety',names: <Name>[Name(code: 'en', value: 'Safety'), Name(code: 'ar', value: 'أمن و سلامة')]),
        const Namez(id: 'group_prd_stairs',names: <Name>[Name(code: 'en', value: 'Stairs'), Name(code: 'ar', value: 'سلالم')]),
        const Namez(id: 'group_prd_roofing',names: <Name>[Name(code: 'en', value: 'Roofing'), Name(code: 'ar', value: 'أسطح')]),
        const Namez(id: 'group_prd_doors',names: <Name>[Name(code: 'en', value: 'Doors & Windows'), Name(code: 'ar', value: 'أبواب و شبابيك')]),
        const Namez(id: 'group_prd_landscape',names: <Name>[Name(code: 'en', value: 'Planting & Landscape'), Name(code: 'ar', value: 'زراعات و لاندسكيب')]),
        const Namez(id: 'group_prd_hvac',names: <Name>[Name(code: 'en', value: 'Heating Ventilation Air Conditioning'), Name(code: 'ar', value: 'تدفئة تهوية تكييف')]),
        const Namez(id: 'group_prd_plumbing',names: <Name>[Name(code: 'en', value: 'Plumbing & Sanitary ware'), Name(code: 'ar', value: 'سباكة و أدوات صحية')]),
        const Namez(id: 'group_prd_lighting',names: <Name>[Name(code: 'en', value: 'Lighting'), Name(code: 'ar', value: 'إضاءة')]),
        const Namez(id: 'group_prd_electricity',names: <Name>[Name(code: 'en', value: 'Electricity'), Name(code: 'ar', value: 'كهرباء')]),
        const Namez(id: 'group_prd_security',names: <Name>[Name(code: 'en', value: 'Security'), Name(code: 'ar', value: 'الحماية و الأمان')]),
        const Namez(id: 'group_prd_poolSpa',names: <Name>[Name(code: 'en', value: 'Pools & Spa'), Name(code: 'ar', value: 'حمامات سباحة و حمامات صحية')]),
        const Namez(id: 'group_prd_smartHome',names: <Name>[Name(code: 'en', value: 'Smart home'), Name(code: 'ar', value: 'تجهيزات المنازل الذكية')]),
        const Namez(id: 'group_prd_furniture',names: <Name>[Name(code: 'en', value: 'Furniture'), Name(code: 'ar', value: 'أثاث و مفروشات')]),
        const Namez(id: 'group_prd_appliances',names: <Name>[Name(code: 'en', value: 'Appliances'), Name(code: 'ar', value: 'أجهزة كهربائية')]),
        const Namez(id: 'group_prd_materials',names: <Name>[Name(code: 'en', value: 'Construction Materials'), Name(code: 'ar', value: 'مواد بناء')]),
        const Namez(id: 'group_equip_handheld',names: <Name>[Name(code: 'en', value: 'Handheld equipment & tools'), Name(code: 'ar', value: 'معدات و أدوات خفيفة')]),
        const Namez(id: 'group_equip_prep',names: <Name>[Name(code: 'en', value: 'Construction preparations'), Name(code: 'ar', value: 'تجهيزات الموقع')]),
        const Namez(id: 'group_equip_vehicle',names: <Name>[Name(code: 'en', value: 'Vehicles'), Name(code: 'ar', value: 'عربات')]),
        const Namez(id: 'group_equip_handling',names: <Name>[Name(code: 'en', value: 'Material handling equipment'), Name(code: 'ar', value: 'معدات نقل و تحميل')]),
        const Namez(id: 'group_equip_heavy',names: <Name>[Name(code: 'en', value: 'Heavy machinery'), Name(code: 'ar', value: 'معدات ثقيلة')]),
        const Namez(id: 'group_ppt_form',names: <Name>[Name(code: 'en', value: 'Property Form'), Name(code: 'ar', value: 'هيئة العقار')]),
        const Namez(id: 'group_ppt_type',names: <Name>[Name(code: 'en', value: 'Property Type'), Name(code: 'ar', value: 'نوع العقار')]),
        const Namez(id: 'group_ppt_area',names: <Name>[Name(code: 'en', value: 'Area'), Name(code: 'ar', value: 'المساحة')]),
        const Namez(id: 'group_ppt_spaces',names: <Name>[Name(code: 'en', value: 'Spaces'), Name(code: 'ar', value: 'مساحات العقار')]),
        const Namez(id: 'group_ppt_features',names: <Name>[Name(code: 'en', value: 'Property Features'), Name(code: 'ar', value: 'خواص العقار')]),
        const Namez(id: 'group_ppt_price',names: <Name>[Name(code: 'en', value: 'Property Price'), Name(code: 'ar', value: 'سعر العقار')]),
        const Namez(id: 'group_dz_type',names: <Name>[Name(code: 'en', value: 'Design Type'), Name(code: 'ar', value: 'نوع التصميم')]),
        const Namez(id: 'group_dz_style',names: <Name>[Name(code: 'en', value: 'Architectural Style'), Name(code: 'ar', value: 'الطراز المعماري')]),
        const Namez(id: 'group_craft_trade',names: <Name>[Name(code: 'en', value: 'Construction Trade'), Name(code: 'ar', value: 'الحرفة')]),
        const Namez(id: 'group_ppt_license',names: <Name>[Name(code: 'en', value: 'Property License'), Name(code: 'ar', value: 'رخصة العقار')]),
        const Namez(id: 'group_space_type',names: <Name>[Name(code: 'en', value: 'Space Type'), Name(code: 'ar', value: 'نوع الفراغ')]),
        const Namez(id: 'group_dz_kioskType',names: <Name>[Name(code: 'en', value: 'Kiosk Type'), Name(code: 'ar', value: 'نوع الكشك')]),
        const Namez(id: 'group_prd_price',names: <Name>[Name(code: 'en', value: 'Product Price'), Name(code: 'ar', value: 'سعر المنتج')]),
      ];
  }
// =============================================================================

/// GET SUBGROUPS

// ------------------o
  static String getSubGroupNameByKeywordID(BuildContext context, String keywordID){
    final Keyword _keyword = Keyword.getKeywordByKeywordID(keywordID);

    final Namez _names = Keyword.allSubGroupsNamez().firstWhere((name) => name.id == _keyword?.subGroupID, orElse: () => null);

    final String _nameInCurrentLang = Name.getNameByCurrentLingoFromNames(context, _names?.names);

    return _nameInCurrentLang;
  }
// -----------------------------------------------------------------------------
  static Namez getSubGroupNamezBySubGroupID({String subGroupID}){
    final Namez _namez = allSubGroupsNamez().firstWhere((namez) => namez.id == subGroupID, orElse: () => null);
    return _namez;
  }
// -----------------------------------------------------------------------------
  static String getSubGroupNameBySubGroupIDAndLingoCode({BuildContext context, String subGroupID, String lingoCode}){
    final Namez _namez = getSubGroupNamezBySubGroupID(subGroupID: subGroupID);
    final List<Name> _names = _namez?.names;

    final String _nameInLang = Name.getNameByLingoFromNames(lingoCode: lingoCode, names: _names);

    return _nameInLang;
  }
// -----------------------------------------------------------------------------
  static List<Namez> allSubGroupsNamez(){
    return
      const <Namez>[
        const Namez(id: 'sub_prd_walls_partitions',names: <Name>[Name(code: 'en', value: 'Room Partitions'), Name(code: 'ar', value: 'فواصل غرف')]),
        const Namez(id: 'sub_prd_walls_partitions',names: <Name>[Name(code: 'en', value: 'Room Partitions'), Name(code: 'ar', value: 'فواصل غرف')]),
        const Namez(id: 'sub_prd_walls_cladding',names: <Name>[Name(code: 'en', value: 'Wall Cladding'), Name(code: 'ar', value: 'تبليط و تجلاليد حوائط')]),
        const Namez(id: 'sub_prd_walls_moldings',names: <Name>[Name(code: 'en', value: 'Moldings & Millwork'), Name(code: 'ar', value: 'قوالب و عواميد')]),
        const Namez(id: 'sub_prd_walls_ceiling',names: <Name>[Name(code: 'en', value: 'Ceiling Cladding'), Name(code: 'ar', value: 'تجاليد أسقف')]),
        const Namez(id: 'sub_prd_floors_tiles',names: <Name>[Name(code: 'en', value: 'Floor Tiles'), Name(code: 'ar', value: 'بلاط أرضيات')]),
        const Namez(id: 'sub_prd_floors_planks',names: <Name>[Name(code: 'en', value: 'Floor Planks'), Name(code: 'ar', value: 'ألواح أرضيات')]),
        const Namez(id: 'sub_prd_floors_covering',names: <Name>[Name(code: 'en', value: 'Floor Covering'), Name(code: 'ar', value: 'تغطيات أرضيات')]),
        const Namez(id: 'sub_prd_floors_paving',names: <Name>[Name(code: 'en', value: 'Floor Paving'), Name(code: 'ar', value: 'تمهيد أرضيات')]),
        const Namez(id: 'sub_prd_floors_skirting',names: <Name>[Name(code: 'en', value: 'Skirting'), Name(code: 'ar', value: 'وزر')]),
        const Namez(id: 'sub_prd_struc_shades',names: <Name>[Name(code: 'en', value: 'Shades'), Name(code: 'ar', value: 'مظلات')]),
        const Namez(id: 'sub_prd_struc_light',names: <Name>[Name(code: 'en', value: 'Light Structures'), Name(code: 'ar', value: 'منشآت خفيفة')]),
        const Namez(id: 'sub_prd_fire_equip',names: <Name>[Name(code: 'en', value: 'Fire Fighting Equipment'), Name(code: 'ar', value: 'معدات مكافحة حريق')]),
        const Namez(id: 'sub_prd_fire_pumpsCont',names: <Name>[Name(code: 'en', value: 'Pumps & Controllers'), Name(code: 'ar', value: 'مضخات و متحكمات')]),
        const Namez(id: 'sub_prd_fire_detectors',names: <Name>[Name(code: 'en', value: 'Fire Detectors'), Name(code: 'ar', value: 'كاشفات حريق')]),
        const Namez(id: 'sub_prd_fire_clothes',names: <Name>[Name(code: 'en', value: 'Fire Fighting Cloth'), Name(code: 'ar', value: 'ملابس مكافحة حريق')]),
        const Namez(id: 'sub_prd_safety_clothes',names: <Name>[Name(code: 'en', value: 'Safety Clothes'), Name(code: 'ar', value: 'ملابس أمن و سلامة')]),
        const Namez(id: 'sub_prd_safety_equip',names: <Name>[Name(code: 'en', value: 'Safety Equipment'), Name(code: 'ar', value: 'معدات سلامة')]),
        const Namez(id: 'sub_prd_safety_floorProtection',names: <Name>[Name(code: 'en', value: 'Floor Protection'), Name(code: 'ar', value: 'حماية أرضيات')]),
        const Namez(id: 'sub_prd_stairs_handrails',names: <Name>[Name(code: 'en', value: 'Handrails'), Name(code: 'ar', value: 'درابزين سلالم')]),
        const Namez(id: 'sub_prd_roof_drainage',names: <Name>[Name(code: 'en', value: 'Roof Drainage'), Name(code: 'ar', value: 'صرف أسطح')]),
        const Namez(id: 'sub_prd_roof_cladding',names: <Name>[Name(code: 'en', value: 'Roof Cladding'), Name(code: 'ar', value: 'تجاليد أسطح')]),
        const Namez(id: 'sub_prd_doors_shutters',names: <Name>[Name(code: 'en', value: 'Shutters'), Name(code: 'ar', value: 'شيش حصيرة')]),
        const Namez(id: 'sub_prd_door_doors',names: <Name>[Name(code: 'en', value: 'Doors'), Name(code: 'ar', value: 'أبواب')]),
        const Namez(id: 'sub_prd_door_windows',names: <Name>[Name(code: 'en', value: 'Windows'), Name(code: 'ar', value: 'شبابيك')]),
        const Namez(id: 'sub_prd_door_hardware',names: <Name>[Name(code: 'en', value: 'Hardware'), Name(code: 'ar', value: 'اكسسوارات')]),
        const Namez(id: 'sub_prd_scape_livePlants',names: <Name>[Name(code: 'en', value: 'Live Plants'), Name(code: 'ar', value: 'نباتات حية')]),
        const Namez(id: 'sub_prd_scape_artificial',names: <Name>[Name(code: 'en', value: 'Artificial plants'), Name(code: 'ar', value: 'نباتات صناعية')]),
        const Namez(id: 'sub_prd_scape_potsVases',names: <Name>[Name(code: 'en', value: 'Pots & Vases'), Name(code: 'ar', value: 'أواني و مزهريات')]),
        const Namez(id: 'sub_prd_scape_birds',names: <Name>[Name(code: 'en', value: 'Birds fixtures'), Name(code: 'ar', value: 'تجهيزات عصافير')]),
        const Namez(id: 'sub_prd_scape_fountainsPonds',names: <Name>[Name(code: 'en', value: 'Fountains & Ponds'), Name(code: 'ar', value: 'نوافير و برك')]),
        const Namez(id: 'sub_prd_scape_hardscape',names: <Name>[Name(code: 'en', value: 'Hardscape'), Name(code: 'ar', value: 'هاردسكيب')]),
        const Namez(id: 'sub_prd_hvac_heating',names: <Name>[Name(code: 'en', value: 'Heating'), Name(code: 'ar', value: 'تدفئة')]),
        const Namez(id: 'sub_prd_hvac_ventilation',names: <Name>[Name(code: 'en', value: 'Ventilation'), Name(code: 'ar', value: 'تهوية')]),
        const Namez(id: 'sub_prd_hvac_ac',names: <Name>[Name(code: 'en', value: 'Air Conditioning'), Name(code: 'ar', value: 'تكييف هواء')]),
        const Namez(id: 'sub_prd_hvac_fireplaces',names: <Name>[Name(code: 'en', value: 'Fireplaces'), Name(code: 'ar', value: 'مواقد نار')]),
        const Namez(id: 'sub_prd_hvac_fireplaceEquip',names: <Name>[Name(code: 'en', value: 'Fireplace Equipment'), Name(code: 'ar', value: 'أدوات مواقد نار')]),
        const Namez(id: 'sub_prd_plumb_connections',names: <Name>[Name(code: 'en', value: 'Connections'), Name(code: 'ar', value: 'وصلات')]),
        const Namez(id: 'sub_prd_plumb_treatment',names: <Name>[Name(code: 'en', value: 'Water Treatment'), Name(code: 'ar', value: 'معالجة مياه')]),
        const Namez(id: 'sub_prd_plumb_sanitary',names: <Name>[Name(code: 'en', value: 'Sanitary ware'), Name(code: 'ar', value: 'أدوات صحية')]),
        const Namez(id: 'sub_prd_plumb_kitchen',names: <Name>[Name(code: 'en', value: 'Kitchen Sanitary ware'), Name(code: 'ar', value: 'أدوات مطبخ صحية')]),
        const Namez(id: 'sub_prd_plumb_handwash',names: <Name>[Name(code: 'en', value: 'Handwash Sanitary ware'), Name(code: 'ar', value: 'أدوات غسيل أيدي صحية')]),
        const Namez(id: 'sub_prd_plumb_toilet',names: <Name>[Name(code: 'en', value: 'Toilet Sanitary ware'), Name(code: 'ar', value: 'أدوات مراحيض صحية')]),
        const Namez(id: 'sub_prd_plumb_shower',names: <Name>[Name(code: 'en', value: 'Shower Sanitary ware'), Name(code: 'ar', value: 'أدوات استحمام صحية')]),
        const Namez(id: 'sub_prd_plumb_tub',names: <Name>[Name(code: 'en', value: 'Tub Sanitary ware'), Name(code: 'ar', value: 'أدوات بانيو صحية')]),
        const Namez(id: 'sub_prd_light_lamps',names: <Name>[Name(code: 'en', value: 'Lamps'), Name(code: 'ar', value: 'مصابيح')]),
        const Namez(id: 'sub_prd_light_ceiling',names: <Name>[Name(code: 'en', value: 'Ceiling Lighting'), Name(code: 'ar', value: 'إضاءة أسقف')]),
        const Namez(id: 'sub_prd_light_wall',names: <Name>[Name(code: 'en', value: 'Wall Lighting'), Name(code: 'ar', value: 'إضاءة حائطية')]),
        const Namez(id: 'sub_prd_light_outdoor',names: <Name>[Name(code: 'en', value: 'Outdoor Lighting'), Name(code: 'ar', value: 'إضاءة خارجية')]),
        const Namez(id: 'sub_prd_light_access',names: <Name>[Name(code: 'en', value: 'Lighting Accessories'), Name(code: 'ar', value: 'اكسسوارات إضاءة')]),
        const Namez(id: 'sub_prd_light_bulbs',names: <Name>[Name(code: 'en', value: 'Light bulbs'), Name(code: 'ar', value: 'لمبات إضاءة')]),
        const Namez(id: 'sub_prd_elec_cables',names: <Name>[Name(code: 'en', value: 'Cables & Wires'), Name(code: 'ar', value: 'كابلات أسلاك')]),
        const Namez(id: 'sub_prd_elec_connectors',names: <Name>[Name(code: 'en', value: 'Electrical Connectors'), Name(code: 'ar', value: 'وصلات كهربائية')]),
        const Namez(id: 'sub_prd_elec_switches',names: <Name>[Name(code: 'en', value: 'Electrical Switches'), Name(code: 'ar', value: 'مفاتيح كهربائية')]),
        const Namez(id: 'sub_prd_elec_organization',names: <Name>[Name(code: 'en', value: 'Electricity Organizers'), Name(code: 'ar', value: 'منسقات كهربائية')]),
        const Namez(id: 'sub_prd_elec_powerStorage',names: <Name>[Name(code: 'en', value: 'Power Storage'), Name(code: 'ar', value: 'تخزين كهرباء')]),
        const Namez(id: 'sub_prd_elec_instruments',names: <Name>[Name(code: 'en', value: 'Electricity Instruments'), Name(code: 'ar', value: 'أجهزة كهربائية')]),
        const Namez(id: 'sub_prd_elec_generators',names: <Name>[Name(code: 'en', value: 'Electricity Generators'), Name(code: 'ar', value: 'مولدات كهرباء')]),
        const Namez(id: 'sub_prd_elec_motors',names: <Name>[Name(code: 'en', value: 'Electrical Motors'), Name(code: 'ar', value: 'مواتير كهربائية')]),
        const Namez(id: 'sub_prd_security_surveillance',names: <Name>[Name(code: 'en', value: 'Surveillance Systems'), Name(code: 'ar', value: 'أنظمة مراقبة')]),
        const Namez(id: 'sub_prd_security_accessibility',names: <Name>[Name(code: 'en', value: 'Accessibility Systems'), Name(code: 'ar', value: 'أنظمة دخول')]),
        const Namez(id: 'sub_prd_security_roadControl',names: <Name>[Name(code: 'en', value: 'Road Control'), Name(code: 'ar', value: 'تحكم في الطرق')]),
        const Namez(id: 'sub_prd_security_safes',names: <Name>[Name(code: 'en', value: 'Security Safes'), Name(code: 'ar', value: 'خزائن أمان')]),
        const Namez(id: 'sub_prd_pool_pools',names: <Name>[Name(code: 'en', value: 'Swimming Pools'), Name(code: 'ar', value: 'حمامات سباحة')]),
        const Namez(id: 'sub_prd_pool_equipment',names: <Name>[Name(code: 'en', value: 'Pools Equipment'), Name(code: 'ar', value: 'عدات حمامات سباحة')]),
        const Namez(id: 'sub_prd_pool_accessories',names: <Name>[Name(code: 'en', value: 'Pool Accessories'), Name(code: 'ar', value: 'اكسسوارات حمامات سباحة')]),
        const Namez(id: 'sub_prd_pool_spa',names: <Name>[Name(code: 'en', value: 'Spa'), Name(code: 'ar', value: 'حمامات صحية')]),
        const Namez(id: 'sub_prd_smart_audio',names: <Name>[Name(code: 'en', value: 'Audio Systems'), Name(code: 'ar', value: 'أنظمة صوت')]),
        const Namez(id: 'sub_prd_smart_automation',names: <Name>[Name(code: 'en', value: 'Automation Systems'), Name(code: 'ar', value: 'أنظمة أوتوماتية')]),
        const Namez(id: 'sub_prd_furn_sets',names: <Name>[Name(code: 'en', value: 'Complete Sets'), Name(code: 'ar', value: 'أطقم متكااملة')]),
        const Namez(id: 'sub_prd_furn_chairs',names: <Name>[Name(code: 'en', value: 'Chairs'), Name(code: 'ar', value: 'كراسي')]),
        const Namez(id: 'sub_prd_furn_tables',names: <Name>[Name(code: 'en', value: 'Tables'), Name(code: 'ar', value: 'طاولات')]),
        const Namez(id: 'sub_prd_furn_outSeating',names: <Name>[Name(code: 'en', value: 'Outdoor Seating'), Name(code: 'ar', value: 'مقاعد خارجية')]),
        const Namez(id: 'sub_prd_furn_outTables',names: <Name>[Name(code: 'en', value: 'Outdoor Tables'), Name(code: 'ar', value: 'طاولات خارجية')]),
        const Namez(id: 'sub_prd_furn_parts',names: <Name>[Name(code: 'en', value: 'Furniture Parts'), Name(code: 'ar', value: 'أجزاء أثاث')]),
        const Namez(id: 'sub_prd_furn_couch',names: <Name>[Name(code: 'en', value: 'Couches'), Name(code: 'ar', value: 'أرائك و كنب')]),
        const Namez(id: 'sub_prd_furn_seatingBench',names: <Name>[Name(code: 'en', value: 'Seating Benches'), Name(code: 'ar', value: 'مجالس')]),
        const Namez(id: 'sub_prd_furn_kitchenStorage',names: <Name>[Name(code: 'en', value: 'Kitchen Storage'), Name(code: 'ar', value: 'خزائن مطبخ')]),
        const Namez(id: 'sub_prd_furn_diningStorage',names: <Name>[Name(code: 'en', value: 'Dining Storage'), Name(code: 'ar', value: 'خزائن غرفة طعام')]),
        const Namez(id: 'sub_prd_furn_bathStorage',names: <Name>[Name(code: 'en', value: 'Bathroom Storage'), Name(code: 'ar', value: 'خزائن حمام')]),
        const Namez(id: 'sub_prd_furn_dressingStorage',names: <Name>[Name(code: 'en', value: 'Dressing Storage'), Name(code: 'ar', value: 'خزائن ملابس')]),
        const Namez(id: 'sub_prd_furn_livingStorage',names: <Name>[Name(code: 'en', value: 'Living Storage'), Name(code: 'ar', value: 'خزائن غرفة معيشة')]),
        const Namez(id: 'sub_prd_furn_boxes',names: <Name>[Name(code: 'en', value: 'Boxes'), Name(code: 'ar', value: 'صناديق ')]),
        const Namez(id: 'sub_prd_furn_kids',names: <Name>[Name(code: 'en', value: 'Kids Furniture'), Name(code: 'ar', value: 'أثاث أطفال')]),
        const Namez(id: 'sub_prd_furn_planting',names: <Name>[Name(code: 'en', value: 'Planting'), Name(code: 'ar', value: 'زراعة منزلية')]),
        const Namez(id: 'sub_prd_furn_laundry',names: <Name>[Name(code: 'en', value: 'Laundry'), Name(code: 'ar', value: 'تجهيزات مغسلة ملابس')]),
        const Namez(id: 'sub_prd_furn_accessories',names: <Name>[Name(code: 'en', value: 'Furniture Accessories'), Name(code: 'ar', value: 'اكسسوارات أثاث')]),
        const Namez(id: 'sub_prd_furn_organizers',names: <Name>[Name(code: 'en', value: 'Organizers'), Name(code: 'ar', value: 'منظمات')]),
        const Namez(id: 'sub_prd_furn_artworks',names: <Name>[Name(code: 'en', value: 'Artworks'), Name(code: 'ar', value: 'أعمال فنية')]),
        const Namez(id: 'sub_prd_furn_bathHardware',names: <Name>[Name(code: 'en', value: 'Bathroom Hardware'), Name(code: 'ar', value: 'اكسسوارات حمامات')]),
        const Namez(id: 'sub_prd_furn_wasteDisposal',names: <Name>[Name(code: 'en', value: 'Waste Disposal'), Name(code: 'ar', value: 'تخلص من النفايات')]),
        const Namez(id: 'sub_prd_furn_cabinetHardware',names: <Name>[Name(code: 'en', value: 'Cabinet Hardware'), Name(code: 'ar', value: 'اكسسوارات كابينات')]),
        const Namez(id: 'sub_prd_furn_carpetsRugs',names: <Name>[Name(code: 'en', value: 'Carpets & Rugs'), Name(code: 'ar', value: 'سجاد')]),
        const Namez(id: 'sub_prd_furn_blindsCurtains',names: <Name>[Name(code: 'en', value: 'Blinds & Curtains'), Name(code: 'ar', value: 'ستائر')]),
        const Namez(id: 'sub_prd_furn_Kitchen Accessories',names: <Name>[Name(code: 'en', value: 'Kitchen Accessories'), Name(code: 'ar', value: 'اكسسوارات مطبخ')]),
        const Namez(id: 'sub_prd_furn_beds',names: <Name>[Name(code: 'en', value: 'Beds & Headboards'), Name(code: 'ar', value: 'سرائر و ظهور سرائر')]),
        const Namez(id: 'sub_prd_furn_cushions',names: <Name>[Name(code: 'en', value: 'Cushions & Pillows'), Name(code: 'ar', value: 'وسائد و مساند')]),
        const Namez(id: 'sub_prd_furn_office',names: <Name>[Name(code: 'en', value: 'Office Furniture'), Name(code: 'ar', value: 'أثاث مكاتب')]),
        const Namez(id: 'sub_prd_furn_tops',names: <Name>[Name(code: 'en', value: 'Vanity Tops'), Name(code: 'ar', value: 'أسطح وحدات حمام و مطبخ')]),
        const Namez(id: 'sub_prd_app_refrigeration',names: <Name>[Name(code: 'en', value: 'Refrigeration'), Name(code: 'ar', value: 'مبردات و ثلاجات')]),
        const Namez(id: 'sub_prd_app_indoorCooking',names: <Name>[Name(code: 'en', value: 'Indoor Cooking'), Name(code: 'ar', value: 'أجهزة طبخ داخلي')]),
        const Namez(id: 'sub_prd_app_foodProcessors',names: <Name>[Name(code: 'en', value: 'Food Processors'), Name(code: 'ar', value: 'محضرات طعام')]),
        const Namez(id: 'sub_prd_app_outdoorCooking',names: <Name>[Name(code: 'en', value: 'Outdoor Cooking'), Name(code: 'ar', value: 'أجهزة طبخ خارجي')]),
        const Namez(id: 'sub_prd_app_bathroom',names: <Name>[Name(code: 'en', value: 'Bathroom Appliances'), Name(code: 'ar', value: 'أجهزة حمام كهربائية')]),
        const Namez(id: 'sub_prd_app_housekeeping',names: <Name>[Name(code: 'en', value: 'HouseKeeping Appliances'), Name(code: 'ar', value: 'أجهزة غسيل و نظافة')]),
        const Namez(id: 'sub_prd_app_drinks',names: <Name>[Name(code: 'en', value: 'Drinks Appliances'), Name(code: 'ar', value: 'أجهزة تحضير مشروبات')]),
        const Namez(id: 'sub_prd_app_snacks',names: <Name>[Name(code: 'en', value: 'Snacks Appliances'), Name(code: 'ar', value: 'أجهزة تحضير وجبات خفيفة')]),
        const Namez(id: 'sub_prd_app_wasteDisposal',names: <Name>[Name(code: 'en', value: 'Waste Disposal Appliances'), Name(code: 'ar', value: 'أجهزة تخلص من النفايات')]),
        const Namez(id: 'sub_prd_app_media',names: <Name>[Name(code: 'en', value: 'Media Appliances'), Name(code: 'ar', value: 'أجهزة ميديا')]),
        const Namez(id: 'sub_prd_mat_cement',names: <Name>[Name(code: 'en', value: 'Cement'), Name(code: 'ar', value: 'أسمنت')]),
        const Namez(id: 'sub_prd_mat_steel',names: <Name>[Name(code: 'en', value: 'Steel'), Name(code: 'ar', value: 'حديد مسلح')]),
        const Namez(id: 'sub_prd_mat_gypsum',names: <Name>[Name(code: 'en', value: 'Gypsum'), Name(code: 'ar', value: 'جبس')]),
        const Namez(id: 'sub_prd_mat_sandRubble',names: <Name>[Name(code: 'en', value: 'Sand & Rubble'), Name(code: 'ar', value: 'رمل و زلط')]),
        const Namez(id: 'sub_prd_mat_bricks',names: <Name>[Name(code: 'en', value: 'Bricks'), Name(code: 'ar', value: 'طوب')]),
        const Namez(id: 'sub_prd_mat_manuWood',names: <Name>[Name(code: 'en', value: 'Manufactured Wood'), Name(code: 'ar', value: 'أخشاب مصنعة')]),
        const Namez(id: 'sub_prd_mat_solidWood',names: <Name>[Name(code: 'en', value: 'Solid Wood'), Name(code: 'ar', value: 'أخشاب طبيعية')]),
        const Namez(id: 'sub_prd_mat_stones',names: <Name>[Name(code: 'en', value: 'Stones'), Name(code: 'ar', value: 'حجر')]),
        const Namez(id: 'sub_prd_mat_woodCoats',names: <Name>[Name(code: 'en', value: 'Wood Coats'), Name(code: 'ar', value: 'دهانات خشب')]),
        const Namez(id: 'sub_prd_mat_paints',names: <Name>[Name(code: 'en', value: 'Paints'), Name(code: 'ar', value: 'دهانات')]),
        const Namez(id: 'sub_prd_mat_glass',names: <Name>[Name(code: 'en', value: 'Glass'), Name(code: 'ar', value: 'زجاج')]),
        const Namez(id: 'sub_prd_mat_acrylic',names: <Name>[Name(code: 'en', value: 'Acrylic'), Name(code: 'ar', value: 'أكريليك')]),
        const Namez(id: 'sub_prd_mat_metals',names: <Name>[Name(code: 'en', value: 'Metals'), Name(code: 'ar', value: 'معادن')]),
        const Namez(id: 'sub_prd_mat_fabrics',names: <Name>[Name(code: 'en', value: 'Fabrics'), Name(code: 'ar', value: 'أنسجة')]),
        const Namez(id: 'sub_prd_mat_waterProofing',names: <Name>[Name(code: 'en', value: 'Water Proofing'), Name(code: 'ar', value: 'عوازل رطوبة و مياه')]),
        const Namez(id: 'sub_prd_mat_heatIMin',names: <Name>[Name(code: 'en', value: 'Mineral Heat Insulation'), Name(code: 'ar', value: 'عوازل حرارية من ألياف معدنية')]),
        const Namez(id: 'sub_prd_mat_heatSynth',names: <Name>[Name(code: 'en', value: 'Synthetic Heat Insulation'), Name(code: 'ar', value: 'عوازل حرارية مصنوعة')]),
        const Namez(id: 'sub_handheld_cleaning',names: <Name>[Name(code: 'en', value: 'Cleaning Tools'), Name(code: 'ar', value: 'أدوات نظافة')]),
        const Namez(id: 'sub_handheld_gardenTools',names: <Name>[Name(code: 'en', value: 'Garden Tools'), Name(code: 'ar', value: 'أدوات زراعة')]),
        const Namez(id: 'sub_handheld_handTools',names: <Name>[Name(code: 'en', value: 'Hand tools'), Name(code: 'ar', value: 'أدوات يدوية')]),
        const Namez(id: 'sub_handheld_power',names: <Name>[Name(code: 'en', value: 'Power tools'), Name(code: 'ar', value: 'أدوات كهربية')]),
        const Namez(id: 'sub_handheld_measure',names: <Name>[Name(code: 'en', value: 'Measurement tools'), Name(code: 'ar', value: 'أدوات قياسس')]),
        const Namez(id: 'sub_handheld_machinery',names: <Name>[Name(code: 'en', value: 'Handheld machinery'), Name(code: 'ar', value: 'ماكينات يدوية')]),
        const Namez(id: 'sub_vehicle_earthmoving',names: <Name>[Name(code: 'en', value: 'Earth moving vehicles'), Name(code: 'ar', value: 'عربات تحريك الأرض')]),
        const Namez(id: 'sub_vehicle_transport',names: <Name>[Name(code: 'en', value: 'Transporting vehicles'), Name(code: 'ar', value: 'عربات ناقلة')]),
        const Namez(id: 'sub_vehicle_paving',names: <Name>[Name(code: 'en', value: 'Paving vehicles'), Name(code: 'ar', value: 'عربات تمهيد طرق')]),
        const Namez(id: 'ppt_lic_residential',names: <Name>[Name(code: 'en', value: 'Residential'), Name(code: 'ar', value: 'سكني')]),
        const Namez(id: 'ppt_lic_retail',names: <Name>[Name(code: 'en', value: 'Retail'), Name(code: 'ar', value: 'تجاري')]),
        const Namez(id: 'ppt_lic_industrial',names: <Name>[Name(code: 'en', value: 'Industrial'), Name(code: 'ar', value: 'صناعي')]),
        const Namez(id: 'ppt_lic_administration',names: <Name>[Name(code: 'en', value: 'Administration'), Name(code: 'ar', value: 'إداري')]),
        const Namez(id: 'ppt_lic_educational',names: <Name>[Name(code: 'en', value: 'Educational'), Name(code: 'ar', value: 'تعليمي')]),
        const Namez(id: 'ppt_lic_hotel',names: <Name>[Name(code: 'en', value: 'Hotel'), Name(code: 'ar', value: 'فندقي')]),
        const Namez(id: 'ppt_lic_sports',names: <Name>[Name(code: 'en', value: 'Sports'), Name(code: 'ar', value: 'رياضي')]),
        const Namez(id: 'ppt_lic_entertainment',names: <Name>[Name(code: 'en', value: 'Entertainment'), Name(code: 'ar', value: 'ترفيهي')]),
        const Namez(id: 'ppt_lic_medical',names: <Name>[Name(code: 'en', value: 'Medical'), Name(code: 'ar', value: 'طبي')]),
        const Namez(id: 'sub_ppt_area_pptArea',names: <Name>[Name(code: 'en', value: 'Property Area'), Name(code: 'ar', value: 'مساحة العقارر')]),
        const Namez(id: 'sub_ppt_area_lotArea',names: <Name>[Name(code: 'en', value: 'Lot Area'), Name(code: 'ar', value: 'مساحة الأرض')]),
        const Namez(id: 'sub_ppt_spaces_bedrooms',names: <Name>[Name(code: 'en', value: 'Number of Bedrooms'), Name(code: 'ar', value: 'عدد غرف النوم')]),
        const Namez(id: 'sub_ppt_spaces_bathrooms',names: <Name>[Name(code: 'en', value: 'Number of Bathrooms'), Name(code: 'ar', value: 'عدد الحمامات')]),
        const Namez(id: 'sub_ppt_spaces_rooms',names: <Name>[Name(code: 'en', value: 'Property Rooms'), Name(code: 'ar', value: 'غرف العقار')]),
        const Namez(id: 'sub_ppt_spaces_parkings',names: <Name>[Name(code: 'en', value: 'Number of private Parking Lots'), Name(code: 'ar', value: 'عدد مواقف السيارات الخاصة')]),
        const Namez(id: 'sub_ppt_feat_compound',names: <Name>[Name(code: 'en', value: 'In a Compound'), Name(code: 'ar', value: 'في مجمع سكني')]),
        const Namez(id: 'sub_ppt_feat_view',names: <Name>[Name(code: 'en', value: 'Property View'), Name(code: 'ar', value: 'المنظر المطل عليه  العقار')]),
        const Namez(id: 'sub_ppt_feat_floors',names: <Name>[Name(code: 'en', value: 'Number of Floor'), Name(code: 'ar', value: 'الدور')]),
        const Namez(id: 'sub_ppt_feat_age',names: <Name>[Name(code: 'en', value: 'Building Age'), Name(code: 'ar', value: 'عمر المنشأ')]),
        const Namez(id: 'sub_ppt_feat_finishing',names: <Name>[Name(code: 'en', value: 'Finishing level'), Name(code: 'ar', value: 'مستوى التشطيب')]),
        const Namez(id: 'sub_ppt_feat_indoor',names: <Name>[Name(code: 'en', value: 'Indoor Features'), Name(code: 'ar', value: 'خواص داخلية')]),
        const Namez(id: 'sub_ppt_feat_amenities',names: <Name>[Name(code: 'en', value: 'Amenities'), Name(code: 'ar', value: 'منشآت خدمية')]),
        const Namez(id: 'sub_ppt_feat_services',names: <Name>[Name(code: 'en', value: 'Additional Services'), Name(code: 'ar', value: 'خدمات إضافية')]),
        const Namez(id: 'sub_ppt_price_sellEGY',names: <Name>[Name(code: 'en', value: 'Property selling price (EGP)'), Name(code: 'ar', value: 'سعر بيع العقار (جم)')]),
        const Namez(id: 'sub_ppt_price_payments',names: <Name>[Name(code: 'en', value: 'Payment Method'), Name(code: 'ar', value: 'طريقة السداد')]),
        const Namez(id: 'sub_ppt_price_duration',names: <Name>[Name(code: 'en', value: 'Installments Duration'), Name(code: 'ar', value: 'فترة الأقساط')]),
        const Namez(id: 'sub_ppt_price_rentalType',names: <Name>[Name(code: 'en', value: 'Rental Type'), Name(code: 'ar', value: 'نوع الإيجار')]),
        const Namez(id: 'sub_ppt_price_rentValue',names: <Name>[Name(code: 'en', value: 'Rental Price'), Name(code: 'ar', value: 'سعر إيجار العقار')]),
        const Namez(id: 'sub_prd_price',names: <Name>[Name(code: 'en', value: 'Product price'), Name(code: 'ar', value: 'سعر المنتج')]),
        const Namez(id: 'sub_prd_priceType',names: <Name>[Name(code: 'en', value: 'Price type'), Name(code: 'ar', value: 'نوع السعر')]),
        const Namez(id: 'sub_prd_rentType',names: <Name>[Name(code: 'en', value: 'Rent type'), Name(code: 'ar', value: 'نوع الإيجار')]),
        const Namez(id: 'sub_prd_price_unit',names: <Name>[Name(code: 'en', value: 'Measurement unit'), Name(code: 'ar', value: 'وحدة القياس')]),
      ];
  }
// -----------------------------------------------------------------------------
  static List<String> getSubGroupsIDsFromKeywords({List<Keyword> keywords}){
    final List<String> _subGroupsIDs = <String>[];

    for (Keyword keyword in keywords){
      if(!_subGroupsIDs.contains(keyword.subGroupID)){
        _subGroupsIDs.add(keyword.subGroupID);
      }
    }

    return _subGroupsIDs;
  }
// =============================================================================

/// FILTERS KEYWORDS
// ------------------o

/// ALL KEYWORDS
// ------------------o
  /// TASK : add clinic keyword under medical sub group in space type for properties
  /// TASK : number of floor to be renamed to floor number
  static List<Keyword> bldrsKeywords(){
    return
      const <Keyword>[
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_carpentry', uses: 0, names: <Name>[Name(code: 'en', value: 'Carpentry'), Name(code: 'ar', value: 'نجارة'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_electricity', uses: 0, names: <Name>[Name(code: 'en', value: 'Electricity'), Name(code: 'ar', value: 'كهرباء'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_insulation', uses: 0, names: <Name>[Name(code: 'en', value: 'Insulation'), Name(code: 'ar', value: 'عزل'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_masonry', uses: 0, names: <Name>[Name(code: 'en', value: 'Masonry'), Name(code: 'ar', value: 'مباني'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_plumbing', uses: 0, names: <Name>[Name(code: 'en', value: 'Plumbing'), Name(code: 'ar', value: 'صحي و سباكة'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_blacksmithing', uses: 0, names: <Name>[Name(code: 'en', value: 'Blacksmithing'), Name(code: 'ar', value: 'حدادة'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_labor', uses: 0, names: <Name>[Name(code: 'en', value: 'Site labor'), Name(code: 'ar', value: 'عمالة موقع'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_painting', uses: 0, names: <Name>[Name(code: 'en', value: 'Painting'), Name(code: 'ar', value: 'نقاشة'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_plaster', uses: 0, names: <Name>[Name(code: 'en', value: 'Plaster'), Name(code: 'ar', value: 'محارة'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_landscape', uses: 0, names: <Name>[Name(code: 'en', value: 'Landscape'), Name(code: 'ar', value: 'لاندسكيب'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_hardscape', uses: 0, names: <Name>[Name(code: 'en', value: 'Hardscape'), Name(code: 'ar', value: 'هاردسكيب'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_hvac', uses: 0, names: <Name>[Name(code: 'en', value: 'HVAC'), Name(code: 'ar', value: 'تدفئة، تهوية و تكيفات'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_firefighting', uses: 0, names: <Name>[Name(code: 'en', value: 'Fire fighting'), Name(code: 'ar', value: 'مقاومة جرائق'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_elevators', uses: 0, names: <Name>[Name(code: 'en', value: 'Elevators / Escalators'), Name(code: 'ar', value: 'مصاعد / مدارج متحركة'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_tiling', uses: 0, names: <Name>[Name(code: 'en', value: 'Tiling'), Name(code: 'ar', value: 'تبليط'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_transportation', uses: 0, names: <Name>[Name(code: 'en', value: 'Transportation'), Name(code: 'ar', value: 'نقل'),],),
        const Keyword(flyerType: FlyerType.craft, groupID: 'group_craft_trade', subGroupID: '', keywordID: 'con_trade_concrete', uses: 0, names: <Name>[Name(code: 'en', value: 'Concrete'), Name(code: 'ar', value: 'خرسانة'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_kioskType', subGroupID: '', keywordID: 'kiosk_food', uses: 0, names: <Name>[Name(code: 'en', value: 'Food & Beverages'), Name(code: 'ar', value: 'أكل و شراب'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_kioskType', subGroupID: '', keywordID: 'kiosk_medical', uses: 0, names: <Name>[Name(code: 'en', value: 'Medical'), Name(code: 'ar', value: 'صحي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_kioskType', subGroupID: '', keywordID: 'kiosk_retail', uses: 0, names: <Name>[Name(code: 'en', value: 'Retail'), Name(code: 'ar', value: 'تجاري'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_kioskType', subGroupID: '', keywordID: 'kiosk_admin', uses: 0, names: <Name>[Name(code: 'en', value: 'Admin.'), Name(code: 'ar', value: 'إداري'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_arabian', uses: 0, names: <Name>[Name(code: 'en', value: 'Arabian'), Name(code: 'ar', value: 'عربي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_andalusian', uses: 0, names: <Name>[Name(code: 'en', value: 'Andalusian'), Name(code: 'ar', value: 'أندلسي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_asian', uses: 0, names: <Name>[Name(code: 'en', value: 'Asian'), Name(code: 'ar', value: 'آسيوي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_chinese', uses: 0, names: <Name>[Name(code: 'en', value: 'Chinese'), Name(code: 'ar', value: 'صيني'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_contemporary', uses: 0, names: <Name>[Name(code: 'en', value: 'Contemporary'), Name(code: 'ar', value: 'معاصر'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_classic', uses: 0, names: <Name>[Name(code: 'en', value: 'Classic'), Name(code: 'ar', value: 'كلاسيكي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_eclectic', uses: 0, names: <Name>[Name(code: 'en', value: 'Eclectic'), Name(code: 'ar', value: 'انتقائي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_english', uses: 0, names: <Name>[Name(code: 'en', value: 'English'), Name(code: 'ar', value: 'إنجليزي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_farmhouse', uses: 0, names: <Name>[Name(code: 'en', value: 'Farmhouse'), Name(code: 'ar', value: 'ريفي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_french', uses: 0, names: <Name>[Name(code: 'en', value: 'French'), Name(code: 'ar', value: 'فرنساوي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_gothic', uses: 0, names: <Name>[Name(code: 'en', value: 'Gothic'), Name(code: 'ar', value: 'قوطي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_greek', uses: 0, names: <Name>[Name(code: 'en', value: 'Greek'), Name(code: 'ar', value: 'يوناني'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_indian', uses: 0, names: <Name>[Name(code: 'en', value: 'Indian'), Name(code: 'ar', value: 'هندي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_industrial', uses: 0, names: <Name>[Name(code: 'en', value: 'Industrial'), Name(code: 'ar', value: 'صناعي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_japanese', uses: 0, names: <Name>[Name(code: 'en', value: 'Japanese'), Name(code: 'ar', value: 'ياباني'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_mediterranean', uses: 0, names: <Name>[Name(code: 'en', value: 'Mediterranean'), Name(code: 'ar', value: 'البحر المتوسط'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_midcentury', uses: 0, names: <Name>[Name(code: 'en', value: 'Mid century modern'), Name(code: 'ar', value: 'منتصف القرن الحديث'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_medieval', uses: 0, names: <Name>[Name(code: 'en', value: 'Medieval'), Name(code: 'ar', value: 'القرون الوسطى'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_minimalist', uses: 0, names: <Name>[Name(code: 'en', value: 'Minimalist'), Name(code: 'ar', value: 'مينيماليزم'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_modern', uses: 0, names: <Name>[Name(code: 'en', value: 'Modern'), Name(code: 'ar', value: 'حديث'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_moroccan', uses: 0, names: <Name>[Name(code: 'en', value: 'Moroccan'), Name(code: 'ar', value: 'مغربي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_rustic', uses: 0, names: <Name>[Name(code: 'en', value: 'Rustic'), Name(code: 'ar', value: 'فلاحي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_scandinavian', uses: 0, names: <Name>[Name(code: 'en', value: 'Scandinavian'), Name(code: 'ar', value: 'إسكاندنيفي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_shabbyChic', uses: 0, names: <Name>[Name(code: 'en', value: 'Shabby Chic'), Name(code: 'ar', value: 'مهترئ أنيق'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_american', uses: 0, names: <Name>[Name(code: 'en', value: 'American'), Name(code: 'ar', value: 'أمريكي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_spanish', uses: 0, names: <Name>[Name(code: 'en', value: 'Spanish'), Name(code: 'ar', value: 'أسباني'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_traditional', uses: 0, names: <Name>[Name(code: 'en', value: 'Traditional'), Name(code: 'ar', value: 'تقليدي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_transitional', uses: 0, names: <Name>[Name(code: 'en', value: 'Transitional'), Name(code: 'ar', value: 'انتقالي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_tuscan', uses: 0, names: <Name>[Name(code: 'en', value: 'Tuscan'), Name(code: 'ar', value: 'توسكاني'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_tropical', uses: 0, names: <Name>[Name(code: 'en', value: 'Tropical'), Name(code: 'ar', value: 'استوائي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_victorian', uses: 0, names: <Name>[Name(code: 'en', value: 'Victorian'), Name(code: 'ar', value: 'فيكتوريان'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_style', subGroupID: '', keywordID: 'arch_style_vintage', uses: 0, names: <Name>[Name(code: 'en', value: 'Vintage'), Name(code: 'ar', value: 'عتيق'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_type', subGroupID: '', keywordID: 'designType_architecture', uses: 0, names: <Name>[Name(code: 'en', value: 'Architectural design'), Name(code: 'ar', value: 'تصميم معماري'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_type', subGroupID: '', keywordID: 'designType_interior', uses: 0, names: <Name>[Name(code: 'en', value: 'Interior design & Décor'), Name(code: 'ar', value: 'تصميم داخلي و ديكور'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_type', subGroupID: '', keywordID: 'designType_facade', uses: 0, names: <Name>[Name(code: 'en', value: 'Façade exterior design'), Name(code: 'ar', value: 'تصميم واجهات خارجية'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_type', subGroupID: '', keywordID: 'designType_urban', uses: 0, names: <Name>[Name(code: 'en', value: 'Urban design'), Name(code: 'ar', value: 'تصميم حضري'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_type', subGroupID: '', keywordID: 'designType_furniture', uses: 0, names: <Name>[Name(code: 'en', value: 'Furniture design'), Name(code: 'ar', value: 'تصميم مفروشات'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_type', subGroupID: '', keywordID: 'designType_lighting', uses: 0, names: <Name>[Name(code: 'en', value: 'Lighting design'), Name(code: 'ar', value: 'تصميم إضاءة'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_type', subGroupID: '', keywordID: 'designType_landscape', uses: 0, names: <Name>[Name(code: 'en', value: 'Landscape design'), Name(code: 'ar', value: 'تصميم لاندسكيب'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_type', subGroupID: '', keywordID: 'designType_structural', uses: 0, names: <Name>[Name(code: 'en', value: 'Structural design'), Name(code: 'ar', value: 'تصميم إنشائي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_type', subGroupID: '', keywordID: 'designType_infrastructure', uses: 0, names: <Name>[Name(code: 'en', value: 'Infrastructure design'), Name(code: 'ar', value: 'تصميم بنية تحتية'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_dz_type', subGroupID: '', keywordID: 'designType_kiosk', uses: 0, names: <Name>[Name(code: 'en', value: 'Kiosk design'), Name(code: 'ar', value: 'تصميم كشك'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_power', keywordID: 'equip_tool_power_drill', uses: 0, names: <Name>[Name(code: 'en', value: 'Drills'), Name(code: 'ar', value: 'ثاقب كهربائي'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_power', keywordID: 'equip_tool_power_saw', uses: 0, names: <Name>[Name(code: 'en', value: 'Electric saw'), Name(code: 'ar', value: 'منشار كهربائي'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_power', keywordID: 'equip_tool_power_router', uses: 0, names: <Name>[Name(code: 'en', value: 'Router'), Name(code: 'ar', value: 'راوتر'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_power', keywordID: 'equip_tool_power_grinder', uses: 0, names: <Name>[Name(code: 'en', value: 'Grinder'), Name(code: 'ar', value: 'صاروخ جارش'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_power', keywordID: 'equip_tool_power_compressor', uses: 0, names: <Name>[Name(code: 'en', value: 'Air compressors'), Name(code: 'ar', value: 'كباس هوائي'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_power', keywordID: 'equip_tool_power_sander', uses: 0, names: <Name>[Name(code: 'en', value: 'Sanders'), Name(code: 'ar', value: 'ماكينات صنفرة'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_power', keywordID: 'equip_tool_power_heatGun', uses: 0, names: <Name>[Name(code: 'en', value: 'Heat guns'), Name(code: 'ar', value: 'مسدسات حرارية'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_measure', keywordID: 'equip_tool_measure_lasermeter', uses: 0, names: <Name>[Name(code: 'en', value: 'Laser meters'), Name(code: 'ar', value: 'متر قياس ليزر'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_measure', keywordID: 'equip_tool_measure_tapMeasure', uses: 0, names: <Name>[Name(code: 'en', value: 'Tape measure'), Name(code: 'ar', value: 'متر شريط قياس'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_measure', keywordID: 'equip_tool_measure_theodolite', uses: 0, names: <Name>[Name(code: 'en', value: 'Theodolite & Total stations'), Name(code: 'ar', value: 'تيدوليت'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_machinery', keywordID: 'equip_handheld_paver', uses: 0, names: <Name>[Name(code: 'en', value: 'Roller Pavers'), Name(code: 'ar', value: 'آلة رصف'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_machinery', keywordID: 'equip_handheld_rammer', uses: 0, names: <Name>[Name(code: 'en', value: 'Tamper rammers'), Name(code: 'ar', value: 'ماكينات دك هزاز'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_machinery', keywordID: 'equip_handheld_jack', uses: 0, names: <Name>[Name(code: 'en', value: 'Jack Hammers'), Name(code: 'ar', value: 'مطرقة ثاقبة هيلتي'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_machinery', keywordID: 'equip_handheld_troweller', uses: 0, names: <Name>[Name(code: 'en', value: 'Trowellers'), Name(code: 'ar', value: 'مجرفة أرض هليكوبتر'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_machinery', keywordID: 'equip_handheld_spray', uses: 0, names: <Name>[Name(code: 'en', value: 'Plaster spray unit'), Name(code: 'ar', value: 'وحدة رش محارة'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_handTools', keywordID: 'equip_tool_hand_workbench', uses: 0, names: <Name>[Name(code: 'en', value: 'Tool storage & work benches'), Name(code: 'ar', value: 'مخازن عدد و أسطح عمل'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_handTools', keywordID: 'equip_tool_hand_bits', uses: 0, names: <Name>[Name(code: 'en', value: 'Wood drill bits'), Name(code: 'ar', value: 'بنط'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_handTools', keywordID: 'equip_tool_hand_screws', uses: 0, names: <Name>[Name(code: 'en', value: 'Screws, nuts & bolts, fishers'), Name(code: 'ar', value: 'براغي و صواميل و مسامير و فيشر'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_handTools', keywordID: 'equip_tool_hand_ladder', uses: 0, names: <Name>[Name(code: 'en', value: 'Ladders & step stools'), Name(code: 'ar', value: 'سلالم'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_handTools', keywordID: 'equip_tool_hand_paint', uses: 0, names: <Name>[Name(code: 'en', value: 'Paint tools'), Name(code: 'ar', value: 'أدوات دهانات'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_handTools', keywordID: 'equip_tool_hand_screwDriver', uses: 0, names: <Name>[Name(code: 'en', value: 'Screw drivers'), Name(code: 'ar', value: 'مفكات'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_handTools', keywordID: 'equip_tool_hand_clamp', uses: 0, names: <Name>[Name(code: 'en', value: 'Clamps'), Name(code: 'ar', value: 'مشابك'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_gardenTools', keywordID: 'prd_tool_garden_fork', uses: 0, names: <Name>[Name(code: 'en', value: 'Forks, Rakes, Hoes, Shovels & Spades'), Name(code: 'ar', value: 'شوك و مجارف و معاول'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_gardenTools', keywordID: 'prd_tool_garden_pruning', uses: 0, names: <Name>[Name(code: 'en', value: 'Pruning tools'), Name(code: 'ar', value: 'أدوات تقليم'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_gardenTools', keywordID: 'prd_tool_garden_wheel', uses: 0, names: <Name>[Name(code: 'en', value: 'Wheelbarrows'), Name(code: 'ar', value: 'عربة ركام'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_gardenTools', keywordID: 'prd_tool_garden_barrel', uses: 0, names: <Name>[Name(code: 'en', value: 'barrels & cans'), Name(code: 'ar', value: 'براميل'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_gardenTools', keywordID: 'prd_tool_garden_sprayer', uses: 0, names: <Name>[Name(code: 'en', value: 'Sprayers & spreaders'), Name(code: 'ar', value: 'رشاشات و موزعات'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_gardenTools', keywordID: 'prd_tool_garden_hose', uses: 0, names: <Name>[Name(code: 'en', value: 'Garden hoses'), Name(code: 'ar', value: 'خراطيم ري'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_gardenTools', keywordID: 'prd_tool_garden_hoseReel', uses: 0, names: <Name>[Name(code: 'en', value: 'Garden hose reels'), Name(code: 'ar', value: 'بكرات خراطيم ري'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_gardenTools', keywordID: 'prd_tool_garden_sprinkler', uses: 0, names: <Name>[Name(code: 'en', value: 'Sprinklers'), Name(code: 'ar', value: 'مرشات ري أرضية'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_gardenTools', keywordID: 'prd_tool_garden_glove', uses: 0, names: <Name>[Name(code: 'en', value: 'Gardening gloves'), Name(code: 'ar', value: 'قفازات زراعة'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_cleaning', keywordID: 'prd_tool_hk_floorcare', uses: 0, names: <Name>[Name(code: 'en', value: 'Floor care Accessories'), Name(code: 'ar', value: 'أدوات عناية بالأرضيات'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handheld', subGroupID: 'sub_handheld_cleaning', keywordID: 'prd_tool_hk_mop', uses: 0, names: <Name>[Name(code: 'en', value: 'Mops, Brooms & dustpans'), Name(code: 'ar', value: 'مماسح و مكانس و مجارف'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handling', subGroupID: '', keywordID: 'equip_mat_crane', uses: 0, names: <Name>[Name(code: 'en', value: 'Cranes'), Name(code: 'ar', value: 'رافعات'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handling', subGroupID: '', keywordID: 'equip_mat_conveyor', uses: 0, names: <Name>[Name(code: 'en', value: 'Conveyors'), Name(code: 'ar', value: 'ناقلات'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handling', subGroupID: '', keywordID: 'equip_mat_forklift', uses: 0, names: <Name>[Name(code: 'en', value: 'Forklifts'), Name(code: 'ar', value: 'عربة رافعة شوكية'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_handling', subGroupID: '', keywordID: 'equip_mat_hoist', uses: 0, names: <Name>[Name(code: 'en', value: 'Hoists'), Name(code: 'ar', value: 'ألات رافعة'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_heavy', subGroupID: '', keywordID: 'equip_machinery_stoneCrusher', uses: 0, names: <Name>[Name(code: 'en', value: 'Stone crushers'), Name(code: 'ar', value: 'كسارة حجر'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_heavy', subGroupID: '', keywordID: 'equip_machinery_tunneling', uses: 0, names: <Name>[Name(code: 'en', value: 'Tunneling boring machine'), Name(code: 'ar', value: 'ألة حفر أنفاق'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_heavy', subGroupID: '', keywordID: 'equip_machinery_mixer', uses: 0, names: <Name>[Name(code: 'en', value: 'Concrete mixers'), Name(code: 'ar', value: 'خلاطات خرسانة'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_heavy', subGroupID: '', keywordID: 'equip_machinery_mixPlant', uses: 0, names: <Name>[Name(code: 'en', value: 'Hot mix plants'), Name(code: 'ar', value: 'محطات خلط ساخنة'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_prep', subGroupID: '', keywordID: 'equip_prep_scaffold', uses: 0, names: <Name>[Name(code: 'en', value: 'Scaffold'), Name(code: 'ar', value: 'سقالات'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_prep', subGroupID: '', keywordID: 'equip_prep_cone', uses: 0, names: <Name>[Name(code: 'en', value: 'Cones & Barriers'), Name(code: 'ar', value: 'أقماع و حواجز'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_prep', subGroupID: '', keywordID: 'equip_prep_signage', uses: 0, names: <Name>[Name(code: 'en', value: 'Safety signage'), Name(code: 'ar', value: 'لافتات أمان'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_earthmoving', keywordID: 'equip_earth_excavator', uses: 0, names: <Name>[Name(code: 'en', value: 'Excavators'), Name(code: 'ar', value: 'حفارات'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_earthmoving', keywordID: 'equip_earth_backhoe', uses: 0, names: <Name>[Name(code: 'en', value: 'Backhoe'), Name(code: 'ar', value: 'جراف حفار'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_earthmoving', keywordID: 'equip_earth_loader', uses: 0, names: <Name>[Name(code: 'en', value: 'Loaders'), Name(code: 'ar', value: 'عربة تحميل لودر'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_earthmoving', keywordID: 'equip_earth_bulldozer', uses: 0, names: <Name>[Name(code: 'en', value: 'Bulldozers'), Name(code: 'ar', value: 'جرافات'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_earthmoving', keywordID: 'equip_earth_trencher', uses: 0, names: <Name>[Name(code: 'en', value: 'Trenchers'), Name(code: 'ar', value: 'حفارات خنادق'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_earthmoving', keywordID: 'equip_earth_grader', uses: 0, names: <Name>[Name(code: 'en', value: 'Graders'), Name(code: 'ar', value: 'ممهدات طرق'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_earthmoving', keywordID: 'equip_earth_scrapper', uses: 0, names: <Name>[Name(code: 'en', value: 'Scrappers'), Name(code: 'ar', value: 'جرارات كاشطة'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_earthmoving', keywordID: 'equip_earth_crawlerLoader', uses: 0, names: <Name>[Name(code: 'en', value: 'Crawler loader'), Name(code: 'ar', value: 'محمل زاحف'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_earthmoving', keywordID: 'equip_earth_crawler', uses: 0, names: <Name>[Name(code: 'en', value: 'Crawlers'), Name(code: 'ar', value: 'حفار زاحف صغير'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_earthmoving', keywordID: 'equip_earth_excavator', uses: 0, names: <Name>[Name(code: 'en', value: 'Excavators'), Name(code: 'ar', value: 'حفار زاحف كبير'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_transport', keywordID: 'equip_vehicle_dumper', uses: 0, names: <Name>[Name(code: 'en', value: 'Dumpers & Tippers'), Name(code: 'ar', value: 'شاحنات قلابة'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_transport', keywordID: 'equip_vehicle_tanker', uses: 0, names: <Name>[Name(code: 'en', value: 'Tankers'), Name(code: 'ar', value: 'شاحنات سوائل'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_transport', keywordID: 'equip_vehicle_mixer', uses: 0, names: <Name>[Name(code: 'en', value: 'Mixer truck'), Name(code: 'ar', value: 'شاحناط خلاط'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_paving', keywordID: 'equip_paving_roller', uses: 0, names: <Name>[Name(code: 'en', value: 'Road Rollers'), Name(code: 'ar', value: 'مدحلة أسفلت'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_paving', keywordID: 'equip_paving_asphalt', uses: 0, names: <Name>[Name(code: 'en', value: 'Road making machine'), Name(code: 'ar', value: 'ماكينات صناعة الطرق'),],),
        const Keyword(flyerType: FlyerType.equipment, groupID: 'group_equip_vehicle', subGroupID: 'sub_vehicle_paving', keywordID: 'equip_paving_slurry', uses: 0, names: <Name>[Name(code: 'en', value: 'Slurry seal machine'), Name(code: 'ar', value: 'ماكينات أسفلت'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_less', uses: 0, names: <Name>[Name(code: 'en', value: 'Less than 50 m²'), Name(code: 'ar', value: 'أقل من 50 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_50_100', uses: 0, names: <Name>[Name(code: 'en', value: '50 - 100 m² '), Name(code: 'ar', value: 'بين 50 - 100 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_100_150', uses: 0, names: <Name>[Name(code: 'en', value: '100 - 150 m²'), Name(code: 'ar', value: 'بين 100 - 150 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_150_200', uses: 0, names: <Name>[Name(code: 'en', value: '150 - 200 m² '), Name(code: 'ar', value: 'بين 150 - 200 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_200_250', uses: 0, names: <Name>[Name(code: 'en', value: '200 - 250 m² '), Name(code: 'ar', value: 'بين 200 - 250 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_250_300', uses: 0, names: <Name>[Name(code: 'en', value: '250 - 300 m²'), Name(code: 'ar', value: 'بين 250 - 300 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_300_400', uses: 0, names: <Name>[Name(code: 'en', value: '300 - 400 m² '), Name(code: 'ar', value: 'بين 300 - 400 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_400_500', uses: 0, names: <Name>[Name(code: 'en', value: '400 - 500 m² '), Name(code: 'ar', value: 'بين 400 - 500 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_500_700', uses: 0, names: <Name>[Name(code: 'en', value: '500 - 700 m² '), Name(code: 'ar', value: 'بين 500 - 700 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_700_1000', uses: 0, names: <Name>[Name(code: 'en', value: '700 - 1\'000 m²'), Name(code: 'ar', value: 'بين 700 - 1000 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_1000_2000', uses: 0, names: <Name>[Name(code: 'en', value: '1\'000 - 2\'000 m² '), Name(code: 'ar', value: 'بين 1000 - 2000 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_2000_5000', uses: 0, names: <Name>[Name(code: 'en', value: '2\'000 - 5\'000 m²'), Name(code: 'ar', value: 'بين 2000 - 5000 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_5000_10000', uses: 0, names: <Name>[Name(code: 'en', value: '5\'000 - 10\'000 m²'), Name(code: 'ar', value: 'بين 5000 - 10000 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_pptArea', keywordID: 'pArea_more', uses: 0, names: <Name>[Name(code: 'en', value: 'More than 10000 m²'), Name(code: 'ar', value: 'أكبر من 10000 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_lotArea', keywordID: 'lArea_200_500', uses: 0, names: <Name>[Name(code: 'en', value: '200 - 500 m²'), Name(code: 'ar', value: 'بين 200 - 500 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_lotArea', keywordID: 'lArea_500_1000', uses: 0, names: <Name>[Name(code: 'en', value: '500 - 1000 m²'), Name(code: 'ar', value: 'بين 500 - 1000 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_lotArea', keywordID: 'lArea_1000_2000', uses: 0, names: <Name>[Name(code: 'en', value: '1\'000 - 2\'000 m²'), Name(code: 'ar', value: 'بين 1000 - 2000 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_lotArea', keywordID: 'lArea_2000_5000', uses: 0, names: <Name>[Name(code: 'en', value: '2\'000 - 5\'000 m²'), Name(code: 'ar', value: 'بين 2000 - 5000 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_lotArea', keywordID: 'lArea_5000_10000', uses: 0, names: <Name>[Name(code: 'en', value: '5\'000 - 10\'000 m²'), Name(code: 'ar', value: 'بين 5000 - 10000 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_lotArea', keywordID: 'lArea_10000_20000', uses: 0, names: <Name>[Name(code: 'en', value: '10\'000 - 20\'000 m²'), Name(code: 'ar', value: 'بين 10000 - 20000 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_lotArea', keywordID: 'lArea_20000_50000', uses: 0, names: <Name>[Name(code: 'en', value: '20\'000 - 50\'000 m²'), Name(code: 'ar', value: 'بين 20000 - 50000 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_area', subGroupID: 'sub_ppt_area_lotArea', keywordID: 'lArea_more', uses: 0, names: <Name>[Name(code: 'en', value: 'More than 50\'000 m²'), Name(code: 'ar', value: 'أكبر من 50000 م²'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_golf', uses: 0, names: <Name>[Name(code: 'en', value: 'Golf course view'), Name(code: 'ar', value: 'مضمار جولف'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_hill', uses: 0, names: <Name>[Name(code: 'en', value: 'Hill or Mountain view'), Name(code: 'ar', value: 'تل أو جبل'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_ocean', uses: 0, names: <Name>[Name(code: 'en', value: 'Ocean view'), Name(code: 'ar', value: 'محيط'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_city', uses: 0, names: <Name>[Name(code: 'en', value: 'City view'), Name(code: 'ar', value: 'مدينة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_lake', uses: 0, names: <Name>[Name(code: 'en', value: 'Lake view'), Name(code: 'ar', value: 'بحيرة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_lagoon', uses: 0, names: <Name>[Name(code: 'en', value: 'Lagoon view'), Name(code: 'ar', value: 'لاجون'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_river', uses: 0, names: <Name>[Name(code: 'en', value: 'River view'), Name(code: 'ar', value: 'نهر'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_mainStreet', uses: 0, names: <Name>[Name(code: 'en', value: 'Main street view'), Name(code: 'ar', value: 'شارع رئيسي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_sideStreet', uses: 0, names: <Name>[Name(code: 'en', value: 'Side street view'), Name(code: 'ar', value: 'شارع جانبي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_corner', uses: 0, names: <Name>[Name(code: 'en', value: 'Corner view'), Name(code: 'ar', value: 'ناصية الشارع'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_back', uses: 0, names: <Name>[Name(code: 'en', value: 'Back view'), Name(code: 'ar', value: 'خلفي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_garden', uses: 0, names: <Name>[Name(code: 'en', value: 'Garden view'), Name(code: 'ar', value: 'حديقة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_view', keywordID: 'view_pool', uses: 0, names: <Name>[Name(code: 'en', value: 'Pool view'), Name(code: 'ar', value: 'حمام سباحة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_lower', uses: 0, names: <Name>[Name(code: 'en', value: 'Under B-1'), Name(code: 'ar', value: 'أسفل البدروم الأول'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_b1', uses: 0, names: <Name>[Name(code: 'en', value: 'B-1'), Name(code: 'ar', value: 'البدروم الأول'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_g', uses: 0, names: <Name>[Name(code: 'en', value: 'Ground floor'), Name(code: 'ar', value: 'الدور الأرضي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_1_10', uses: 0, names: <Name>[Name(code: 'en', value: '1ˢᵗ - 10ᵗʰ'), Name(code: 'ar', value: '1ˢᵗ - 10ᵗʰ'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_10_20', uses: 0, names: <Name>[Name(code: 'en', value: '10ᵗʰ - 20ᵗʰ'), Name(code: 'ar', value: '10ᵗʰ - 20ᵗʰ'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_20_30', uses: 0, names: <Name>[Name(code: 'en', value: '20ᵗʰ - 30ᵗʰ'), Name(code: 'ar', value: '20ᵗʰ - 30ᵗʰ'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_30_40', uses: 0, names: <Name>[Name(code: 'en', value: '30ᵗʰ - 40ᵗʰ'), Name(code: 'ar', value: '30ᵗʰ - 40ᵗʰ'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_40_50', uses: 0, names: <Name>[Name(code: 'en', value: '40ᵗʰ - 50ᵗʰ'), Name(code: 'ar', value: '40ᵗʰ - 50ᵗʰ'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_50_60', uses: 0, names: <Name>[Name(code: 'en', value: '50ᵗʰ - 60ᵗʰ'), Name(code: 'ar', value: '50ᵗʰ - 60ᵗʰ'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_60_70', uses: 0, names: <Name>[Name(code: 'en', value: '60ᵗʰ - 70ᵗʰ'), Name(code: 'ar', value: '60ᵗʰ - 70ᵗʰ'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_70_80', uses: 0, names: <Name>[Name(code: 'en', value: '70ᵗʰ - 80ᵗʰ'), Name(code: 'ar', value: '70ᵗʰ - 80ᵗʰ'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_90_100', uses: 0, names: <Name>[Name(code: 'en', value: '90ᵗʰ - 100ᵗʰ'), Name(code: 'ar', value: '90ᵗʰ - 100ᵗʰ'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_floors', keywordID: 'floor_100_163', uses: 0, names: <Name>[Name(code: 'en', value: '100ᵗʰ - 163ʳᵈ'), Name(code: 'ar', value: '100ᵗʰ - 163ʳᵈ'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_disabilityFeatures', uses: 0, names: <Name>[Name(code: 'en', value: 'Disability features'), Name(code: 'ar', value: 'خواص معتبرة للإعاقة و المقعدين'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_fireplace', uses: 0, names: <Name>[Name(code: 'en', value: 'Fireplace'), Name(code: 'ar', value: 'مدفأة حطب'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_energyEfficient', uses: 0, names: <Name>[Name(code: 'en', value: 'Energy efficient'), Name(code: 'ar', value: 'موفر للطاقة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_electricityBackup', uses: 0, names: <Name>[Name(code: 'en', value: 'Electricity backup'), Name(code: 'ar', value: 'دعم كهرباء احتياطي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_centralAC', uses: 0, names: <Name>[Name(code: 'en', value: 'Central AC'), Name(code: 'ar', value: 'تكييف مركزي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_centralHeating', uses: 0, names: <Name>[Name(code: 'en', value: 'Central heating'), Name(code: 'ar', value: 'تدفئة مركزية'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_builtinWardrobe', uses: 0, names: <Name>[Name(code: 'en', value: 'Built-in wardrobes'), Name(code: 'ar', value: 'دواليب داخل الحوائط'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_kitchenAppliances', uses: 0, names: <Name>[Name(code: 'en', value: 'Kitchen Appliances'), Name(code: 'ar', value: 'أجهزة مطبخ'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_elevator', uses: 0, names: <Name>[Name(code: 'en', value: 'Elevator'), Name(code: 'ar', value: 'مصعد'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_intercom', uses: 0, names: <Name>[Name(code: 'en', value: 'Intercom'), Name(code: 'ar', value: 'إنتركوم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_internet', uses: 0, names: <Name>[Name(code: 'en', value: 'Broadband internet'), Name(code: 'ar', value: 'إنترنت'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_tv', uses: 0, names: <Name>[Name(code: 'en', value: 'Satellite / Cable TV'), Name(code: 'ar', value: 'قمر صناعي / تلفزيون مركزي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_indoor', keywordID: 'pFeature_atm', uses: 0, names: <Name>[Name(code: 'en', value: 'ATM'), Name(code: 'ar', value: 'ماكينة سحب أموال ATM'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_compound', keywordID: 'compound_notInCompound', uses: 0, names: <Name>[Name(code: 'en', value: 'Not in a compound'), Name(code: 'ar', value: 'ليس في مجمع سكني'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_compound', keywordID: 'compound_inCompound', uses: 0, names: <Name>[Name(code: 'en', value: 'Only in a compound'), Name(code: 'ar', value: 'في مجمع سكني'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_finishing', keywordID: 'finish_coreAndShell', uses: 0, names: <Name>[Name(code: 'en', value: 'Core and shell'), Name(code: 'ar', value: 'خرسانات و حوائط خارجية'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_finishing', keywordID: 'finish_withoutFinishing', uses: 0, names: <Name>[Name(code: 'en', value: 'Without finishing'), Name(code: 'ar', value: 'غير متشطب'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_finishing', keywordID: 'finish_semiFinished', uses: 0, names: <Name>[Name(code: 'en', value: 'Semi finished'), Name(code: 'ar', value: 'نصف تشطيب'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_finishing', keywordID: 'finish_lux', uses: 0, names: <Name>[Name(code: 'en', value: 'Lux'), Name(code: 'ar', value: 'تشطيب لوكس'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_finishing', keywordID: 'finish_superLux', uses: 0, names: <Name>[Name(code: 'en', value: 'Super lux'), Name(code: 'ar', value: 'تشطيب سوبر لوكس'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_finishing', keywordID: 'finish_extraSuperLux', uses: 0, names: <Name>[Name(code: 'en', value: 'Extra super lux'), Name(code: 'ar', value: 'تشطيب إكسترا سوبر لوكس'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_age', keywordID: 'age_1_2', uses: 0, names: <Name>[Name(code: 'en', value: '1 - 2 years'), Name(code: 'ar', value: 'بين 1 - 2 عام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_age', keywordID: 'age_2_5', uses: 0, names: <Name>[Name(code: 'en', value: '2 - 5 years'), Name(code: 'ar', value: 'بين 2 - 5 أعوام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_age', keywordID: 'age_5_10', uses: 0, names: <Name>[Name(code: 'en', value: '5 - 10 years'), Name(code: 'ar', value: 'بين 5 - 10 أعوام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_age', keywordID: 'age_10_20', uses: 0, names: <Name>[Name(code: 'en', value: '10 - 20 years'), Name(code: 'ar', value: 'بين 10 - 20 عام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_age', keywordID: 'age_20_50', uses: 0, names: <Name>[Name(code: 'en', value: '20 - 50 years'), Name(code: 'ar', value: 'بين 20 - 50 عام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_age', keywordID: 'age_50_100', uses: 0, names: <Name>[Name(code: 'en', value: '50 - 100 years'), Name(code: 'ar', value: 'بين 50 - 100 عام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_age', keywordID: 'age_more', uses: 0, names: <Name>[Name(code: 'en', value: 'More than 100 years'), Name(code: 'ar', value: 'أقدم من 100 عام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_laundry', uses: 0, names: <Name>[Name(code: 'en', value: 'Laundry'), Name(code: 'ar', value: 'مغسلة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_swimmingPool', uses: 0, names: <Name>[Name(code: 'en', value: 'Swimming pool'), Name(code: 'ar', value: 'حمام سباحة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_kidsPool', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids pool'), Name(code: 'ar', value: 'حمام سباحة أطفال'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_boatFacilities', uses: 0, names: <Name>[Name(code: 'en', value: 'Boat facilities'), Name(code: 'ar', value: 'خدمات مراكب مائية'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_gymFacilities', uses: 0, names: <Name>[Name(code: 'en', value: 'Gym'), Name(code: 'ar', value: 'صالة جيمنازيوم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_clubHouse', uses: 0, names: <Name>[Name(code: 'en', value: 'Clubhouse'), Name(code: 'ar', value: 'كلاب هاوس'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_horseFacilities', uses: 0, names: <Name>[Name(code: 'en', value: 'Horse facilities'), Name(code: 'ar', value: 'خدمات خيول'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_sportsCourts', uses: 0, names: <Name>[Name(code: 'en', value: 'Sports courts'), Name(code: 'ar', value: 'ملاعب رياضية'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_park', uses: 0, names: <Name>[Name(code: 'en', value: 'Park / garden'), Name(code: 'ar', value: 'حديقة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_golfCourse', uses: 0, names: <Name>[Name(code: 'en', value: 'Golf course'), Name(code: 'ar', value: 'مضمار جولف'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_spa', uses: 0, names: <Name>[Name(code: 'en', value: 'Spa'), Name(code: 'ar', value: 'منتجع صحي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_kidsArea', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids Area'), Name(code: 'ar', value: 'منطقة أطفال'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_cafeteria', uses: 0, names: <Name>[Name(code: 'en', value: 'Cafeteria'), Name(code: 'ar', value: 'كافيتيريا'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_businessCenter', uses: 0, names: <Name>[Name(code: 'en', value: 'Business center'), Name(code: 'ar', value: 'مقر أعمال'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_amenities', keywordID: 'am_lobby', uses: 0, names: <Name>[Name(code: 'en', value: 'Building lobby'), Name(code: 'ar', value: 'ردهة مدخل للمبنى'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_services', keywordID: 'pService_houseKeeping', uses: 0, names: <Name>[Name(code: 'en', value: 'Housekeeping'), Name(code: 'ar', value: 'خدمة تنظيف منزلي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_services', keywordID: 'pService_laundryService', uses: 0, names: <Name>[Name(code: 'en', value: 'LaundryService'), Name(code: 'ar', value: 'خدمة غسيل ملابس'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_services', keywordID: 'pService_concierge', uses: 0, names: <Name>[Name(code: 'en', value: 'Concierge'), Name(code: 'ar', value: 'خدمة استقبال'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_services', keywordID: 'pService_securityStaff', uses: 0, names: <Name>[Name(code: 'en', value: 'Security  staff'), Name(code: 'ar', value: 'فريق حراسة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_services', keywordID: 'pService_securityCCTV', uses: 0, names: <Name>[Name(code: 'en', value: 'CCTV security'), Name(code: 'ar', value: 'كاميرات مراقبة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_services', keywordID: 'pService_petsAllowed', uses: 0, names: <Name>[Name(code: 'en', value: 'Pets allowed'), Name(code: 'ar', value: 'مسموح بالحيوانات الأليفة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_services', keywordID: 'pService_doorMan', uses: 0, names: <Name>[Name(code: 'en', value: 'Doorman'), Name(code: 'ar', value: 'بواب'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_services', keywordID: 'pService_maintenance', uses: 0, names: <Name>[Name(code: 'en', value: 'Maintenance staff'), Name(code: 'ar', value: 'فريق صيانة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_features', subGroupID: 'sub_ppt_feat_services', keywordID: 'pService_wasteDisposal', uses: 0, names: <Name>[Name(code: 'en', value: 'Waste disposal'), Name(code: 'ar', value: 'خدمة رفع القمامة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_form', subGroupID: '', keywordID: 'pf_fullFloor', uses: 0, names: <Name>[Name(code: 'en', value: 'Full floor'), Name(code: 'ar', value: 'دور كامل'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_form', subGroupID: '', keywordID: 'pf_halfFloor', uses: 0, names: <Name>[Name(code: 'en', value: 'Half floor'), Name(code: 'ar', value: 'نصف دور'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_form', subGroupID: '', keywordID: 'pf_partFloor', uses: 0, names: <Name>[Name(code: 'en', value: 'Part of floor'), Name(code: 'ar', value: 'جزء من دور'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_form', subGroupID: '', keywordID: 'pf_building', uses: 0, names: <Name>[Name(code: 'en', value: 'Whole building'), Name(code: 'ar', value: 'مبنى كامل'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_form', subGroupID: '', keywordID: 'pf_land', uses: 0, names: <Name>[Name(code: 'en', value: 'Land'), Name(code: 'ar', value: 'أرض'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_form', subGroupID: '', keywordID: 'pf_mobile', uses: 0, names: <Name>[Name(code: 'en', value: 'Mobile'), Name(code: 'ar', value: 'منشأ متنقل'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_license', subGroupID: '', keywordID: 'ppt_lic_residential', uses: 0, names: <Name>[Name(code: 'en', value: 'Residential'), Name(code: 'ar', value: 'سكني'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_license', subGroupID: '', keywordID: 'ppt_lic_administration', uses: 0, names: <Name>[Name(code: 'en', value: 'Administration'), Name(code: 'ar', value: 'إداري'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_license', subGroupID: '', keywordID: 'ppt_lic_educational', uses: 0, names: <Name>[Name(code: 'en', value: 'Educational'), Name(code: 'ar', value: 'تعليمي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_license', subGroupID: '', keywordID: 'ppt_lic_utilities', uses: 0, names: <Name>[Name(code: 'en', value: 'Utilities'), Name(code: 'ar', value: 'خدمات'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_license', subGroupID: '', keywordID: 'ppt_lic_sports', uses: 0, names: <Name>[Name(code: 'en', value: 'Sports'), Name(code: 'ar', value: 'رياضي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_license', subGroupID: '', keywordID: 'ppt_lic_entertainment', uses: 0, names: <Name>[Name(code: 'en', value: 'Entertainment'), Name(code: 'ar', value: 'ترفيهي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_license', subGroupID: '', keywordID: 'ppt_lic_medical', uses: 0, names: <Name>[Name(code: 'en', value: 'Medical'), Name(code: 'ar', value: 'طبي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_license', subGroupID: '', keywordID: 'ppt_lic_retail', uses: 0, names: <Name>[Name(code: 'en', value: 'Retail'), Name(code: 'ar', value: 'تجاري'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_license', subGroupID: '', keywordID: 'ppt_lic_hotel', uses: 0, names: <Name>[Name(code: 'en', value: 'Hotel'), Name(code: 'ar', value: 'فندقي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_license', subGroupID: '', keywordID: 'ppt_lic_industrial', uses: 0, names: <Name>[Name(code: 'en', value: 'Industrial'), Name(code: 'ar', value: 'صناعي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_rentalType', keywordID: 'rent_perDay', uses: 0, names: <Name>[Name(code: 'en', value: 'Per day'), Name(code: 'ar', value: 'باليوم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_rentalType', keywordID: 'rent_perMonth', uses: 0, names: <Name>[Name(code: 'en', value: 'Per Month'), Name(code: 'ar', value: 'بالشهر'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_rentValue', keywordID: 'rent_val_less', uses: 0, names: <Name>[Name(code: 'en', value: 'Less than 1 K EGP'), Name(code: 'ar', value: 'أقل من 1 ألف جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_rentValue', keywordID: 'rent_val_1_2_k', uses: 0, names: <Name>[Name(code: 'en', value: '1 K - 2 K EGP'), Name(code: 'ar', value: 'بين 1 ألف - 2 ألف جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_rentValue', keywordID: 'rent_val_2_5_k', uses: 0, names: <Name>[Name(code: 'en', value: '2 K - 5 K EGP'), Name(code: 'ar', value: 'بين 2 ألف - 5 آلاف جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_rentValue', keywordID: 'rent_val_5_10_k', uses: 0, names: <Name>[Name(code: 'en', value: '5 K - 10 K EGP'), Name(code: 'ar', value: 'بين 5 آلاف - 10 آلاف جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_rentValue', keywordID: 'rent_val_10_20_k', uses: 0, names: <Name>[Name(code: 'en', value: '10 K- 20 K EGP'), Name(code: 'ar', value: 'بين 10 آلاف - 20 ألف جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_rentValue', keywordID: 'rent_val_20_50_k', uses: 0, names: <Name>[Name(code: 'en', value: '20 K - 50 K EGP'), Name(code: 'ar', value: 'بين 20 ألف - 50 ألف جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_rentValue', keywordID: 'rent_val_more', uses: 0, names: <Name>[Name(code: 'en', value: 'More than 50 K EGP'), Name(code: 'ar', value: 'أكثر من 50 ألف جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_sellEGY', keywordID: 'pPriceEGY_100_200_k', uses: 0, names: <Name>[Name(code: 'en', value: '100K - 200K EGP'), Name(code: 'ar', value: 'بين  100 ألف - 200 ألف جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_sellEGY', keywordID: 'pPriceEGY_200_500_k', uses: 0, names: <Name>[Name(code: 'en', value: '200K - 500 EGP'), Name(code: 'ar', value: 'بين  200 ألف - 500 ألف جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_sellEGY', keywordID: 'pPriceEGY_500_1_m', uses: 0, names: <Name>[Name(code: 'en', value: '500k - 1M EGP'), Name(code: 'ar', value: 'بين  500 ألف - 1 مليون جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_sellEGY', keywordID: 'pPriceEGY_1_2_m', uses: 0, names: <Name>[Name(code: 'en', value: '1M - 2M EGP'), Name(code: 'ar', value: 'بين  1 مليون - 2 مليون جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_sellEGY', keywordID: 'pPriceEGY_2_5_m', uses: 0, names: <Name>[Name(code: 'en', value: '2M - 5M EGP'), Name(code: 'ar', value: 'بين  2 مليون - 5 مليون جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_sellEGY', keywordID: 'pPriceEGY_5_10_m', uses: 0, names: <Name>[Name(code: 'en', value: '5M - 10M EGP'), Name(code: 'ar', value: 'بين  5 مليون - 10 مليون جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_sellEGY', keywordID: 'pPriceEGY_10_20_m', uses: 0, names: <Name>[Name(code: 'en', value: '10M - 20M EGP'), Name(code: 'ar', value: 'بين  10 مليون - 20 مليون جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_sellEGY', keywordID: 'pPriceEGY_20_50_m', uses: 0, names: <Name>[Name(code: 'en', value: '20M - 50M EGP'), Name(code: 'ar', value: 'بين  20 مليون - 50 مليون جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_sellEGY', keywordID: 'pPriceEGY_50_100_m', uses: 0, names: <Name>[Name(code: 'en', value: '50M - 100M EGP'), Name(code: 'ar', value: 'بين  50 مليون - 100 مليون جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_sellEGY', keywordID: 'pPriceEGY_100_200_m', uses: 0, names: <Name>[Name(code: 'en', value: '100M - 200M EGP'), Name(code: 'ar', value: 'بين  100 مليون - 200 مليون جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_sellEGY', keywordID: 'pPriceEGY_more', uses: 0, names: <Name>[Name(code: 'en', value: 'More than 200M EGP'), Name(code: 'ar', value: 'أكثر من 200 مليون جم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_payments', keywordID: 'payment_cash', uses: 0, names: <Name>[Name(code: 'en', value: 'Cash Only'), Name(code: 'ar', value: 'كل المبلغ دفعة واحدة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_payments', keywordID: 'payment_installments', uses: 0, names: <Name>[Name(code: 'en', value: 'Installments Only'), Name(code: 'ar', value: 'على دفعات فقط'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_duration', keywordID: 'inst_dur_less', uses: 0, names: <Name>[Name(code: 'en', value: 'Less than 1 year'), Name(code: 'ar', value: 'أقل من 1 عام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_duration', keywordID: 'inst_dur_1_2', uses: 0, names: <Name>[Name(code: 'en', value: '1 - 2 years'), Name(code: 'ar', value: 'بين 1 - 2 عام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_duration', keywordID: 'inst_dur_2_5', uses: 0, names: <Name>[Name(code: 'en', value: '2 - 5 years'), Name(code: 'ar', value: 'بين 2 - 5 أعوام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_duration', keywordID: 'inst_dur_5_10', uses: 0, names: <Name>[Name(code: 'en', value: '5 - 10 years'), Name(code: 'ar', value: 'بين 5 - 10 أعوام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_duration', keywordID: 'inst_dur_10_20', uses: 0, names: <Name>[Name(code: 'en', value: '10 - 20 years'), Name(code: 'ar', value: 'بين 10 - 20 عام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_price', subGroupID: 'sub_ppt_price_duration', keywordID: 'inst_dur_more', uses: 0, names: <Name>[Name(code: 'en', value: 'More than 20 years'), Name(code: 'ar', value: 'أكثر من 20 عام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_rooms', keywordID: 'space_dining', uses: 0, names: <Name>[Name(code: 'en', value: 'Dining room'), Name(code: 'ar', value: 'غرفة طعام'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_rooms', keywordID: 'space_laundry', uses: 0, names: <Name>[Name(code: 'en', value: 'Laundry room'), Name(code: 'ar', value: 'غرفة غسيل ملابس'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_rooms', keywordID: 'space_living', uses: 0, names: <Name>[Name(code: 'en', value: 'Living room'), Name(code: 'ar', value: 'غرفة معيشة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_rooms', keywordID: 'space_maid', uses: 0, names: <Name>[Name(code: 'en', value: 'Maid room'), Name(code: 'ar', value: 'غرفة مربية'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_rooms', keywordID: 'space_balcony', uses: 0, names: <Name>[Name(code: 'en', value: 'Balcony'), Name(code: 'ar', value: 'شرفة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_rooms', keywordID: 'space_walkInCloset', uses: 0, names: <Name>[Name(code: 'en', value: 'Walk In closet'), Name(code: 'ar', value: 'غرفة دواليب ملابس'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_rooms', keywordID: 'space_barbecue', uses: 0, names: <Name>[Name(code: 'en', value: 'Barbecue area'), Name(code: 'ar', value: 'مساحة شواية'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_rooms', keywordID: 'space_garden', uses: 0, names: <Name>[Name(code: 'en', value: 'Private garden'), Name(code: 'ar', value: 'حديقة خاصة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_rooms', keywordID: 'space_privatePool', uses: 0, names: <Name>[Name(code: 'en', value: 'Private pool'), Name(code: 'ar', value: 'حمام سباحة خاص'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_parkings', keywordID: 'parking_1', uses: 0, names: <Name>[Name(code: 'en', value: '1'), Name(code: 'ar', value: '1'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_parkings', keywordID: 'parking_2', uses: 0, names: <Name>[Name(code: 'en', value: '2'), Name(code: 'ar', value: '2'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_parkings', keywordID: 'parking_3', uses: 0, names: <Name>[Name(code: 'en', value: '3'), Name(code: 'ar', value: '3'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_parkings', keywordID: 'parking_more', uses: 0, names: <Name>[Name(code: 'en', value: 'More than 3'), Name(code: 'ar', value: 'أكثر من 3'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bedrooms', keywordID: 'rooms_1', uses: 0, names: <Name>[Name(code: 'en', value: '1'), Name(code: 'ar', value: '1'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bedrooms', keywordID: 'rooms_2', uses: 0, names: <Name>[Name(code: 'en', value: '2'), Name(code: 'ar', value: '2'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bedrooms', keywordID: 'rooms_3', uses: 0, names: <Name>[Name(code: 'en', value: '3'), Name(code: 'ar', value: '3'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bedrooms', keywordID: 'rooms_4', uses: 0, names: <Name>[Name(code: 'en', value: '4'), Name(code: 'ar', value: '4'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bedrooms', keywordID: 'rooms_5', uses: 0, names: <Name>[Name(code: 'en', value: '5'), Name(code: 'ar', value: '5'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bedrooms', keywordID: 'rooms_6', uses: 0, names: <Name>[Name(code: 'en', value: '6'), Name(code: 'ar', value: '6'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bedrooms', keywordID: 'rooms_7', uses: 0, names: <Name>[Name(code: 'en', value: '7'), Name(code: 'ar', value: '7'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bedrooms', keywordID: 'rooms_more', uses: 0, names: <Name>[Name(code: 'en', value: 'More than 7'), Name(code: 'ar', value: 'أكثر من 7'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bathrooms', keywordID: 'bath_1', uses: 0, names: <Name>[Name(code: 'en', value: '1'), Name(code: 'ar', value: '1'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bathrooms', keywordID: 'bath_2', uses: 0, names: <Name>[Name(code: 'en', value: '2'), Name(code: 'ar', value: '2'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bathrooms', keywordID: 'bath_3', uses: 0, names: <Name>[Name(code: 'en', value: '3'), Name(code: 'ar', value: '3'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bathrooms', keywordID: 'bath_4', uses: 0, names: <Name>[Name(code: 'en', value: '4'), Name(code: 'ar', value: '4'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bathrooms', keywordID: 'bath_5', uses: 0, names: <Name>[Name(code: 'en', value: '5'), Name(code: 'ar', value: '5'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bathrooms', keywordID: 'bath_6', uses: 0, names: <Name>[Name(code: 'en', value: '6'), Name(code: 'ar', value: '6'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bathrooms', keywordID: 'bath_7', uses: 0, names: <Name>[Name(code: 'en', value: '7'), Name(code: 'ar', value: '7'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_spaces', subGroupID: 'sub_ppt_spaces_bathrooms', keywordID: 'bath_more', uses: 0, names: <Name>[Name(code: 'en', value: 'More than 7'), Name(code: 'ar', value: 'أكثر من 7'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_industrial', keywordID: 'pt_factory', uses: 0, names: <Name>[Name(code: 'en', value: 'Factory'), Name(code: 'ar', value: 'مصنع'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_educational', keywordID: 'pt_school', uses: 0, names: <Name>[Name(code: 'en', value: 'School'), Name(code: 'ar', value: 'مدرسة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_hotel', keywordID: 'pt_hotel', uses: 0, names: <Name>[Name(code: 'en', value: 'Hotel'), Name(code: 'ar', value: 'فندق'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_entertainment', keywordID: 'pt_gallery', uses: 0, names: <Name>[Name(code: 'en', value: 'Gallery'), Name(code: 'ar', value: 'معرض'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_entertainment', keywordID: 'pt_theatre', uses: 0, names: <Name>[Name(code: 'en', value: 'Theatre'), Name(code: 'ar', value: 'مسرح'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_medical', keywordID: 'space_spa', uses: 0, names: <Name>[Name(code: 'en', value: 'Spa'), Name(code: 'ar', value: 'منتجع صحي'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_medical', keywordID: 'pt_clinic', uses: 0, names: <Name>[Name(code: 'en', value: 'Clinic'), Name(code: 'ar', value: 'عيادة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_medical', keywordID: 'pt_hospital', uses: 0, names: <Name>[Name(code: 'en', value: 'Hospital'), Name(code: 'ar', value: 'مستشفى'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_sports', keywordID: 'pt_football', uses: 0, names: <Name>[Name(code: 'en', value: 'Football court'), Name(code: 'ar', value: 'ملعب كرة قدم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_sports', keywordID: 'pt_tennis', uses: 0, names: <Name>[Name(code: 'en', value: 'Tennis court'), Name(code: 'ar', value: 'ملعب كرة مضرب'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_sports', keywordID: 'pt_basketball', uses: 0, names: <Name>[Name(code: 'en', value: 'Basketball court'), Name(code: 'ar', value: 'ملعب كرة سلة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_sports', keywordID: 'pt_gym', uses: 0, names: <Name>[Name(code: 'en', value: 'Gym'), Name(code: 'ar', value: 'جيمنازيوم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_apartment', uses: 0, names: <Name>[Name(code: 'en', value: 'Apartment'), Name(code: 'ar', value: 'شقة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_furnishedApartment', uses: 0, names: <Name>[Name(code: 'en', value: 'Furnished Apartment'), Name(code: 'ar', value: 'شقة مفروشة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_loft', uses: 0, names: <Name>[Name(code: 'en', value: 'Loft'), Name(code: 'ar', value: 'لوفت'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_penthouse', uses: 0, names: <Name>[Name(code: 'en', value: 'Penthouse'), Name(code: 'ar', value: 'بنت هاوس'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_chalet', uses: 0, names: <Name>[Name(code: 'en', value: 'Chalet'), Name(code: 'ar', value: 'شاليه'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_twinhouse', uses: 0, names: <Name>[Name(code: 'en', value: 'Twin House'), Name(code: 'ar', value: 'توين هاوس'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_bungalow', uses: 0, names: <Name>[Name(code: 'en', value: 'Bungalows & Cabanas'), Name(code: 'ar', value: 'بونجالو'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_villa', uses: 0, names: <Name>[Name(code: 'en', value: 'Villa'), Name(code: 'ar', value: 'فيلا'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_condo', uses: 0, names: <Name>[Name(code: 'en', value: 'Condo'), Name(code: 'ar', value: 'كوندو'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_farm', uses: 0, names: <Name>[Name(code: 'en', value: 'Farm'), Name(code: 'ar', value: 'مزرعة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_townHome', uses: 0, names: <Name>[Name(code: 'en', value: 'Town Home'), Name(code: 'ar', value: 'تاون هوم'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_sharedRoom', uses: 0, names: <Name>[Name(code: 'en', value: 'Shared Rooms'), Name(code: 'ar', value: 'غرفة مشتركة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_duplix', uses: 0, names: <Name>[Name(code: 'en', value: 'Duplix'), Name(code: 'ar', value: 'دوبليكس'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_hotelApartment', uses: 0, names: <Name>[Name(code: 'en', value: 'Hotel apartment'), Name(code: 'ar', value: 'شقة فندقية'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_residential', keywordID: 'pt_studio', uses: 0, names: <Name>[Name(code: 'en', value: 'Studio'), Name(code: 'ar', value: 'ستوديو'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_retail', keywordID: 'pt_store', uses: 0, names: <Name>[Name(code: 'en', value: 'Store & Shop'), Name(code: 'ar', value: 'محل و متجر'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_retail', keywordID: 'pt_supermarket', uses: 0, names: <Name>[Name(code: 'en', value: 'Supermarket'), Name(code: 'ar', value: 'بقالة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_retail', keywordID: 'pt_warehouse', uses: 0, names: <Name>[Name(code: 'en', value: 'Warehouse '), Name(code: 'ar', value: 'مخزن و مستودع'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_retail', keywordID: 'pt_hall', uses: 0, names: <Name>[Name(code: 'en', value: 'Events Halls'), Name(code: 'ar', value: 'قاعة'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_retail', keywordID: 'pt_bank', uses: 0, names: <Name>[Name(code: 'en', value: 'Bank'), Name(code: 'ar', value: 'بنك'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_retail', keywordID: 'pt_restaurant', uses: 0, names: <Name>[Name(code: 'en', value: 'Restaurant & Café'), Name(code: 'ar', value: 'مطعم و مقهى'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_retail', keywordID: 'pt_pharmacy', uses: 0, names: <Name>[Name(code: 'en', value: 'Pharmacy'), Name(code: 'ar', value: 'صيدلية'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_retail', keywordID: 'pt_studio', uses: 0, names: <Name>[Name(code: 'en', value: 'Studio'), Name(code: 'ar', value: 'ستوديو'),],),
        const Keyword(flyerType: FlyerType.rentalProperty, groupID: 'group_ppt_type', subGroupID: 'ppt_lic_administration', keywordID: 'pt_office', uses: 0, names: <Name>[Name(code: 'en', value: 'Office'), Name(code: 'ar', value: 'مكتب إداري'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_wasteDisposal', keywordID: 'prd_app_waste_compactor', uses: 0, names: <Name>[Name(code: 'en', value: 'Trash compactor'), Name(code: 'ar', value: 'حاويات ضغط قمامة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_wasteDisposal', keywordID: 'prd_app_waste_disposer', uses: 0, names: <Name>[Name(code: 'en', value: 'Food waste disposers'), Name(code: 'ar', value: 'مطاحن فضلات طعام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_snacks', keywordID: 'prd_app_snack_icecream', uses: 0, names: <Name>[Name(code: 'en', value: 'Ice cream makers'), Name(code: 'ar', value: 'ماكينات آيس كريم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_snacks', keywordID: 'prd_app_snack_popcorn', uses: 0, names: <Name>[Name(code: 'en', value: 'Popcorn makers'), Name(code: 'ar', value: 'ماكينات فشار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_snacks', keywordID: 'prd_app_snack_toaster', uses: 0, names: <Name>[Name(code: 'en', value: 'Toasters'), Name(code: 'ar', value: 'محمصة خبز'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_snacks', keywordID: 'prd_app_snack_waffle', uses: 0, names: <Name>[Name(code: 'en', value: 'Waffle makers'), Name(code: 'ar', value: 'ماكينات وافل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_snacks', keywordID: 'prd_app_snack_bread', uses: 0, names: <Name>[Name(code: 'en', value: 'Bread machine'), Name(code: 'ar', value: 'ماكينات خبز'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_snacks', keywordID: 'prd_app_snack_canOpener', uses: 0, names: <Name>[Name(code: 'en', value: 'Can opener'), Name(code: 'ar', value: 'فواتح معلبات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_refrigeration', keywordID: 'prd_app_ref_fridge', uses: 0, names: <Name>[Name(code: 'en', value: 'Fridges'), Name(code: 'ar', value: 'ثلاجات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_refrigeration', keywordID: 'prd_app_ref_freezer', uses: 0, names: <Name>[Name(code: 'en', value: 'Freezers'), Name(code: 'ar', value: 'ثلاجات تجميد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_refrigeration', keywordID: 'prd_app_ref_icemaker', uses: 0, names: <Name>[Name(code: 'en', value: 'Ice makers'), Name(code: 'ar', value: 'ماكينات ثلج'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_refrigeration', keywordID: 'prd_app_ref_water', uses: 0, names: <Name>[Name(code: 'en', value: 'Water Dispensers'), Name(code: 'ar', value: 'كولدير مياه'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_outdoorCooking', keywordID: 'prd_app_outcook_grill', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor Grills'), Name(code: 'ar', value: 'شوايات و أفران خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_outdoorCooking', keywordID: 'prd_app_outcook_grillTools', uses: 0, names: <Name>[Name(code: 'en', value: 'Grill tools and accessories'), Name(code: 'ar', value: 'أدوات و اكسسوارات شوي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_outdoorCooking', keywordID: 'prd_app_outcook_oven', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoors Ovens'), Name(code: 'ar', value: 'أفران خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_outdoorCooking', keywordID: 'prd_app_outcook_smoker', uses: 0, names: <Name>[Name(code: 'en', value: 'Smokers'), Name(code: 'ar', value: 'أفران مدخنة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_media', keywordID: 'prd_app_media_tv', uses: 0, names: <Name>[Name(code: 'en', value: 'Televisions'), Name(code: 'ar', value: 'تلفزيونات و شاشات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_media', keywordID: 'prd_app_media_soundSystem', uses: 0, names: <Name>[Name(code: 'en', value: 'Sound systems'), Name(code: 'ar', value: 'أنظمة صوت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_indoorCooking', keywordID: 'prd_app_incook_microwave', uses: 0, names: <Name>[Name(code: 'en', value: 'Microwave ovens'), Name(code: 'ar', value: 'فرن مايكرويف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_indoorCooking', keywordID: 'prd_app_incook_fryer', uses: 0, names: <Name>[Name(code: 'en', value: 'Fryers'), Name(code: 'ar', value: 'قلايات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_indoorCooking', keywordID: 'prd_app_incook_elecGrill', uses: 0, names: <Name>[Name(code: 'en', value: 'Electric grills'), Name(code: 'ar', value: 'شوايات كهربائية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_indoorCooking', keywordID: 'prd_app_incook_cooktop', uses: 0, names: <Name>[Name(code: 'en', value: 'Cooktops'), Name(code: 'ar', value: 'بوتاجاز سطحي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_indoorCooking', keywordID: 'prd_app_incook_range', uses: 0, names: <Name>[Name(code: 'en', value: 'Gas & Electric ranges'), Name(code: 'ar', value: 'بوتاجاز كهربائي أو غاز'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_indoorCooking', keywordID: 'prd_app_incook_oven', uses: 0, names: <Name>[Name(code: 'en', value: 'Gas & Electric Ovens'), Name(code: 'ar', value: 'فرن كهربائي أو غاز'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_indoorCooking', keywordID: 'prd_app_incook_hood', uses: 0, names: <Name>[Name(code: 'en', value: 'Range hoods & vents'), Name(code: 'ar', value: 'شفاطات بوتاجاز'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_indoorCooking', keywordID: 'prd_app_incook_skillet', uses: 0, names: <Name>[Name(code: 'en', value: 'Electric skillets'), Name(code: 'ar', value: 'مقلاه كهربائية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_indoorCooking', keywordID: 'prd_app_incook_rooster', uses: 0, names: <Name>[Name(code: 'en', value: 'Electric roaster ovens'), Name(code: 'ar', value: 'فرن شواء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_indoorCooking', keywordID: 'prd_app_incook_hotPlate', uses: 0, names: <Name>[Name(code: 'en', value: 'Hot plates & burners'), Name(code: 'ar', value: 'مواقد و لوحات ساخنة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_housekeeping', keywordID: 'prd_app_hk_washingMachine', uses: 0, names: <Name>[Name(code: 'en', value: 'Washing & Drying machines'), Name(code: 'ar', value: 'مغاسل و مناشف ملابس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_housekeeping', keywordID: 'prd_app_hk_dishWasher', uses: 0, names: <Name>[Name(code: 'en', value: 'Dish washer'), Name(code: 'ar', value: 'مغسلة صحون'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_housekeeping', keywordID: 'prd_app_hk_warmingDrawers', uses: 0, names: <Name>[Name(code: 'en', value: 'Warming drawers'), Name(code: 'ar', value: 'أدراج تدفئة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_housekeeping', keywordID: 'prd_app_hk_vacuum', uses: 0, names: <Name>[Name(code: 'en', value: 'Vacuum cleaner'), Name(code: 'ar', value: 'مكانس كهربائية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_housekeeping', keywordID: 'prd_app_hk_iron', uses: 0, names: <Name>[Name(code: 'en', value: 'Irons'), Name(code: 'ar', value: 'مكواه '),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_housekeeping', keywordID: 'prd_app_hk_steamer', uses: 0, names: <Name>[Name(code: 'en', value: 'Garment steamers'), Name(code: 'ar', value: 'مكواه بخارية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_housekeeping', keywordID: 'prd_app_hk_carpet', uses: 0, names: <Name>[Name(code: 'en', value: 'Carpet cleaners'), Name(code: 'ar', value: 'مغاسل سجاد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_housekeeping', keywordID: 'prd_app_hk_sewing', uses: 0, names: <Name>[Name(code: 'en', value: 'Sewing machines'), Name(code: 'ar', value: 'ماكينات خياطة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_foodProcessors', keywordID: 'prd_app_pro_slowCooker', uses: 0, names: <Name>[Name(code: 'en', value: 'Slow cookers'), Name(code: 'ar', value: 'مواقد بطيئة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_foodProcessors', keywordID: 'prd_app_pro_pro', uses: 0, names: <Name>[Name(code: 'en', value: 'Food processor'), Name(code: 'ar', value: 'أجهزة معالجة للطعام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_foodProcessors', keywordID: 'prd_app_pro_meat', uses: 0, names: <Name>[Name(code: 'en', value: 'Meat grinders'), Name(code: 'ar', value: 'مطاحن لحوم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_foodProcessors', keywordID: 'prd_app_pro_rice', uses: 0, names: <Name>[Name(code: 'en', value: 'Rice cookers & steamers'), Name(code: 'ar', value: 'حلل طهي أرز'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_foodProcessors', keywordID: 'prd_app_pro_dehydrator', uses: 0, names: <Name>[Name(code: 'en', value: 'Food Dehydrators'), Name(code: 'ar', value: 'مجففات طعام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_foodProcessors', keywordID: 'prd_app_pro_mixer', uses: 0, names: <Name>[Name(code: 'en', value: 'Food Mixers'), Name(code: 'ar', value: 'آلة عجن و خلط'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_drinks', keywordID: 'prd_app_drink_coffeeMaker', uses: 0, names: <Name>[Name(code: 'en', value: 'Coffee maker'), Name(code: 'ar', value: 'ماكينات قهوة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_drinks', keywordID: 'prd_app_drink_coffeeGrinder', uses: 0, names: <Name>[Name(code: 'en', value: 'Coffee grinder'), Name(code: 'ar', value: 'مطاحن قهوة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_drinks', keywordID: 'prd_app_drink_espresso', uses: 0, names: <Name>[Name(code: 'en', value: 'Espresso machine'), Name(code: 'ar', value: 'ماكينات اسبريسو'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_drinks', keywordID: 'prd_app_drink_blender', uses: 0, names: <Name>[Name(code: 'en', value: 'Blender'), Name(code: 'ar', value: 'خلاطات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_drinks', keywordID: 'prd_app_drink_juicer', uses: 0, names: <Name>[Name(code: 'en', value: 'Juicers'), Name(code: 'ar', value: 'عصارات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_drinks', keywordID: 'prd_app_drink_kettle', uses: 0, names: <Name>[Name(code: 'en', value: 'Boilers / Kettles'), Name(code: 'ar', value: 'غلايات و سخانات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_bathroom', keywordID: 'prd_app_bath_handDryer', uses: 0, names: <Name>[Name(code: 'en', value: 'Hand dryer'), Name(code: 'ar', value: 'منشفة أيدي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_appliances', subGroupID: 'sub_prd_app_bathroom', keywordID: 'prd_app_bath_hairDryer', uses: 0, names: <Name>[Name(code: 'en', value: 'Hair dryer'), Name(code: 'ar', value: 'سشوار شعر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_windows', keywordID: 'prd_doors_win_glassPanel', uses: 0, names: <Name>[Name(code: 'en', value: 'Window panels'), Name(code: 'ar', value: 'قطاعات شبابيك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_windows', keywordID: 'prd_doors_win_skyLight', uses: 0, names: <Name>[Name(code: 'en', value: 'Skylights'), Name(code: 'ar', value: 'قطاعات شبابيك سقفية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_doors_shutters', keywordID: 'prd_doors_shutters_metal', uses: 0, names: <Name>[Name(code: 'en', value: 'Metal shutters'), Name(code: 'ar', value: 'شيش حصيرة معدني'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_doors_shutters', keywordID: 'prd_doors_shutters_aluminum', uses: 0, names: <Name>[Name(code: 'en', value: 'Aluminum shutters'), Name(code: 'ar', value: 'شيش حصيرة ألومنيوم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_hinges', uses: 0, names: <Name>[Name(code: 'en', value: 'Hinges & Accessories'), Name(code: 'ar', value: 'مفصلات و اكسسوارات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_doorbell', uses: 0, names: <Name>[Name(code: 'en', value: 'Door Chimes'), Name(code: 'ar', value: 'أجراس أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_entrySet', uses: 0, names: <Name>[Name(code: 'en', value: 'Door Entry sets'), Name(code: 'ar', value: 'أطقم مقابض أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_lever', uses: 0, names: <Name>[Name(code: 'en', value: 'Door levers'), Name(code: 'ar', value: 'أكر أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_knob', uses: 0, names: <Name>[Name(code: 'en', value: 'Door knobs'), Name(code: 'ar', value: 'مقابض أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_knocker', uses: 0, names: <Name>[Name(code: 'en', value: 'Door knockers'), Name(code: 'ar', value: 'مطارق أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_lock', uses: 0, names: <Name>[Name(code: 'en', value: 'Door locks'), Name(code: 'ar', value: 'أقفال أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_stop', uses: 0, names: <Name>[Name(code: 'en', value: 'Door stops & bumpers'), Name(code: 'ar', value: 'مصدات أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_sliding', uses: 0, names: <Name>[Name(code: 'en', value: 'Sliding doors systems'), Name(code: 'ar', value: 'مجاري أبواب منزلقة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_hook', uses: 0, names: <Name>[Name(code: 'en', value: 'Door hooks'), Name(code: 'ar', value: 'كلّاب أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_eye', uses: 0, names: <Name>[Name(code: 'en', value: 'Door eye'), Name(code: 'ar', value: 'عيون أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_sign', uses: 0, names: <Name>[Name(code: 'en', value: 'Door signs'), Name(code: 'ar', value: 'لافتات أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_dust', uses: 0, names: <Name>[Name(code: 'en', value: 'Door dust draught'), Name(code: 'ar', value: 'فرشاة تراب '),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_closer', uses: 0, names: <Name>[Name(code: 'en', value: 'Door closers'), Name(code: 'ar', value: 'غالقات أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_hardware', keywordID: 'prd_doors_hardware_tint', uses: 0, names: <Name>[Name(code: 'en', value: 'Window tint films'), Name(code: 'ar', value: 'أفلام زجاج شبابيك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_doors', keywordID: 'prd_doors_doors_front', uses: 0, names: <Name>[Name(code: 'en', value: 'Front doors'), Name(code: 'ar', value: 'أبواب أمامية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_doors', keywordID: 'prd_doors_doors_interior', uses: 0, names: <Name>[Name(code: 'en', value: 'Interior doors'), Name(code: 'ar', value: 'أبواب داخلية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_doors', keywordID: 'prd_doors_doors_folding', uses: 0, names: <Name>[Name(code: 'en', value: 'Folding &  Accordion doors'), Name(code: 'ar', value: 'أبواب قابلة للطي و أكورديون'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_doors', keywordID: 'prd_doors_doors_shower', uses: 0, names: <Name>[Name(code: 'en', value: 'Shower doors'), Name(code: 'ar', value: 'أبواب دش استحمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_doors', keywordID: 'prd_doors_doors_patio', uses: 0, names: <Name>[Name(code: 'en', value: 'Patio & Sliding doors'), Name(code: 'ar', value: 'أبواب تراس منزلقة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_doors', keywordID: 'prd_doors_doors_screen', uses: 0, names: <Name>[Name(code: 'en', value: 'Screen & Mesh doors'), Name(code: 'ar', value: 'أبواب سلك شبكي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_doors', keywordID: 'prd_doors_doors_garage', uses: 0, names: <Name>[Name(code: 'en', value: 'Garage doors'), Name(code: 'ar', value: 'أبواب جراج'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_doors', keywordID: 'prd_doors_doors_metalGate', uses: 0, names: <Name>[Name(code: 'en', value: 'Metal gates'), Name(code: 'ar', value: 'بوابات معدنية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_doors', keywordID: 'prd_doors_doors_escape', uses: 0, names: <Name>[Name(code: 'en', value: 'Escape doors'), Name(code: 'ar', value: 'أبواب هروب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_doors', subGroupID: 'sub_prd_door_doors', keywordID: 'prd_doors_doors_blast', uses: 0, names: <Name>[Name(code: 'en', value: 'Blast proof doors'), Name(code: 'ar', value: 'أبواب مقاومة للإنفجار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_powerStorage', keywordID: 'prd_elec_storage_rechargeable', uses: 0, names: <Name>[Name(code: 'en', value: 'Rechargeable batteries'), Name(code: 'ar', value: 'بطاريات قابلة للشحن'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_powerStorage', keywordID: 'prd_elec_storage_nonRechargeable', uses: 0, names: <Name>[Name(code: 'en', value: 'Non Rechargeable batteries'), Name(code: 'ar', value: 'بطاريات غير قابلة للشحن'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_powerStorage', keywordID: 'prd_elec_storage_accessories', uses: 0, names: <Name>[Name(code: 'en', value: 'Battery accessories'), Name(code: 'ar', value: 'اكسسوارات بطاريات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_powerStorage', keywordID: 'prd_elec_storage_portable', uses: 0, names: <Name>[Name(code: 'en', value: 'Portable power storage'), Name(code: 'ar', value: 'تخزين طاقة متنقل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_organization', keywordID: 'prd_elec_org_load', uses: 0, names: <Name>[Name(code: 'en', value: 'Load centers'), Name(code: 'ar', value: 'مراكز حمل كهربي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_organization', keywordID: 'prd_elec_org_conduit', uses: 0, names: <Name>[Name(code: 'en', value: 'Conduit & fittings'), Name(code: 'ar', value: 'خراطيم كهرباء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_organization', keywordID: 'prd_elec_org_junction', uses: 0, names: <Name>[Name(code: 'en', value: 'Junction boxes & covers'), Name(code: 'ar', value: 'بواط توزيع كهرباء و أغطيتها'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_organization', keywordID: 'prd_elec_org_hook', uses: 0, names: <Name>[Name(code: 'en', value: 'Hooks & cable organizers'), Name(code: 'ar', value: 'خطافات و منظمات أسلاك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_instruments', keywordID: 'prd_elec_instr_factor', uses: 0, names: <Name>[Name(code: 'en', value: 'Power factor controllers'), Name(code: 'ar', value: 'منظمات عامل طاقة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_instruments', keywordID: 'prd_elec_instr_measure', uses: 0, names: <Name>[Name(code: 'en', value: 'Power measurement devices'), Name(code: 'ar', value: 'أجهزة قياس كهرباء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_instruments', keywordID: 'prd_elec_instr_clamp', uses: 0, names: <Name>[Name(code: 'en', value: 'Power clamp meters'), Name(code: 'ar', value: 'أجهزة قياس كهرباء كلّابة معلقة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_instruments', keywordID: 'prd_elec_instr_powerMeter', uses: 0, names: <Name>[Name(code: 'en', value: 'Power meters'), Name(code: 'ar', value: 'عداد كهرباء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_instruments', keywordID: 'prd_elec_instr_resistance', uses: 0, names: <Name>[Name(code: 'en', value: 'Resistance testers'), Name(code: 'ar', value: 'فاحص مقاومة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_instruments', keywordID: 'prd_elec_instr_transformer', uses: 0, names: <Name>[Name(code: 'en', value: 'Transformers'), Name(code: 'ar', value: 'محولات كهربائية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_instruments', keywordID: 'prd_elec_instr_frequency', uses: 0, names: <Name>[Name(code: 'en', value: 'Frequency inverters'), Name(code: 'ar', value: 'عاكس تردد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_instruments', keywordID: 'prd_elec_instr_relay', uses: 0, names: <Name>[Name(code: 'en', value: 'Current relays'), Name(code: 'ar', value: 'ممررات تيار كهربي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_instruments', keywordID: 'prd_elec_inst_dc', uses: 0, names: <Name>[Name(code: 'en', value: 'Power supplies'), Name(code: 'ar', value: 'مزودات طاقة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_instruments', keywordID: 'prd_elec_inst_inverter', uses: 0, names: <Name>[Name(code: 'en', value: 'Power inverters'), Name(code: 'ar', value: 'محولات طاقة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_instruments', keywordID: 'prd_elec_inst_regulator', uses: 0, names: <Name>[Name(code: 'en', value: 'Voltage regulators'), Name(code: 'ar', value: 'منظمات جهد كهربي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_generators', keywordID: 'prd_elec_gen_solar', uses: 0, names: <Name>[Name(code: 'en', value: 'Solar power'), Name(code: 'ar', value: 'طاقة شمسية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_generators', keywordID: 'prd_elec_gen_wind', uses: 0, names: <Name>[Name(code: 'en', value: 'Wind power'), Name(code: 'ar', value: 'طاقة رياح'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_generators', keywordID: 'prd_elec_gen_hydro', uses: 0, names: <Name>[Name(code: 'en', value: 'Hydro power'), Name(code: 'ar', value: 'طاقة تيارات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_generators', keywordID: 'prd_elec_gen_steam', uses: 0, names: <Name>[Name(code: 'en', value: 'Steam power'), Name(code: 'ar', value: 'طاقة بخار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_generators', keywordID: 'prd_elec_gen_diesel', uses: 0, names: <Name>[Name(code: 'en', value: 'Diesel power'), Name(code: 'ar', value: 'طاقة ديزل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_generators', keywordID: 'prd_elec_gen_gasoline', uses: 0, names: <Name>[Name(code: 'en', value: 'Gasoline power'), Name(code: 'ar', value: 'طاقة بنزين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_generators', keywordID: 'prd_elec_gen_gas', uses: 0, names: <Name>[Name(code: 'en', value: 'Natural gas power'), Name(code: 'ar', value: 'طاقة غاز طبيعي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_generators', keywordID: 'prd_elec_gen_hydrogen', uses: 0, names: <Name>[Name(code: 'en', value: 'Hydrogen power'), Name(code: 'ar', value: 'طاقة هيدروجين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_switches', keywordID: 'prd_elec_switches_outlet', uses: 0, names: <Name>[Name(code: 'en', value: 'Wall switches & Outlets'), Name(code: 'ar', value: 'مفاتيح كهربائية و إضاءة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_switches', keywordID: 'prd_elec_switches_thermostat', uses: 0, names: <Name>[Name(code: 'en', value: 'Thermostats'), Name(code: 'ar', value: 'ترموستات منظم حرارة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_switches', keywordID: 'prd_elec_switches_dimmer', uses: 0, names: <Name>[Name(code: 'en', value: 'Dimmers'), Name(code: 'ar', value: 'متحكم و معتم قوة الإضاءة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_switches', keywordID: 'prd_elec_switches_plate', uses: 0, names: <Name>[Name(code: 'en', value: 'Switch plates & outlet covers'), Name(code: 'ar', value: 'لوحات و أغطية كهربائية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_switches', keywordID: 'prd_elec_switches_circuit', uses: 0, names: <Name>[Name(code: 'en', value: 'Circuit breakers & fuses'), Name(code: 'ar', value: 'قواطع و فيوزات كهربائية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_switches', keywordID: 'prd_elec_switches_doorbell', uses: 0, names: <Name>[Name(code: 'en', value: 'Doorbells'), Name(code: 'ar', value: 'أجراس أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_motors', keywordID: 'prd_elec_motor_ac', uses: 0, names: <Name>[Name(code: 'en', value: 'AC motors'), Name(code: 'ar', value: 'مواتير تيار متردد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_motors', keywordID: 'prd_elec_motor_dc', uses: 0, names: <Name>[Name(code: 'en', value: 'DC motors'), Name(code: 'ar', value: 'مواتير تيار ثابت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_motors', keywordID: 'prd_elec_motor_vibro', uses: 0, names: <Name>[Name(code: 'en', value: 'Vibration motors'), Name(code: 'ar', value: 'مواتير اهتزاز'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_motors', keywordID: 'prd_elec_motor_controller', uses: 0, names: <Name>[Name(code: 'en', value: 'Motor controllers & drivers'), Name(code: 'ar', value: 'متحكمات مواتير'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_motors', keywordID: 'prd_elec_motor_part', uses: 0, names: <Name>[Name(code: 'en', value: 'Motor parts'), Name(code: 'ar', value: 'أجزاء مواتير'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_connectors', keywordID: 'prd_elec_connectors_alligator', uses: 0, names: <Name>[Name(code: 'en', value: 'Alligator clips'), Name(code: 'ar', value: 'مقلمة تمساح'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_connectors', keywordID: 'prd_elec_connectors_connector', uses: 0, names: <Name>[Name(code: 'en', value: 'Power connectors'), Name(code: 'ar', value: 'لقم توصيل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_connectors', keywordID: 'prd_elec_connectors_terminal', uses: 0, names: <Name>[Name(code: 'en', value: 'Terminals & accessories'), Name(code: 'ar', value: 'أقطاب و اكسسوارات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_connectors', keywordID: 'prd_elec_connectors_strip', uses: 0, names: <Name>[Name(code: 'en', value: 'Power strips'), Name(code: 'ar', value: 'مشترك كهربائي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_connectors', keywordID: 'prd_elec_connectors_socket', uses: 0, names: <Name>[Name(code: 'en', value: 'Sockets & plugs'), Name(code: 'ar', value: 'مقابس كهرباء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_connectors', keywordID: 'prd_elec_connectors_adapter', uses: 0, names: <Name>[Name(code: 'en', value: 'Adapters'), Name(code: 'ar', value: 'محولات كهربائية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_cables', keywordID: 'prd_elec_cables_wire', uses: 0, names: <Name>[Name(code: 'en', value: 'Cables & Wires'), Name(code: 'ar', value: 'أسلاك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_electricity', subGroupID: 'sub_prd_elec_cables', keywordID: 'prd_elec_cables_extension', uses: 0, names: <Name>[Name(code: 'en', value: 'Extension cables'), Name(code: 'ar', value: 'أسلاك إطالة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_pumpsCont', keywordID: 'prd_fireFighting_pump_pump', uses: 0, names: <Name>[Name(code: 'en', value: 'Fire pumps'), Name(code: 'ar', value: 'مضخات حريق'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_pumpsCont', keywordID: 'prd_fireFighting_pump_filter', uses: 0, names: <Name>[Name(code: 'en', value: 'Filtration systems'), Name(code: 'ar', value: 'أنظمة تصفية مياه'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_pumpsCont', keywordID: 'prd_fireFighting_pump_system', uses: 0, names: <Name>[Name(code: 'en', value: 'Wet systems'), Name(code: 'ar', value: 'أنظمة إطفاء سائلة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_pumpsCont', keywordID: 'prd_fireFighting_pump_foamSystems', uses: 0, names: <Name>[Name(code: 'en', value: 'Foam & Powder based systems'), Name(code: 'ar', value: 'أنظمة إطفاء فوم و بودرة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_pumpsCont', keywordID: 'prd_fireFighting_pump_gasSystems', uses: 0, names: <Name>[Name(code: 'en', value: 'Gas based systems'), Name(code: 'ar', value: 'أنظمة إطفاء غازية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_equip', keywordID: 'prd_fireFighting_equip_hydrant', uses: 0, names: <Name>[Name(code: 'en', value: 'Fire hydrants'), Name(code: 'ar', value: 'صنبور إطفاء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_equip', keywordID: 'prd_fireFighting_equip_extinguisher', uses: 0, names: <Name>[Name(code: 'en', value: 'Fire Extinguishers'), Name(code: 'ar', value: 'طفاية حريق'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_equip', keywordID: 'prd_fireFighting_equip_pipe', uses: 0, names: <Name>[Name(code: 'en', value: 'Pipes, Valves & Risers'), Name(code: 'ar', value: 'مواسير، مفاتيح، صواعد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_equip', keywordID: 'prd_fireFighting_equip_reel', uses: 0, names: <Name>[Name(code: 'en', value: 'Reels & Cabinets'), Name(code: 'ar', value: 'بكرة خرطوم حريق'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_equip', keywordID: 'prd_fireFighting_equip_hose', uses: 0, names: <Name>[Name(code: 'en', value: 'Hoses & Accessories'), Name(code: 'ar', value: 'خراطيم حريق و اكسسوارات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_equip', keywordID: 'prd_fireFighting_equip_curtains', uses: 0, names: <Name>[Name(code: 'en', value: 'Fire curtains'), Name(code: 'ar', value: 'ستائر حريق'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_clothes', keywordID: 'prd_fireFighting_equip_suit', uses: 0, names: <Name>[Name(code: 'en', value: 'Suits'), Name(code: 'ar', value: 'بدلة إطفاء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_clothes', keywordID: 'prd_fireFighting_equip_helmet', uses: 0, names: <Name>[Name(code: 'en', value: 'Helmets & hoods'), Name(code: 'ar', value: 'خوذة و أوشحة إطفاء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_clothes', keywordID: 'prd_fireFighting_equip_glove', uses: 0, names: <Name>[Name(code: 'en', value: 'Gloves'), Name(code: 'ar', value: 'قفازات إطفاء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_clothes', keywordID: 'prd_fireFighting_equip_boots', uses: 0, names: <Name>[Name(code: 'en', value: 'Boots'), Name(code: 'ar', value: 'أحذية إطفاء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_clothes', keywordID: 'prd_fireFighting_equip_torches', uses: 0, names: <Name>[Name(code: 'en', value: 'Drip torches'), Name(code: 'ar', value: 'شعلة تنقيط'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_clothes', keywordID: 'prd_fireFighting_equip_breathing', uses: 0, names: <Name>[Name(code: 'en', value: 'Breathing apparatus'), Name(code: 'ar', value: 'جهاز تنفس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_detectors', keywordID: 'prd_fireFighting_detectors_alarm', uses: 0, names: <Name>[Name(code: 'en', value: 'Fire detection & Alarm systems'), Name(code: 'ar', value: 'أنظمة كشف و إنذار حرائق'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_fireFighting', subGroupID: 'sub_prd_fire_detectors', keywordID: 'prd_fireFighting_detectors_control', uses: 0, names: <Name>[Name(code: 'en', value: 'Extinguishing control systems'), Name(code: 'ar', value: 'أنظمة تحكم إطفاء حرائق'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_skirting', keywordID: 'prd_floors_skirting_skirting', uses: 0, names: <Name>[Name(code: 'en', value: 'Floor skirting'), Name(code: 'ar', value: 'وزر أرضيات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_ceramic', uses: 0, names: <Name>[Name(code: 'en', value: 'Ceramic'), Name(code: 'ar', value: 'سيراميك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_porcelain', uses: 0, names: <Name>[Name(code: 'en', value: 'Porcelain'), Name(code: 'ar', value: 'بورسلين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_mosaic', uses: 0, names: <Name>[Name(code: 'en', value: 'Mosaic'), Name(code: 'ar', value: 'موزاييك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_stones', uses: 0, names: <Name>[Name(code: 'en', value: 'Stones'), Name(code: 'ar', value: 'حجر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_marble', uses: 0, names: <Name>[Name(code: 'en', value: 'Marble'), Name(code: 'ar', value: 'رخام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_granite', uses: 0, names: <Name>[Name(code: 'en', value: 'Granite'), Name(code: 'ar', value: 'جرانيت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_interlock', uses: 0, names: <Name>[Name(code: 'en', value: 'Interlock & brick tiles'), Name(code: 'ar', value: 'إنترلوك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_cork', uses: 0, names: <Name>[Name(code: 'en', value: 'Cork tiles'), Name(code: 'ar', value: 'كورك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_parquet', uses: 0, names: <Name>[Name(code: 'en', value: 'Parquet'), Name(code: 'ar', value: 'باركيه'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_glass', uses: 0, names: <Name>[Name(code: 'en', value: 'Acrylic & Glass tiles'), Name(code: 'ar', value: 'زجاج و أكريليك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_grc', uses: 0, names: <Name>[Name(code: 'en', value: 'GRC tiles'), Name(code: 'ar', value: 'جي آر سي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_metal', uses: 0, names: <Name>[Name(code: 'en', value: 'Metal tiles'), Name(code: 'ar', value: 'معادن'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_terrazzo', uses: 0, names: <Name>[Name(code: 'en', value: 'Terrazzo tiles'), Name(code: 'ar', value: 'تيرازو'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_tiles', keywordID: 'prd_floors_tiles_medallions', uses: 0, names: <Name>[Name(code: 'en', value: 'Floor Medallion & Inlays'), Name(code: 'ar', value: 'ميدالية أرض'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_planks', keywordID: 'prd_floors_planks_bamboo', uses: 0, names: <Name>[Name(code: 'en', value: 'Bamboo flooring'), Name(code: 'ar', value: 'بامبو'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_planks', keywordID: 'prd_floors_planks_engineered', uses: 0, names: <Name>[Name(code: 'en', value: 'Engineered wood plank'), Name(code: 'ar', value: 'ألواح خشب هندسية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_planks', keywordID: 'prd_floors_planks_hardwood', uses: 0, names: <Name>[Name(code: 'en', value: 'Hardwood plank'), Name(code: 'ar', value: 'ألواح خب صلب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_planks', keywordID: 'prd_floors_planks_laminate', uses: 0, names: <Name>[Name(code: 'en', value: 'Laminate plank'), Name(code: 'ar', value: 'قشرة خشب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_planks', keywordID: 'prd_floors_planks_wpc', uses: 0, names: <Name>[Name(code: 'en', value: 'WPC plank'), Name(code: 'ar', value: 'ألواح دبليو بي سي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_paving', keywordID: 'prd_floors_paving_screed', uses: 0, names: <Name>[Name(code: 'en', value: 'Cement screed'), Name(code: 'ar', value: 'أرضية أسمنتية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_paving', keywordID: 'prd_floors_paving_epoxy', uses: 0, names: <Name>[Name(code: 'en', value: 'Epoxy coating'), Name(code: 'ar', value: 'إيبوكسي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_paving', keywordID: 'prd_floors_paving_asphalt', uses: 0, names: <Name>[Name(code: 'en', value: 'Asphalt flooring'), Name(code: 'ar', value: 'أسفلت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_covering', keywordID: 'prd_floors_covering_vinyl', uses: 0, names: <Name>[Name(code: 'en', value: 'Vinyl flooring'), Name(code: 'ar', value: 'فينيل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_covering', keywordID: 'prd_floors_covering_carpet', uses: 0, names: <Name>[Name(code: 'en', value: 'Carpet flooring'), Name(code: 'ar', value: 'سجاد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_covering', keywordID: 'prd_floors_covering_raised', uses: 0, names: <Name>[Name(code: 'en', value: 'Raised flooring'), Name(code: 'ar', value: 'أرضية مرتفعة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_floors', subGroupID: 'sub_prd_floors_covering', keywordID: 'prd_floors_covering_rubber', uses: 0, names: <Name>[Name(code: 'en', value: 'Rubber mats'), Name(code: 'ar', value: 'أرضية مطاط'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_wasteDisposal', keywordID: 'prd_furn_waste_small', uses: 0, names: <Name>[Name(code: 'en', value: 'Small trash cans'), Name(code: 'ar', value: 'سلات قمامة صغيرة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_wasteDisposal', keywordID: 'prd_furn_waste_large', uses: 0, names: <Name>[Name(code: 'en', value: 'Large trash cans'), Name(code: 'ar', value: 'سلات قمامة كبيرة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_wasteDisposal', keywordID: 'prd_furn_waste_pull', uses: 0, names: <Name>[Name(code: 'en', value: 'Pullout trash bins'), Name(code: 'ar', value: 'سلات قمامة منزلقة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_tops', keywordID: 'prd_furn_tops_bathVanity', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom vanity tops'), Name(code: 'ar', value: 'مسطحات وحدات حمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_tops', keywordID: 'prd_furn_tops_kit', uses: 0, names: <Name>[Name(code: 'en', value: 'Kitchen counter tops'), Name(code: 'ar', value: 'مسطحات و جوانب وحدات مطبخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_tables', keywordID: 'prd_furn_tables_dining', uses: 0, names: <Name>[Name(code: 'en', value: 'Dining tables'), Name(code: 'ar', value: 'طاولات طعام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_tables', keywordID: 'prd_furn_tables_bistro', uses: 0, names: <Name>[Name(code: 'en', value: 'Pub & Bistro table'), Name(code: 'ar', value: 'طاولات مقاهي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_tables', keywordID: 'prd_furn_tables_coffee', uses: 0, names: <Name>[Name(code: 'en', value: 'Coffee table'), Name(code: 'ar', value: 'طاولات قهوة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_tables', keywordID: 'prd_furn_tables_folding', uses: 0, names: <Name>[Name(code: 'en', value: 'Folding table'), Name(code: 'ar', value: 'طاولات قابلة للطي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_tables', keywordID: 'prd_furn_tables_console', uses: 0, names: <Name>[Name(code: 'en', value: 'Console'), Name(code: 'ar', value: 'كونسول'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_tables', keywordID: 'prd_furn_tables_meeting', uses: 0, names: <Name>[Name(code: 'en', value: 'Meeting tables'), Name(code: 'ar', value: 'طاولات اجتماعات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_tables', keywordID: 'prd_furn_tables_side', uses: 0, names: <Name>[Name(code: 'en', value: 'Side & End tables'), Name(code: 'ar', value: 'طاولات جانبية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_seatingBench', keywordID: 'prd_furn_bench_shower', uses: 0, names: <Name>[Name(code: 'en', value: 'Shower benches & seats'), Name(code: 'ar', value: 'مجالس دش استحمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_seatingBench', keywordID: 'prd_furn_bench_bedVanity', uses: 0, names: <Name>[Name(code: 'en', value: 'Vanity stools & benches'), Name(code: 'ar', value: 'كراسي وحدة حمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_seatingBench', keywordID: 'prd_furn_bench_bedBench', uses: 0, names: <Name>[Name(code: 'en', value: 'Bedroom benches'), Name(code: 'ar', value: 'مجالس غرفة نوم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_seatingBench', keywordID: 'prd_furn_bench_storage', uses: 0, names: <Name>[Name(code: 'en', value: 'Accent & storage benches'), Name(code: 'ar', value: 'مجالس تخزين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_planting', keywordID: 'prd_furn_planting_stand', uses: 0, names: <Name>[Name(code: 'en', value: 'Plant stands'), Name(code: 'ar', value: 'منصة نباتات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_planting', keywordID: 'prd_furn_planting_potting', uses: 0, names: <Name>[Name(code: 'en', value: 'Potting tables'), Name(code: 'ar', value: 'طاولات أصيص نبات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_planting', keywordID: 'prd_furn_planting_pot', uses: 0, names: <Name>[Name(code: 'en', value: 'Plants pots'), Name(code: 'ar', value: 'أصيص نبات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_planting', keywordID: 'prd_furn_planting_vase', uses: 0, names: <Name>[Name(code: 'en', value: 'Vases'), Name(code: 'ar', value: 'مزهريات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outTables', keywordID: 'prd_furn_outTable_coffee', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor Coffee tables'), Name(code: 'ar', value: 'طاولات قهوة خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outTables', keywordID: 'prd_furn_outTable_side', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor side tables'), Name(code: 'ar', value: 'طاولات جانبية خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outTables', keywordID: 'prd_furn_outTable_dining', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor dining tables'), Name(code: 'ar', value: 'طاولات طعام خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outTables', keywordID: 'prd_furn_outTable_cart', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor serving carts'), Name(code: 'ar', value: 'عربة تقديم خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outSeating', keywordID: 'prd_furn_outSeat_lounge', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor lounge chairs'), Name(code: 'ar', value: 'كراسي معيشة خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outSeating', keywordID: 'prd_furn_outSeat_dining', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor dining chairs'), Name(code: 'ar', value: 'كراسي مائدة خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outSeating', keywordID: 'prd_furn_outSeat_bar', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor bar stools'), Name(code: 'ar', value: 'كراسي بار خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outSeating', keywordID: 'prd_furn_outSeat_chaise', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor Chaise Lounges'), Name(code: 'ar', value: 'شيزلونج خارجي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outSeating', keywordID: 'prd_furn_outSeat_glider', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor gliders'), Name(code: 'ar', value: 'جلايدر خارجي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outSeating', keywordID: 'prd_furn_outSeat_rocking', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor Rocking chairs'), Name(code: 'ar', value: 'كراسي هزازة خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outSeating', keywordID: 'prd_furn_outSeat_adirondack', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor Adirondack chairs'), Name(code: 'ar', value: 'كراسي أديرونداك خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outSeating', keywordID: 'prd_furn_outSeat_love', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor love seats'), Name(code: 'ar', value: 'مجالس ثنائية خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outSeating', keywordID: 'prd_furn_outSeat_poolLounger', uses: 0, names: <Name>[Name(code: 'en', value: 'Pool lounger'), Name(code: 'ar', value: 'سرائر حمام سباحة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outSeating', keywordID: 'prd_furn_outSeat_bench', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor benches'), Name(code: 'ar', value: 'مجالس مسطحة خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outSeating', keywordID: 'prd_furn_outSeat_swing', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor porch swings'), Name(code: 'ar', value: 'كنب هزاز خارجي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_outSeating', keywordID: 'prd_furn_outSeat_sofa', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor sofas'), Name(code: 'ar', value: 'أريكة خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_organizers', keywordID: 'prd_furn_org_shelf', uses: 0, names: <Name>[Name(code: 'en', value: 'Display & wall shelves'), Name(code: 'ar', value: 'أرفف عرض حائطي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_organizers', keywordID: 'prd_furn_org_drawer', uses: 0, names: <Name>[Name(code: 'en', value: 'Drawer organizers'), Name(code: 'ar', value: 'منظمات أدراج'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_organizers', keywordID: 'prd_furn_org_closet', uses: 0, names: <Name>[Name(code: 'en', value: 'Closet Organizers'), Name(code: 'ar', value: 'منظمات دولاب ملابس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_office', keywordID: 'prd_furn_office_desk', uses: 0, names: <Name>[Name(code: 'en', value: 'Office desks'), Name(code: 'ar', value: 'مكاتب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_office', keywordID: 'prd_furn_office_deskAccess', uses: 0, names: <Name>[Name(code: 'en', value: 'Desk accessories'), Name(code: 'ar', value: 'اكسسوارات مكاتب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_office', keywordID: 'prd_furn_office_drafting', uses: 0, names: <Name>[Name(code: 'en', value: 'Drafting tables'), Name(code: 'ar', value: 'طاولات رسم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_office', keywordID: 'prd_furn_officeStore_filing', uses: 0, names: <Name>[Name(code: 'en', value: 'Filing cabinets'), Name(code: 'ar', value: 'كابينات ملفات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_office', keywordID: 'prd_furn_officeStore_cart', uses: 0, names: <Name>[Name(code: 'en', value: 'Office carts & stands'), Name(code: 'ar', value: 'عربات مكاتب و منصات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_livingStorage', keywordID: 'prd_furn_living_blanket', uses: 0, names: <Name>[Name(code: 'en', value: 'Blanket & Quilt racks'), Name(code: 'ar', value: 'وحدات بطانية و لحاف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_livingStorage', keywordID: 'prd_furn_living_chest', uses: 0, names: <Name>[Name(code: 'en', value: 'Accent chests'), Name(code: 'ar', value: 'وحدات صندوقية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_livingStorage', keywordID: 'prd_furn_living_bookcase', uses: 0, names: <Name>[Name(code: 'en', value: 'Bookcases'), Name(code: 'ar', value: 'مكاتب كتب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_livingStorage', keywordID: 'prd_furn_living_media', uses: 0, names: <Name>[Name(code: 'en', value: 'Media cabinets & TV tables'), Name(code: 'ar', value: 'وحدات تلفزيون و ميديا'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_livingStorage', keywordID: 'prd_furn_living_mediaRack', uses: 0, names: <Name>[Name(code: 'en', value: 'Media racks'), Name(code: 'ar', value: 'أرفف ميديا'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_livingStorage', keywordID: 'prd_furn_living_hallTree', uses: 0, names: <Name>[Name(code: 'en', value: 'Hall trees'), Name(code: 'ar', value: 'شماعات القاعة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_livingStorage', keywordID: 'prd_furn_living_barCart', uses: 0, names: <Name>[Name(code: 'en', value: 'Bar carts'), Name(code: 'ar', value: 'عربات بار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_livingStorage', keywordID: 'prd_furn_living_umbrella', uses: 0, names: <Name>[Name(code: 'en', value: 'Coat racks & umbrella stands'), Name(code: 'ar', value: 'شماعات معاطف و شمسيات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_laundry', keywordID: 'prd_furn_laundry_dryingRack', uses: 0, names: <Name>[Name(code: 'en', value: 'Drying racks'), Name(code: 'ar', value: 'أرفف تجفيف ملابس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_laundry', keywordID: 'prd_furn_laundry_ironingTable', uses: 0, names: <Name>[Name(code: 'en', value: 'Ironing table'), Name(code: 'ar', value: 'طاولات كي ملابس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_laundry', keywordID: 'prd_furn_laundry_hamper', uses: 0, names: <Name>[Name(code: 'en', value: 'Laundry hampers'), Name(code: 'ar', value: 'سلات غسيل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kitchenStorage', keywordID: 'prd_furn_kitStore_cabinet', uses: 0, names: <Name>[Name(code: 'en', value: 'Kitchen cabinet'), Name(code: 'ar', value: 'كابينات مطبخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kitchenStorage', keywordID: 'prd_furn_kitStore_pantry', uses: 0, names: <Name>[Name(code: 'en', value: 'Pantry cabinet'), Name(code: 'ar', value: 'كابينات تخزين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kitchenStorage', keywordID: 'prd_furn_kitStore_baker', uses: 0, names: <Name>[Name(code: 'en', value: 'Baker\'s racks'), Name(code: 'ar', value: 'وحدة أرفف خباز'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kitchenStorage', keywordID: 'prd_furn_kitStore_island', uses: 0, names: <Name>[Name(code: 'en', value: 'Kitchen island'), Name(code: 'ar', value: 'وحدات جزيرة مطبخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kitchenStorage', keywordID: 'prd_furn_kitStore_utilityShelf', uses: 0, names: <Name>[Name(code: 'en', value: 'Utility shelves'), Name(code: 'ar', value: 'أرفف خدمية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kitchenStorage', keywordID: 'prd_furn_kitStore_utilityCart', uses: 0, names: <Name>[Name(code: 'en', value: 'Utility carts'), Name(code: 'ar', value: 'عربات خدمية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kitchenStorage', keywordID: 'prd_furn_kitStore_kitCart', uses: 0, names: <Name>[Name(code: 'en', value: 'Kitchen carts'), Name(code: 'ar', value: 'عربات مطبخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_Kitchen Accessories', keywordID: 'prd_furn_kitaccess_rack', uses: 0, names: <Name>[Name(code: 'en', value: 'Holders and racks'), Name(code: 'ar', value: 'وحدات تنظيم مطبخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_Kitchen Accessories', keywordID: 'prd_furn_kitaccess_drawerOrg', uses: 0, names: <Name>[Name(code: 'en', value: 'Drawer organizers'), Name(code: 'ar', value: 'وحدات تنظيم أدراج مطبخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_Kitchen Accessories', keywordID: 'prd_furn_kitaccess_paperHolder', uses: 0, names: <Name>[Name(code: 'en', value: 'Paper towel holders'), Name(code: 'ar', value: 'حاملات مناديل مطبخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_Kitchen Accessories', keywordID: 'prd_furn_kitaccess_shelfLiner', uses: 0, names: <Name>[Name(code: 'en', value: 'Drawer & shelf liners'), Name(code: 'ar', value: 'بطانة أدراج و أرفف مطبخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_Kitchen Accessories', keywordID: 'prd_furn_kitaccess_bookstand', uses: 0, names: <Name>[Name(code: 'en', value: 'Book stands'), Name(code: 'ar', value: 'منصات كتب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kids', keywordID: 'prd_furn_kids_set', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids bedroom sets'), Name(code: 'ar', value: 'أطقم نوم أطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kids', keywordID: 'prd_furn_kids_vanity', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids Vanities'), Name(code: 'ar', value: 'تسريحات أطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kids', keywordID: 'prd_furn_kids_highChair', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids high chairs'), Name(code: 'ar', value: 'كراسي مرتفعة للأطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kids', keywordID: 'prd_furn_kids_chair', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids seating & chairs'), Name(code: 'ar', value: 'كراسي أطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kids', keywordID: 'prd_furn_kids_dresser', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids Dressers'), Name(code: 'ar', value: 'وحدات تخزين أطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kids', keywordID: 'prd_furn_kids_bookcase', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids Bookcases'), Name(code: 'ar', value: 'مكاتب كتب أطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kids', keywordID: 'prd_furn_kids_nightstand', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids nightstands'), Name(code: 'ar', value: 'وحدات سرير أطفال جانبية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kids', keywordID: 'prd_furn_kids_box', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids boxes & organizers'), Name(code: 'ar', value: 'صناديق أطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kids', keywordID: 'prd_furn_kids_rug', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids rugs'), Name(code: 'ar', value: 'سجاد أطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kids', keywordID: 'prd_furn_kids_bed', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids beds'), Name(code: 'ar', value: 'سرير أطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kids', keywordID: 'prd_furn_kids_cradle', uses: 0, names: <Name>[Name(code: 'en', value: 'Toddler beds & cradles'), Name(code: 'ar', value: 'سرير و مهد رضيع'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_kids', keywordID: 'prd_furn_kids_desk', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids desks'), Name(code: 'ar', value: 'مكاتب أطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_parts', keywordID: 'prd_furn_parts_tableLeg', uses: 0, names: <Name>[Name(code: 'en', value: 'Table legs'), Name(code: 'ar', value: 'أرجل طاولات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_parts', keywordID: 'prd_furn_parts_tableTop', uses: 0, names: <Name>[Name(code: 'en', value: 'Table tops'), Name(code: 'ar', value: 'أسطح طاولات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_accessories', keywordID: 'prd_furn_access_mirror', uses: 0, names: <Name>[Name(code: 'en', value: 'Wall Mirrors'), Name(code: 'ar', value: 'مرايا حائط'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_accessories', keywordID: 'prd_furn_access_clock', uses: 0, names: <Name>[Name(code: 'en', value: 'Wall clocks'), Name(code: 'ar', value: 'ساعات حائط'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_accessories', keywordID: 'prd_furn_access_step', uses: 0, names: <Name>[Name(code: 'en', value: 'Step ladders & stools'), Name(code: 'ar', value: 'عتبات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_accessories', keywordID: 'prd_furn_access_charging', uses: 0, names: <Name>[Name(code: 'en', value: 'Charging station'), Name(code: 'ar', value: 'محطات شحن'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_accessories', keywordID: 'prd_furn_access_magazine', uses: 0, names: <Name>[Name(code: 'en', value: 'Magazine racks'), Name(code: 'ar', value: 'أرفف مجلات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_accessories', keywordID: 'prd_furn_org_wall', uses: 0, names: <Name>[Name(code: 'en', value: 'Wall Organizers'), Name(code: 'ar', value: 'منظمات حائطية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_accessories', keywordID: 'prd_furn_access_furnProtector', uses: 0, names: <Name>[Name(code: 'en', value: 'Furniture protectors'), Name(code: 'ar', value: 'حاميات أثاث'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_dressingStorage', keywordID: 'prd_furn_dressStore_wardrobe', uses: 0, names: <Name>[Name(code: 'en', value: 'Armories & Wardrobes'), Name(code: 'ar', value: 'دواليب ملابس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_dressingStorage', keywordID: 'prd_furn_dressStore_dresser', uses: 0, names: <Name>[Name(code: 'en', value: 'Dresser'), Name(code: 'ar', value: 'تسريحات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_dressingStorage', keywordID: 'prd_furn_dressStore_shoe', uses: 0, names: <Name>[Name(code: 'en', value: 'Shoes closet'), Name(code: 'ar', value: 'دولاب أحذية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_dressingStorage', keywordID: 'prd_furn_dressStore_clothRack', uses: 0, names: <Name>[Name(code: 'en', value: 'Clothes racks'), Name(code: 'ar', value: 'شماعات ملابس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_dressingStorage', keywordID: 'prd_furn_dressStore_valet', uses: 0, names: <Name>[Name(code: 'en', value: 'Clothes Valets'), Name(code: 'ar', value: 'فاليه ملابس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_dressingStorage', keywordID: 'prd_furn_dressStore_jewelry', uses: 0, names: <Name>[Name(code: 'en', value: 'Jewelry armories'), Name(code: 'ar', value: 'وحدات مجوهرات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_diningStorage', keywordID: 'prd_furn_dinStore_china', uses: 0, names: <Name>[Name(code: 'en', value: 'China cabinet & Hutches'), Name(code: 'ar', value: 'نيش'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_diningStorage', keywordID: 'prd_furn_dinStore_buffet', uses: 0, names: <Name>[Name(code: 'en', value: 'Buffet & sideboards'), Name(code: 'ar', value: 'بوفيه'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cushions', keywordID: 'prd_furn_cush_pillow', uses: 0, names: <Name>[Name(code: 'en', value: 'Pillows'), Name(code: 'ar', value: 'مخدات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cushions', keywordID: 'prd_furn_cush_seat', uses: 0, names: <Name>[Name(code: 'en', value: 'Seats cushions'), Name(code: 'ar', value: 'وسائد مقاعد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cushions', keywordID: 'prd_furn_cush_throw', uses: 0, names: <Name>[Name(code: 'en', value: 'Throws'), Name(code: 'ar', value: 'أغطية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cushions', keywordID: 'prd_furn_cush_floorPillow', uses: 0, names: <Name>[Name(code: 'en', value: 'Floor Pillows'), Name(code: 'ar', value: 'وسائد أرضية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cushions', keywordID: 'prd_furn_cush_pouf', uses: 0, names: <Name>[Name(code: 'en', value: 'Pouf'), Name(code: 'ar', value: 'بوف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cushions', keywordID: 'prd_furn_cush_cush', uses: 0, names: <Name>[Name(code: 'en', value: 'Cushions'), Name(code: 'ar', value: 'وسائد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cushions', keywordID: 'prd_furn_cush_ottoman', uses: 0, names: <Name>[Name(code: 'en', value: 'Foot stools & Ottomans'), Name(code: 'ar', value: 'مساند أقدام عثمانية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cushions', keywordID: 'prd_furn_cush_beanbag', uses: 0, names: <Name>[Name(code: 'en', value: 'Bean bags'), Name(code: 'ar', value: 'بين باج'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cushions', keywordID: 'prd_furn_cush_outOttoman', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor Ottomans'), Name(code: 'ar', value: 'مساند عثمانية خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cushions', keywordID: 'prd_furn_cush_outCushion', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor cushions & pillows'), Name(code: 'ar', value: 'مخدات و وسائد خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_couch', keywordID: 'prd_furn_couch_chaise', uses: 0, names: <Name>[Name(code: 'en', value: 'Chaise lounge'), Name(code: 'ar', value: 'شيزلونج'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_couch', keywordID: 'prd_furn_couch_banquette', uses: 0, names: <Name>[Name(code: 'en', value: 'Banquettes'), Name(code: 'ar', value: 'بانكيت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_couch', keywordID: 'prd_furn_couch_sofa', uses: 0, names: <Name>[Name(code: 'en', value: 'Sofas'), Name(code: 'ar', value: 'أرائك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_couch', keywordID: 'prd_furn_couch_sectional', uses: 0, names: <Name>[Name(code: 'en', value: 'Sectional sofas'), Name(code: 'ar', value: 'أرائك منفصلة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_couch', keywordID: 'prd_furn_couch_futon', uses: 0, names: <Name>[Name(code: 'en', value: 'Futons'), Name(code: 'ar', value: 'فوتون'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_couch', keywordID: 'prd_furn_couch_love', uses: 0, names: <Name>[Name(code: 'en', value: 'Love seats'), Name(code: 'ar', value: 'أرائك مزدوجة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_couch', keywordID: 'prd_furn_couch_sleeper', uses: 0, names: <Name>[Name(code: 'en', value: 'Sleeper sofas'), Name(code: 'ar', value: 'أرائك سرير'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_sets', keywordID: 'prd_furn_sets_dining', uses: 0, names: <Name>[Name(code: 'en', value: 'Dining set'), Name(code: 'ar', value: 'أطقم غرفة طعام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_sets', keywordID: 'prd_furn_sets_bistro', uses: 0, names: <Name>[Name(code: 'en', value: 'Pub & Bistro set'), Name(code: 'ar', value: 'أطقم مقاهي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_sets', keywordID: 'prd_furn_sets_living', uses: 0, names: <Name>[Name(code: 'en', value: 'Living room set'), Name(code: 'ar', value: 'أطقم غرفة معيشة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_sets', keywordID: 'prd_furn_sets_tv', uses: 0, names: <Name>[Name(code: 'en', value: 'Tv set'), Name(code: 'ar', value: 'أطقم تلفزيون'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_sets', keywordID: 'prd_furn_sets_bathVanity', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom vanities'), Name(code: 'ar', value: 'وحدات حمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_sets', keywordID: 'prd_furn_sets_bedroom', uses: 0, names: <Name>[Name(code: 'en', value: 'Bedroom sets'), Name(code: 'ar', value: 'أطقم غرف نوم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_sets', keywordID: 'prd_furn_sets_bedVanity', uses: 0, names: <Name>[Name(code: 'en', value: 'Bedroom vanities'), Name(code: 'ar', value: 'أطقم تسريحة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_sets', keywordID: 'prd_furn_sets_outLounge', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor lounge sets'), Name(code: 'ar', value: 'أطقم معيشة خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_sets', keywordID: 'prd_furn_sets_outDining', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor Dining sets'), Name(code: 'ar', value: 'أطقم غرفة طعام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_sets', keywordID: 'prd_furn_sets_outBistro', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor pub & bistro sets'), Name(code: 'ar', value: 'أطقم مقاهي خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_bar', uses: 0, names: <Name>[Name(code: 'en', value: 'Bar & Counter stools'), Name(code: 'ar', value: 'كراسي بار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_dining', uses: 0, names: <Name>[Name(code: 'en', value: 'Dining Chairs'), Name(code: 'ar', value: 'كراسي مائدة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_diningBench', uses: 0, names: <Name>[Name(code: 'en', value: 'Dining Benches'), Name(code: 'ar', value: 'مجالس مائدة منبسطة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_arm', uses: 0, names: <Name>[Name(code: 'en', value: 'Arm chairs'), Name(code: 'ar', value: 'كراسي بذراع'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_recliner', uses: 0, names: <Name>[Name(code: 'en', value: 'Recliner chairs'), Name(code: 'ar', value: 'كراسي ريكلاينر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_glider', uses: 0, names: <Name>[Name(code: 'en', value: 'Gliders'), Name(code: 'ar', value: 'كراسي جلايدر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_rocking', uses: 0, names: <Name>[Name(code: 'en', value: 'Rocking chairs'), Name(code: 'ar', value: 'كراسي هزازة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_hanging', uses: 0, names: <Name>[Name(code: 'en', value: 'Hammock & Swing chairs'), Name(code: 'ar', value: 'كراسي متدلية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_lift', uses: 0, names: <Name>[Name(code: 'en', value: 'Lift chairs'), Name(code: 'ar', value: 'كراسي رفع'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_massage', uses: 0, names: <Name>[Name(code: 'en', value: 'Massage chairs'), Name(code: 'ar', value: 'كراسي تدليك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_sleeper', uses: 0, names: <Name>[Name(code: 'en', value: 'Sleeper chairs'), Name(code: 'ar', value: 'كراسي سرير'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_theatre', uses: 0, names: <Name>[Name(code: 'en', value: 'Theatre seating'), Name(code: 'ar', value: 'كراسي مسرح'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_folding', uses: 0, names: <Name>[Name(code: 'en', value: 'Folding chairs & stools'), Name(code: 'ar', value: 'كراسي قابلة للطي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_office', uses: 0, names: <Name>[Name(code: 'en', value: 'Office chairs'), Name(code: 'ar', value: 'كراسي مكتب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_chairs', keywordID: 'prd_furn_chair_gaming', uses: 0, names: <Name>[Name(code: 'en', value: 'Gaming chairs'), Name(code: 'ar', value: 'كراسي ألعاب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_carpetsRugs', keywordID: 'prd_furn_carpet_bathMat', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom Mats'), Name(code: 'ar', value: 'سجاد حمامات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_carpetsRugs', keywordID: 'prd_furn_carpet_rug', uses: 0, names: <Name>[Name(code: 'en', value: 'Area rugs'), Name(code: 'ar', value: 'بساط مساحات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_carpetsRugs', keywordID: 'prd_furn_carpet_doorMat', uses: 0, names: <Name>[Name(code: 'en', value: 'Door mats'), Name(code: 'ar', value: 'حصيرة أبواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_carpetsRugs', keywordID: 'prd_furn_carpet_runner', uses: 0, names: <Name>[Name(code: 'en', value: 'Hall & stairs runners'), Name(code: 'ar', value: 'بساط سلالم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_carpetsRugs', keywordID: 'prd_furn_carpet_kitchen', uses: 0, names: <Name>[Name(code: 'en', value: 'Kitchen mats'), Name(code: 'ar', value: 'سجاد مطابخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_carpetsRugs', keywordID: 'prd_furn_carpet_outdoor', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor rugs'), Name(code: 'ar', value: 'سجاد خارجي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_carpetsRugs', keywordID: 'prd_furn_carpet_pad', uses: 0, names: <Name>[Name(code: 'en', value: 'Rug pads'), Name(code: 'ar', value: 'بطانة سجاد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_carpetsRugs', keywordID: 'prd_furn_carpet_handmade', uses: 0, names: <Name>[Name(code: 'en', value: 'Handmade rugs'), Name(code: 'ar', value: 'سجاد يدوي الصنع'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cabinetHardware', keywordID: 'prd_furn_cabhard_pull', uses: 0, names: <Name>[Name(code: 'en', value: 'Cabinet & drawers pulls'), Name(code: 'ar', value: 'أكر أدراج و كابينات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cabinetHardware', keywordID: 'prd_furn_cabhard_knob', uses: 0, names: <Name>[Name(code: 'en', value: 'Cabinet & drawers knobs'), Name(code: 'ar', value: 'مقابض أدراج و كابينات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cabinetHardware', keywordID: 'prd_furn_cabhard_hook', uses: 0, names: <Name>[Name(code: 'en', value: 'Wall Cloth hooks'), Name(code: 'ar', value: 'معلاق ملابس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_cabinetHardware', keywordID: 'prd_furn_cabhard_hinge', uses: 0, names: <Name>[Name(code: 'en', value: 'Cabinet hinges'), Name(code: 'ar', value: 'مفصلات ضلف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_boxes', keywordID: 'prd_furn_boxes_bin', uses: 0, names: <Name>[Name(code: 'en', value: 'Storage bins & boxes'), Name(code: 'ar', value: 'سلات و صناديق تخزين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_boxes', keywordID: 'prd_furn_boxes_outdoor', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor boxes'), Name(code: 'ar', value: 'صناديق تخزين خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_boxes', keywordID: 'prd_furn_boxes_ice', uses: 0, names: <Name>[Name(code: 'en', value: 'Coolers & ice chests'), Name(code: 'ar', value: 'صناديق ثلج'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_boxes', keywordID: 'prd_furn_boxes_basket', uses: 0, names: <Name>[Name(code: 'en', value: 'Baskets'), Name(code: 'ar', value: 'سلات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_blindsCurtains', keywordID: 'prd_furn_curtain_shower', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom shower curtains'), Name(code: 'ar', value: 'ستائر دش استحمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_blindsCurtains', keywordID: 'prd_furn_curtain_shade', uses: 0, names: <Name>[Name(code: 'en', value: 'Blinds & shades'), Name(code: 'ar', value: 'سواتر و ستائر شفافة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_blindsCurtains', keywordID: 'prd_furn_curtain_horizontal', uses: 0, names: <Name>[Name(code: 'en', value: 'Horizontal shades'), Name(code: 'ar', value: 'ستائر شريطية عرضية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_blindsCurtains', keywordID: 'prd_furn_curtain_vertical', uses: 0, names: <Name>[Name(code: 'en', value: 'Vertical blinds'), Name(code: 'ar', value: 'ستائر شريطية طولية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_blindsCurtains', keywordID: 'prd_furn_curtain_rod', uses: 0, names: <Name>[Name(code: 'en', value: 'Curtain rods'), Name(code: 'ar', value: 'قضبان ستائر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_blindsCurtains', keywordID: 'prd_furn_curtain_valance', uses: 0, names: <Name>[Name(code: 'en', value: 'Valances'), Name(code: 'ar', value: 'كرانيش ستائر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_blindsCurtains', keywordID: 'prd_furn_curtain_curtain', uses: 0, names: <Name>[Name(code: 'en', value: 'Curtains'), Name(code: 'ar', value: 'ستائر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_blindsCurtains', keywordID: 'prd_furn_curtain_tassel', uses: 0, names: <Name>[Name(code: 'en', value: 'Tassels'), Name(code: 'ar', value: 'شرابات ستائر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_blindsCurtains', keywordID: 'prd_furn_curtain_bendRail', uses: 0, names: <Name>[Name(code: 'en', value: 'Bendable curtain rails'), Name(code: 'ar', value: 'قضبان ستائر قابلة للطي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_bed', uses: 0, names: <Name>[Name(code: 'en', value: 'Beds'), Name(code: 'ar', value: 'سرائر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_board', uses: 0, names: <Name>[Name(code: 'en', value: 'Headboards'), Name(code: 'ar', value: 'ألواح سرائر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_mattress', uses: 0, names: <Name>[Name(code: 'en', value: 'Mattresses & Pads'), Name(code: 'ar', value: 'مراتب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_frame', uses: 0, names: <Name>[Name(code: 'en', value: 'Bed Frames'), Name(code: 'ar', value: 'هياكل سرائر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_blanket', uses: 0, names: <Name>[Name(code: 'en', value: 'Blankets, pillows & covers'), Name(code: 'ar', value: 'بطانيات و مخدات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_panel', uses: 0, names: <Name>[Name(code: 'en', value: 'Panel beds'), Name(code: 'ar', value: 'سرائر بظهر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_platform', uses: 0, names: <Name>[Name(code: 'en', value: 'Platform beds'), Name(code: 'ar', value: 'سرائر على منصة منبسطة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_sleigh', uses: 0, names: <Name>[Name(code: 'en', value: 'Sleigh beds'), Name(code: 'ar', value: 'سرائر سلاي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_bunk', uses: 0, names: <Name>[Name(code: 'en', value: 'Bunk beds'), Name(code: 'ar', value: 'سرائر دورين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_loft', uses: 0, names: <Name>[Name(code: 'en', value: 'Loft beds'), Name(code: 'ar', value: 'سرائر لوفت مرتفعة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_day', uses: 0, names: <Name>[Name(code: 'en', value: 'Day beds'), Name(code: 'ar', value: 'سرائر النهار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_murphy', uses: 0, names: <Name>[Name(code: 'en', value: 'Murphy beds'), Name(code: 'ar', value: 'سرائر ميرفي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_folding', uses: 0, names: <Name>[Name(code: 'en', value: 'Folding beds'), Name(code: 'ar', value: 'سرائر قابلة للطي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_beds', keywordID: 'prd_furn_beds_adjustable', uses: 0, names: <Name>[Name(code: 'en', value: 'Adjustable beds'), Name(code: 'ar', value: 'سرائر قابلة للضبط'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathStorage', keywordID: 'prd_furn_bathStore_medicine', uses: 0, names: <Name>[Name(code: 'en', value: 'Medicine cabinet'), Name(code: 'ar', value: 'كابينات دواء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathStorage', keywordID: 'prd_furn_bathStore_cabinet', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom cabinet'), Name(code: 'ar', value: 'كابينات حمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathStorage', keywordID: 'prd_furn_bathStore_shelf', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom shelves'), Name(code: 'ar', value: 'أرفف حمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathStorage', keywordID: 'prd_furn_bathStore_sink', uses: 0, names: <Name>[Name(code: 'en', value: 'Under sink cabinets'), Name(code: 'ar', value: 'كابينات حمام سفلية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathStorage', keywordID: 'prd_furn_bedStore_nightstand', uses: 0, names: <Name>[Name(code: 'en', value: 'Nightstands & bedside tables'), Name(code: 'ar', value: 'طاولات سرير جانبية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathHardware', keywordID: 'prd_furn_bathHard_towelBar', uses: 0, names: <Name>[Name(code: 'en', value: 'Towel bars & holders'), Name(code: 'ar', value: 'قضيب فوط'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathHardware', keywordID: 'prd_furn_bathHard_mirror', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom mirrors'), Name(code: 'ar', value: 'مرايا حمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathHardware', keywordID: 'prd_furn_bathHard_makeup', uses: 0, names: <Name>[Name(code: 'en', value: 'Makeup mirrors'), Name(code: 'ar', value: 'مرايا مكياج'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathHardware', keywordID: 'prd_furn_bathHard_rack', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom racks'), Name(code: 'ar', value: 'أرفف حمامات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathHardware', keywordID: 'prd_furn_bathHard_grab', uses: 0, names: <Name>[Name(code: 'en', value: 'Grab bars'), Name(code: 'ar', value: 'قضبان اتكاء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathHardware', keywordID: 'prd_furn_bathHard_caddy', uses: 0, names: <Name>[Name(code: 'en', value: 'Shower Caddies'), Name(code: 'ar', value: 'أرفف دش استحمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathHardware', keywordID: 'prd_furn_bathHard_safetyRail', uses: 0, names: <Name>[Name(code: 'en', value: 'Toilet safety rails'), Name(code: 'ar', value: 'قضبان أمان مرحاض'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathHardware', keywordID: 'prd_furn_bathHard_toiletHolder', uses: 0, names: <Name>[Name(code: 'en', value: 'Toilet paper holder'), Name(code: 'ar', value: 'حاملة مناديل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_bathHardware', keywordID: 'prd_furn_bathHard_commode', uses: 0, names: <Name>[Name(code: 'en', value: 'Toilet Commode'), Name(code: 'ar', value: 'مرحاض متنقل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_artworks', keywordID: 'prd_furn_art_painting', uses: 0, names: <Name>[Name(code: 'en', value: 'Paintings'), Name(code: 'ar', value: 'رسومات فنية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_artworks', keywordID: 'prd_furn_art_photo', uses: 0, names: <Name>[Name(code: 'en', value: 'Photographs'), Name(code: 'ar', value: 'صور'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_artworks', keywordID: 'prd_furn_art_illustration', uses: 0, names: <Name>[Name(code: 'en', value: 'Drawings & Illustrations'), Name(code: 'ar', value: 'تصاميم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_artworks', keywordID: 'prd_furn_art_print', uses: 0, names: <Name>[Name(code: 'en', value: 'Prints & posters'), Name(code: 'ar', value: 'مطبوعات و ملصقات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_artworks', keywordID: 'prd_furn_art_sculpture', uses: 0, names: <Name>[Name(code: 'en', value: 'Sculptures'), Name(code: 'ar', value: 'تماثيل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_artworks', keywordID: 'prd_furn_art_letter', uses: 0, names: <Name>[Name(code: 'en', value: 'Wall Letters'), Name(code: 'ar', value: 'حروف حائطية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_artworks', keywordID: 'prd_furn_art_frame', uses: 0, names: <Name>[Name(code: 'en', value: 'Picture frames & accents'), Name(code: 'ar', value: 'إطارات صور ز هياكل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_artworks', keywordID: 'prd_furn_art_bulletin', uses: 0, names: <Name>[Name(code: 'en', value: 'Bulletin boards'), Name(code: 'ar', value: 'لوحات دبابيس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_artworks', keywordID: 'prd_furn_art_decals', uses: 0, names: <Name>[Name(code: 'en', value: 'Wall Decals'), Name(code: 'ar', value: 'ملصقات حائطية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_furniture', subGroupID: 'sub_prd_furn_artworks', keywordID: 'prd_furn_art_tapestry', uses: 0, names: <Name>[Name(code: 'en', value: 'Tapestries'), Name(code: 'ar', value: 'بساط و أنسجة حائطية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_ventilation', keywordID: 'prd_hvac_vent_fan', uses: 0, names: <Name>[Name(code: 'en', value: 'Fans'), Name(code: 'ar', value: 'مراوح'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_ventilation', keywordID: 'prd_hvac_vent_exhaust', uses: 0, names: <Name>[Name(code: 'en', value: 'Exhaust fans'), Name(code: 'ar', value: 'مراوح شفط و شفاطات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_ventilation', keywordID: 'prd_hvac_vent_curtain', uses: 0, names: <Name>[Name(code: 'en', value: 'Air curtains'), Name(code: 'ar', value: 'ستائر هوائية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_ventilation', keywordID: 'prd_hvac_vent_ceilingFan', uses: 0, names: <Name>[Name(code: 'en', value: 'Ceiling fan'), Name(code: 'ar', value: 'مراوح سقف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_heating', keywordID: 'prd_hvac_heating_electric', uses: 0, names: <Name>[Name(code: 'en', value: 'Electric heaters'), Name(code: 'ar', value: 'أجهزة تدفئة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_heating', keywordID: 'prd_hvac_heating_radiators', uses: 0, names: <Name>[Name(code: 'en', value: 'Radiators'), Name(code: 'ar', value: 'مشعاع حراري'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_heating', keywordID: 'prd_hvac_heating_floor', uses: 0, names: <Name>[Name(code: 'en', value: 'Floor heating systems'), Name(code: 'ar', value: 'أنظمة تدفئة أرضية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_fireplaces', keywordID: 'prd_fireplace_fire_mantle', uses: 0, names: <Name>[Name(code: 'en', value: 'Fireplace mantels'), Name(code: 'ar', value: 'دفايات نار مبنية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_fireplaces', keywordID: 'prd_fireplace_fire_tabletop', uses: 0, names: <Name>[Name(code: 'en', value: 'Tabletop fireplaces'), Name(code: 'ar', value: 'دفايات نار طاولة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_fireplaces', keywordID: 'prd_fireplace_fire_freeStove', uses: 0, names: <Name>[Name(code: 'en', value: 'Freestanding stoves'), Name(code: 'ar', value: 'مواقد قائمة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_fireplaces', keywordID: 'prd_fireplace_fire_outdoor', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor fireplaces'), Name(code: 'ar', value: 'دفايات نار خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_fireplaces', keywordID: 'prd_fireplace_fire_chiminea', uses: 0, names: <Name>[Name(code: 'en', value: 'Chimineas'), Name(code: 'ar', value: 'مداخن'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_fireplaces', keywordID: 'prd_fireplace_fire_pit', uses: 0, names: <Name>[Name(code: 'en', value: 'Fire pits'), Name(code: 'ar', value: 'حفرة نار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_fireplaceEquip', keywordID: 'prd_fireplace_equip_tools', uses: 0, names: <Name>[Name(code: 'en', value: 'Fireplace tools'), Name(code: 'ar', value: 'أدوات دفايات نار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_fireplaceEquip', keywordID: 'prd_fireplace_equip_rack', uses: 0, names: <Name>[Name(code: 'en', value: 'Fire wood racks'), Name(code: 'ar', value: 'أرفف حطب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_fireplaceEquip', keywordID: 'prd_fireplace_equip_fuel', uses: 0, names: <Name>[Name(code: 'en', value: 'Fire starters & fuel'), Name(code: 'ar', value: 'مساعدات اشتعال و وقود'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_fireplaceEquip', keywordID: 'prd_fireplace_equip_grate', uses: 0, names: <Name>[Name(code: 'en', value: 'fireplace grates & Andirons'), Name(code: 'ar', value: 'فواصل و حوامل حطب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_ac', keywordID: 'prd_hvac_ac_chiller', uses: 0, names: <Name>[Name(code: 'en', value: 'Chillers'), Name(code: 'ar', value: 'مبردات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_ac', keywordID: 'prd_hvac_ac_ac', uses: 0, names: <Name>[Name(code: 'en', value: 'Indoor AC units'), Name(code: 'ar', value: 'تكييفات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_ac', keywordID: 'prd_hvac_ac_vent', uses: 0, names: <Name>[Name(code: 'en', value: 'Registers, grills & vents'), Name(code: 'ar', value: 'فتحات تكييف، هوايات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_ac', keywordID: 'prd_hvac_ac_humidifier', uses: 0, names: <Name>[Name(code: 'en', value: 'Humidifiers'), Name(code: 'ar', value: 'مرطبات هواء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_ac', keywordID: 'prd_hvac_ac_dehumidifier', uses: 0, names: <Name>[Name(code: 'en', value: 'Dehumidifiers'), Name(code: 'ar', value: 'مجففات هواء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_hvac', subGroupID: 'sub_prd_hvac_ac', keywordID: 'prd_hvac_ac_purifier', uses: 0, names: <Name>[Name(code: 'en', value: 'Air purifiers'), Name(code: 'ar', value: 'منقيات هواء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_potsVases', keywordID: 'prd_landscape_pots_vase', uses: 0, names: <Name>[Name(code: 'en', value: 'Vases'), Name(code: 'ar', value: 'مزاهر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_potsVases', keywordID: 'prd_landscape_pots_indoorPlanter', uses: 0, names: <Name>[Name(code: 'en', value: 'Indoor pots & planters'), Name(code: 'ar', value: 'أصيص زراعة داخلي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_potsVases', keywordID: 'prd_landscape_pots_outdoorPlanter', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor pots & planters'), Name(code: 'ar', value: 'أصيص زراعة خارجي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_potsVases', keywordID: 'prd_landscape_pots_bin', uses: 0, names: <Name>[Name(code: 'en', value: 'Composite bins'), Name(code: 'ar', value: 'براميل و صناديق سماد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_livePlants', keywordID: 'prd_landscape_live_tree', uses: 0, names: <Name>[Name(code: 'en', value: 'Live Trees'), Name(code: 'ar', value: 'شجر طبيعي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_livePlants', keywordID: 'prd_landscape_live_grass', uses: 0, names: <Name>[Name(code: 'en', value: 'Live Grass lawn'), Name(code: 'ar', value: 'نجيلة طبيعية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_livePlants', keywordID: 'prd_landscape_live_bush', uses: 0, names: <Name>[Name(code: 'en', value: 'Plants, Bushes & Flowers'), Name(code: 'ar', value: 'مزروعات، نباتات و ورود'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_hardscape', keywordID: 'prd_landscape_hardscape_trellis', uses: 0, names: <Name>[Name(code: 'en', value: 'Garden Trellises'), Name(code: 'ar', value: 'تعريشات حديقة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_hardscape', keywordID: 'prd_landscape_hardscape_flag', uses: 0, names: <Name>[Name(code: 'en', value: 'Flags & Poles'), Name(code: 'ar', value: 'أعلام و عواميدها'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_fountainsPonds', keywordID: 'prd_landscape_fountain_indoor', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor fountains'), Name(code: 'ar', value: 'نافورة خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_fountainsPonds', keywordID: 'prd_landscape_fountain_outdoor', uses: 0, names: <Name>[Name(code: 'en', value: 'Indoor fountains'), Name(code: 'ar', value: 'نافورة داخلية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_birds', keywordID: 'prd_landscape_birds_feeder', uses: 0, names: <Name>[Name(code: 'en', value: 'Bird feeders'), Name(code: 'ar', value: 'مغذيات عصافير'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_birds', keywordID: 'prd_landscape_birds_bath', uses: 0, names: <Name>[Name(code: 'en', value: 'Bird baths'), Name(code: 'ar', value: 'أحواض عصافير'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_birds', keywordID: 'prd_landscape_birds_house', uses: 0, names: <Name>[Name(code: 'en', value: 'Bird houses'), Name(code: 'ar', value: 'بيوت عصافير'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_artificial', keywordID: 'prd_landscape_artificial_tree', uses: 0, names: <Name>[Name(code: 'en', value: 'Artificial Trees'), Name(code: 'ar', value: 'شجر صناعي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_artificial', keywordID: 'prd_landscape_artificial_plant', uses: 0, names: <Name>[Name(code: 'en', value: 'Artificial Plants'), Name(code: 'ar', value: 'نباتات صناعية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_landscape', subGroupID: 'sub_prd_scape_artificial', keywordID: 'prd_landscape_artificial_grass', uses: 0, names: <Name>[Name(code: 'en', value: 'Artificial grass'), Name(code: 'ar', value: 'نجيلة صناعية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_wall', keywordID: 'prd_lighting_wall_applique', uses: 0, names: <Name>[Name(code: 'en', value: 'Sconces & Appliques'), Name(code: 'ar', value: 'أباليك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_wall', keywordID: 'prd_lighting_wall_vanity', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom vanity lighting'), Name(code: 'ar', value: 'مصابيح وحدات حمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_wall', keywordID: 'prd_lighting_wall_picture', uses: 0, names: <Name>[Name(code: 'en', value: 'Display & Picture lighting'), Name(code: 'ar', value: 'مصابيح عرض و صور'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_wall', keywordID: 'prd_lighting_wall_swing', uses: 0, names: <Name>[Name(code: 'en', value: 'Swing arm wall lamps'), Name(code: 'ar', value: 'مصابيح ذراع متحرك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_wall', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor wall lights'), Name(code: 'ar', value: 'مصابيح حوائط خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_flush', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor Flush mounts'), Name(code: 'ar', value: 'مصابيح ملتصقة بالسقف خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_hanging', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor Hanging lights'), Name(code: 'ar', value: 'مصابيح خارجية متدلية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_deck', uses: 0, names: <Name>[Name(code: 'en', value: 'Deck post caps'), Name(code: 'ar', value: 'أغطية مصابيح خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_inground', uses: 0, names: <Name>[Name(code: 'en', value: 'Inground & well lights'), Name(code: 'ar', value: 'مصابيح مدفونة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_path', uses: 0, names: <Name>[Name(code: 'en', value: 'Path lights'), Name(code: 'ar', value: 'مصابيح ممرات خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_step', uses: 0, names: <Name>[Name(code: 'en', value: 'Stairs and step lights'), Name(code: 'ar', value: 'مصابيح سلالم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_floorSpot', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor floor & spot lights'), Name(code: 'ar', value: 'مصابيح سبوت أرضية خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_lamp', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor lamps'), Name(code: 'ar', value: 'مصابيح خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_table', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor table lamps'), Name(code: 'ar', value: 'مصابيح طاولة خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_string', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor String lights'), Name(code: 'ar', value: 'مصابيح سلسلة خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_post', uses: 0, names: <Name>[Name(code: 'en', value: 'Post lights'), Name(code: 'ar', value: 'عواميد إضاءة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_torch', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor torches'), Name(code: 'ar', value: 'شعلات إضاءة خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_outdoor', keywordID: 'prd_lighting_outdoor_gardenSpot', uses: 0, names: <Name>[Name(code: 'en', value: 'Graden spotlights'), Name(code: 'ar', value: 'إضاءات حدائق سبوت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_access', keywordID: 'prd_lighting_accessories_shade', uses: 0, names: <Name>[Name(code: 'en', value: 'Lamp shades & bases'), Name(code: 'ar', value: 'قواعد و أغطية مصابيح'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_access', keywordID: 'prd_lighting_accessories_timer', uses: 0, names: <Name>[Name(code: 'en', value: 'Timers & lighting controls'), Name(code: 'ar', value: 'مواقيت و ضوابط إضاءة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_access', keywordID: 'prd_lighting_accessories_lightingHardware', uses: 0, names: <Name>[Name(code: 'en', value: 'Lighting hardware & accessories'), Name(code: 'ar', value: 'اكسسوارات إضاءة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_access', keywordID: 'prd_lighting_accessories_flash', uses: 0, names: <Name>[Name(code: 'en', value: 'Flash lights'), Name(code: 'ar', value: 'كشافات يدوية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_access', keywordID: 'prd_lighting_accessories_diffuser', uses: 0, names: <Name>[Name(code: 'en', value: 'Light diffusers'), Name(code: 'ar', value: 'مبددات أضواء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_bulbs', keywordID: 'prd_lighting_bulbs_fluorescent', uses: 0, names: <Name>[Name(code: 'en', value: 'Fluorescent bulbs'), Name(code: 'ar', value: 'لمبة فلوريسينت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_bulbs', keywordID: 'prd_lighting_bulbs_led', uses: 0, names: <Name>[Name(code: 'en', value: 'Led bulbs'), Name(code: 'ar', value: 'لمبة ليد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_bulbs', keywordID: 'prd_lighting_bulbs_halogen', uses: 0, names: <Name>[Name(code: 'en', value: 'Halogen bulbs'), Name(code: 'ar', value: 'لمبة هالوجين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_bulbs', keywordID: 'prd_lighting_bulbs_incandescent', uses: 0, names: <Name>[Name(code: 'en', value: 'Incandescent bulbs'), Name(code: 'ar', value: 'لمبة متوهجة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_bulbs', keywordID: 'prd_lighting_bulbs_tube', uses: 0, names: <Name>[Name(code: 'en', value: 'Fluorescent tubes'), Name(code: 'ar', value: 'عود نيون فلوريسينت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_bulbs', keywordID: 'prd_lighting_bulbs_krypton', uses: 0, names: <Name>[Name(code: 'en', value: 'Krypton & xenon bulbs'), Name(code: 'ar', value: 'لمبة كريبتون و زينون'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_lamps', keywordID: 'prd_lighting_lamp_table', uses: 0, names: <Name>[Name(code: 'en', value: 'Table lamps'), Name(code: 'ar', value: 'مصابيح طاولة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_lamps', keywordID: 'prd_lighting_lamp_floor', uses: 0, names: <Name>[Name(code: 'en', value: 'Floor lamps'), Name(code: 'ar', value: 'مصابيح أرضية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_lamps', keywordID: 'prd_lighting_lamp_desk', uses: 0, names: <Name>[Name(code: 'en', value: 'Desk lamps'), Name(code: 'ar', value: 'مصابيح مكتب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_lamps', keywordID: 'prd_lighting_lamp_set', uses: 0, names: <Name>[Name(code: 'en', value: 'Lamp sets'), Name(code: 'ar', value: 'أطقم مصابيح'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_lamps', keywordID: 'prd_lighting_lamp_piano', uses: 0, names: <Name>[Name(code: 'en', value: 'Piano table Lights'), Name(code: 'ar', value: 'مصباح بيانو'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_lamps', keywordID: 'prd_lighting_lamp_kids', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids lamps'), Name(code: 'ar', value: 'مصابيح أطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_lamps', keywordID: 'prd_lighting_lamp_emergency', uses: 0, names: <Name>[Name(code: 'en', value: 'Emergency lights'), Name(code: 'ar', value: 'مصابيح طوارئ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_ceiling', keywordID: 'prd_lighting_ceiling_chandelier', uses: 0, names: <Name>[Name(code: 'en', value: 'Chandeliers'), Name(code: 'ar', value: 'نجف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_ceiling', keywordID: 'prd_lighting_ceiling_pendant', uses: 0, names: <Name>[Name(code: 'en', value: 'Pendant lighting'), Name(code: 'ar', value: 'مصابيح معلقة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_ceiling', keywordID: 'prd_lighting_ceiling_flush', uses: 0, names: <Name>[Name(code: 'en', value: 'Flush mount lighting'), Name(code: 'ar', value: 'مصابيح ملتصقة بالسقف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_ceiling', keywordID: 'prd_lighting_ceiling_kitchenIsland', uses: 0, names: <Name>[Name(code: 'en', value: 'Kitchen Island lighting'), Name(code: 'ar', value: 'مصابيح جزيرة مطبخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_ceiling', keywordID: 'prd_lighting_ceiling_underCabinet', uses: 0, names: <Name>[Name(code: 'en', value: 'Under cabinet lighting'), Name(code: 'ar', value: 'مصابيح مطبخ سفلية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_ceiling', keywordID: 'prd_lighting_ceiling_track', uses: 0, names: <Name>[Name(code: 'en', value: 'Track lighting'), Name(code: 'ar', value: 'مصابيح مضمار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_ceiling', keywordID: 'prd_lighting_ceiling_recessed', uses: 0, names: <Name>[Name(code: 'en', value: 'Recessed lighting'), Name(code: 'ar', value: 'مصابيح مخفية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_ceiling', keywordID: 'prd_lighting_ceiling_pool', uses: 0, names: <Name>[Name(code: 'en', value: 'Pool table lighting'), Name(code: 'ar', value: 'مصباح طاولة بلياردو'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_ceiling', keywordID: 'prd_lighting_ceiling_spot', uses: 0, names: <Name>[Name(code: 'en', value: 'Spot lights'), Name(code: 'ar', value: 'مصابيح سبوت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_lighting', subGroupID: 'sub_prd_light_ceiling', keywordID: 'prd_lighting_ceiling_kids', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids ceiling lights'), Name(code: 'ar', value: 'مصابيح سقف أطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_woodCoats', keywordID: 'prd_mat_woodPaint_lacquer', uses: 0, names: <Name>[Name(code: 'en', value: 'Lacquer'), Name(code: 'ar', value: 'لاكيه'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_woodCoats', keywordID: 'prd_mat_woodPaint_polyurethane', uses: 0, names: <Name>[Name(code: 'en', value: 'Polyurethane'), Name(code: 'ar', value: 'بولي يوريثان'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_woodCoats', keywordID: 'prd_mat_woodPaint_polycrylic', uses: 0, names: <Name>[Name(code: 'en', value: 'Polycrylic'), Name(code: 'ar', value: 'بوليكريليك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_woodCoats', keywordID: 'prd_mat_woodPaint_varnish', uses: 0, names: <Name>[Name(code: 'en', value: 'Varnish & Shellacs'), Name(code: 'ar', value: 'ورنيش'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_woodCoats', keywordID: 'prd_mat_woodPaint_polyester', uses: 0, names: <Name>[Name(code: 'en', value: 'Polyester Urethane'), Name(code: 'ar', value: 'بولي استر '),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_waterProofing', keywordID: 'prd_mat_waterProof_rubber', uses: 0, names: <Name>[Name(code: 'en', value: 'EPDM Rubber membranes'), Name(code: 'ar', value: 'عزل ماء و رطوبة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_waterProofing', keywordID: 'prd_mat_waterProof_bitumen', uses: 0, names: <Name>[Name(code: 'en', value: 'Bitumen membranes'), Name(code: 'ar', value: 'لفائف بيتومين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_waterProofing', keywordID: 'prd_mat_waterProof_pvc', uses: 0, names: <Name>[Name(code: 'en', value: 'PVC membranes (Thermoplastic polyolefin)'), Name(code: 'ar', value: 'لفائف بوليفيلين بي في سي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_waterProofing', keywordID: 'prd_mat_waterProof_tpo', uses: 0, names: <Name>[Name(code: 'en', value: 'TPO membranes'), Name(code: 'ar', value: 'لفائف تي بي أو'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_waterProofing', keywordID: 'prd_mat_waterProof_polyurethane', uses: 0, names: <Name>[Name(code: 'en', value: 'Polyurethane coating'), Name(code: 'ar', value: 'طلاء بولي يوريثان'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_waterProofing', keywordID: 'prd_mat_waterProof_acrylic', uses: 0, names: <Name>[Name(code: 'en', value: 'Acrylic coating'), Name(code: 'ar', value: 'طلاء أكريليك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_waterProofing', keywordID: 'prd_mat_waterProof_cementitious', uses: 0, names: <Name>[Name(code: 'en', value: 'Cementitious coating'), Name(code: 'ar', value: 'طلاء أسمنتي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatSynth', keywordID: 'prd_mat_heatSynth_reflective', uses: 0, names: <Name>[Name(code: 'en', value: 'Reflective foam sheets'), Name(code: 'ar', value: 'ألواح فوم عاكس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatSynth', keywordID: 'prd_mat_heatSynth_polystyrene', uses: 0, names: <Name>[Name(code: 'en', value: 'EPS Polystyrene sheets'), Name(code: 'ar', value: 'ألواح إي بي إس بولي ستيرين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatSynth', keywordID: 'prd_mat_heatSynth_styro', uses: 0, names: <Name>[Name(code: 'en', value: 'XPS Styrofoam'), Name(code: 'ar', value: 'ستايروفوم إكس بي إس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatSynth', keywordID: 'prd_mat_heatSynth_purSheet', uses: 0, names: <Name>[Name(code: 'en', value: 'Polyurethane Foam sheets'), Name(code: 'ar', value: 'ألواح فوم بولي يوريثان'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatSynth', keywordID: 'prd_mat_heatSynth_purSpray', uses: 0, names: <Name>[Name(code: 'en', value: 'Polyurethane Foam spray'), Name(code: 'ar', value: 'بولي يووريثان رش'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatSynth', keywordID: 'prd_mat_heatSynth_purSection', uses: 0, names: <Name>[Name(code: 'en', value: 'Polyurethane piping sections'), Name(code: 'ar', value: 'قطاعات عزل بولي يوريثان'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatSynth', keywordID: 'prd_mat_heatSynth_phenolic', uses: 0, names: <Name>[Name(code: 'en', value: 'Phenolic foam boards'), Name(code: 'ar', value: 'ألواح فوم فينول'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatSynth', keywordID: 'prd_mat_heatSynth_aerogel', uses: 0, names: <Name>[Name(code: 'en', value: 'Aerogel blankets'), Name(code: 'ar', value: 'بطانية عزل إيرو جيل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_stones', keywordID: 'prd_mat_stone_marble', uses: 0, names: <Name>[Name(code: 'en', value: 'Marble'), Name(code: 'ar', value: 'رخام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_stones', keywordID: 'prd_mat_stone_granite', uses: 0, names: <Name>[Name(code: 'en', value: 'Granite'), Name(code: 'ar', value: 'جرانيت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_stones', keywordID: 'prd_mat_stone_slate', uses: 0, names: <Name>[Name(code: 'en', value: 'Slate'), Name(code: 'ar', value: 'شرائح حجر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_stones', keywordID: 'prd_mat_stone_quartzite', uses: 0, names: <Name>[Name(code: 'en', value: 'Quartzite'), Name(code: 'ar', value: 'كوارتزيت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_stones', keywordID: 'prd_mat_stone_soap', uses: 0, names: <Name>[Name(code: 'en', value: 'Soap stone'), Name(code: 'ar', value: 'حجر أملس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_stones', keywordID: 'prd_mat_stone_travertine', uses: 0, names: <Name>[Name(code: 'en', value: 'Travertine'), Name(code: 'ar', value: 'حجر جيري ترافنتين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_steel', keywordID: 'prd_mat_steel_rebar', uses: 0, names: <Name>[Name(code: 'en', value: 'Steel rebar'), Name(code: 'ar', value: 'حديد تسليح'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_steel', keywordID: 'prd_mat_steel_section', uses: 0, names: <Name>[Name(code: 'en', value: 'Steel sections'), Name(code: 'ar', value: 'قطاعات معدنية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_oak', uses: 0, names: <Name>[Name(code: 'en', value: 'Oak'), Name(code: 'ar', value: 'خشب أرو'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_beech', uses: 0, names: <Name>[Name(code: 'en', value: 'Beech'), Name(code: 'ar', value: 'خشب زان'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_mahogany', uses: 0, names: <Name>[Name(code: 'en', value: 'Mahogany'), Name(code: 'ar', value: 'خشب ماهوجني'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_beechPine', uses: 0, names: <Name>[Name(code: 'en', value: 'Beech pine'), Name(code: 'ar', value: 'خشب موسكي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_ash', uses: 0, names: <Name>[Name(code: 'en', value: 'Ash'), Name(code: 'ar', value: 'خشب بلوط'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_walnut', uses: 0, names: <Name>[Name(code: 'en', value: 'Walnut'), Name(code: 'ar', value: 'خشب الجوز'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_pine', uses: 0, names: <Name>[Name(code: 'en', value: 'Pine'), Name(code: 'ar', value: 'خشب العزيزي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_teak', uses: 0, names: <Name>[Name(code: 'en', value: 'Teak'), Name(code: 'ar', value: 'خشب تك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_rose', uses: 0, names: <Name>[Name(code: 'en', value: 'Rosewood'), Name(code: 'ar', value: 'خشب الورد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_palisander', uses: 0, names: <Name>[Name(code: 'en', value: 'Palisander'), Name(code: 'ar', value: 'خشب البليسندر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_sandal', uses: 0, names: <Name>[Name(code: 'en', value: 'Sandalwood'), Name(code: 'ar', value: 'خشب الصندل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_cherry', uses: 0, names: <Name>[Name(code: 'en', value: 'Cherry wood'), Name(code: 'ar', value: 'خشب الكريز'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_ebony', uses: 0, names: <Name>[Name(code: 'en', value: 'Ebony wood'), Name(code: 'ar', value: 'خشب الابنوس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_solidWood', keywordID: 'prd_mat_wood_maple', uses: 0, names: <Name>[Name(code: 'en', value: 'Maple wood'), Name(code: 'ar', value: 'خشب الحور، القيقب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_sandRubble', keywordID: 'prd_mat_sand_sand', uses: 0, names: <Name>[Name(code: 'en', value: 'Sand & Rubble'), Name(code: 'ar', value: 'رمل و حصى'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_paints', keywordID: 'prd_mat_paint_cement', uses: 0, names: <Name>[Name(code: 'en', value: 'Cement paints'), Name(code: 'ar', value: 'دهانات أسمنتية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_paints', keywordID: 'prd_mat_paint_outdoor', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor paints'), Name(code: 'ar', value: 'دهانات خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_paints', keywordID: 'prd_mat_paint_primer', uses: 0, names: <Name>[Name(code: 'en', value: 'Primer & sealer'), Name(code: 'ar', value: 'معجون و سيلر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_paints', keywordID: 'prd_mat_paint_acrylic', uses: 0, names: <Name>[Name(code: 'en', value: 'Acrylic'), Name(code: 'ar', value: 'أكريليك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_paints', keywordID: 'prd_mat_paint_duco', uses: 0, names: <Name>[Name(code: 'en', value: 'Spray & Duco'), Name(code: 'ar', value: 'رش و دوكو'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_paints', keywordID: 'prd_mat_paint_heatproof', uses: 0, names: <Name>[Name(code: 'en', value: 'Thermal insulation paints'), Name(code: 'ar', value: 'دهانات حرارية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_paints', keywordID: 'prd_mat_paint_fire', uses: 0, names: <Name>[Name(code: 'en', value: 'Fire retardant paints'), Name(code: 'ar', value: 'دهانات مضادة للحريق'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatIMin', keywordID: 'prd_mat_heatmin_vermiculite', uses: 0, names: <Name>[Name(code: 'en', value: 'Vermiculite Asbestos'), Name(code: 'ar', value: 'أسبستوس فيرميكوليت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_metals', keywordID: 'prd_mat_metal_iron', uses: 0, names: <Name>[Name(code: 'en', value: 'Iron'), Name(code: 'ar', value: 'حديد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_metals', keywordID: 'prd_mat_metal_steel', uses: 0, names: <Name>[Name(code: 'en', value: 'Steel'), Name(code: 'ar', value: 'حديد مسلح'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_metals', keywordID: 'prd_mat_metal_aluminum', uses: 0, names: <Name>[Name(code: 'en', value: 'Aluminum'), Name(code: 'ar', value: 'ألمنيوم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_metals', keywordID: 'prd_mat_metal_copper', uses: 0, names: <Name>[Name(code: 'en', value: 'Copper'), Name(code: 'ar', value: 'نحاس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_metals', keywordID: 'prd_mat_metal_silver', uses: 0, names: <Name>[Name(code: 'en', value: 'Sliver'), Name(code: 'ar', value: 'فضة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_metals', keywordID: 'prd_mat_metal_gold', uses: 0, names: <Name>[Name(code: 'en', value: 'Gold'), Name(code: 'ar', value: 'ذهب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_metals', keywordID: 'prd_mat_metal_bronze', uses: 0, names: <Name>[Name(code: 'en', value: 'Bronze'), Name(code: 'ar', value: 'برونز'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_metals', keywordID: 'prd_mat_metal_stainless', uses: 0, names: <Name>[Name(code: 'en', value: 'Stainless steel'), Name(code: 'ar', value: 'ستانلس ستيل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_metals', keywordID: 'prd_mat_metal_chrome', uses: 0, names: <Name>[Name(code: 'en', value: 'Chrome'), Name(code: 'ar', value: 'كروم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_manuWood', keywordID: 'prd_mat_manWood_mdf', uses: 0, names: <Name>[Name(code: 'en', value: 'MDF'), Name(code: 'ar', value: 'خشب مضغوط إم دي إف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_manuWood', keywordID: 'prd_mat_manWood_veneer', uses: 0, names: <Name>[Name(code: 'en', value: 'Veneer wood'), Name(code: 'ar', value: 'قشرة خشب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_manuWood', keywordID: 'prd_mat_manWood_compressed', uses: 0, names: <Name>[Name(code: 'en', value: 'Compressed chip & fire board wood'), Name(code: 'ar', value: 'خشب حبيبي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_manuWood', keywordID: 'prd_mat_manWood_formica', uses: 0, names: <Name>[Name(code: 'en', value: 'Formica'), Name(code: 'ar', value: 'خشب فروميكا'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_manuWood', keywordID: 'prd_mat_manWood_engineered', uses: 0, names: <Name>[Name(code: 'en', value: 'Engineered wood'), Name(code: 'ar', value: 'خشب كونتر طبقات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_manuWood', keywordID: 'prd_mat_manWood_ply', uses: 0, names: <Name>[Name(code: 'en', value: 'Plywood'), Name(code: 'ar', value: 'خشب أبلكاش'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_manuWood', keywordID: 'prd_mat_manWood_cork', uses: 0, names: <Name>[Name(code: 'en', value: 'Cork wood'), Name(code: 'ar', value: 'خشب فلين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatIMin', keywordID: 'prd_mat_heatmin_cellulose', uses: 0, names: <Name>[Name(code: 'en', value: 'Cellulose fibre'), Name(code: 'ar', value: 'ألياف سيليولوز'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatIMin', keywordID: 'prd_mat_heatmin_perlite', uses: 0, names: <Name>[Name(code: 'en', value: 'Perlite insulation boards'), Name(code: 'ar', value: 'ألواح بيرلايت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatIMin', keywordID: 'prd_mat_heatmin_foamGlass', uses: 0, names: <Name>[Name(code: 'en', value: 'Foam glass boards'), Name(code: 'ar', value: 'ألواح فوم زجاجي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatIMin', keywordID: 'prd_mat_heatmin_fiberglassWool', uses: 0, names: <Name>[Name(code: 'en', value: 'Fiberglass wool'), Name(code: 'ar', value: 'صوف زجاجي فايبر جلاس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatIMin', keywordID: 'prd_mat_heatmin_fiberglassPipe', uses: 0, names: <Name>[Name(code: 'en', value: 'Fiberglass piping insulation'), Name(code: 'ar', value: 'عزل صوف زجاجي خراطيم فايبر جلاس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_heatIMin', keywordID: 'prd_mat_heatmin_rockWool', uses: 0, names: <Name>[Name(code: 'en', value: 'Rock wool'), Name(code: 'ar', value: 'صوف صخري'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_gypsum', keywordID: 'prd_mat_gypsum_board', uses: 0, names: <Name>[Name(code: 'en', value: 'Gypsum boards & accessories'), Name(code: 'ar', value: 'ألواح جبسية و اكسسوارات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_gypsum', keywordID: 'prd_mat_gypsum_powder', uses: 0, names: <Name>[Name(code: 'en', value: 'Gypsum powder'), Name(code: 'ar', value: 'جبس أبيض'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_glass', keywordID: 'prd_mat_glass_float', uses: 0, names: <Name>[Name(code: 'en', value: 'Float glass'), Name(code: 'ar', value: 'زجاج مصقول'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_glass', keywordID: 'prd_mat_glass_bullet', uses: 0, names: <Name>[Name(code: 'en', value: 'Bullet proof glass'), Name(code: 'ar', value: 'زجاج مضاد للرصاص'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_glass', keywordID: 'prd_mat_glass_block', uses: 0, names: <Name>[Name(code: 'en', value: 'Glass blocks'), Name(code: 'ar', value: 'طوب زجاجي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_glass', keywordID: 'prd_mat_glass_tempered', uses: 0, names: <Name>[Name(code: 'en', value: 'Tempered & Laminated glass'), Name(code: 'ar', value: 'زجاج سيكوريت مقوى'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_glass', keywordID: 'prd_mat_glass_obscured', uses: 0, names: <Name>[Name(code: 'en', value: 'Obscured glass'), Name(code: 'ar', value: 'زجاج منقوش'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_glass', keywordID: 'prd_mat_glass_mirrored', uses: 0, names: <Name>[Name(code: 'en', value: 'Mirrored glass'), Name(code: 'ar', value: 'زجاج عاكس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_glass', keywordID: 'prd_mat_glass_tinted', uses: 0, names: <Name>[Name(code: 'en', value: ' Tinted glass'), Name(code: 'ar', value: 'زجاج ملون'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_glass', keywordID: 'prd_mat_glass_wired', uses: 0, names: <Name>[Name(code: 'en', value: 'Wired glass'), Name(code: 'ar', value: 'زجاج سلكي و شبكي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_fabrics', keywordID: 'prd_mat_fabric_wool', uses: 0, names: <Name>[Name(code: 'en', value: 'Wool'), Name(code: 'ar', value: 'صوف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_fabrics', keywordID: 'prd_mat_fabric_moquette', uses: 0, names: <Name>[Name(code: 'en', value: 'Carpets'), Name(code: 'ar', value: 'موكيت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_fabrics', keywordID: 'prd_mat_fabric_leather', uses: 0, names: <Name>[Name(code: 'en', value: 'Leather'), Name(code: 'ar', value: 'جلود'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_fabrics', keywordID: 'prd_mat_fabric_upholstery', uses: 0, names: <Name>[Name(code: 'en', value: 'Upholstery fabric'), Name(code: 'ar', value: 'أنسجة تنجيد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_fabrics', keywordID: 'prd_mat_fabric_polyester', uses: 0, names: <Name>[Name(code: 'en', value: 'Polyester'), Name(code: 'ar', value: 'بوليستر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_fabrics', keywordID: 'prd_mat_fabric_silk', uses: 0, names: <Name>[Name(code: 'en', value: 'Silk'), Name(code: 'ar', value: 'حرير'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_fabrics', keywordID: 'prd_mat_fabric_rayon', uses: 0, names: <Name>[Name(code: 'en', value: 'Rayon'), Name(code: 'ar', value: 'رايون'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_fabrics', keywordID: 'prd_mat_fabric_cotton', uses: 0, names: <Name>[Name(code: 'en', value: 'Cotton'), Name(code: 'ar', value: 'قطن'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_fabrics', keywordID: 'prd_mat_fabric_linen', uses: 0, names: <Name>[Name(code: 'en', value: 'Linen'), Name(code: 'ar', value: 'كتان'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_fabrics', keywordID: 'prd_mat_fabric_velvet', uses: 0, names: <Name>[Name(code: 'en', value: 'Velvet'), Name(code: 'ar', value: 'فيلفيت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_fabrics', keywordID: 'prd_mat_fabric_voile', uses: 0, names: <Name>[Name(code: 'en', value: 'Voile'), Name(code: 'ar', value: 'فوال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_fabrics', keywordID: 'prd_mat_fabric_lace', uses: 0, names: <Name>[Name(code: 'en', value: 'Lace'), Name(code: 'ar', value: 'دانتيل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_cement', keywordID: 'prd_mat_cement_white', uses: 0, names: <Name>[Name(code: 'en', value: 'White cement'), Name(code: 'ar', value: 'أسمنت أبيض'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_cement', keywordID: 'prd_mat_cement_portland', uses: 0, names: <Name>[Name(code: 'en', value: 'Portland'), Name(code: 'ar', value: 'أسمنت بورتلاندي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_cement', keywordID: 'prd_mat_cement_board', uses: 0, names: <Name>[Name(code: 'en', value: 'Cement boards'), Name(code: 'ar', value: 'ألواح أسمنتية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_bricks', keywordID: 'prd_mat_brick_cement', uses: 0, names: <Name>[Name(code: 'en', value: 'Cement brick'), Name(code: 'ar', value: 'طوب أسمنتي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_bricks', keywordID: 'prd_mat_brick_red', uses: 0, names: <Name>[Name(code: 'en', value: 'Red brick'), Name(code: 'ar', value: 'طوب أحمر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_bricks', keywordID: 'prd_mat_brick_white', uses: 0, names: <Name>[Name(code: 'en', value: 'Lightweight White brick'), Name(code: 'ar', value: 'طوب أبيض'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_acrylic', keywordID: 'prd_mat_acrylic_tinted', uses: 0, names: <Name>[Name(code: 'en', value: 'Tinted acrylic'), Name(code: 'ar', value: 'أكريليك شفاف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_acrylic', keywordID: 'prd_mat_acrylic_frosted', uses: 0, names: <Name>[Name(code: 'en', value: 'Frosted acrylic'), Name(code: 'ar', value: 'أكريليك نصف شفاف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_materials', subGroupID: 'sub_prd_mat_acrylic', keywordID: 'prd_mat_acrylic_opaque', uses: 0, names: <Name>[Name(code: 'en', value: 'Opaque acrylic'), Name(code: 'ar', value: 'أكريليك غير شفاف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_treatment', keywordID: 'prd_plumbing_treatment_filter', uses: 0, names: <Name>[Name(code: 'en', value: 'Water filters'), Name(code: 'ar', value: 'فلاتر مياه'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_treatment', keywordID: 'prd_plumbing_treatment_system', uses: 0, names: <Name>[Name(code: 'en', value: 'Water treatment systems'), Name(code: 'ar', value: 'أنظمة معالجة مياه'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_treatment', keywordID: 'prd_plumbing_treatment_tank', uses: 0, names: <Name>[Name(code: 'en', value: 'Water tanks'), Name(code: 'ar', value: 'خزانات مياه'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_treatment', keywordID: 'prd_plumbing_treatment_heater', uses: 0, names: <Name>[Name(code: 'en', value: 'Water Heater'), Name(code: 'ar', value: 'سخانات مياه'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_tub', keywordID: 'prd_plumbing_tub_bathTubs', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathtubs'), Name(code: 'ar', value: ' بانيوهات استحمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_tub', keywordID: 'prd_plumbing_tub_faucet', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathtub faucets'), Name(code: 'ar', value: 'صنابير بانيوهات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_toilet', keywordID: 'prd_plumbing_toilet_floorDrain', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom floor drains'), Name(code: 'ar', value: 'مصارف و بلاعات أرضية للحمامات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_toilet', keywordID: 'prd_plumbing_toilet_urinal', uses: 0, names: <Name>[Name(code: 'en', value: 'Urinals'), Name(code: 'ar', value: 'مباول'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_toilet', keywordID: 'prd_plumbing_toilet_bidet', uses: 0, names: <Name>[Name(code: 'en', value: 'Bidet'), Name(code: 'ar', value: 'بيديه شطاف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_toilet', keywordID: 'prd_plumbing_toilet_bidetFaucet', uses: 0, names: <Name>[Name(code: 'en', value: 'Bidet faucets'), Name(code: 'ar', value: 'صنابير بيديه'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_toilet', keywordID: 'prd_plumbing_toilet_toilet', uses: 0, names: <Name>[Name(code: 'en', value: 'Toilets & toilet seats'), Name(code: 'ar', value: 'مراحيض و مجالس مراحيض'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_toilet', keywordID: 'prd_plumbing_toilet_rinser', uses: 0, names: <Name>[Name(code: 'en', value: 'Toilet rinsers'), Name(code: 'ar', value: 'شطافات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_shower', keywordID: 'prd_plumbing_shower_head', uses: 0, names: <Name>[Name(code: 'en', value: 'Shower heads & Body sprays'), Name(code: 'ar', value: 'دش و رشاشات دش'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_shower', keywordID: 'prd_plumbing_shower_panel', uses: 0, names: <Name>[Name(code: 'en', value: 'Shower panels'), Name(code: 'ar', value: 'وحدات دش متكاملة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_shower', keywordID: 'prd_plumbing_shower_steam', uses: 0, names: <Name>[Name(code: 'en', value: 'Steam shower cabins'), Name(code: 'ar', value: 'كابينات دش بخار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_shower', keywordID: 'prd_plumbing_shower_faucet', uses: 0, names: <Name>[Name(code: 'en', value: 'Tub & shower faucet sets'), Name(code: 'ar', value: 'أطقم صنابير بانيوهات و دش'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_shower', keywordID: 'prd_plumbing_shower_base', uses: 0, names: <Name>[Name(code: 'en', value: 'Shower pans & bases'), Name(code: 'ar', value: 'وحدات دش قدم و قواعد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_shower', keywordID: 'prd_plumbing_shower_accessory', uses: 0, names: <Name>[Name(code: 'en', value: 'Shower accessories'), Name(code: 'ar', value: 'اكسسوارات دش استحمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_sanitary', keywordID: 'prd_plumbing_sanitary_drain', uses: 0, names: <Name>[Name(code: 'en', value: 'Drains'), Name(code: 'ar', value: 'بلاعات / مصارف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_sanitary', keywordID: 'prd_plumbing_sanitary_bibbs', uses: 0, names: <Name>[Name(code: 'en', value: 'Hose bibbs'), Name(code: 'ar', value: 'حنفيات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_kitchen', keywordID: 'prd_plumbing_kitchen_rinser', uses: 0, names: <Name>[Name(code: 'en', value: 'Rinsers'), Name(code: 'ar', value: 'مغسلة أكواب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_kitchen', keywordID: 'prd_plumbing_kitchen_sink', uses: 0, names: <Name>[Name(code: 'en', value: 'Kitchen sinks'), Name(code: 'ar', value: 'أحواض مطابخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_kitchen', keywordID: 'prd_plumbing_kitchen_faucet', uses: 0, names: <Name>[Name(code: 'en', value: 'Kitchen faucets'), Name(code: 'ar', value: 'صنابير مطابخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_kitchen', keywordID: 'prd_plumbing_kitchen_potFiller', uses: 0, names: <Name>[Name(code: 'en', value: 'Kitchen pot fillers'), Name(code: 'ar', value: 'صنابير ملئ وعاء'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_kitchen', keywordID: 'prd_plumbing_kitchen_barSink', uses: 0, names: <Name>[Name(code: 'en', value: 'Bar sinks'), Name(code: 'ar', value: 'أحواض بار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_kitchen', keywordID: 'prd_plumbing_kitchen_barFaucet', uses: 0, names: <Name>[Name(code: 'en', value: 'Bar faucets'), Name(code: 'ar', value: 'صنابير بار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_kitchen', keywordID: 'prd_plumbing_kitchen_floorDrain', uses: 0, names: <Name>[Name(code: 'en', value: 'Kitchen floor drains'), Name(code: 'ar', value: 'مصارف أرضية مطبخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_handwash', keywordID: 'prd_plumbing_handwash_washBasins', uses: 0, names: <Name>[Name(code: 'en', value: 'Wash basins'), Name(code: 'ar', value: 'أحواض أيدي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_handwash', keywordID: 'prd_plumbing_handwash_faucet', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom faucets'), Name(code: 'ar', value: 'صنابير حمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_handwash', keywordID: 'prd_plumbing_handwash_accessories', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom accessories'), Name(code: 'ar', value: 'اكسسوارات حمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_handwash', keywordID: 'prd_plumbing_handwash_soap', uses: 0, names: <Name>[Name(code: 'en', value: 'Lotion & soap dispensers'), Name(code: 'ar', value: 'حاوية صابون و لوشن'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_connections', keywordID: 'prd_plumbing_connections_pipes', uses: 0, names: <Name>[Name(code: 'en', value: 'Pipes'), Name(code: 'ar', value: 'مواسير صرف و تغذية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_connections', keywordID: 'prd_plumbing_connections_fittings', uses: 0, names: <Name>[Name(code: 'en', value: 'Fittings'), Name(code: 'ar', value: 'أكواع و وصلات مواسير'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_plumbing', subGroupID: 'sub_prd_plumb_connections', keywordID: 'prd_plumbing_connections_valve', uses: 0, names: <Name>[Name(code: 'en', value: 'Valves'), Name(code: 'ar', value: 'محابس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_pools', keywordID: 'prd_poolSpa_pools_fiberglass', uses: 0, names: <Name>[Name(code: 'en', value: 'Fiberglass pools'), Name(code: 'ar', value: 'حمامات سباحة فايبرجلاس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_pools', keywordID: 'prd_poolSpa_pools_above', uses: 0, names: <Name>[Name(code: 'en', value: 'Above ground  pools'), Name(code: 'ar', value: 'حمامات سباحة فوق الأرض'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_pools', keywordID: 'prd_poolSpa_pools_inflatable', uses: 0, names: <Name>[Name(code: 'en', value: 'Inflatable pools'), Name(code: 'ar', value: 'حمامات سباحة قابلة للنفخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_spa', keywordID: 'prd_poolSpa_spa_sauna', uses: 0, names: <Name>[Name(code: 'en', value: 'Sauna rooms'), Name(code: 'ar', value: 'غرف ساونا'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_spa', keywordID: 'prd_poolSpa_spa_steam', uses: 0, names: <Name>[Name(code: 'en', value: 'Steam rooms'), Name(code: 'ar', value: 'غرف بخار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_spa', keywordID: 'prd_poolSpa_spa_steamShower', uses: 0, names: <Name>[Name(code: 'en', value: 'Steam shower cabins'), Name(code: 'ar', value: 'وحدات دش استحمام بخار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_spa', keywordID: 'prd_poolSpa_spa_jacuzzi', uses: 0, names: <Name>[Name(code: 'en', value: 'Jacuzzi & Hot tubs'), Name(code: 'ar', value: 'جاكوزي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_equipment', keywordID: 'prd_poolSpa_equip_cleaning', uses: 0, names: <Name>[Name(code: 'en', value: 'Cleaning supplies'), Name(code: 'ar', value: 'أدوات تنظيف حمام سباحة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_equipment', keywordID: 'prd_poolSpa_equip_pump', uses: 0, names: <Name>[Name(code: 'en', value: 'Pumps'), Name(code: 'ar', value: 'مضخات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_equipment', keywordID: 'prd_poolSpa_equip_filter', uses: 0, names: <Name>[Name(code: 'en', value: 'Filters'), Name(code: 'ar', value: 'فلاتر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_accessories', keywordID: 'prd_poolSpa_access_handrail', uses: 0, names: <Name>[Name(code: 'en', value: 'Handrails'), Name(code: 'ar', value: 'درابزين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_accessories', keywordID: 'prd_poolSpa_access_grate', uses: 0, names: <Name>[Name(code: 'en', value: 'Gutters & Grating'), Name(code: 'ar', value: 'مصارف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_accessories', keywordID: 'prd_poolSpa_access_light', uses: 0, names: <Name>[Name(code: 'en', value: 'Lighting'), Name(code: 'ar', value: 'إضاءة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_poolSpa', subGroupID: 'sub_prd_pool_accessories', keywordID: 'prd_poolSpa_access_shower', uses: 0, names: <Name>[Name(code: 'en', value: 'Outdoor showers'), Name(code: 'ar', value: 'وحدات دش استحمام خارجية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_roofing', subGroupID: 'sub_prd_roof_drainage', keywordID: 'prd_roof_drainage_gutter', uses: 0, names: <Name>[Name(code: 'en', value: 'Gutters'), Name(code: 'ar', value: 'مصارف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_roofing', subGroupID: 'sub_prd_roof_cladding', keywordID: 'prd_roof_cladding_brick', uses: 0, names: <Name>[Name(code: 'en', value: 'Roof bricks & tiles'), Name(code: 'ar', value: 'قرميد'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_roofing', subGroupID: 'sub_prd_roof_cladding', keywordID: 'prd_roof_cladding_bitumen', uses: 0, names: <Name>[Name(code: 'en', value: 'Corrugatedbitumen sheets'), Name(code: 'ar', value: 'صفائح بيتومينية مموجة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_roofing', subGroupID: 'sub_prd_roof_cladding', keywordID: 'prd_roof_cladding_metal', uses: 0, names: <Name>[Name(code: 'en', value: 'Corrugated metal sheets'), Name(code: 'ar', value: 'صفائح معدنية مموجة شينكو'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_equip', keywordID: 'prd_safety_equip_gasDetector', uses: 0, names: <Name>[Name(code: 'en', value: 'Portable gas detectors'), Name(code: 'ar', value: 'كاشف غاز يدوي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_equip', keywordID: 'prd_safety_equip_rescue', uses: 0, names: <Name>[Name(code: 'en', value: 'Rescue tools & devices'), Name(code: 'ar', value: 'أدوات و أجهزة إنقاذ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_equip', keywordID: 'prd_safety_equip_firstAid', uses: 0, names: <Name>[Name(code: 'en', value: 'Emergency & first aid kits'), Name(code: 'ar', value: 'أدوات طوارئ و إعافات أولية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_clothes', keywordID: 'prd_safety_clothes_coverall', uses: 0, names: <Name>[Name(code: 'en', value: 'Coveralls'), Name(code: 'ar', value: 'معاطف عمل'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_clothes', keywordID: 'prd_safety_clothes_chemicalSuit', uses: 0, names: <Name>[Name(code: 'en', value: 'Chemical protection suits'), Name(code: 'ar', value: 'بدلة واقية من الكيماويات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_clothes', keywordID: 'prd_safety_clothes_eyeProtection', uses: 0, names: <Name>[Name(code: 'en', value: 'Eye protectors'), Name(code: 'ar', value: 'واقيات عيون'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_clothes', keywordID: 'prd_safety_clothes_earProtection', uses: 0, names: <Name>[Name(code: 'en', value: 'Ear protectors'), Name(code: 'ar', value: 'واقيات أذن'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_clothes', keywordID: 'prd_safety_clothes_helmet', uses: 0, names: <Name>[Name(code: 'en', value: 'Helmets'), Name(code: 'ar', value: 'خوذ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_clothes', keywordID: 'prd_safety_clothes_glove', uses: 0, names: <Name>[Name(code: 'en', value: 'Gloves'), Name(code: 'ar', value: 'قفازات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_clothes', keywordID: 'prd_safety_clothes_shoe', uses: 0, names: <Name>[Name(code: 'en', value: 'Shoes'), Name(code: 'ar', value: 'أحذية حامية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_clothes', keywordID: 'prd_safety_clothes_respirator', uses: 0, names: <Name>[Name(code: 'en', value: 'Respirators'), Name(code: 'ar', value: 'كمامات تنفس'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_floorProtection', keywordID: 'prd_safety_floorProtection_cardboard', uses: 0, names: <Name>[Name(code: 'en', value: 'Cardboard roll'), Name(code: 'ar', value: 'لفة كرتون'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_safety', subGroupID: 'sub_prd_safety_floorProtection', keywordID: 'prd_safety_floorProtection_plastic', uses: 0, names: <Name>[Name(code: 'en', value: 'plastic roll'), Name(code: 'ar', value: 'لفة بلاستيك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_surveillance', keywordID: 'prd_security_surv_camera', uses: 0, names: <Name>[Name(code: 'en', value: 'Video surveillance systems'), Name(code: 'ar', value: 'أنظمة مراقبة فيديو'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_surveillance', keywordID: 'prd_security_surv_thermal', uses: 0, names: <Name>[Name(code: 'en', value: 'Thermal imaging systems'), Name(code: 'ar', value: 'أنظمة تصوير حراري'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_surveillance', keywordID: 'prd_security_surv_motion', uses: 0, names: <Name>[Name(code: 'en', value: 'Motion sensors'), Name(code: 'ar', value: 'حساسات حركة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_safes', keywordID: 'prd_security_safes_wall', uses: 0, names: <Name>[Name(code: 'en', value: 'Wall safes'), Name(code: 'ar', value: 'خزن حائطية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_safes', keywordID: 'prd_security_safes_portable', uses: 0, names: <Name>[Name(code: 'en', value: 'Portable safes'), Name(code: 'ar', value: 'خزن متنقلة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_safes', keywordID: 'prd_security_safes_mini', uses: 0, names: <Name>[Name(code: 'en', value: 'Mini safes'), Name(code: 'ar', value: 'خزن صغيرة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_safes', keywordID: 'prd_security_safes_vault', uses: 0, names: <Name>[Name(code: 'en', value: 'Vaults'), Name(code: 'ar', value: 'خزن سرداب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_safes', keywordID: 'prd_security_safes_fire', uses: 0, names: <Name>[Name(code: 'en', value: 'Fire proof safes'), Name(code: 'ar', value: 'خزن مضادة للحريق'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_roadControl', keywordID: 'prd_security_road_bollard', uses: 0, names: <Name>[Name(code: 'en', value: 'Bollards'), Name(code: 'ar', value: 'بولارد فاصل حركة أرضي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_roadControl', keywordID: 'prd_security_road_tire', uses: 0, names: <Name>[Name(code: 'en', value: 'Tire killers'), Name(code: 'ar', value: 'قاتل إطارات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_roadControl', keywordID: 'prd_security_road_barrier', uses: 0, names: <Name>[Name(code: 'en', value: 'Road barriers'), Name(code: 'ar', value: 'فاصل طريق'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_accessibility', keywordID: 'prd_security_access_accessControl', uses: 0, names: <Name>[Name(code: 'en', value: 'Access control systems'), Name(code: 'ar', value: 'أنظمة دخول'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_accessibility', keywordID: 'prd_security_access_eas', uses: 0, names: <Name>[Name(code: 'en', value: 'EAS systems'), Name(code: 'ar', value: 'أنظمة أمن هوائي EAS'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_accessibility', keywordID: 'prd_security_access_detector', uses: 0, names: <Name>[Name(code: 'en', value: 'Metal detector portals'), Name(code: 'ar', value: 'بوابات كشف معادن'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_security', subGroupID: 'sub_prd_security_accessibility', keywordID: 'prd_security_access_turnstile', uses: 0, names: <Name>[Name(code: 'en', value: 'Turnstiles'), Name(code: 'ar', value: 'بوابات مرور فردية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_smartHome', subGroupID: 'sub_prd_smart_automation', keywordID: 'prd_smart_auto_center', uses: 0, names: <Name>[Name(code: 'en', value: 'Home automation centers'), Name(code: 'ar', value: 'أنظمة تحكم منزلي آلية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_smartHome', subGroupID: 'sub_prd_smart_automation', keywordID: 'prd_smart_auto_system', uses: 0, names: <Name>[Name(code: 'en', value: 'Automation systems'), Name(code: 'ar', value: 'لوحات تحكم منزلي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_smartHome', subGroupID: 'sub_prd_smart_audio', keywordID: 'prd_smart_audio_system', uses: 0, names: <Name>[Name(code: 'en', value: 'Audio systems'), Name(code: 'ar', value: 'أنظمة صوتية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_smartHome', subGroupID: 'sub_prd_smart_audio', keywordID: 'prd_smart_audio_theatre', uses: 0, names: <Name>[Name(code: 'en', value: 'Home theatre systems'), Name(code: 'ar', value: 'أنظمة مسرح منزلي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_smartHome', subGroupID: 'sub_prd_smart_audio', keywordID: 'prd_smart_audio_speaker', uses: 0, names: <Name>[Name(code: 'en', value: 'Wall & ceiling speakers'), Name(code: 'ar', value: 'سماعات حوائط و أسقف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_smartHome', subGroupID: 'sub_prd_smart_audio', keywordID: 'prd_smart_audio_wirelessSpeaker', uses: 0, names: <Name>[Name(code: 'en', value: 'Wireless speakers'), Name(code: 'ar', value: 'سماعات لاسلكية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_smartHome', subGroupID: 'sub_prd_smart_audio', keywordID: 'prd_smart_audio_controller', uses: 0, names: <Name>[Name(code: 'en', value: 'Audio controllers'), Name(code: 'ar', value: 'متحكمات صوت'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_stairs', subGroupID: 'sub_prd_stairs_handrails', keywordID: 'prd_stairs_handrails_wood', uses: 0, names: <Name>[Name(code: 'en', value: 'Wooden handrails'), Name(code: 'ar', value: 'درابزين خشبي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_stairs', subGroupID: 'sub_prd_stairs_handrails', keywordID: 'prd_stairs_handrails_metal', uses: 0, names: <Name>[Name(code: 'en', value: 'Metal handrails'), Name(code: 'ar', value: 'درابزين معدني'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_stairs', subGroupID: 'sub_prd_stairs_handrails', keywordID: 'prd_stairs_handrails_parts', uses: 0, names: <Name>[Name(code: 'en', value: 'Handrail parts'), Name(code: 'ar', value: 'أجزاء درابزين'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_shades', keywordID: 'prd_structure_shades_pergola', uses: 0, names: <Name>[Name(code: 'en', value: 'Pergola'), Name(code: 'ar', value: 'برجولة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_shades', keywordID: 'prd_structure_shades_gazebo', uses: 0, names: <Name>[Name(code: 'en', value: 'Gazebos'), Name(code: 'ar', value: 'جازيبو'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_shades', keywordID: 'prd_structure_shades_sail', uses: 0, names: <Name>[Name(code: 'en', value: 'Shade sails'), Name(code: 'ar', value: 'تغطيات شراعية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_shades', keywordID: 'prd_structure_shades_canopy', uses: 0, names: <Name>[Name(code: 'en', value: 'Canopy'), Name(code: 'ar', value: 'مظلة أرضية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_shades', keywordID: 'prd_structure_shades_awning', uses: 0, names: <Name>[Name(code: 'en', value: 'Awning'), Name(code: 'ar', value: 'مظلة حائطية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_shades', keywordID: 'prd_structure_shades_tent', uses: 0, names: <Name>[Name(code: 'en', value: 'tent'), Name(code: 'ar', value: 'خيمة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_shades', keywordID: 'prd_structure_shades_umbrella', uses: 0, names: <Name>[Name(code: 'en', value: 'Umbrella'), Name(code: 'ar', value: 'شمسية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_light', keywordID: 'prd_structure_light_arbor', uses: 0, names: <Name>[Name(code: 'en', value: 'Garden Arbor'), Name(code: 'ar', value: 'معرش شجري'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_light', keywordID: 'prd_structure_light_shed', uses: 0, names: <Name>[Name(code: 'en', value: 'Shed'), Name(code: 'ar', value: 'كوخ'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_light', keywordID: 'prd_structure_light_kiosk', uses: 0, names: <Name>[Name(code: 'en', value: 'Kiosk'), Name(code: 'ar', value: 'كشك'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_light', keywordID: 'prd_structure_light_playhouse', uses: 0, names: <Name>[Name(code: 'en', value: 'Kids playhouse'), Name(code: 'ar', value: 'بيت لعب أطفال'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_light', keywordID: 'prd_structure_light_greenHouse', uses: 0, names: <Name>[Name(code: 'en', value: 'Greenhouse'), Name(code: 'ar', value: 'صوبة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_light', keywordID: 'prd_structure_light_glassHouse', uses: 0, names: <Name>[Name(code: 'en', value: 'Glass house'), Name(code: 'ar', value: 'بيت زجاجي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_structure', subGroupID: 'sub_prd_struc_light', keywordID: 'prd_structure_light_trailer', uses: 0, names: <Name>[Name(code: 'en', value: 'Construction trailers & Caravans'), Name(code: 'ar', value: 'كارافان و مقطورات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_cladding', keywordID: 'prd_walls_cladding_mosaic', uses: 0, names: <Name>[Name(code: 'en', value: 'Mosaic tiling'), Name(code: 'ar', value: 'موزايك حائط'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_cladding', keywordID: 'prd_walls_cladding_murals', uses: 0, names: <Name>[Name(code: 'en', value: 'Tile mural'), Name(code: 'ar', value: 'جدارية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_cladding', keywordID: 'prd_walls_cladding_borders', uses: 0, names: <Name>[Name(code: 'en', value: 'Accent, trim & border tiles'), Name(code: 'ar', value: 'حليات و زوايا'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_cladding', keywordID: 'prd_walls_cladding_tiles', uses: 0, names: <Name>[Name(code: 'en', value: 'Wall tiles'), Name(code: 'ar', value: 'بلاطات حائط'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_cladding', keywordID: 'prd_walls_cladding_veneer', uses: 0, names: <Name>[Name(code: 'en', value: 'Siding & stone veneer slices'), Name(code: 'ar', value: 'شرائح صخرية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_cladding', keywordID: 'prd_walls_cladding_panels', uses: 0, names: <Name>[Name(code: 'en', value: 'Wall panels'), Name(code: 'ar', value: 'بانوهات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_cladding', keywordID: 'prd_walls_cladding_wood', uses: 0, names: <Name>[Name(code: 'en', value: 'Wood wall panels'), Name(code: 'ar', value: 'تجاليد خشب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_cladding', keywordID: 'prd_walls_cladding_metal', uses: 0, names: <Name>[Name(code: 'en', value: 'Metal cladding'), Name(code: 'ar', value: 'تجاليد معدنية'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_cladding', keywordID: 'prd_walls_cladding_wallpaper', uses: 0, names: <Name>[Name(code: 'en', value: 'Wall paper'), Name(code: 'ar', value: 'ورق حائط'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_partitions', keywordID: 'prd_walls_partitions_screens', uses: 0, names: <Name>[Name(code: 'en', value: 'Screens & room divider'), Name(code: 'ar', value: 'فاصل غرفة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_partitions', keywordID: 'prd_walls_partitions_showerStalls', uses: 0, names: <Name>[Name(code: 'en', value: 'Shower cabinet'), Name(code: 'ar', value: 'وحدة دش استحمام'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_partitions', keywordID: 'prd_walls_partitions_doubleWalls', uses: 0, names: <Name>[Name(code: 'en', value: 'Double wall section'), Name(code: 'ar', value: 'قطاع حائط مزدوج'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_moldings', keywordID: 'prd_walls_molding_rail', uses: 0, names: <Name>[Name(code: 'en', value: 'Rails & trims'), Name(code: 'ar', value: 'وزر حائطي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_moldings', keywordID: 'prd_walls_molding_onlay', uses: 0, names: <Name>[Name(code: 'en', value: 'Onlays & Appliques'), Name(code: 'ar', value: 'منحوتات و زخرفيات'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_moldings', keywordID: 'prd_walls_molding_column', uses: 0, names: <Name>[Name(code: 'en', value: 'Columns & Capitals'), Name(code: 'ar', value: 'أعمدة و تيجان'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_moldings', keywordID: 'prd_walls_molding_medallion', uses: 0, names: <Name>[Name(code: 'en', value: 'Ceiling Medallions'), Name(code: 'ar', value: 'مدالية سقف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_moldings', keywordID: 'prd_walls_molding_corbel', uses: 0, names: <Name>[Name(code: 'en', value: 'Corbels'), Name(code: 'ar', value: 'كرابيل أسقف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_walls', subGroupID: 'sub_prd_walls_ceiling', keywordID: 'prd_walls_ceiling_tiles', uses: 0, names: <Name>[Name(code: 'en', value: 'Ceiling tiles'), Name(code: 'ar', value: 'بلاطات تجليد أسقف'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price', keywordID: 'prd_price_sell_egp_100_500', uses: 0, names: <Name>[Name(code: 'en', value: '10 - 500 EGP'), Name(code: 'ar', value: 'بين  10 - 500 جم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price', keywordID: 'prd_price_sell_egp_500_1k', uses: 0, names: <Name>[Name(code: 'en', value: '500 - 1K EGP'), Name(code: 'ar', value: 'بين  500 - 1 ألف جم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price', keywordID: 'prd_price_sell_egp_1k_2k', uses: 0, names: <Name>[Name(code: 'en', value: '1K - 2K EGP'), Name(code: 'ar', value: 'بين  1 ألف - 2 ألف جم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price', keywordID: 'prd_price_sell_egp_2k_5k', uses: 0, names: <Name>[Name(code: 'en', value: '2K - 5K EGP'), Name(code: 'ar', value: 'بين  2 ألف - 5 ألف جم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price', keywordID: 'prd_price_sell_egp_5k_10k', uses: 0, names: <Name>[Name(code: 'en', value: '5K - 10K EGP'), Name(code: 'ar', value: 'بين  5 ألف - 10 ألف جم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price', keywordID: 'prd_price_sell_egp_10k_20k', uses: 0, names: <Name>[Name(code: 'en', value: '10K - 20K EGP'), Name(code: 'ar', value: 'بين  10 ألف - 20 ألف جم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price', keywordID: 'prd_price_sell_egp_20k_50k', uses: 0, names: <Name>[Name(code: 'en', value: '20K - 50K EGP'), Name(code: 'ar', value: 'بين  20 ألف - 50 ألف جم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price', keywordID: 'prd_price_sell_egp_50k_100k', uses: 0, names: <Name>[Name(code: 'en', value: '50K - 100K EGP'), Name(code: 'ar', value: 'بين  50 ألف - 100 ألف جم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price', keywordID: 'prd_price_sell_egp_100k_200k', uses: 0, names: <Name>[Name(code: 'en', value: '100K - 200K EGP'), Name(code: 'ar', value: 'بين  100 ألف - 200 ألف جم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price', keywordID: 'prd_price_sell_egp_200k_500k', uses: 0, names: <Name>[Name(code: 'en', value: '200K - 500K EGP'), Name(code: 'ar', value: 'بين  200 ألف - 500 ألف جم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price', keywordID: 'prd_price_sell_egp_500k_1M', uses: 0, names: <Name>[Name(code: 'en', value: '500K - 1M EGP'), Name(code: 'ar', value: 'بين  500 ألف - 1 مليون جم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price', keywordID: 'prd_price_sell_egp_more', uses: 0, names: <Name>[Name(code: 'en', value: 'More than 1M EGP'), Name(code: 'ar', value: 'أكثر من 1 مليون جم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_priceType', keywordID: 'prd_price_type_sale', uses: 0, names: <Name>[Name(code: 'en', value: 'Selling price'), Name(code: 'ar', value: 'سعر البيع'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_priceType', keywordID: 'prd_price_type_rent', uses: 0, names: <Name>[Name(code: 'en', value: 'Rent price'), Name(code: 'ar', value: 'سعر الإيجار'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_rentType', keywordID: 'prd_price_rent_hour', uses: 0, names: <Name>[Name(code: 'en', value: 'Per Hour'), Name(code: 'ar', value: 'في الساعة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_rentType', keywordID: 'prd_price_rent_day', uses: 0, names: <Name>[Name(code: 'en', value: 'Per Day'), Name(code: 'ar', value: 'في اليوم'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_rentType', keywordID: 'prd_price_rent_week', uses: 0, names: <Name>[Name(code: 'en', value: 'Per Week'), Name(code: 'ar', value: 'في الأسبوع'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_rentType', keywordID: 'prd_price_rent_year', uses: 0, names: <Name>[Name(code: 'en', value: 'Per Year'), Name(code: 'ar', value: 'في السنة'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price_unit', keywordID: 'pd_price_unit_m', uses: 0, names: <Name>[Name(code: 'en', value: 'Meter'), Name(code: 'ar', value: 'متر طولي'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price_unit', keywordID: 'pd_price_unit_sqm', uses: 0, names: <Name>[Name(code: 'en', value: 'Square Meter'), Name(code: 'ar', value: 'متر مربع'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price_unit', keywordID: 'pd_price_unit_cubicm', uses: 0, names: <Name>[Name(code: 'en', value: 'Cubic Meter'), Name(code: 'ar', value: 'متر مكعب'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price_unit', keywordID: 'pd_price_unit_ml', uses: 0, names: <Name>[Name(code: 'en', value: 'Millilitre'), Name(code: 'ar', value: 'مللي لتر'),],),
        const Keyword(flyerType: FlyerType.product, groupID: 'group_prd_price', subGroupID: 'sub_prd_price_unit', keywordID: 'pd_price_unit_l', uses: 0, names: <Name>[Name(code: 'en', value: 'Litre'), Name(code: 'ar', value: 'لتر'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_administration', keywordID: 'space_office', uses: 0, names: <Name>[Name(code: 'en', value: 'Office'), Name(code: 'ar', value: 'مكتب'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_administration', keywordID: 'space_kitchenette', uses: 0, names: <Name>[Name(code: 'en', value: 'Office Kitchenette'), Name(code: 'ar', value: 'أوفيس / مطبخ صغير'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_administration', keywordID: 'space_meetingRoom', uses: 0, names: <Name>[Name(code: 'en', value: 'Meeting room'), Name(code: 'ar', value: 'غرفة اجتماعات'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_administration', keywordID: 'space_seminarHall', uses: 0, names: <Name>[Name(code: 'en', value: 'Seminar hall'), Name(code: 'ar', value: 'قاعة سمينار'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_administration', keywordID: 'space_conventionHall', uses: 0, names: <Name>[Name(code: 'en', value: 'Convention hall'), Name(code: 'ar', value: 'قاعة عرض'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_educational', keywordID: 'space_lectureRoom', uses: 0, names: <Name>[Name(code: 'en', value: 'Lecture room'), Name(code: 'ar', value: 'غرفة محاضرات'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_educational', keywordID: 'space_library', uses: 0, names: <Name>[Name(code: 'en', value: 'Library'), Name(code: 'ar', value: 'مكتبة'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_entertainment', keywordID: 'space_theatre', uses: 0, names: <Name>[Name(code: 'en', value: 'Theatre'), Name(code: 'ar', value: 'مسرح'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_entertainment', keywordID: 'space_concertHall', uses: 0, names: <Name>[Name(code: 'en', value: 'Concert hall'), Name(code: 'ar', value: 'قاعة موسيقية'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_entertainment', keywordID: 'space_homeCinema', uses: 0, names: <Name>[Name(code: 'en', value: 'Home Cinema'), Name(code: 'ar', value: 'مسرح منزلي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_medical', keywordID: 'space_spa', uses: 0, names: <Name>[Name(code: 'en', value: 'Spa'), Name(code: 'ar', value: 'منتجع صحي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_lobby', uses: 0, names: <Name>[Name(code: 'en', value: 'Lobby'), Name(code: 'ar', value: 'ردهة'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_living', uses: 0, names: <Name>[Name(code: 'en', value: 'Living room'), Name(code: 'ar', value: 'غرفة معيشة'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_bedroom', uses: 0, names: <Name>[Name(code: 'en', value: 'Bedroom'), Name(code: 'ar', value: 'غرفة نوم'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_kitchen', uses: 0, names: <Name>[Name(code: 'en', value: 'Home Kitchen'), Name(code: 'ar', value: 'مطبخ'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_bathroom', uses: 0, names: <Name>[Name(code: 'en', value: 'Bathroom'), Name(code: 'ar', value: 'حمام'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_reception', uses: 0, names: <Name>[Name(code: 'en', value: 'Reception'), Name(code: 'ar', value: 'استقبال'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_salon', uses: 0, names: <Name>[Name(code: 'en', value: 'Salon'), Name(code: 'ar', value: 'صالون'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_laundry', uses: 0, names: <Name>[Name(code: 'en', value: 'Home Laundry'), Name(code: 'ar', value: 'غرفة غسيل'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_balcony', uses: 0, names: <Name>[Name(code: 'en', value: 'Terrace'), Name(code: 'ar', value: 'تراس'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_toilet', uses: 0, names: <Name>[Name(code: 'en', value: 'Toilet'), Name(code: 'ar', value: 'دورة مياه'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_dining', uses: 0, names: <Name>[Name(code: 'en', value: 'Dining room'), Name(code: 'ar', value: 'غرفة طعام'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_stairs', uses: 0, names: <Name>[Name(code: 'en', value: 'Stairs'), Name(code: 'ar', value: 'سلالم'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_attic', uses: 0, names: <Name>[Name(code: 'en', value: 'Attic'), Name(code: 'ar', value: 'علية / صندرة'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_corridor', uses: 0, names: <Name>[Name(code: 'en', value: 'Corridor'), Name(code: 'ar', value: 'رواق / طرقة'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_garage', uses: 0, names: <Name>[Name(code: 'en', value: 'Garage'), Name(code: 'ar', value: 'جراج'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_residential', keywordID: 'space_storage', uses: 0, names: <Name>[Name(code: 'en', value: 'Storage room'), Name(code: 'ar', value: 'مخزن'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_retail', keywordID: 'space_store', uses: 0, names: <Name>[Name(code: 'en', value: 'Store / Shop'), Name(code: 'ar', value: 'محل / متجر'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_sports', keywordID: 'space_gymnasium', uses: 0, names: <Name>[Name(code: 'en', value: 'Gymnasium'), Name(code: 'ar', value: 'جيمنازيوم'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_sports', keywordID: 'space_sportsCourt', uses: 0, names: <Name>[Name(code: 'en', value: 'Sports court'), Name(code: 'ar', value: 'ملعب رياضي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_sports', keywordID: 'space_sportStadium', uses: 0, names: <Name>[Name(code: 'en', value: 'Stadium'), Name(code: 'ar', value: 'استاد رياضي'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_utilities', keywordID: 'pFeature_elevator', uses: 0, names: <Name>[Name(code: 'en', value: 'Elevator'), Name(code: 'ar', value: 'مصعد'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_utilities', keywordID: 'space_electricityRoom', uses: 0, names: <Name>[Name(code: 'en', value: 'Electricity rooms'), Name(code: 'ar', value: 'غرفة كهرباء'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_utilities', keywordID: 'space_plumbingRoom', uses: 0, names: <Name>[Name(code: 'en', value: 'Plumbing rooms'), Name(code: 'ar', value: 'غرفة صحي و صرف'),],),
        const Keyword(flyerType: FlyerType.design, groupID: 'group_space_type', subGroupID: 'ppt_lic_utilities', keywordID: 'space_mechanicalRoom', uses: 0, names: <Name>[Name(code: 'en', value: 'Mechanical rooms'), Name(code: 'ar', value: 'غرفة ميكانيكية'),],),
      ];
  }
// =============================================================================
}
// -----------------------------------------------------------------------------
//   static List<Namez> flyerTypesNamez(){
//     return
//       <Namez>[
//         // Namez(id: 'FlyerType.Property',names: <Name>[Name(code: 'en', value: 'Properties'), Name(code: 'ar', value: 'عقارات')]),
//         // Namez(id: 'FlyerType.Design',names: <Name>[Name(code: 'en', value: 'Designs & Projects'), Name(code: 'ar', value: 'تصاميم و مشاريع')]),
//         // Namez(id: 'FlyerType.Project',names: <Name>[Name(code: 'en', value: 'Designs & Projects'), Name(code: 'ar', value: 'تصاميم و مشاريع')]),
//         // Namez(id: 'FlyerType.Product',names: <Name>[Name(code: 'en', value: 'Products'), Name(code: 'ar', value: 'منتجات')]),
//         // Namez(id: 'FlyerType.Equipment',names: <Name>[Name(code: 'en', value: 'Equipment'), Name(code: 'ar', value: 'معدات')]),
//         // Namez(id: 'FlyerType.Craft',names: <Name>[Name(code: 'en', value: 'Craft Samples'), Name(code: 'ar', value: 'عينات حرفية')]),
//       ];
//   }


