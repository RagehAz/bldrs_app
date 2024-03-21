import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
/// => TAMAM
class PicLDBOps {
  // -----------------------------------------------------------------------------

  const PicLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE - UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertMedia({
    required MediaModel? media,
  }) async {

    if (media != null){

      await LDBOps.insertMap(
        // allowDuplicateIDs: false,
        docName: LDBDoc.media,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.media),
        input: MediaModel.cipherToLDB(media),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> readMedia({
    required String? fileName,
  }) async {
    MediaModel? _picModel;

    if (TextCheck.isEmpty(fileName) == false){

      final List<Map<String, dynamic>> maps = await LDBOps.readMaps(
        docName: LDBDoc.media,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.media),
        ids: [fileName!],
      );

      if (Lister.checkCanLoop(maps) == true){
        _picModel = MediaModel.decipherFromLDB(maps.first);
      }

    }

    return _picModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> readMediaByFireStoragePath({
    required String? path,
  }) async {

    final String? _fileName = FilePathing.createFileNameFromFireStoragePath(
      fireStoragePath: path,
    );

    return readMedia(
      fileName: _fileName,
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _deleteMedia({
    required String? fileName,
  }) async {
    if (TextCheck.isEmpty(fileName) == false) {
      await LDBOps.deleteMap(
        docName: LDBDoc.media,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.media),
        objectID: fileName,
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMediaByFireStoragePath({
    required String? path,
  }) async {

    final String? _fileName = FilePathing.createFileNameFromFireStoragePath(
        fireStoragePath: path,
    );

    await _deleteMedia(
      fileName: _fileName,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _deleteMedias({
    required List<String> filesNames,
  }) async {

    if (Lister.checkCanLoop(filesNames) == true){
      await LDBOps.deleteMaps(
        docName: LDBDoc.media,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.media),
        ids: filesNames,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMediasByFireStoragePaths({
    required List<String> paths,
  }) async {

    final List<String> _filesNames = FilePathing.createFilesNamesFromFireStoragePaths(
      paths: paths,
    );

    await _deleteMedias(
      filesNames: _filesNames,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAll() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.media,
    );

  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkExists({
    required String? fileName,
  }) async {

    bool _exists = false;

    if (TextCheck.isEmpty(fileName) == false){

      _exists = await LDBOps.checkMapExists(
        id: fileName,
        docName: LDBDoc.media,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.media),
      );

    }

    return _exists;
    }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkExistsByFireStoragePath({
    required String? path,
  }) async {

    final String? _fileName = FilePathing.createFileNameFromFireStoragePath(
      fireStoragePath: path,
    );

    return checkExists(
      fileName: _fileName,
    );

  }
  // -----------------------------------------------------------------------------
}
