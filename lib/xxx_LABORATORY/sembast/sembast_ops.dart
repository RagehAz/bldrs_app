import 'package:bldrs/xxx_LABORATORY/sembast/sembast.dart';
import 'package:sembast/sembast.dart';

class SembastOps{
  /// static const String _storeName = 'blah';
  /// final StoreRef<int, Map<String, Object>> _doc = intMapStoreFactory.store(_storeName);
  /// Future<Database> get _db async => await AppDatabase.instance.database;
// -----------------------------------------------------------------------------
  static Future<Database> _getDB() async {
    return await AppDatabase.instance.database;
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
  static Future<List<Map<String, Object>>> readAll({String docName, }) async {

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