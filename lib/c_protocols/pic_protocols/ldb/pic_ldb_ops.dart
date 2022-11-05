import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';

class PicLDBOps {
  // -----------------------------------------------------------------------------

  const PicLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE - UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertPic(PicModel picModel) async {

    if (picModel != null){

      await LDBOps.insertMap(
        docName: LDBDoc.pics,
        input: PicModel.cipherToLDB(picModel),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<PicModel> readPic(String path) async {
    PicModel _picModel;

    if (TextCheck.isEmpty(path) == false){

      final List<Map<String, dynamic>> maps = await LDBOps.readMaps(
        docName: LDBDoc.pics,
        ids: [path],
      );

      if (Mapper.checkCanLoopList(maps) == true){

        _picModel = PicModel.decipherFromLDB(maps.first);

      }

    }

    return _picModel;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> deletePic(String path) async {

    if (TextCheck.isEmpty(path) == false){
      await LDBOps.deleteMap(
          docName: LDBDoc.pics,
          objectID: path,
      );
    }

  }
  // --------------------
  ///
  static Future<void> deletePics(List<String> paths) async {

    if (Mapper.checkCanLoopList(paths) == true){

      await LDBOps.deleteMaps(
          docName: LDBDoc.pics,
          ids: paths,
      );

    }

  }
  // --------------------
  ///
  static Future<void> deleteAll() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.pics,
    );

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkExists(String path) async {

    bool _exists = false;

    if (TextCheck.isEmpty(path) == false){

      _exists = await LDBOps.checkMapExists(
          id: path,
          docName: LDBDoc.pics,
      );

    }

    return _exists;
    }
  // -----------------------------------------------------------------------------
}
