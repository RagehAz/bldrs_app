import 'dart:ui' as ui;
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';

class ImagifyFlyerProtocols {
  // -----------------------------------------------------------------------------

  const ImagifyFlyerProtocols();
  // -----------------------------------------------------------------------------

  /// SMALL FLYER IMAGIFIED

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel?> renderSmallFlyer({
    required FlyerModel? flyerModel,
  }) async {

    FlyerModel? _output = flyerModel;

    if (flyerModel != null){

      await Future.wait(<Future>[

        /// FIRST SLIDE
        _imagifyFirstSlide(flyerModel: flyerModel)
            .then((FlyerModel? flyer){
          _output = _output?.copyWith(
            slides: flyer?.slides,
          );
        }),

        /// BZ LOGO
        _imagifyBzLogo(flyerModel: flyerModel)
            .then((FlyerModel? flyer){
          _output = _output?.copyWith(
            bzLogoImage: flyer?.bzLogoImage,
          );
        }),

        /// BZ MODEL
        BzProtocols.fetchBz(
          bzID: flyerModel.bzID,
        ).then((BzModel? bzModel){
          _output = _output?.copyWith(
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
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel?> renderBigFlyer({
    required FlyerModel? flyerModel,
    required Function(FlyerModel flyer) onRenderEachSlide,
  }) async {

    FlyerModel? _output = flyerModel;

    if (flyerModel != null){

      await Future.wait(<Future>[

        /// FIRST SLIDE
        _imagifySlides(
          flyerModel: flyerModel,
          onRenderSlide: onRenderEachSlide,
        ).then((FlyerModel? flyer){
          _output = _output?.copyWith(
            slides: flyer?.slides,
          );
        }),

        /// BZ LOGO
        _imagifyBzLogo(flyerModel: flyerModel)
            .then((FlyerModel? flyer){
          _output = _output?.copyWith(
            bzLogoImage: flyer?.bzLogoImage,
          );
        }),

        /// IMAGIFY AUTHOR PIC
        if (Mapper.boolIsTrue(_output?.showsAuthor) == true)
          _imagifyAuthorPic(flyerModel: flyerModel)
              .then((FlyerModel? flyer){
            _output = _output?.copyWith(
              authorImage: flyer?.authorImage,
            );
          }),

        /// BZ MODEL
        BzProtocols.fetchBz(
          bzID: flyerModel.bzID,
        ).then((BzModel? bzModel){
          _output = _output?.copyWith(
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
    required FlyerModel? flyerModel,
    required bool mounted,
    required String invoker,
  }){

    /// TASK : search for traces by this searchID : DISPOSE_IMAGIFIED_FLYER_ISSUE

    if (flyerModel != null && mounted == true){

      /// SLIDES
      if (Mapper.checkCanLoopList(flyerModel.slides) == true){
        for (int i = 0; i < flyerModel.slides!.length; i++){
          blog('disposeRenderedFlyer ($invoker) : ${flyerModel.id} => disposing flyer[$i] SLIDE '
              'IMAGE : '
              '${flyerModel.slides![i].uiImage == null ? 'null' : 'not null'}');
          // flyerModel.slides[i]?.uiImage?.dispose();
          // UiProvider.proDisposeCacher(
          //   context: context,
          //   notify: false,
          //   cacherID: flyerModel.slides[i]?.picPath,
          // );
        }
      }

      /// BZ LOGO
      blog('disposeRenderedFlyer ($invoker) : ${flyerModel.id} => disposing BZ LOGO : ${flyerModel.bzLogoImage == null ? 'NULL' : 'NOT NULL'}');
      // flyerModel?.bzLogoImage?.dispose();
      // UiProvider.proDisposeCacher(
      //   context: context,
      //   notify: false,
      //   cacherID: Storage.generateBzLogoPath(flyerModel.bzID),
      // );

      /// AUTHOR PIC
      blog('disposeRenderedFlyer ($invoker) : ${flyerModel.id} => disposing AUTHOR PIC : ${flyerModel.authorImage == null ? 'NULL' : 'NOT NULL'}');
      // flyerModel?.authorImage?.dispose();
      // UiProvider.proDisposeCacher(
      //   context: context,
      //   notify: false,
      //   cacherID: BldrStorage.generateAuthorPicPath(
      //     authorID: flyerModel.authorID,
      //     bzID: flyerModel.bzID,
      //   ),
      // );

    }

  }
  // -----------------------------------------------------------------------------

  /// IMAGIFY SLIDES

  // --------------------
  /// TASK : TEST ME VERIFY_ME
  static Future<FlyerModel?> _imagifyFirstSlide({
    required FlyerModel? flyerModel,
  }) async {
    FlyerModel? _output;

    if (flyerModel != null){

      _output = flyerModel;

      if (Mapper.checkCanLoopList(flyerModel.slides) == true){

        SlideModel _firstSlide = flyerModel.slides![0];

        if (_firstSlide.uiImage == null){

          final ui.Image? _image = await PicProtocols.fetchPicUiImage(
            path: SlideModel.generateSlidePicPath(
                flyerID: flyerModel.id,
                slideIndex: 0,
                type: SlidePicType.small,
            ),
          );

          _firstSlide = _firstSlide.copyWith(
            uiImage: _image,
          );

          final List<SlideModel> _slides = <SlideModel>[...?flyerModel.slides];

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
  /// TASK : TEST ME VERIFY_ME
  static Future<FlyerModel?> _imagifySlides({
    required FlyerModel? flyerModel,
    required Function(FlyerModel flyer) onRenderSlide,
  }) async {
    FlyerModel? _output;

    if (flyerModel != null){

      _output = flyerModel;

      if (Mapper.checkCanLoopList(flyerModel.slides) == true){

        List<SlideModel> _flyerSlides = SlideModel.sortSlidesByIndexes(flyerModel.slides!);

        for (int i = 0; i < _flyerSlides.length; i++){

          SlideModel _slide = _flyerSlides[i];

          /// UI IMAGE IS MISSING
          if (_slide.uiImage == null){

            final ui.Image? _image = await PicProtocols.fetchPicUiImage(
              path: SlideModel.generateSlidePicPath(
                  flyerID: _slide.flyerID,
                  slideIndex: _slide.slideIndex,
                  type: SlidePicType.med,
              ),
            );

            _slide = _slide.copyWith(
              uiImage: _image,
            );

          }

          _flyerSlides = SlideModel.replaceSlideInSlides(
            slides: _flyerSlides,
            slide: _slide,
          );
          _output = _output!.copyWith(
            slides: _flyerSlides,
          );
          onRenderSlide(_output);

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
  static Future<FlyerModel?> _imagifyBzLogo({
    required FlyerModel? flyerModel,
  }) async {
    FlyerModel? _output = flyerModel;

    if (flyerModel != null){

      assert(flyerModel.bzID != null, 'bz ID is null');

      if (flyerModel.bzLogoImage == null){

        final ui.Image? _logoImage = await PicProtocols.fetchPicUiImage(
          path: StoragePath.bzz_bzID_logo(flyerModel.bzID),
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
  static Future<FlyerModel?> _imagifyAuthorPic({
    required FlyerModel? flyerModel,
  }) async {
    FlyerModel? _output = flyerModel;

    if (flyerModel != null){

      assert(flyerModel.bzID != null, 'bz ID is null');

      if (flyerModel.authorImage == null){

        final ui.Image? _authorImage = await PicProtocols.fetchPicUiImage(
          path: StoragePath.bzz_bzID_authorID(
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
