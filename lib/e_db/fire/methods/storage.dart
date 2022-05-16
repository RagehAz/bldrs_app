import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

/// FIREBASE STORAGE METHODS

// =============================================================================

/// REFERENCES

// ------------------------------------------------
/// TESTED : WORKS PERFECT
Reference getRef({
  @required BuildContext context,
  @required String docName,
  @required String picName,
  String fileExtension = 'jpg',
}) {
  blog('getting fire storage reference');

  final Reference _ref = FirebaseStorage.instance
      .ref()
      .child(docName)
      .child('$picName.$fileExtension');

  return _ref;
}
// ------------------------------------------------
Future<Reference> getRefFromURL({
  @required String url,
  @required BuildContext context,
}) async {
  Reference _ref;

  await tryAndCatch(
      context: context,
      methodName: 'getRefFromURL',
      functions: () {
        final FirebaseStorage _storage = FirebaseStorage.instance;
        _ref = _storage.refFromURL(url);
        // await null;
      },
      onError: (String error) async {
        log(error);

        /// TASK : this is temp ,, or see how it goes
        await CenterDialog.showCenterDialog(
          context: context,
          title: 'Something is wrong',
          body: 'Could not get this image',
        );
      });

  return _ref;
}
// -----------------------------------------------------------------------------

/// CREATE

// ------------------------------------------------
Future<dynamic> uploadFile({
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
  //   blog('upload completed');
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
Future<String> createStoragePicAndGetURL({
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

        blog('X1 - getting storage ref : $_ref');

        final ImageSize imageSize = await ImageSize.superImageSize(inputFile);

        blog('X2 - image size is ${imageSize.height} * ${imageSize.width}');

        final SettableMetadata metaData =
            SettableMetadata(customMetadata: <String, String>{
          'width': '${imageSize.width}',
          'height': '${imageSize.height}',
          'owner': ownerID,
        });

        blog('X3 - meta data assigned');

        await _ref.putFile(
          inputFile,
          metaData,
        );

        blog('X4 - File has been uploaded $inputFile');

        _imageURL = await _ref.getDownloadURL();

        blog('X5 - _imageURL is downloaded  $_imageURL');
      });
  return _imageURL;
}
// ------------------------------------------------
Future<List<String>> createStorageSlidePicsAndGetURLs({
  @required BuildContext context,
  @required List<SlideModel> slides,
  @required String flyerID,
  @required String authorID,
}) async {

  final List<String> _picturesURLs = <String>[];

  for (final SlideModel slide in slides) {
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
Future<List<String>> createMultipleStoragePicsAndGetURLs({
  @required BuildContext context,
  @required List<dynamic> pics,
  @required List<String> names,
  @required String userID,
}) async {

  final List<String> _picsURLs = <String>[];

  if (
  Mapper.canLoopList(pics)
  &&
  Mapper.canLoopList(names)
  &&
  pics.length == names.length
  ) {

    for (int i = 0; i < pics.length; i++) {
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
Future<String> createStoragePicFromLocalAssetAndGetURL({
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

  blog('uploading $fileName pic to fireStorage in folder of $docName');

  _url = await createStoragePicAndGetURL(
    context: context,
    picName: fileName,
    docName: docName,
    inputFile: _result,
    ownerID: ownerID,
  );

  blog('uploaded pic : $_url');

  return _url;
}
// -----------------------------------------------------------------------------

/// READ

// ------------------------------------------------
/// TESTED : WORKS PERFECT : NOTE : use picName without file extension
Future<String> readStoragePicURL({
  @required BuildContext context,
  @required String docName,
  @required String picName,
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
Future<File> getFileFromPicURL({
  @required BuildContext context,
  @required String url,
}) async {
  File _file;

  if (url != null) {

    final Reference _ref = await getRefFromURL(
        url: url,
        context: context,
    );

    if (_ref != null) {

      final Uint8List _uInts = await _ref.getData();

      _file = await Imagers.getFileFromUint8List(
          uInt8List: _uInts,
          fileName: _ref.name,
      );

    }
  }

  return _file;
}
// ------------------------------------------------
Future<File> getFileByPath(
    {@required BuildContext context,
    @required String docName,
    @required String picName}) async {
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

  final Reference _ref = getRef(
      context: context,
      docName: docName,
      picName: picName,
  );


  if (_ref != null) {
    final Uint8List _uInts = await _ref.getData();

    _file = await Imagers.getFileFromUint8List(
        uInt8List: _uInts,
        fileName: _ref.name
    );
  }

  return _file;
}
// -----------------------------------------------------------------------------

/// UPDATE

// ------------------------------------------------
Future<String> updateExistingPic({
  @required BuildContext context,
  @required String oldURL,
  @required File newPic,
}) async {

  final Reference _ref = await getRefFromURL(
      url: oldURL,
      context: context,
  );

  final FullMetadata _fullMeta = await _ref.getMetadata();
  final Map<String, dynamic> _existingMetaData = _fullMeta.customMetadata;

  final SettableMetadata metaData = SettableMetadata(
      customMetadata: _existingMetaData,
  );

  await _ref.putFile(newPic, metaData);

  final String _newURL = await _ref.getDownloadURL();

  return _newURL;
}
// ------------------------------------------------
/// returns updated pic new URL
Future<String> createOrUpdatePic({
  @required BuildContext context,
  @required String oldURL,
  @required File newPic,
  @required String ownerID,
  @required String docName,
  @required String picName,
}) async {

  String _outputURL;

  final bool _oldURLIsValid = ObjectChecker.objectIsURL(oldURL);

  /// when old url exists
  if (_oldURLIsValid == true){

    _outputURL = await updateExistingPic(
        context: context,
        oldURL: oldURL,
        newPic: newPic,
    );

  }

  /// when no existing image url
  else {

    _outputURL = await createStoragePicAndGetURL(
      context: context,
      inputFile: newPic,
      ownerID: ownerID,
      docName: docName,
      picName: picName,
    );

  }

  return _outputURL;
}
// -----------------------------------------------------------------------------

/// DELETE

// ------------------------------------------------
Future<void> deleteStoragePic({
  @required BuildContext context,
  @required String docName,
  @required String picName,
}) async {

  final dynamic _result = await tryCatchAndReturnBool(
      context: context,
      methodName: 'deleteStoragePic',
      functions: () async {

        final Reference _picRef = getRef(
            context: context,
            docName: docName,
            picName: picName,
        );

        final FullMetadata _metaData = await _picRef?.getMetadata();

        blogFullMetaData(_metaData);

        await _picRef?.delete();
      },
    onError: (String error) async {

        const String _noImageError = '[firebase_storage/object-not-found] No object exists at the desired reference.';

        if (error == _noImageError){

          blog('deleteStoragePic : NOT FOUND AND NOTHING IS DELETED :docName $docName : picName : $picName');

        }

    }
    );

  /// if result is true
  if (_result == true) {
    blog('deleteStoragePic : IMAGE HAS BEEN DELETED :docName $docName : picName : $picName');
  }

  else {

  }
}
// -----------------------------------------------------------------------------

/// BLOGGING

// ------------------------------------------------
void blogFullMetaData(FullMetadata metaData){

  blog('BLOGGING STORAGE IMAGE META DATA ------------------------------- START');
  blog('name : ${metaData.name}');
  blog('bucket : ${metaData.bucket}');
  blog('cacheControl : ${metaData.cacheControl}');
  blog('contentDisposition : ${metaData.contentDisposition}');
  blog('contentEncoding : ${metaData.contentEncoding}');
  blog('contentLanguage : ${metaData.contentLanguage}');
  blog('contentType : ${metaData.contentType}');
  blog('customMetadata : ${metaData.customMetadata}'); // map
  blog('fullPath : ${metaData.fullPath}');
  blog('generation : ${metaData.generation}');
  blog('md5Hash : ${metaData.md5Hash}');
  blog('metadataGeneration : ${metaData.metadataGeneration}');
  blog('metageneration : ${metaData.metageneration}');
  blog('size : ${metaData.size}');
  blog('timeCreated : ${metaData.timeCreated}'); // date time
  blog('updated : ${metaData.updated}'); // date time
  blog('BLOGGING STORAGE IMAGE META DATA ------------------------------- END');

}
// -----------------------------------------------------------------------------
