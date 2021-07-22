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
  price,
}
/// ----------------------------------------------------------------------------
class Spec {
  final SpecType specType;
  final dynamic value; // string, int, double

  Spec({
    @required this.specType,
    @required this.value,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap() {
    return {
      'specType': specType.toString(),
      'value': value,
    };
  }
// -----------------------------------------------------------------------------
  Spec clone(){
    return
      Spec(
          specType: specType,
          value: value
      );
  }
// -----------------------------------------------------------------------------
  static List<Spec> cloneSpecs(List<Spec> specs){
    List<Spec> _specs = new List();

    for (Spec spec in specs){
      _specs.add(spec.clone());
    }

    return _specs;
  }
// -----------------------------------------------------------------------------
  static Spec decipherSpec(Map<String, dynamic> map) {
    return
      Spec(
        specType: decipherSpecType(map['specType']),
        value: map['value'],
      );
  }

// -----------------------------------------------------------------------------
  static SpecType decipherSpecType(dynamic input) {
    switch (input) {
      case 'width':return SpecType.width;break;
      case 'length':return SpecType.length;break;
      case 'height':return SpecType.height;break;
      case 'volume':return SpecType.volume;break;
      case 'area':return SpecType.area;break;
      case 'count':return SpecType.count;break;
      case 'weight':return SpecType.weight;break;
      case 'price' : return SpecType.price; break;

      default :
        return null;
    }
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherSpecs(List<Spec> specs){
    List<Map<String, dynamic>> _maps = new List();

    for (Spec spec in specs){
      _maps.add(spec.toMap());
    }
  return _maps;
  }
// -----------------------------------------------------------------------------
  static List<Spec> decipherSpecs(List<dynamic> maps){
    List<Spec> _specs = new List();

    if(maps != null && maps.length != 0){
      for (var map in maps){
        _specs.add(Spec.decipherSpec(map));
      }

    }

    return _specs;
  }
// -----------------------------------------------------------------------------
}
/// ============================================================================
