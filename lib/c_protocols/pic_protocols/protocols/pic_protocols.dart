import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/c_protocols/pic_protocols/ldb/pic_ldb_ops.dart';
import 'package:bldrs/c_protocols/pic_protocols/storage/pic_storage_ops.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'dart:ui' as ui;

class PicProtocols {
  // -----------------------------------------------------------------------------

  const PicProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  ///
  static Future<void> composePic(PicModel picModel) async {

    if (picModel != null){

      await Future.wait(<Future>[

        PicStorageOps.createPic(picModel,),

        PicLDBOps.insertPic(picModel),

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
  /// TESTED : WORKS PERFECT
  static Future<ui.Image> fetchPicUiImage(String path) async {
    final PicModel _picModel = await PicProtocols.fetchPic(path);
    final ui.Image _theImage = await Floaters.getUiImageFromUint8List(_picModel.bytes);
    return _theImage;
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
  ///
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

  /// UPDATE

  // --------------------
  ///
  static Future<void> renovatePic(PicModel picModel) async {

    if (picModel != null){

      await composePic(picModel);

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> wipePic(String path) async {

    if (TextCheck.isEmpty(path) == false){

      await Future.wait(<Future>[

        PicLDBOps.deletePic(path),

        PicStorageOps.deletePic(path),

      ]);

    }

  }
  // --------------------
  ///
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
