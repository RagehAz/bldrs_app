part of super_fire;

/// => TAMAM
class _OfficialStorage {
  // -----------------------------------------------------------------------------
  /// Note : use picName without file extension <---------------
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
      invoker: 'OfficialStorage._getRefByURL',
      functions: () {
        _ref = _OfficialFirebase.getStorage()?.refFromURL(url);
      },
      onError: StorageError.onException,
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
      invoker: 'OfficialStorage._createURLByRef',
      functions: () async {
        _url = await ref?.getDownloadURL();
        },
      onError: StorageError.onException,
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
    @required StorageMetaModel storageMetaModel,
  }) async {

    assert(Mapper.checkCanLoopList(bytes) == true, 'uInt7List is empty or null');
    assert(storageMetaModel != null, 'metaData is null');
    assert(TextCheck.isEmpty(path) == false, 'path is empty or null');

    String _url;

    await tryAndCatch(
      invoker: 'OfficialStorage.createDocByUint8List',
      functions: () async {

        final f_s.Reference _ref = _getRefByPath(path);

        blog('createDocByUint8List : 1 - got ref : $_ref');

        final f_s.UploadTask _uploadTask = _ref.putData(
          bytes,
          storageMetaModel.toOfficialSettableMetadata(),
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


        },
      onError: StorageError.onException,
    );

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
      invoker: 'OfficialStorage.uploadFile',
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

        },
      onError: StorageError.onException,
    );

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
  static Future<String> createURLByPath({
    @required String path
  }) async {
    final f_s.Reference _ref = _getRefByPath(path);
    final String _url = await _createURLByRef(ref: _ref);
    return _url;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
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
        invoker: 'OfficialStorage.readBytesByPath',
        functions: () async {
          final f_s.Reference _ref = _getRefByPath(path);
          blog('got ref : $_ref');
          /// 10'485'760 default max size
          _output = await _ref.getData();
        },
        onError: StorageError.onException,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> readBytesByURL({
    @required String url
  }) async {
    Uint8List _bytes;

    await tryAndCatch(
      invoker: 'OfficialStorage.readBytesByURL',
      functions: () async {

        if (ObjectCheck.isAbsoluteURL(url) == true) {
          /// call http.get method and pass imageUrl into it to get response.
          final http.Response _response = await Rest.get(
            rawLink: url,
            // timeout: 60,
            invoker: 'OfficialStorage.readBytesByURL',
          );

          if (_response != null && _response.statusCode == 200) {
            _bytes = _response.bodyBytes;
          }

        }

      },
      onError: StorageError.onException,
    );

    return _bytes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File> readFileByURL({
    @required String url,
  }) async {
    File _file;

    await tryAndCatch(
      invoker: 'OfficialStorage.readFileByURL',
      functions: () async {

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
      },
      onError: StorageError.onException,
    );

    return _file;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File> readFileByNodes({
    @required String coll,
    @required String doc,
  }) async {
    File _file;

    await tryAndCatch(
      invoker: 'OfficialStorage.readFileByNodes',
      functions: () async {

        final f_s.Reference _ref = _getRefByNodes(
          coll: coll,
          doc: doc,
        );

        if (_ref != null) {
          final Uint8List _uInts = await _ref.getData();

          _file = await Filers.getFileFromUint8List(
              uInt8List: _uInts,
              fileName: _ref.name,
          );

        }
      },
      onError: StorageError.onException,
    );

    return _file;
  }
  // -----------------------------------------------------------------------------

  /// READ META DATA

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<StorageMetaModel> readMetaByPath({
    @required String path,
  }) async {
    StorageMetaModel _output;

    if (TextCheck.isEmpty(path) == false){

      await tryAndCatch(
          invoker: 'OfficialStorage.readBytesByPath',
          functions: () async {

            final f_s.Reference _ref = _getRefByPath(path);
            final f_s.FullMetadata _meta = await _ref.getMetadata();

            _output = StorageMetaModel.decipherOfficialFullMetaData(
              fullMetadata: _meta,
            );

          },
          onError: StorageError.onException,
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<StorageMetaModel> readMetaByURL({
    @required String url,
  }) async {
    StorageMetaModel _output;

    if (ObjectCheck.isAbsoluteURL(url) == true){

      await tryAndCatch(
        invoker: 'OfficialStorage.getMetaByURL',
        functions: () async {

          final f_s.Reference _ref = await _getRefByURL(
            url: url,
          );

            final f_s.FullMetadata _meta = await _ref.getMetadata();

            _output = StorageMetaModel.decipherOfficialFullMetaData(
              fullMetadata: _meta,
            );

        },
        onError: StorageError.onException,
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
    @required String url,
    @required StorageMetaModel meta,
  }) async {

    /// ASSIGNING NULL TO KEY DELETES PAIR AUTOMATICALLY.

    if (ObjectCheck.isAbsoluteURL(url) == true && meta != null) {

      await tryAndCatch(
        invoker: 'OfficialStorage.updatePicMetaData',
        onError: StorageError.onException,
        functions: () async {

          final f_s.Reference _ref = await _getRefByURL(
            url: url,
          );

          await _ref.updateMetadata(meta.toOfficialSettableMetadata());

        },
      );
    }

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
          invoker: 'OfficialStorage.deleteDoc',
          functions: () async {
            final f_s.Reference _picRef = _getRefByPath(path);
            await _picRef?.delete();
            blog('deletePic : DELETED STORAGE FILE IN PATH: $path');
          },
          onError: StorageError.onException,
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
  /// TESTED : WORKS PERFECT
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
  // -----------------------------------------------------------------------------
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
  // -----------------------------------------------------------------------------
}
