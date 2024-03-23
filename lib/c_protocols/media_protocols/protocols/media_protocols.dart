import 'dart:ui' as ui;
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/slide_pic_maker.dart';
import 'package:bldrs/c_protocols/media_protocols/ldb/media_ldb_ops.dart';
import 'package:bldrs/c_protocols/media_protocols/fire/fire_storage_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';

/// => TAMAM
class MediaProtocols {
  // -----------------------------------------------------------------------------

  const MediaProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeMedia(MediaModel? media) async {

    if (media != null){

      await Future.wait(<Future>[

        FireStorageOps.createMedia(media),

        MediaLDBOps.insertMedia(media: media),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeMedias(List<MediaModel> medias) async {

    if (Lister.checkCanLoop(medias) == true){

      await Future.wait(<Future>[

        ...List.generate(medias.length, (index){

          return composeMedia(medias[index]);

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// FETCH PICS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fetchMedia(String? path) async {

    MediaModel? _picModel = await MediaLDBOps.readMediaByFireStoragePath(
      path: path,
    );

    if (_picModel == null){

      _picModel = await FireStorageOps.readMedia(firePathOrUrl: path);

      if (_picModel != null){

        await MediaLDBOps.insertMedia(
          media: _picModel,
        );
      }

    }

    return _picModel;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> fetchMedias(List<String>? paths) async {
    final List<MediaModel> _output = <MediaModel>[];

    if (Lister.checkCanLoop(paths) == true){

      await Future.wait(<Future>[

        ...List.generate(paths!.length, (index){

          return fetchMedia(paths[index]).then((MediaModel? pic){

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

      final MediaModel? _picModel = await MediaProtocols.fetchMedia(path);

      _theImage = await Imager.getUiImageFromSuperFile(_picModel?.file);

    }

    return _theImage;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> refetchMedia(List<String> paths) async {

    List<MediaModel> _output = <MediaModel>[];

    if (Lister.checkCanLoop(paths) == true){

      await MediaLDBOps.deleteMediasByFireStoragePaths(
        paths: paths,
      );

      _output = await fetchMedias(paths);

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

    return fetchMedia(_path);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> fetchFlyerPoster({
    required String? flyerID,
  }) async {
    MediaModel? _output;

    final String? _path = StoragePath.flyers_flyerID_poster(flyerID);

    if (_path != null){
      _output = await fetchMedia(_path);
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
      _output = await MediaProtocols.fetchMedias(_slidesPicsPaths);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DOWNLOAD

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> downloadMedia(String path) async {

    if (TextCheck.isEmpty(path) == false){

      final bool _existsInLDB = await MediaLDBOps.checkExistsByFireStoragePath(
        path: path,
      );

      if (_existsInLDB == false){

        // blog('downloadPic : Downloading pic : $path');

        final MediaModel? _picModel = await FireStorageOps.readMedia(firePathOrUrl: path);

        // blog('downloadPic : Downloaded pic : $path');

        await MediaLDBOps.insertMedia(media: _picModel);

        // blog('downloadPic : inserted in LDB : $path');

      }
      else {
        blog('downloadPic : ---> already downloaded : $path');
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> downloadMedias(List<String> paths) async {

    if (Lister.checkCanLoop(paths) == true){

      await Future.wait(<Future>[

        ...List.generate(paths.length, (index){

          final String path = paths[index];

          return downloadMedia(path);

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateMedia({
    required MediaModel? newMedia,
    /// USE THIS IN CASE YOU WANT TO WIPE THE OLD PATH BEFORE INSERTING A NEW WITH DIFFERENT PATH
    required MediaModel? oldMedia,
  }) async {

    // blog('1 - renovatePic : picModel : $picModel');

    if (newMedia != null){

      final bool _areIdentical = await MediaModel.checkMediaModelsAreIdentical(
        model1: oldMedia,
        model2: newMedia,
      );

      // blog('2 - renovate.Pic : _areIdentical : $_areIdentical');

      if (_areIdentical == false){

        await wipeMedia(oldMedia?.meta?.uploadPath);

        await composeMedia(newMedia);

      }

    }

      // blog('3 - .done');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateMedias(List<MediaModel> medias) async {

    if (Lister.checkCanLoop(medias) == true){

      await Future.wait(<Future>[

        ...List.generate(medias.length, (index){
          return renovateMedia(
            newMedia: medias[index],
            oldMedia: null,
          );
        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeMedia(String? path) async {

    if (TextCheck.isEmpty(path) == false){

      await Future.wait(<Future>[

        MediaLDBOps.deleteMediaByFireStoragePath(
          path: path,
        ),

        FireStorageOps.deleteMedia(path!),

        XFiler.deleteFileByName(
          name: FilePathing.createFileNameFromFireStoragePath(fireStoragePath: path),
        ),

      ]);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeMedias(List<String> paths) async {

    if (Lister.checkCanLoop(paths) == true){

      await Future.wait(<Future>[

        MediaLDBOps.deleteMediasByFireStoragePaths(
          paths: paths
        ),

        FireStorageOps.deletePics(paths),

        XFiler.deleteFiledByNames(
          names: FilePathing.createFilesNamesFromFireStoragePaths(paths: paths),
        ),

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
    required String fileName,
    required String uploadPath,
  }) async {
    MediaModel? _output;

    if (url != null){

      _output = await MediaModelCreator.fromURL(
        url: url,
        ownersIDs: ownersIDs,
        fileName: fileName,
        uploadPath: uploadPath,
      );

      await composeMedia(_output);

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
