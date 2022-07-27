import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Storage {

  Storage();


  /// FIREBASE STORAGE METHODS

// =============================================================================

  /// REFERENCES

// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Reference getRef({
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
  /// TESTED : WORKS PERFECT
  static Future<Reference> getRefFromURL({
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static Future<String> createStoragePicAndGetURL({
    @required BuildContext context,
    @required File inputFile,
    @required String docName,
    @required String picName,
    @required List<String> ownersIDs,
  }) async {

    /// NOTE
    /// creates new pic in document name according to pic type,
    /// and overrides existing pic if already exists

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


          final Map<String, String> _metaDataMap = <String, String>{
            'width': '${imageSize.width}',
            'height': '${imageSize.height}',
          };
          for (final String ownerID in ownersIDs){
            _metaDataMap[ownerID]= 'cool';
          }

          final SettableMetadata metaData = SettableMetadata(
              customMetadata: _metaDataMap,
          );


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
  /// TESTED : WORKS PERFECT
  static Future<List<String>> createStorageSlidePicsAndGetURLs({
    @required BuildContext context,
    @required List<SlideModel> slides,
    @required String flyerID,
    @required String bzCreatorID,
    @required String flyerAuthorID,
  }) async {

    final List<String> _picturesURLs = <String>[];

    if (Mapper.checkCanLoopList(slides) == true && flyerID != null && bzCreatorID != null){

      for (final SlideModel slide in slides) {

        final String _picURL = await createStoragePicAndGetURL(
          context: context,
          inputFile: slide.pic,
          docName: StorageDoc.slides,
          ownersIDs: <String>[bzCreatorID, flyerAuthorID],
          picName: SlideModel.generateSlideID(
            flyerID: flyerID,
            slideIndex: slide.slideIndex,
          ),
        );

        _picturesURLs.add(_picURL);
      }

    }

    return _picturesURLs;
  }
// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> createMultipleStoragePicsAndGetURLs({
    @required BuildContext context,
    @required List<dynamic> pics,
    @required List<String> names,
    @required List<String> ownersIDs,
  }) async {

    final List<String> _picsURLs = <String>[];

    if (
    Mapper.checkCanLoopList(pics)
        &&
        Mapper.checkCanLoopList(names)
        &&
        pics.length == names.length
    ) {

      for (int i = 0; i < pics.length; i++) {
        final String _picURL = await createStoragePicAndGetURL(
          context: context,
          inputFile: pics[i],
          docName: StorageDoc.slides,
          picName: names[i],
          ownersIDs: ownersIDs,
        );

        _picsURLs.add(_picURL);
      }
    }

    return _picsURLs;
  }
// ------------------------------------------------
  /// TASK : createStoragePicFromAssetAndGetURL not tested properly
  static Future<String> createStoragePicFromLocalAssetAndGetURL({
    @required BuildContext context,
    @required String asset,
    @required String fileName,
    @required String docName,
    @required List<String> ownersIDs,
  }) async {
    String _url;

    final File _result = await Filers.getFileFromLocalRasterAsset(
      context: context,
      localAsset: asset,
    );

    blog('uploading $fileName pic to fireStorage in folder of $docName');

    _url = await createStoragePicAndGetURL(
      context: context,
      picName: fileName,
      docName: docName,
      inputFile: _result,
      ownersIDs: ownersIDs,
    );

    blog('uploaded pic : $_url');

    return _url;
  }
// -----------------------------------------------------------------------------

  /// READ (GETTERS)

// ------------------------------------------------
  /// TESTED : WORKS PERFECT : NOTE
  static Future<String> getImageURLByPath({
    @required BuildContext context,
    @required String docName,
    /// Note : use picName without file extension
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
  /// TESTED : WORKS PERFECT
  static Future<File> getImageFileByURL({
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

        _file = await Filers.getFileFromUint8List(
          uInt8List: _uInts,
          fileName: _ref.name,
        );

      }
    }

    return _file;
  }
// ------------------------------------------------
  static Future<File> getImageFileByPath({
    @required BuildContext context,
    @required String docName,
    @required String picName,
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

    final Reference _ref = getRef(
      context: context,
      docName: docName,
      picName: picName,
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
// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> getImageNameByURL({
    @required BuildContext context,
    @required String url,
    @required bool withExtension,
  }) async {

    final Reference _ref = await getRefFromURL(
      context: context,
      url: url,
    );

    /// NAME WITH EXTENSION
    String _output = _ref.name;

    /// WITHOUT EXTENSION
    if (withExtension == false){
      _output = TextMod.removeTextAfterLastSpecialCharacter(_output, '.');
    }

    return _output;
  }
// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FullMetadata> getMetadataFromURL({
    @required String url,
    @required BuildContext context,
  }) async {

    FullMetadata _meta;

    if (ObjectChecker.objectIsURL(url) == true){

      final Reference _ref = await Storage.getRefFromURL(
          url: url,
          context: context
      );

      _meta = await _ref.getMetadata();

    }

    return _meta;
  }
// -----------------------------------------------------------------------------

  /// UPDATE

// ------------------------------------------------
  static Future<String> updateExistingPic({
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
  /// TESTED : WORKS PERFECT
  static Future<String> createOrUpdatePic({
    @required BuildContext context,
    @required String oldURL,
    @required File newPic,
    @required String docName,
    @required String picName,
    @required List<String> ownersIDs,
  }) async {
    /// returns updated pic new URL

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
        ownersIDs: ownersIDs,
        docName: docName,
        picName: picName,
      );

    }

    return _outputURL;
  }
// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updatePicMetadata({
    @required BuildContext context,
    @required String picURL,
    Map<String, String> metaDataMap,
  }) async {

    /// Map<String, String> _dummyMap = <String, String>{
    ///   'width': _meta.customMetadata['width'],
    ///   'height': _meta.customMetadata['height'],
    ///   '$ownerID': 'cool,
    ///   '$ownerID': 'cool,
    ///   '$ownerID': 'cool,
    ///   ...
    ///   'owner': null, /// ASSIGNING NULL TO KEY DELETES PAIR AUTOMATICALLY.
    /// };

    blog('updatePicMetaData : START');

    if (ObjectChecker.objectIsURL(picURL) == true && metaDataMap != null){

      final Reference _ref = await Storage.getRefFromURL(
          url: picURL,
          context: context
      );

      final FullMetadata _meta = await _ref.getMetadata();

      final SettableMetadata metaData = SettableMetadata(
          customMetadata: metaDataMap,
      );

      await _ref.updateMetadata(metaData);

      Storage.blogFullMetaData(_meta);

    }

    blog('updatePicMetaData : END');

  }
// -----------------------------------------------------------------------------

  /// DELETE

// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteStoragePic({
    @required BuildContext context,
    @required String docName,
    @required String picName,
  }) async {

    blog('deleteStoragePic : start');

    final dynamic _result = await tryCatchAndReturnBool(
        context: context,
        methodName: 'deleteStoragePic',
        functions: () async {

          final Reference _picRef = getRef(
            context: context,
            docName: docName,
            picName: picName,
          );

          // blog('pic ref : $_picRef');
          // final FullMetadata _metaData = await _picRef?.getMetadata();
          // blogFullMetaData(_metaData);

          await _picRef?.delete();
        },
        onError: (String error) async {

          const String _noImageError = '[firebase_storage/object-not-found] No object exists at the desired reference.';
          if (error == _noImageError){

            blog('deleteStoragePic : NOT FOUND AND NOTHING IS DELETED :docName $docName : picName : $picName');

          }
          else {
            blog('deleteStoragePic : error : $error');
          }

        }
    );

    /// if result is true
    if (_result == true) {
      blog('deleteStoragePic : IMAGE HAS BEEN DELETED :docName $docName : picName : $picName');
    }

    // else {
    //
    // }

    blog('deleteStoragePic : end');

  }
// -----------------------------------------------------------------------------

  /// CHECKER

// ------------------------------------------------
  /// CAN NOT STOP STORAGE ( Object does not exist at location ) EXCEPTION
/*
  bool checkStorageImageExists(){
    /// AFTER SOME SEARCHING,, NO WAY TO STOP STORAGE SDK THROWN EXCEPTION
    /// WHEN THE IMAGE TRIED TO BE CALLED DOES NOT EXISTS.
    /// END OF STORY
  }
 */
// -----------------------------------------------------------------------------

  /// BLOGGING

// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogFullMetaData(FullMetadata metaData){

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
// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogReference(Reference ref){
    blog('BLOGGING STORAGE IMAGE REFERENCE ------------------------------- START');

    blog('name : ${ref.name}');
    blog('fullPath : ${ref.fullPath}');
    blog('bucket : ${ref.bucket}');
    blog('hashCode : ${ref.hashCode}');
    blog('parent : ${ref.parent}');
    blog('root : ${ref.root}');
    blog('storage : ${ref.storage}');

    blog('BLOGGING STORAGE IMAGE REFERENCE ------------------------------- END');
  }
// -----------------------------------------------------------------------------
}
