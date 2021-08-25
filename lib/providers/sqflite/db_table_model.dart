import 'package:bldrs/providers/sqflite/db_column_model.dart';
import 'package:flutter/foundation.dart';

class DBTable{
  final String dbName;
  final List<DBColumn> dbColumns;

  DBTable({
    @required this.dbName,
    @required this.dbColumns,
  });
// -----------------------------------------------------------------------------
  String toSQLQuery(){

    String _columnsQuery = DBColumn.getSQLQueryFromColumns(columns: dbColumns);

    String _sqlQuery = '$dbName ($_columnsQuery)';

    return _sqlQuery;
  }
// -----------------------------------------------------------------------------
  String toRawInsertString(){

    String _fieldsRawInsertString = DBColumn.getFieldsRawInsertString(dbColumns);
    String _valuesRawInsertString = DBColumn.getValuesRawInsertString(dbColumns);

    /// 'INSERT INTO dbName(field, field, field, field) VALUES("value", "value", "value", "value")'
    String _rawInsertString = 'INSERT INTO $dbName$_fieldsRawInsertString VALUES$_valuesRawInsertString';

    return _rawInsertString;
  }
// -----------------------------------------------------------------------------
}
