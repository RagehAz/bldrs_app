import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/numeric.dart';
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:flutter/cupertino.dart';
// -----------------------------------------------------------------------------
enum SpecType {
  width,
  length,
  height,
  volume,
  area,
  count,
  weight,
  oldPrice,
  currentPrice,
  inStock,
}

enum MeasureUnit {
  meter_linear,
  meter_square,
  meter_cubic,


}
/// ----------------------------------------------------------------------------
class Spec {
  final SpecType specType;
  final dynamic value; // string, int, double
  // final MeasureUnit unit;

  const Spec({
    @required this.specType,
    @required this.value,
    // @required this.unit,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap() {
    return {
      'specType': cipherSpecType(specType),
      'value': value,
      // 'unit' : cipherMeasureUnit(unit),
    };
  }
// -----------------------------------------------------------------------------
  Spec clone(){
    return
      Spec(
          specType: specType,
          value: value,
        // unit: unit,
      );
  }
// -----------------------------------------------------------------------------
  static List<Spec> cloneSpecs(List<Spec> specs){
    final List<Spec> _specs = <Spec>[];

    if (specs != null){
      for (Spec spec in specs){
        _specs.add(spec.clone());
      }
    }

    return _specs;
  }
// -----------------------------------------------------------------------------
  static Spec decipherSpec(Map<String, dynamic> map) {
    return
      Spec(
        specType: decipherSpecType(map['specType']),
        value: map['value'],
        // unit: map['unit'],
      );
  }
// -----------------------------------------------------------------------------
  static String cipherSpecType(SpecType specType){
    switch (specType) {
      case SpecType.width         : return 'width'        ; break;
      case SpecType.length        : return 'length'       ; break;
      case SpecType.height        : return 'height'       ; break;
      case SpecType.volume        : return 'volume'       ; break;
      case SpecType.area          : return 'area'         ; break;
      case SpecType.count         : return 'count'        ; break;
      case SpecType.weight        : return 'weight'       ; break;
      case SpecType.oldPrice      : return 'oldPrice'     ; break;
      case SpecType.currentPrice  : return 'currentPrice' ; break;
      case SpecType.inStock       : return 'inStock' ; break;
      default :
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static SpecType decipherSpecType(String input) {
    switch (input) {
      case 'width':return SpecType.width;break;
      case 'length':return SpecType.length;break;
      case 'height':return SpecType.height;break;
      case 'volume':return SpecType.volume;break;
      case 'area':return SpecType.area;break;
      case 'count':return SpecType.count;break;
      case 'weight':return SpecType.weight;break;
      case 'oldPrice' : return SpecType.oldPrice; break;
      case 'currentPrice' : return SpecType.currentPrice; break;
      case 'inStock' : return SpecType.inStock; break;
      default :
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static String getDataTypeOfSpecType({SpecType specType}){
    switch (specType) {
      case SpecType.width         : return 'double'     ; break;
      case SpecType.length        : return 'double'     ; break;
      case SpecType.height        : return 'double'     ; break;
      case SpecType.volume        : return 'double'     ; break;
      case SpecType.area          : return 'double'     ; break;
      case SpecType.count         : return 'int'        ; break;
      case SpecType.weight        : return 'double'     ; break;
      case SpecType.oldPrice      : return 'double'     ; break;
      case SpecType.currentPrice  : return 'double'     ; break;
      case SpecType.inStock       : return 'bool'     ; break;
      default :
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static dynamic assignValueDataTypeAccordingToSpecType({@required SpecType specType, @required String specValueString}){
    final String _dataType = getDataTypeOfSpecType(specType: specType);
    dynamic _output;

    if(_dataType == 'double'){
      final double _value = Numeric.stringToDouble(specValueString);
      _output = _value;
    }

    else if (_dataType == 'int'){
      final int _value = Numeric.stringToInt(specValueString);
      _output = _value;
    }

    else if (_dataType == 'String'){
      final String _value = specValueString;
      _output = _value;
    }

    else if (_dataType == 'bool'){
      final int _boolAsInt = Numeric.stringToInt(specValueString);
      final bool _value = Numeric.decipherBool(_boolAsInt);
      _output = _value;
    }

    return _output;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherSpecs(List<Spec> specs){
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.canLoopList(specs)){
      for (Spec spec in specs){
        _maps.add(spec.toMap());
      }
    }

    return _maps;
  }
// -----------------------------------------------------------------------------
  static List<Spec> decipherSpecs(List<dynamic> maps){
    final List<Spec> _specs = <Spec>[];

    if(Mapper.canLoopList(maps)){
      for (var map in maps){
        _specs.add(Spec.decipherSpec(map));
      }

    }

    return _specs;
  }
// -----------------------------------------------------------------------------
  static String cipherSpecValue(Spec spec){
    final String _dataType = getDataTypeOfSpecType(specType: spec.specType);
    String _output;

    if(_dataType == 'double'){
      _output = spec.value.toString();
    }

    else if (_dataType == 'int'){
      _output = spec.value.toString();
    }

    else if (_dataType == 'String'){
      _output = spec.value;
    }

    else if (_dataType == 'bool'){
      final int _valueAsInt = Numeric.cipherBool(spec.value);
      _output = '$_valueAsInt';
    }

    return _output;

  }
// -----------------------------------------------------------------------------
  static String sqlCipherSpec(Spec spec){
    String _string;

    if (spec != null){

      final String _specTypeString = cipherSpecType(spec.specType);
      final String _specValueString = cipherSpecValue(spec);

      _string = '${_specTypeString}#${_specValueString}';
    }

    return _string;
  }
// -----------------------------------------------------------------------------
  static Spec sqlDecipherSpec(String string){
    Spec spec;

    if (string != null){
      final String _specTypeString = TextMod.trimTextAfterLastSpecialCharacter(string, '#');
      final String _specValueString = TextMod.trimTextBeforeFirstSpecialCharacter(string, '#');

      final SpecType _specType = decipherSpecType(_specTypeString);

      final dynamic _specValue = assignValueDataTypeAccordingToSpecType(specType: _specType, specValueString: _specValueString);

      spec = Spec(
        specType: _specType,
        value: _specValue,
      );
    }

    return spec;
  }
// -----------------------------------------------------------------------------
  static String sqlCipherSpecs(List<Spec> specs){

    String _output;

    if (Mapper.canLoopList(specs)){

      final List<String> _specsSQLStrings = <String>[];

      for (Spec spec in specs){
        final String _specString = sqlCipherSpec(spec);
        _specsSQLStrings.add(_specString);
      }

      final String _sqlString = TextMod.sqlCipherStrings(_specsSQLStrings);

      _output = _sqlString;
    }

    return _output;
  }
// -----------------------------------------------------------------------------
  static List<Spec> sqlDecipherSpecs(String sqlSpecsString){

    final List<Spec> _specs = <Spec>[];

    if (sqlSpecsString != null){

      final List<String> _sqlSpecsStrings = TextMod.sqlDecipherStrings(sqlSpecsString);

      for (String sqlString in _sqlSpecsStrings){
        final Spec _spec = sqlDecipherSpec(sqlString);
        _specs.add(_spec);
      }
    }

    return _specs;
  }
// -----------------------------------------------------------------------------
  static bool specsAreTheSame(Spec specA, Spec specB){
    bool _areTheSame = false;

    if (specA != null && specB != null){

      if (specA.specType == specB.specType){

        if (specA.value == specB.value){

          _areTheSame = true;

        }

      }

    }

    return _areTheSame;
  }
// -----------------------------------------------------------------------------
  static bool specsListsAreTheSame(List<Spec> specsA, List<Spec> specsB){
    bool _listsAreTheSame = false;

    if (Mapper.canLoopList(specsA) && Mapper.canLoopList(specsB)){

      bool _stillTheSame;

      for (int i = 0; i < specsA.length; i++){

        final bool _specsAreTheSame = specsAreTheSame(specsA[i], specsB[i]);


        if (_specsAreTheSame == false){
          _stillTheSame = false;
          break;
        }{
          _stillTheSame = true;
        };

      }

      if (_stillTheSame == true){
        _listsAreTheSame = true;
      }

    }

    return _listsAreTheSame;
  }
}
/// ============================================================================


