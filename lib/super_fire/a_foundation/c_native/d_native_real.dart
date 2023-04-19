part of super_fire;

class _NativeReal {
  // -----------------------------------------------------------------------------

  const _NativeReal();

  // -----------------------------------------------------------------------------

  /// REF

  // --------------------
  /// TESTED : WORKS PERFECT
  static f_d.DatabaseReference _createPathAndGetRef({
    @required String coll,
    String doc,
    String key,
  }){
    final String path = RealQueryModel.createRealPath(
      coll: coll,
      doc: doc,
      key: key,
    );
    return _NativeFirebase.getReal().reference().child(path);
  }
  // --------------------
  /// TASK : TEST ME
  static f_d.DatabaseReference _getRefByPath({
    @required String path,
  }){
    assert(path != null, 'PATH SHOULD NOT BE NULL');
    return _NativeFirebase.getReal().reference().child(path);
  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> createDoc({
    @required String coll,
    @required Map<String, dynamic> map,
    String doc,
  }) async {

    Map<String, dynamic> _output;

   if (doc == null){
     _output = await _createUnnamedDoc(
       coll: coll,
       map: map,
     );
   }

   else {
     _output = await _createNamedDoc(
       coll: coll,
       doc: doc,
       map: map,
     );
   }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> _createUnnamedDoc({
    @required String coll,
    @required Map<String, dynamic> map,
  }) async {

    Map<String, dynamic> _output;

    String _docID;

    if (map != null && coll != null){

      Map<String, dynamic> _uploaded;

      await tryAndCatch(
        invoker: 'createDoc',
        functions: () async {

          /// GET PATH
          final f_d.DatabaseReference _ref = _createPathAndGetRef(
            coll: coll,
          );

          blog('createDoc got ref : $_ref');

          /// ADD EVENT LISTENER
          // final StreamSubscription _sub =
          _ref.onChildAdded.listen((event){

            _docID = event.previousSiblingKey;

            _uploaded = NativeFireMapper.getMapFromDataSnapshot(
              snapshot: event.snapshot,
              addDocID: true,
              onNull: () => blog('Real.createDoc : failed to create doc '),
            );

            _uploaded = Mapper.insertPairInMap(
              map: _uploaded,
              key: 'id',
              value: _docID,
              overrideExisting: true,
            );

            blog('createDoc got _uploaded with id : $_docID');

          });


          final Map<String, dynamic> _upload = Mapper.removePair(
              map: map,
              fieldKey: 'id',
          );

          /// CREATE
          await _ref.push().set(_upload);

          blog('createDoc pushed map');

          _output = _uploaded;
          // /// CANCEL EVENT LISTENER
          // await _sub.cancel();

          blog('createDoc cancelled sub');

        },
      );


    }

    // if (_output != null){
    //   blog('Real.createDoc : map added to [REAL/$collName/$_docID] : map : ${_output.keys.length} keys');
    // }


    return _output;
  }
  // --------------------

  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> _createNamedDoc({
    @required String coll,
    @required String doc,
    @required Map<String, dynamic> map,
  }) async {
    Map<String, dynamic> _uploaded;

    if (map != null){

      blog('createNamedDoc : start');

      final f_d.DatabaseReference _ref = _createPathAndGetRef(
        coll: coll,
        doc: doc,
      );

      blog('createNamedDoc got ref : $_ref');

      // if (pushNodeOneStepDeepWithUniqueID == true){
      //   _ref = _ref.push();
      // }

      await tryAndCatch(
        invoker: 'createNamedDoc',
        functions: () async {

          blog('createNamedDoc setting map');

          final Map<String, dynamic> _upload = Mapper.removePair(
              map: map,
              fieldKey: 'id',
          );

          await _ref.set(_upload);

          blog('createNamedDoc pushed map');

          // blog('Real.reateNamedDoc : added to [REAL/$collName/$docName] : '
          //     'push is $pushNodeOneStepDeepWithUniqueID : map : ${map.keys.length} keys');

        },

      );

      _uploaded = Mapper.insertPairInMap(
        map: map,
        key: 'id',
        value: doc,
      );

    }

    return _uploaded;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<Map<String, dynamic>> createDocInPath({
    @required String pathWithoutDocName,
    @required Map<String, dynamic> map,
    /// random id is assigned as docName if this parameter is not assigned
    String doc,
  }) async {

    // blog('X - createDocInPath ================================ START');

    Map<String, dynamic> _output;

    if (map != null){
      String _docID;

      await tryAndCatch(
        invoker: 'createDoc',
        functions: () async {

          final String _path = doc == null ? pathWithoutDocName : '$pathWithoutDocName/$doc';

          /// GET PATH
          f_d.DatabaseReference _ref = _getRefByPath(
            path: _path,
          );

          /// ADD EVENT LISTENER
          // final StreamSubscription _sub =
          _ref.onChildAdded.listen((f_d.Event event){

            _docID = event.previousSiblingKey;

            blog('event.previousSiblingKey : ${event.previousSiblingKey}');
            blog('event.snapshot.key : ${event.snapshot.key}');

            // if (_docID != null){
            //   _output = Mapper.insertPairInMap(
            //     map: _output,
            //     key: 'id',
            //     value: _docID,
            //   );
            // }

          });

          if (doc == null){
            _ref = _ref.push();
          }

          final Map<String, dynamic> _upload = Mapper.removePair(
              map: map,
              fieldKey: 'id',
          );

          /// CREATE
          await _ref.set(_upload);


          /// CANCEL EVENT LISTENER
          // await _sub.cancel();

        },
      );

      _output = Mapper.insertPairInMap(
        map: map,
        key: 'id',
        value: _docID,
        overrideExisting: true,
      );

    }

    // if (_output != null){
    //   blog('Real.createDoc : map added to [REAL/$pathWithoutDocName] : map : ${_output.keys.length} keys');
    // }

    // blog('X - createDocInPath ================================ END');

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<Map<String, dynamic>> createColl({
    @required String coll,
    @required Map<String, dynamic> map,
  }) async {
    Map<String, dynamic> _output;

    if (map != null && coll != null){

      await tryAndCatch(
        invoker: 'createColl',
        functions: () async {

          /// GET PATH
          final f_d.DatabaseReference _ref = _createPathAndGetRef(
            coll: coll,
          );

          /// ADD EVENT LISTENER
          final StreamSubscription _sub = _ref.onValue.listen((event){

            // final _docID = event.previousChildKey;

            _output = Mapper.getMapFromIHLMOO(
              ihlmoo: event.snapshot.value,
              // addDocID: false,
              // onNull: () => blog('Real.createColl : failed to create doc '),
            );

            // if (addDocIDToOutput == true){
            //   _output = Mapper.insertPairInMap(
            //     map: _output,
            //     key: 'id',
            //     value: _docID,
            //   );
            // }

          });

          /// CREATE
          await _ref.set(map);

          /// CANCEL EVENT LISTENER
          await _sub.cancel();

        },
      );

    }

    if (_output != null){
      blog('Real.createColl : map added to [REAL/$coll] : map : ${_output.keys.length} keys');
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST ME
  static Future<List<Map<String, dynamic>>> readPathMaps({
    @required RealQueryModel realQueryModel,
    Map<String, dynamic> startAfter,
  }) async {

    List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    await tryAndCatch(
      functions: () async {

        final f_d.Query _query = RealQueryModel.createNativeRealQuery(
          queryModel: realQueryModel,
          lastMap: startAfter,
        );

        // final fireDB.DataSnapshot _snap = await _query.get();

        final f_d.DataSnapshot _dataSnapshot = await _query.once();


        _output = NativeFireMapper.getMapsFromDataSnapshot(
          snapshot: _dataSnapshot,
          // addDocID: false,
        );

        // Mapper.blogMaps(_output, invoker: 'readPathMaps');


      },
    );

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<Map<String, dynamic>> readPathMap({
    @required String path,
  }) async {

    Map<String, dynamic> _output = {};

    await tryAndCatch(
      functions: () async {

        final f_d.DatabaseReference _ref = _getRefByPath(path: path);

        final f_d.DataSnapshot _snap = await _ref.get();

        _output = NativeFireMapper.getMapFromDataSnapshot(
          snapshot: _snap,
          addDocID: false,
        );

      },
    );

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Future<dynamic> readPath({
    /// looks like : 'collName/docName/...'
    @required String path,
  }) async {

    dynamic _output;

    if (TextCheck.isEmpty(path) == false){

      final f_d.DatabaseReference _ref = _getRefByPath(path: path);

      await tryAndCatch(
        functions: () async {

          final f_d.DataSnapshot snapshot = await _ref.once();

          _output = snapshot.value;

        },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> readDoc({
    @required String coll,
    @required String doc,
  }) async {

    final f_d.DatabaseReference ref = _createPathAndGetRef(
      coll: coll,
      doc: doc,
    );

    Map<String, dynamic> _map;

    await tryAndCatch(
      functions: () async {

        final f_d.DataSnapshot snapshot = await ref.once();

        _map = NativeFireMapper.getMapFromDataSnapshot(
          snapshot: snapshot,
          addDocID: true,
        );

      },
    );

    return _map;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TASK : TEST ME
  static Future<void> updateColl({
    @required String coll,
    @required Map<String, dynamic> map,
  }) async {
    if (map != null){

      await createColl(
        coll: coll,
        map: map,
      );

    }
  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> updateDoc({
    @required String coll,
    @required String doc,
    @required Map<String, dynamic> map,
  }) async {

    if (map != null){

      await createDoc(
        coll: coll,
        doc: doc,
        map: map,
      );

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> updatePath({
    @required String path,
    @required Map<String, dynamic> map,
  }) async {

    if (path != null && map != null){

      final String _pathWithoutDocName = TextMod.removeTextAfterLastSpecialCharacter(path, '/');
      final String _docName = TextMod.removeTextBeforeLastSpecialCharacter(path, '/');

      if (
          TextCheck.isEmpty(_pathWithoutDocName) == false
          &&
          TextCheck.isEmpty(_docName) == false
      ){

        await createDocInPath(
          pathWithoutDocName: _pathWithoutDocName,
          doc: _docName,
          map: map,
        );

      }

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> updateDocField({
    @required String coll,
    @required String doc,
    @required String field,
    @required dynamic value,
  }) async {

    // blog('updateDocField : START');

    /// NOTE : if value is null the pair will be deleted on real db map

    if (coll != null && doc != null && field != null){

      final f_d.DatabaseReference _ref = _createPathAndGetRef(
        coll: coll,
        doc: doc,
        key: field,
      );

      /// this is stupid shit
      // if (pushNodeOneStepWithNewUniqueID == true){
      //   _ref = _ref.push();
      // }

      await tryAndCatch(
          functions: () async {

            await _ref.set(value).then((_) {
              // Data saved successfully!
              // blog('Real.updateField : updated (Real/$collName/$docName/$fieldName) : $value');

            })
                .catchError((error) {
              // The write failed...
            });


          }
      );

    }

    // blog('updateDocField : END');

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> incrementDocFields({
    @required String coll,
    @required String doc,
    @required Map<String, int> incrementationMap,
    @required bool isIncrementing,
  }) async {

    if (incrementationMap != null){

      final Map<String, dynamic> _map = await readDoc(
        coll: coll,
        doc: doc,
      );

      final Map<String, dynamic> _updatesMap = NativeFireMapper.incrementFields(
        baseMap: _map,
        incrementationMap: incrementationMap,
        isIncrementing: isIncrementing,
      );

      await updateDoc(
          coll: coll,
          doc: doc,
          map: _updatesMap,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST ME
  static Future<void> deleteDoc({
    @required String coll,
    @required String doc,
  }) async {

    final f_d.DatabaseReference _ref = _createPathAndGetRef(
      coll: coll,
      doc: doc,
    );

    await tryAndCatch(
      functions: () async {

        await _ref.remove();

      },
    );

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> deleteField({
    @required String coll,
    @required String doc,
    @required String field,
  }) async {

    await updateDocField(
      coll: coll,
      doc: doc,
      field: field,
      value: null,
    );

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> deletePath({
    @required String pathWithDocName,
  }) async {

    if (TextCheck.isEmpty(pathWithDocName) == false){

      final f_d.DatabaseReference _ref = _getRefByPath(
        path: pathWithDocName,
      );

      await tryAndCatch(
        functions: () async {
          await _ref.remove();
        },
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// CLONE

  // --------------------
  /// TASK : TEST ME
  static Future<void> cloneColl({
    @required String oldColl, // coll/doc/node/mapName
    @required String newColl, // newColl
  }) async {

    final Object _object = await readPath(path: oldColl);

    if (_object != null){

      // ( remove collName )=> docName/node/mapName
      String _newPath = TextMod.removeTextBeforeFirstSpecialCharacter(oldColl, '/');
      // ( remove mapName )=> docName/node
      _newPath = TextMod.removeTextAfterLastSpecialCharacter(_newPath, '/');
      // ( add newCollName )=> newCollName/docName/node
      _newPath = '$newColl/$_newPath';

      // mapName
      // final String _mapName = TextMod.removeTextBeforeLastSpecialCharacter(oldCollName, '/');

      final f_d.DatabaseReference _ref = _getRefByPath(
        path: newColl,
      );

      await tryAndCatch(functions: () async {
        await _ref.set(_object);
      });

    }

  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> clonePath({
    @required String oldPath,
    @required String newPath,
  }) async {

    blog('1 - clonePath : START');

    final Object _object = await readPath(path: oldPath);

    blog('2 - clonePath : GOT OBJECT : ( ${_object != null} )');

    if (_object != null){

      final f_d.DatabaseReference _ref = _getRefByPath(
        path: newPath,
      );

      blog('3 - clonePath : GOT REF : ( $_ref )');

      await tryAndCatch(
          invoker: 'clonePath',
          functions: () async {

            await _ref.set(_object);

            blog('4 - clonePath : OBJECT IS SET IN NEW PATH');

      });

    }

    blog('5 - clonePath : END');
  }
  // -----------------------------------------------------------------------------
}
