import 'dart:async';
import 'dart:io';

import 'package:bldrs/e_db/ldb/api/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
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

// -----------------------------
  /// private constructor to create instances of this class only in itself
  Sembast._thing();
// -----------------------------
  /// Singleton instance
  static final Sembast _singleton = Sembast._thing();
// -----------------------------
  /// Singleton accessor
  static Sembast get instance => _singleton;
// -----------------------------
  /// to transform from synchronous into asynchronous
  Completer<Database> _dbOpenCompleter;
// -----------------------------
  /// db object accessor
  Future<Database> get database async {
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();

      await _openDatabase();
    }

    return _dbOpenCompleter.future;
  }
// -----------------------------
  Future<void> _openDatabase() async {
    final Directory _appDocDir = await getApplicationDocumentsDirectory();

    final String _dbPath = join(_appDocDir.path, 'bldrs_sembast.db');

    final Database _db = await databaseFactoryIo.openDatabase(_dbPath);

    _dbOpenCompleter.complete(_db);

    return _db;
  }
// -----------------------------
  /// static const String _storeName = 'blah';
  /// final StoreRef<int, Map<String, Object>> _doc = intMapStoreFactory.store(_storeName);
  /// Future<Database> get _db async => await AppDatabase.instance.database;
// -----------------------------
  static Future<Database> _getDB() async {
    final Database _result = await Sembast.instance.database;
    return _result;
  }
// -----------------------------
  static StoreRef<int, Map<String, Object>> _getStore({
    @required String docName,
  }) {
    return intMapStoreFactory.store(docName);
  }
// -----------------------------------------------------------------------------

  /// CREATE

// -----------------------------
  /// TESTED :
  static Future<void> insert({
    @required Map<String, Object> map,
    @required String docName,
  }) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    // final int result = await update(
    //   docName: docName,
    //   map: map,
    //   searchPrimaryKey: primaryKey,
    //   searchPrimaryValue: map[primaryKey],
    // );
    //
    // if (result == 0) {
    //   /// map not found in ldb so we add it
      await _doc.add(_db, map);
    // }
  }
// -----------------------------
  /// TESTED :
  static Future<void> insertAll({
    @required String primaryKey,
    @required List<Map<String, Object>> inputs,
    @required String docName,
  }) async {

    if (Mapper.canLoopList(inputs)) {

      final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
      final Database _db = await _getDB();

      await _doc.addAll(_db, inputs);
      blog('SEMBAST : insertAll : inserted ${inputs.length} maps into ( $docName ) : primaryKey : ( $primaryKey )');

    }

  }
// -----------------------------
  /// TESTED :
  static Future<void> deleteAllThenInsertAll({
    @required String primaryKey,
    @required List<Map<String, Object>> inputs,
    @required String docName,
  }) async {

    await deleteAllAtOnce(
        docName: docName,
    );

    await insertAll(
      inputs: inputs,
      docName: docName,
      primaryKey: primaryKey,
    );

  }
// -----------------------------------------------------------------------------

  /// READ

// -----------------------------
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
      blog('Sembast : readMaps : $docName : $primaryKeyName : $_maps');

    return _maps;
  }
// -----------------------------
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
// -----------------------------
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
// -----------------------------
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
// -----------------------------
  /// TESTED :
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
// -----------------------------
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
        await _doc.findFirst(
      _db,
      finder: _finder,
    );

    // blog('_recordSnapshot : $_recordSnapshot');

    final Map<String, Object> _map = _recordSnapshot?.value;

    return _map;
  }
// -----------------------------------------------------------------------------

  /// UPDATE

// -----------------------------
  /// TESTED :
  static Future<void> update({
    @required Map<String, Object> map,
    @required String objectID,
    @required String docName,
  }) async {

    /// Note : either updates all existing maps with this primary key "ID"
    /// or inserts new map


      final bool _exists = await checkMapExists(
          docName: docName,
          id: objectID,
      );

      /// IF NOT FOUND
      if (_exists == false){
        await insert(
            docName: docName,
            map: map,
        );
      }

      /// IF FOUND
      else {

        final Database _db = await _getDB();
        final StoreRef<int, Map<String, Object>> _doc = _getStore(
          docName: docName,
        );

        final String _primaryKey = getPrimaryKey(docName);

        final Finder _finder = Finder(
          filter: Filter.equals(_primaryKey, objectID),
        );

        final int _result = await _doc.update(
          _db,
          map,
          finder: _finder,
        );

        blog('SEMBAST : update : _result : $_result');

      }

    // return _result;
  }
// -----------------------------------------------------------------------------

  /// DELETE

// -----------------------------
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
    final String _primaryKey = getPrimaryKey(docName);

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
// -----------------------------
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
// -----------------------------
  /// TESTED :
  static Future<void> deleteAllOneByOne({
    @required String docName,
  }) async {

    final List<Map<String, Object>> _allMaps = await readAll(
        docName: docName,
    );

    if (Mapper.canLoopList(_allMaps) == true){

      final String _primaryKey = getPrimaryKey(docName);

      for (final Map<String, Object> map in _allMaps) {

        final String _id = map[_primaryKey];

        await deleteMap(
            objectID: _id,
            docName: docName,
        );

        blog('Sembast : deleteAll : $docName : _id : $_id');
      }

    }

// -----------------------------------------------------------------------------
  }
// -----------------------------------------------------------------------------
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

// -----------------------------
  static Future<bool> checkMapExists({
    @required String docName,
    @required String id,
}) async {

      final String _primaryKey = getPrimaryKey(docName);

      final Map<String, dynamic> _map = await findFirst(
        fieldToSortBy: _primaryKey,
        searchField: _primaryKey,
        searchValue: id,
        docName: docName,
      );

      return _map != null;
  }
// -----------------------------------------------------------------------------
}
