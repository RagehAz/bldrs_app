import 'dart:typed_data';

import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:basics/super_image/super_image.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/blur/blur_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

// // -----------------------------------------------------------------------------
// /*
// /// GIF THING
// // check this
// // https://stackoverflow.com/questions/67173576/how-to-get-or-pick-local-gif-file-from-device
// // https://pub.dev/packages/file_picker
// // Container(
// //   width: 200,
// //   height: 200,
// //   margin: EdgeInsets.all(30),
// //   color: Colorz.BloodTest,
// //   child: Image.network('https://media.giphy.com/media/hYUeC8Z6exWEg/giphy.gif'),
// // ),
//  */

/// => TAMAM
class BldrsPicMaker {
  // --------------------------------------------------------------------------

  const BldrsPicMaker();

  // -----------------------------------------------------------------------------

  /// MAKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<PicModel?> makePic({
    required PicMakerType picMakerType,
    required bool cropAfterPick,
    required double aspectRatio,
    required int compressionQuality,
    required double finalWidth,
    required String assignPath,
    required List<String> ownersIDs,
    required String name,
  }) async {
    PicModel? _output;
    Uint8List? _bytes;

    if(picMakerType == PicMakerType.galleryImage){
      _bytes = await PicMaker.pickAndCropSinglePic(
        context: getMainContext(),
        cropAfterPick: cropAfterPick,
        aspectRatio: aspectRatio,
        finalWidth: finalWidth,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        confirmText: Verse.transBake('phid_continue')!,
        onlyCompress: Standards.onlyCompressOnResizing,
        compressionQuality: compressionQuality,
        // selectedAsset: selectedAsset,
      );
    }

    else if (picMakerType == PicMakerType.cameraImage){
      _bytes = await PicMaker.shootAndCropCameraPic(
        context: getMainContext(),
        cropAfterPick: cropAfterPick,
        aspectRatio: aspectRatio,
        finalWidth: finalWidth,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        onlyCompress: Standards.onlyCompressOnResizing,
        compressionQuality: compressionQuality,
        confirmText: Verse.transBake('phid_continue')!,
      );
    }

    if (_bytes != null){

      _output = await PicModel.combinePicModel(
        ownersIDs: ownersIDs,
        name: name,
        bytes: _bytes,
        compressionQuality: compressionQuality,
        picMakerType: picMakerType,
        assignPath: assignPath,
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME VERIFY_ME
  static Future<List<PicModel>> makePics({
    required bool cropAfterPick,
    required double aspectRatio,
    required int compressionQuality,
    required double finalWidth,
    required String Function(int index) assignPath,
    required List<String> ownersIDs,
    required String Function(int index) picNameGenerator,
    required int maxAssets,
  }) async {

    final List<PicModel> _output = [];

    final List<Uint8List> _bytezz = await PicMaker.pickAndCropMultiplePics(
      context: getMainContext(),
      cropAfterPick: cropAfterPick,
      aspectRatio: aspectRatio,
      finalWidth: finalWidth,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      confirmText: Verse.transBake('phid_continue')!,
      maxAssets: maxAssets,
      compressionQuality: compressionQuality,
      onlyCompress: Standards.onlyCompressOnResizing,
      // selectedAssets: selectedAssets,
    );

    if (Mapper.checkCanLoopList(_bytezz) == true){

      for (int i = 0; i < _bytezz.length; i++){

        final Uint8List bytes = _bytezz[i];

        final PicModel? _picModel = await PicModel.combinePicModel(
          ownersIDs: ownersIDs,
          name: picNameGenerator(i),
          bytes: bytes,
          compressionQuality: compressionQuality,
          picMakerType: PicMakerType.galleryImage,
          assignPath: assignPath(i),
        );

        if (_picModel != null){
          _output.add(_picModel);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CROPPERS

  // --------------------
  /// TASK : TEST ME VERIFY_ME
  static Future<PicModel?> cropPic({
    required PicModel? pic,
    required double aspectRatio,
    required int compressionQuality,
  }) async {
    PicModel? _output;

    if (pic != null && pic.path != null && pic.meta != null && pic.meta?.name != null){

      final Uint8List? _bytes = await PicMaker.cropPic(
        context: getMainContext(),
        bytes: pic.bytes,
        confirmText: Verse.transBake('phid_continue')!,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        aspectRatio: aspectRatio,
      );

      if (_bytes != null){

        _output = await PicModel.combinePicModel(
          bytes: _bytes,
          picMakerType: PicMaker.decipherPicMakerType(pic.meta!.data!['source'])!,
          compressionQuality: compressionQuality,
          assignPath: pic.path!,
          ownersIDs: pic.meta!.ownersIDs,
          name: pic.meta!.name!,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// COMPRESSION

  // --------------------
  /// TASK : TEST ME VERIFY_ME
  static Future<PicModel?> compressPic({
    required PicModel pic,
    required double compressToWidth,
    required int quality,
  }) async {
    PicModel? _output;

    final Uint8List? _bytes = await PicMaker.compressPic(
      bytes: pic.bytes,
      compressToWidth: compressToWidth,
      quality: quality,
    );

    if (_bytes != null){

      _output = pic.copyWith(
        bytes: _bytes,
      );

    }

    return _output;
  }
  // --------------------
  /*
  ///
  static Future<List<PicModel>> compressPics({
    required List<PicModel> pics,
    required double compressToWidth,
    required int quality,
  }) async {
    final List<PicModel> _output = <PicModel>[];

    if (Mapper.checkCanLoopList(pics) == true){

      for (final PicModel _pic in pics){

        final Uint8List? _bytes = await PicMaker.compressPic(
          bytes: _pic.bytes,
          compressToWidth: compressToWidth,
          quality: quality,
        );

        if (_bytes != null){

          final PicModel _updated = _pic.copyWith(
            bytes: _bytes,
          );

          _output.add(_updated);
        }

      }

    }

    return _output;
  }
   */
  // -----------------------------------------------------------------------------

  /// SLIDES CREATORS

  // --------------------
  /// TASK : TEST ME VERIFY_ME
  static Future<PicModel?> compressSlideBigPicTo({
    required PicModel? bigPic,
    required String? flyerID,
    required int? slideIndex,
    required SlidePicType type,
  }) async {
    PicModel? _output;

    if (flyerID != null && slideIndex != null && bigPic != null && bigPic.meta?.data != null){

      final Uint8List? _smallBytes = await PicMaker.compressPic(
        bytes: bigPic.bytes,
        quality: Standards.slideSmallQuality,
        compressToWidth: Standards.slideSmallWidth,
      );

      if (_smallBytes != null){

        final String? _slideID = SlideModel.generateSlideID(
          flyerID: flyerID,
          slideIndex: slideIndex,
          type: type,
        );

        final String? _slidePath = SlideModel.generateSlidePicPath(
          flyerID: flyerID,
          slideIndex: slideIndex,
          type: type,
        );

        if (_slideID != null && _slidePath != null){

          _output = await PicModel.combinePicModel(
            bytes: _smallBytes,
            picMakerType: PicMaker.decipherPicMakerType(bigPic.meta!.data!['source'])!,
            compressionQuality: getSlidePicCompressionQuality(type),
            assignPath: _slidePath,
            ownersIDs: bigPic.meta!.ownersIDs,
            name: _slideID,
          );

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getSlidePicCompressionQuality(SlidePicType type){
    switch (type){
      case SlidePicType.big: return Standards.slideBigQuality;
      case SlidePicType.med: return Standards.slideMediumQuality;
      case SlidePicType.small: return Standards.slideSmallQuality;
      case SlidePicType.back: return Standards.slideSmallQuality;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getSlidePicWidth(SlidePicType type){
    switch (type){
      case SlidePicType.big: return Standards.slideBigWidth;
      case SlidePicType.med: return Standards.slideMediumWidth;
      case SlidePicType.small: return Standards.slideSmallWidth;
      case SlidePicType.back: return Standards.slideSmallWidth;
    }
  }
  // --------------------
  /// TASK : TEST ME VERIFY_ME
  static Future<PicModel?> createSlideBackground({
    required PicModel? bigPic,
    required String? flyerID,
    required int? slideIndex,
  }) async {
    PicModel? _output;

    if (bigPic != null && bigPic.meta != null){

      final ScreenshotController? _controller = ScreenshotController();

      const double _width = 1000;
      final double _height = FlyerDim.flyerHeightByFlyerWidth(flyerBoxWidth: _width);

      // final double _posterHeight = NotePosterBox.getBoxHeight(width);

      final Uint8List? _bytes = await _controller?.captureFromWidget(
        SizedBox(
          width: _width,
          height: _height,
          child: Stack(
            children: <Widget>[

              SuperImage(
                width: _width,
                height: _height,
                pic: bigPic.bytes,
                loading: false,
              ),

              BlurLayer(
                width: _width,
                height: _height,
                borders: BorderRadius.zero,
                blurIsOn: true,
              ),

            ],
          ),
        ),
        context: getMainContext(),
        /// FINAL PIC WIDTH = VIEW WIDTH * PIXEL RATIO
        //MediaQuery.of(_context).devicePixelRatio, no need to use this
        pixelRatio: _width / _width,
        delay: const Duration(milliseconds: 200),
      );

      if (_bytes != null){

        final String? _path = SlideModel.generateSlidePicPath(
            flyerID: flyerID,
            slideIndex: slideIndex,
            type: SlidePicType.back,
        );

        final String? _slideID = SlideModel.generateSlideID(
          flyerID: flyerID,
          slideIndex: slideIndex,
          type: SlidePicType.back,
        );

        if (_path != null && _slideID != null){

          final PicModel? _pic = await PicModel.combinePicModel(
              bytes: _bytes,
              picMakerType: PicMakerType.generated,
              compressionQuality: Standards.slideSmallQuality,
              assignPath: _path,
              ownersIDs: bigPic.meta!.ownersIDs,
              name: _slideID,
          );

          if (_pic != null){
            _output = await compressPic(
              pic: _pic,
              compressToWidth: Standards.slideSmallWidth,
              quality: Standards.slideSmallQuality,
            );
          }

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
