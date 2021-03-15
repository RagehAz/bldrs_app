import 'package:flutter/foundation.dart';
// ###############################
class SlideModel {
  final int slideIndex;
  final dynamic picture;
  final String headline;
  final String description;
  // -------------------------
  int sharesCount;
  int viewsCount;
  int savesCount;
  int callsCount;

// ###############################
  SlideModel({
    @required this.slideIndex,
    @required this.picture,
    @required this.headline,
    this.description,
    // -------------------------
    this.sharesCount,
    this.viewsCount,
    this.savesCount,
    this.callsCount,
  });
// ###############################
  Map<String, Object> toMap() {
    return {
      // 'flyerID'     : flyerID,
      // 'slideID'     : slideID,
      'slideIndex': slideIndex,
      'picture': picture,
      'headline': headline,
      'description': description,
      'sharesCount': sharesCount,
      'viewsCount': viewsCount,
      'savesCount': savesCount,
      'callsCount': callsCount,
    };
  }
// ###############################
}
List<Map<String, dynamic>> cipherSlidesModels(List<SlideModel> slidesList) {
  List<Map<String, dynamic>> _slidesMaps = new List();
  slidesList.forEach((sl) {
    _slidesMaps.add(sl.toMap());
  });
  return _slidesMaps;
}
// ###############################

// List<SlideModel> moldSlidesMapsListIntoSlidesModelsList(List<Map<String,Object>> slidesMaps){
//     return slidesMaps.entries.map().toList();
// }
