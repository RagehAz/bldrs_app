import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class SlideModel {
  final int slideIndex;
  final dynamic picture;
  final String headline;
  final String description;
  // -------------------------
  int sharesCount;
  int viewsCount;
  int savesCount;
// -----------------------------------------------------------------------------
  SlideModel({
    @required this.slideIndex,
    @required this.picture,
    @required this.headline,
    this.description,
    // -------------------------
    this.sharesCount,
    this.viewsCount,
    this.savesCount,
  });
  // -------------------------
  Map<String, dynamic> toMap() {
    return {
      'slideIndex': slideIndex,
      'picture': picture,
      'headline': headline,
      'description': description,
      'sharesCount': sharesCount,
      'viewsCount': viewsCount,
      'savesCount': savesCount,
    };
  }
// -------------------------
}
// -----------------------------------------------------------------------------
List<Map<String,Object>> cipherSlidesModels(List<SlideModel> slidesList) {
  List<Map<String,Object>> _slidesMaps = new List();
  slidesList.forEach((sl) {
    _slidesMaps.add(sl.toMap());
  });
  return _slidesMaps;
}
// -----------------------------------------------------------------------------
List<SlideModel> decipherSlidesMaps(List<dynamic> maps){
  List<SlideModel> _slidesList = new List();

  maps?.forEach((map) {
    _slidesList.add(decipherSlideMap(map));
  });

  return _slidesList;
}
// -----------------------------------------------------------------------------
SlideModel decipherSlideMap(dynamic map){
  return SlideModel(
  slideIndex : map['slideIndex'],
  picture : map['picture'],
  headline : map['headline'],
  description : map['description'],
  // -------------------------
  sharesCount : map['sharesCount'],
  viewsCount : map['viewsCount'],
  savesCount : map['savesCount'],
  );
}
// -----------------------------------------------------------------------------
String generateSlideID(String flyerID, int slideIndex){
  // slide index shall never have more than two digits
  String _slideIndexString = slideIndex <= 9 ? '0$slideIndex' : '$slideIndex';
  String _slideID = '${flyerID}_$_slideIndexString';
  return _slideID;
}
// -----------------------------------------------------------------------------
int getSlideIndexFromSlideID(String slideID){
  // slide index shall never have more than two digits
  int _slideIndex = lastTwoIntegersFromAString(slideID);
  return _slideIndex;
}
// -----------------------------------------------------------------------------
// String getFlyerIDFromSlideID(String slideID){
  // I guess no need for this, no use cases,, flyerID will always be there
  // beside slideID
// }