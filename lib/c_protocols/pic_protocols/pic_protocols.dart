import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/pic_ldb_ops.dart';
import 'package:bldrs/e_back_end/x_ops/storage_ops/pic_storage_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';

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
  ///
  static Future<PicModel> fetchPic(String path) async {

    PicModel _picModel = await PicLDBOps.readPic(path);


    if (_picModel == null){

      _picModel = await PicStorageOps.readPic(path: path);

      await PicLDBOps.insertPic(_picModel);

    }

    return _picModel;

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
