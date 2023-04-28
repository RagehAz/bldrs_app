import 'dart:typed_data';

import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:mediators/mediators.dart';
import 'package:stringer/stringer.dart';

class PicStorageOps {
  // -----------------------------------------------------------------------------

  const PicStorageOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<PicModel> createPic(PicModel picModel) async {

    PicModel.assertIsUploadable(picModel);

    final String _url = await Storage.uploadBytesAndGetURL(
      bytes: picModel.bytes,
      path: picModel.path,
      storageMetaModel: picModel.meta,
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
  static Future<PicModel> readPic({
    @required String path,
  }) async {
    PicModel _picModel;

    if (TextCheck.isEmpty(path) == false){

      final bool _pathIsURL = ObjectCheck.isAbsoluteURL(path);
      Uint8List _bytes;
      StorageMetaModel _meta;

      /// GET BYTES
      if (_pathIsURL == true){
        _bytes = await Floaters.getUint8ListFromURL(path);
      }
      else {
        _bytes = await Storage.readBytesByPath(
          path: path,
        );
      }

      /// GET META DATA
      if (Mapper.checkCanLoopList(_bytes) == true && _pathIsURL == false){
        _meta = await Storage.readMetaByPath(
          path: path,
        );
      }
      else if (_pathIsURL == true){
      final Dimensions _dims = await Dimensions.superDimensions(_bytes);
      final double _mega = Filers.calculateSize(_bytes.length, FileSizeUnit.megaByte);
        _meta = StorageMetaModel(
          ownersIDs: const ['non'],
          name: path,
          height: _dims.height,
          width: _dims.width,
          sizeMB: _mega,
        );
      }

      _picModel = PicModel(
          path: path,
          bytes: _bytes,
          meta: _meta,
        );

    }

    return _picModel;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TASK : TEST ME
  static Future<PicModel> updatePic({
    @required PicModel picModel,
  }) async {

    final PicModel _uploaded = await createPic(picModel);

    return _uploaded;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST ME
  static Future<void> deletePic(String path) async {
    blog('deletePic : START');

    await Storage.deleteDoc(
      path: path,
      currentUserID: Authing.getUserID(),
    );

    blog('deletePic : END');
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> deletePics(List<String> paths) async {

    if (Mapper.checkCanLoopList(paths) == true){

      await Storage.deleteDocs(
        paths: paths,
        currentUserID: Authing.getUserID(),
      );

    }

  }
  // --------------------
}
