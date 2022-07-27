import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Filers {
// -----------------------------------------------------------------

  Filers();

// -----------------------------------------------------------------

/// CREATORS - WRITING

// ---------------------------------------
  ///
  static Future<File> createNewEmptyFile({
    @required String fileName,
    bool useTemporaryDirectory = false,
  }) async {

    final String _filePath = await _createNewFilePath(
      fileName: fileName,
      useTemporaryDirectory: useTemporaryDirectory,
    );

    final File _file = File(_filePath);

    return _file;
  }
// ---------------------------------------
  static Future<File> writeUint8ListOnFile({
    @required File file,
    @required Uint8List uint8list,
  }) async {
    await file.writeAsBytes(uint8list);
    await file.create(recursive: true);
    return file;
  }
// ---------------------------------------
  static Future<File> writeBytesOnFile({
    @required File file,
    @required ByteData byteData,
  }) async {
    File _file;

    if (file != null && byteData != null) {
      final Uint8List _uInts = Floaters.getUint8ListFromByteData(byteData);
      _file = await writeUint8ListOnFile(file: file, uint8list: _uInts);
    }

    return _file;
  }
// ---------------------------------------
  /*
  static File createFileFromXFile(XFile xFile){
    return File(xFile.path);
  }
   */
// -----------------------------------------------------------------

  /// FILE PATH

// ---------------------------------------
  ///
  static Future<String> _createNewFilePath({
    @required String fileName,
    bool useTemporaryDirectory = false,
  }) async {

    final Directory _appDocDir = useTemporaryDirectory ?
    await getTemporaryDirectory()
        :
    await getApplicationDocumentsDirectory();

    final String _appDocPath = _appDocDir.path;
    final String _filePath = '$_appDocPath/$fileName';
    return _filePath;
  }
// ---------------------------------------
  ///
  static String getFileNameFromFile(File file){
    final String _path = file.path;
    final String _fileName = TextMod.removeTextBeforeLastSpecialCharacter(_path, '/');
    return _fileName;
  }
// -----------------------------------------------------------------

  /// GETTERS

// ---------------------------------------
  /// TAMAM
  static Future<File> getFileFromLocalRasterAsset({
    @required BuildContext context,
    @required String localAsset,
    int width = 100,
  }) async {

    File _file;
    final String _asset = ObjectChecker.objectIsSVG(localAsset) ? Iconz.bldrsAppIcon : localAsset;

    await tryAndCatch(
        context: context,
        methodName: 'getFileFromLocalRasterAsset',
        functions: () async {
          // blog('0. removing [assets/] from input image path');
          final String _pathTrimmed = TextMod.removeNumberOfCharactersFromBeginningOfAString(
            string: _asset,
            numberOfCharacters: 7,
          );
          // blog('1. starting getting image from assets');
          // final ByteData _byteData = await rootBundle.load('assets/$_pathTrimmed');
          // blog('2. we got byteData and creating the File aho');
          final String _fileName = TextMod.getFileNameFromAsset(_pathTrimmed);
          // final File _tempFile = await getEmptyFile(_fileNae);
          // blog('3. we created the FILE and will overwrite image data as bytes');
          // final File _finalFile = await writeBytesOnFile(file: _tempFile, byteData: _byteData);
          // _tempFile.delete(recursive: true);
          //
          // _file = _finalFile;
          //
          // blog('4. file is ${_file.path}');

          final Uint8List _uInt = await Floaters.getUint8ListFromLocalRasterAsset(
              asset: _asset,
              width: width,
          );

          _file = await getFileFromUint8List(
              uInt8List: _uInt,
              fileName: _fileName,
          );

        });

    return _file;
  }
// ---------------------------------------
  static Future<File> getFileFromUint8List({
    @required Uint8List uInt8List,
    @required String fileName,
  }) async {

    final File _file = await createNewEmptyFile(
      fileName: fileName,
    );

    final File _result = await writeUint8ListOnFile(
      uint8list: uInt8List,
      file: _file,
    );

    return _result;
  }
// ---------------------------------------
  static Future<File> getFileFromURL(String imageUrl) async {
    /// generate random number.
    final Random _rng = Random();

    /// get temporary directory of device.
    final Directory _tempDir = await getTemporaryDirectory();

    /// get temporary path from temporary directory.
    final String _tempPath = _tempDir.path;

    /// create a new file in temporary path with random file name.
    final File _file = File('$_tempPath${(_rng.nextInt(100)).toString()}.png');

    /// call http.get method and pass imageUrl into it to get response.
    final Uri _imageUri = Uri.parse(imageUrl);
    final http.Response _response = await http.get(_imageUri);

    /// write bodyBytes received in response to file.
    await _file.writeAsBytes(_response.bodyBytes);

    /// now return the file which is created with random name in
    /// temporary directory and image bytes from response is written to // that file.
    return _file;
  }
// ---------------------------------------
  static Future<File> getFileFromDynamic(dynamic pic) async {
    File _file;

    if (pic != null) {
      if (ObjectChecker.objectIsFile(pic) == true) {
        _file = pic;
      }
      // else if (ObjectChecker.objectIsAsset(pic) == true) {
      //   _file = await getFileFromPickerAsset(pic);
      // }
      else if (ObjectChecker.objectIsURL(pic) == true) {
        _file = await getFileFromURL(pic);
      }
      else if (ObjectChecker.objectIsJPGorPNG(pic) == true) {
        // _file = await getFile
      }
    }

    return _file;
  }
// ---------------------------------------
  static Future<File> getFilerFromBase64(String base64) async {

    final Uint8List _fileAgainAsInt = base64Decode(base64);
    // await null;

    final File _fileAgain = await getFileFromUint8List(
      uInt8List: _fileAgainAsInt,
      fileName: '${Numeric.createUniqueID()}',
    );

    return _fileAgain;
  }
// -----------------------------------------------------------------

}
