import 'dart:typed_data';

import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PicStorageOps {
  // -----------------------------------------------------------------------------

  const PicStorageOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TAMAM
  static Future<PicModel> createPic({
    @required PicModel picModel,
  }) async {

    PicModel.assertIsUploadable(picModel);

    final Reference _ref = await Storage.uploadBytes(
      bytes: picModel.bytes,
      path: picModel.path,
      ownersIDs: picModel.meta.ownersIDs,
      dimensions: picModel.meta.dimensions,
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
  ///
  static Future<PicModel> readPic({
    @required String path,
  }) async {
    PicModel _picModel;

    if (TextCheck.isEmpty(path) == false){

      final Reference _ref = Storage.getRefByPath(path);
      Uint8List _bytes;
      FullMetadata _meta;
      List<String> _owners;

      await tryAndCatch(
          functions: () async {

            await Future.wait(<Future>[

              /// 10'485'760 default max size
              _ref.getData().then((Uint8List ints){
                _bytes = ints;
              }),

              _ref.getMetadata().then((FullMetadata metadata){
                _meta = metadata;

              }),

            ]);

          },
      );

      if (Mapper.checkCanLoopList(_bytes) == true){

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
  ///
  static Future<PicModel> updatePic() async {}
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<PicModel> deletePic() async {}
  // --------------------
  ///
  static Future<PicModel> deletePics() async {}
  // --------------------
}
