
// --- FILE EXTENSIONS
import 'dart:io';

extension FileExtention on FileSystemEntity{
  String get fileNameWithExtension {
    return this?.path?.split("/")?.last;
  }

  String get fileExtension {
    return this?.path?.split(".")?.last;
  }

}

fileExtensionOf(String file){
  return File(file).fileExtension;
}

valueIsString(dynamic value){
  bool valueIsString = value.runtimeType == String ? true : false;
  return valueIsString;
}

fileIsURL(dynamic file){
  bool _validURL = valueIsString(file) == true ?
      Uri.parse(file).isAbsolute :
      false;
  return _validURL;
}