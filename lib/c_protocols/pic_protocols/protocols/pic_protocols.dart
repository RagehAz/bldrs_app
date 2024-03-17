import 'dart:ui' as ui;
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/floaters.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/mediator/models/file_typer.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:bldrs/a_models/x_ui/ui_image_cache_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/pic_protocols/ldb/pic_ldb_ops.dart';
import 'package:bldrs/c_protocols/pic_protocols/storage/pic_storage_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';

/// => TAMAM
class PicProtocols {
  // -----------------------------------------------------------------------------

  const PicProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composePic(MediaModel? picModel) async {

    if (picModel != null){

      await Future.wait(<Future>[

        PicStorageOps.createPic(picModel),

        PicLDBOps.insertPic(picModel),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composePics(List<MediaModel> pics) async {

    if (Lister.checkCanLoop(pics) == true){

      await Future.wait(<Future>[

        ...List.generate(pics.length, (index){

          return composePic(pics[index]);

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// FETCH PICS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fetchPic(String? path) async {

    MediaModel? _picModel = await PicLDBOps.readPic(path);

    if (_picModel == null){

      _picModel = await PicStorageOps.readPic(path: path);

      if (_picModel != null){
        await PicLDBOps.insertPic(_picModel);
      }

    }

    return _picModel;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> fetchPics(List<String>? paths) async {
    final List<MediaModel> _output = <MediaModel>[];

    if (Lister.checkCanLoop(paths) == true){

      await Future.wait(<Future>[

        ...List.generate(paths!.length, (index){

          return fetchPic(paths[index]).then((MediaModel? pic){

            if (pic != null){
              _output.add(pic);
            }

          });

        }),

      ]);

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ui.Image?> fetchPicUiImage({
    required String? path,
  }) async {
    ui.Image? _theImage;

    if (path != null){

      final Cacher? _cacher = UiProvider.proGetCacher(
          cacherID: path,
          listen: false,
      );

      /// PIC IS PRO-CACHED
      if (_cacher != null){
        _theImage = _cacher.image;
      }

      /// PIC IS NOT PRO-CACHED
      else {

        final MediaModel? _picModel = await PicProtocols.fetchPic(path);
        _theImage = await Floaters.getUiImageFromXFile(_picModel?.file);

        /// PRO-CACHE IF POSSIBLE
        if (_theImage != null){
          UiProvider.proStoreCacher(
              notify: false,
              cacher: Cacher(
                id: path,
                image: _theImage,
              ),
          );
        }

      }

    }

    return _theImage;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> refetchPics(List<String> paths) async {

    List<MediaModel> _output = <MediaModel>[];

    if (Lister.checkCanLoop(paths) == true){

      await PicLDBOps.deletePics(paths);

      _output = await fetchPics(paths);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// FETCH FLYER PICS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fetchSlidePic({
    required SlideModel slide,
    required SlidePicType type,
  }) async {

    final String? _path = SlideModel.generateSlidePicPath(
        flyerID: slide.flyerID,
        slideIndex: slide.slideIndex,
        type: type
    );

    return fetchPic(_path);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fetchFlyerPoster({
    required String? flyerID,
  }) async {
    MediaModel? _output;

    final String? _path = StoragePath.flyers_flyerID_poster(flyerID);

    if (_path != null){
      _output = await fetchPic(_path);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> fetchFlyersPosters({
    required List<String> flyersIDs,
  }) async {
    final List<MediaModel> _posters = [];

    if (Lister.checkCanLoop(flyersIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(flyersIDs.length, (index){

          return fetchFlyerPoster(
            flyerID: flyersIDs[index],
          ).then((MediaModel? pic){

            if (pic != null){
              _posters.add(pic);
            }

          });

        }),

      ]);

    }

    return _posters;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> fetchFlyerPics({
    required FlyerModel? flyerModel,
    required SlidePicType type,
  }) async {
    List<MediaModel> _output = <MediaModel>[];

    if (flyerModel != null){

      final List<String> _slidesPicsPaths = SlideModel.generateSlidesPicsPaths(
        slides: flyerModel.slides,
        type: type,
      );
      _output = await PicProtocols.fetchPics(_slidesPicsPaths);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DOWNLOAD

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> downloadPic(String path) async {

    if (TextCheck.isEmpty(path) == false){

      final bool _existsInLDB = await PicLDBOps.checkExists(path);

      if (_existsInLDB == false){

        blog('downloadPic : Downloading pic : $path');

        final MediaModel? _picModel = await PicStorageOps.readPic(path: path);

        blog('downloadPic : Downloaded pic : $path');

        await PicLDBOps.insertPic(_picModel);

        blog('downloadPic : inserted in LDB : $path');

      }
      else {
        blog('downloadPic : ---> already downloaded : $path');
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> downloadPics(List<String> paths) async {

    if (Lister.checkCanLoop(paths) == true){

      await Future.wait(<Future>[

        ...List.generate(paths.length, (index){

          final String path = paths[index];

          return downloadPic(path);

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovatePic({
    required MediaModel? newPic,
    /// USE THIS IN CASE YOU WANT TO WIPE THE OLD PATH BEFORE INSERTING A NEW WITH DIFFERENT PATH
    required MediaModel? oldPic,
  }) async {

    // blog('1 - renovatePic : picModel : $picModel');

    if (newPic != null){

      final bool _areIdentical = await MediaModel.checkMediaModelsAreIdentical(
        model1: oldPic,
        model2: newPic,
      );

      // blog('2 - renovate.Pic : _areIdentical : $_areIdentical');

      if (_areIdentical == false){

        await wipePic(oldPic?.meta?.uploadPath);

        await composePic(newPic);

      }

    }

      // blog('3 - .done');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovatePics(List<MediaModel> picModels) async {

    if (Lister.checkCanLoop(picModels) == true){

      await Future.wait(<Future>[

        ...List.generate(picModels.length, (index){
          return renovatePic(
            newPic: picModels[index],
            oldPic: null,
          );
        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipePic(String? path) async {

    if (TextCheck.isEmpty(path) == false){

      await Future.wait(<Future>[

        PicLDBOps.deletePic(path),

        PicStorageOps.deletePic(path!),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipePics(List<String> paths) async {

    if (Lister.checkCanLoop(paths) == true){

      await Future.wait(<Future>[

        PicLDBOps.deletePics(paths),

        PicStorageOps.deletePics(paths),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// STEALING

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> stealInternetPic({
    required String? url,
    required List<String> ownersIDs,
    required String picName,
    required String uploadPath,
  }) async {
    MediaModel? _output;

    if (url != null){

      _output = await MediaModelCreator.fromURL(
        url: url,
        fileType: FileType.jpeg, /// TASK: DETECT_FILE_TYPE
        ownersIDs: ownersIDs,
        fileName: picName,
        uploadPath: uploadPath,
      );

      await composePic(_output);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
