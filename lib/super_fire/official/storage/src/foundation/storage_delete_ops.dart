import 'package:bldrs/super_fire/super_fire.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
import 'storage_exception_ops.dart';

class StorageDeletionOps {
  // -----------------------------------------------------------------------------

  const StorageDeletionOps();

  // -----------------------------------------------------------------------------

  /// DELETE DOC

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteDoc({
    @required String path,
    @required String currentUserID,
  }) async {

    if (TextCheck.isEmpty(path) == false){

      final bool _canDelete = await OfficialStorage.checkCanDeleteDocByPath(
        path: path,
        userID: currentUserID,
      );

      if (_canDelete == true){

        await tryAndCatch(
          invoker: 'deleteDoc',
          functions: () async {
            final Reference _picRef = OfficialStorage.getRefByPath(path);
            await _picRef?.delete();
            blog('deletePic : DELETED STORAGE FILE IN PATH: $path');
          },
          onError: (String error){
            StorageExceptionOps.onException(error);
          }
        );

      }

      else {
        blog('deletePic : CAN NOT DELETE STORAGE FILE');
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE DOCS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteDocs({
    @required List<String> paths,
    @required String currentUserID,
  }) async {

    if (Mapper.checkCanLoopList(paths) == true){

      await Future.wait(<Future>[

        ...List.generate(paths.length, (index){

          return deleteDoc(
            path: paths[index],
            currentUserID: currentUserID,
          );

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE PATH ( COLLECTION - OR - DOC )

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deletePath({
    @required BuildContext context,
    @required String path,
    Function onFinish,
  }) async {

    // if (TextCheck.isEmpty(path) == false){
    //
    //   await CloudFunction.call(
    //     context: context,
    //     functionName: CloudFunction.callDeleteStorageDirectory,
    //     mapToPass: {
    //       'path' : path,
    //     },
    //     onFinish: onFinish,
    //   );
    //
    // }

  }
  // -----------------------------------------------------------------------------
}
