part of super_fire;

class NativeFireMapper {
  // -----------------------------------------------------------------------------

  const NativeFireMapper();

  // -----------------------------------------------------------------------------
  /// TASK : TEST ME
  static List<Map<String, dynamic>> getMapsFromNativePage({
    @required fd.Page<fd.Document> page,
    bool addDocsIDs = false,
  }) {
    final List<Map<String, dynamic>> _output = [];

    if (page != null && page.isNotEmpty == true) {
      for (final fd.Document _doc in page) {
        final Map<String, dynamic> _map = getMapFromNativeDoc(
          doc: _doc,
          addDocID: addDocsIDs,
        );

        _output.add(_map);
      }
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static Map<String, dynamic> getMapFromNativeDoc({
    @required fd.Document doc,
    bool addDocID = false,
  }) {
    Map<String, dynamic> _output;

    if (doc != null) {
      _output = doc.map;

      if (addDocID == true) {
        _output = Mapper.insertPairInMap(
          map: _output,
          key: 'id',
          value: doc.id,
        );
      }
    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static List<Map<String, dynamic>> mapDocs(List<fd.Document> docs) {
    final List<Map<String, dynamic>> _maps = NativeFireMapper.getMapsFromNativePage(
      page: docs,
      addDocsIDs: true,
    );
    return _maps;
  }
  // --------------------
  /// TASK : TEST ME
  static Map<String, dynamic> mapDoc(fd.Document doc) {
    final Map<String, dynamic> _map = NativeFireMapper.getMapFromNativeDoc(
      doc: doc,
      addDocID: true,
    );
    return _map;
  }
  // -----------------------------------------------------------------------------

  /// DATA SNAPSHOT

  // --------------------
  /// TASK : TEST ME
  static Map<String, dynamic> getMapFromDataSnapshot({
    @required f_d.DataSnapshot snapshot,
    bool addDocID = true,
    Function onExists,
    Function onNull,
  }){
    Map<String, dynamic> _output;

    if (snapshot != null && snapshot.value != null) {

      blog('snapshot.value : ${snapshot.value} : type : ${snapshot.value.runtimeType}');

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
  /// TASK : TEST ME
  static List<Map<String, dynamic>> getMapsFromDataSnapshot({
    @required f_d.DataSnapshot snapshot,
    // bool addDocID = true,
  }) {
    List<Map<String, dynamic>> _output;

    if (snapshot != null && snapshot.value != null) {

      // blog('snapshot type : ${snapshot.value.runtimeType}');

      // if (snapshot.value.runtimeType.toString() == 'List<Object?>'){

        _output = [];

        final List<dynamic> _dynamics = snapshot.value.toList();

        for (final dynamic object in _dynamics){

          final Map<String, dynamic> _maw = getMapFromDataSnapshot(
            snapshot: object,
            // addDocID: true,
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
  // -----------------------------------------------------------------------------

  /// INCREMENTATION

  // --------------------
  /// TASK : TEST ME
  static Map<String, dynamic> incrementFields({
    @required Map<String, dynamic> baseMap,
    @required Map<String, int> incrementationMap,
    @required bool isIncrementing,
  }){

    Map<String, dynamic> _output = Mapper.insertMapInMap(
        baseMap: {},
        insert: baseMap,
    );

    if (incrementationMap != null){

      final List<String> _keys = incrementationMap.keys.toList();
      final int _incrementer = isIncrementing == true ? 1 : -1;

      if(Mapper.checkCanLoopList(_keys) == true){

        for (final String _key in _keys){

          final int _currentValue = _output[_key] ?? 0;
          final int _increment = incrementationMap[_key] * _incrementer;
          final int _newValue = _currentValue + _increment;

            _output = Mapper.insertPairInMap(
              map: _output,
              key: _key,
              value: _newValue,
              overrideExisting: true,
            );

        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
