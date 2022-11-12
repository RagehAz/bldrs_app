import 'dart:typed_data';

import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/g_storage/foundation/storage_ref.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PicStorageOps {
  // -----------------------------------------------------------------------------

  const PicStorageOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<PicModel> createPic(PicModel picModel,) async {

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
  /// TASK : TEST ME
  static Future<PicModel> readPic({
    @required String path,
  }) async {
    PicModel _picModel;

    if (TextCheck.isEmpty(path) == false){

      final Reference _ref = StorageRef.getRefByPath(path);
      Uint8List _bytes;
      FullMetadata _meta;

      try {

        blog('getting meta data for path : $path');

        _meta = await _ref.getMetadata();

        if (_meta != null){

          /// 10'485'760 default max size
          _bytes = await _ref.getData();

        }


      }

      on firebase_core.FirebaseException catch (error){

        blog('the storage error : $error');

      }


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

    blog('Picccc : readPic : _picModel : $_picModel');
    
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

    final bool _canDelete = await checkCanDeleteStorageFile(
      path: path,
    );

    if (_canDelete == true){

      final dynamic _result = await tryCatchAndReturnBool(
          invoker: 'deletePic',
          functions: () async {

            final Reference _picRef = StorageRef.getRefByPath(path);

            await _picRef?.delete();
          },
          onError: (String error) async {

            const String _noImageError = '[firebase_storage/object-not-found] No object exists at the desired reference.';
            if (error == _noImageError){
              blog('deletePic : NOT FOUND AND NOTHING IS DELETED : path $path');
            }
            else {
              blog('deletePic : $path: error : $error');
            }

          }
      );

      /// if result is true
      if (_result == true) {
        blog('deletePic : IMAGE HAS BEEN DELETED :docName $path');
      }

      // else {
      //
      // }

    }

    else {
      blog('deletePic : CAN NOT DELETE STORAGE FILE');
    }


    blog('deletePic : END');

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> deletePics(List<String> paths) async {

    if (Mapper.checkCanLoopList(paths) == true){

      await Future.wait(<Future>[

        ...List.generate(paths.length, (index){
          return deletePic(paths[index]);
      }),

      ]);

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<bool> checkCanDeleteStorageFile({
    @required String path,
  }) async {

    assert(path != null, 'path is null');

    bool _canDelete = false;

    blog('checkCanDeleteStorageFile : START');

    if (path != null){

      final List<String> _ownersIDs = await Storage.readOwnersIDsByPath(
        path: path,
      );

      blog('checkCanDeleteStorageFile : _ownersIDs : $_ownersIDs');

      if (Mapper.checkCanLoopList(_ownersIDs) == true){

        _canDelete = Stringer.checkStringsContainString(
          strings: _ownersIDs,
          string: AuthFireOps.superUserID(),
        );

        blog('checkCanDeleteStorageFile : _canDelete : $_canDelete');

      }

    }


    blog('checkCanDeleteStorageFile : END');
    return _canDelete;
  }
  // --------------------
}
