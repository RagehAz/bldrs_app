import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bldrs/controllers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/models/secondary_models/error_helpers.dart';
import 'package:bldrs/models/secondary_models/image_size.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

/// FIREBASE STORAGE METHODS
class Storage {

// =============================================================================

  /// REFERENCES

  static Reference getRef({
    @required BuildContext context,
    @required String docName,
    @required String picName,
    String fileExtension = 'jpg',
  }) {

    print('getting fire storage reference');

    final Reference _ref = FirebaseStorage.instance
        .ref()
        .child(docName)
        .child(picName + '.${fileExtension}') ?? null;

    return _ref;
  }
// ------------------------------------------------
  static Future<Reference> getRefFromURL({
  @required String url,
  @required BuildContext context,
}) async {

    Reference _ref;

    await tryAndCatch(
      context: context,
      methodName: 'getRefFromURL',
      functions: () async {

        final FirebaseStorage  _storage = FirebaseStorage.instance;
        _ref = await _storage.refFromURL(url);

      },
      onError: (String error) async {

        log(error);

        /// TASK : this is temp ,, or see how it goes
        await CenterDialog.showCenterDialog(
          context: context,
          boolDialog: false,
          title: 'Something is wrong',
          body: 'Could not get this image',
        );

    }
    );

    return _ref;
}
// -----------------------------------------------------------------------------

  /// CREATE

// ------------------------------------------------
  static Future<dynamic> uploadFile({
    @required BuildContext context,
    @required File file,
    @required String docName,
    @required String fileName,
  }) async {

    // final Reference _ref = getRef(
    //     context: context,
    //     docName: docName,
    //     picName: fileName
    // );

    // final UploadTask _uploadTask = _ref.putFile(file);

    // final TaskSnapshot _snapshot = await _uploadTask.whenComplete((){
    //
    //   print('upload completed');
    //
    // });

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

}
// ------------------------------------------------
  /// creates new pic in document name according to pic type,
  /// and overrides existing pic if already exists
  static Future<String> createStoragePicAndGetURL({
    @required BuildContext context,
    @required File inputFile,
    @required String docName,
    @required String picName,
    @required String ownerID,
  }) async {
    String _imageURL;

    await tryAndCatch(
        context: context,
        methodName: 'createStoragePicAndGetURL',
        functions: () async {

          final Reference _ref = getRef(
            context: context,
            docName: docName,
            picName: picName,
          );

          print('X1 - getting storage ref : $_ref');

          final ImageSize imageSize = await ImageSize.superImageSize(inputFile);

          print('X2 - image size is ${imageSize.height} * ${imageSize.width}');

          final SettableMetadata metaData = SettableMetadata(
              customMetadata: <String, String>{
                'width': '${imageSize.width}',
                'height': '${imageSize.height}',
                'owner' : ownerID,
              }
          );

          print('X3 - meta data assigned');

          await _ref.putFile(
            inputFile,
            metaData,
          );

          print('X4 - File has been uploaded $inputFile');

          _imageURL = await _ref.getDownloadURL();

          print('X5 - _imageURL is downloaded  $_imageURL');
        }
    );
    return _imageURL;
  }
// ------------------------------------------------
  static Future<List<String>> createStorageSlidePicsAndGetURLs({
    @required BuildContext context,
    @required List<SlideModel> slides,
    @required String flyerID,
    @required String authorID,
  }) async {

    final List<String> _picturesURLs = <String>[];

    for (SlideModel slide in slides) {

      final String _picURL = await createStoragePicAndGetURL(
        context: context,
        inputFile: slide.pic,
        picName: SlideModel.generateSlideID(flyerID, slide.slideIndex),
        docName: StorageDoc.slides,
        ownerID: authorID,
      );

      _picturesURLs.add(_picURL);

    }

    return _picturesURLs;
  }
// ------------------------------------------------
  static Future<List<String>> createMultipleStoragePicsAndGetURLs({
    @required BuildContext context,
    @required List<dynamic> pics,
    @required List<String> names,
    @required String userID,
  }) async {

    final List<String> _picsURLs = <String>[];

    if (Mapper.canLoopList(pics) && Mapper.canLoopList(names) && pics.length == names.length){

      for (int i =0; i < pics.length; i++) {

        final String _picURL = await createStoragePicAndGetURL(
          context: context,
          inputFile: pics[i],
          docName: StorageDoc.slides,
          picName: names[i],
          ownerID: userID,
        );

        _picsURLs.add(_picURL);
      }

    }

    return _picsURLs;
  }
// ------------------------------------------------
  /// TASK : createStoragePicFromAssetAndGetURL not tested properly
  static Future<String> createStoragePicFromLocalAssetAndGetURL ({
    @required BuildContext context,
    @required String asset,
    @required String fileName,
    @required String docName,
    @required String ownerID,
  }) async {
    String _url;

    final File _result = await Imagers.getFileFromLocalRasterAsset(
        context: context,
        localAsset: asset,
    );

    print('uploading $fileName pic to fireStorage in folder of $docName');

    _url = await createStoragePicAndGetURL(
      context: context,
      picName: fileName,
      docName: docName,
      inputFile: _result,
      ownerID: ownerID,
    );

    print('uploaded pic : $_url');

    return _url;
  }
// -----------------------------------------------------------------------------

  /// READ

// ------------------------------------------------
  static Future<String> readStoragePicURL({
    @required BuildContext context,
    @required String docName,
    @required String picName
  }) async {

    final Reference _ref = getRef(
      context: context,
      docName: docName,
      picName: picName,
    );

    String _url;

    await tryAndCatch(
      context: context,
      methodName: '',
      functions: () async {

        _url = await _ref.getDownloadURL();

      }
    );

    return _url;
  }
// ------------------------------------------------
  static Future<File> getFileFromPicURL({
    @required BuildContext context,
    @required String url,
  }) async {

    File _file;

    if (url != null){

      final Reference _ref = await getRefFromURL(url: url, context: context);

      if (_ref != null){
        final Uint8List _uInts = await _ref.getData();

        _file = await Imagers.getFileFromUint8List(uInt8List: _uInts, fileName: _ref.name);
      }

    }

    return _file;
  }
// ------------------------------------------------
  static Future<File> getFileByPath({
    @required BuildContext context,
    @required String docName,
    @required String picName
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

    final Reference _ref = await getRef(context: context, docName: docName, picName: picName);

    if (_ref != null){
      final Uint8List _uInts = await _ref.getData();

      _file = await Imagers.getFileFromUint8List(uInt8List: _uInts, fileName: _ref.name);
    }

    return _file;
}
// -----------------------------------------------------------------------------

  /// UPDATE

// ------------------------------------------------
  /// returns updated pic new URL
  static Future<String> updatePic({
    @required BuildContext context,
    @required String oldURL,
    @required File newPic,
  }) async {

    final Reference _ref = await getRefFromURL(url: oldURL, context: context);
    final FullMetadata _fullMeta = await _ref.getMetadata();
    final Map<String, dynamic> _existingMetaData = _fullMeta.customMetadata;

    final SettableMetadata metaData = SettableMetadata(
        customMetadata: _existingMetaData
    );

    await _ref.putFile(newPic, metaData);

    final String _newURL = await _ref.getDownloadURL();

    return _newURL;
  }
// -----------------------------------------------------------------------------

  /// DELETE

// ------------------------------------------------
  static Future<void> deleteStoragePic({
    @required BuildContext context,
    @required String docName,
    @required String picName,
  }) async {

    dynamic _result = await tryCatchAndReturn(
        context: context,
        methodName: 'deleteStoragePic',
        functions: () async {

          final Reference _picRef  = getRef(
              context: context,
              docName: docName,
              picName: picName
          );

          final FullMetadata _metaData = await _picRef?.getMetadata();

          print('_metaData ------------------------- : $_metaData');

          await _picRef?.delete();
        }
    );

    print('checking delete result : $_result');

    /// if result is an error, pop a dialog
    if (_result.runtimeType == String){

      /// only if the error is not
      /// [firebase_storage/object-not-found] No object exists at the desired reference.
      const String _fileDoesNotExistError = '[firebase_storage/object-not-found] No object exists at the desired reference.';

      if (_result == _fileDoesNotExistError){

        // await superDialog(
        //   context: context,
        //   title: '',
        //   body: 'there is no image to delete',
        //   boolDialog: false,
        // );

        print('there is no image to delete');

      }

      else {
        await CenterDialog.showCenterDialog(
          context: context,
          title: 'Can not delete image',
          body: '${_result.toString()}',
          boolDialog: false,
        );
      }

    }

    /// if result is null, so no error was thrown and procedure succeeded
    else {

      // await superDialog(
      //   context: context,
      //   title: '',
      //   body: 'Picture has been deleted',
      //   boolDialog: false,
      // );

      print('picture has been deleted');

    }

  }
// -----------------------------------------------------------------------------

}