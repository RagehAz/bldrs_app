import 'dart:io';

import 'package:bldrs/controllers/drafters/colorizers.dart' as Colorizer;
import 'package:bldrs/controllers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/controllers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/controllers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/controllers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/models/secondary_models/image_size.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class SlideModel {
  final int slideIndex;
  final dynamic pic;
  final String headline;
  final String description;
  int sharesCount;
  int viewsCount;
  int savesCount;
  BoxFit picFit;
  ImageSize imageSize;
  Color midColor;

  final String flyerID; /// only used in sql ops

  SlideModel({
    @required this.description,
    @required this.picFit, /// TASK : update all methods below to include this boxfit parameter
    @required this.imageSize,
    @required this.midColor,
    this.slideIndex,
    this.pic,
    this.headline,
    this.sharesCount,
    this.viewsCount,
    this.savesCount,

    this.flyerID, /// only used in sql ops
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'slideIndex': slideIndex,
      'picture': pic is String == true ? pic : null,
      'headline': headline,
      'description': description,
      'sharesCount': sharesCount,
      'viewsCount': viewsCount,
      'savesCount': savesCount,
      'boxFit' : ImageSize.cipherBoxFit(picFit),
      'imageSize' : imageSize.toMap(),
      'midColor' : Colorizer.cipherColor(midColor),
    };
  }
// -----------------------------------------------------------------------------
  static SlideModel decipherSlide(dynamic map){
    return SlideModel(
        slideIndex : map['slideIndex'],
        pic : map['picture'],
        headline : map['headline'],
        description : map['description'],
        // -------------------------
        sharesCount : map['sharesCount'],
        viewsCount : map['viewsCount'],
        savesCount : map['savesCount'],
        picFit: ImageSize.decipherBoxFit(map['boxFit']),
        imageSize: ImageSize.decipherImageSize(map['imageSize']),
        midColor: Colorizer.decipherColor(map['midColor'])
    );
  }
// -----------------------------------------------------------------------------
  static Map<String,Object> cipherSlides(List<SlideModel> slides) {
    Map<String,Object> _slidesMap = <String,Object>{};

    if (Mapper.canLoopList(slides)){

      for (SlideModel slide in slides){

        _slidesMap = Mapper.insertPairInMap(
          map: _slidesMap,
          key: '${slide.slideIndex}',
          value: slide.toMap(),
        );

      }

    }

    return _slidesMap;
  }
// -----------------------------------------------------------------------------
  static List<SlideModel> decipherSlides(Map<String, dynamic> maps){
    final List<SlideModel> _slides = <SlideModel>[];
    final List<String> _keys = maps.keys.toList();

    if (Mapper.canLoopList(_keys)){

      for (String key in _keys){

        final Map<String, dynamic> _slideMap = maps[key];
        final SlideModel _slide = decipherSlide(_slideMap);
        _slides.add(_slide);

      }

    }

    return _slides;
  }
// -----------------------------------------------------------------------------
  SlideModel clone(){
    return SlideModel(
      slideIndex : slideIndex,
      pic : pic,
      headline : headline,
      description : description,
      // -------------------------
      sharesCount : sharesCount,
      viewsCount : viewsCount,
      savesCount : savesCount,
      imageSize: imageSize,
      picFit: picFit,
      midColor: midColor,
    );
  }
// -------------------------
// -------------------------
  static void printSlides(List<SlideModel> slides){
    if (slides == null || slides.length == 0){

      print('slides can not be printed : slides are : ${slides}');

    }

    else {

      print('XXX - STARTING TO PRINT ALL ${slides.length} SLIDES');

      for (SlideModel slide in slides){

        slide.printSlide();

      }

      print('XXX - ENDED PRINTING ALL ${slides.length} SLIDES');

    }
  }
// -------------------------
  static List<SlideModel> cloneSlides(List<SlideModel> slides){
    final List<SlideModel> _newSlides = <SlideModel>[];

    for (SlideModel slide in slides){
      _newSlides.add(slide.clone());
    }
    return _newSlides;
  }
// -------------------------
  static bool slidesPicsAreTheSame(SlideModel finalSlide, SlideModel originalSlide){
    bool _slidesPicsAreTheSame;

    if (finalSlide.pic != originalSlide.pic){
      _slidesPicsAreTheSame = false;
    }
    else {
      _slidesPicsAreTheSame = true;
    }

    return _slidesPicsAreTheSame;
  }
// -----------------------------------------------------------------------------
  static bool allSlidesPicsAreTheSame({FlyerModel finalFlyer, FlyerModel originalFlyer}){
    bool _allSlidesPicsAreTheSame;

    // print('finalFlyer.slides.length = ${finalFlyer.slides.length}');
    // print('originalFlyer.slides.length = ${originalFlyer.slides.length}');

    if (finalFlyer.slides.length == originalFlyer.slides.length){

      for (int i = 0; i < finalFlyer.slides.length; i++){

        final bool _slidesAreTheSame = slidesPicsAreTheSame(finalFlyer.slides[i], originalFlyer.slides[i]);

        if (_slidesAreTheSame == false){
          _allSlidesPicsAreTheSame = false;
          break;
        } else {
          _allSlidesPicsAreTheSame = true;
        }

      }

    } else if (finalFlyer.slides.length != originalFlyer.slides.length){
      _allSlidesPicsAreTheSame = false;
    }

    return _allSlidesPicsAreTheSame;
  }
// -----------------------------------------------------------------------------
  static String generateSlideID(String flyerID, int slideIndex){
    // slide index shall never have more than two digits
    // ass flyer should never be more than 10 slides long
    final String _slideIndexString = slideIndex <= 9 ? '0$slideIndex' : '$slideIndex';
    final String _slideID = '${flyerID}_$_slideIndexString';
    return _slideID;
  }
// -----------------------------------------------------------------------------
  static List<String> generateSlidesIDs({String flyerID, int numberOfSlides,}){
    final List<String> _slidesIDs = <String>[];

    for (int i = 0; i < numberOfSlides; i++){
      final String _slideID = SlideModel.generateSlideID(flyerID, i);
      _slidesIDs.add(_slideID);
    }

    return _slidesIDs;
  }
// -----------------------------------------------------------------------------
  static int getSlideIndexFromSlideID(String slideID){
    // slide index shall never have more than two digits
    final int _slideIndex = Numeric.lastTwoIntegersFromAString(slideID);
    return _slideIndex;
  }
// -----------------------------------------------------------------------------
  static String getFlyerIDFromSlideID(String slideID){
    final String _flyerID = TextMod.removeTextAfterFirstSpecialCharacter(slideID, '_');
    return _flyerID;
  }
// -----------------------------------------------------------------------------
  static Future<List<SlideModel>> replaceSlidesPicturesWithNewURLs(List<String> newPicturesURLs, List<SlideModel> inputSlides) async {
    final List<SlideModel> _outputSlides = <SlideModel>[];

    for (SlideModel slide in inputSlides){

      final int i = slide.slideIndex;

      final SlideModel _newSlide = SlideModel(
        slideIndex: inputSlides[i].slideIndex,
        pic: newPicturesURLs[i],
        headline: inputSlides[i].headline,
        description: inputSlides[i].description,
        savesCount: inputSlides[i].savesCount,
        sharesCount: inputSlides[i].sharesCount,
        viewsCount: inputSlides[i].viewsCount,
        imageSize: inputSlides[i].imageSize,
        picFit: inputSlides[i].picFit,
        midColor: inputSlides[i].midColor,
      );

      _outputSlides.add(_newSlide);

    }

    print('slides are $_outputSlides');

    return _outputSlides;
  }
// -----------------------------------------------------------------------------
  static Future<Map<String, dynamic>> cipherSlidesCounters(List<SlideModel> slides) async {

    Map<String, dynamic> _combinedMap = <String, dynamic>{};

    await Future.forEach(slides, (SlideModel slide){

      _combinedMap.addAll(<String, dynamic>{
        'saves/${slide.slideIndex}' : slide.savesCount,
        'shares/${slide.slideIndex}' : slide.sharesCount,
        'views/${slide.slideIndex}' : slide.viewsCount,
      });

    });

    return _combinedMap;
  }
// -----------------------------------------------------------------------------
  static Future <List<File>> getImageFilesFromPublishedSlides(List<SlideModel> slides) async {
    final List<File> _files = <File>[];

    if (Mapper.canLoopList(slides)){
      for (SlideModel slide in slides){

        final File _file = await Imagers.getFileFromURL(slide.pic);

        _files.add(_file);

      }
    }

    return _files;
  }
// -----------------------------------------------------------------------------
  static Future <List<Asset>> getImageAssetsFromPublishedSlides(List<SlideModel> slides) async {
    final List<Asset> _assets = <Asset>[];


    if (Mapper.canLoopList(slides)){
      for (SlideModel slide in slides){

        final File _file = await Imagers.getFileFromURL(slide.pic);
        final ImageSize imageSize = await ImageSize.superImageSize(_file);


        final Asset _asset = new Asset(
          // identifier
          '${slide.slideIndex}',
          // _name
          '${slide.pic.toString()}',
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
// -----------------------------------------------------------------------------
  static List<BoxFit> getSlidesBoxFits(List<SlideModel> slides) {
    final List<BoxFit> _boxFits = <BoxFit>[];

    if (Mapper.canLoopList(slides)){
      for (SlideModel slide in slides){

        final BoxFit _fit = slide.picFit;

        if (_fit == null){
          _boxFits.add(BoxFit.cover);
        }
        else {
        _boxFits.add(_fit);
        }

      }
    }

    return _boxFits;
  }
// -----------------------------------------------------------------------------
  static List<bool> createVisibilityListFromSlides(List<SlideModel> slides){
    final List<bool> _visibilityList = <bool> [];

    if (Mapper.canLoopList(slides)){
      for (int i = 0; i < slides.length; i++){
        _visibilityList.add(true);
      }
    }

    return _visibilityList;
  }
// -----------------------------------------------------------------------------
  static SlideModel getSlideFromMutableSlide(MutableSlide mSlide){

    SlideModel _slideModel;

    if (mSlide != null){
      _slideModel = SlideModel(
          slideIndex: mSlide.slideIndex,
          pic: mSlide.picURL ?? mSlide.picFile ?? mSlide.picAsset,
          headline: mSlide.headline,
          description: mSlide.description,
          sharesCount: mSlide.sharesCount,
          viewsCount: mSlide.viewsCount,
          savesCount: mSlide.savesCount,
          picFit: mSlide.picFit,
          imageSize: mSlide.imageSize,
          midColor: mSlide.midColor,
      );
    }
    return _slideModel;
  }
// -----------------------------------------------------------------------------
  static List<SlideModel> getSlidesFromMutableSlides(List<MutableSlide> mSlides){
    final List<SlideModel> _slides = <SlideModel>[];
    if (mSlides != null && mSlides.length != 0){
      for (MutableSlide mSlide in mSlides){
        _slides.add(getSlideFromMutableSlide(mSlide));
      }
    }
    return _slides;
  }
// -----------------------------------------------------------------------------
  static List<SlideModel> getSlidesFromSlidesByFlyerID(List<SlideModel> allSlides, String flyerID){
    final List<SlideModel> _foundSlides = <SlideModel>[];

    if(allSlides != null && flyerID != null && allSlides.length != 0){

      for (SlideModel slide in allSlides){

        if (slide.flyerID == flyerID){
          _foundSlides.add(slide);
        }

      }

    }

    _foundSlides.sort((SlideModel a, SlideModel b) => a.slideIndex.compareTo(b.slideIndex));

    return _foundSlides;
  }
// -----------------------------------------------------------------------------
  static SlideModel dummySlide(){
    return
        SlideModel(
            slideIndex: 0,
            pic: Iconz.DumSlide1,
            headline: 'Headliner',
            description: 'Descriptor',
            sharesCount: 2540256,
            viewsCount: 5442574,
            savesCount: 5402540,
            picFit: BoxFit.cover,
            imageSize: ImageSize(height: 900, width: 600),
            midColor: Colorz.black255,
        );
  }
// -----------------------------------------------------------------------------
  void printSlide(){

    print('SLIDE-PRINT --------------------------------------------------START');

    // print('SLIDE-PRINT : flyerID : ${flyerID}');
    print('SLIDE-PRINT : slideIndex : ${slideIndex}');
    print('SLIDE-PRINT : pic : ${pic}');
    print('SLIDE-PRINT : headline : ${headline}');
    print('SLIDE-PRINT : description : ${description}');
    print('SLIDE-PRINT : sharesCount : ${sharesCount}');
    print('SLIDE-PRINT : viewsCount : ${viewsCount}');
    print('SLIDE-PRINT : savesCount : ${savesCount}');
    print('SLIDE-PRINT : picFit : ${picFit}');
    print('SLIDE-PRINT : imageSize : ${imageSize}');
    print('SLIDE-PRINT : midColor : ${midColor}');

    print('SLIDE-PRINT --------------------------------------------------END');

  }
// -----------------------------------------------------------------------------
}