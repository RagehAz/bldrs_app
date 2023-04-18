part of super_fire;

class _NativeStorage {
  // -----------------------------------------------------------------------------

  const _NativeStorage();

  // -----------------------------------------------------------------------------

  /// REFERENCES

  // --------------------
  /// TASK : TEST ME
  static f_d.Reference _getRefByPath(String path){
    return _NativeFirebase.getStorage().ref(path);
  }
  // --------------------
  /// TASK : TEST ME
  static f_d.Reference _getRefByNodes({
    @required String coll,
    @required String doc, // without extension
  }) {

    return _NativeFirebase.getStorage()
        .ref()
        .child(coll)
        .child(doc);

  }
  // --------------------
  /// TASK : TEST ME
  static Future<f_d.Reference> _getRefByURL({
    @required String url,
  }) async {
    f_d.Reference _ref;

    await tryAndCatch(
        invoker: 'StorageRef.byURL',
        functions: () {
          _ref = _NativeFirebase.getStorage().refFromURL(url);
        },
    );

    return _ref;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<String> _createURLByRef({
    @required f_d.Reference ref,
  }) async {

    String _url;

    await tryAndCatch(
        invoker: '_createURLByRef',
        functions: () async {
          _url = await ref.getDownloadURL();
        }
    );

    return _url;
  }
  // -----------------------------------------------------------------------------

  /// CREATE DOC

  // --------------------
  /// TASK : TEST ME
  static Future<String> uploadBytesAndGetURL({
    @required Uint8List bytes,
    @required String path,
    @required StorageMetaModel picMetaModel,
  }) async {

    assert(Mapper.checkCanLoopList(bytes) == true, 'uInt7List is empty or null');
    assert(picMetaModel != null, 'picMetaModel is null');
    assert(TextCheck.isEmpty(path) == false, 'path is empty or null');

    String _url;

    await tryAndCatch(
        invoker: 'createDocByUint8List',
        functions: () async {

          final f_d.Reference _ref = _getRefByPath(path);

          blog('createDocByUint8List : 1 - got ref : $_ref');

          final f_d.UploadTask _uploadTask = _ref.putData(
            bytes,
            picMetaModel.toNativeSettableMetadata(),
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
  /// TASK : TEST ME
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
          final f_d.Reference _ref = _getRefByNodes(
            coll: coll,
            doc: doc,
          );

          blog('uploadFile : 1 - got ref : $_ref');

          blog('uploadFile : 2 - assigned meta data');

          final Uint8List _bytes = await Floaters.getUint8ListFromFile(file);

          if (_bytes != null && _bytes.isNotEmpty == true){

            final f_d.UploadTask _uploadTask = _ref.putData(
            _bytes,
            picMetaModel.toNativeSettableMetadata(),
          );

          blog('uploadFile : 3 - uploaded file : fileName : $doc : file.fileNameWithExtension : ${file.fileNameWithExtension}');

          final f_d.TaskSnapshot _snapshot = await _uploadTask.whenComplete((){
            blog('uploadFile : 4 - upload file completed');
          });

          blog('uploadFile : 5 - task state : ${_snapshot?.state}');

          _fileURL = await _ref.getDownloadURL();
          blog('uploadFile : 6 - got url : $_fileURL');

          }

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
  /// TASK : TEST ME
  static Future<String> createURLByPath(String path) async {
    final f_d.Reference _ref = _getRefByPath(path);
    final String _url = await _createURLByRef(ref: _ref);
    return _url;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<String> createURLByNodes({
    @required String coll,
    @required String doc, // without extension
  }) async {
    final f_d.Reference _ref = _getRefByNodes(
      coll: coll,
      doc: doc,
    );
    final String _url = await _createURLByRef(ref: _ref);
    return _url;
  }
  // -----------------------------------------------------------------------------

  /// READ DOC

  // --------------------
  /// TASK : TEST ME
  static Future<Uint8List> readBytesByPath({
    @required String path,
  }) async {
    Uint8List _output;

    if (TextCheck.isEmpty(path) == false){

      await tryAndCatch(
        invoker: 'readBytesByPath',
        functions: () async {
          final f_d.Reference _ref = _getRefByPath(path);
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
  /// TASK : TEST ME
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
  /// TASK : TEST ME
  static Future<File> readFileByURL({
    @required String url,
  }) async {
    File _file;

    if (url != null) {

      final f_d.Reference _ref = await _getRefByURL(
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

    final f_d.Reference _ref = _getRefByNodes(
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

            final f_d.Reference _ref = _getRefByPath(path);
            final f_d.FullMetadata _meta = await _ref.getMetadata();

            _output = StorageMetaModel.decipherNativeFullMetaData(
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
  static Future<StorageMetaModel> readMetaByURL({
    @required String url,
  }) async {
    StorageMetaModel _output;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      await tryAndCatch(
        invoker: 'getMetaByURL',
        functions: () async {

          final f_d.Reference _ref = await _getRefByURL(
            url: url,
          );

            final f_d.FullMetadata _meta = await _ref.getMetadata();

            _output = StorageMetaModel.decipherNativeFullMetaData(
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
  static Future<f_d.FullMetadata> _readMetaByNodes({
    @required String coll,
    @required String doc,
  }) async {

    f_d.FullMetadata _meta;

    blog('getMetaByNodes : $coll/$doc');

    if (coll != null && doc != null){

      await tryAndCatch(
        invoker: 'getMetaByNodes',
        functions: () async {

          final f_d.Reference _ref = _getRefByNodes(
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

      final f_d.FullMetadata _metaData = await readMetaByURL(
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

      final f_d.FullMetadata _metaData = await _readMetaByNodes(
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

      final f_d.Reference _ref = await _getRefByURL(
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
  /// TASK : TEST ME
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

      final f_d.Reference _ref = await _getRefByURL(
        url: picURL,
      );

      // final f_d.FullMetadata _meta = await _ref.getMetadata();

      final f_d.SettableMetadata metaData = f_d.SettableMetadata(
        customMetadata: metaDataMap,
      );

      await _ref.updateMetadata(metaData);

      // Storage.blog.FullMetaData(_meta);

    }

    blog('updatePicMetaData : END');

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST ME
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
            final f_d.Reference _picRef = _getRefByPath(path);
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
  /// TASK : TEST ME
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
  /// TASK : TEST ME
  static Future<bool> _checkCanDeleteDocByNodes({
    @required String coll,
    @required String oc,
    @required String userID,
  }) async {

    assert(oc != null && coll != null,
    'checkCanDeleteStorageFile : fileName or storageDocName can not be null');

    bool _canDelete = false;

    if (oc != null && coll != null){

      final f_d.Reference _ref = _getRefByNodes(
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
  static void blogRef(f_d.Reference ref){
    blog('BLOGGING STORAGE IMAGE f_d.REFERENCE ------------------------------- START');

    if (ref == null){
      blog('f_d.Reference is null');
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

    blog('BLOGGING STORAGE IMAGE f_d.REFERENCE ------------------------------- END');
  }
   */
  // -----------------------------------------------------------------------------
}
