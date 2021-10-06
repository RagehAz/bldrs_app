import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/providers/local_db/sql_db/sql_column.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class SQLTable{
  Database db;
  final String tableName;
  final List<SQLColumn> columns;
  /// each map is a row in the table, map keys are the column fields
  List<Map<String, dynamic>> maps;

  SQLTable({
    @required this.db,
    @required this.tableName,
    @required this.columns,
    @required this.maps,
  });
// -----------------------------------------------------------------------------
  static String _getValuesRawInsertString({Map<String, Object> map, List<SQLColumn> columns}){
    /// should return ("value", "value", "value", "value")

    String _output = '';

    final List<Object> _mapKeys = map.keys.toList();
      // print('A - _getValuesRawInsertString : _mapKeys : $_mapKeys');

    final List<Object> _mapValues = map.values.toList();
      // print('B - _getValuesRawInsertString : _mapValues : $_mapValues');

    for (int i = 0; i < map.values.length; i++){

      final bool _isPrimary = _mapKeys[i] == SQLColumn.getPrimaryKeyFromColumns(columns);
      // print('C1 - i:$i - _getValuesRawInsertString : _isPrimary : $_isPrimary');

      if (_isPrimary == false){

        final dynamic _value = _mapValues[i].toString();
        // print('C2 - i:$i - _getValuesRawInsertString : _value : $_value');

        _output = _output + '"$_value", ';
        // print('C3 - i:$i - _getValuesRawInsertString : _output : $_output');
      }

    }

    final String _outputAfterRemovingLastComma = TextMod.trimTextAfterLastSpecialCharacter(_output, ',');
    // print('D - _getValuesRawInsertString : _outputAfterRemovingLastComma $_outputAfterRemovingLastComma');

    final String _finalOutput = '($_outputAfterRemovingLastComma)';
    // print('E - _getValuesRawInsertString : _finalOutput $_finalOutput');

    return _finalOutput;
  }
// -----------------------------------------------------------------------------
  String toCreateSQLQuery(){

    final String _columnsQuery = SQLColumn.getSQLQueryFromColumns(columns: columns);

    final String _createTableQuery = 'CREATE TABLE $tableName ($_columnsQuery)';

    return _createTableQuery;
  }
// -----------------------------------------------------------------------------
  static String getRawInsertSQLQuery({Map<String, dynamic> map, List<SQLColumn> columns, String tableName}){

    final String _fieldsRawInsertString = SQLColumn.getFieldsRawInsertString(columns);
    // print('1 - getRawInsertSQLQuery : _fieldsRawInsertString : $_fieldsRawInsertString');

    final String _valuesRawInsertString = _getValuesRawInsertString(
      columns: columns,
      map: map,
    );
    // print('2 - getRawInsertSQLQuery : _valuesRawInsertString : $_valuesRawInsertString');

    /// 'INSERT INTO dbName(field, field, field, field) VALUES("value", "value", "value", "value")'
    final String _rawInsertString = 'INSERT INTO $tableName$_fieldsRawInsertString VALUES$_valuesRawInsertString';

    return _rawInsertString;
  }
// -----------------------------------------------------------------------------
}
