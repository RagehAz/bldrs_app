import 'dart:typed_data';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:basics/mediator/models/media_meta_model.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class PicStorageOps {
  // -----------------------------------------------------------------------------

  const PicStorageOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> createPic(MediaModel? picModel) async {

    await MediaModel.assertIsUploadable(picModel);

    final String? _url = await Storage.uploadBytesAndGetURL(
      bytes: await picModel?.getBytes(),
      storageMetaModel: picModel?.meta,
    );

    if (_url == null){
      return null;
    }

    else {
      return picModel;
    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> readPic({
    required String? firePathOrUrl,
  }) async {
    MediaModel? _picModel;

    if (ObjectCheck.objectIsFireStoragePicPath(firePathOrUrl) == true){
      _picModel = await _readFireStoragePath(
        path: firePathOrUrl!,
      );
    }
    else if (ObjectCheck.isAbsoluteURL(firePathOrUrl) == true){
      _picModel = await _readUrl(
        url: firePathOrUrl!,
      );
    }

    return _picModel;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> _readFireStoragePath({
    required String path,
  }) async {
    MediaModel? _output;

    if (ObjectCheck.objectIsFireStoragePicPath(path) == true){

      final MediaMetaModel? _meta = await Storage.readMetaByPath(
        path: path,
      );

      final Uint8List? _bytes = await Storage.readBytesByPath(
        path: path,
      );

      _output = await MediaModelCreator.fromBytes(
        bytes: _bytes,
        ownersIDs: _meta?.ownersIDs,
        uploadPath: _meta?.uploadPath,
        mediaOrigin: _meta?.getMediaOrigin(),
        fileName: FilePathing.createFileNameFromFireStoragePath(
          fireStoragePath: path,
        ),
      );

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST_ME_NOW
  static Future<MediaModel?> _readUrl({
    required String url,
  }) async {
    MediaModel? _output;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final MediaMetaModel? _meta = await Storage.readMetaByURL(
        url: url,
      );

      _output = await MediaModelCreator.fromURL(
        url: url,
        fileName: _meta?.name ?? TextMod.idifyString(url),
        ownersIDs: _meta?.ownersIDs,
        uploadPath: _meta?.uploadPath,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> updatePic({
    required MediaModel? picModel,
  }) async {

    final MediaModel? _uploaded = await createPic(picModel);

    return _uploaded;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deletePic(String? path) async {
    blog('deletePic : START');

    if (path != null && Authing.getUserID() != null){
      await Storage.deleteDoc(
        path: path,
        currentUserID: Authing.getUserID()!,
      );
    }

    blog('deletePic : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deletePics(List<String>? paths) async {

    if (Authing.getUserID() != null && Lister.checkCanLoop(paths) == true){

      await Storage.deleteDocs(
        paths: paths!,
        currentUserID: Authing.getUserID()!,
      );

    }

  }
  // --------------------
}
