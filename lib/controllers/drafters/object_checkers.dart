import 'dart:io';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
// -----------------------------------------------------------------------------
extension FileExtention on FileSystemEntity {
  String get fileNameWithExtension {
    return this?.path?.split("/")?.last;
  }

// -----------------------------------------------------------------------------
  String get fileExtension {
    return this?.path?.split(".")?.last;
  }
}
// -----------------------------------------------------------------------------
class ObjectChecker {
// -----------------------------------------------------------------------------
  static bool listCanBeUsed(List<dynamic> list){

    final bool _canBeUsed =
    list == null ? false :
    list.length == 0 ? false : true;

    return _canBeUsed;
  }
// -----------------------------------------------------------------------------
  static fileExtensionOf(dynamic file) {
    return
      file == null ? null
          :
    objectIsString(file) == true ? File(file).fileExtension
        :
    null;
  }
// -----------------------------------------------------------------------------
  static bool objectIsString(dynamic value) {
    final bool _valueIsString = value.runtimeType == String ? true : false;
    return _valueIsString;
  }
// -----------------------------------------------------------------------------
  static bool objectIsList(dynamic value) {
    final bool _valueIsString = value.runtimeType == List ? true : false;
    return _valueIsString;
  }
// -----------------------------------------------------------------------------
  static bool objectIsURL(dynamic file) {
    final bool _validURL = objectIsString(file) == true ? Uri.parse(file).isAbsolute : false;
    return _validURL;
  }
// -----------------------------------------------------------------------------
  static bool isBase64(dynamic value) {

    if (objectIsString(value) == true){
      final RegExp rx = RegExp(r'^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$', multiLine: true, unicode: true);

      final bool isBase64Valid = rx.hasMatch(value);

      if (isBase64Valid == true) {

        return true;
      } else {
        return false;
      }

    } else {
      return false;
    }

  }
// -----------------------------------------------------------------------------
  static bool objectIsFile(dynamic file) {
    bool _isFile = false;

    if(file != null){
      if(file.runtimeType.toString() == '_File'){
        _isFile = true;
      }
    }

    return _isFile;
  }
// -----------------------------------------------------------------------------
  static bool objectIsUint8List(dynamic file){
    bool _isUint8List = false;

    if(file != null){
      if(file.runtimeType.toString() == '_Uint8ArrayView'){
        _isUint8List = true;
      }
    }

    return _isUint8List;
  }
// -----------------------------------------------------------------------------
  static bool objectIsSVG(dynamic object) {
    return fileExtensionOf(object) == 'svg' ? true : false;
  }
// -----------------------------------------------------------------------------
  static bool objectIsAsset(dynamic object){

    final bool _objectIsAsset =
    object == null ? null
        :
    object.runtimeType == Asset ? true : false;

    return
      _objectIsAsset;
  }
// -----------------------------------------------------------------------------
  static bool objectIsJPGorPNG(dynamic object) {

    return fileExtensionOf(object) == 'jpeg' ||
            fileExtensionOf(object) == 'jpg' ||
            fileExtensionOf(object) == 'png' ?

    true : false;
  }
// -----------------------------------------------------------------------------
  static bool objectIsColor(dynamic object) {
    final bool _objectIsColor = object.runtimeType == Color ? true : false;
    return _objectIsColor;
  }
// -----------------------------------------------------------------------------
  static Future<bool> objectIsIntInString(BuildContext context, dynamic string) async {

    bool _objectIsIntInString;
    int _int;

    if (string != null){
      _int = int.tryParse(string.trim());
    }

    if (_int == null){
      _objectIsIntInString = false;
    } else {
      _objectIsIntInString = true;
    }

    // print('objectIsIntInString : string is : $string');
    // print('objectIsIntInString : _int is : $_int');
    // print('objectIsIntInString : _objectIsIntInString is : $_objectIsIntInString');
    // print('objectIsIntInString returns $_objectIsIntInString');

    return _objectIsIntInString;

  }
// -----------------------------------------------------------------------------
  static Future<bool> objectIsDoubleInString(BuildContext context, dynamic string) async {

    bool _objectIsDoubleInString;
    double _double;

    if (string != null){
      _double = double.tryParse(string.trim());
    }

    if (_double == null){
      _objectIsDoubleInString = false;
    } else {
      _objectIsDoubleInString = true;
    }

    print('objectIsDoubleInString : _double is : $_double');

    return _objectIsDoubleInString;

  }
// -----------------------------------------------------------------------------
}
