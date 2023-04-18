import 'dart:typed_data';

import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:filers/filers.dart';
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

    final String _url = await OfficialStorage.uploadBytesAndGetURL(
      bytes: picModel.bytes,
      path: picModel.path,
      picMetaModel: picModel.meta,
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

      final Uint8List _bytes = await OfficialStorage.readBytesByPath(
        path: path,
      );

      if (Mapper.checkCanLoopList(_bytes) == true){

        final StorageMetaModel _meta = await OfficialStorage.readMetaByPath(
          path: path,
        );

        _picModel = PicModel(
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

    await OfficialStorage.deleteDoc(
      path: path,
      currentUserID: OfficialAuthing.getUserID(),
    );

    blog('deletePic : END');
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> deletePics(List<String> paths) async {

    if (Mapper.checkCanLoopList(paths) == true){

      await OfficialStorage.deleteDocs(
        paths: paths,
        currentUserID: OfficialAuthing.getUserID(),
      );

    }

  }
  // --------------------
}
