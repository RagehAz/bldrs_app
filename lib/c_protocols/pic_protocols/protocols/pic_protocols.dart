import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_ui/ui_image_cache_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/pic_protocols/ldb/pic_ldb_ops.dart';
import 'package:bldrs/c_protocols/pic_protocols/storage/pic_storage_ops.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:mapper/mapper.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class PicProtocols {
  // -----------------------------------------------------------------------------

  const PicProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composePic(PicModel picModel) async {

    if (picModel != null){

      await Future.wait(<Future>[

        PicStorageOps.createPic(picModel,),

        PicLDBOps.insertPic(picModel),

      ]);

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> composePics(List<PicModel> pics) async {

    if (Mapper.checkCanLoopList(pics) == true){

      await Future.wait(<Future>[

        ...List.generate(pics.length, (index){

          return composePic(pics[index]);

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<PicModel> fetchPic(String path) async {

    PicModel _picModel = await PicLDBOps.readPic(path);

    if (_picModel == null){

      _picModel = await PicStorageOps.readPic(path: path);

      if (_picModel != null){
        await PicLDBOps.insertPic(_picModel);
      }

    }

    return _picModel;

  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<PicModel>> fetchPics(List<String> paths) async {
    final List<PicModel> _output = <PicModel>[];

    if (Mapper.checkCanLoopList(paths) == true){

      await Future.wait(<Future>[

        ...List.generate(paths.length, (index){

          return fetchPic(paths[index]).then((PicModel pic){

            _output.add(pic);

          });

        }),

      ]);

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<ui.Image> fetchPicUiImage({
    @required BuildContext context,
    @required String path,
  }) async {
    ui.Image _theImage;

    if (path != null){

      final Cacher _cacher = UiProvider.proGetCacher(
          context: context,
          cacherID: path,
          listen: false,
      );

      /// PIC IS PRO-CACHED
      if (_cacher != null){
        _theImage = _cacher.image;
      }

      /// PIC IS NOT PRO-CACHED
      else {

        final PicModel _picModel = await PicProtocols.fetchPic(path);
        _theImage = await Floaters.getUiImageFromUint8List(_picModel?.bytes);

        /// PRO-CACHE IF POSSIBLE
        if (_theImage != null){
          UiProvider.proStoreCacher(
              context: context,
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
  /// TASK : TEST ME
  static Future<List<PicModel>> refetchPics(List<String> paths) async {

    List<PicModel> _output = <PicModel>[];

    if (Mapper.checkCanLoopList(paths) == true){

      await PicLDBOps.deletePics(paths);

      _output = await fetchPics(paths);

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<List<PicModel>> fetchFlyerPics({
    @required FlyerModel flyerModel,
  }) async {
    List<PicModel> _output = <PicModel>[];

    if (flyerModel != null){

      final List<String> _slidesPicsPaths = SlideModel.getSlidePicsPaths(flyerModel.slides);
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

        final PicModel _picModel = await PicStorageOps.readPic(path: path);

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
  /// TASK : TEST ME
  static Future<void> downloadPics(List<String> paths) async {

    if (Mapper.checkCanLoopList(paths) == true){

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
  static Future<void> renovatePic(PicModel picModel) async {

    if (picModel != null){

      final PicModel _oldPic = await fetchPic(picModel.path);

      final bool _areIdentical = PicModel.checkPicsAreIdentical(
          pic1: _oldPic,
          pic2: picModel,
      );

      if (_areIdentical == false){

        await Future.wait(<Future>[

          PicStorageOps.updatePic(picModel: picModel),

          PicLDBOps.insertPic(picModel),

        ]);

      }

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> renovatePics(List<PicModel> picModels) async {

    if (Mapper.checkCanLoopList(picModels) == true){

      await Future.wait(<Future>[

        ...List.generate(picModels.length, (index){
          return renovatePic(picModels[index]);
        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipePic(String path) async {

    if (TextCheck.isEmpty(path) == false){

      await Future.wait(<Future>[

        PicLDBOps.deletePic(path),

        PicStorageOps.deletePic(path),

      ]);

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> wipePics(List<String> paths) async {

    if (Mapper.checkCanLoopList(paths) == true){

      await Future.wait(<Future>[

        PicLDBOps.deletePics(paths),

        PicStorageOps.deletePics(paths),

      ]);

    }

  }
  // --------------------
}
