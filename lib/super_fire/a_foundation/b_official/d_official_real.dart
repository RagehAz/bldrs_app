part of super_fire;

/// => TAMAM
class _OfficialReal {
  // -----------------------------------------------------------------------------

  const _OfficialReal();

  // -----------------------------------------------------------------------------

  /// REF

  // --------------------
  /// TESTED : WORKS PERFECT
  static f_db.DatabaseReference _createPathAndGetRef({
    @required String coll,
    String doc,
    String key,
  }){
    final String path = RealQueryModel.createRealPath(
      coll: coll,
      doc: doc,
      key: key,
    );
    return _OfficialFirebase.getReal().ref(path);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static f_db.DatabaseReference _getRefByPath({
    @required String path,
  }){
    assert(path != null, 'PATH SHOULD NOT BE NULL');
    return _OfficialFirebase.getReal().ref(path);
  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
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
          final f_db.DatabaseReference _ref = _createPathAndGetRef(
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> createDoc({
    @required String coll,
    @required Map<String, dynamic> map,
  }) async {

    Map<String, dynamic> _output;
    String _docID;

    if (map != null && coll != null){

      await tryAndCatch(
        invoker: 'createDoc',
        functions: () async {

          /// GET PATH
          final f_db.DatabaseReference _ref = _createPathAndGetRef(
            coll: coll,
          );

          /// ADD EVENT LISTENER
          final StreamSubscription _sub = _ref.onChildAdded.listen((event){

            _docID = event.previousChildKey;

            _output = OfficialFireMapper.getMapFromDataSnapshot(
              snapshot: event.snapshot,
              addDocID: true,
              onNull: () => blog('Real.createDoc : failed to create doc '),
            );

            _output = Mapper.insertPairInMap(
              map: _output,
              key: 'id',
              value: _docID,
              overrideExisting: true,
            );

          });

          /// CREATE
          await _ref.push().set(map);

          /// CANCEL EVENT LISTENER
          await _sub.cancel();

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
  static Future<void> createNamedDoc({
    @required String coll,
    @required String doc,
    @required Map<String, dynamic> map,
    bool pushNodeOneStepDeepWithUniqueID = false,
    bool isUpdating = false,
  }) async {

    if (map != null){

      f_db.DatabaseReference _ref = _createPathAndGetRef(
        coll: coll,
        doc: doc,
      );

      if (pushNodeOneStepDeepWithUniqueID == true){
        _ref = _ref.push();
      }

      await tryAndCatch(
        invoker: 'createNamedDoc',

        functions: () async {

          await _ref.set(map);

          // blog('Real.reateNamedDoc : added to [REAL/$collName/$docName] : '
          //     'push is $pushNodeOneStepDeepWithUniqueID : map : ${map.keys.length} keys');

        },

      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> createDocInPath({
    @required String pathWithoutDocName,
    @required Map<String, dynamic> map,
    /// random id is assigned as docName if this parameter is not assigned
    String docName,
  }) async {

    // blog('X - createDocInPath ================================ START');

    Map<String, dynamic> _map = map;

    if (_map != null){
      String _docID;

      await tryAndCatch(
        invoker: 'createDoc',
        functions: () async {

          final String _path = docName == null ? pathWithoutDocName : '$pathWithoutDocName/$docName';

          /// GET PATH
          f_db.DatabaseReference _ref = _getRefByPath(
            path: _path,
          );

          /// ADD EVENT LISTENER
          final StreamSubscription _sub = _ref.onChildAdded.listen((f_db.DatabaseEvent event){

            _docID = event.previousChildKey;

            if (_docID != null){
              _map = Mapper.insertPairInMap(
                map: _map,
                key: 'id',
                value: _docID,
              );
            }

          });

          if (docName == null){
            _ref = _ref.push();
          }

          /// CREATE
          await _ref.set(_map);


          /// CANCEL EVENT LISTENER
          await _sub.cancel();

        },
      );
    }

    // if (_map != null){
    //   blog('Real.createDoc : map added to [REAL/$pathWithoutDocName] : map : ${_map.keys.length} keys');
    // }

    // blog('X - createDocInPath ================================ END');

    return _map;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, dynamic>>> readPathMaps({
    @required RealQueryModel realQueryModel,
    Map<String, dynamic> startAfter,
  }) async {

    List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    await tryAndCatch(
      functions: () async {

        final f_db.Query _query = RealQueryModel.createOfficialRealQuery(
          queryModel: realQueryModel,
          lastMap: startAfter,
        );

        // final fireDB.DataSnapshot _snap = await _query.get();

        final f_db.DatabaseEvent _event = await _query.once();


        _output = OfficialFireMapper.getMapsFromDataSnapshot(
          snapshot: _event.snapshot,
          addDocID: false,
        );

        // Mapper.blogMaps(_output, invoker: 'readPathMaps');


      },
    );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> readPathMap({
    @required String path,
  }) async {

    Map<String, dynamic> _output = {};

    await tryAndCatch(
      functions: () async {

        final f_db.DatabaseReference _ref = _getRefByPath(path: path);

        final f_db.DataSnapshot _snap = await _ref.get();

        _output = OfficialFireMapper.getMapFromDataSnapshot(
          snapshot: _snap,
          addDocID: false,
        );

      },
    );

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> readPath({
    /// looks like : 'collName/docName/...'
    @required String path,
  }) async {

    dynamic _output;

    if (TextCheck.isEmpty(path) == false){

      final f_db.DatabaseReference _ref = _getRefByPath(path: path);

      await tryAndCatch(
        functions: () async {

          final f_db.DatabaseEvent event = await _ref.once(f_db.DatabaseEventType.value);

          _output = event.snapshot.value;

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

    Map<String, dynamic> _output;

    final String _path = RealQueryModel.createRealPath(
      coll: coll,
      doc: doc,
    );

    await tryAndCatch(
      functions: () async {

        final f_db.DataSnapshot snapshot = await _OfficialFirebase.getReal().ref().child(_path).get();

        _output = OfficialFireMapper.getMapFromDataSnapshot(
          snapshot: snapshot,
          onNull: () => blog('Real.readDoc : No data available : path : $_path.'),
          addDocID: true,
          // onExists:
        );

      },
    );

    // if (_output != null){
    //   blog('Real.readDoc : found map in (REAL/$collName/$docName) of ${_output.keys.length} keys');
    // }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> readDocOnce({
    @required String coll,
    @required String doc,
  }) async {

    final f_db.DatabaseReference ref = _createPathAndGetRef(
      coll: coll,
      doc: doc,
    );

    Map<String, dynamic> _map;

    await tryAndCatch(
      functions: () async {

        final f_db.DatabaseEvent event = await ref.once(f_db.DatabaseEventType.value);

        _map = OfficialFireMapper.getMapFromDataSnapshot(
          snapshot: event.snapshot,
          addDocID: true,
        );

      },
    );

    // if (_map != null){
      // blog('Real.readDocOnce : map read from [REAL/$collName/$docName] : map : ${_map.length} keys');
    // }

    return _map;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static Future<void> updateDoc({
    @required String coll,
    @required String doc,
    @required Map<String, dynamic> map,
  }) async {

    if (map != null){

      await createNamedDoc(
        coll: coll,
        doc: doc,
        map: map,
        isUpdating: true,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
          docName: _docName,
          map: map,
        );

      }

    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateDocField({
    @required String coll,
    @required String doc,
    @required String field,
    @required dynamic value,
  }) async {

    // blog('updateDocField : START');

    /// NOTE : if value is null the pair will be deleted on real db map

    if (coll != null && doc != null && field != null){

      final f_db.DatabaseReference _ref = _createPathAndGetRef(
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
  /// TESTED : WORKS PERFECT
  static Future<void> incrementDocFields({
    @required String coll,
    @required String doc,
    @required Map<String, int> incrementationMap,
    @required bool isIncrementing,
  }) async {

    if (incrementationMap != null){

      final f_db.DatabaseReference _ref = _createPathAndGetRef(
        coll: coll,
        doc: doc,
      );

      final Map<String, dynamic> _updatesMap = OfficialFireMapper.createPathValueMapFromIncrementationMap(
        incrementationMap: incrementationMap,
        isIncrementing: isIncrementing,
      );

      await _ref.update(_updatesMap);

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteDoc({
    @required String coll,
    @required String doc,
  }) async {

    final f_db.DatabaseReference _ref = _createPathAndGetRef(
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static Future<void> deletePath({
    @required String pathWithDocName,
  }) async {

    if (TextCheck.isEmpty(pathWithDocName) == false){

      final f_db.DatabaseReference _ref = _getRefByPath(
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
  /// TESTED : WORKS PERFECT
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

      final f_db.DatabaseReference _ref = _getRefByPath(
        path: newColl,
      );

      await tryAndCatch(functions: () async {
        await _ref.set(_object);
      });

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> clonePath({
    @required String oldPath,
    @required String newPath,
  }) async {

    blog('1 - clonePath : START');

    final Object _object = await readPath(path: oldPath);

    blog('2 - clonePath : GOT OBJECT : ( ${_object != null} )');

    if (_object != null){

      final f_db.DatabaseReference _ref = _getRefByPath(
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

  /// TRANSACTION & ATOMICS & LISTENERS

  // --------------------
  /// EXPERIMENTAL
  /*
  static Future<f_db.TransactionResult> runTransaction ({
    @required BuildContext context,
    @required String coll,
    @required String oc,
    @required Function(Map<String, dynamic> map) doStuff,
    @required bool applyLocally,
  }) async {

    final f_db.DatabaseReference _ref = createPathAndGetRef(
        coll: coll,
        doc: oc
    );

    final f_db.TransactionResult _result = await _ref.runTransaction((Object map){

      // Ensure a map at the ref exists.
      if (map == null) {
        return f_db.Transaction.abort();
      }

      else {

        final Map<String, dynamic> _map = Map<String, dynamic>.from(map as Map);

        doStuff(_map);

        return f_db.Transaction.success(_map);
      }

    },
      applyLocally: applyLocally,
    );

    blog('runTransaction : _result.committed : ${_result.committed} : _result.snapshot : ${_result.snapshot}');

    return _result;
  }
   */
  // -----------------------------------------------------------------------------
}

/// OLD METHODS
  /*
  static fireDB.DatabaseReference  _getRefFromURL({
  @required String url,
}){
    return fireDB.FirebaseDatabase.instance.refFromURL(url);
  }
    // --------------------
  static Future<void> updateMultipleDocsAtOnce({
    @required List<RealNode> nodes,

  }) async {

    // Get a key for a new Post.
    final newPostKey = fireDB.FirebaseDatabase.instance.ref().child('posts').push().key;

    final Map<String, Map> updates = {};
    updates['/posts/$newPostKey'] = postData;
    updates['/user-posts/$uid/$newPostKey'] = postData;

    return fireDB.FirebaseDatabase.instance.ref().update(updates);
  }

  void addStar(uid, key) async {
    Map<String, Object?> updates = {};
    updates["posts/$key/stars/$uid"] = true;
    updates["posts/$key/starCount"] = ServerValue.increment(1);
    updates["user-posts/$key/stars/$uid"] = true;
    updates["user-posts/$key/starCount"] = ServerValue.increment(1);
    return fireDB.FirebaseDatabase.instance.ref().update(updates);
  }

    // --------------------


  // static Future<Map<String, dynamic>> createNamedDocInPath({
  //   @required BuildContext context,
  //   @required String path,
  //   @required String docName,
  //   @required bool addDocIDToOutput,
  //   @required Map<String, dynamic> map,
  // }) async {
  //
  //   DatabaseReference _ref = _getRefByPath(path: path)
  //
  //   await tryAndCatch(
  //     context: context,
  //     invoker: 'createNamedDoc',
  //
  //     functions: () async {
  //
  //       await _ref.set(map);
  //
  //       blog('Real.createNamedDoc : added to [$path$docName] : push is $pushNodeOneStepDeepWithUniqueID : map : $map');
  //
  //     },
  //
  //   );
  //
  //
  // }
   */
