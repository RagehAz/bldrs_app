import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/providers/local_db/models/ldb.dart';
import 'package:bldrs/providers/local_db/models/ldb_column.dart';
import 'package:bldrs/providers/local_db/models/ldb_table.dart';
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
    // 'viewID' : viewID,
    'userID' : userID,
    'flyerID' : flyerID,
    'slideIndex' : slideIndex,
    'viewTime' : Timers.cipherDateTimeToString(viewTime),
  };
}
// -----------------------------------------------------------------------------
    static const List<LDBColumn> columns = const <LDBColumn>[
      LDBColumn(key: 'viewID', type: 'INTEGER', isPrimary: true),
      LDBColumn(key: 'userID', type: 'TEXT'),
      LDBColumn(key: 'flyerID', type: 'TEXT'),
      LDBColumn(key: 'slideIndex', type: 'INTEGER'),
      LDBColumn(key: 'viewTime', type: 'TEXT'),
    ];
// -----------------------------------------------------------------------------
  static Future<LDBTable> createLDBTable({BuildContext context, String tableName}) async {

    final LDBTable _dbTable = await LDB.createAndSetLDB(
      context: context,
      tableName: tableName,
      columns: columns,
    );

    return _dbTable;
  }
// -----------------------------------------------------------------------------

}

