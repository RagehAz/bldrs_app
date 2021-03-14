import 'package:flutter/foundation.dart';
// ###############################
class SlideModel{
  /// shall delete this later as the SlideModel is a sub-part of
  /// the flyer that has a List<SlideModel> in its constructor
  /// will leave this for now to avoid exploding the app
  // final String flyerID;
  // final String slideID;
  // -------------------------
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
    // @required this.flyerID,
    // @required this.slideID,
    // -------------------------
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
  Map<String ,Object> toMap(){
    return {
    // 'flyerID'     : flyerID,
    // 'slideID'     : slideID,
    'slideIndex'  : slideIndex,
    'picture'     : picture,
    'headline'    : headline,
    'description' : description,
    'sharesCount' : sharesCount,
    'viewsCount'  : viewsCount,
    'savesCount'  : savesCount,
    'callsCount'  : callsCount,
  };
}
// ###############################
}

// List<SlideModel> moldSlidesMapsListIntoSlidesModelsList(List<Map<String,Object>> slidesMaps){
//     return slidesMaps.entries.map().toList();
// }
