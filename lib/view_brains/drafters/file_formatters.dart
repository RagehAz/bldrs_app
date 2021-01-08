import 'package:bldrs/view_brains/drafters/stringers.dart';
import 'dart:io';
// ----------------------------------------------------------------------------
extension FileExtention on FileSystemEntity{
  String get fileNameWithExtension {
    return this?.path?.split("/")?.last;
  }
// ----------------------------------------------------------------------------
  String get fileExtension {
    return this?.path?.split(".")?.last;
  }
}
// ----------------------------------------------------------------------------
fileExtensionOf(dynamic file){
  return
    file == null ? null :
    valueIsString(file) == true ? File(file).fileExtension :
  null;
}
// ----------------------------------------------------------------------------
valueIsString(dynamic value){
  bool valueIsString = value.runtimeType == String ? true : false;
  return valueIsString;
}
// ----------------------------------------------------------------------------
fileIsURL(dynamic file){
  bool _validURL = valueIsString(file) == true ?
      Uri.parse(file).isAbsolute :
      false;
  return _validURL;
}
// ----------------------------------------------------------------------------
fileIsFileType(dynamic file){
  // print('runtTimeType is : $file');
  String fileAsString = (file.runtimeType).toString();
  // print('fileAsString is : $fileAsString');
  String stringWithoutFirstCharacter = removeFirstCharacterFromAString(fileAsString);
  // print('stringWithoutFirstCharacter is : $stringWithoutFirstCharacter');
  return stringWithoutFirstCharacter == 'File' ? true : false;
}
// ----------------------------------------------------------------------------
