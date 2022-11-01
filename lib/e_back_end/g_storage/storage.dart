import 'dart:io';

import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/g_storage/storage_file_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage_meta_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage_ref.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Storage {
  const Storage();
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------

  // --------------------
  /// protocol
  /// TESTED : WORKS PERFECT
  static Future<String> createStoragePicAndGetURL({
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
        methodName: 'createStoragePicAndGetURL',
        functions: () async {

          final Dimensions imageSize = await Dimensions.superDimensions(inputFile);

          final Map<String, String> _metaDataMap = <String, String>{
            'width': '${imageSize.width}',
            'height': '${imageSize.height}',
          };

          _imageURL = await StorageFileOps.uploadFileAndGetURL(
            storageCollName: docName,
            docName: fileName,
            file: inputFile,
            ownersIDs: ownersIDs,
            metaDataAddOn: _metaDataMap,
          );

        });

    return _imageURL;
  }
  // --------------------
  /// flyerStorageOps
  /// TESTED : WORKS PERFECT
  static Future<List<String>> createStorageSlidePicsAndGetURLs({
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
  // --------------------
  /// protocol
  static Future<List<String>> createMultipleStoragePicsAndGetURLs({
    @required List<File> files,
    @required List<String> names,
    @required List<String> ownersIDs,
    @required String docName,
  }) async {

    final List<String> _picsURLs = <String>[];

    if (
        Mapper.checkCanLoopList(files)
        &&
        Mapper.checkCanLoopList(names)
        &&
        files.length == names.length
    ) {

      await Future.wait(<Future>[

        ...List.generate(files.length, (index){

          final File _file = files[index];
          final String _name = names[index];

          return createStoragePicAndGetURL(
            inputFile: _file,
            docName: docName,
            fileName: _name,
            ownersIDs: ownersIDs,
          ).then((String url){
            _picsURLs.add(url);
          });

      }),

      ]);

    }

    return _picsURLs;
  }
  // --------------------
  /// protocol
  /// TASK : createStoragePicFromAssetAndGetURL not tested properly
  static Future<String> createStoragePicFromLocalAssetAndGetURL({
    @required String asset,
    @required String fileName,
    @required String docName,
    @required List<String> ownersIDs,
  }) async {
    String _url;

    final File _result = await Filers.getFileFromLocalRasterAsset(
      localAsset: asset,
    );

    blog('uploading $fileName pic to fireStorage in folder of $docName');

    _url = await createStoragePicAndGetURL(
      fileName: fileName,
      docName: docName,
      inputFile: _result,
      ownersIDs: ownersIDs,
    );

    blog('uploaded pic : $_url');

    return _url;
  }
  // --------------------
  /// pdf storage ops
  /// TESTED : WORKS PERFECT
  static Future<FileModel> uploadFlyerPDFAndGetFlyerPDF({
    @required FileModel pdf,
    @required String flyerID,
    @required List<String> ownersIDs,
    ValueChanged<FileModel> onFinished,
  }) async {

    FileModel _pdf = pdf?.copyWith();

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

        if (ObjectCheck.objectIsFile(pdf.file) == true){

          _fileFromURL = pdf.file;

          _url = await StorageFileOps.uploadFileAndGetURL(
            file: pdf.file,
            storageCollName: StorageDoc.flyersPDFs,
            docName: _pdfStorageName,
            ownersIDs: ownersIDs,
            // metaDataAddOn: ,
          );

        }

      }

      /// NO NEW FILE GIVEN - BUT NEED TO RE-UPLOAD EXISTING URL WITH NEW NAME
      else if (_shouldReUploadExistingURL == true){

        _fileFromURL = await Filers.getFileFromURL(pdf.url);
        final FullMetadata _meta = await StorageMetaOps.getMetaByURL(
          url: pdf.url,
        );

        _url = await StorageFileOps.uploadFileAndGetURL(
          file: _fileFromURL,
          storageCollName: StorageDoc.flyersPDFs,
          docName: _pdfStorageName,
          ownersIDs: ownersIDs,
          metaDataAddOn: _meta.customMetadata,
        );

      }

      _pdf = FileModel(
        fileName: pdf.fileName,
        size: Filers.getFileSizeInMb(_fileFromURL),
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

  // --------------------


  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> getImageNameByURL({
    @required String url,
    // @required bool withExtension,
  }) async {
    blog('getImageNameByURL : START');
    String _output;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final Reference _ref = await StorageRef.byURL(
        url: url,
      );

      /// NAME WITH EXTENSION
      _output = _ref.name;

      // blog('getImageNameByURL : _output : $_output');

      // /// WITHOUT EXTENSION
      // if (withExtension == false){
      //   _output = TextMod.removeTextAfterLastSpecialCharacter(_output, '.');
      // }

      blog('getImageNameByURL :  _output : $_output');

    }


    blog('getImageNameByURL : END');
    return _output;
  }
  // --------------------
  // --------------------
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getOwnersIDsByURL({
    @required String url,
  }) async {
    final List<String> _ids = [];

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final FullMetadata _metaData = await StorageMetaOps.getMetaByURL(
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getOwnersIDsByFileName({
    @required String storageCollName,
    @required String docName,
  }) async {
    final List<String> _ids = [];

    if (docName != null && storageCollName != null){

      final FullMetadata _metaData = await StorageMetaOps.getMetaByNodes(
        storageCollName: storageCollName,
        docName: docName,
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

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> updateExistingPic({
    @required String oldURL,
    @required File newPic,
  }) async {
    String _output;

    if (oldURL != null && newPic != null){

      await tryAndCatch(
        methodName: 'updateExistingPic',
        functions: () async {

          final Reference _ref = await StorageRef.byURL(
            url: oldURL,
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> createOrUpdatePic({
    @required String oldURL,
    @required File newPic,
    @required String docName,
    @required String picName,
    @required List<String> ownersIDs,
  }) async {
    /// returns updated pic new URL

    String _outputURL;

    final bool _oldURLIsValid = ObjectCheck.isAbsoluteURL(oldURL);

    /// when old url exists
    if (_oldURLIsValid == true){

      _outputURL = await updateExistingPic(
        oldURL: oldURL,
        newPic: newPic,
      );

    }

    /// when no existing image url
    else {

      _outputURL = await createStoragePicAndGetURL(
        inputFile: newPic,
        ownersIDs: ownersIDs,
        docName: docName,
        fileName: picName,
      );

    }

    return _outputURL;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updatePicMetadata({
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

    if (ObjectCheck.isAbsoluteURL(picURL) == true && metaDataMap != null){

      final Reference _ref = await StorageRef.byURL(
          url: picURL,
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

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteStoragePic({
    @required String collName,
    @required String docName,
  }) async {

    blog('deleteStoragePic : START');

    final bool _canDelete = await checkCanDeleteStorageFile(
      docName: docName,
      collName: collName,
    );

    if (_canDelete == true){

      final dynamic _result = await tryCatchAndReturnBool(
          methodName: 'deleteStoragePic',
          functions: () async {

            final Reference _picRef = StorageRef.byNodes(
              storageDocName: collName,
              fileName: docName,
            );

            // blog('pic ref : $_picRef');
            // final FullMetadata _metaData = await _picRef?.getMetadata();
            // blogFullMetaData(_metaData);

            await _picRef?.delete();
          },
          onError: (String error) async {

            const String _noImageError = '[firebase_storage/object-not-found] No object exists at the desired reference.';
            if (error == _noImageError){

              blog('deleteStoragePic : NOT FOUND AND NOTHING IS DELETED :docName $collName : picName : $docName');

            }
            else {
              blog('deleteStoragePic : $collName/$docName : error : $error');
            }

          }
      );

      /// if result is true
      if (_result == true) {
        blog('deleteStoragePic : IMAGE HAS BEEN DELETED :docName $collName : picName : $docName');
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkCanDeleteStorageFile({
    @required String collName,
    @required String docName,
  }) async {

    assert(docName != null && collName != null,
    'checkCanDeleteStorageFile : fileName or storageDocName can not be null');

    bool _canDelete = false;

    blog('checkCanDeleteStorageFile : START');

    if (docName != null && collName != null){

      final List<String> _ownersIDs = await getOwnersIDsByFileName(
        storageCollName: collName,
        docName: docName,
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

  // --------------------
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

  // --------------------
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
