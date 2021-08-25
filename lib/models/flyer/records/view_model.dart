// -----------------------------------------------------------------------------
import 'package:bldrs/providers/sqflite/db_column_model.dart';
import 'package:bldrs/providers/sqflite/db_table_model.dart';

class ViewModel{
  final String viewID;
  final String userID;
  final String slideID;
  final DateTime viewTime;
// -----------------------------------------------------------------------------
  ViewModel({
  this.viewID,
  this.userID,
  this.slideID,
  this.viewTime,
});
// -----------------------------------------------------------------------------
Map<String, Object> toMap(){
  return {
    'viewID' : viewID,
    'userID' : userID,
    'slideID' : slideID,
    'viewTime' : viewTime,
  };
}
// -----------------------------------------------------------------------------
  static DBTable flyerViewsDBTable(){

    List<DBColumn> _columns = <DBColumn>[
      DBColumn(field: 'viewID', type: 'INTEGER', isPrimary: true),
      DBColumn(field: 'userID', type: 'TEXT'),
      DBColumn(field: 'slideID', type: 'TEXT'),
      DBColumn(field: 'viewTime', type: 'TEXT'),
    ];

    DBTable _dbTable = DBTable(
      dbName: 'flyerViewsTable',
      dbColumns: _columns,
    );

    return _dbTable;
  }
// -----------------------------------------------------------------------------
}

