import 'dart:io';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:flutter/material.dart';

import 'text_manipulators.dart';

// === === === === === === === === === === === === === === === === === === ===
extension FileExtention on FileSystemEntity {
  String get fileNameWithExtension {
    return this?.path?.split("/")?.last;
  }

// === === === === === === === === === === === === === === === === === === ===
  String get fileExtension {
    return this?.path?.split(".")?.last;
  }
}
// === === === === === === === === === === === === === === === === === === ===
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
        removeFirstCharacterFromAString(fileAsString);
    // print('stringWithoutFirstCharacter is : $stringWithoutFirstCharacter');
    return stringWithoutFirstCharacter == 'File' ? true : false;
  }
// -----------------------------------------------------------------------------
  static bool objectIsSVG(dynamic object) {
    return fileExtensionOf(object) == 'svg' ? true : false;
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
    int _num;

    dynamic _result = await tryCatchAndReturn(
        context: context,
        methodName: 'objectIsIntInString',
        functions: () async {

          _num = int.parse(string);

        }
    );

    print('_result.runtimeType is ${_result.runtimeType}');

    if (_result.runtimeType == String){
      _objectIsIntInString = false;

    } else {
      _objectIsIntInString = true;
    }

    print('objectIsIntInString : _num is : $_num');

    return _objectIsIntInString;

  }
// -----------------------------------------------------------------------------
  static Future<bool> objectIsDoubleInString(BuildContext context, dynamic string) async {

    bool objectIsDoubleInString;
    double _double;

    dynamic _result = await tryCatchAndReturn(
        context: context,
        methodName: 'objectIsIntInString',
        functions: () async {

          _double = double.parse(string);

        }
    );

    print('_result.runtimeType is ${_result.runtimeType}');

    if (_result.runtimeType == String){
      objectIsDoubleInString = false;

    } else {
      objectIsDoubleInString = true;
    }

    print('objectIsDoubleInString : _double is : $_double');

    return objectIsDoubleInString;

  }
// -----------------------------------------------------------------------------
}
