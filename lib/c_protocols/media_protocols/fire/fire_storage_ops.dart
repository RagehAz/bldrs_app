import 'dart:typed_data';

import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class FireStorageOps {
  // -----------------------------------------------------------------------------

  const FireStorageOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> createMedia(MediaModel? media) async {

    await MediaModel.assertIsUploadable(media);

    final String? _url = await Storage.uploadBytesAndGetURL(
      bytes: media?.bytes,
      storageMetaModel: media?.meta,
    );

    if (_url == null){
      return null;
    }

    else {
      return media;
    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> readMedia({
    required String? firePathOrUrl,
  }) async {
    MediaModel? _output;

    if (ObjectCheck.objectIsFireStoragePicPath(firePathOrUrl) == true){
      _output = await _readFireStoragePath(
        path: firePathOrUrl!,
      );
    }
    else if (ObjectCheck.isAbsoluteURL(firePathOrUrl) == true){
      _output = await _readUrl(
        url: firePathOrUrl!,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> _readFireStoragePath({
    required String path,
  }) async {
    MediaModel? _output;

    if (ObjectCheck.objectIsFireStoragePicPath(path) == true){

      final MediaMetaModel? _meta = await Storage.readMetaByPath(
        path: path,
      );

      if (_meta != null){

        final Uint8List? _bytes = await Storage.readBytesByPath(
          path: path,
        );

        _output = await MediaModelCreator.fromBytes(
          bytes: _bytes,
          ownersIDs: _meta.ownersIDs,
          uploadPath: path,
          mediaOrigin: _meta.getMediaOrigin(),
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> _readUrl({
    required String url,
  }) async {
    MediaModel? _output;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final MediaMetaModel? _meta = await Storage.readMetaByURL(
        url: url,
      );

      if (_meta?.uploadPath != null){

        _output = await MediaModelCreator.fromURL(
          url: url,
          ownersIDs: _meta!.ownersIDs,
          uploadPath: _meta.uploadPath!,
        );

      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> updateMedia({
    required MediaModel? media,
  }) async {

    final MediaModel? _uploaded = await createMedia(media);

    return _uploaded;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMedia(String? path) async {
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
