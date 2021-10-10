import 'package:bldrs/db/ldb/sql_db/sql_column.dart';
import 'package:bldrs/db/ldb/sql_db/sql_db.dart';
import 'package:bldrs/db/ldb/sql_db/sql_table.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:flutter/material.dart';

class BzSQLdb{
  final String tableName;
  final SQLTable bzzTable;
  final SQLTable authorsTable;

  BzSQLdb({
    @required this.tableName,
    @required this.bzzTable,
    @required this.authorsTable,
  });
// -----------------------------------------------------------------------------
  static String _authorsTableName(String tableName){
    return '${tableName}_authors';
  }
// -----------------------------------------------------------------------------
  static Future<BzSQLdb> createBzzLDB({BuildContext context, String LDBName}) async {

    /// 1 - CREATE BZZ LDB
    final List<SQLColumn> _bzzColumns = BzModel.createBzzLDBColumns();
    final SQLTable _bzzTable = await SQLdb.createAndSetSQLdb(
      context: context,
      tableName: LDBName,
      columns: _bzzColumns,
    );

    /// 2 - CREATE Authors SLAVE LDB FOR PREVIOUS BZZ LDB
    final List<SQLColumn> _authorsColumns = AuthorModel.createAuthorsLDBColumns();
    final SQLTable _authorsTable = await SQLdb.createAndSetSQLdb(
      context: context,
      tableName: _authorsTableName(LDBName),
      columns: _authorsColumns,
    );

    /// 3 - COMBINE BZZ AND AUTHORS LDBs  AND RETURN
    final BzSQLdb _bzzLDB = BzSQLdb(
      tableName: LDBName,
      bzzTable: _bzzTable,
      authorsTable: _authorsTable,
    );

    print('BzzLDB created : ${LDBName}');

    return _bzzLDB;
  }
// -----------------------------------------------------------------------------
  static Future<List<BzModel>> readBzzLDB({BuildContext context, BzSQLdb bzzLDB}) async {

    final List<Map<String, Object>> _sqlBzzMaps = await SQLdb.readRaw(
      context: context,
      table: bzzLDB.bzzTable,
    );

    final List<Map<String, Object>> _sqlAuthorsMaps = await SQLdb.readRaw(
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
  static Future<void> deleteBzzLDB({BuildContext context, BzSQLdb bzzLDB}) async {

    await SQLdb.deleteDB(
      context: context,
      table: bzzLDB.authorsTable,
    );

    await SQLdb.deleteDB(
      context: context,
      table: bzzLDB.bzzTable,
    );

    print('Deleted bzzLDB : ${bzzLDB.tableName}');
  }
// -----------------------------------------------------------------------------
  static Future<void> insertBzToLDB({BzSQLdb bzzLDB, BzModel bz}) async {

    /// inset sql authors
    for (AuthorModel author in bz.bzAuthors){

      final Map<String, Object> _sqlAuthorMap = await AuthorModel.sqlCipherAuthor(
        author: author,
      );

      await SQLdb.insert(
        table: bzzLDB.authorsTable,
        input: _sqlAuthorMap,
      );
    }

    /// insert sql bz
    final Map<String, Object> _sqlBzMap = await BzModel.sqlCipherBz(bz);
    await SQLdb.insert(
      table: bzzLDB.bzzTable,
      input: _sqlBzMap,
    );

    print('bz : ${bz.bzID} : added to : ${bzzLDB.tableName} : LDB');
  }
// -----------------------------------------------------------------------------
  static Future<Map<String, Object>> _getBzFromLDB({BzSQLdb bzzLDB, String bzID}) async {

    final List<Map<String, Object>> _bzMapInList = await SQLdb.getData(
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
  static Future<List<AuthorModel>> _getAuthorsFromLDBByBzID({BzSQLdb bzzLDB, String bzID}) async {

    List<AuthorModel> _authors = <AuthorModel>[];

    Map<String, Object> _bzMap = await _getBzFromLDB(bzzLDB: bzzLDB, bzID: bzID);

    if (_bzMap != null){

      final List<String> _authorsIDs = _bzMap['_authorsIDs'];

      if (_authorsIDs != null && _authorsIDs.isNotEmpty){

        for (String id in _authorsIDs){

          final List<Map<String, Object>> _authorMapInList = await SQLdb.getData(
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
  static Future<BzModel> readABzFromLDB({BzSQLdb bzzLDB, String bzID}) async {
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
  static Future<void> deleteBzFromLDB({BzSQLdb bzzLDB, String bzID}) async {

    final List<AuthorModel> _bzAuthors = await _getAuthorsFromLDBByBzID(
      bzzLDB: bzzLDB,
      bzID: bzID,
    );

    for (AuthorModel author in _bzAuthors){

      await SQLdb.deleteRowsByKeyAndValue(
        table: bzzLDB.authorsTable,
        key: 'userID',
        value: author.userID,
      );

    }

    await SQLdb.deleteRowsByKeyAndValue(
      table: bzzLDB.bzzTable,
      key: 'bzID',
      value: bzID,
    );

    print('deleteBzFromLDB : bzID : $bzID : _bzAuthors.length : ${_bzAuthors.length}');

  }
// -----------------------------------------------------------------------------

}