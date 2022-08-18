import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/image_size.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Storage {

  const Storage();


  /// FIREBASE STORAGE METHODS

// =============================================================================

  /// REFERENCES

// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Reference getRef({
    @required BuildContext context,
    @required String storageDocName,
    @required String fileName, // without extension
  }) {
    blog('getting fire storage reference');

    final Reference _ref = FirebaseStorage.instance
        .ref()
        .child(storageDocName)
        .child(fileName);

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
  static Future<String> uploadFile({
    @required BuildContext context,
    @required File file,
    @required String storageDocName,
    @required String fileName,
    @required List<String> ownersIDs,
    Map<String, String> metaDataAddOn,
  }) async {

    blog('uploadFile : START');

    /// NOTE : RETURNS URL
    String _fileURL;

    await tryAndCatch(
      context: context,
        methodName: 'uploadFile',
        functions: () async {

          /// GET REF
          final Reference _ref = getRef(
            context: context,
            storageDocName: storageDocName,
            fileName: fileName,
          );

          blog('uploadFile : 1 - got ref : $_ref');

          /// ASSIGN FILE OWNERS
          Map<String, String> _metaDataMap = <String, String>{};
          for (final String ownerID in ownersIDs) {
            _metaDataMap[ownerID] = 'cool';
          }
          /// ADD EXTENSION
          final String _extension = Filers.getFileExtensionFromFile(file);
          _metaDataMap['extension'] = _extension;


          blog('uploadFile : 2 - assigned owners : _metaDataMap : $_metaDataMap');

          /// ADD EXTRA METADATA MAP PAIRS
          if (metaDataAddOn != null) {
            _metaDataMap = Mapper.mergeMaps(
              baseMap: _metaDataMap,
              insert: metaDataAddOn,
              replaceDuplicateKeys: true,
            );
          }

          blog('uploadFile : 3 - added extra meta data : _metaDataMap : $_metaDataMap');

          /// FORM METADATA
          final SettableMetadata metaData = SettableMetadata(
            customMetadata: _metaDataMap,
          );

          blog('uploadFile : 4 - assigned meta data');


          final UploadTask _uploadTask = _ref.putFile(
            file,
            metaData,
          );

          blog('uploadFile : 5 - uploaded file : fileName : $fileName : file.fileNameWithExtension : ${file.fileNameWithExtension}');

          final TaskSnapshot _snapshot = await _uploadTask.whenComplete((){
            blog('uploadFile : 6 - upload file completed');
          });
          blog('uploadFile : 7 - task state : ${_snapshot.state}');

          _fileURL = await _ref.getDownloadURL();
          blog('uploadFile : 8 - got url : $_fileURL');

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
// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> createStoragePicAndGetURL({
    @required BuildContext context,
    @required File inputFile,
    @required String docName,
    @required String fileName,
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

          final ImageSize imageSize = await ImageSize.superImageSize(inputFile);

          final Map<String, String> _metaDataMap = <String, String>{
            'width': '${imageSize.width}',
            'height': '${imageSize.height}',
          };

          _imageURL = await uploadFile(
            context: context,
            storageDocName: docName,
            fileName: fileName,
            file: inputFile,
            ownersIDs: ownersIDs,
            metaDataAddOn: _metaDataMap,
          );

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
    ValueChanged<List<String>> onFinished,
  }) async {

    final List<String> _picturesURLs = <String>[];

    if (Mapper.checkCanLoopList(slides) == true && flyerID != null && bzCreatorID != null){

      await Future.wait(<Future>[

            ...List.generate(slides.length, (index) async {

              final String _picURL = await createStoragePicAndGetURL(
                context: context,
                inputFile: slides[index].pic,
                docName: StorageDoc.slides,
                ownersIDs: <String>[bzCreatorID, flyerAuthorID],
                fileName: SlideModel.generateSlideID(
                  flyerID: flyerID,
                  slideIndex: slides[index].slideIndex,
                ),
              );

              _picturesURLs.add(_picURL);

            }),

      ]);

    }

    if (onFinished != null){
      onFinished(_picturesURLs);
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
          fileName: names[i],
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
      fileName: fileName,
      docName: docName,
      inputFile: _result,
      ownersIDs: ownersIDs,
    );

    blog('uploaded pic : $_url');

    return _url;
  }
// ------------------------------------------------




  /// TESTED : WORKS PERFECT
  static Future<FileModel> uploadFlyerPDFAndGetFlyerPDF({
    @required BuildContext context,
    @required FileModel pdf,
    @required String flyerID,
    @required List<String> ownersIDs,
    ValueChanged<FileModel> onFinished,
  }) async {

    FileModel _pdf = pdf.copyWith();

    if (pdf != null && (pdf.file != null || pdf.url != null)){

      final bool _shouldUploadNewFile = pdf.file != null;
      final bool _shouldReUploadExistingURL = pdf.file == null && pdf.url != null;

      final String _pdfStorageName = FileModel.generateFlyerPDFStorageName(
        pdfFileName: pdf.fileName,
        flyerID: flyerID,
      );

      String _url;
      File _fileFromURL;

      /// A NEW FILE WAS GIVEN
      if (_shouldUploadNewFile == true){

        if (ObjectChecker.objectIsFile(pdf.file) == true){

          _fileFromURL = pdf.file;

          _url = await Storage.uploadFile(
            context: context,
            file: pdf.file,
            storageDocName: StorageDoc.flyersPDFs,
            fileName: _pdfStorageName,
            ownersIDs: ownersIDs,
            // metaDataAddOn: ,
          );

        }

      }

      /// NO NEW FILE GIVEN - BUT NEED TO RE-UPLOAD EXISTING URL WITH NEW NAME
      else if (_shouldReUploadExistingURL == true){

        _fileFromURL = await Filers.getFileFromURL(pdf.url);
        final FullMetadata _meta = await getMetadataFromURL(
            context: context,
            url: pdf.url,
        );

        _url = await Storage.uploadFile(
          context: context,
          file: _fileFromURL,
          storageDocName: StorageDoc.flyersPDFs,
          fileName: _pdfStorageName,
          ownersIDs: ownersIDs,
          metaDataAddOn: _meta.customMetadata,
        );

      }

      _pdf = FileModel(
        fileName: pdf.fileName,
        size: Filers.getFileSize(_fileFromURL),
        url: _url,
        // file: null,
      );

    }

    if (onFinished != null){
      onFinished(_pdf);
    }

    return _pdf;
  }
 // -----------------------------------------------------------------------------

  /// READ (GETTERS)

// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> getImageURLByPath({
    @required BuildContext context,
    @required String storageDocName,
    /// Note : use picName without file extension
    @required String fileName,
  }) async {

    final Reference _ref = getRef(
      context: context,
      storageDocName: storageDocName,
      fileName: fileName,
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
    @required String storageDocName,
    @required String fileName,
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
      storageDocName: storageDocName,
      fileName: fileName,
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
    // @required bool withExtension,
  }) async {
    blog('getImageNameByURL : START');
    String _output;

    if (ObjectChecker.objectIsURL(url) == true){

      final Reference _ref = await getRefFromURL(
        context: context,
        url: url,
      );

      /// NAME WITH EXTENSION
      final String _output = _ref.name;

      blog('getImageNameByURL : _output : $_output');

      // /// WITHOUT EXTENSION
      // if (withExtension == false){
      //   _output = TextMod.removeTextAfterLastSpecialCharacter(_output, '.');
      // }

      blog('getImageNameByURL :  _output : $_output');

    }


    blog('getImageNameByURL : END');
    return _output;
  }
// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FullMetadata> getMetadataFromURL({
    @required BuildContext context,
    @required String url,
  }) async {

    FullMetadata _meta;

    if (ObjectChecker.objectIsURL(url) == true){

      await tryAndCatch(
        context: context,
        methodName: 'getMetadataFromURL',
        functions: () async {

          final Reference _ref = await Storage.getRefFromURL(
              url: url,
              context: context
          );

          _meta = await _ref.getMetadata();


        },
      );

    }

    return _meta;
  }
// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FullMetadata> getMetadataByFileName({
    @required BuildContext context,
    @required String storageDocName,
    @required String fileName,
  }) async {

    FullMetadata _meta;

    blog('getMetadataByFileName : $storageDocName/$fileName');

    if (storageDocName != null && fileName != null){

      await tryAndCatch(
        context: context,
          methodName: 'getMetadataByFileName',
          functions: () async {

            final Reference _ref = Storage.getRef(
              context: context,
              storageDocName: storageDocName,
              fileName: fileName,
            );

            _meta = await _ref?.getMetadata();

          },
      );


    }

    return _meta;
  }
// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getOwnersIDsByURL({
    @required BuildContext context,
    @required String url,
  }) async {
    final List<String> _ids = [];

    if (ObjectChecker.objectIsURL(url) == true){

      final FullMetadata _metaData = await getMetadataFromURL(
          context: context,
          url: url,
      );

      final Map<String, String> _map = _metaData?.customMetadata;

      final List<String> _ownersIDs = Mapper.getKeysHavingThisValue(
        map: _map,
        value: 'cool',
      );

      _ids.addAll(_ownersIDs);

    }

    return _ids;
  }
// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getOwnersIDsByFileName({
    @required BuildContext context,
    @required String storageDocName,
    @required String fileName,
  }) async {
    final List<String> _ids = [];

    if (fileName != null && storageDocName != null){

      final FullMetadata _metaData = await getMetadataByFileName(
        context: context,
        storageDocName: storageDocName,
        fileName: fileName,
      );

      final Map<String, String> _map = _metaData?.customMetadata;

      final List<String> _ownersIDs = Mapper.getKeysHavingThisValue(
        map: _map,
        value: 'cool',
      );

      _ids.addAll(_ownersIDs);

    }

    return _ids;
  }
// -----------------------------------------------------------------------------

  /// UPDATE

// ------------------------------------------------
  static Future<String> updateExistingPic({
    @required BuildContext context,
    @required String oldURL,
    @required File newPic,
  }) async {
    String _output;

    if (oldURL != null && newPic != null){

      await tryAndCatch(
        methodName: 'updateExistingPic',
        functions: () async {

          final Reference _ref = await getRefFromURL(
            url: oldURL,
            context: context,
          );

          final FullMetadata _fullMeta = await _ref?.getMetadata();

          final Map<String, dynamic> _existingMetaData = _fullMeta?.customMetadata;

          final SettableMetadata metaData = SettableMetadata(
            customMetadata: _existingMetaData,
          );

          await _ref?.putFile(newPic, metaData);

          _output = await _ref?.getDownloadURL();


        },
      );

    }

    return _output;
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
        fileName: picName,
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

      // final FullMetadata _meta = await _ref.getMetadata();

      final SettableMetadata metaData = SettableMetadata(
          customMetadata: metaDataMap,
      );

      await _ref.updateMetadata(metaData);

      // Storage.blogFullMetaData(_meta);

    }

    blog('updatePicMetaData : END');

  }
// -----------------------------------------------------------------------------

  /// DELETE

// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteStoragePic({
    @required BuildContext context,
    @required String storageDocName,
    @required String fileName,
  }) async {

    blog('deleteStoragePic : START');

    final bool _canDelete = await checkCanDeleteStorageFile(
        context: context,
        fileName: fileName,
        storageDocName: storageDocName,
    );

    if (_canDelete == true){

      final dynamic _result = await tryCatchAndReturnBool(
          context: context,
          methodName: 'deleteStoragePic',
          functions: () async {

            final Reference _picRef = getRef(
              context: context,
              storageDocName: storageDocName,
              fileName: fileName,
            );

            // blog('pic ref : $_picRef');
            // final FullMetadata _metaData = await _picRef?.getMetadata();
            // blogFullMetaData(_metaData);

            await _picRef?.delete();
          },
          onError: (String error) async {

            const String _noImageError = '[firebase_storage/object-not-found] No object exists at the desired reference.';
            if (error == _noImageError){

              blog('deleteStoragePic : NOT FOUND AND NOTHING IS DELETED :docName $storageDocName : picName : $fileName');

            }
            else {
              blog('deleteStoragePic : $storageDocName/$fileName : error : $error');
            }

          }
      );

      /// if result is true
      if (_result == true) {
        blog('deleteStoragePic : IMAGE HAS BEEN DELETED :docName $storageDocName : picName : $fileName');
      }

      // else {
      //
      // }

    }

    else {
      blog('deleteStoragePic : CAN NOT DELETE STORAGE FILE');
    }


    blog('deleteStoragePic : END');

  }
// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkCanDeleteStorageFile({
    @required BuildContext context,
    @required String fileName,
    @required String storageDocName,
  }) async {
    bool _canDelete = false;

    blog('checkCanDeleteStorageFile : START');

    if (fileName != null && storageDocName != null){

      final List<String> _ownersIDs = await getOwnersIDsByFileName(
        context: context,
        storageDocName: storageDocName,
        fileName: fileName,
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

    blog('BLOGGING STORAGE FILE META DATA ------------------------------- START');
    if (metaData == null){
      blog('Meta data is null');
    }
    else {
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
    }
    blog('BLOGGING STORAGE IMAGE META DATA ------------------------------- END');

  }
// ------------------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogReference(Reference ref){
    blog('BLOGGING STORAGE IMAGE REFERENCE ------------------------------- START');

    if (ref == null){
      blog('Reference is null');
    }
    else {
      blog('name : ${ref.name}');
      blog('fullPath : ${ref.fullPath}');
      blog('bucket : ${ref.bucket}');
      blog('hashCode : ${ref.hashCode}');
      blog('parent : ${ref.parent}');
      blog('root : ${ref.root}');
      blog('storage : ${ref.storage}');
    }

    blog('BLOGGING STORAGE IMAGE REFERENCE ------------------------------- END');
  }
// -----------------------------------------------------------------------------
}
