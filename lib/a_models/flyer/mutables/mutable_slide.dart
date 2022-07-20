import 'dart:io';

import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart' as Colorizers;
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
@immutable
class MutableSlide {
  /// --------------------------------------------------------------------------
  const MutableSlide({
    @required this.picFile,
    @required this.headline,
    @required this.midColor,
    @required this.opacity,
    @required this.slideIndex,
    @required this.picURL,
    @required this.description,
    @required this.sharesCount,
    @required this.viewsCount,
    @required this.savesCount,
    @required this.picFit,
    @required this.imageSize,
    @required this.matrix,
    @required this.filter,
  });
  /// --------------------------------------------------------------------------
  final int slideIndex;
  final String picURL;
  final File picFile;
  final BoxFit picFit;
  final ImageSize imageSize;
  final TextEditingController headline;
  final TextEditingController description;
  final int sharesCount;
  final int viewsCount;
  final int savesCount;
  final Color midColor;
  final double opacity;
  final Matrix4 matrix;
  final ImageFilterModel filter;
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  MutableSlide copyWith({
      int slideIndex,
      String picURL,
      File picFile,
      BoxFit picFit,
      TextEditingController headline,
      TextEditingController description,
      int sharesCount,
      int viewsCount,
      int savesCount,
      ImageSize imageSize,
      Color midColor,
      double opacity,
      Matrix4 matrix,
      ImageFilterModel filter,
}){
    return MutableSlide(
      picFile: picFile ?? this.picFile,
      headline: headline ?? this.headline,
      imageSize: imageSize ?? this.imageSize,
      midColor: midColor ?? this.midColor,
      opacity: opacity ?? this.opacity,
      slideIndex: slideIndex ?? this.slideIndex,
      picURL: picURL ?? this.picURL,
      description: description ?? this.description,
      sharesCount: sharesCount ?? this.sharesCount,
      viewsCount: viewsCount ?? this.viewsCount,
      savesCount: savesCount ?? this.savesCount,
      picFit: picFit ?? this.picFit,
      matrix: matrix ?? this.matrix,
      filter: filter ?? this.filter,
    );
  }
// -----------------------------------------------------------------------------

  /// VIEW MUTABLE SLIDES CREATORS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static MutableSlide createViewMutableSlideFromSlide(SlideModel slide) {
    return MutableSlide(
      slideIndex: slide.slideIndex,
      picURL: slide.pic,
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
      matrix: slide.matrix,
      filter: ImageFilterModel.getFilterByID(slide.filterID),
    );
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static Future<MutableSlide> createMutableSlideFromSlide({
    @required SlideModel slide,
  }) async {

    final File _file = await Imagers.getFileFromURL(slide.pic);

    return MutableSlide(
      slideIndex: slide.slideIndex,
      picURL: slide.pic,
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
      filter: ImageFilterModel.getFilterByID(slide.filterID),
      matrix: slide.matrix,
    );

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static Future<List<MutableSlide>> createMutableSlidesByFiles({
    @required BuildContext context,
    @required List<File> files,
    @required List<MutableSlide> existingSlides,
    @required TextEditingController headlineController,
}) async {

    final List<MutableSlide> _output = <MutableSlide>[];

    if (Mapper.checkCanLoopList(files) == true){

      for (int i = 0; i < files.length; i++){

        final File _file = files[i];

        final int _slideIndexThatIncludesThisFile = MutableSlide.getMutableSlideIndexThatContainsThisFile(
          mSlides: existingSlides,
          fileToSearchFor: _file,
        );

        /// A - IF FOUND EXITING SLIDE CONTAINING THIS ASSET => ALREADY PICKED ASSET
        if (_slideIndexThatIncludesThisFile != -1){

          /// A1 - ADJUST SLIDE INDEX AND HEADLINE OF EXISTING SLIDE
          final MutableSlide _adjustedSlide = existingSlides[_slideIndexThatIncludesThisFile].copyWith(
            slideIndex: i,
            headline: i == 0 ? headlineController : null,
          );

          /// A2 - ADD THIS SLIDE
          _output.add(_adjustedSlide);
        }

        /// B - IF DID NOT FIND SLIDE WITH THIS ASSET => NEWLY PICKED ASSET
        else {

          /// B1 - CREATE NEW SLIDE
          final MutableSlide _newSlide = await createNewMutableSlideByFile(
            context: context,
            file: _file,
            index: i,
            headline: i == 0 ? headlineController : null,
          );

          /// B2 - ADD THIS NEW SLIDE
          _output.add(_newSlide);
        }

      }

    }

    return _output;
  }
// -------------------------------------
  /// RE-TEST REQUIRED
  static Future<MutableSlide> createNewMutableSlideByFile({
    @required BuildContext context,
    @required File file,
    @required int index,
    @required TextEditingController headline,
}) async {
    MutableSlide _slide;

    if (file != null){

      final File _file = file;
      final ImageSize _imageSize = await ImageSize.superImageSize(file);
      final BoxFit _fit = ImageSize.concludeBoxFit(
          picWidth: _imageSize.width,
          picHeight: _imageSize.width,
          viewWidth: FlyerBox.width(context, 1),
          viewHeight: FlyerBox.heightBySizeFactor(context: context, flyerSizeFactor: 1),
      );
      final Color _midColor = await Colorizers.getAverageColor(_file);

      _slide = MutableSlide(
        picFile: _file,
        headline: headline ?? TextEditingController(),
        imageSize: _imageSize,
        midColor: _midColor,
        opacity: 1,
        slideIndex: index,
        picURL: null,
        description: TextEditingController(),
        sharesCount: 0,
        viewsCount: 0,
        savesCount: 0,
        picFit: _fit,
        matrix: Matrix4.identity(),
        filter: ImageFilterModel.noFilter(),
      );

    }

    return _slide;
}
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
  /// RE-TEST REQUIRED
  static List<File> getFilesFromMutableSlides({
    @required List<MutableSlide> mutableSlides,
  }) {

    final List<File> _files = <File>[];

    for (final MutableSlide mSlide in mutableSlides) {
      if (mSlide.picFile != null) {
        _files.add(mSlide.picFile);
      }
    }

    return _files;
  }
// -----------------------------------------------------------------------------

  /// INDEXES

// -------------------------------------
  static int getFileTrueIndexFromMutableSlides({
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
            ObjectChecker.objectIsFile(slide.picURL) == true,
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
  /// RETEST REQUIRED
  static int getMutableSlideIndexThatContainsThisFile({
    @required List<MutableSlide> mSlides,
    @required File fileToSearchFor,
  }) {

    int _assetIndexInAssets = -1;

    if (mSlides != null && mSlides.isNotEmpty && fileToSearchFor != null) {
      _assetIndexInAssets = mSlides.indexWhere(
            (MutableSlide mSlide) =>
        mSlide?.picFile?.path == fileToSearchFor.path,
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

    if (Mapper.checkCanLoopList(mutableSlides)) {
      for (final MutableSlide mSlide in mutableSlides) {
        TextChecker.disposeControllerIfPossible(mSlide.headline);
        TextChecker.disposeControllerIfPossible(mSlide.description);
      }
    }

  }
// -----------------------------------------------------------------------------

/// BLOGGING

// -------------------------------------
  /// TESTED : WORKS PERFECT
  void blogSlide(){

    blog('BLOGGING SLIDE ------------> START');
    blog('picFile : $picFile');
    blog('headline : ${headline.text}');
    imageSize.blogSize();
    blog('midColor : $midColor');
    blog('opacity : $opacity');
    blog('slideIndex : $slideIndex');
    blog('picURL : $picURL');
    blog('description : ${description.text}');
    blog('sharesCount : $sharesCount');
    blog('viewsCount : $viewsCount');
    blog('savesCount : $savesCount');
    blog('picFit : $picFit');
    blog('matrix : $matrix');
    blog('filter : ${filter?.id}');
    blog('BLOGGING SLIDE ------------> END');

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogSlides(List<MutableSlide> slides){

    blog('BLOGGING SLIDES -------- START');

    for (final MutableSlide slide in slides){
      slide.blogSlide();
    }

    blog('BLOGGING SLIDES -------- END');
  }
// -----------------------------------------------------------------------------

  /// MODIFIERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<MutableSlide> replaceSlide({
    @required List<MutableSlide> slides,
    @required MutableSlide slide,
}){

    slides.removeAt(slide.slideIndex);
    slides.insert(slide.slideIndex, slide);
    // slides[1].blogSlide();
    return slides;
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
