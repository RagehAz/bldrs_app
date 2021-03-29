import 'package:bldrs/controllers/drafters/file_formatters.dart';
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
  // ass flyer should never be more than 10 slides long
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
Future<List<SlideModel>> replaceSlidesPicturesWithNewURLs(List<String> newPicturesURLs, List<SlideModel> inputSlides) async {
  List<SlideModel> _outputSlides = new List();

  for (var slide in inputSlides){

    int i = slide.slideIndex;

    SlideModel _newSlide = SlideModel(
      slideIndex: inputSlides[i].slideIndex,
      picture: newPicturesURLs[i],
      headline: inputSlides[i].headline,
      description: inputSlides[i].description,
      savesCount: inputSlides[i].savesCount,
      sharesCount: inputSlides[i].sharesCount,
      viewsCount: inputSlides[i].viewsCount,
    );

    _outputSlides.add(_newSlide);

  }

  print('slides are $_outputSlides');

  return _outputSlides;
}
// -----------------------------------------------------------------------------
Future<dynamic> cipherSlidesCounters(List<SlideModel> slides) async {

  Map<String, dynamic> _combinedMap = {};

  await Future.forEach(slides, (slide){

    _combinedMap.addAll({
      'saves/${slide.slideIndex}' : slide.savesCount,
      'shares/${slide.slideIndex}' : slide.sharesCount,
      'views/${slide.slideIndex}' : slide.viewsCount,
    });

  });

  return _combinedMap;
}
// -----------------------------------------------------------------------------
