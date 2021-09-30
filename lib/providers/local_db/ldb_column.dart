import 'package:bldrs/controllers/drafters/text_manipulators.dart';
import 'package:flutter/foundation.dart';

class LDBColumn{
  final String key;
  final String type;
  final bool isPrimary;

  const LDBColumn({
    @required this.key,
    @required this.type,
    this.isPrimary = false,
  });
// -----------------------------------------------------------------------------
  static String _getSQLQueryFromColumn({LDBColumn column}){

    final String _primary = column.isPrimary == true ? ' PRIMARY KEY' : '';

    return
      '${column.key} ${column.type}$_primary, ';
  }
// -----------------------------------------------------------------------------
  static String getSQLQueryFromColumns({List<LDBColumn> columns}){
    String _sqlQuery = '';

    columns.forEach((column) {
      String _columnSQL = _getSQLQueryFromColumn(column: column);

      _sqlQuery = _sqlQuery + _columnSQL;

    });

    final String _sqlWithoutLastSpace = TextMod.trimTextAfterLastSpecialCharacter(_sqlQuery, ',');

    return _sqlWithoutLastSpace;
  }
// -----------------------------------------------------------------------------
  static String getFieldsRawInsertString(List<LDBColumn> columns){
    /// should return '(field, field, field, field)'

    String _output = '';

    for (LDBColumn column in columns){

      if (column.isPrimary != true){
        _output = _output + '${column.key}, ';
      }

    }

    final String _outputAfterRemovingLastComma = TextMod.trimTextAfterLastSpecialCharacter(_output, ',');

    final String _finalOutput = '($_outputAfterRemovingLastComma)';

    return _finalOutput;
  }
// -----------------------------------------------------------------------------
  static String getPrimaryKeyFromColumns(List<LDBColumn> columns){
    final LDBColumn _primaryColumn = columns.singleWhere((column) => column.isPrimary == true, orElse: ()=> null);
    final String _primaryKey = _primaryColumn == null ? null : _primaryColumn.key;
    return _primaryKey;
  }
// -----------------------------------------------------------------------------
//   static List<LDBColumn> getColumnsFromMap({Map<String, Object> map, String primaryKey}){
//     List<LDBColumn> _columns = [];
//
//     List<Object> _keys = map.keys.toList();
//
//     for (String key in _keys){
//
//       _columns.add(
//           LDBColumn(
//             key: key,
//             type: 'TEXT', // this entire method aslan does not make sence
//             isPrimary: key == primaryKey ? true : false,
//           )
//       );
//
//     }
//
//     return _columns;
//   }
// -----------------------------------------------------------------------------
}
