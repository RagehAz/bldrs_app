import 'package:bldrs/providers/local_db/ldb_table.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;


enum LDBDataType{
  TEXT,
  INTEGER,
  REAL,
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
      default :                   return 'TEXT';
    }
  }
// -----------------------------------------------------------------------------
  /// CREATE LOCAL DATABASE
  static Future<Database> createLDB({
    @required BuildContext context,
    @required LDBTable table,
  }) async {

    final String dbPath = await getDatabasesPath();

    /// this open the ldb from the given path, or creates a new one if does not exist
    Database _db = await openDatabase(
      path.join(dbPath, table.tableName),
      version: 1,
      onCreate: (database, version) async {

        await tryAndCatch(
          context: context,
          methodName: 'createDB',
          functions: () async {

            String _createSQLQuery = table.toCreateSQLQuery();
            await database.execute(_createSQLQuery);

            print('createDB : database is created : database.path : ${database.path} : _createSQLQuery : $_createSQLQuery');

          },
          // onError: (e){
          //   print('some error happened : $e');
          // }
        );

      },
      onOpen: (database) async {

        await readRawFromLDB(
          db: database,
          tableName: table.tableName,
        );

        print('createDB : database is opened : database.path : ${database.path}');
      },
      readOnly: false,
      // onConfigure:
      // onDowngrade:
      // onUpgrade:
      // singleInstance:
    );

    return _db;
  }
// -----------------------------------------------------------------------------
  /// RAW INSERT TO LOCAL DATABASE
  static Future<void> InsertRawToLDB({BuildContext context, Database db, LDBTable dbTable, Map<String, Object> input}) async {

    await tryAndCatch(
      context: context,
      methodName: 'insertToDB',
      functions: () async {

        await db.transaction((txn) async {

          String _rawInsertSQLQuery = LDBTable.getRawInsertSQLQuery(
            tableName: dbTable.tableName,
            map: input,
            columns: dbTable.columns,
          );
          List<dynamic> _arguments = [];

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
// -----------------------------------------------------------------------------
  /// INSERT TO LOCAL DATABASE
  static Future<void> insert({Database db, LDBTable dbTable, Map<String, Object> data}) async {

    db.insert(
      dbTable.tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

  }
// -----------------------------------------------------------------------------
  /// RAW READ FROM LOCAL DATABASE
  static Future<List<dynamic>> readRawFromLDB({Database db,String tableName}) async {
    List<Map<String, Object>> _sqfMaps = new List();

    if (db != null){
      String _tableName = tableName;
      String _sql = 'SELECT * FROM $_tableName';

      _sqfMaps = await db.rawQuery(_sql);

    }

    return _sqfMaps;
  }
// -----------------------------------------------------------------------------
  static Future<List<dynamic>> readFromLDB({Database db, String tableName}) async {
    return db.query(tableName);
  }
// -----------------------------------------------------------------------------
}