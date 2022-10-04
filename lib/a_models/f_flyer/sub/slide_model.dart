import 'dart:io';

import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/mutable_slide.dart';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/a_models/x_utilities/image_size.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/drafters/trinity.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

@immutable
class SlideModel {
  /// --------------------------------------------------------------------------
  const SlideModel({
    @required this.description,
    @required this.picFit,
    /// TASK : update all methods below to include this boxfit parameter
    @required this.imageSize,
    @required this.midColor,
    @required this.matrix,
    @required this.filterID,
    this.slideIndex,
    this.pic,
    this.headline,
    this.flyerID,
  });
  /// --------------------------------------------------------------------------
  final int slideIndex;
  final dynamic pic;
  final String headline;
  final String description;
  final Matrix4 matrix;
  final BoxFit picFit;
  final ImageSize imageSize;
  final Color midColor;
  final String flyerID;
  final String filterID;
// -----------------------------------------------------------------------------

  /// CYPHERS

// -------------------------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slideIndex': slideIndex,
      'picture': pic is String == true ? pic : null,
      'headline': headline,
      'description': description,
      'boxFit': ImageSize.cipherBoxFit(picFit),
      'imageSize': imageSize.toMap(),
      'midColor': Colorizer.cipherColor(midColor),
      'matrix' : Trinity.cipherMatrix(matrix),
      'filterID' : filterID,
    };
  }
// -------------------------------------
  static SlideModel decipherSlide(dynamic map) {

    return SlideModel(
      slideIndex: map['slideIndex'],
      pic: map['picture'],
      headline: map['headline'],
      description: map['description'],
      picFit: ImageSize.decipherBoxFit(map['boxFit']),
      imageSize: ImageSize.decipherImageSize(map['imageSize']),
      midColor: Colorizer.decipherColor(map['midColor']),
      matrix: Trinity.decipherMatrix(map['matrix']),
      filterID: map['filterID'],
    );
  }
// -------------------------------------
  static Map<String, Object> cipherSlides(List<SlideModel> slides) {
    Map<String, Object> _slidesMap = <String, Object>{};

    if (Mapper.checkCanLoopList(slides)) {
      for (final SlideModel slide in slides) {
        _slidesMap = Mapper.insertPairInMap(
          map: _slidesMap,
          key: '${slide.slideIndex}',
          value: slide.toMap(),
        );
      }
    }

    return _slidesMap;
  }
// -------------------------------------
  static List<SlideModel> decipherSlides(Map<String, dynamic> maps) {
    final List<SlideModel> _slides = <SlideModel>[];
    final List<String> _keys = maps.keys.toList();

    if (Mapper.checkCanLoopList(_keys)) {
      for (final String key in _keys) {
        final Map<String, dynamic> _slideMap = maps[key];
        final SlideModel _slide = decipherSlide(_slideMap);
        _slides.add(_slide);
      }
    }

    return _slides;
  }
// -------------------------------------
  /*
  static Future<Map<String, dynamic>> cipherSlidesCounters(List<SlideModel> slides) async {
    final Map<String, dynamic> _combinedMap = <String, dynamic>{};

    await Future.forEach(slides, (SlideModel slide) {
      _combinedMap.addAll(<String, dynamic>{
        'saves/${slide.slideIndex}': slide.savesCount,
        'shares/${slide.slideIndex}': slide.sharesCount,
        'views/${slide.slideIndex}': slide.viewsCount,
      });
    });

    return _combinedMap;
  }
   */
// -----------------------------------------------------------------------------

  /// CLONING

// -------------------------------------
  SlideModel copyWith({
    int slideIndex,
    dynamic pic,
    String headline,
    String description,
    Matrix4 matrix,
    BoxFit picFit,
    ImageSize imageSize,
    Color midColor,
    String flyerID,
    String filterID,
}) {
    return SlideModel(
      slideIndex: slideIndex ?? this.slideIndex,
      pic: pic ?? this.pic,
      headline: headline ?? this.headline,
      description: description ?? this.description,
      imageSize: imageSize ?? this.imageSize,
      picFit: picFit ?? this.picFit,
      midColor: midColor ?? this.midColor,
      matrix: matrix ?? this.matrix,
      filterID: filterID ?? this.filterID,
    );
  }
// -----------------------------------------------------------------------------

  /// BLOGGING

// -------------------------------------
  void blogSlide() {
    blog('slideIndex : $slideIndex : flyerID : $flyerID --------------------------------------- []');
    blog('headline : $headline');
    blog('description : $description');
    blog('midColor : $midColor : filterID : $filterID : picFit : $picFit : hasCustomMatrix : ${matrix != Matrix4.identity()}');
    imageSize.blogSize();
    blog('pic : $pic');
  }
// -------------------------------------
  static void blogSlides(List<SlideModel> slides) {

    blog('blogSlides : ${slides.length} SLIDES -----------------------------------------START');
    if (Mapper.checkCanLoopList(slides) == false) {
      blog('blogSlides : slides can not be printed : slides are : $slides');
    }

    else {

      for (final SlideModel slide in slides) {
        slide.blogSlide();
      }

    }

    blog('blogSlides -------------------------------------------------- END');
  }
// -------------------------------------
  static void blogSlidesDifferences({
    @required SlideModel slide1,
    @required SlideModel slide2,
  }){

    blog('blogSlidesDifferences : START');

    if (slide1 == null){
      blog('slide1 == null');
    }

    if (slide2 == null){
      blog('slide2 == null');
    }

    if (slide1.slideIndex != slide2.slideIndex){
      blog('slide1.slideIndex != slide2.slideIndex');
    }
    if (Imagers.checkPicsAreIdentical(pic1: slide1.pic, pic2: slide2.pic) == false){
      blog('slide1.pic != slide2.pic');
    }
    if (slide1.headline != slide2.headline){
      blog('slide1.headline != slide2.headline');
    }
    if (slide1.description != slide2.description){
      blog('slide1.description != slide2.description');
    }
    if (Trinity.checkMatrixesAreIdentical(matrix1: slide1.matrix, matrixReloaded: slide2.matrix) == false){
      blog('slide1.matrix != slide2.matrix');
    }
    if (slide1.picFit != slide2.picFit){
      blog('slide1.picFit != slide2.picFit');
    }
    if (ImageSize.checkSizesAreIdentical(sizeA: slide1.imageSize, sizeB: slide2.imageSize) == false){
      blog('slide1.imageSize != slide2.imageSize');
    }
    if (Colorizer.checkColorsAreIdentical(slide1.midColor, slide2.midColor) == false){
      blog('slide1.midColor !=  slideB.midColor');
    }
    if (slide1.flyerID != slide2.flyerID){
      blog('slide1.flyerID != slide2.flyerID');
    }
    if (slide1.filterID != slide2.filterID){
      blog('slide1.filterID != slide2.filterID');
    }


    blog('blogSlidesDifferences : END');
  }
// -------------------------------------
  static void blogSlidesListsDifferences({
    @required List<SlideModel> slides1,
    @required List<SlideModel> slides2,
  }){

    if (slides1 == null){
      blog('slides1 == null');
    }
    if (slides2 == null){
      blog('slides2 == null');
    }
    if (slides1?.length != slides2?.length){
      blog('slides1.length [ ${slides1?.length} ] != [ ${slides2?.length} ] slides2.length');
    }

  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  static bool slidesPicsAreTheSame({
    @required SlideModel newSlide,
    @required SlideModel oldSlide,
  }) {

    final bool _slidesPicsAreTheSame = newSlide?.pic == oldSlide?.pic;

    /// deprecated
    // if (newSlide.pic != oldSlide.pic) {
    //   _slidesPicsAreTheSame = false;
    // }
    //
    // else {
    //   _slidesPicsAreTheSame = true;
    // }

    return _slidesPicsAreTheSame;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static bool allSlidesPicsAreIdentical({
    @required FlyerModel newFlyer,
    @required FlyerModel oldFlyer,
  }) {
    bool _allSlidesPicsAreTheSame;

    if (newFlyer.slides.length == oldFlyer.slides.length) {
      for (int i = 0; i < newFlyer.slides.length; i++) {

        final bool _slidesAreTheSame = slidesPicsAreTheSame(
            newSlide: newFlyer.slides[i],
            oldSlide: oldFlyer.slides[i],
        );

        if (_slidesAreTheSame == false) {
          _allSlidesPicsAreTheSame = false;
          break;
        }

        else {
          _allSlidesPicsAreTheSame = true;
        }

      }
    }

    else if (newFlyer.slides.length != oldFlyer.slides.length) {
      _allSlidesPicsAreTheSame = false;
    }

    return _allSlidesPicsAreTheSame;
  }
// -------------------------------------
  static bool checkSlidesAreIdentical({
    @required SlideModel slide1,
    @required SlideModel slide2,
  }){
    bool _identical = false;

    if (slide1 == null && slide2 == null){
      _identical = true;
    }

    else if (slide1 != null && slide2 != null){

      if (
          slide1.slideIndex == slide2.slideIndex &&
          Imagers.checkPicsAreIdentical(pic1: slide1.pic, pic2: slide2.pic) &&
          slide1.headline == slide2.headline &&
          slide1.description == slide2.description &&
          Trinity.checkMatrixesAreIdentical(matrix1: slide1.matrix, matrixReloaded: slide2.matrix) &&
          slide1.picFit == slide2.picFit &&
          ImageSize.checkSizesAreIdentical(sizeA: slide1.imageSize, sizeB: slide2.imageSize) &&
          Colorizer.checkColorsAreIdentical(slide1.midColor, slide2.midColor) &&
          slide1.flyerID == slide2.flyerID &&
          slide1.filterID == slide2.filterID
      ){
        _identical = true;
      }

    }

    if (_identical == false){
      blogSlidesDifferences(
        slide1: slide1,
        slide2: slide2,
      );
    }

    return _identical;
  }
// -------------------------------------
  static bool checkSlidesListsAreIdentical({
    @required List<SlideModel> slides1,
    @required List<SlideModel> slides2,
  }){
    bool _identical = false;

    if (slides1 == null && slides2 == null){
      _identical = true;
    }
    else if (slides1?.isEmpty == true && slides2?.isEmpty == true){
      _identical = true;
    }
    else if (
        Mapper.checkCanLoopList(slides1) == true &&
        Mapper.checkCanLoopList(slides2) == true
    ){

      if (slides1.length == slides2.length){

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

    if (_identical == false){
      blogSlidesListsDifferences(
        slides1: slides1,
        slides2: slides2,
      );
    }

    return _identical;
  }
// -----------------------------------------------------------------------------

  /// ID GENERATOR AND GETTERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String generateSlideID({
    @required String flyerID,
    @required int slideIndex,
  }) {

    String _output;

    if (flyerID != null && slideIndex != null){
      /// NOTE : slide index shall never have more than two digits
      /// as flyer should never be more than 10 slides long
      final String _slideIndexString = slideIndex <= 9 ? '0$slideIndex' : '$slideIndex';
      _output = '${flyerID}_$_slideIndexString'; // no

    }


    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateSlidesIDs({
    @required String flyerID,
    @required int numberOfSlides,
  }) {
    final List<String> _slidesIDs = <String>[];

    for (int i = 0; i < numberOfSlides; i++) {

      final String _slideID = SlideModel.generateSlideID(
        flyerID: flyerID,
        slideIndex: i,
      );

      _slidesIDs.add(_slideID);

    }

    return _slidesIDs;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static int getSlideIndexFromSlideID(String slideID) {
    /// NOTE : slide index shall never have more than two digits
    final String _lastTwoSubStrings = TextMod.cutLastTwoCharactersFromAString(slideID);
    final int _slideIndex = Numeric.transformStringToInt(_lastTwoSubStrings);
    return _slideIndex;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String getFlyerIDFromSlideID(String slideID) {
    final String _flyerID = TextMod.removeTextAfterFirstSpecialCharacter(slideID, '_');
    return _flyerID;
  }
// -----------------------------------------------------------------------------

  /// MODIFIERS

// -------------------------------------
  static List<SlideModel> replaceSlidesPicturesWithNewURLs({
    @required List<String> newPicturesURLs,
    @required List<SlideModel> inputSlides,
  }) {
    final List<SlideModel> _outputSlides = <SlideModel>[];

    for (final SlideModel slide in inputSlides) {
      final int i = slide.slideIndex;

      final SlideModel _newSlide = inputSlides[i].copyWith(
          pic: newPicturesURLs[i],
      );

      _outputSlides.add(_newSlide);
    }

    blog('replaceSlidesPicturesWithNewURLs : slides are $_outputSlides');

    return _outputSlides;
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
  static Future<List<File>> getImageFilesFromPublishedSlides(List<SlideModel> slides) async {
    final List<File> _files = <File>[];

    if (Mapper.checkCanLoopList(slides)) {
      for (final SlideModel slide in slides) {
        final File _file = await Filers.getFileFromURL(slide.pic);

        _files.add(_file);
      }
    }

    return _files;
  }
// -------------------------------------
  ///
  static List<String> getSlidePics(List<SlideModel> slides){
    final List<String> _urls = <String>[];

    if (Mapper.checkCanLoopList(slides) == true){

      for (final SlideModel slide in slides){
        _urls.add(slide.pic);
      }

    }

    return _urls;
  }
// -------------------------------------
  /*
  static Future<List<Asset>> getImageAssetsFromPublishedSlides(List<SlideModel> slides) async {
    final List<Asset> _assets = <Asset>[];

    if (Mapper.checkCanLoopList(slides)) {
      for (final SlideModel slide in slides) {
        final File _file = await Imagers.getFileFromURL(slide.pic);
        final ImageSize imageSize = await ImageSize.superImageSize(_file);

        final Asset _asset = Asset(
          // identifier
          '${slide.slideIndex}',
          // _name
          slide.pic.toString(),
          // _originalWidth
          imageSize.width.toInt(),
          // _originalHeight
          imageSize.height.toInt(),
        ); //await Imagers.urlToAsset(slide.picture); /// TASK : URL to Asset needed here if possible

        _assets.add(_asset);
      }
    }

    return _assets;
  }
   */
// -------------------------------------
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
// -------------------------------------
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
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static SlideModel getSlideFromMutableSlide({
    @required MutableSlide mSlide,
    @required bool forLDB,
}) {
    SlideModel _slideModel;

    if (mSlide != null) {
      _slideModel = SlideModel(
        slideIndex: mSlide.slideIndex,
        pic: forLDB == true ?
        FileModel.bakeFileForLDB(mSlide.picFileModel)
        :
        FileModel.bakeFileForUpload(
          newFile: mSlide.picFileModel,
          existingPic: mSlide.picURL,
        ),
        headline: mSlide.headline,
        description: mSlide.description,
        picFit: mSlide.picFit,
        imageSize: mSlide.imageSize,
        midColor: mSlide.midColor,
        matrix: mSlide.matrix,
        filterID: mSlide.filter.id,
      );
    }
    return _slideModel;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<SlideModel> getSlidesFromMutableSlides({
    @required List<MutableSlide> mSlides,
    @required bool forLDB,
  }) {
    final List<SlideModel> _slides = <SlideModel>[];

    if (Mapper.checkCanLoopList(mSlides)) {
      for (final MutableSlide mSlide in mSlides) {
        _slides.add(getSlideFromMutableSlide(
          mSlide: mSlide,
          forLDB: forLDB,
        ));
      }
    }

    return _slides;
  }
// -----------------------------------------------------------------------------

  /// VISIBILITY LISTS

// -------------------------------------
  static List<bool> createVisibilityListFromSlides(List<SlideModel> slides) {
    final List<bool> _visibilityList = <bool>[];

    if (Mapper.checkCanLoopList(slides)) {
      for (int i = 0; i < slides.length; i++) {
        _visibilityList.add(true);
      }
    }

    return _visibilityList;
  }
// -----------------------------------------------------------------------------

  /// DUMMIES

// -------------------------------------
  static SlideModel dummySlide() {
    return SlideModel(
      slideIndex: 0,
      pic: Iconz.dumSlide1,
      headline: 'Headliner',
      description: 'Descriptor',
      picFit: BoxFit.cover,
      imageSize: const ImageSize(height: 900, width: 600),
      midColor: Colorz.black255,
      matrix: Matrix4.identity(),
      filterID: 'phid_filter_normal',
    );
  }
// -----------------------------------------------------------------------------

  /// OVERRIDES

// ----------------------------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
// ----------------------------------------
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
// ----------------------------------------
  @override
  int get hashCode =>
      description.hashCode^
      picFit.hashCode^
      imageSize.hashCode^
      midColor.hashCode^
      matrix.hashCode^
      filterID.hashCode^
      slideIndex.hashCode^
      pic.hashCode^
      headline.hashCode^
      flyerID.hashCode;
// -----------------------------------------------------------------------------
}
