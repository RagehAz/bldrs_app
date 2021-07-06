import 'package:bldrs/models/keywords/group_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';

class FilterKeys {
// -----------------------------------------------------------------------------
  static  List<KeywordModel> propertyForms(){
    String _groupID = 'group_ppt_form';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<KeywordModel> propertyTypes(){
    String _groupID = 'group_ppt_type';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<KeywordModel> propertyLicenses(){
    String _groupID = 'group_ppt_license';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<KeywordModel> propertyArea(){
    String _subGroupID = 'sub_ppt_area_pptArea';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsBySubGroupID(_subGroupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<KeywordModel> LotArea(){
    String _subGroupID = 'sub_ppt_area_lotArea';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsBySubGroupID(_subGroupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<KeywordModel> propertyFeatures(){
    String _groupID = 'group_ppt_features';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<KeywordModel> propertyPrices(){
    String _groupID = 'group_ppt_price';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<KeywordModel> designTypes(){
    String _groupID = 'group_dz_type';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<KeywordModel> architecturalStyles(){
    String _groupID = 'group_dz_style';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<KeywordModel> spaceTypes(){
    String _groupID = 'group_space_type';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  //food and beverages
  static List<KeywordModel> kioskTypes(){
    String _groupID = 'group_dz_kioskType';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<KeywordModel> constructionTrades(){
    String _groupID = 'group_craft_trade';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<KeywordModel> productPrices(){
    String _groupID = 'group_prd_price';
    List<KeywordModel> _keywords = KeywordModel.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<KeywordModel> products(){
    List<KeywordModel> _keywords = new List();

    Sequence.productsSequence().forEach((group) {
      String _groupID = group.firstKeyID;
      _keywords.addAll(KeywordModel.getKeywordsByGroupID(_groupID));
    });

    return _keywords;
  }
// -----------------------------------------------------------------------------


}
