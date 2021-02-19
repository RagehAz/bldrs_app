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
  Map<String,String> toMap(){
    return {
      'code' : code,
      'value' : value,
    };
  }
}
// ---------------------------------------------------------------------------
