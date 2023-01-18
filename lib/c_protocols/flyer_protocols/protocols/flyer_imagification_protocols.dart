import 'dart:ui' as ui;

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';

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
        _imagifyFirstSlide(context: context, flyerModel: flyerModel)
            .then((FlyerModel flyer){
          _output = _output.copyWith(
            slides: flyer.slides,
          );
        }),

        /// BZ LOGO
        _imagifyBzLogo(context: context, flyerModel: flyerModel)
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
        _imagifySlides(context: context, flyerModel: flyerModel)
            .then((FlyerModel flyer){
          _output = _output.copyWith(
            slides: flyer.slides,
          );
        }),

        /// BZ LOGO
        _imagifyBzLogo(context: context, flyerModel: flyerModel)
            .then((FlyerModel flyer){
          _output = _output.copyWith(
            bzLogoImage: flyer.bzLogoImage,
          );
        }),

        /// IMAGIFY AUTHOR PIC
        if (_output.showsAuthor == true)
          _imagifyAuthorPic(context: context, flyerModel: flyerModel)
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
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required bool mounted,
    @required String invoker,
  }){

    if (flyerModel != null && mounted == true){

      /// SLIDES
      if (Mapper.checkCanLoopList(flyerModel?.slides) == true){
        for (int i = 0; i < flyerModel.slides.length; i++){
          blog('disposeRenderedFlyer ($invoker) : ${flyerModel.id} => disposing flyer[$i] SLIDE '
              'IMAGE : '
              '${flyerModel.slides[i].uiImage == null ? 'null' : 'not null'}');
          // flyerModel.slides[i]?.uiImage?.dispose();
          // UiProvider.proDisposeCacher(
          //   context: context,
          //   notify: false,
          //   cacherID: flyerModel.slides[i]?.picPath,
          // );
        }
      }

      /// BZ LOGO
      blog('disposeRenderedFlyer ($invoker) : ${flyerModel.id} => disposing BZ LOGO : ${flyerModel?.bzLogoImage == null ? 'NULL' : 'NOT NULL'}');
      // flyerModel?.bzLogoImage?.dispose();
      // UiProvider.proDisposeCacher(
      //   context: context,
      //   notify: false,
      //   cacherID: Storage.generateBzLogoPath(flyerModel.bzID),
      // );

      /// AUTHOR PIC
      blog('disposeRenderedFlyer ($invoker) : ${flyerModel.id} => disposing AUTHOR PIC : ${flyerModel?.authorImage == null ? 'NULL' : 'NOT NULL'}');
      // flyerModel?.authorImage?.dispose();
      // UiProvider.proDisposeCacher(
      //   context: context,
      //   notify: false,
      //   cacherID: Storage.generateAuthorPicPath(
      //     authorID: flyerModel.authorID,
      //     bzID: flyerModel.bzID,
      //   ),
      // );

    }

  }
  // -----------------------------------------------------------------------------

  /// IMAGIFY SLIDES

  // --------------------
  /// TASK : TEST ME
  static Future<FlyerModel> _imagifyFirstSlide({
    @required FlyerModel flyerModel,
    @required BuildContext context,
  }) async {
    FlyerModel _output;

    if (flyerModel != null){

      _output = flyerModel;

      if (Mapper.checkCanLoopList(flyerModel.slides) == true){

        SlideModel _firstSlide = flyerModel.slides[0];

        if (_firstSlide.uiImage == null){

          final ui.Image _image = await PicProtocols.fetchPicUiImage(
            context: context,
            path: _firstSlide.picPath,
          );

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
  static Future<FlyerModel> _imagifySlides({
    @required BuildContext context,
    @required FlyerModel flyerModel,
  }) async {
    FlyerModel _output;

    if (flyerModel != null){

      _output = flyerModel;

      if (Mapper.checkCanLoopList(flyerModel.slides) == true){

        final List<SlideModel> _flyerSlides = <SlideModel>[];

        for (int i = 0; i < flyerModel.slides.length; i++){

          final SlideModel _slide = flyerModel.slides[i];

          /// UI IMAGE IS MISSING
          if (_slide.uiImage == null){

            final ui.Image _image = await PicProtocols.fetchPicUiImage(
              context: context,
              path: _slide.picPath,
            );

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
  static Future<FlyerModel> _imagifyBzLogo({
    @required BuildContext context,
    @required FlyerModel flyerModel,
  }) async {
    FlyerModel _output = flyerModel;

    if (flyerModel != null){

      assert(flyerModel.bzID != null, 'bz ID is null');

      if (flyerModel.bzLogoImage == null){

        final ui.Image _logoImage = await PicProtocols.fetchPicUiImage(
          path: Storage.generateBzLogoPath(flyerModel.bzID),
          context: context,
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
  static Future<FlyerModel> _imagifyAuthorPic({
    @required BuildContext context,
    @required FlyerModel flyerModel,
  }) async {
    FlyerModel _output = flyerModel;

    if (flyerModel != null){

      assert(flyerModel.bzID != null, 'bz ID is null');

      if (flyerModel.authorImage == null){

        final ui.Image _authorImage = await PicProtocols.fetchPicUiImage(
          context: context,
          path: Storage.generateAuthorPicPath(
            authorID: flyerModel.authorID,
            bzID: flyerModel.bzID,
          ),
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
