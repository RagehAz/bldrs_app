import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/providers/local_db/models/ldb_column.dart';
import 'package:bldrs/models/helpers/error_helpers.dart';
import 'package:bldrs/providers/local_db/models/ldb_table.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;


enum LDBDataType{
  TEXT,
  INTEGER,
  REAL,
  BLOB,
}

/// LDB : LOCAL DATA BASE
///
/// table shall look like this
///
///   id    fieldA      fieldB      fieldC    ---> LDBColumns : List<LDBColumn>
///   1     value       value       value     ---|
///   2     value       value       value        |---> LDBRows : List<LDBRow>
///   3     value       value       value     ---|
///   ...
///

abstract class LDB{
// -----------------------------------------------------------------------------
  static String dataType(LDBDataType dataType){
    switch (dataType){
      case LDBDataType.TEXT:      return 'TEXT'; break;
      case LDBDataType.INTEGER:   return 'INTEGER'; break;
      case LDBDataType.REAL:      return 'REAL'; break;
      case LDBDataType.BLOB:      return  'BLOB'; break;
      default :                   return 'TEXT';
    }
  }
// -----------------------------------------------------------------------------
  /// CREATE LOCAL DATABASE
  static Future<LDBTable> createAndSetLDB({
    @required BuildContext context,
    @required List<LDBColumn> columns,
    @required String tableName,
  }) async {

    LDBTable _dbTable = LDBTable(
      tableName: tableName,
      columns: columns,
      maps: [],
      db: null,
    );

    print('createLDB : starting to open LDB : table.tableName : ${_dbTable.tableName}');

    final String _dbPath = await getDatabasesPath();

    print('createLDB : _dbPath : $_dbPath');

    /// this open the ldb from the given path, or creates a new one if does not exist
    final Database _db = await openDatabase(
      path.join(_dbPath, _dbTable.tableName),
      version: 1,
      onCreate: (database, version) async {

        print('createLDB : database.isOpen : ${database.isOpen}');

        await tryAndCatch(
          context: context,
          methodName: 'createDB',
          functions: () async {

            final String _createSQLQuery = _dbTable.toCreateSQLQuery();
            await database.execute(_createSQLQuery);

            print('createDB : database is created : database.path : ${database.path} : _createSQLQuery : $_createSQLQuery');

          },
          // onError: (e){
          //   print('some error happened : $e');
          // }
        );

      },
      onOpen: (database) async {

        _dbTable.db = database;

        await readRawFromLDB(
          table: _dbTable,
        );

        print('createDB : database is opened : database.path : ${database.path}');
      },
      readOnly: false,
      // onConfigure:
      // onDowngrade:
      // onUpgrade:
      // singleInstance:
    );

    print('createLDB : _db.isOpen : ${_db.isOpen}');

    _dbTable.db = _db;

    return _dbTable;
  }
// -----------------------------------------------------------------------------
  /// RAW INSERT TO LOCAL DATABASE ( inserts new row to LDB )
  static Future<void> InsertRawToLDB({BuildContext context, LDBTable table, Map<String, Object> input}) async {

    if (table.db.isOpen == true){

      await tryAndCatch(
        context: context,
        methodName: 'insertToDB',
        functions: () async {

          await table.db.transaction((txn) async {

            final String _rawInsertSQLQuery = LDBTable.getRawInsertSQLQuery(
              tableName: table.tableName,
              map: input,
              columns: table.columns,
            );
            final List<dynamic> _arguments = <dynamic>[];

            /// fields below do not include the integer primary key
            await txn.rawInsert(_rawInsertSQLQuery, _arguments);

            // print ('insertToDB : added data to ${db.path} : and dbTable.toRawInsertString() is : $_rawInsertSQLQuery');

            return null;
          });

        },
        // onError: (e){
        //
        // }

      );

    }

  }
// -----------------------------------------------------------------------------
  /// INSERT TO LOCAL DATABASE
  static Future<void> insert({LDBTable table, Map<String, Object> input}) async {

    if (table.db.isOpen == true){

      await table.db.insert(
        table.tableName,
        input,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

    }

  }
// -----------------------------------------------------------------------------
  /// RAW READ FROM LOCAL DATABASE
  static Future<List<dynamic>> readRawFromLDB({BuildContext context, LDBTable table}) async {
    List<Map<String, Object>> _sqfMaps = <Map<String, Object>>[];

    await tryAndCatch(
      context: context,
      methodName: 'readRawFromLDB',
      functions: () async {

        print('readRawFromLDB : reading tableName : ${table.tableName} : db.isOpen : ${table.db.isOpen} : db == null : ${table.db != null}');

        if (table.db != null && table.db.isOpen == true){
          final String _tableName = table.tableName;
          final String _sql = 'SELECT * FROM $_tableName';

          print('readRawFromLDB : starting rawQuery for _sql: $_sql');

          _sqfMaps = await table.db.rawQuery(_sql);

          print('readRawFromLDB : finished rawQuery with _sqfMaps: $_sqfMaps');

        }

      },
      // onError: (){},
    );


    return _sqfMaps;
  }
// -----------------------------------------------------------------------------
  /// works exactly like [readRawFromLDB]
  static Future<List<dynamic>> readFromLDB({LDBTable table}) async {
    return table.db.query(table.tableName);
  }
// -----------------------------------------------------------------------------
  static Future<void> deleteLDB({BuildContext context, LDBTable table,}) async {

    await tryAndCatch(
      context: context,
      methodName: 'deleteLDB',
      functions: () async {

        final String dbPath = await getDatabasesPath();
        final String _path = path.join(dbPath, table.tableName);

        await table.db.close();
        await deleteDatabase(_path);

        print('deleteLDB : tableName : ${table.tableName} :  _path : ${_path}');

      }

    );

  }
// -----------------------------------------------------------------------------
  static Future<void> updateRow({BuildContext context, LDBTable table, int rowNumber, Map<String, Object> input}) async {

    // String _time = Timers.cipherDateTimeToString(DateTime.now());
    // String _tableName = table.tableName;
    // String _rawUpdateSQLQuery = 'UPDATE $_tableName SET userID = userIteez, flyerID = flyerIteez, slideIndex = 9, viewTime = 5555 WHERE viewID = 7';
    // List<String> _arguments = <String>['userID','flyerID', 'slideIndex', 'viewTime'];
    //
    // await db.rawUpdate(_rawUpdateSQLQuery, _arguments,);

    final String _primaryKey = LDBColumn.getPrimaryKeyFromColumns(table.columns);

    final dynamic _result = await table.db.update(
      table.tableName,
      input,
      where: "$_primaryKey = ?",
      whereArgs: [rowNumber],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print('_result : $_result');

  }
// -----------------------------------------------------------------------------
  static Future<void> deleteRow({BuildContext context, LDBTable table, int rowNumber}) async {

    final String _primaryKey = LDBColumn.getPrimaryKeyFromColumns(table.columns);

    final dynamic result = await table.db.delete(
      table.tableName,
      where: "$_primaryKey = ?",
      whereArgs: [rowNumber],
    );

    print(result);

  }
// -----------------------------------------------------------------------------
  static String sqlCipherSlides(List<SlideModel> slides){
    String _string;

    return _string;
  }
// -----------------------------------------------------------------------------
}

// To avoid ping-pong between dart and native code, you can use Batch:

// batch = db.batch();
// batch.insert('Test', {'name': 'item'});
// batch.update('Test', {'name': 'new_item'}, where: 'name = ?', whereArgs: ['item']);
// batch.delete('Test', where: 'name = ?', whereArgs: ['item']);
// results = await batch.commit();

// If you don't care about the result and worry about performance in big batches, you can use
// await batch.commit(noResult: true);

// await database.transaction((txn) async {
// var batch = txn.batch();
//
// // ...
//
// // commit but the actual commit will happen when the transaction is committed
// // however the data is available in this transaction
// await batch.commit();
//
// //  ...
// });