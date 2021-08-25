import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:flutter/foundation.dart';

class DBColumn{
  final String field;
  final String type;
  final bool isPrimary;
  dynamic value;

  DBColumn({
    @required this.field,
    @required this.type,
    this.isPrimary = false,
    this.value,
  });
// -----------------------------------------------------------------------------
  static String getSQLQueryFromColumn({DBColumn column}){

    String _primary = column.isPrimary == true ? ' PRIMARY KEY' : '';

    return
      '${column.field} ${column.type}$_primary, ';
  }
// -----------------------------------------------------------------------------
  static String getSQLQueryFromColumns({List<DBColumn> columns}){
    String _sqlQuery = '';

    columns.forEach((column) {
      String _columnSQL = getSQLQueryFromColumn(column: column);

      _sqlQuery = _sqlQuery + _columnSQL;

    });

    String _sqlWithoutLastSpace = TextMod.trimTextAfterLastSpecialCharacter(_sqlQuery, ',');

    return _sqlWithoutLastSpace;
  }
// -----------------------------------------------------------------------------
  static String getFieldsRawInsertString(List<DBColumn> columns){
    /// should return '(field, field, field, field)'

    String _output = '';

    for (DBColumn column in columns){

      if (column.isPrimary != true){
        _output = _output + '${column.field}, ';
      }

    }

    String _outputAfterRemovingLastComma = TextMod.trimTextAfterLastSpecialCharacter(_output, ',');

    String _finalOutput = '($_outputAfterRemovingLastComma)';

    return _finalOutput;
  }
// -----------------------------------------------------------------------------
  static String getValuesRawInsertString(List<DBColumn> columns){
    /// should return ("value", "value", "value", "value")

    String _output = '';

    for (DBColumn column in columns){

      if (column.isPrimary != true){
        _output = _output + '"${column.value}", ';
      }

    }

    String _outputAfterRemovingLastComma = TextMod.trimTextAfterLastSpecialCharacter(_output, ',');

    String _finalOutput = '($_outputAfterRemovingLastComma)';

    return _finalOutput;
  }
// -----------------------------------------------------------------------------
}
