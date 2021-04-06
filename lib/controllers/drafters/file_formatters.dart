import 'dart:io';
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
    return file == null
        ? null
        : objectIsString(file) == true
            ? File(file).fileExtension
            : null;
  }
// -----------------------------------------------------------------------------
  static objectIsString(dynamic value) {
    bool valueIsString = value.runtimeType == String ? true : false;
    return valueIsString;
  }
// -----------------------------------------------------------------------------
  static objectIsURL(dynamic file) {
    bool _validURL =
        objectIsString(file) == true ? Uri.parse(file).isAbsolute : false;
    return _validURL;
  }
// -----------------------------------------------------------------------------
  static objectIsFile(dynamic file) {
    // print('runtTimeType is : $file');
    String fileAsString = (file.runtimeType).toString();
    // print('fileAsString is : $fileAsString');
    String stringWithoutFirstCharacter =
        removeFirstCharacterFromAString(fileAsString);
    // print('stringWithoutFirstCharacter is : $stringWithoutFirstCharacter');
    return stringWithoutFirstCharacter == 'File' ? true : false;
  }
// -----------------------------------------------------------------------------
  static objectIsSVG(dynamic object) {
    return fileExtensionOf(object) == 'svg' ? true : false;
  }
// -----------------------------------------------------------------------------
  static objectIsJPGorPNG(dynamic object) {
    return fileExtensionOf(object) == 'jpeg' ||
            fileExtensionOf(object) == 'jpg' ||
            fileExtensionOf(object) == 'png'
        ? true
        : false;
  }
// -----------------------------------------------------------------------------
  static objectIsColor(dynamic object) {
    bool objectIsColor = object.runtimeType == Color ? true : false;
    return objectIsColor;
  }
// === === === === === === === === === === === === === === === === === === ===
}
