import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/e_back_end/g_storage/storage_ref.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMetaOps {
  /// --------------------------------------------------------------------------

  const StorageMetaOps();

  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TAMAM
  static Future<FullMetadata> getMetaByPath({
    @required String path,
  }) async {

    FullMetadata _meta;

    if (TextCheck.isEmpty(path) == false){

      await tryAndCatch(
        methodName: 'getMetaByPath',
        functions: () async {

          final Reference _ref = StorageRef.byPath(path);

          _meta = await _ref.getMetadata();

        },
      );

    }

    return _meta;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FullMetadata> getMetaByURL({
    @required String url,
  }) async {
    FullMetadata _meta;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      await tryAndCatch(
        methodName: 'getMetaByURL',
        functions: () async {

          final Reference _ref = await StorageRef.byURL(
            url: url,
          );

          _meta = await _ref.getMetadata();


        },
      );

    }

    return _meta;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FullMetadata> getMetaByNodes({
    @required String storageCollName,
    @required String docName,
  }) async {

    FullMetadata _meta;

    blog('getMetaByNodes : $storageCollName/$docName');

    if (storageCollName != null && docName != null){

      await tryAndCatch(
        methodName: 'getMetaByNodes',
        functions: () async {

          final Reference _ref = StorageRef.byNodes(
            storageDocName: storageCollName,
            fileName: docName,
          );

          _meta = await _ref?.getMetadata();

        },
      );


    }

    return _meta;
  }
// -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///

  // -----------------------------------------------------------------------------
}
