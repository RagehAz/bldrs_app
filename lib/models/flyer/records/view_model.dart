import 'package:bldrs/models/flyer/sub/slide_model.dart';
import 'package:bldrs/providers/local_db/ldb_column.dart';
import 'package:bldrs/providers/local_db/ldb_table.dart';

class ViewModel{
  final String viewID;
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
    'viewID' : viewID,
    'userID' : userID,
    'flyerID' : flyerID,
    'slideIndex' : slideIndex,
    'viewTime' : viewTime,
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
  static LDBTable createLDBTable(){

    List<LDBColumn> _columns = _createLDBColumns();

    LDBTable _dbTable = LDBTable(
      tableName: 'flyerViewsTable',
      columns: _columns,
      maps: new List(),
    );

    return _dbTable;
  }
// -----------------------------------------------------------------------------
}

