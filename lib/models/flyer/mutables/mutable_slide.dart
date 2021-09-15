import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/helpers/image_size.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
// -----------------------------------------------------------------------------
class MutableSlide {
  int slideIndex;
  String picURL;
  Asset picAsset;
  File picFile;
  BoxFit picFit;
  ImageSize picSize;
  String headline;
  TextEditingController headlineController;
  String description;
  TextEditingController descriptionController;
  int sharesCount;
  int viewsCount;
  int savesCount;
  ImageSize imageSize;
  Color midColor;
  double opacity;

  MutableSlide({
    this.slideIndex,
    this.picURL,
    @required this.picAsset,
    @required this.picFile,
    @required this.headline,
    @required this.headlineController,
    this.description,
    @required this.descriptionController,
    this.sharesCount,
    this.viewsCount,
    this.savesCount,
    this.picFit, /// TASK : update all methods below to include this boxfit parameter
    @required this.imageSize,
    @required this.midColor,
    @required this.opacity,
  });
// -----------------------------------------------------------------------------
  static MutableSlide getViewMutableSlideFromSlideModel(SlideModel slide) {
    // --------------------------------------------------------o
    return
      MutableSlide(
        slideIndex : slide.slideIndex,
        picURL : slide.pic,
        picAsset : null,
        picFile: null,
        headline : slide.headline,
        headlineController: null,//TextEditingController(text: slide.headline),
        description : slide.description,
        descriptionController: null,//TextEditingController(text: slide.description),
        // -------------------------
        sharesCount : slide.sharesCount,
        viewsCount : slide.viewsCount,
        savesCount : slide.savesCount,
        imageSize: slide.imageSize,
        picFit: slide.picFit,
        midColor: slide.midColor,
        opacity: 1,
      );
  }
// -----------------------------------------------------------------------------
  static Future<MutableSlide> getDraftMutableSlideFromSlideModel(SlideModel slide) async {
    File _file = await Imagers.urlToFile(slide.pic);
    return
      MutableSlide(
        slideIndex : slide.slideIndex,
        picURL : slide.pic,
        picAsset : null,
        picFile: _file,
        headline : slide.headline,
        headlineController: TextEditingController(text: slide.headline),
        description : slide.description,
        descriptionController: TextEditingController(text: slide.description),
        // -------------------------
        sharesCount : slide.sharesCount,
        viewsCount : slide.viewsCount,
        savesCount : slide.savesCount,
        imageSize: slide.imageSize,
        picFit: slide.picFit,
        midColor: slide.midColor,
        opacity: 1,
      );
  }
// -----------------------------------------------------------------------------
  static List<MutableSlide> getViewMutableSlidesFromSlidesModels(List<SlideModel> slides) {
    List<MutableSlide> _slides = [];

    if(slides != null){
      for (SlideModel slide in slides){

        MutableSlide _mutableSlide = getViewMutableSlideFromSlideModel(slide);

        _slides.add(_mutableSlide);
      }

    }


    return _slides;
  }
// -----------------------------------------------------------------------------
  static Future<List<MutableSlide>> getDraftMutableSlidesFromSlidesModels(List<SlideModel> slides) async {
    List<MutableSlide> _slides = [];

    if(slides != null){
      for (SlideModel slide in slides){

        MutableSlide _mutableSlide = await getDraftMutableSlideFromSlideModel(slide);

        _slides.add(_mutableSlide);
      }

    }


    return _slides;
  }
// -----------------------------------------------------------------------------
  /// delete this ,, maybe
//  static MutableSlide createMutableSlideFromFile({
//     File file,
//     int index,
//     @required Color midColor,
//     @required BoxFit boxFit,
//   }) {
//
//     // ImageSize _imageSize = await Imagers.superImageSize(file);
//
//     return
//       MutableSlide(
//         slideIndex : index,
//         picURL : null,
//         picAsset: null,
//         picFile: file,
//         headline : null,
//         headlineController: null,
//         description : null,
//         descriptionController: null,
//         // -------------------------
//         sharesCount : null,
//         viewsCount : null,
//         savesCount : null,
//         imageSize: null,
//         picFit: boxFit,
//         midColor: midColor,
//         isVisible: true,
//
//       );
//   }
// -----------------------------------------------------------------------------
  ///
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
    MutableSlide _firstSlideWithAssetPicture = mutableSlides.firstWhere((slide) => ObjectChecker.objectIsAsset(slide.picURL) == true, orElse: ()=> null);

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
  static void disposeMutableSlidesTextControllers(List<MutableSlide> mutableSlides){

    if(mutableSlides != null && mutableSlides.length != 0){
      for (MutableSlide mSlide in mutableSlides){
        TextChecker.disposeControllerIfPossible(mSlide.headlineController);
        TextChecker.disposeControllerIfPossible(mSlide.descriptionController);
      }
    }

  }
// -----------------------------------------------------------------------------
static List<Asset> getAssetsFromMutableSlides(List<MutableSlide> mSlides){
    List<Asset> _assets = [];

    for (MutableSlide mSlide in mSlides){
      if (mSlide.picAsset != null){
        _assets.add(mSlide.picAsset);
      }
    }

    return _assets;
}
// -----------------------------------------------------------------------------
  static int getMutableSlideIndexThatContainsThisAsset({List<MutableSlide> mSlides, Asset assetToSearchFor}){
    int _assetIndexInAssets = -1;

    if(mSlides != null && mSlides.isNotEmpty && assetToSearchFor != null){
      _assetIndexInAssets = mSlides.indexWhere(
            (mSlide) => mSlide?.picAsset?.identifier == assetToSearchFor.identifier,);
    }

    return _assetIndexInAssets;
  }
// -----------------------------------------------------------------------------
}
