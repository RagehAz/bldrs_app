import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'dart:io';

import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
extension FileExtention on FileSystemEntity{
  String get fileNameWithExtension {
    return this?.path?.split("/")?.last;
  }
// ----------------------------------------------------------------------------
  String get fileExtension {
    return this?.path?.split(".")?.last;
  }
}
// === === === === === === === === === === === === === === === === === === ===
fileExtensionOf(dynamic file){
  return
    file == null ? null :
    objectIsString(file) == true ? File(file).fileExtension :
  null;
}
// === === === === === === === === === === === === === === === === === === ===
objectIsString(dynamic value){
  bool valueIsString = value.runtimeType == String ? true : false;
  return valueIsString;
}
// === === === === === === === === === === === === === === === === === === ===
objectIsURL(dynamic file){
  bool _validURL = objectIsString(file) == true ?
      Uri.parse(file).isAbsolute :
      false;
  return _validURL;
}
// === === === === === === === === === === === === === === === === === === ===
objectIsFile(dynamic file){
  // print('runtTimeType is : $file');
  String fileAsString = (file.runtimeType).toString();
  // print('fileAsString is : $fileAsString');
  String stringWithoutFirstCharacter = removeFirstCharacterFromAString(fileAsString);
  // print('stringWithoutFirstCharacter is : $stringWithoutFirstCharacter');
  return stringWithoutFirstCharacter == 'File' ? true : false;
}
// === === === === === === === === === === === === === === === === === === ===
objectIsSVG(dynamic object){
  return
  fileExtensionOf(object) == 'svg' ? true : false;
}
// === === === === === === === === === === === === === === === === === === ===
objectIsJPGorPNG(dynamic object){
  return
    fileExtensionOf(object) == 'jpeg' || fileExtensionOf(object) == 'jpg' || fileExtensionOf(object) == 'png' ?
        true : false;
}
// === === === === === === === === === === === === === === === === === === ===
objectIsColor(dynamic object){
  bool objectIsColor = object.runtimeType == Color ? true : false;
  return objectIsColor;
}
// === === === === === === === === === === === === === === === === === === ===
