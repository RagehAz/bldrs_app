import 'dart:io';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart' as Colorizer;
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/drafters/trinity.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class SlideModel {
  /// --------------------------------------------------------------------------
  SlideModel({
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
    this.sharesCount,
    this.viewsCount,
    this.savesCount,
    this.flyerID,
  });
  /// --------------------------------------------------------------------------
  final int slideIndex;
  final dynamic pic;
  final String headline;
  final String description;
  final Matrix4 matrix;
  int sharesCount;
  int viewsCount;
  int savesCount;
  BoxFit picFit;
  ImageSize imageSize;
  Color midColor;
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
      'sharesCount': sharesCount,
      'viewsCount': viewsCount,
      'savesCount': savesCount,
      'boxFit': ImageSize.cipherBoxFit(picFit),
      'imageSize': imageSize.toMap(),
      'midColor': Colorizer.cipherColor(midColor),
      'matrix' : Trinity.cipherMatrix(matrix),
      'filterID' : filterID,
    };
  }
// -------------------------------------
  static SlideModel decipherSlide(dynamic map) {

    blog(map['matrix'].runtimeType);
    blog(map['matrix']);

    return SlideModel(
      slideIndex: map['slideIndex'],
      pic: map['picture'],
      headline: map['headline'],
      description: map['description'],
      // -------------------------
      sharesCount: map['sharesCount'],
      viewsCount: map['viewsCount'],
      savesCount: map['savesCount'],
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
// -----------------------------------------------------------------------------

  /// CLONING

// -------------------------------------
  SlideModel copyWith({
    int slideIndex,
    dynamic pic,
    String headline,
    String description,
    Matrix4 matrix,
    int sharesCount,
    int viewsCount,
    int savesCount,
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
      sharesCount: sharesCount ?? this.sharesCount,
      viewsCount: viewsCount ?? this.viewsCount,
      savesCount: savesCount ?? this.savesCount,
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
    blog('SLIDE-PRINT --------------------------------------------------START');

    blog('flyerID : $flyerID');
    blog('slideIndex : $slideIndex');
    blog('pic : $pic');
    blog('headline : $headline');
    blog('description : $description');
    blog('sharesCount : $sharesCount');
    blog('viewsCount : $viewsCount');
    blog('savesCount : $savesCount');
    blog('picFit : $picFit');
    blog('imageSize : $imageSize');
    blog('midColor : $midColor');
    blog('filterID : $filterID');

    Trinity.blogMatrix(matrix);

    blog('SLIDE-PRINT --------------------------------------------------END');
  }
// -------------------------------------
  static void blogSlides(List<SlideModel> slides) {

    if (Mapper.checkCanLoopList(slides) == false) {
      blog('slides can not be printed : slides are : $slides');
    }

    else {
      blog('XXX - STARTING TO PRINT ALL ${slides.length} SLIDES');

      for (final SlideModel slide in slides) {
        slide.blogSlide();
      }

      blog('XXX - ENDED PRINTING ALL ${slides.length} SLIDES');
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
  static bool allSlidesPicsAreTheSame({
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
// -----------------------------------------------------------------------------

  /// ID GENERATOR AND GETTERS

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String generateSlideID({
    @required String flyerID,
    @required int slideIndex,
  }) {
    /// NOTE : slide index shall never have more than two digits
    /// and flyer should never be more than 10 slides long
    final String _slideIndexString = slideIndex <= 9 ? '0$slideIndex' : '$slideIndex';
    final String _slideID = '${flyerID}_$_slideIndexString';
    return _slideID;
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
        final File _file = await Imagers.getFileFromURL(slide.pic);

        _files.add(_file);
      }
    }

    return _files;
  }
// -------------------------------------
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
  static SlideModel getSlideFromMutableSlide(MutableSlide mSlide) {
    SlideModel _slideModel;

    if (mSlide != null) {
      _slideModel = SlideModel(
        slideIndex: mSlide.slideIndex,
        pic: mSlide.picURL ?? mSlide.picFile ?? mSlide.picAsset,
        headline: mSlide.headline.text,
        description: mSlide.description.text,
        sharesCount: mSlide.sharesCount,
        viewsCount: mSlide.viewsCount,
        savesCount: mSlide.savesCount,
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
  static List<SlideModel> getSlidesFromMutableSlides(List<MutableSlide> mSlides) {
    final List<SlideModel> _slides = <SlideModel>[];

    if (Mapper.checkCanLoopList(mSlides)) {
      for (final MutableSlide mSlide in mSlides) {
        _slides.add(getSlideFromMutableSlide(mSlide));
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
      sharesCount: 2540256,
      viewsCount: 5442574,
      savesCount: 5402540,
      picFit: BoxFit.cover,
      imageSize: ImageSize(height: 900, width: 600),
      midColor: Colorz.black255,
      matrix: Matrix4.identity(),
      filterID: 'phid_filter_normal',
    );
  }
// -----------------------------------------------------------------------------
}
