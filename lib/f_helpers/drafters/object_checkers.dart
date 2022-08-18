import 'dart:io';

import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'dart:ui' as ui;

// -----------------------------------------------------------------------------
extension FileExtention on FileSystemEntity {
  String get fileNameWithExtension {
    return this?.path?.split('/')?.last;
  }

// -----------------------------------------------------------------------------
  String get fileExtension {
    return this?.path?.split('.')?.last;
  }
}

class ObjectChecker {
// -----------------------------------------------------------------------------

  const ObjectChecker();

// -----------------------------------------------------------------------------
  static String fileExtensionOf(dynamic file) {
    return file == null ?
    null
        :
    file is String == true ?
    File(file).fileExtension
        :
    null;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsURL(dynamic file) {
    bool _validURL;

    if (file != null && file is String) {
      _validURL = Uri.parse(file).isAbsolute;

    }

    else {
      _validURL = false;
    }

    return _validURL;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool isBase64(dynamic value) {
    if (value is String == true) {

      final RegExp rx = RegExp(
          r'^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$',
          multiLine: true,
          unicode: true);

      final bool isBase64Valid = rx.hasMatch(value);

      if (isBase64Valid == true) {
        return true;
      }

      else {
        return false;
      }

    }

    else {
      return false;
    }
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsFile(dynamic file) {
    bool _isFile = false;

    if (file != null) {

      final bool isFileA = file is File;
      final bool isFileB = file.runtimeType.toString() == '_File';

      if (isFileA == true || isFileB == true) {
        _isFile = true;
      }

      // blog('objectIsFile : isFile : $_isFile : [file is File : $isFileA] - [file == _File] : $isFileB');

    }

    else {
      blog('objectIsFile : isFile : null');
    }


    return _isFile;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsUint8List(dynamic object) {
    bool _isUint8List = false;

    if (object != null) {
      if (
      object.runtimeType.toString() == '_Uint8ArrayView'
          ||
      object.runtimeType.toString() == 'Uint8List'
      ) {
        _isUint8List = true;
      }
    }

    return _isUint8List;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsSVG(dynamic object) {
    bool _isSVG;

    if (fileExtensionOf(object) == 'svg') {
      _isSVG = true;
    }

    else {
      _isSVG = false;
    }

    return _isSVG;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsJPGorPNG(dynamic object) {
    bool _objectIsJPGorPNG;

    if (fileExtensionOf(object) == 'jpeg' ||
        fileExtensionOf(object) == 'jpg' ||
        fileExtensionOf(object) == 'png') {
      _objectIsJPGorPNG = true;
    }

    else {
      _objectIsJPGorPNG = false;
    }

    return _objectIsJPGorPNG;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsUiImage(dynamic object){
    bool _isUiImage = false;

    if (object != null){

      if (object is ui.Image){
        _isUiImage = true;
      }

    }

    return _isUiImage;
  }
// -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool objectIsImgImage(dynamic object){
    bool _isImgImage = false;

    if (object != null){

      if (object is img.Image){
        _isImgImage = true;
      }

    }

    return _isImgImage;
  }
// -----------------------------------------------------------------------------
  static Future<bool> objectIsIntInString(BuildContext context, dynamic string) async {
    bool _objectIsIntInString;
    int _int;

    if (string != null) {
      _int = int.tryParse(string.trim());
    }

    if (_int == null) {
      _objectIsIntInString = false;
    }

    else {
      _objectIsIntInString = true;
    }

    // print('objectIsIntInString : string is : $string');
    // print('objectIsIntInString : _int is : $_int');
    // print('objectIsIntInString : _objectIsIntInString is : $_objectIsIntInString');
    // print('objectIsIntInString returns $_objectIsIntInString');

    return _objectIsIntInString;
  }
// -----------------------------------------------------------------------------
  static bool objectIsDoubleInString(dynamic string) {
    bool _objectIsDoubleInString;
    double _double;

    if (string != null) {
      _double = double.tryParse(string.trim());
    }

    if (_double == null) {
      _objectIsDoubleInString = false;
    }

    else {
      _objectIsDoubleInString = true;
    }

    blog('objectIsDoubleInString : _double is : $_double');

    return _objectIsDoubleInString;
  }
// -----------------------------------------------------------------------------
  static bool objectIsDateTime(dynamic object) {
    final bool _isDatTime = object?.runtimeType == DateTime;
    return _isDatTime;
  }
// -----------------------------------------------------------------------------
  static bool objectIsGeoPoint(dynamic object) {
    final bool _isGeoPoint = object?.runtimeType == GeoPoint;
    return _isGeoPoint;
  }
// -----------------------------------------------------------------------------
  static bool objectIsTimeStamp(dynamic object) {
    final bool _isTimestamp = object?.runtimeType == Timestamp;
    return _isTimestamp;
  }
// -----------------------------------------------------------------------------
  static bool objectIsListOfSpecs(dynamic object) {
    bool _objectsListIsSpecs = false;

    if (object != null) {
      if (object.length > 0) {
        if (object[0].runtimeType == SpecModel) {
          _objectsListIsSpecs = true;
        }
      }
    }

    return _objectsListIsSpecs;
  }
// -----------------------------------------------------------------------------
  static bool objectIsNull(dynamic object){
    bool _isNull;

    if (object == null){
      _isNull = true;
    }

    else {
      _isNull = false;
    }

    return _isNull;
  }
// -----------------------------------------------------------------------------

}
