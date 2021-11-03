import 'dart:io';

import 'package:bldrs/controllers/drafters/imagers.dart';
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
  static Reference getRef({
    @required BuildContext context,
    @required String docName,
    @required String fileName,
    String fileExtension = 'jpg',
  }) {

    print('getting fire storage reference');

    final Reference _ref = FirebaseStorage.instance
        .ref()
        .child(docName)
        .child(fileName + '.${fileExtension}') ?? null;

    return _ref;
  }
// -----------------------------------------------------------------------------
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

      }
    );

    return _ref;
}
// -----------------------------------------------------------------------------
  static Future<dynamic> uploadFile({
    @required BuildContext context,
    @required File file,
    @required String docName,
    @required String fileName,
  }) async {

    final Reference _ref = getRef(
        context: context,
        docName: docName,
        fileName: fileName
    );

    final UploadTask _uploadTask = _ref.putFile(file);

    final TaskSnapshot _snapshot = await _uploadTask.whenComplete((){

      print('upload completed');

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

}

  /// creates new pic in document name according to pic type,
  /// and overrides existing pic if already exists
  static Future<String> createStoragePicAndGetURL({
    @required BuildContext context,
    @required File inputFile,
    @required String fileName,
    @required PicType picType
  }) async {
    String _imageURL;

    await tryAndCatch(
        context: context,
        methodName: 'createStoragePicAndGetURL',
        functions: () async {

          final Reference _ref = getRef(
            context: context,
            docName: StorageDoc.docName(picType),
            fileName: fileName,
          );

          print('X1 - getting storage ref : $_ref');

          final ImageSize imageSize = await ImageSize.superImageSize(inputFile);

          print('X2 - image size is ${imageSize.height} * ${imageSize.width}');

          final SettableMetadata metaData = SettableMetadata(
              customMetadata: {'width': '${imageSize.width}', 'height': '${imageSize.height}'}
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
// -----------------------------------------------------------------------------
  static Future<List<String>> createStorageSlidePicsAndGetURLs({
    @required BuildContext context,
    @required List<SlideModel> slides,
    @required String flyerID
  }) async {

    final List<String> _picturesURLs = <String>[];

    for (var slide in slides) {

      final String _picURL = await createStoragePicAndGetURL(
        context: context,
        inputFile: slide.pic,
        picType: PicType.slideHighRes,
        fileName: SlideModel.generateSlideID(flyerID, slide.slideIndex),
      );

      _picturesURLs.add(_picURL);

    }

    return _picturesURLs;
  }
// -----------------------------------------------------------------------------
  static Future<List<String>> createMultipleStoragePicsAndGetURLs({
    @required BuildContext context,
    @required List<dynamic> pics,
    @required List<String> names,
  }) async {

    final List<String> _picsURLs = <String>[];

    if (Mapper.canLoopList(pics) && Mapper.canLoopList(names) && pics.length == names.length){

      for (int i =0; i < pics.length; i++) {
        final String _picURL = await createStoragePicAndGetURL(
          context: context,
          inputFile: pics[i],
          picType: PicType.slideHighRes,
          fileName: names[i],
        );
        _picsURLs.add(_picURL);
      }

    }

    return _picsURLs;
  }
// -----------------------------------------------------------------------------
  /// TASK : createStoragePicFromAssetAndGetURL not tested properly
  static Future<String> createStoragePicFromLocalAssetAndGetURL ({
    @required BuildContext context,
    @required String asset,
    @required String fileName,
    @required PicType picType
  }) async {
    String _url;

    final File _result = await Imagers.getImageFileFromLocalAsset(context, asset);

    print('uploading $fileName pic to fireStorage in folder of $picType');

    _url = await createStoragePicAndGetURL(
      context: context,
      fileName: fileName,
      picType: picType,
      inputFile: _result,
    );

    print('uploaded pic : $_url');

    return _url;
  }
// -----------------------------------------------------------------------------
  static Future<String> readStoragePicURL({
    @required BuildContext context,
    @required PicType picType,
    @required String fileName
  }) async {

    final Reference _ref = getRef(
      context: context,
      docName: StorageDoc.docName(picType),
      fileName: fileName,
    );

    final String _url = await _ref.getDownloadURL();

    return _url;
  }
// -----------------------------------------------------------------------------
  static Future<void> deleteStoragePic({
    @required BuildContext context,
    @required String fileName,
    @required PicType picType
  }) async {

    dynamic _result = await tryCatchAndReturn(
        context: context,
        methodName: 'deleteStoragePic',
        functions: () async {

          final Reference _picRef  = getRef(
              context: context,
              docName: StorageDoc.docName(picType),
              fileName: fileName
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