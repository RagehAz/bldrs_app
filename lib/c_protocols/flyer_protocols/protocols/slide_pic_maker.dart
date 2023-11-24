import 'dart:typed_data';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/slide_background/slide_blurred_background_widget.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/slide_editor_screen/z_components/slide_background/slide_colored_background_widget.dart';
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
  /// TESTED : WORKS PERFECT
  static Future<PicModel?> compressSlideBigPicTo({
    required PicModel? slidePic,
    required String? flyerID,
    required int? slideIndex,
    required SlidePicType type,
  }) async {
    PicModel? _output;

    // blog('1.compressSlideBigPicTo : flyerID $flyerID : slideIndex : $slideIndex : type : $type');

    if (flyerID != null && slideIndex != null && slidePic != null && slidePic.meta?.data != null){

      Uint8List? _bytes = await PicMaker.resizePic(
          bytes: slidePic.bytes,
          resizeToWidth:getSlidePicWidth(type),
      );

      _bytes = await PicMaker.compressPic(
        bytes: _bytes,
        quality: getSlidePicCompressionQuality(type),
      );

      // blog('2.compressSlideBigPicTo : _bytes ${_bytes?.length}');

      if (_bytes != null){

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
          final PicMakerType _type = _source == null ? PicMakerType.generated
              :
          PicMaker.decipherPicMakerType(_source) ?? PicMakerType.generated;

          _output = await PicModel.combinePicModel(
            bytes: _bytes,
            picMakerType: _type,
            compressWithQuality: getSlidePicCompressionQuality(type),
            assignPath: _slidePath,
            ownersIDs: slidePic.meta!.ownersIDs,
            name: _slideID,
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
  static Future<PicModel?> createSlideBackground({
    required PicModel? bigPic,
    required String? flyerID,
    required int? slideIndex,
    required Color? overrideSolidColor,
  }) async {
    PicModel? _output;

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
  /// TESTED : WORKS PERFECT
  static Future<PicModel?> _backgroundPicCreator({
    required String? flyerID,
    required int? slideIndex,
    required List<String> ownersIDs,
    required Widget widget,
  }) async {
    PicModel? _output;

    Uint8List? _bytes = await ScreenshotController().captureFromWidget(
      widget,
      context: getMainContext(),
      /// FINAL PIC WIDTH = VIEW WIDTH * PIXEL RATIO
      //MediaQuery.of(_context).devicePixelRatio, no need to use this
      pixelRatio: 1,
      delay: const Duration(milliseconds: 200),
    );

    _bytes = await PicMaker.resizePic(
      bytes: _bytes,
      resizeToWidth: Standards.slideSmallWidth,
    );

    _bytes = await PicMaker.compressPic(
      bytes: _bytes,
      quality: Standards.slideSmallQuality,
    );

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

    if (_bytes != null && _path != null && _slideID != null){
      _output = await PicModel.combinePicModel(
        bytes: _bytes,
        picMakerType: PicMakerType.generated,
        compressWithQuality: Standards.slideSmallQuality,
        assignPath: _path,
        ownersIDs: ownersIDs,
        name: _slideID,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

}
