import 'package:bldrs/controllers/theme/keywordz.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/flyer_type_class.dart';
import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:bldrs/models/secondary_models/namez_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class KeywordModel {
  final String keywordID;
  final FlyerType flyerType;
  final String groupID;
  final String subGroupID;
  final int uses;
  final List<Namez> names;

  KeywordModel({
    @required this.keywordID,
    @required this.flyerType,
    @required this.groupID,
    @required this.subGroupID,
    @required this.uses,
    this.names,
});
// -----------------------------------------------------------------------------
  static String getImagePath(String id){
    return 'assets/keywords/$id.jpg';
  }
// -----------------------------------------------------------------------------
  static bool KeywordsAreTheSame(KeywordModel _firstKeyword, KeywordModel _secondKeyword){
    bool _keywordsAreTheSame =
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
  static bool isIconless(KeywordModel keywordModel){
    bool _isIconless =
    keywordModel.groupID == 'numberOfRooms' ? true :
    keywordModel.groupID == 'numberOfBathrooms' ? true :
    keywordModel.groupID == 'parkingLots' ? true :
    keywordModel.groupID == 'propertyArea' ? true :
    keywordModel.groupID == 'lotArea' ? true :
    keywordModel.groupID == 'inCompound' ? true :
    keywordModel.groupID == 'numberOfFloor' ? true :
    keywordModel.groupID == 'buildingAge' ? true :
    false;

    return _isIconless;
  }
// -----------------------------------------------------------------------------
  /// tamam
  static List<KeywordModel> getKeywordsByFlyerType(FlyerType flyerType){
    List<KeywordModel> _keywords = new List();

    AllKeywords.bldrsKeywords().forEach((keyword) {
      if (keyword.flyerType == flyerType){
        _keywords.add(keyword);
      }
    });

    return _keywords;
  }
// -----------------------------------------------------------------------------
  /// tamam
  static List<KeywordModel> getKeywordsByGroupID(String groupID){
    List<KeywordModel> _keywords = new List();

    AllKeywords.bldrsKeywords().forEach((keyword) {
      if (keyword.groupID == groupID){
        _keywords.add(keyword);
      }
    });

    return _keywords;
  }
// -----------------------------------------------------------------------------
  /// tamam
  static List<KeywordModel> getKeywordsBySubGroupID(String subGroupID){
    List<KeywordModel> _keywords = new List();

    AllKeywords.bldrsKeywords().forEach((keyword) {
      if (keyword.subGroupID == subGroupID){
        _keywords.add(keyword);
      }
    });

    return _keywords;
  }
// -----------------------------------------------------------------------------
  /// tamam
  static List<String> getGroupsIDsByFlyerType(FlyerType flyerType){
    List<String> _groupsIDs = new List();

    AllKeywords.bldrsKeywords().forEach((keyword) {
      if (keyword.flyerType == flyerType && !_groupsIDs.contains(keyword.groupID)){
        _groupsIDs.add(keyword.groupID);
      }
    });

    return _groupsIDs;
  }
// -----------------------------------------------------------------------------
  /// tamam
  static KeywordModel getKeywordModelByKeywordID(String keywordID){
    KeywordModel _keyword = AllKeywords.bldrsKeywords().firstWhere((keyword) => keyword.keywordID == keywordID, orElse: () => null);
    return
        _keyword;
  }

// -----------------------------------------------------------------------------
  static String getKeywordNameByKeywordID(BuildContext context, String keywordID){
    KeywordModel _keyword = getKeywordModelByKeywordID(keywordID);
    String _nameWithCurrentLanguage = Namez.getNameWithCurrentLanguageFromListOfNamez(context, _keyword?.names);
    return _nameWithCurrentLanguage;
  }
// -----------------------------------------------------------------------------
  static bool keywordsContainThisFlyerType({List<KeywordModel> keywords, FlyerType flyerType}){

    bool _keywordsContainThisFlyerType = false;

    keywords.forEach((keyword) {
      if(keyword.flyerType == flyerType){
        _keywordsContainThisFlyerType = true;
      }
    });

    return _keywordsContainThisFlyerType;
  }
// -----------------------------------------------------------------------------
  /// Task : should move this to FilterModel class instead
  static List<String> getGroupsIDsFromFilterModel(FilterModel filterModel){
    List<String> _groupsIDs = new List();

    List<KeywordModel> _keywords = filterModel.keywordModels;

    _keywords.forEach((keyword) {

      String _groupID = keyword.groupID;

      if(!_groupsIDs.contains(_groupID) && _groupID != ''){
        _groupsIDs.add(keyword.groupID);
      }
    });

    return _groupsIDs;
  }
// -----------------------------------------------------------------------------
  static List<KeywordModel> getKeywordModelsByGroupIDAndFilterModel({FilterModel filterModel, String groupID}){
    List<KeywordModel> _keywordModels = new List();

    filterModel.keywordModels.forEach((keyword) {
      if(!_keywordModels.contains(keyword) && keyword.groupID == groupID){
        _keywordModels.add(keyword);
      }
    });

    return _keywordModels;
  }
// -----------------------------------------------------------------------------
  /// TASK : should delete this
  static List<KeywordModel> getKeywordModelsByCategoryID(String filterID){
    List<KeywordModel> _keywordModels = new List();

    return _keywordModels;
  }
// -----------------------------------------------------------------------------
}

