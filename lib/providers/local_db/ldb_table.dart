import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:bldrs/providers/local_db/ldb_column.dart';
import 'package:flutter/foundation.dart';

class LDBTable{
  final String tableName;
  final List<LDBColumn> columns;
  /// each map is a row in the table, map keys are the column fields
  List<Map<String, dynamic>> maps;

  LDBTable({
    @required this.tableName,
    @required this.columns,
    @required this.maps,
  });
// -----------------------------------------------------------------------------
  static String _getValuesRawInsertString({Map<String, Object> map, List<LDBColumn> columns}){
    /// should return ("value", "value", "value", "value")

    String _output = '';

      List<Object> _mapKeys = map.keys.toList();
      print('A - _getValuesRawInsertString : _mapKeys : $_mapKeys');

      List<Object> _mapValues = map.values.toList();
      print('B - _getValuesRawInsertString : _mapValues : $_mapValues');

    for (int i = 0; i < map.values.length; i++){

      bool _isPrimary = _mapKeys[i] == LDBColumn.getPrimaryKeyFromColumns(columns);
      print('C1 - i:$i - _getValuesRawInsertString : _isPrimary : $_isPrimary');

      if (_isPrimary == false){

        dynamic _value = _mapValues[i].toString();
        print('C2 - i:$i - _getValuesRawInsertString : _value : $_value');

        _output = _output + '"$_value", ';
        print('C3 - i:$i - _getValuesRawInsertString : _output : $_output');
      }

    }

    String _outputAfterRemovingLastComma = TextMod.trimTextAfterLastSpecialCharacter(_output, ',');
    print('D - _getValuesRawInsertString : _outputAfterRemovingLastComma $_outputAfterRemovingLastComma');

    String _finalOutput = '($_outputAfterRemovingLastComma)';
    print('E - _getValuesRawInsertString : _finalOutput $_finalOutput');

    return _finalOutput;
  }
// -----------------------------------------------------------------------------
  String toCreateSQLQuery(){

    String _columnsQuery = LDBColumn.getSQLQueryFromColumns(columns: columns);

    String _createTableQuery = 'CREATE TABLE $tableName ($_columnsQuery)';

    return _createTableQuery;
  }
// -----------------------------------------------------------------------------
  static String getRawInsertSQLQuery({Map<String, dynamic> map, List<LDBColumn> columns, String tableName}){

    String _fieldsRawInsertString = LDBColumn.getFieldsRawInsertString(columns);
    print('1 - getRawInsertSQLQuery : _fieldsRawInsertString : $_fieldsRawInsertString');

    String _valuesRawInsertString = _getValuesRawInsertString(
      columns: columns,
      map: map,
    );
    print('2 - getRawInsertSQLQuery : _valuesRawInsertString : $_valuesRawInsertString');

    /// 'INSERT INTO dbName(field, field, field, field) VALUES("value", "value", "value", "value")'
    String _rawInsertString = 'INSERT INTO $tableName$_fieldsRawInsertString VALUES$_valuesRawInsertString';

    return _rawInsertString;
  }
// -----------------------------------------------------------------------------
}
