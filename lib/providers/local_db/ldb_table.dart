import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/providers/local_db/ldb_column.dart';
import 'package:flutter/foundation.dart';

class LDBTable{
  final String tableName;
  final List<LDBColumn> columns;
  /// each map is a row in the table, map keys are the column fields
  final List<Map<String, dynamic>> maps;

  LDBTable({
    @required this.tableName,
    @required this.columns,
    @required this.maps,
  });
// -----------------------------------------------------------------------------
  static String _getValuesRawInsertString({Map<String, dynamic> map, List<LDBColumn> columns}){
    /// should return ("value", "value", "value", "value")

    String _output = '';

      List<String> _mapKeys = map.keys;
      List<String> _mapValues = map.values;

    for (int i = 0; i < map.values.length; i++){

      bool _isPrimary = _mapKeys[i] == LDBColumn.getPrimaryKeyFromColumns(columns);

      if (_isPrimary == false){

        String _value = _mapValues[i];

        _output = _output + '"$_value", ';
      }

    }

    String _outputAfterRemovingLastComma = TextMod.trimTextAfterLastSpecialCharacter(_output, ',');

    String _finalOutput = '($_outputAfterRemovingLastComma)';

    return _finalOutput;
  }
// -----------------------------------------------------------------------------
  String toCreateSQLQuery(){

    String _columnsQuery = LDBColumn.getSQLQueryFromColumns(columns: columns);

    String _createTableQuery = 'CREATE TABLE $tableName ($_columnsQuery)}';

    return _createTableQuery;
  }
// -----------------------------------------------------------------------------
  static String getRawInsertSQLQuery({Map<String, dynamic> map, List<LDBColumn> columns, String tableName}){

    String _fieldsRawInsertString = LDBColumn.getFieldsRawInsertString(columns);
    String _valuesRawInsertString = _getValuesRawInsertString(
      columns: columns,
      map: map,
    );

    /// 'INSERT INTO dbName(field, field, field, field) VALUES("value", "value", "value", "value")'
    String _rawInsertString = 'INSERT INTO $tableName$_fieldsRawInsertString VALUES$_valuesRawInsertString';

    return _rawInsertString;
  }
// -----------------------------------------------------------------------------
}
