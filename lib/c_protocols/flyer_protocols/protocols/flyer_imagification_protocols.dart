import 'dart:ui' as ui;

import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage_paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';


class ImagifyFlyerProtocols {
  // -----------------------------------------------------------------------------

  const ImagifyFlyerProtocols();

  // -----------------------------------------------------------------------------

  /// IMAGIFY SLIDES

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> imagifyFirstSlide(FlyerModel flyerModel) async {
    FlyerModel _output;

    if (flyerModel != null){

      _output = flyerModel;

      if (Mapper.checkCanLoopList(flyerModel.slides) == true){

        SlideModel _firstSlide = flyerModel.slides[0];

        if (ObjectCheck.objectIsUiImage(_firstSlide.picPath) == false){
          final ui.Image _image = await PicProtocols.fetchPicUiImage(_firstSlide.picPath); // is path
          _firstSlide = _firstSlide.copyWith(
            uiImage: _image,
          );
        }

        final List<SlideModel> _slides = <SlideModel>[...flyerModel.slides];

        _slides.removeAt(0);
        _slides.insert(0, _firstSlide);

        _output = flyerModel.copyWith(
          slides: _slides,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> imagifySlides(FlyerModel flyerModel) async {
    FlyerModel _output;

    if (flyerModel != null){

      _output = flyerModel;

      if (Mapper.checkCanLoopList(flyerModel.slides) == true){

        final List<SlideModel> _flyerSlides = <SlideModel>[];

        for (int i = 0; i < flyerModel.slides.length; i++){

          final SlideModel _slide = flyerModel.slides[i];

          /// UI IMAGE IS MISSING
          if (_slide.uiImage == null){

            final ui.Image _image = await PicProtocols.fetchPicUiImage(_slide.picPath); // is path
            final SlideModel _updatedSlide = _slide.copyWith(
              uiImage: _image,
            );

            _flyerSlides.add(_updatedSlide);
          }

          /// UI IMAGE IS DEFINED
          else {

            _flyerSlides.add(_slide);

          }

        }

        _output = flyerModel.copyWith(
          slides: _flyerSlides,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// IMAGIFY LOGO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> imagifyBzLogo(FlyerModel flyerModel) async {
    FlyerModel _output = flyerModel;

    if (flyerModel != null){

      assert(flyerModel.bzID != null, 'bz ID is null');

      if (ObjectCheck.objectIsUiImage(flyerModel.bzLogoImage) == false){

        final ui.Image _logoImage = await PicProtocols.fetchPicUiImage(
            StorageColl.getBzLogoPath(flyerModel.bzID)
        );

        _output = flyerModel.copyWith(
          bzLogoImage: _logoImage,
        );

      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// IMAGIFY AUTHOR PIC

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> imagifyAuthorPic(FlyerModel flyerModel) async {
    FlyerModel _output = flyerModel;

    if (flyerModel != null){

      assert(flyerModel.bzID != null, 'bz ID is null');

      if (ObjectCheck.objectIsUiImage(flyerModel.authorImage) == false){

        final ui.Image _authorImage = await PicProtocols.fetchPicUiImage(
            StorageColl.getAuthorPicPath(
              authorID: flyerModel.authorID,
              bzID: flyerModel.bzID,
            )
        );

        _output = flyerModel.copyWith(
          authorImage: _authorImage,
        );

      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
