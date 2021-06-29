import 'package:bldrs/models/keywords/filter_model.dart';
import 'package:flutter/foundation.dart';

class KeywordModel {
  final String id;
  final String filterID;
  final String groupID;
  final String subGroupID;
  final String name;
  final int uses;

  KeywordModel({
    @required this.id,
    @required this.filterID,
    @required this.groupID,
    @required this.subGroupID,
    @required this.name,
    @required this.uses,
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
        _firstKeyword.filterID == _secondKeyword.filterID &&
        _firstKeyword.name == _secondKeyword.name &&
        _firstKeyword.id == _secondKeyword.id &&
        _firstKeyword.groupID == _secondKeyword.groupID &&
        _firstKeyword.subGroupID == _secondKeyword.subGroupID &&
        _firstKeyword.uses == _secondKeyword.uses ?
            true : false;

    return _keywordsAreTheSame;
  }

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
  static bool keywordsContainThisFilterID({List<KeywordModel> keywords, String filterID}){

    bool _keywordsContainThisID = false;

    keywords.forEach((keyword) {
      if(keyword.filterID == filterID){
        _keywordsContainThisID = true;
      }
    });

    return _keywordsContainThisID;
  }
// -----------------------------------------------------------------------------
  static List<String> getFiltersIDs(){
    List<String> _filtersIDs = new List();

    return _filtersIDs;
  }
// -----------------------------------------------------------------------------
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
  static List<KeywordModel> getKeywordModelsByGroupID({FilterModel filterModel, String groupID}){
    List<KeywordModel> _keywordModels = new List();

    filterModel.keywordModels.forEach((keyword) {
      if(!_keywordModels.contains(keyword) && keyword.groupID == groupID){
        _keywordModels.add(keyword);
      }
    });

    return _keywordModels;
  }
// -----------------------------------------------------------------------------
  static List<KeywordModel> getKeywordModelsByFilterID(String filterID){
    List<KeywordModel> _keywordModels = new List();

    return _keywordModels;
  }


}

