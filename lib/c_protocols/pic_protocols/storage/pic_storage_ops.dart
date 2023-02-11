import 'dart:typed_data';

import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:filers/filers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
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

    final Reference _ref = await Storage.uploadBytes(
      bytes: picModel.bytes,
      path: picModel.path,
      metaData: picModel.meta.toSettableMetadata(),
    );

    if (_ref == null){
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

      final Uint8List _bytes = await Storage.readBytesByPath(
        path: path,
      );

      if (Mapper.checkCanLoopList(_bytes) == true){

        final FullMetadata _meta = await Storage.readMetaByPath(
          path: path,
        );

        _picModel = PicModel(
          path: path,
          bytes: _bytes,
          meta: PicMetaModel.decipherFullMetaData(
              fullMetadata: _meta,
          ),
        );

      }

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
    );

    blog('deletePic : END');
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> deletePics(List<String> paths) async {

    if (Mapper.checkCanLoopList(paths) == true){

      await Storage.deleteDocs(
        paths: paths,
      );

    }

  }
  // --------------------
}
