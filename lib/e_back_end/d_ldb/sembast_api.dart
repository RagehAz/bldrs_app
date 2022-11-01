import 'dart:async';
import 'dart:io';

import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// Simple Embedded Application Store database
class Sembast  {
  // -----------------------------------------------------------------------------

  /// REFERENCES

  // --------------------
  /// private constructor to create instances of this class only in itself
  Sembast._thing();
  // --------------------
  /// Singleton instance
  static final Sembast _singleton = Sembast._thing();
  // --------------------
  /// Singleton accessor
  static Sembast get instance => _singleton;
  // --------------------
  /// local instance : to transform from synchronous into asynchronous
  Completer<Database> _dbOpenCompleter;
  // --------------------
  /// instance getter
  Future<Database> get database async {
    /// NOTE :this is db object accessor
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();

      await _openDatabase();
    }

    return _dbOpenCompleter.future;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _openDatabase() async {
    final Directory _appDocDir = await getApplicationDocumentsDirectory();

    final String _dbPath = join(_appDocDir.path, 'bldrs_sembast.db');

    final Database _db = await databaseFactoryIo.openDatabase(_dbPath);

    _dbOpenCompleter.complete(_db);

    return _db;
  }
  // --------------------
  /*
  /// Static close
  static Future<void> dispose() async {
    final Database _result = await _getDB();
    await _result.close();
  }
   */
  // -----------------------------------------------------------------------------
  /// static const String _storeName = 'blah';
  /// final StoreRef<int, Map<String, Object>> _doc = intMapStoreFactory.store(_storeName);
  /// Future<Database> get _db async => await AppDatabase.instance.database;
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Database> _getDB() async {
    final Database _result = await Sembast.instance.database;
    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static StoreRef<int, Map<String, Object>> _getStore({
    @required String docName,
  }) {
    return intMapStoreFactory.store(docName);
  }
  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addMap({
    @required Map<String, Object> map,
    @required String docName,
  }) async {

    /// NOTE : this ignores if there is an existing map with same ID
    final Database _db = await _getDB();
    final StoreRef<int, Map<String, Object>> _doc = _getStore(
      docName: docName,
    );

    if (map != null){
      await _doc.add(_db, map);
      // final String _id = LDBDoc.getPrimaryKey(docName);
      // blog('SEMBAST : _addMap : added to ($docName) : map has (${map.keys.length}) keys : (${map[_id]})');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addMaps({
    @required List<Map<String, Object>> maps,
    @required String docName,
  }) async {

    /// NOTE : this allows duplicate IDs

    if (Mapper.checkCanLoopList(maps) == true){

      final Database _db = await _getDB();
      final StoreRef<int, Map<String, Object>> _doc = _getStore(
        docName: docName,
      );
      await _doc.addAll(_db, maps);

    }


  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _updateExistingMap({
    @required Map<String, Object> map,
    @required String docName,
  }) async {

    final Database _db = await _getDB();
    final StoreRef<int, Map<String, Object>> _doc = _getStore(
      docName: docName,
    );

    final String _primaryKey = LDBDoc.getPrimaryKey(docName);
    final String _objectID = map[_primaryKey];

    final Finder _finder = Finder(
      filter: Filter.equals(_primaryKey, _objectID),
    );

    // final int _result =
    await _doc.update(
      _db,
      map,
      finder: _finder,
    );

    // blog('SEMBAST : _updateExistingMap : updated in ( $docName ) : result : $_result : map has ${map?.keys?.length} keys');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insert({
    @required Map<String, Object> map,
    @required String docName,
    bool allowDuplicateIDs = false,
  }) async {

    /// Note : either updates all existing maps with this primary key "ID"
    /// or inserts new map

    if (allowDuplicateIDs == true){
      await _addMap(
        docName: docName,
        map: map,
      );
    }

    else {

      final bool _exists = await checkMapExists(
        docName: docName,
        map: map,
      );

      /// ADD IF NOT FOUND
      if (_exists == false){
        await _addMap(
          docName: docName,
          map: map,
        );
      }

      /// UPDATE IF FOUND
      else {
        await _updateExistingMap(
          docName: docName,
          map: map,
        );
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertAll({
    @required List<Map<String, Object>> maps,
    @required String docName,
    bool allowDuplicateIDs = false,
  }) async {

    if (Mapper.checkCanLoopList(maps)) {

      if (allowDuplicateIDs == true){
        await _addMaps(
          docName: docName,
          maps: maps,
        );
      }

      else {

        final List<Map<String, dynamic>> _existingMaps = await readAll(
          docName: docName,
        );

        final String _primaryKey = LDBDoc.getPrimaryKey(docName);

        final List<Map<String, dynamic>> _cleanedMaps = Mapper.cleanMapsOfDuplicateIDs(
          /// do not change this order of maps to overwrite the new values
          maps: [...maps,..._existingMaps,],
          idFieldName: _primaryKey,
        );

        await deleteAllThenAddAll(
            maps: _cleanedMaps,
            docName: docName
        );

      }

      // blog('SEMBAST : insertAll : inserted ${maps.length} maps into ( $docName ) ');

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllThenAddAll({
    @required List<Map<String, Object>> maps,
    @required String docName,
  }) async {

    await deleteAllAtOnce(
      docName: docName,
    );

    await _addMaps(
      maps: maps,
      docName: docName,
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED :
  static Future<List<Map <String, Object>>> readMaps({
    @required String docName,
    @required List<String> ids,
    @required String primaryKeyName,
  }) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(
      docName: docName,
    );

    final Database _db = await _getDB();

    final Finder _finder = Finder(
      filter: Filter.inList(primaryKeyName, ids),
    );

    List<Map<String, Object>> _maps;

    if (_db != null && _doc != null){

      final List<RecordSnapshot<int, Map<String, Object>>> _recordSnapshots =
      await _doc.find(
        _db,
        finder: _finder,
      );

      _maps = _recordSnapshots.map((RecordSnapshot<int, Map<String, Object>> snapshot) {
        return snapshot.value;
      }).toList();

    }
    // blog('Sembast : readMaps : $docName : $primaryKeyName : ${_maps.length} maps');

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, Object>>> readAll({
    @required String docName,
  }) async {

    /// TASK : THIS METHOD IS VERY SLOW IN FETCHING PHRASES

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    final List<RecordSnapshot<int, Map<String, Object>>> _recordSnapshots =
    await _doc.find(
      _db,
      // finder: _finder,
    );

    final List<Map<String, Object>> _maps = _recordSnapshots
        .map((RecordSnapshot<int, Map<String, Object>> snapshot) {
      return snapshot.value;
    }).toList();

    return _maps;
  }
  // --------------------
  /*
  static Future<List<Map<String, Object>>> readAllNewMethod({
  @required String docName,
}) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    final QueryRef<int, Map<String, Object>> _query = _doc.query();

    final List<RecordSnapshot<int, Map<String, Object>>> _snaps = await _query.getSnapshots(_db);

    final List<Map<String, dynamic>> _maps = [];

    for (final snap in _snaps){
      _maps.add(snap.value);
    }

    return _maps;
  }
 */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, Object>>> searchArrays({
    @required String fieldToSortBy,
    @required String searchField,
    @required dynamic searchValue,
    @required String docName,
  }) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    final _finder = Finder(
      filter: Filter.matches(searchField, searchValue, anyInList: true),
      sortOrders: <SortOrder>[
        SortOrder(fieldToSortBy)
      ],
    );

    final List<RecordSnapshot<int, Map<String, Object>>> _recordSnapshots = await _doc.find(
      _db,
      finder: _finder,
    );

    final List<Map<String, Object>> _maps = _recordSnapshots.map((snapshot){
      return snapshot.value;
    }).toList();

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, Object>>> search({
    @required String fieldToSortBy,
    @required String searchField,
    @required bool fieldIsList,
    @required dynamic searchValue,
    @required String docName,
  }) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    final Finder _finder = Finder(
      filter: Filter.equals(searchField, searchValue, anyInList: fieldIsList),
      sortOrders: <SortOrder>[SortOrder(fieldToSortBy)],
    );

    final List<RecordSnapshot<int, Map<String, Object>>> _recordSnapshots =
    await _doc.find(
      _db,
      finder: _finder,
    );

    // blog('fieldToSortBy : $fieldToSortBy');
    // blog('searchField : $searchField');
    // blog('searchValue : $searchValue');
    // blog('docName : $docName');
    // blog('_doc : $_doc');
    // blog('_db : $_db');
    // blog('_finder : $_finder');
    // blog('_recordSnapshots : $_recordSnapshots');

    final List<Map<String, Object>> _maps = _recordSnapshots.map((RecordSnapshot<int, Map<String, Object>> snapshot) {
      return snapshot.value;
    }).toList();

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, Object>> findFirst({
    @required String fieldToSortBy,
    @required String searchField,
    @required dynamic searchValue,
    @required String docName,
  }) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    final Finder _finder = Finder(
      filter: Filter.equals(searchField, searchValue, anyInList: false),
      // sortOrders: <SortOrder>[
      //   SortOrder(fieldToSortBy)
      // ],
    );

    // blog('_finder is : $_finder');

    final RecordSnapshot<int, Map<String, Object>> _recordSnapshot =
    await _doc?.findFirst(
      _db,
      finder: _finder,
    );

    // blog('_recordSnapshot : $_recordSnapshot');

    final Map<String, Object> _map = _recordSnapshot?.value;

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Map<String, Object>>> searchMultiple({
    @required String docName,
    @required String searchField,
    @required List<Object> searchObjects,
    @required String fieldToSortBy,
  }) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    final Finder _finder = Finder(
      filter: Filter.inList(searchField, searchObjects ?? []),
      sortOrders: <SortOrder>[SortOrder(fieldToSortBy)],
    );

    final List<RecordSnapshot<int, Map<String, Object>>> _recordSnapshots =
    await _doc.find(
      _db,
      finder: _finder,
    );

    final List<Map<String, Object>> _maps = _recordSnapshots.map((RecordSnapshot<int, Map<String, Object>> snapshot) {
      return snapshot.value;
    }).toList();

    return _maps;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMap({
    @required String objectID,
    @required String docName,
  }) async {

    /// NOTE : Deletes all maps with the given primary key,
    /// as LDB allows duplicate maps of same ID "same value of the primary key"

    final StoreRef<int, Map<String, Object>> _doc = _getStore(
        docName: docName
    );
    final Database _db = await _getDB();
    final String _primaryKey = LDBDoc.getPrimaryKey(docName);

    final Finder _finder = Finder(
      filter: Filter.equals(_primaryKey, objectID),
    );

    if (_db != null && _doc != null){

      await _doc.delete(
        _db,
        finder: _finder,
      );

      blog('Sembast : deleteMap : $docName : $_primaryKey : $objectID');

    }

  }
  // --------------------
  /// TESTED :
  static Future<void> deleteMaps({
    @required String primaryKeyName,
    @required List<String> ids,
    @required String docName,
  }) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(
      docName: docName,
    );

    final Database _db = await _getDB();

    final Finder _finder = Finder(
      filter: Filter.inList(primaryKeyName, ids),
    );

    if (_db != null && _doc != null){
      await _doc.delete(
        _db,
        finder: _finder,
      );

      blog('Sembast : deleteDocs : $docName : $primaryKeyName : $ids');
    }

  }
  // --------------------
  /// TESTED :
  static Future<void> deleteAllOneByOne({
    @required String docName,
  }) async {

    final List<Map<String, Object>> _allMaps = await readAll(
      docName: docName,
    );

    if (Mapper.checkCanLoopList(_allMaps) == true){

      final String _primaryKey = LDBDoc.getPrimaryKey(docName);

      await Future.wait(<Future>[

        ...List.generate(_allMaps.length, (index){

          final String _id = _allMaps[index][_primaryKey];

          blog('Sembast : deleteAll : $docName : _id : $_id');

          return deleteMap(
            objectID: _id,
            docName: docName,
          );

        }),

      ]);

    }

  // -----------------------------------------------------------------------------
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteAllAtOnce({
    @required String docName,
  }) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(
        docName: docName
    );

    final Database _db = await _getDB();

    await _doc.delete(_db,);

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkMapExists({
    @required String docName,
    @required Map<String, dynamic> map,
  }) async {

    Map<String, dynamic> _map;

    await tryAndCatch(
        functions: () async {

          final String _primaryKey = LDBDoc.getPrimaryKey(docName);
          final String _objectID = map[_primaryKey];

          _map = await findFirst(
            fieldToSortBy: _primaryKey,
            searchField: _primaryKey,
            searchValue: _objectID,
            docName: docName,
          );

        }
    );


    return _map != null;
  }
  // --------------------
  /// NEED TEST
  static Future<bool> checkIfExists({
    @required String docName,
    @required String id,
  }) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();
    final String _primaryKey = LDBDoc.getPrimaryKey(docName);

    final Finder _finder = Finder(
      filter: Filter.equals(_primaryKey, id, anyInList: false),
    );

    final int _val = await _doc.findKey(_db,
        finder: _finder,
    );

    /// NOT FOUND
    if (_val == null){
      return false;
    }

    /// FOUND
    else {
      return true;
    }

  }
  // -----------------------------------------------------------------------------
}
