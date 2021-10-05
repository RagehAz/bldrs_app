

import 'package:bldrs/xxx_LABORATORY/sembast/sembast.dart';
import 'package:sembast/sembast.dart';

class SembastOps{
// -----------------------------------------------------------------------------
  static const String _storeName = 'blah';
// -----------------------------------------------------------------------------
  final _store = intMapStoreFactory.store(_storeName);
// -----------------------------------------------------------------------------
  Future<Database> get _db async => await AppDatabase.instance.database;
// -----------------------------------------------------------------------------
  Future<void> insert(List<Map<String, Object>> map) async {

    await _store.addAll(await _db, map);

  }
// -----------------------------------------------------------------------------
  Future<void> update(Map<String, Object> map, String id) async {

    final Finder _finder = Finder(filter: Filter.byKey(id));

    await _store.update(
      await _db,
      map,
      finder: _finder,
    );

  }
// -----------------------------------------------------------------------------
  Future<void> delete(String id) async {

    final Finder _finder = Finder(filter: Filter.byKey(id),);

    await _store.delete(
      await _db,
      finder: _finder,
    );

  }
// -----------------------------------------------------------------------------
  Future<List<Map<String, Object>>> search({String fieldToSortBy, String searchField, dynamic searchValue}) async {

    final _finder = Finder(
        filter: Filter.equals(searchField, searchValue, anyInList: true),
        sortOrders: <SortOrder>[
          SortOrder(fieldToSortBy)
        ],
    );

    final List<RecordSnapshot<int, Map<String, Object>>> _recordSnapshots = await _store.find(
      await _db,
      finder: _finder,
    );

    final List<Map<String, Object>> _maps = _recordSnapshots.map((snapshot){
      return snapshot.value;
    }).toList();

    return _maps;
}
// -----------------------------------------------------------------------------
}