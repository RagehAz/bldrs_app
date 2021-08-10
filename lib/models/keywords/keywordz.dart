import 'package:bldrs/models/keywords/sequence_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';

class FilterKeywords {
// -----------------------------------------------------------------------------
  static  List<Keyword> propertyForms(){
    String _groupID = 'group_ppt_form';
    List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> propertyTypes(){
    String _groupID = 'group_ppt_type';
    List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> propertyLicenses(){
    String _groupID = 'group_ppt_license';
    List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> propertyArea(){
    String _subGroupID = 'sub_ppt_area_pptArea';
    List<Keyword> _keywords = Keyword.getKeywordsBySubGroupID(_subGroupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> LotArea(){
    String _subGroupID = 'sub_ppt_area_lotArea';
    List<Keyword> _keywords = Keyword.getKeywordsBySubGroupID(_subGroupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> propertyFeatures(){
    String _groupID = 'group_ppt_features';
    List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> propertyPrices(){
    String _groupID = 'group_ppt_price';
    List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> designTypes(){
    String _groupID = 'group_dz_type';
    List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> architecturalStyles(){
    String _groupID = 'group_dz_style';
    List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> spaceTypes(){
    String _groupID = 'group_space_type';
    List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  //food and beverages
  static List<Keyword> kioskTypes(){
    String _groupID = 'group_dz_kioskType';
    List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> constructionTrades(){
    String _groupID = 'group_craft_trade';
    List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> productPrices(){
    String _groupID = 'group_prd_price';
    List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> products(){
    List<Keyword> _keywords = new List();

    Sequence.productsSequence().forEach((group) {
      String _groupID = group.titleID;
      _keywords.addAll(Keyword.getKeywordsByGroupID(_groupID));
    });

    return _keywords;
  }
// -----------------------------------------------------------------------------


}
