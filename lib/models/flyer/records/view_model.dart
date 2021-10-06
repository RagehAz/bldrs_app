import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/providers/local_db/sql_db/sql_db.dart';
import 'package:bldrs/providers/local_db/sql_db/sql_column.dart';
import 'package:bldrs/providers/local_db/sql_db/sql_table.dart';
import 'package:flutter/material.dart';

class ViewModel{
  final dynamic viewID;
  final String userID;
  final String flyerID;
  final int slideIndex;
  final DateTime viewTime;
// -----------------------------------------------------------------------------
  const ViewModel({
    this.viewID,
    this.userID,
    this.flyerID,
    this.slideIndex,
    this.viewTime,
  });
// -----------------------------------------------------------------------------
Map<String, Object> toMap(){
  return {
    'viewID' : viewID,
    'userID' : userID,
    'flyerID' : flyerID,
    'slideIndex' : slideIndex,
    'viewTime' : Timers.cipherDateTimeToString(viewTime),
  };
}
// -----------------------------------------------------------------------------
    static const List<SQLColumn> columns = const <SQLColumn>[
      SQLColumn(key: 'viewID', type: 'INTEGER', isPrimary: true),
      SQLColumn(key: 'userID', type: 'TEXT'),
      SQLColumn(key: 'flyerID', type: 'TEXT'),
      SQLColumn(key: 'slideIndex', type: 'INTEGER'),
      SQLColumn(key: 'viewTime', type: 'TEXT'),
    ];
// -----------------------------------------------------------------------------
  static Future<SQLTable> createLDBTable({BuildContext context, String tableName}) async {

    final SQLTable _dbTable = await SQLdb.createAndSetSQLdb(
      context: context,
      tableName: tableName,
      columns: columns,
    );

    return _dbTable;
  }
// -----------------------------------------------------------------------------

}

