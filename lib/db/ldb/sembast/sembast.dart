import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

/// Simple Embedded Application Store database
class Sembast {
// -----------------------------------------------------------------------------
  /// private constructor to create instances of this class only in itself
  Sembast._thing();
// -----------------------------------------------------------------------------
  /// Singleton instance
  static final Sembast _singleton = Sembast._thing();
// -----------------------------------------------------------------------------
  /// Singleton accessor
  static Sembast get instance => _singleton;
// -----------------------------------------------------------------------------
  /// to transform from synchronous into asynchronous
  Completer<Database> _dbOpenCompleter;
// -----------------------------------------------------------------------------
  /// db object accessor
  Future<Database> get database async {

    if (_dbOpenCompleter == null){
      _dbOpenCompleter = Completer();

      _openDatabase();
    }

    return _dbOpenCompleter.future;
  }
// -----------------------------------------------------------------------------
  Future<void> _openDatabase() async {

    final Directory _appDocDir = await getApplicationDocumentsDirectory();

    final String _dbPath = join(_appDocDir.path, 'bldrs_sembast.db');

    final Database _db = await databaseFactoryIo.openDatabase(_dbPath);

    _dbOpenCompleter.complete(_db);

    return _db;

  }
// -----------------------------------------------------------------------------

/// SEMBAST OPS

// -----------------------------------------------------------------------------

  /// static const String _storeName = 'blah';
  /// final StoreRef<int, Map<String, Object>> _doc = intMapStoreFactory.store(_storeName);
  /// Future<Database> get _db async => await AppDatabase.instance.database;
// -----------------------------------------------------------------------------
  static Future<Database> _getDB() async {
    return await Sembast.instance.database;
  }
// -----------------------------------------------------------------------------
  static StoreRef<int, Map<String, Object>> _getStore({String docName}) {
    return intMapStoreFactory.store(docName);
  }
// -----------------------------------------------------------------------------
  static Future<void> insert({List<Map<String, Object>> inputs, String docName}) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    await _doc.addAll(await _db, inputs);

  }
// -----------------------------------------------------------------------------
  static Future<void> update({Map<String, Object> map, String searchPrimaryValue, String searchPrimaryKey, String docName}) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    final Finder _finder = Finder(filter: Filter.equals(searchPrimaryKey, searchPrimaryValue));

    await _doc.update(
      await _db,
      map,
      finder: _finder,
    );

  }
// -----------------------------------------------------------------------------
  static Future<void> delete({String searchPrimaryKey,String searchPrimaryValue, String docName}) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    final Finder _finder = Finder(
      filter: Filter.equals(searchPrimaryKey, searchPrimaryValue),
    );

    await _doc.delete(
      await _db,
      finder: _finder,
    );

  }
// -----------------------------------------------------------------------------
  static Future<List<Map<String, Object>>> search({String fieldToSortBy, String searchField, dynamic searchValue, String docName}) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    final _finder = Finder(
      filter: Filter.equals(searchField, searchValue, anyInList: true),
      sortOrders: <SortOrder>[
        SortOrder(fieldToSortBy)
      ],
    );

    final List<RecordSnapshot<int, Map<String, Object>>> _recordSnapshots = await _doc.find(
      await _db,
      finder: _finder,
    );

    final List<Map<String, Object>> _maps = _recordSnapshots.map((snapshot){
      return snapshot.value;
    }).toList();

    return _maps;
  }
// -----------------------------------------------------------------------------
  static Future<Map<String, Object>> findFirst({String fieldToSortBy, String searchField, dynamic searchValue, String docName}) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    final _finder = Finder(
      filter: Filter.equals(searchField, searchValue, anyInList: true),
      sortOrders: <SortOrder>[
        SortOrder(fieldToSortBy)
      ],
    );


    final RecordSnapshot<int, Map<String, Object>> _recordSnapshot = await _doc.findFirst(
      await _db,
      finder: _finder,
    );

    final Map<String, Object> _map = _recordSnapshot.value;

    return _map;
  }
// -----------------------------------------------------------------------------
  static Future<List<Map<String, Object>>> readAll({String docName,}) async {

    final StoreRef<int, Map<String, Object>> _doc = _getStore(docName: docName);
    final Database _db = await _getDB();

    final List<RecordSnapshot<int, Map<String, Object>>> _recordSnapshots = await _doc.find(
      await _db,
      // finder: _finder,
    );

    final List<Map<String, Object>> _maps = _recordSnapshots.map((snapshot){
      return snapshot.value;
    }).toList();

    return _maps;
  }
// -----------------------------------------------------------------------------


}