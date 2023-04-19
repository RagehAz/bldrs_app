part of super_fire;

class OfficialFireMapper {
  // -----------------------------------------------------------------------------

  const OfficialFireMapper();

  // -----------------------------------------------------------------------------

  /// QUERY SNAPSHOT - QUERY DOCUMENT SNAPSHOT

  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromQuerySnapshot({
    @required cloud.QuerySnapshot<Object> querySnapshot,
    @required bool addDocsIDs,
    @required bool addDocSnapshotToEachMap,
  }) {

    return getMapsFromQueryDocumentSnapshotsList(
      queryDocumentSnapshots: querySnapshot?.docs,
      addDocsIDs: addDocsIDs,
      addDocSnapshotToEachMap: addDocSnapshotToEachMap,
    );
  }
  // --------------------
  /// TASK : TEST ME
  static List<Map<String, dynamic>> mapSnapshots(cloud.QuerySnapshot<Map<String, dynamic>> querySnapshot){

    final List<Map<String, dynamic>> _maps = getMapsFromQuerySnapshot(
      querySnapshot: querySnapshot,
      addDocsIDs: true,
      addDocSnapshotToEachMap: true,
    );

    return _maps;
  }
  // -----------------------------------------------------------------------------

  /// QUERY DOCUMENT SNAPSHOT

  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromQueryDocumentSnapshotsList({
    @required List<cloud.QueryDocumentSnapshot<Object>> queryDocumentSnapshots,
    @required bool addDocsIDs,
    @required bool addDocSnapshotToEachMap,
  }) {

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.checkCanLoopList(queryDocumentSnapshots) == true) {
      for (final cloud.QueryDocumentSnapshot<Object> docSnapshot in queryDocumentSnapshots) {

        Map<String, dynamic> _map = docSnapshot.data();

        if (addDocsIDs == true) {
          _map['id'] = docSnapshot.id;
        }

        if (addDocSnapshotToEachMap == true) {
          _map = Mapper.insertPairInMap(
            map: _map,
            key: 'docSnapshot',
            value: docSnapshot,
          );
        }

        _maps.add(_map);
      }
    }

    return _maps;
  }
  // -----------------------------------------------------------------------------

  /// DOCUMENT SNAPSHOT

  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static Map<String, dynamic> getMapFromDocumentSnapshot({
    @required cloud.DocumentSnapshot<Object> docSnapshot,
    @required bool addDocID,
    @required bool addDocSnapshot,
  }) {

    Map<String, dynamic> _map = docSnapshot?.data();

    if (docSnapshot != null && docSnapshot.exists == true){

      if (addDocID == true) {
        _map['id'] = docSnapshot.id;
      }

      if (addDocSnapshot == true) {
        _map = Mapper.insertPairInMap(
          map: _map,
          key: 'docSnapshot',
          value: docSnapshot,
        );
      }

    }

    return _map;
  }
  // --------------------
  /// TASK : TEST ME
  static Map<String, dynamic> mapSnapshot(cloud.DocumentSnapshot<Object> docSnapshot){

    final Map<String, dynamic> _map = getMapFromDocumentSnapshot(
      docSnapshot: docSnapshot,
      addDocID: true,
      addDocSnapshot: true,
    );

    return _map;
  }
  // -----------------------------------------------------------------------------

  /// DATA SNAPSHOT

  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static Map<String, dynamic> getMapFromDataSnapshot({
    @required f_db.DataSnapshot snapshot,
    @required bool addDocID,
    Function onExists,
    Function onNull,
  }){
    Map<String, dynamic> _output;

    if (snapshot.exists) {

      // blog('snapshot.value : ${snapshot.value} : type : ${snapshot.value.runtimeType}');

      if (snapshot.value.runtimeType.toString() == '_InternalLinkedHashMap<Object?, Object?>'){
        _output = Mapper.getMapFromIHLMOO(
          ihlmoo: snapshot.value,
        );
      }
      else {
        _output = Map<String, dynamic>.from(snapshot.value);
      }


      if (addDocID == true){
        _output = Mapper.insertPairInMap(
          map: _output,
          key: 'id',
          value: snapshot.key,
        );
      }

      if (onExists != null){
        onExists();
      }
    }

    else {
      if (onNull != null){
        onNull();
      }
    }

    return _output;
  }
  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromDataSnapshot({
    @required f_db.DataSnapshot snapshot,
    bool addDocID = true,
  }) {
    List<Map<String, dynamic>> _output;

    if (snapshot.exists) {

      // blog('snapshot type : ${snapshot.value.runtimeType}');

      // if (snapshot.value.runtimeType.toString() == 'List<Object?>'){

        _output = [];

        final List<dynamic> _dynamics = snapshot.children.toList();

        for (final dynamic object in _dynamics){

          final Map<String, dynamic> _maw = getMapFromDataSnapshot(
            snapshot: object,
            addDocID: addDocID,
          );

          _output.add(_maw);

        }

      // }

      // if (snapshot.value.runtimeType.toString() == '_InternalLinkedHashMap<Object?, Object?>'){
      //
      //   final Map<String, dynamic> _map = getMapFromInternalHashLinkedMapObjectObject(
      //     internalHashLinkedMapObjectObject: snapshot.value,
      //   );
      //
      //   Mapper.blogMap(_map, invoker: 'the fookin maw');
      //
      //   _output = [];
      //   if (_map != null){
      //     _output.add(_map);
      //   }
      //
      // }


    }

    return _output;
  }
  // --------------------
  /// MANUALLY TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> getMapsFromDataSnapshots({
    @required List<f_db.DataSnapshot> snapshots,
    @required bool addDocsIDs,
  }){

    final List<Map<String, dynamic>> _output = <Map<String, dynamic>>[];

    if (Mapper.checkCanLoopList(snapshots) == true){

      for (final f_db.DataSnapshot snap in snapshots){

        final Map<String, dynamic> _map = getMapFromDataSnapshot(
          snapshot: snap,
          addDocID: addDocsIDs,
        );

        _output.add(_map);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// REAL INCREMENTATION MAP

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> createPathValueMapFromIncrementationMap({
    @required Map<String, int> incrementationMap,
    @required bool isIncrementing,
  }){

    /*
    /// INCREMENTATION MAP LOOK LIKE THIS
    final Map<String, int> _incrementationMap = {
      'key1': 1,
      'key2': 2,
    };
     */

    Map<String, dynamic> _output = {};

    final List<String> _keys = incrementationMap.keys.toList();

    if (Mapper.checkCanLoopList(_keys) == true){

      for (final String key in _keys){

        int _incrementationValue = incrementationMap[key];
        if (isIncrementing == false){
          _incrementationValue = -_incrementationValue;
        }

        _output = Mapper.insertPairInMap(
            map: _output,
            key: key,
            value: f_db.ServerValue.increment(_incrementationValue)
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogDatabaseEvent({
    @required f_db.DatabaseEvent event,
    String invoker = 'blogDatabaseEvent',
  }){
    blog('blogDatabaseEvent : $invoker ----------------------- START');

    if (event != null){
      blog('event.snapshot : ${event.snapshot}');
      blog('event.snapshot.value : ${event.snapshot.value}');
      blog('event.snapshot.key : ${event.snapshot.key}');
      blog('event.snapshot.children : ${event.snapshot.children}');
      blog('event.snapshot.ref : ${event.snapshot.ref}');
      blog('event.snapshot.exists : ${event.snapshot.exists}');
      blog('event.snapshot.priority : ${event.snapshot.priority}');
      blog('event.snapshot.child("id") : ${event.snapshot.child('id')}');
      blog('event.snapshot.hasChild("id") : ${event.snapshot.hasChild('id')}');
      blog('event.type : ${event.type}');
      blog('event.type.name : ${event.type.name}');
      blog('event.type.index : ${event.type.index}');
      blog('event.previousChildKey : ${event.previousChildKey}');
    }
    else {
      blog('event is null');
    }


    blog('blogDatabaseEvent : $invoker ----------------------- END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogDataSnapshot ({
    @required f_db.DataSnapshot snapshot,
    String invoker = 'blogDataSnapshot',
  }){
    blog('blogDataSnapshot : $invoker ----------------------- START');
    if (snapshot != null){
      blog('snapshot.key : ${snapshot.key}');
      blog('snapshot.value : ${snapshot.value}');
      blog('snapshot.value.runtimeType : ${snapshot.value.runtimeType}');
      blog('snapshot.children : ${snapshot.children}');
      blog('snapshot.priority : ${snapshot.priority}');
      blog('snapshot.exists : ${snapshot.exists}');
      blog('snapshot.ref : ${snapshot.ref}');
      blog('snapshot.hasChild("id") : ${snapshot.hasChild('id')}');
      blog('snapshot.child("id") : ${snapshot.child('id')}');
    }
    else {
      blog('snapshot is null');
    }
    blog('blogDataSnapshot : $invoker ----------------------- END');
  }
  // -----------------------------------------------------------------------------
}
