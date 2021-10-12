import 'package:bldrs/models/keywords/sequence_model.dart';
import 'package:bldrs/models/keywords/keyword_model.dart';

abstract class FilterKeywords {
// -----------------------------------------------------------------------------
  static  List<Keyword> propertyForms(){
    const String _groupID = 'group_ppt_form';
    final List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> propertyTypes(){
    const String _groupID = 'group_ppt_type';
    final List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> propertyLicenses(){
    const String _groupID = 'group_ppt_license';
    final List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> propertyArea(){
    const String _subGroupID = 'sub_ppt_area_pptArea';
    final List<Keyword> _keywords = Keyword.getKeywordsBySubGroupID(_subGroupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> LotArea(){
    const String _subGroupID = 'sub_ppt_area_lotArea';
    final List<Keyword> _keywords = Keyword.getKeywordsBySubGroupID(_subGroupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> propertyFeatures(){
    const String _groupID = 'group_ppt_features';
    final List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> propertyPrices(){
    const String _groupID = 'group_ppt_price';
    final List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> designTypes(){
    const String _groupID = 'group_dz_type';
    final List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> architecturalStyles(){
    const String _groupID = 'group_dz_style';
    final List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> spaceTypes(){
    const String _groupID = 'group_space_type';
    final List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  /// food and beverages
  static List<Keyword> kioskTypes(){
    const String _groupID = 'group_dz_kioskType';
    final List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static  List<Keyword> constructionTrades(){
    const String _groupID = 'group_craft_trade';
    final List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> productPrices(){
    const String _groupID = 'group_prd_price';
    final List<Keyword> _keywords = Keyword.getKeywordsByGroupID(_groupID);
    return _keywords;
  }
// -----------------------------------------------------------------------------
  static List<Keyword> products(){
    final List<Keyword> _keywords = <Keyword>[];

    Sequence.productsSequence().forEach((group) {
      final String _groupID = group.titleID;
      _keywords.addAll(Keyword.getKeywordsByGroupID(_groupID));
    });

    return _keywords;
  }
// -----------------------------------------------------------------------------


}
