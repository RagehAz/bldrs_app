import 'dart:typed_data';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/slide_editor_screen/z_components/slide_background/slide_blurred_background_widget.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/slide_editor_screen/z_components/slide_background/slide_colored_background_widget.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/cupertino.dart';
import 'package:screenshot/screenshot.dart';

enum SlidePicType {
  big,
  med,
  small,
  back,
}

enum SlideBackType {
  blurred,
  color,
  white,
}

class SlidePicMaker {
  // -----------------------------------------------------------------------------

  const SlidePicMaker();

  // -----------------------------------------------------------------------------

  /// SLIDES CREATORS

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> compressSlideBigPicTo({
    required MediaModel? slidePic,
    required String? flyerID,
    required int? slideIndex,
    required SlidePicType type,
  }) async {
    MediaModel? _output;

    // blog('1.compressSlideBigPicTo : flyerID $flyerID : slideIndex : $slideIndex : type : $type');

    if (flyerID != null && slideIndex != null && slidePic != null && slidePic.meta?.data != null){

      _output = await PicMaker.resizePic(
          mediaModel: slidePic,
          resizeToWidth: getSlidePicWidth(type),
      );

      _output = await PicMaker.compressPic(
        mediaModel: _output,
        quality: getSlidePicCompressionQuality(type),
      );

      // blog('2.compressSlideBigPicTo : _bytes ${_bytes?.length}');

      if (_output != null){

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

        // blog('3.compressSlideBigPicTo : _slideID $_slideID : $_slidePath');

        if (_slideID != null && _slidePath != null){

          final String? _source = slidePic.meta?.data?['source'];
          final MediaOrigin _type = _source == null ? MediaOrigin.generated
              :
          MediaModel.decipherMediaOrigin(_source) ?? MediaOrigin.generated;

          _output = await MediaModelCreator.fromXFile(
            file: _output.file,
            mediaOrigin: _type,
            uploadPath: _slidePath,
            ownersIDs: slidePic.meta!.ownersIDs,
            renameFile: _slideID,
          );

          // blog('4.compressSlideBigPicTo : _output $_output');

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
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> createSlideBackground({
    required MediaModel? bigPic,
    required String? flyerID,
    required int? slideIndex,
    required Color? overrideSolidColor,
  }) async {
    MediaModel? _output;

    final bool _shouldMakeBackground = overrideSolidColor == null;

    if (_shouldMakeBackground == true){

      if (bigPic != null && bigPic.meta != null){

        // const double _width = 1000;

        _output = await _backgroundPicCreator(
            flyerID: flyerID,
            slideIndex: slideIndex,
            ownersIDs: bigPic.meta?.ownersIDs ?? <String>[],
            widget: overrideSolidColor == null ?
            SlideBlurredBackgroundWidget(
              bigPic: bigPic,
              // width: _width,
            )
                :
            SlideColoredBackgroundWidget(
              // width:_width,
              color: overrideSolidColor,
            )
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> _backgroundPicCreator({
    required String? flyerID,
    required int? slideIndex,
    required List<String> ownersIDs,
    required Widget widget,
  }) async {
    MediaModel? _output;

    final Uint8List _bytes = await ScreenshotController().captureFromWidget(
      widget,
      context: getMainContext(),
      /// FINAL PIC WIDTH = VIEW WIDTH * PIXEL RATIO
      //MediaQuery.of(_context).devicePixelRatio, no need to use this
      pixelRatio: 1,
      delay: const Duration(milliseconds: 200),
    );

    if (_bytes.isNotEmpty == true){

      final String? _slideID = SlideModel.generateSlideID(
        flyerID: flyerID,
        slideIndex: slideIndex,
        type: SlidePicType.back,
      );

      final String? _uploadPath = SlideModel.generateSlidePicPath(
        flyerID: flyerID,
        slideIndex: slideIndex,
        type: SlidePicType.back,
      );

      if (_uploadPath != null && _slideID != null){
        _output = await MediaModelCreator.fromBytes(
          bytes: _bytes,
          mediaOrigin: MediaOrigin.generated,
          uploadPath: _uploadPath,
          ownersIDs: ownersIDs,
          fileName: _slideID,
        );
      }

      if (_output != null){

        _output = await PicMaker.resizePic(
          mediaModel: _output,
          resizeToWidth: Standards.slideSmallWidth,
        );

        _output = await PicMaker.compressPic(
          mediaModel: _output,
          quality: Standards.slideSmallQuality,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
