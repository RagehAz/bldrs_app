import 'dart:typed_data';

import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/file_size_unit.dart';
import 'package:basics/helpers/files/filers.dart';
import 'package:basics/helpers/files/floaters.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:basics/mediator/models/file_typer.dart';
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
  /// TESTED: WORKS PERFECT
  static Future<MediaModel?> createPic(MediaModel? picModel) async {

    MediaModel.assertIsUploadable(picModel);

    final String? _url = await Storage.uploadBytesAndGetURL(
      bytes: picModel?.bytes,
      path: picModel?.path,
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
  /// TESTED : WORKS PERFECT
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
        _bytes = await Floaters.getBytesFromURL(path);
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
          final Dimensions? _dims = await Dimensions.superDimensions(_bytes);
          final double? _mega = Filers.calculateSize(_bytes?.length, FileSizeUnit.megaByte);
          _meta = MediaMetaModel(
            fileType: FileType.jpeg,
            ownersIDs: const ['non'],
            name: path,
            height: _dims?.height,
            width: _dims?.width,
            sizeMB: _mega,
          );
        }

        _picModel = MediaModel(
            path: path,
            bytes: _bytes,
            meta: _meta,
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
