import 'dart:typed_data';

import 'package:filers/filers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mapper/mapper.dart';
import 'package:rest/rest.dart';
import 'package:stringer/stringer.dart';
import 'storage_exception_ops.dart';
import 'storage_ref.dart';

/// => TAMAM
class StorageByteOps {
  // -----------------------------------------------------------------------------

  const StorageByteOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
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
        invoker: 'createDocByUint8List',
        functions: () async {

          final Reference _ref = StorageRef.getRefByPath(path);

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
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> readBytesByPath({
    @required String path,
  }) async {
    Uint8List _output;

    if (TextCheck.isEmpty(path) == false){

      await tryAndCatch(
        invoker: 'readBytesByPath',
        functions: () async {
          final Reference _ref = StorageRef.getRefByPath(path);
          /// 10'485'760 default max size
          _output = await _ref.getData();
        },
        onError: (String error){
          blog('ERROR : readBytesByPath : path : $path');
          StorageExceptionOps.onException(error);
        }
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> readBytesByURL(String url) async {
    Uint8List _bytes;

    // blog('readBytesByURL : 1 - START');

    if (ObjectCheck.isAbsoluteURL(url) == true){

      /// call http.get method and pass imageUrl into it to get response.
      final http.Response _response = await Rest.get(
        rawLink: url,
        // timeout: 60,
        invoker: 'readBytesByURL',
      );

      if (_response != null && _response.statusCode == 200){

        _bytes = _response.bodyBytes;

      }

    }

    // blog('readBytesByURL : 2 - END : _bytes : ${_bytes.length} bytes');

    return _bytes;
  }
  // -----------------------------------------------------------------------------
}
