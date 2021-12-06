import 'dart:io';
import 'package:bldrs/models/kw/specs/spec_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
// -----------------------------------------------------------------------------
  fileExtensionOf(dynamic file) {
    return
      file == null ? null
          :
    file is String == true ? File(file).fileExtension
        :
    null;
  }
// -----------------------------------------------------------------------------
  bool objectIsURL(dynamic file) {
    bool _validURL;

    if (file is String){
      _validURL = Uri.parse(file).isAbsolute;
    }

    else {
      _validURL = false;
    }

    return _validURL;
  }
// -----------------------------------------------------------------------------
  bool isBase64(dynamic value) {

    if (value is String == true){
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
  bool objectIsFile(dynamic file) {
    bool _isFile = false;

    if(file != null){
      if(file.runtimeType.toString() == '_File'){
        _isFile = true;
      }
    }

    return _isFile;
  }
// -----------------------------------------------------------------------------
  bool objectIsUint8List(dynamic file){
    bool _isUint8List = false;

    if(file != null){
      if(file.runtimeType.toString() == '_Uint8ArrayView'){
        _isUint8List = true;
      }
    }

    return _isUint8List;
  }
// -----------------------------------------------------------------------------
  bool objectIsSVG(dynamic object) {

    bool _isSVG;

    if (fileExtensionOf(object) == 'svg'){
      _isSVG = true;
    }
    else {
      _isSVG = false;
    }

    return _isSVG;
  }
// -----------------------------------------------------------------------------
  bool objectIsAsset(dynamic object){

    bool _objectIsAsset;

    if (object is Asset){
      _objectIsAsset = true;
    }

    else {
      _objectIsAsset = false;
    }

    return
      _objectIsAsset;
  }
// -----------------------------------------------------------------------------
  bool objectIsJPGorPNG(dynamic object) {

    bool _objectIsJPGorPNG;

    if (fileExtensionOf(object) == 'jpeg' ||
        fileExtensionOf(object) == 'jpg' ||
        fileExtensionOf(object) == 'png'){
      _objectIsJPGorPNG = true;
    }
    else {
      _objectIsJPGorPNG = false;
    }

    return _objectIsJPGorPNG;
  }
// -----------------------------------------------------------------------------
  Future<bool> objectIsIntInString(BuildContext context, dynamic string) async {

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
  bool objectIsDoubleInString(dynamic string) {

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
  bool objectIsDateTime(dynamic object){

    final bool _isDatTime = object?.runtimeType == DateTime;

    return _isDatTime;

  }
// -----------------------------------------------------------------------------
  bool objectIsGeoPoint(dynamic object){

    final bool _isGeoPoint = object?.runtimeType == GeoPoint;

    return _isGeoPoint;
  }
// -----------------------------------------------------------------------------
  bool objectIsTimeStamp(dynamic object){

    final bool _isTimestamp = object?.runtimeType == Timestamp;

    return _isTimestamp;
  }
// -----------------------------------------------------------------------------
  bool objectIsListOfSpecs(dynamic object){

    bool _objectsListIsSpecs = false;

    if (object != null){
      if (object.length > 0){
        if (object[0].runtimeType == Spec){
          _objectsListIsSpecs = true;
        }

      }
    }

    return _objectsListIsSpecs;
  }
// -----------------------------------------------------------------------------
