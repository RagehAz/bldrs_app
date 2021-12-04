import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/controllers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/controllers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/secondary_models/image_size.dart';
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
    @required this.picAsset,
    @required this.picFile,
    @required this.headline,
    @required this.headlineController,
    @required this.descriptionController,
    @required this.imageSize,
    @required this.midColor,
    @required this.opacity,
    this.slideIndex,
    this.picURL,
    this.description,
    this.sharesCount,
    this.viewsCount,
    this.savesCount,
    this.picFit, /// TASK : update all methods below to include this boxfit parameter
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
    final File _file = await Imagers.getFileFromURL(slide.pic);
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
    final List<MutableSlide> _slides = <MutableSlide>[];

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
    final List<MutableSlide> _slides = <MutableSlide>[];

    if(slides != null){
      for (SlideModel slide in slides){

        final MutableSlide _mutableSlide = await getDraftMutableSlideFromSlideModel(slide);

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
    final MutableSlide _firstSlideWithAssetPicture = mutableSlides.firstWhere((MutableSlide slide) => ObjectChecker.objectIsAsset(slide.picURL) == true, orElse: ()=> null);

    /// B - when found
    if(_firstSlideWithAssetPicture != null){

      /// C - get number of slides with files
      final int _firstAssetIndex = _firstSlideWithAssetPicture.slideIndex;
      final int _numberOfFiles = _firstAssetIndex;

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
    final List<Asset> _assets = <Asset>[];

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
            (MutableSlide mSlide) => mSlide?.picAsset?.identifier == assetToSearchFor.identifier,);
    }

    return _assetIndexInAssets;
  }
// -----------------------------------------------------------------------------
}
