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
  Map<String, dynamic> toMap() {
    return {
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
List<Map<String,Object>> cipherSlidesModels(List<SlideModel> slidesList) {
  List<Map<String,Object>> _slidesMaps = new List();
  slidesList.forEach((sl) {
    _slidesMaps.add(sl.toMap());
  });
  return _slidesMaps;
}
// ###############################
List<SlideModel> decipherSlidesMaps(List<dynamic> maps){
  List<SlideModel> _slidesList = new List();

  maps?.forEach((map) {
    _slidesList.add(decipherSlideMap(map));
  });

  return _slidesList;
}
// ###############################
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
  callsCount : map['callsCount'],
  );
}
// ###############################

