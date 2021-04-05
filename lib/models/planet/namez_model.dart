import 'package:flutter/foundation.dart';
// ---------------------------------------------------------------------------
class Namez {
  /// language code
  final String code;
  /// name in this language
  final String value;

  Namez({
    @required this.code,
    @required this.value,
  });
// ---------------------------------------------------------------------------
  Map<String,String> toMap(){
    return {
      'code' : code,
      'value' : value,
    };
  }
// ---------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherNamezz(List<Namez> namezz){
    List<Map<String, dynamic>> _namezMaps = new List();
    namezz.forEach((nm) {
      _namezMaps.add(nm.toMap());
    });
    return _namezMaps;
  }
// ---------------------------------------------------------------------------
  static Namez decipherNamezMap(Map<String, dynamic> map){
    return Namez(
      code : 'code',
      value : 'value',
    );
  }
// ---------------------------------------------------------------------------
  static List<Namez> decipherNamezzMaps(List<dynamic> maps){
    List<Namez> _namez = new List();
    maps?.forEach((map) {
      _namez.add(decipherNamezMap(map));
    });
    return _namez;
  }
// ---------------------------------------------------------------------------
}
