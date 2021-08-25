import 'package:bldrs/providers/sqflite/db_table_model.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';



abstract class SQFLite{

  /// 1. create db
  static Future<Database> createDB({
    @required BuildContext context,
    @required DBTable dbTable,
  }) async {

    Database _db = await openDatabase(
      dbTable.dbName,
      version: 1,
      onCreate: (database, version) async {

        await tryAndCatch(
          context: context,
          methodName: 'createDB',
          functions: () async {

            String _createTableQuery = 'CREATE TABLE ${dbTable.toSQLQuery()}';

            await database.execute(_createTableQuery);

            print('createDB : database is created : database.path : ${database.path} : _createTableQuery : $_createTableQuery');

          },
          onError: (e){
            print('some error happened : $e');
          }
        );

      },
      onOpen: (database){

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

  /// 2. create tables

  /// 3. open db

  /// 4. insert in db
  static Future<void> insertToDB({BuildContext context, Database db, DBTable dbTable}) async {
    await tryAndCatch(
      context: context,
      methodName: 'insertToDB',
      functions: () async {

        await db.transaction((txn) async {

          String _sql = dbTable.toRawInsertString();

          /// fields below do not include the integer primary key
          await txn.rawInsert(_sql);

          print ('insertToDB : added data to ${db.path} : and dbTable.toRawInsertString() is : $_sql');

          return null;
        });

      },
      // onError: (e){
      //
      // }

    );
    
  }
  /// 5. read from db

  /// 6. update in db

  /// 7. delete in db

}