import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';

class PicLDBOps {
  // -----------------------------------------------------------------------------

  const PicLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE - UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertPic(PicModel? picModel) async {

    if (picModel != null){

      await LDBOps.insertMap(
        // allowDuplicateIDs: false,
        docName: LDBDoc.pics,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pics),
        input: PicModel.cipherToLDB(picModel),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<PicModel?> readPic(String? path) async {
    PicModel? _picModel;

    if (TextCheck.isEmpty(path) == false){

      final List<Map<String, dynamic>> maps = await LDBOps.readMaps(
        docName: LDBDoc.pics,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pics),
        ids: [path!],
      );

      if (Lister.checkCanLoopList(maps) == true){
        _picModel = PicModel.decipherFromLDB(maps.first);
      }

    }

    return _picModel;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deletePic(String? path) async {
    if (TextCheck.isEmpty(path) == false) {
      await LDBOps.deleteMap(
        docName: LDBDoc.pics,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pics),
        objectID: path,
      );
    }
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> deletePics(List<String> paths) async {

    if (Lister.checkCanLoopList(paths) == true){
      await LDBOps.deleteMaps(
        docName: LDBDoc.pics,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pics),
        ids: paths,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAll() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.pics,
    );

  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkExists(String path) async {

    bool _exists = false;

    if (TextCheck.isEmpty(path) == false){

      _exists = await LDBOps.checkMapExists(
        id: path,
        docName: LDBDoc.pics,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pics),
      );

    }

    return _exists;
    }
  // -----------------------------------------------------------------------------
}
