import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
/// => TAMAM
class MediaLDBOps {
  // -----------------------------------------------------------------------------

  const MediaLDBOps();

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
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> readMedia({
    String? id,
    String? path,
  }) async {
    MediaModel? _output;

    if (TextCheck.isEmpty(id) == false){
      _output = await _readMediaByID(
        id: id,
      );
    }
    else if (TextCheck.isEmpty(path) == false){
      _output = await _readMediaByPath(
        path: path,
      );
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> _readMediaByID({
    required String? id,
  }) async {
    MediaModel? _output;

    if (TextCheck.isEmpty(id) == false){

      final List<Map<String, dynamic>> maps = await LDBOps.readMaps(
        docName: LDBDoc.media,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.media),
        ids: [id!],
      );

      if (Lister.checkCanLoop(maps) == true){
        _output = MediaModel.decipherFromLDB(maps.first);
      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> _readMediaByPath({
    required String? path,
  }) async {
    MediaModel? _output;

    final String? _id = MediaModel.createID(uploadPath: path);

    if (TextCheck.isEmpty(_id) == false){

      _output = await _readMediaByID(id: _id);

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> readStolenURL({
    required String? url,
  }) async {
    MediaModel? _output;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final String? _path = StoragePath.downloads_url(url);

      if (_path != null){

        _output = await _readMediaByPath(
          path: _path,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<void> deleteMedia({
    String? id,
    String? path,
  }) async {

    if (TextCheck.isEmpty(id) == false) {
      await _deleteMediaById(id: id);
    }

    else if (TextCheck.isEmpty(path) == false) {
      await _deleteMediaByPath(path: path);
    }

  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<void> _deleteMediaById({
    required String? id,
  }) async {
    if (TextCheck.isEmpty(id) == false) {
      await LDBOps.deleteMap(
        docName: LDBDoc.media,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.media),
        objectID: id,
      );
    }
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<void> _deleteMediaByPath({
    required String? path,
  }) async {

    final String? _id = MediaModel.createID(uploadPath: path);

    if (TextCheck.isEmpty(_id) == false) {
      await _deleteMediaById(id: _id);
    }
  }
  // -------------------------------------------
  /// TASK : TEST_ME_NOW
  static Future<void> deleteMedias({
    List<String>? ids,
    List<String>? paths,
  }) async {

    if (Lister.checkCanLoop(ids) == true){
      await _deleteMediasByIDs(
        ids: ids,
      );
    }

    else if (Lister.checkCanLoop(paths) == true){
      await _deleteMediasByPaths(
        paths: paths,
      );
    }

  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<void> _deleteMediasByIDs({
    required List<String>? ids,
  }) async {

    if (Lister.checkCanLoop(ids) == true){
      await LDBOps.deleteMaps(
        docName: LDBDoc.media,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.media),
        ids: ids,
      );
    }

  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<void> _deleteMediasByPaths({
    required List<String>? paths,
  }) async {

    if (Lister.checkCanLoop(paths) == true){

      final List<String> _ids = MediaModel.createIDs(
        uploadPaths: paths!,
      );

      await _deleteMediasByIDs(
        ids: _ids,
      );

    }

  }
  // -------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAll() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.media,
    );

  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<bool> checkExists({
    String? id,
    String? path,
  }) async {

    bool _exists = false;

    if (TextCheck.isEmpty(id) == false) {
      _exists = await _checkExistsByID(id: id);
    }

    else if (TextCheck.isEmpty(path) == false) {
      _exists = await _checkExistsByPath(path: path);
    }

    return _exists;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _checkExistsByID({
    required String? id,
  }) async {

    bool _exists = false;

    if (TextCheck.isEmpty(id) == false){
      _exists = await LDBOps.checkMapExists(
        id: id,
        docName: LDBDoc.media,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.media),
      );
    }

    return _exists;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> _checkExistsByPath({
    required String? path,
  }) async {

    bool _exists = false;

    final String? _id = MediaModel.createID(uploadPath: path);

    if (TextCheck.isEmpty(_id) == false){
      _exists = await _checkExistsByID(
        id: _id,
      );
    }

    return _exists;
  }
  // -----------------------------------------------------------------------------
}
