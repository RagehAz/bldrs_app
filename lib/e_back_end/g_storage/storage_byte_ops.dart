import 'dart:typed_data';

import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/e_back_end/g_storage/storage_ref.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageByteOps {
  // -----------------------------------------------------------------------------

  const StorageByteOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TAMAM
  static Future<Reference> uploadBytes({
    @required Uint8List bytes,
    @required String path,
    @required SettableMetadata metaData,
  }) async {

    assert(Mapper.checkCanLoopList(bytes) == true, 'uInt7List is empty or null');
    assert(metaData != null, 'metaData is null');
    assert(TextCheck.isEmpty(path) == false, 'path is empty or null');

    Reference _output;

    await tryAndCatch(
        methodName: 'createDocByUint8List',
        functions: () async {

          final Reference _ref = StorageRef.byPath(path);

          blog('createDocByUint8List : 1 - got ref : $_ref');

          final UploadTask _uploadTask = _ref.putData(
            bytes,
            metaData,
          );

          blog('createDocByUint8List : 2 - uploaded uInt8List to path : $path');


          await Future.wait(<Future>[

            _uploadTask.whenComplete((){
              blog('createDocByUint8List : 3 - uploaded successfully');
              _output = _ref;
            }),

            _uploadTask.onError((error, stackTrace){
              blog('createDocByUint8List : 3 - failed to upload');
              blog('error : ${error.runtimeType} : $error');
              blog('stackTrace : ${stackTrace.runtimeType} : $stackTrace');
              return error;
            }),

          ]);


        });

    blog('createDocByUint8List : 4 - END');

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  ///
  static Future<Uint8List> readBytes({
    @required String path,
  }) async {
    Uint8List _output;

    if (TextCheck.isEmpty(path) == false){



    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///

  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
///

// -----------------------------------------------------------------------------
}
