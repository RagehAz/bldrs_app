import 'dart:io';

import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart' as Colorizers;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

// -----------------------------------------------------------------------------
class MutableSlide {
  /// --------------------------------------------------------------------------
  MutableSlide({
    @required this.picAsset,
    @required this.picFile,
    @required this.headline,
    @required this.imageSize,
    @required this.midColor,
    @required this.opacity,
    @required this.slideIndex,
    @required this.picURL,
    @required this.description,
    @required this.sharesCount,
    @required this.viewsCount,
    @required this.savesCount,
    @required this.picFit,
  });
  /// --------------------------------------------------------------------------
  int slideIndex;
  String picURL;
  Asset picAsset;
  File picFile;
  BoxFit picFit;
  ImageSize picSize;
  TextEditingController headline;
  TextEditingController description;
  int sharesCount;
  int viewsCount;
  int savesCount;
  ImageSize imageSize;
  Color midColor;
  double opacity;
// -----------------------------------------------------------------------------

  /// VIEW MUTABLE SLIDES CREATORS

// -------------------------------------
  static MutableSlide createViewMutableSlideFromSlide(SlideModel slide) {
    return MutableSlide(
      slideIndex: slide.slideIndex,
      picURL: slide.pic,
      picAsset: null,
      picFile: null,
      headline: TextEditingController(text: slide.headline),
      description: TextEditingController(text: slide.description),
      sharesCount: slide.sharesCount,
      viewsCount: slide.viewsCount,
      savesCount: slide.savesCount,
      imageSize: slide.imageSize,
      picFit: slide.picFit,
      midColor: slide.midColor,
      opacity: 1,
    );
  }
// -------------------------------------
  static List<MutableSlide> getViewMutableSlidesFromSlides({
    @required List<SlideModel> slides,
  }) {

    final List<MutableSlide> _slides = <MutableSlide>[];

    if (slides != null) {
      for (final SlideModel slide in slides) {

        final MutableSlide _mutableSlide = createViewMutableSlideFromSlide(slide);

        _slides.add(_mutableSlide);
      }
    }

    return _slides;
  }
// -----------------------------------------------------------------------------

  /// MUTABLE SLIDES CREATORS

// -------------------------------------
  static Future<MutableSlide> createMutableSlideFromSlide({
    @required SlideModel slide,
  }) async {

    final File _file = await Imagers.getFileFromURL(slide.pic);

    return MutableSlide(
      slideIndex: slide.slideIndex,
      picURL: slide.pic,
      picAsset: null,
      picFile: _file,
      headline: TextEditingController(text: slide.headline),
      description: TextEditingController(text: slide.description),
      // -------------------------
      sharesCount: slide.sharesCount,
      viewsCount: slide.viewsCount,
      savesCount: slide.savesCount,
      imageSize: slide.imageSize,
      picFit: slide.picFit,
      midColor: slide.midColor,
      opacity: 1,
    );

  }
// -------------------------------------
  static Future<List<MutableSlide>> createMutableSlidesFromSlides({
    @required List<SlideModel> slides,
  }) async {

    final List<MutableSlide> _slides = <MutableSlide>[];

    if (slides != null) {
      for (final SlideModel slide in slides) {

        final MutableSlide _mutableSlide = await createMutableSlideFromSlide(
          slide: slide,
        );

        _slides.add(_mutableSlide);
      }
    }

    return _slides;
  }
// -------------------------------------
  static Future<List<MutableSlide>> createNewMutableSlidesByAssets({
    @required List<Asset> assets,
    @required List<Asset> existingAssets,
}) async {

    final List<MutableSlide> _slides = <MutableSlide>[];

    if (Mapper.canLoopList(assets) == true){

      for (int i = 0; i < assets.length; i++){

        final MutableSlide _mutableSlide = await createNewMutableSlideByAsset(
          asset: assets[i],
          index: existingAssets.length + i,
        );

        _slides.add(_mutableSlide);
      }

    }

    return _slides;
  }
// -------------------------------------
  static Future<MutableSlide> createNewMutableSlideByAsset({
    @required Asset asset,
    @required int index,
}) async {
    MutableSlide _slide;

    if (asset != null){

      final File _file = await Imagers.getFileFromPickerAsset(asset);
      final BoxFit _fit = Imagers.concludeBoxFitForAsset(
          asset: asset,
          flyerBoxWidth: 100, /// TASK : no need for this, dig deeper to understand, Ratio is calculated inside
      );
      final ImageSize _imageSize = ImageSize.getImageSizeFromAsset(asset);
      final Color _midColor = await Colorizers.getAverageColor(_file);

      _slide = MutableSlide(
          picAsset: asset,
          picFile: _file,
          headline: TextEditingController(),
          imageSize: _imageSize,
          midColor: _midColor,
          opacity: 1,
          slideIndex: index,
          picURL: null,
          description: TextEditingController(),
          sharesCount: 0,
          viewsCount: 0,
          savesCount: 0,
          picFit: _fit
      );

    }

    return _slide;
}
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
  static List<Asset> getAssetsFromMutableSlides({
    @required List<MutableSlide> mutableSlides,
  }) {

    final List<Asset> _assets = <Asset>[];

    for (final MutableSlide mSlide in mutableSlides) {
      if (mSlide.picAsset != null) {
        _assets.add(mSlide.picAsset);
      }
    }

    return _assets;
  }
// -----------------------------------------------------------------------------

  /// INDEXES

// -------------------------------------
  static int getAssetTrueIndexFromMutableSlides({
    @required List<MutableSlide> mutableSlides,
    @required int slideIndex,
  }) {

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

    int _trueIndex;

    /// A - search for first slide where its picture of object type asset
    final MutableSlide _firstSlideWithAssetPicture = mutableSlides.firstWhere(
        (MutableSlide slide) =>
            ObjectChecker.objectIsAsset(slide.picURL) == true,
        orElse: () => null);

    /// B - when found
    if (_firstSlideWithAssetPicture != null) {
      /// C - get number of slides with files
      final int _firstAssetIndex = _firstSlideWithAssetPicture.slideIndex;
      final int _numberOfFiles = _firstAssetIndex;

      /// C - conclude true index
      _trueIndex = slideIndex - _numberOfFiles;
    }

    /// B - when not found, return null
    return _trueIndex;
  }
// -------------------------------------
  static int getMutableSlideIndexThatContainsThisAsset({
    @required List<MutableSlide> mSlides,
    @required Asset assetToSearchFor,
  }) {

    int _assetIndexInAssets = -1;

    if (mSlides != null && mSlides.isNotEmpty && assetToSearchFor != null) {
      _assetIndexInAssets = mSlides.indexWhere(
            (MutableSlide mSlide) =>
        mSlide?.picAsset?.identifier == assetToSearchFor.identifier,
      );
    }

    return _assetIndexInAssets;
  }
// -----------------------------------------------------------------------------

  /// DISPOSING

// -------------------------------------
  static void disposeMutableSlidesTextControllers({
    @required List<MutableSlide> mutableSlides,
  }) {

    if (Mapper.canLoopList(mutableSlides)) {
      for (final MutableSlide mSlide in mutableSlides) {
        TextChecker.disposeControllerIfPossible(mSlide.headline);
        TextChecker.disposeControllerIfPossible(mSlide.description);
      }
    }

  }
// -----------------------------------------------------------------------------
}

/*
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


 */
