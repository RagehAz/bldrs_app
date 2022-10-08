import 'dart:io';

import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/x_utilities/image_size.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/images/super_filter/color_filter_generator.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/trinity.dart';
import 'package:flutter/material.dart';

@immutable
class MutableSlide {
  /// --------------------------------------------------------------------------
  const MutableSlide({
    @required this.picFileModel,
    @required this.headline,
    @required this.midColor,
    @required this.opacity,
    @required this.slideIndex,
    @required this.picURL,
    @required this.description,
    @required this.picFit,
    @required this.imageSize,
    @required this.matrix,
    @required this.filter,
  });
  /// --------------------------------------------------------------------------
  final int slideIndex;
  final String picURL;
  final FileModel picFileModel;
  final BoxFit picFit;
  final ImageSize imageSize;
  final String headline;
  final String description;
  final Color midColor;
  final double opacity;
  final Matrix4 matrix;
  final ImageFilterModel filter;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  MutableSlide copyWith({
    int slideIndex,
    String picURL,
    FileModel picFileModel,
    BoxFit picFit,
    String headline,
    String description,
    ImageSize imageSize,
    Color midColor,
    double opacity,
    Matrix4 matrix,
    ImageFilterModel filter,
  }){
    return MutableSlide(
      picFileModel: picFileModel ?? this.picFileModel,
      headline: headline ?? this.headline,
      imageSize: imageSize ?? this.imageSize,
      midColor: midColor ?? this.midColor,
      opacity: opacity ?? this.opacity,
      slideIndex: slideIndex ?? this.slideIndex,
      picURL: picURL ?? this.picURL,
      description: description ?? this.description,
      picFit: picFit ?? this.picFit,
      matrix: matrix ?? this.matrix,
      filter: filter ?? this.filter,
    );
  }
  // -----------------------------------------------------------------------------

  /// VIEW MUTABLE SLIDES CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static MutableSlide createViewMutableSlideFromSlide(SlideModel slide) {
    return MutableSlide(
      slideIndex: slide.slideIndex,
      picURL: slide.pic,
      picFileModel: null,
      headline: slide.headline,
      description: slide.description,
      imageSize: slide.imageSize,
      picFit: slide.picFit,
      midColor: slide.midColor,
      opacity: 1,
      matrix: slide.matrix,
      filter: ImageFilterModel.getFilterByID(slide.filterID),
    );
  }
  // --------------------
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

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MutableSlide> createMutableSlideFromSlide({
    @required SlideModel slide,
    @required String flyerID,
  }) async {

    final FileModel _file = await FileModel.preparePicForEditing(
      pic: slide.pic,
      fileName: SlideModel.generateSlideID(
        flyerID: flyerID,
        slideIndex: slide.slideIndex,
      ),
    );

    return MutableSlide(
      slideIndex: slide.slideIndex,
      picURL: slide.pic,
      picFileModel: _file,
      headline: slide.headline,
      description: slide.description,
      // -------------------------
      imageSize: slide.imageSize,
      picFit: slide.picFit,
      midColor: slide.midColor,
      opacity: 1,
      filter: ImageFilterModel.getFilterByID(slide.filterID),
      matrix: slide.matrix,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MutableSlide>> createMutableSlidesFromSlides({
    @required List<SlideModel> slides,
    @required String flyerID,
  }) async {

    final List<MutableSlide> _slides = <MutableSlide>[];

    if (slides != null) {
      for (final SlideModel slide in slides) {

        final MutableSlide _mutableSlide = await createMutableSlideFromSlide(
          slide: slide,
          flyerID: flyerID,
        );

        _slides.add(_mutableSlide);
      }
    }

    return _slides;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MutableSlide>> createMutableSlidesByFiles({
    @required BuildContext context,
    @required List<File> files,
    @required List<MutableSlide> existingSlides,
    @required String headline,
  }) async {

    final List<MutableSlide> _output = <MutableSlide>[];

    if (Mapper.checkCanLoopList(files) == true){

      for (int i = 0; i < files.length; i++){

        final File _file = files[i];

        // final int _slideIndexThatIncludesThisFile = MutableSlide.getMutableSlideIndexThatContainsThisFile(
        //   mSlides: existingSlides,
        //   fileToSearchFor: _file,
        // );

        // /// A - IF FOUND EXITING SLIDE CONTAINING THIS ASSET => ALREADY PICKED ASSET
        // if (_slideIndexThatIncludesThisFile != -1){
        //
        //   /// A1 - ADJUST SLIDE INDEX AND HEADLINE OF EXISTING SLIDE
        //   final MutableSlide _adjustedSlide = existingSlides[_slideIndexThatIncludesThisFile].copyWith(
        //     slideIndex: i,
        //     headline: i == 0 ? headlineController : null,
        //   );
        //
        //   /// A2 - ADD THIS SLIDE
        //   _output.add(_adjustedSlide);
        // }
        //
        // /// B - IF DID NOT FIND SLIDE WITH THIS ASSET => NEWLY PICKED ASSET
        // else {

        final int _newSlideIndex = i + existingSlides.length;

        /// B1 - CREATE NEW SLIDE
        final MutableSlide _newSlide = await createNewMutableSlideByFile(
          context: context,
          file: _file,
          index: _newSlideIndex,
          headline: _newSlideIndex  == 0 ? headline : null,
        );

        /// B2 - ADD THIS NEW SLIDE
        _output.add(_newSlide);
        // }

      }

    }

    return _output;
  }
  // --------------------
  /// RE-TEST REQUIRED
  static Future<MutableSlide> createNewMutableSlideByFile({
    @required BuildContext context,
    @required File file,
    @required int index,
    @required String headline,
  }) async {
    MutableSlide _slide;

    if (file != null){

      final ImageSize _imageSize = await ImageSize.superImageSize(file);
      final BoxFit _fit = ImageSize.concludeBoxFit(
        picWidth: _imageSize.width,
        picHeight: _imageSize.width,
        viewWidth: FlyerDim.flyerWidthByFactor(context, 1),
        viewHeight: FlyerDim.heightBySizeFactor(context: context, flyerSizeFactor: 1),
      );
      final Color _midColor = await Colorizer.getAverageColor(file);

      _slide = MutableSlide(
        picFileModel: FileModel.createModelByNewFile(file),
        headline: headline,
        imageSize: _imageSize,
        midColor: _midColor,
        opacity: 1,
        slideIndex: index,
        picURL: null,
        description: '',
        picFit: _fit,
        matrix: Matrix4.identity(),
        filter: ImageFilterModel.noFilter(),
      );

    }

    return _slide;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// RE-TEST REQUIRED
  static List<File> getFilesFromMutableSlides({
    @required List<MutableSlide> mutableSlides,
  }) {

    final List<File> _files = <File>[];

    for (final MutableSlide mSlide in mutableSlides) {
      if (mSlide.picFileModel != null) {
        _files.add(mSlide.picFileModel.file);
      }
    }

    return _files;
  }
  // -----------------------------------------------------------------------------

  /// INDEXES

  // --------------------
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
        ObjectCheck.objectIsFile(slide.picURL) == true,
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
  // --------------------
  /// RETEST REQUIRED
  static int getMutableSlideIndexThatContainsThisFile({
    @required List<MutableSlide> mSlides,
    @required File fileToSearchFor,
  }) {

    int _assetIndexInAssets = -1;

    if (mSlides != null && mSlides.isNotEmpty && fileToSearchFor != null) {
      _assetIndexInAssets = mSlides.indexWhere(
            (MutableSlide mSlide) =>
        Filers.checkFilesAreIdentical(file1: mSlide?.picFileModel?.file, file2: fileToSearchFor) == true,
      );
    }

    return _assetIndexInAssets;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogSlide(){

    blog('slideIndex : $slideIndex --------------------------------------- [m]');
    blog('headline : $headline');
    blog('description : $description');
    imageSize.blogSize();
    blog('midColor : $midColor : opacity : $opacity : picFit : $picFit : filter : ${filter?.id} : hasCustomMatrix : ${matrix != Matrix4.identity()}');
    blog('picFile : $picFileModel');
    blog('picURL : $picURL');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogSlides(List<MutableSlide> slides){

    blog('BLOGGING SLIDES -------- START');

    for (final MutableSlide slide in slides){
      slide.blogSlide();
    }

    blog('BLOGGING SLIDES -------- END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogMutableSlidesDifferences({
    @required MutableSlide slide1,
    @required MutableSlide slide2,
  }){

    if (slide1 == null){
      blog('MutableSlidesDifferences : slide1 is null');
    }
    if (slide2 == null){
      blog('MutableSlidesDifferences : slide2 is null');
    }

    if (slide1.slideIndex != slide2.slideIndex){
      blog('MutableSlidesDifferences : slideIndexes are not Identical');
    }
    if (slide1.picURL != slide2.picURL){
      blog('MutableSlidesDifferences : picURLs are not Identical');
    }
    if (FileModel.checkFileModelsAreIdentical(model1: slide1.picFileModel, model2: slide2.picFileModel) == false){
      blog('MutableSlidesDifferences : picFileModels are not Identical');
    }
    if (slide1.picFit != slide2.picFit){
      blog('MutableSlidesDifferences : picFits are not Identical');
    }
    if (ImageSize.checkSizesAreIdentical(sizeA: slide1.imageSize, sizeB: slide2.imageSize) == false){
      blog('MutableSlidesDifferences : imageSizes are not Identical');
    }
    if (slide1.headline != slide2.headline){
      blog('MutableSlidesDifferences : headlines are not Identical');
    }
    if (slide1.description != slide2.description){
      blog('MutableSlidesDifferences : descriptions are not Identical');
    }
    if (Colorizer.checkColorsAreIdentical(slide1.midColor, slide2.midColor) == false){
      blog('MutableSlidesDifferences : midColors are not Identical');
    }
    if (slide1.opacity != slide2.opacity){
      blog('MutableSlidesDifferences : opacities are not Identical');
    }
    if (Trinity.checkMatrixesAreIdentical(matrix1: slide1.matrix, matrixReloaded: slide2.matrix) == false){
      blog('MutableSlidesDifferences : matrixes are not Identical');
    }
    if (ImageFilterModel.checkFiltersAreIdentical(filter1: slide1.filter, filter2: slide2.filter) == false){
      blog('MutableSlidesDifferences : filters are not Identical');
    }

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
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

  /// CHECKERS

  // --------------------
  static bool checkSlidesAreIdentical({
    @required MutableSlide slide1,
    @required MutableSlide slide2,
  }){
    bool _identical = false;
    if (slide1 != null && slide2 != null){

      if (
      slide1.slideIndex == slide2.slideIndex &&
          slide1.picURL == slide2.picURL &&
          FileModel.checkFileModelsAreIdentical(model1: slide1.picFileModel, model2: slide2.picFileModel) &&
          slide1.picFit == slide2.picFit &&
          ImageSize.checkSizesAreIdentical(sizeA: slide1.imageSize, sizeB: slide2.imageSize) &&
          slide1.headline == slide2.headline &&
          slide1.description == slide2.description &&
          Colorizer.checkColorsAreIdentical(slide1.midColor, slide2.midColor) &&
          slide1.opacity == slide2.opacity &&
          Trinity.checkMatrixesAreIdentical(matrix1: slide1.matrix, matrixReloaded: slide2.matrix) &&
          ImageFilterModel.checkFiltersAreIdentical(filter1: slide1.filter, filter2: slide2.filter)
      ){
        _identical = true;
      }

      if (_identical == false){
        blogMutableSlidesDifferences(
          slide1: slide1,
          slide2: slide2,
        );
      }

    }
    return _identical;
  }
  // --------------------
  static bool checkSlidesListsAreIdentical({
    @required List<MutableSlide> slides1,
    @required List<MutableSlide> slides2,
  }){
    bool _listsAreIdentical = false;

    if (slides1 == null && slides2 == null){
      _listsAreIdentical = true;
    }
    else if (slides1.isEmpty == true && slides2.isEmpty == true){
      _listsAreIdentical = true;
    }
    else if (Mapper.checkCanLoopList(slides1) == true && Mapper.checkCanLoopList(slides2) == true){

      if (slides1.length != slides2.length){
        _listsAreIdentical = false;
      }
      else {

        for (int i = 0; i < slides1.length; i++){

          final MutableSlide _slide1 = slides1[i];
          final MutableSlide _slide2 = slides2[i];

          final bool _areIdentical = checkSlidesAreIdentical(
            slide1: _slide1,
            slide2: _slide2,
          );

          if (_areIdentical == false){
            _listsAreIdentical = false;
            break;
          }

          _listsAreIdentical = true;

        }

      }

    }

    return _listsAreIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is MutableSlide){
      _areIdentical = checkSlidesAreIdentical(
        slide1: this,
        slide2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      picFileModel.hashCode ^
      headline.hashCode ^
      midColor.hashCode ^
      opacity.hashCode ^
      slideIndex.hashCode ^
      picURL.hashCode ^
      description.hashCode ^
      picFit.hashCode ^
      imageSize.hashCode ^
      matrix.hashCode ^
      filter.hashCode;
  // -----------------------------------------------------------------------------
}

// -------------
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
// -------------
/*
  static void disposeMutableSlidesTextControllers({
    @required List<MutableSlide> mutableSlides,
  }) {

    if (Mapper.checkCanLoopList(mutableSlides)) {
      for (final MutableSlide mSlide in mutableSlides) {
        // TextChecker.disposeControllerIfPossible(mSlide?.headline);
        TextCheck.disposeControllerIfPossible(mSlide?.description);
      }
    }

  }

   */
// -------------