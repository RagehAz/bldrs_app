import 'dart:ui' as ui;

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class ImagifyFlyerProtocols {
  // -----------------------------------------------------------------------------

  const ImagifyFlyerProtocols();
  // -----------------------------------------------------------------------------

  /// SMALL FLYER IMAGIFIED

  // --------------------
  /// TASK : TEST ME
  static Future<FlyerModel> renderSmallFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
  }) async {

    FlyerModel _output = flyerModel;

    if (flyerModel != null){

      await Future.wait(<Future>[

        /// FIRST SLIDE
        _imagifyFirstSlide(flyerModel)
            .then((FlyerModel flyer){
          _output = _output.copyWith(
            slides: flyer.slides,
          );
        }),

        /// BZ LOGO
        _imagifyBzLogo(flyerModel)
            .then((FlyerModel flyer){
          _output = _output.copyWith(
            bzLogoImage: flyer.bzLogoImage,
          );
        }),

        /// BZ MODEL
        BzProtocols.fetchBz(
          context: context,
          bzID: flyerModel.bzID,
        ).then((BzModel bzModel){
          _output = _output.copyWith(
            bzModel: bzModel,
          );
        }),

      ]);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BIG FLYER IMAGIFIED

  // --------------------
  /// TASK : TEST ME
  static Future<FlyerModel> renderBigFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
  }) async {

    FlyerModel _output = flyerModel;

    if (flyerModel != null){

      await Future.wait(<Future>[

        /// FIRST SLIDE
        _imagifySlides(flyerModel)
            .then((FlyerModel flyer){
          _output = _output.copyWith(
            slides: flyer.slides,
          );
        }),

        /// BZ LOGO
        _imagifyBzLogo(flyerModel)
            .then((FlyerModel flyer){
          _output = _output.copyWith(
            bzLogoImage: flyer.bzLogoImage,
          );
        }),

        /// IMAGIFY AUTHOR PIC
        if (_output.showsAuthor == true)
          _imagifyAuthorPic(flyerModel)
              .then((FlyerModel flyer){
            _output = _output.copyWith(
              authorImage: flyer.authorImage,
            );
          }),

        /// BZ MODEL
        BzProtocols.fetchBz(
          context: context,
          bzID: flyerModel.bzID,
        ).then((BzModel bzModel){
          _output = _output.copyWith(
            bzModel: bzModel,
          );
        }),

      ]);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DISPOSING

  // --------------------
  /// TASK : TEST ME
  static void disposeRenderedFlyer({
    @required FlyerModel flyerModel,
    @required bool mounted,
  }){

    if (flyerModel != null && mounted == true){

      /// SLIDES
      if (Mapper.checkCanLoopList(flyerModel?.slides) == true){
        for (int i = 0; i < flyerModel.slides.length; i++){
          blog('disposeRenderedFlyer ${flyerModel.id} => disposing flyer[$i] SLIDE IMAGE : ${flyerModel.slides[i].uiImage == null ? 'null' : 'not null'}');
          flyerModel.slides[i]?.uiImage?.dispose();
        }
      }

      /// BZ LOGO
      blog('disposeRenderedFlyer ${flyerModel.id} => disposing BZ LOGO : ${flyerModel?.bzLogoImage == null ? 'NULL' : 'NOT NULL'}');
      flyerModel?.bzLogoImage?.dispose();

      /// AUTHOR PIC
      blog('disposeRenderedFlyer ${flyerModel.id} => disposing AUTHOR PIC : ${flyerModel?.authorImage == null ? 'NULL' : 'NOT NULL'}');
      flyerModel?.authorImage?.dispose();

    }

  }
  // -----------------------------------------------------------------------------

  /// IMAGIFY SLIDES

  // --------------------
  /// TASK : TEST ME
  static Future<FlyerModel> _imagifyFirstSlide(FlyerModel flyerModel) async {
    FlyerModel _output;

    if (flyerModel != null){

      _output = flyerModel;

      if (Mapper.checkCanLoopList(flyerModel.slides) == true){

        SlideModel _firstSlide = flyerModel.slides[0];

        if (_firstSlide.uiImage == null){

          final ui.Image _image = await PicProtocols.fetchPicUiImage(_firstSlide.picPath);
          _firstSlide = _firstSlide.copyWith(
            uiImage: _image,
          );

          final List<SlideModel> _slides = <SlideModel>[...flyerModel.slides];

          _slides.removeAt(0);
          _slides.insert(0, _firstSlide);

          _output = flyerModel.copyWith(
            slides: _slides,
          );

        }



      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> _imagifySlides(FlyerModel flyerModel) async {
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
  /// TASK : TEST ME
  static Future<FlyerModel> _imagifyBzLogo(FlyerModel flyerModel) async {
    FlyerModel _output = flyerModel;

    if (flyerModel != null){

      assert(flyerModel.bzID != null, 'bz ID is null');

      if (flyerModel.bzLogoImage == null){

        final ui.Image _logoImage = await PicProtocols.fetchPicUiImage(
            Storage.generateBzLogoPath(flyerModel.bzID)
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
  /// TASK : TEST ME
  static Future<FlyerModel> _imagifyAuthorPic(FlyerModel flyerModel) async {
    FlyerModel _output = flyerModel;

    if (flyerModel != null){

      assert(flyerModel.bzID != null, 'bz ID is null');

      if (flyerModel.authorImage == null){

        final ui.Image _authorImage = await PicProtocols.fetchPicUiImage(
            Storage.generateAuthorPicPath(
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
