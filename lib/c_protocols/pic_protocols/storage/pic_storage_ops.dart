import 'dart:typed_data';
import 'package:basics/filing/filing.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
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
    required String? path,
  }) async {
    MediaModel? _picModel;

    if (TextCheck.isEmpty(path) == false){

      final bool _pathIsURL = ObjectCheck.isAbsoluteURL(path);
      Uint8List? _bytes;
      MediaMetaModel? _meta;

      /// GET BYTES
      if (_pathIsURL == true){
        _bytes = await Byter.fromURL(path);
      }
      else {
        _bytes = await Storage.readBytesByPath(
          path: path,
        );
      }

      if (Lister.checkCanLoop(_bytes) == true){

        /// GET META DATA
        if (_pathIsURL == false){
          _meta = await Storage.readMetaByPath(
            path: path,
          );
        }

        else if (_pathIsURL == true){
          _meta = await Storage.readMetaByURL(
            url: path,
          );
        }

        _picModel = await MediaModelCreator.fromBytes(
          bytes: _bytes,
          fileName: _meta?.name,
          uploadPath: _meta?.uploadPath,
          ownersIDs: _meta?.ownersIDs,
          mediaOrigin: _meta?.getMediaOrigin(),
        );

      }

    }

    return _picModel;
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
