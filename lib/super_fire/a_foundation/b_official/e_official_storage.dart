part of super_fire;

/// Note : use picName without file extension <---------------

class _OfficialStorage {
  // -----------------------------------------------------------------------------

  const _OfficialStorage();

  // -----------------------------------------------------------------------------

  /// f_s.REFERENCES

  // --------------------
  /// TESTED: WORKS PERFECT
  static f_s.Reference _getRefByPath(String path){
    return _OfficialFirebase.getStorage().ref(path);
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static f_s.Reference _getRefByNodes({
    @required String coll,
    @required String doc, // without extension
  }) {

    return _OfficialFirebase.getStorage()
        .ref()
        .child(coll)
        .child(doc);

  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<f_s.Reference> _getRefByURL({
    @required String url,
  }) async {
    f_s.Reference _ref;

    await tryAndCatch(
        invoker: 'StorageRef.byURL',
        functions: () {
          _ref = _OfficialFirebase.getStorage()?.refFromURL(url);
        },
    );

    return _ref;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<String> _createURLByRef({
    @required f_s.Reference ref,
  }) async {
    String _url;

    await tryAndCatch(
        invoker: '_createURLByRef',
        functions: () async {
          _url = await ref?.getDownloadURL();
        }
    );

    return _url;
  }
  // -----------------------------------------------------------------------------

  /// CREATE DOC

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> uploadBytesAndGetURL({
    @required Uint8List bytes,
    @required String path,
    @required StorageMetaModel picMetaModel,
  }) async {

    assert(Mapper.checkCanLoopList(bytes) == true, 'uInt7List is empty or null');
    assert(picMetaModel != null, 'metaData is null');
    assert(TextCheck.isEmpty(path) == false, 'path is empty or null');

    String _url;

    await tryAndCatch(
        invoker: 'createDocByUint8List',
        functions: () async {

          final f_s.Reference _ref = _getRefByPath(path);

          blog('createDocByUint8List : 1 - got ref : $_ref');

          final f_s.UploadTask _uploadTask = _ref.putData(
            bytes,
            picMetaModel.toOfficialSettableMetadata(),
          );

          blog('createDocByUint8List : 2 - uploaded uInt8List to path : $path');


          await Future.wait(<Future>[

            _uploadTask.whenComplete(() async {
              blog('createDocByUint8List : 3 - uploaded successfully');
              _url = await _createURLByRef(ref: _ref);
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

    return _url;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> uploadFileAndGetURL({
    @required File file,
    @required String coll,
    @required String doc,
    @required StorageMetaModel picMetaModel,
  }) async {

    blog('uploadFile : START');

    /// NOTE : RETURNS URL
    String _fileURL;

    await tryAndCatch(
        invoker: 'uploadFile',
        functions: () async {

          /// GET REF
          final f_s.Reference _ref = _getRefByNodes(
            coll: coll,
            doc: doc,
          );

          blog('uploadFile : 1 - got ref : $_ref');

          blog('uploadFile : 2 - assigned meta data');

          final f_s.UploadTask _uploadTask = _ref.putFile(
            file,
            picMetaModel.toOfficialSettableMetadata(),
          );

          blog('uploadFile : 3 - uploaded file : fileName : $doc : file.fileNameWithExtension : ${file.fileNameWithExtension}');

          final f_s.TaskSnapshot _snapshot = await _uploadTask.whenComplete((){
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

  /// CREATE URL

  // --------------------
  /// TESTED: WORKS PERFECT
  static Future<String> createURLByPath(String path) async {
    final f_s.Reference _ref = _getRefByPath(path);
    final String _url = await _createURLByRef(ref: _ref);
    return _url;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<String> createURLByNodes({
    @required String coll,
    @required String doc, // without extension
  }) async {
    final f_s.Reference _ref = _getRefByNodes(
      coll: coll,
      doc: doc,
    );
    final String _url = await _createURLByRef(ref: _ref);
    return _url;
  }
  // -----------------------------------------------------------------------------

  /// READ DOC

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
          final f_s.Reference _ref = _getRefByPath(path);
          blog('got ref : $_ref');
          /// 10'485'760 default max size
          _output = await _ref.getData();
        },
        onError: (String error){
          blog('ERROR : readBytesByPath : path : $path');
          StorageError.onException(error);
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File> readFileByURL({
    @required String url,
  }) async {
    File _file;

    if (url != null) {

      final f_s.Reference _ref = await _getRefByURL(
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
  /// TASK : TEST ME
  static Future<File> readFileByNodes({
    @required String coll,
    @required String doc,
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

    final f_s.Reference _ref = _getRefByNodes(
      coll: coll,
      doc: doc,
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
  // -----------------------------------------------------------------------------

  /// READ META DATA

  // --------------------
  /// TASK : TEST ME
  static Future<StorageMetaModel> readMetaByPath({
    @required String path,
  }) async {
    StorageMetaModel _output;

    if (TextCheck.isEmpty(path) == false){

      await tryAndCatch(
          invoker: 'readBytesByPath',
          functions: () async {
            final f_s.Reference _ref = _getRefByPath(path);
            final f_s.FullMetadata _meta = await _ref.getMetadata();

            _output = StorageMetaModel.decipherOfficialFullMetaData(
              fullMetadata: _meta,
            );

            },
          onError: (String error){
            StorageError.onException(error);
          });

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<StorageMetaModel> readMetaByURL({
    @required String url,
  }) async {
    StorageMetaModel _output;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      await tryAndCatch(
        invoker: 'getMetaByURL',
        functions: () async {

          final f_s.Reference _ref = await _getRefByURL(
            url: url,
          );

            final f_s.FullMetadata _meta = await _ref.getMetadata();

            _output = StorageMetaModel.decipherOfficialFullMetaData(
              fullMetadata: _meta,
            );

        },
      );

    }

    return _output;
  }
  // --------------------
  /// NOT USED
  /*
    // --------------------
  /// TESTED : WORKS PERFECT
  static Future<f_s.FullMetadata> _readMetaByNodes({
    @required String coll,
    @required String doc,
  }) async {

    f_s.FullMetadata _meta;

    blog('getMetaByNodes : $coll/$doc');

    if (coll != null && doc != null){

      await tryAndCatch(
        invoker: 'getMetaByNodes',
        functions: () async {

          final f_s.Reference _ref = _getRefByNodes(
            coll: coll,
            doc: doc,
          );

          _meta = await _ref?.getMetadata();

        },
      );


    }

    return _meta;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> _readOwnersIDsByURL({
    @required String url,
  }) async {
    final List<String> _ids = [];

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final f_s.FullMetadata _metaData = await _readMetaByURL(
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
  static Future<List<String>> _readOwnersIDsByNodes({
    @required String coll,
    @required String doc,
  }) async {
    final List<String> _ids = [];

    if (doc != null && coll != null){

      final f_s.FullMetadata _metaData = await _readMetaByNodes(
        coll: coll,
        doc: doc,
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
  static Future<String> _readDocNameByURL({
    @required String url,
    // @required bool withExtension,
  }) async {
    blog('getImageNameByURL : START');
    String _output;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final f_s.Reference _ref = await _getRefByURL(
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
   */
  // -----------------------------------------------------------------------------

  /// UPDATE META

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateMetaByURL({
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

      final f_s.Reference _ref = await _getRefByURL(
        url: picURL,
      );

      // final f_s.FullMetadata _meta = await _ref.getMetadata();

      final f_s.SettableMetadata metaData = f_s.SettableMetadata(
        customMetadata: metaDataMap,
      );

      await _ref.updateMetadata(metaData);

      // Storage.blogf_s.FullMetaData(_meta);

    }

    blog('updatePicMetaData : END');

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteDoc({
    @required String path,
    @required String currentUserID,
  }) async {

    if (TextCheck.isEmpty(path) == false){

      final bool _canDelete = await _checkCanDeleteDocByPath(
        path: path,
        userID: currentUserID,
      );

      if (_canDelete == true){

        await tryAndCatch(
          invoker: 'deleteDoc',
          functions: () async {
            final f_s.Reference _picRef = _getRefByPath(path);
            await _picRef?.delete();
            blog('deletePic : DELETED STORAGE FILE IN PATH: $path');
          },
          onError: (String error){
            StorageError.onException(error);
          }
        );

      }

      else {
        blog('deletePic : CAN NOT DELETE STORAGE FILE');
      }

    }

  }
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

  /// CHECKERS

  // --------------------
  /// TASK : TEST ME
  static Future<bool> _checkCanDeleteDocByPath({
    @required String path,
    @required String userID,
  }) async {

    assert(path != null, 'path is null');

    bool _canDelete = false;

    blog('checkCanDeleteStorageFile : START');

    if (path != null && userID != null){

      final StorageMetaModel _meta = await readMetaByPath(
        path: path,
      );

      final List<String> _ownersIDs = _meta?.ownersIDs;

      blog('checkCanDeleteStorageFile : _ownersIDs : $_ownersIDs');

      if (Mapper.checkCanLoopList(_ownersIDs) == true){

        _canDelete = Stringer.checkStringsContainString(
          strings: _ownersIDs,
          string: userID,
        );

        blog('checkCanDeleteStorageFile : _canDelete : $_canDelete');

      }

    }

    blog('checkCanDeleteStorageFile : END');
    return _canDelete;
  }
  // --------------------
  /// NOT USED
  /*
  /// TESTED : WORKS PERFECT
  static Future<bool> _checkCanDeleteDocByNodes({
    @required String coll,
    @required String oc,
    @required String userID,
  }) async {

    assert(oc != null && coll != null,
    'checkCanDeleteStorageFile : fileName or storageDocName can not be null');

    bool _canDelete = false;

    if (oc != null && coll != null){

      final f_s.Reference _ref = _getRefByNodes(
          coll: coll,
          doc: oc,
        );

      _canDelete = await _checkCanDeleteDocByPath(
        path: _ref.fullPath,
        userID: userID,
      );

    }

    return _canDelete;
  }
   */
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// NOT USED
  /*
  /// TESTED : WORKS PERFECT
  static void blogRef(f_s.Reference ref){
    blog('BLOGGING STORAGE IMAGE f_s.REFERENCE ------------------------------- START');

    if (ref == null){
      blog('f_s.Reference is null');
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

    blog('BLOGGING STORAGE IMAGE f_s.REFERENCE ------------------------------- END');
  }
   */
  // -----------------------------------------------------------------------------
}

  /*
  /// TESTED: WORKS PERFECT
  static Future<String> _getPathByURL(String url) async {
    String _path;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      final f_s.Reference _ref = await _getRefByURL(url: url);
      _path = _ref.fullPath;

    }

    // blog('getPathByURL : _path : $_path');

    return _path;
  }
   */

  /*
class OldStorageMethods {
  // -----------------------------------------------------------------------------

  const OldStorageMethods();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /*
  /// protocol
  /// TESTED : WORKS PERFECT
  static Future<String> createStoragePicAndGetURL({
    @required File inputFile,
    @required String collName,
    @required String docName,
    @required List<String> ownersIDs,
  }) async {

    /// NOTE
    /// creates new pic in document name according to pic type,
    /// and overrides existing pic if already exists

    String _imageURL;

    await tryAndCatch(
        invoker: 'createStoragePicAndGetURL',
        functions: () async {

          final Dimensions imageSize = await Dimensions.superDimensions(inputFile);

          final Map<String, String> _metaDataMap = <String, String>{
            'width': '${imageSize.width}',
            'height': '${imageSize.height}',
          };

          _imageURL = await Storage.uploadFileAndGetURL(
            storageCollName: collName,
            docName: docName,
            file: inputFile,
            ownersIDs: ownersIDs,
            metaDataAddOn: _metaDataMap,
          );

        });

    return _imageURL;
  }
   */
  // --------------------
  /*
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
            inputFile: slides[index].picPath,
            collName: StorageColl.slides,
            ownersIDs: <String>[bzCreatorID, flyerAuthorID],
            docName: SlideModel.generateSlideID(
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
   */
  // --------------------
  /*
  /// protocol
  static Future<List<String>> createMultipleStoragePicsAndGetURLs({
    @required List<File> files,
    @required List<String> docsNames,
    @required List<String> ownersIDs,
    @required String collName,
  }) async {

    final List<String> _picsURLs = <String>[];

    if (
        Mapper.checkCanLoopList(files)
        &&
        Mapper.checkCanLoopList(docsNames)
        &&
        files.length == docsNames.length
    ) {

      await Future.wait(<Future>[

        ...List.generate(files.length, (index){

          final File _file = files[index];
          final String _name = docsNames[index];

          return createStoragePicAndGetURL(
            inputFile: _file,
            collName: collName,
            docName: _name,
            ownersIDs: ownersIDs,
          ).then((String url){
            _picsURLs.add(url);
          });

      }),

      ]);

    }

    return _picsURLs;
  }
   */
  // --------------------
  /*
  /// protocol
  /// TASK : createStoragePicFromAssetAndGetURL not tested properly
  static Future<String> createStoragePicFromLocalAssetAndGetURL({
    @required String asset,
    @required String docName,
    @required String collName,
    @required List<String> ownersIDs,
  }) async {
    String _url;

    final File _result = await Filers.getFileFromLocalRasterAsset(
      localAsset: asset,
    );

    blog('uploading $docName pic to fireStorage in folder of $collName');

    _url = await createStoragePicAndGetURL(
      docName: docName,
      collName: collName,
      inputFile: _result,
      ownersIDs: ownersIDs,
    );

    blog('uploaded pic : $_url');

    return _url;
  }
   */
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<String> updateExistingPic({
    @required String oldURL,
    @required File newPic,
  }) async {
    String _output;

    if (oldURL != null && newPic != null){

      await tryAndCatch(
        invoker: 'updateExistingPic',
        functions: () async {

          final f_s.Reference _ref = await StorageRef.byURL(
            url: oldURL,
          );

          final f_s.FullMetadata _fullMeta = await _ref?.getMetadata();

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
   */
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<String> createOrUpdatePic({
    @required String oldURL,
    @required File newPic,
    @required String collName,
    @required String docName,
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
        collName: collName,
        docName: docName,
      );

    }

    return _outputURL;
  }
   */
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /*
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
          invoker: 'deleteStoragePic',
          functions: () async {

            final f_s.Reference _picRef = StorageRef.byNodes(
              collName: collName,
              docName: docName,
            );

            // blog('pic ref : $_picRef');
            // final f_s.FullMetadata _metaData = await _picRef?.getMetadata();
            // blogf_s.FullMetaData(_metaData);

            await _picRef?.delete();
          },
          onError: (String error) async {

            const String _noImageError = '[firebase_storage/object-not-found] No object exists at the desired f_s.reference.';
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
   */
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
}


 */
