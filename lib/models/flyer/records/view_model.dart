import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/providers/local_db/ldb.dart';
import 'package:bldrs/providers/local_db/ldb_column.dart';
import 'package:bldrs/providers/local_db/ldb_table.dart';
import 'package:flutter/material.dart';

class ViewModel{
  final dynamic viewID;
  final String userID;
  final String flyerID;
  final int slideIndex;
  final DateTime viewTime;
// -----------------------------------------------------------------------------
  ViewModel({
    this.viewID,
    this.userID,
    this.flyerID,
    this.slideIndex,
    this.viewTime,
  });
// -----------------------------------------------------------------------------
Map<String, Object> toMap(){
  return {
    // 'viewID' : viewID,
    'userID' : userID,
    'flyerID' : flyerID,
    'slideIndex' : slideIndex,
    'viewTime' : Timers.cipherDateTimeToString(viewTime),
  };
}
// -----------------------------------------------------------------------------
  static List<LDBColumn> _createLDBColumns(){
    List<LDBColumn> _columns = <LDBColumn>[
      LDBColumn(key: 'viewID', type: 'INTEGER', isPrimary: true),
      LDBColumn(key: 'userID', type: 'TEXT'),
      LDBColumn(key: 'flyerID', type: 'TEXT'),
      LDBColumn(key: 'slideIndex', type: 'INTEGER'),
      LDBColumn(key: 'viewTime', type: 'TEXT'),
    ];

    return _columns;
  }
// -----------------------------------------------------------------------------
  static Future<LDBTable> createLDBTable({BuildContext context}) async {

    List<LDBColumn> _columns = _createLDBColumns();


    LDBTable _dbTable = LDBTable(
      tableName: 'flyerViewsTable',
      columns: _columns,
      maps: [],
      db: null,
    );

    _dbTable = await LDB.createAndSetLDB(context: context, table: _dbTable);

    return _dbTable;
  }
// -----------------------------------------------------------------------------

}

