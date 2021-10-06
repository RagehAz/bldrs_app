import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/providers/local_db/models/ldb.dart';
import 'package:bldrs/providers/local_db/models/ldb_column.dart';
import 'package:bldrs/providers/local_db/models/ldb_table.dart';
import 'package:flutter/material.dart';

class BzzLDB{
  final String tableName;
  final LDBTable bzzTable;
  final LDBTable authorsTable;

  BzzLDB({
    @required this.tableName,
    @required this.bzzTable,
    @required this.authorsTable,
  });
// -----------------------------------------------------------------------------
  static String _authorsTableName(String tableName){
    return '${tableName}_authors';
  }
// -----------------------------------------------------------------------------
  static Future<BzzLDB> createBzzLDB({BuildContext context, String LDBName}) async {

    /// 1 - CREATE BZZ LDB
    final List<LDBColumn> _bzzColumns = BzModel.createBzzLDBColumns();
    final LDBTable _bzzTable = await LDB.createAndSetLDB(
      context: context,
      tableName: LDBName,
      columns: _bzzColumns,
    );

    /// 2 - CREATE Authors SLAVE LDB FOR PREVIOUS BZZ LDB
    final List<LDBColumn> _authorsColumns = AuthorModel.createAuthorsLDBColumns();
    final LDBTable _authorsTable = await LDB.createAndSetLDB(
      context: context,
      tableName: _authorsTableName(LDBName),
      columns: _authorsColumns,
    );

    /// 3 - COMBINE BZZ AND AUTHORS LDBs  AND RETURN
    final BzzLDB _bzzLDB = BzzLDB(
      tableName: LDBName,
      bzzTable: _bzzTable,
      authorsTable: _authorsTable,
    );

    print('BzzLDB created : ${LDBName}');

    return _bzzLDB;
  }
// -----------------------------------------------------------------------------
  static Future<List<BzModel>> readBzzLDB({BuildContext context, BzzLDB bzzLDB}) async {

    final List<Map<String, Object>> _sqlBzzMaps = await LDB.readRawFromLDB(
      context: context,
      table: bzzLDB.bzzTable,
    );

    final List<Map<String, Object>> _sqlAuthorsMaps = await LDB.readRawFromLDB(
      context: context,
      table: bzzLDB.authorsTable,
    );

    final List<AuthorModel> _allAuthors = await AuthorModel.sqlDecipherAuthors(maps: _sqlAuthorsMaps);

    final List<BzModel> _allBzz = await BzModel.sqlDecipherBzz(
      maps: _sqlBzzMaps,
      allAuthors: _allAuthors,
    );

    print('reading _allBzz LDB : ${bzzLDB.tableName} : and got ${_allBzz.length} bzz');

    return _allBzz;
  }
// -----------------------------------------------------------------------------
  static Future<void> deleteBzzLDB({BuildContext context, BzzLDB bzzLDB}) async {

    await LDB.deleteLDB(
      context: context,
      table: bzzLDB.authorsTable,
    );

    await LDB.deleteLDB(
      context: context,
      table: bzzLDB.bzzTable,
    );

    print('Deleted bzzLDB : ${bzzLDB.tableName}');
  }
// -----------------------------------------------------------------------------
  static Future<void> insertBzToLDB({BzzLDB bzzLDB, BzModel bz}) async {

    /// inset sql authors
    for (AuthorModel author in bz.bzAuthors){

      final Map<String, Object> _sqlAuthorMap = await AuthorModel.sqlCipherAuthor(
        author: author,
      );

      await LDB.insert(
        table: bzzLDB.authorsTable,
        input: _sqlAuthorMap,
      );
    }

    /// insert sql bz
    final Map<String, Object> _sqlBzMap = await BzModel.sqlCipherBz(bz);
    await LDB.insert(
      table: bzzLDB.bzzTable,
      input: _sqlBzMap,
    );

    print('bz : ${bz.bzID} : added to : ${bzzLDB.tableName} : LDB');
  }
// -----------------------------------------------------------------------------
  static Future<Map<String, Object>> _getBzFromLDB({BzzLDB bzzLDB, String bzID}) async {

    final List<Map<String, Object>> _bzMapInList = await LDB.getData(
      table: bzzLDB.bzzTable,
      key: 'bzID',
      value: bzID,
    );

    Map<String, Object> _bzMap;

    if (_bzMapInList != null && _bzMapInList.isNotEmpty){
      _bzMap = _bzMapInList[0];
    }

    return _bzMap;
  }
// -----------------------------------------------------------------------------
  static Future<List<AuthorModel>> _getAuthorsFromLDBByBzID({BzzLDB bzzLDB, String bzID}) async {

    List<AuthorModel> _authors = <AuthorModel>[];

    Map<String, Object> _bzMap = await _getBzFromLDB(bzzLDB: bzzLDB, bzID: bzID);

    if (_bzMap != null){

      final List<String> _authorsIDs = _bzMap['_authorsIDs'];

      if (_authorsIDs != null && _authorsIDs.isNotEmpty){

        for (String id in _authorsIDs){

          final List<Map<String, Object>> _authorMapInList = await LDB.getData(
            table: bzzLDB.authorsTable,
            key: 'userID',
            value: id,
          );

          if (_authorMapInList != null && _authorMapInList.isNotEmpty){

            final AuthorModel _author = await AuthorModel.sqlDecipherAuthor(map: _authorMapInList[0]);
            _authors.add(_author);

          }

        }

      }

    }

    return _authors;
  }
// -----------------------------------------------------------------------------
  static Future<BzModel> readABzFromLDB({BzzLDB bzzLDB, String bzID}) async {
    BzModel _bz;

    final Map<String,Object> _bzMap = await _getBzFromLDB(
      bzzLDB: bzzLDB,
      bzID: bzID,
    );

    final List<AuthorModel> _bzAuthors = await _getAuthorsFromLDBByBzID(
      bzzLDB: bzzLDB,
      bzID: bzID,
    );

    if (_bzMap != null){
      _bz = await BzModel.sqlDecipherBz(_bzMap, _bzAuthors);
    }


    print('readABzFromLDB : _bzMap : ${_bzMap}');

    return _bz;
  }
// -----------------------------------------------------------------------------
  static Future<void> deleteBzFromLDB({BzzLDB bzzLDB, String bzID}) async {

    final List<AuthorModel> _bzAuthors = await _getAuthorsFromLDBByBzID(
      bzzLDB: bzzLDB,
      bzID: bzID,
    );

    for (AuthorModel author in _bzAuthors){

      await LDB.deleteRowsByKeyAndValue(
        table: bzzLDB.authorsTable,
        key: 'userID',
        value: author.userID,
      );

    }

    await LDB.deleteRowsByKeyAndValue(
      table: bzzLDB.bzzTable,
      key: 'bzID',
      value: bzID,
    );

    print('deleteBzFromLDB : bzID : $bzID : _bzAuthors.length : ${_bzAuthors.length}');

  }
// -----------------------------------------------------------------------------

}