import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
class MutableSlide extends SlideModel{
  int slideIndex;
  dynamic picture;
  String headline;
  String description;
  int sharesCount;
  int viewsCount;
  int savesCount;
  BoxFit boxFit;
  ImageSize imageSize;
  Color midColor;

  MutableSlide({
    this.slideIndex,
    this.picture,
    this.headline,
    this.description,
    this.sharesCount,
    this.viewsCount,
    this.savesCount,
    this.boxFit, /// TASK : update all methods below to include this boxfit parameter
    @required this.imageSize,
    @required this.midColor,
  });
// -----------------------------------------------------------------------------
  static MutableSlide getMutableSlideFromSlideModel(SlideModel slide) {
    // --------------------------------------------------------o
    return
      MutableSlide(
        slideIndex : slide.slideIndex,
        picture : slide.picture,
        headline : slide.headline,
        description : slide.description,
        // -------------------------
        sharesCount : slide.sharesCount,
        viewsCount : slide.viewsCount,
        savesCount : slide.savesCount,
        imageSize: slide.imageSize,
        boxFit: slide.boxFit,
        midColor: slide.midColor,
      );
  }
// -----------------------------------------------------------------------------
  static List<MutableSlide> getMutableSlidesFromSlidesModels(List<SlideModel> slides) {
    List<MutableSlide> _slides = new List();

    if(slides != null){
      for (SlideModel slide in slides){

        MutableSlide _mutableSlide = getMutableSlideFromSlideModel(slide);

        _slides.add(_mutableSlide);
      }

    }


    return _slides;
  }
// -----------------------------------------------------------------------------
  static MutableSlide createMutableSlideFromFile({
    File file,
    int index,
    @required Color midColor,
    @required BoxFit boxFit,
  }) {

    // ImageSize _imageSize = await Imagers.superImageSize(file);

    return
      MutableSlide(
        slideIndex : index,
        picture : file,
        headline : null,
        description : null,
        // -------------------------
        sharesCount : null,
        viewsCount : null,
        savesCount : null,
        imageSize: null,
        boxFit: boxFit,
        midColor: midColor,
      );
  }
// -----------------------------------------------------------------------------
  /// mutable slides pics object types will look like [File, File, File, Asset, Asset, Asset]
  /// while assets list can't include null values or empty assets, so its list would be [Asset, Asset, Asset]
  /// so
  /// when deleting slide index 4, we need to figure that asset true index is 1
  /// by saying : trueIndex = ( 4 - 3 ) = ( slideIndex - numberOfFiles )
  /// A - search for first slide where its picture of object type asset
  /// B - when found
  ///   C - get number of slides with files
  ///   C - conclude true index
  /// B - when not found, return null
  static int getAssetTrueIndexFromMutableSlides({List<MutableSlide> mutableSlides,int slideIndex }){
    int _trueIndex;

    /// A - search for first slide where its picture of object type asset
    MutableSlide _firstSlideWithAssetPicture = mutableSlides.firstWhere((slide) => ObjectChecker.objectIsAsset(slide.picture) == true, orElse: ()=> null);

    /// B - when found
    if(_firstSlideWithAssetPicture != null){

      /// C - get number of slides with files
      int _firstAssetIndex = _firstSlideWithAssetPicture.slideIndex;
      int _numberOfFiles = _firstAssetIndex;

      /// C - conclude true index
      _trueIndex = slideIndex - _numberOfFiles;
    }

    /// B - when not found, return null
    return _trueIndex;
  }
// -----------------------------------------------------------------------------
}
