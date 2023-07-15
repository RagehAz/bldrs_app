import 'dart:ui' as ui;
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/files/floaters.dart';
import 'package:basics/helpers/classes/space/trinity.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/helpers/classes/colors/colorizer.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
/// => TAMAM
@immutable
class SlideModel {
  /// --------------------------------------------------------------------------
  const SlideModel({
    required this.description,
    required this.picFit,
    required this.dimensions,
    required this.midColor,
    required this.matrix,
    required this.animationCurve,
    required this.slideIndex,
    this.picPath,
    this.headline,
    this.flyerID,
    this.uiImage,
  });
  /// --------------------------------------------------------------------------
  final int slideIndex;
  final String? picPath;
  final String? headline;
  final String? description;
  final Matrix4? matrix;
  final BoxFit? picFit;
  final Dimensions? dimensions;
  final Color? midColor;
  final String? flyerID;
  final ui.Image? uiImage;
  final Curve? animationCurve;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slideIndex': slideIndex,
      'picPath': picPath is String == true ? picPath : null,
      'headline': headline,
      'description': description,
      'picFit': Dimensions.cipherBoxFit(picFit),
      'dimensions': dimensions?.toMap(),
      'midColor': Colorizer.cipherColor(midColor),
      'matrix' : Trinity.cipherMatrix(matrix),
      'animationCurve': Trinity.cipherAnimationCurve(animationCurve),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static SlideModel decipherSlide(dynamic map) {

    return SlideModel(
      slideIndex: map['slideIndex'],
      picPath: map['picPath'],
      headline: map['headline'],
      description: map['description'],
      picFit: Dimensions.decipherBoxFit(map['picFit']),
      dimensions: Dimensions.decipherDimensions(map['dimensions']),
      midColor: Colorizer.decipherColor(map['midColor']),
      matrix: Trinity.decipherMatrix(map['matrix']),
      animationCurve: Trinity.decipherAnimationCurve(map['animationCurve']),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherSlides(List<SlideModel>? slides) {
    Map<String, dynamic> _slidesMap = <String, dynamic>{};

    if (Mapper.checkCanLoopList(slides) == true) {
      for (final SlideModel slide in slides!) {
        _slidesMap = Mapper.insertPairInMap(
          map: _slidesMap,
          key: '${slide.slideIndex}',
          value: slide.toMap(),
          overrideExisting: true,
        );
      }
    }

    return _slidesMap;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<SlideModel> decipherSlides(Map<String, dynamic> maps) {
    final List<SlideModel> _slides = <SlideModel>[];
    final List<String>? _keys = maps.keys.toList();

    if (Mapper.checkCanLoopList(_keys) == true) {

      final List<String> _sorted = Stringer.sortAlphabetically(_keys);

      for (final String key in _sorted) {
        final Map<String, dynamic> _slideMap = maps[key];
        final SlideModel _slide = decipherSlide(_slideMap);
        _slides.add(_slide);
      }
    }

    return _slides;
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  SlideModel copyWith({
    int? slideIndex,
    String? picPath,
    String? headline,
    String? description,
    Matrix4? matrix,
    BoxFit? picFit,
    Dimensions? dimensions,
    Color? midColor,
    String? flyerID,
    ui.Image? uiImage,
    Curve? animationCurve,
  }) {
    return SlideModel(
      slideIndex: slideIndex ?? this.slideIndex,
      picPath: picPath ?? this.picPath,
      headline: headline ?? this.headline,
      description: description ?? this.description,
      dimensions: dimensions ?? this.dimensions,
      picFit: picFit ?? this.picFit,
      midColor: midColor ?? this.midColor,
      matrix: matrix ?? this.matrix,
      uiImage: uiImage ?? this.uiImage,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogSlide() {
    blog(' >> SLIDE [ $slideIndex ] --------------------------------------- []');
    blog('  slideIndex : ($slideIndex ): flyerID : ($flyerID)  : pic : ($picPath) : uiImage : ($uiImage) ');
    blog('  headline : ($headline) : description : ($description)');
    blog('  midColor : ($midColor) : '
        'picFit : ($picFit) : '
        'hasCustomMatrix : (${matrix != Matrix4.identity()}) : '
        'animationCurve : ($animationCurve) : '
        'width : (${dimensions?.width}) : '
        'height : (${dimensions?.height}) : '
    );
    blog('  has ui.Image : (${uiImage != null})');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogSlides(List<SlideModel>? slides) {

    blog('blogSlides : ${slides?.length} SLIDES -----------------------------------------START');
    if (Mapper.checkCanLoopList(slides) == false) {
      blog('blogSlides : slides can not be printed : slides are : $slides');
    }

    else {

      for (final SlideModel slide in slides!) {
        slide.blogSlide();
      }

    }

    blog('blogSlides -------------------------------------------------- END');
  }
    // --------------------
  /// TESTED : WORKS PERFECT
  static void blogSlidesDifferences({
    required SlideModel? slide1,
    required SlideModel? slide2,
  }){

    blog('blogSlidesDifferences : START');

    if (slide1 == null){
      blog('slide1 == null');
    }

    if (slide2 == null){
      blog('slide2 == null');
    }

    if (slide1?.slideIndex != slide2?.slideIndex){
      blog('slide1.slideIndex != slide2.slideIndex');
    }
    if (slide1?.picPath != slide2?.picPath){
      blog('slide1.pic != slide2.pic');
    }
    if (slide1?.headline != slide2?.headline){
      blog('slide1.headline != slide2.headline');
    }
    if (slide1?.description != slide2?.description){
      blog('slide1.description != slide2.description');
    }
    if (Trinity.checkMatrixesAreIdentical(matrix1: slide1?.matrix, matrixReloaded: slide2?.matrix) == false){
      blog('slide1.matrix != slide2.matrix');
    }
    if (slide1?.picFit != slide2?.picFit){
      blog('slide1.picFit != slide2.picFit');
    }
    if (Dimensions.checkDimensionsAreIdentical(dim1: slide1?.dimensions, dim2: slide2?.dimensions) == false){
      blog('slide1.dimensions != slide2.dimensions');
    }
    if (Colorizer.checkColorsAreIdentical(slide1?.midColor, slide2?.midColor) == false){
      blog('slide1.midColor !=  slideB.midColor');
    }
    if (slide1?.flyerID != slide2?.flyerID){
      blog('slide1.flyerID != slide2.flyerID');
    }
    if (Floaters.checkUiImagesAreIdentical(slide1?.uiImage, slide2?.uiImage) == false){
      blog('slide1.uiImage != slide2.uiImage');
    }
    if (slide1?.animationCurve != slide2?.animationCurve){
      blog('slide1.animationCurve != slide2.animationCurve');
    }
    blog('blogSlidesDifferences : END');
  }
    // --------------------
  /// TESTED : WORKS PERFECT
  static void blogSlidesListsDifferences({
    required List<SlideModel>? slides1,
    required List<SlideModel>? slides2,
  }){

    if (slides1 == null){
      blog(' > slides1 == null');
    }
    if (slides2 == null){
      blog(' > slides2 == null');
    }
    if (slides1?.length != slides2?.length){
      blog(' > slides1.length [ ${slides1?.length} ] != [ ${slides2?.length} ] slides2.length');
    }

    if (Mapper.checkCanLoopList(slides1) == true && Mapper.checkCanLoopList(slides2) == true){

      if (slides1!.length != slides2!.length) {
        blog(' > maps1.length != maps2.length');
      }

      else {
        for (int i = 0; i < slides1.length; i++) {

          final bool _identicalSlides = checkSlidesAreIdentical(
            slide1: slides1[i],
            slide2: slides2[i],
          );

          if (_identicalSlides == false) {
            blog(' >> slides at index ( $i ) do not match : ( ${slides1[i]} ) <=> ( ${slides2[i]} )');
            blogSlidesDifferences(
              slide1: slides1[i],
              slide2: slides2[i],
            );
            break;
          }

          else {
            blog(' >> all maps are identical');
          }

        }
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// ID GENERATOR AND GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? generateSlideID({
    required String? flyerID,
    required int? slideIndex,
  }) {

    String? _output;

    if (flyerID != null && slideIndex != null){
      /// NOTE : slide index shall never have more than two digits
      /// as flyer should never be more than 10 slides long
      final String _slideIndexString = slideIndex <= 9 ? '0$slideIndex' : '$slideIndex';
      _output = '${flyerID}_$_slideIndexString'; // no

    }


    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateSlidesIDs({
    required String flyerID,
    required int numberOfSlides,
  }) {
    final List<String> _slidesIDs = <String>[];

    for (int i = 0; i < numberOfSlides; i++) {

      final String? _slideID = SlideModel.generateSlideID(
        flyerID: flyerID,
        slideIndex: i,
      );

      if (_slideID != null){
        _slidesIDs.add(_slideID);
      }


    }

    return _slidesIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int? getSlideIndexFromSlideID(String slideID) {
    /// NOTE : slide index shall never have more than two digits
    final String? _lastTwoSubStrings = TextMod.cutLastTwoCharactersFromAString(slideID);
    final int? _slideIndex = Numeric.transformStringToInt(_lastTwoSubStrings);
    return _slideIndex;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFlyerIDFromSlideID(String slideID) {
    final String? _flyerID = TextMod.removeTextAfterFirstSpecialCharacter(
        text: slideID,
        specialCharacter: '_',
    );
    return _flyerID;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// DEPRECATED
  /*
  ///
  static List<SlideModel> replaceSlidesPicturesWithNewURLs({
    required List<String> newPicturesURLs,
    required List<SlideModel> inputSlides,
  }) {
    final List<SlideModel> _outputSlides = <SlideModel>[];

    for (final SlideModel slide in inputSlides) {
      final int i = slide.slideIndex;

      final SlideModel _newSlide = inputSlides[i].copyWith(
          picPath: newPicturesURLs[i],
      );

      _outputSlides.add(_newSlide);
    }

    blog('replaceSlidesPicturesWithNewURLs : slides are $_outputSlides');

    return _outputSlides;
  }
   */
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// NOT USED
  /*
  static Future<List<File>> getImageFilesFromPublishedSlides(List<SlideModel> slides) async {
    final List<File> _files = <File>[];

    if (Mapper.checkCanLoopList(slides)) {
      for (final SlideModel slide in slides) {
        final File _file = await Filers.getFileFromURL(slide.picPath);

        _files.add(_file);
      }
    }

    return _files;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getSlidePicsPaths(List<SlideModel>? slides){
    final List<String> _paths = <String>[];

    if (Mapper.checkCanLoopList(slides) == true){

      for (final SlideModel slide in slides!){
        if (slide.picPath != null){
          _paths.add(slide.picPath!);
        }
      }

    }

    return _paths;
  }
  // --------------------
  /// NOT USED
  /*
  static List<BoxFit> getSlidesBoxFits(List<SlideModel> slides) {
    final List<BoxFit> _boxFits = <BoxFit>[];

    if (Mapper.checkCanLoopList(slides)) {
      for (final SlideModel slide in slides) {
        final BoxFit _fit = slide.picFit;

        if (_fit == null) {
          _boxFits.add(BoxFit.cover);
        } else {
          _boxFits.add(_fit);
        }
      }
    }

    return _boxFits;
  }
   */
  // --------------------
  /// NOT USED
  /*
  static List<SlideModel> getSlidesFromSlidesByFlyerID(List<SlideModel> allSlides, String flyerID) {
    final List<SlideModel> _foundSlides = <SlideModel>[];

    if (allSlides != null && flyerID != null && allSlides.isNotEmpty) {
      for (final SlideModel slide in allSlides) {
        if (slide.flyerID == flyerID) {
          _foundSlides.add(slide);
        }
      }
    }

    _foundSlides.sort(
            (SlideModel a, SlideModel b) => a.slideIndex.compareTo(b.slideIndex));

    return _foundSlides;
  }
   */
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static SlideModel dummySlide() {
    return SlideModel(
      slideIndex: 0,
      picPath: Iconz.power,
      headline: 'Headliner',
      description: 'Descriptor',
      picFit: BoxFit.cover,
      dimensions: const Dimensions(height: 900, width: 600),
      midColor: Colorz.black255,
      matrix: Matrix4.identity(),
      animationCurve: null,
    );
  }
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<SlideModel> sortSlidesByIndexes(List<SlideModel> slides){

    if (Mapper.checkCanLoopList(slides) == true){
      final List<SlideModel> _slides = [...slides];
      _slides.sort((a, b) => a.slideIndex.compareTo(b.slideIndex));
      return _slides;
    }

    else {
      return <SlideModel>[];
    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSlidesAreIdentical({
    required SlideModel? slide1,
    required SlideModel? slide2,
  }){
    bool _identical = false;

    if (slide1 == null && slide2 == null){
      _identical = true;
    }

    else if (slide1 != null && slide2 != null){

      if (
      slide1.slideIndex == slide2.slideIndex &&
          slide1.picPath == slide2.picPath &&
          slide1.headline == slide2.headline &&
          slide1.description == slide2.description &&
          Trinity.checkMatrixesAreIdentical(matrix1: slide1.matrix, matrixReloaded: slide2.matrix) == true &&
          slide1.picFit == slide2.picFit &&
          Dimensions.checkDimensionsAreIdentical(dim1: slide1.dimensions, dim2: slide2.dimensions) == true &&
          Colorizer.checkColorsAreIdentical(slide1.midColor, slide2.midColor) == true &&
          slide1.flyerID == slide2.flyerID &&
          Floaters.checkUiImagesAreIdentical(slide1.uiImage, slide2.uiImage) == true
      ){
        _identical = true;
      }

    }

    // if (_identical == false){
    //   blogSlidesDifferences(
    //     slide1: slide1,
    //     slide2: slide2,
    //   );
    // }

    return _identical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSlidesListsAreIdentical({
    required List<SlideModel>? slides1,
    required List<SlideModel>? slides2,
  }){
    bool _identical = false;

    if (slides1 == null && slides2 == null){
      _identical = true;
    }
    else if (slides1 != null && slides1.isEmpty == true && slides2 != null && slides2.isEmpty == true){
      _identical = true;
    }
    else if (
        Mapper.checkCanLoopList(slides1) == true
        &&
        Mapper.checkCanLoopList(slides2) == true
    ){

      if (slides1!.length == slides2!.length){

        for (int i = 0; i < slides1.length; i++){

          final bool _slidesAreIdentical = checkSlidesAreIdentical(
            slide1: slides1[i],
            slide2: slides2[i],
          );

          if (_slidesAreIdentical == true && i + 1 == slides1.length){
            _identical = true;
          }
          else if (_slidesAreIdentical == false){
            _identical = false;
            break;
          }

        }

      }

    }

    // if (_identical == false){
    //   blogSlidesListsDifferences(
    //     slides1: slides1,
    //     slides2: slides2,
    //   );
    // }

    return _identical;
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
    if (other is SlideModel){
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
      description.hashCode^
      picFit.hashCode^
      dimensions.hashCode^
      midColor.hashCode^
      matrix.hashCode^
      animationCurve.hashCode^
      slideIndex.hashCode^
      picPath.hashCode^
      headline.hashCode^
      uiImage.hashCode^
      flyerID.hashCode;
  // -----------------------------------------------------------------------------
}
