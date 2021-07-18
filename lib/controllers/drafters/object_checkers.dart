import 'dart:io';
import 'package:bldrs/controllers/drafters/text_manipulators.dart';
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
    bool valueIsString = value.runtimeType == String ? true : false;
    return valueIsString;
  }
// -----------------------------------------------------------------------------
  static bool objectIsList(dynamic value) {
    bool valueIsString = value.runtimeType == List ? true : false;
    return valueIsString;
  }
// -----------------------------------------------------------------------------
  static bool objectIsURL(dynamic file) {
    bool _validURL =
        objectIsString(file) == true ? Uri.parse(file).isAbsolute : false;
    return _validURL;
  }
// -----------------------------------------------------------------------------
  static bool objectIsFile(dynamic file) {
    // print('runtTimeType is : $file');
    String fileAsString = (file.runtimeType).toString();
    // print('fileAsString is : $fileAsString');
    String stringWithoutFirstCharacter =
    TextMod.removeFirstCharacterFromAString(fileAsString);
    // print('stringWithoutFirstCharacter is : $stringWithoutFirstCharacter');
    return stringWithoutFirstCharacter == 'File' ? true : false;
  }
// -----------------------------------------------------------------------------
  static bool objectIsSVG(dynamic object) {
    return fileExtensionOf(object) == 'svg' ? true : false;
  }
// -----------------------------------------------------------------------------
  static bool objectIsAsset(dynamic object){

    bool _objectIsAsset =
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
            fileExtensionOf(object) == 'png'
        ? true
        : false;
  }
// -----------------------------------------------------------------------------
  static bool objectIsColor(dynamic object) {
    bool objectIsColor = object.runtimeType == Color ? true : false;
    return objectIsColor;
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

    bool objectIsDoubleInString;
    double _double;

    if (string != null){
      _double = double.tryParse(string.trim());
    }

    if (_double == null){
      objectIsDoubleInString = false;
    } else {
      objectIsDoubleInString = true;
    }


    print('objectIsDoubleInString : _double is : $_double');

    return objectIsDoubleInString;

  }
// -----------------------------------------------------------------------------
}
