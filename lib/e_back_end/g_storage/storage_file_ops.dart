import 'dart:io';
import 'dart:typed_data';

import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/e_back_end/g_storage/storage_ref.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageFileOps {
  // -----------------------------------------------------------------------------

  const StorageFileOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> uploadFileAndGetURL({
    @required File file,
    @required String storageCollName,
    @required String docName,
    @required List<String> ownersIDs,
    Map<String, String> metaDataAddOn,
  }) async {

    blog('uploadFile : START');

    /// NOTE : RETURNS URL
    String _fileURL;

    await tryAndCatch(
        invoker: 'uploadFile',
        functions: () async {

          /// GET REF
          final Reference _ref = StorageRef.byNodes(
            collName: storageCollName,
            docName: docName,
          );

          blog('uploadFile : 1 - got ref : $_ref');

          final SettableMetadata metaData = PicMetaModel(
            ownersIDs: ownersIDs,
            dimensions: await Dimensions.superDimensions(file),
          ).toSettableMetadata(
            extraData: metaDataAddOn,
          );

          // / ASSIGN FILE OWNERS
          // Map<String, String> _metaDataMap = <String, String>{};
          // for (final String ownerID in ownersIDs) {
          //   _metaDataMap[ownerID] = 'cool';
          // }
          // /// ADD EXTENSION
          // final String _extension = Filers.getFileExtensionFromFile(file);
          // _metaDataMap['extension'] = _extension;


          // blog('uploadFile : 2 - assigned owners : _metaDataMap : $_metaDataMap');

          // /// ADD EXTRA METADATA MAP PAIRS
          // if (metaDataAddOn != null) {
          //   _metaDataMap = Mapper.mergeMaps(
          //     baseMap: _metaDataMap,
          //     insert: metaDataAddOn,
          //     replaceDuplicateKeys: true,
          //   );
          // }

          // blog('uploadFile : 3 - added extra meta data : _metaDataMap : $_metaDataMap');

          // /// FORM METADATA
          // final SettableMetadata metaData = SettableMetadata(
          //   customMetadata: _metaDataMap,
          // );

          blog('uploadFile : 2 - assigned meta data');


          final UploadTask _uploadTask = _ref.putFile(
            file,
            metaData,
          );

          blog('uploadFile : 3 - uploaded file : fileName : $docName : file.fileNameWithExtension : ${file.fileNameWithExtension}');

          final TaskSnapshot _snapshot = await _uploadTask.whenComplete((){
            blog('uploadFile : 4 - upload file completed');
          });

          blog('uploadFile : 5 - task state : ${_snapshot?.state}');

          _fileURL = await _ref.getDownloadURL();
          blog('uploadFile : 6 - got url : $_fileURL');

        });

    /*

    StreamBuilder<StorageTaskEvent>(
    stream: _uploadTask.events,
    builder: (context, snapshot) {
        if(!snapshot.hasData){
            return Text('No data');
        }
       StorageTaskSnapshot taskSnapshot = snapshot.data.snapshot;
       switch (snapshot.data.type) {
          case StorageTaskEventType.failure:
              return Text('Failure');
              break;
          case StorageTaskEventType.progress:
              return CircularProgressIndicator(
                     value : taskSnapshot.bytesTransferred
                             /taskSnapshot.totalByteCount);
              break;
          case StorageTaskEventType.pause:
              return Text('Pause');
              break;
          case StorageTaskEventType.success:
              return Text('Success');
              break;
          case StorageTaskEventType.resume:
              return Text('Resume');
              break;
          default:
              return Text('Default');
       }
    },
)

// -----------------------------------------------------

ButtonBar(
   alignment: MainAxisAlignment.center,
   children: <Widget>[
       IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: (){
               // to resume the upload
               _uploadTask.resume();
          },
       ),
       IconButton(
          icon: Icon(Icons.cancel),
          onPressed: (){
               // to cancel the upload
               _uploadTask.cancel();
          },
       ),
       IconButton(
          icon: Icon(Icons.pause),
          onPressed: (){
              // to pause the upload
              _uploadTask.pause();
          },
       ),
   ],
)

https://medium.com/@debnathakash8/firebase-cloud-storage-with-flutter-aad7de6c4314

     */

    blog('uploadFile : END');
    return _fileURL;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File> downloadFileByURL({
    @required String url,
  }) async {
    File _file;

    if (url != null) {

      final Reference _ref = await StorageRef.byURL(
        url: url,
      );

      if (_ref != null) {

        final Uint8List _uInts = await _ref.getData();

        _file = await Filers.getFileFromUint8List(
          uInt8List: _uInts,
          fileName: _ref.name,
        );

      }
    }

    return _file;
  }
  // --------------------
  ///
  static Future<File> downloadFileByNodes({
    @required String storageCollName,
    @required String docName,
  }) async {
    File _file;

    // final String _url = await readStoragePicURL(
    //     context: context,
    //     docName: docName,
    //     picName: picName
    // );
    // if (_url != null){
    //   _file = await getFileFromPicURL(context: context, url: _url);
    //
    //
    //
    // }

    final Reference _ref = StorageRef.byNodes(
      collName: storageCollName,
      docName: docName,
    );


    if (_ref != null) {
      final Uint8List _uInts = await _ref.getData();

      _file = await Filers.getFileFromUint8List(
          uInt8List: _uInts,
          fileName: _ref.name
      );
    }

    return _file;
  }
  // --------------------
  ///


  // -----------------------------------------------------------------------------
  void fuck(){}
}
