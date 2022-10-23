import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:bldrs/a_models/x_utilities/error_helpers.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/e_back_end/a_rest/rest.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart';

class Filers {
  // -----------------------------------------------------------------------------

  const Filers();

  // -----------------------------------------------------------------------------

  /// CREATORS - WRITING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File> createNewEmptyFile({
    @required String fileName,
    /// APP DIRECTORY
    /// /data/user/0/com.bldrs.net/app_flutter/{fileName}
    /// TEMPORARY DIRECTORY
    /// /data/user/0/com.bldrs.net/cache/{fileName}
    bool useTemporaryDirectory = true,
  }) async {

    final String _filePath = await _createNewFilePath(
      fileName: fileName,
      useTemporaryDirectory: useTemporaryDirectory,
    );

    return File(_filePath);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File> writeUint8ListOnFile({
    @required File file,
    @required Uint8List uint8list,
  }) async {
    await file.writeAsBytes(uint8list);
    await file.create(recursive: true);
    return file;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
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
  // --------------------
  /*
  static File createFileFromXFile(XFile xFile){
    return File(xFile.path);
  }
   */
  // -----------------------------------------------------------------------------

  /// FILE PATH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> _createNewFilePath({
    @required String fileName,
    bool useTemporaryDirectory = true,
  }) async {

    final Directory _appDocDir = useTemporaryDirectory ?
    await getTemporaryDirectory()
        :
    await getApplicationDocumentsDirectory();


    return '${_appDocDir.path}/$fileName';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getFileNameFromFile({
    @required File file,
    @required bool withExtension,
  }){
    String _fileName;

    if (file != null){
      final String _path = file.path;
      _fileName = TextMod.removeTextBeforeLastSpecialCharacter(_path, '/');


      if (withExtension == false){
        _fileName = TextMod.removeTextAfterLastSpecialCharacter(_fileName, '.');
      }

    }

    return _fileName;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<String>> getFilesNamesFromFiles({
    @required List<File> files,
    @required bool withExtension,
  }) async {

    final List<String> _names = <String>[];

    if (Mapper.checkCanLoopList(files) == true){

      for (final File _file in files){

        final String _name = getFileNameFromFile(
          file: _file,
          withExtension: withExtension,
        );

        _names.add(_name);

      }

    }

    return _names;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getFileExtensionFromFile(File file){

    ///  NOTE 'jpg' - 'png' - 'pdf' ... etc => which does not include the '.'
    String _fileExtension;

    if (file != null){

      /// '.jpg' - '.png' '.pdf'
      final String _dotExtension = extension(file.path);

      /// 'jpg' - 'png' 'pdf'
      _fileExtension = TextMod.removeTextBeforeLastSpecialCharacter(_dotExtension, '.');

    }

    return _fileExtension;
  }
  // -----------------------------------------------------------------------------

  /// SIZE

  // --------------------
  /// TESTED : WORKS PERFECT
  static double getFileSizeInMb(File file){

    return getFileSizeWithUnit(
      file: file,
      unit: FileSizeUnit.megaByte,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getFileSizeWithUnit({
    @required File file,
    @required FileSizeUnit unit,
    int fractionDigits = 1,
  }){
      double _output;

      if (file != null){

        final int _bytes = file.lengthSync();

        _output = _bytes.toDouble();

        switch (unit){
          case FileSizeUnit.byte:       _output = _bytes.toDouble(); break;
          case FileSizeUnit.kiloByte:   _output = _bytes / 1024; break;
          case FileSizeUnit.megaByte:   _output = _bytes/ (1024 * 1024); break;
          case FileSizeUnit.gigaByte:   _output = _bytes/ (1024 * 1024 * 1024); break;
          case FileSizeUnit.teraByte:   _output = _bytes/ (1024 * 1024 * 1024 * 1024); break;
          default:                      _output = _bytes.toDouble(); break;
        }

        _output = Numeric.roundFractions(_output, fractionDigits);

      }

      return _output;
    }
  // -----------------------------------------------------------------------------

  /// TRANSFORMERS

  // --------------------
  /// LOCAL RASTER ASSET
// ---------------------
  /// TAMAM : WORKS PERFECT
  static Future<File> getFileFromLocalRasterAsset({
    @required String localAsset,
    int width = 100,
  }) async {

    File _file;

    await tryAndCatch(
        methodName: 'getFileFromLocalRasterAsset',
        functions: () async {

          Uint8List _uInt;

          /// IF SVG
          if (ObjectCheck.objectIsSVG(localAsset) == true){
            _uInt = await Floaters.getUint8ListFromLocalSVGAsset(localAsset);
          }

          /// ANYTHING ELSE
          else {
            _uInt = await Floaters.getUint8ListFromLocalRasterAsset(
              asset: localAsset,
              width: width,
            );
          }

          /// ASSIGN UINT TO FILE
          if (Mapper.checkCanLoopList(_uInt) == true){
            _file = await getFileFromUint8List(
              uInt8List: _uInt,
              fileName: Floaters.getLocalAssetName(localAsset),
            );
          }

        });

    return _file;
  }
  // --------------------
  /// Uint8List
// ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File> getFileFromUint8List({
    @required Uint8List uInt8List,
    @required String fileName,
  }) async {

    if (uInt8List != null){
      final File _file = await createNewEmptyFile(
        fileName: fileName,
      );

      final File _result = await writeUint8ListOnFile(
        uint8list: uInt8List,
        file: _file,
      );

      return _result;

    }

    else {
      return null;
    }


  }
// ---------------------
  /// TESTED : WORKS PERFECT
  static Future<List<File>> getFilesFromUint8Lists({
    @required List<Uint8List> uInt8Lists,
    @required List<String> filesNames,
  }) async {
    final List<File> _output = <File>[];

    if (Mapper.checkCanLoopList(uInt8Lists) == true){

      for (int i = 0; i < uInt8Lists.length; i++){

        final File _file = await getFileFromUint8List(
          uInt8List: uInt8Lists[i],
          fileName: filesNames[i],
        );

        if (_file != null){
          _output.add(_file);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// ImgImage
// ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File> getFileFromImgImage({
    @required img.Image imgImage,
    @required String fileName,
  }) async {

    File file;

    if (imgImage != null){

      final Uint8List _uIntAgain = Floaters.getUint8ListFromImgImage(imgImage);

      file = await Filers.getFileFromUint8List(
        uInt8List: _uIntAgain,
        fileName: fileName,
      );

    }

    return file;
  }
  // --------------------
  /// URL
// ---------------------
  /// TESTED : WORKS PERFECT
  static Future<File> getFileFromURL(String url) async {
    File _file;

    if (ObjectCheck.isAbsoluteURL(url) == true){
      // blog('getFileFromURL : START');

      /// call http.get method and pass imageUrl into it to get response.
      final http.Response _response = await Rest.get(
        context: null,
        rawLink: url,
        showErrorDialog: true,
        // timeout: 60,
        invoker: 'getFileFromURL',
      );
      // blog('getFileFromURL : _response : $_response');

      if (_response != null){

        /// generate random number.
        final Random _rng = Random();
        // blog('getFileFromURL : _rng : $_rng');

        /// get temporary directory of device.
        final Directory _tempDir = await getTemporaryDirectory();
        // blog('getFileFromURL : _tempDir : $_tempDir');

        /// get temporary path from temporary directory.
        final String _tempPath = _tempDir.path;
        // blog('getFileFromURL : _tempPath : $_tempPath');

        /// create a new file in temporary path with random file name.
        _file = File('$_tempPath${(_rng.nextInt(100)).toString()}'); // .png');
        // blog('getFileFromURL : _file : $_file');


        /// write bodyBytes received in response to file.
        await _file.writeAsBytes(_response.bodyBytes);
        // blog('getFileFromURL : BYTES WRITTEN ON FILE --------- END');

        /// now return the file which is created with random name in
        /// temporary directory and image bytes from response is written to // that file.

      }


    }

    return _file;
  }
  // --------------------
  /// BASE 64
// ---------------------
  static Future<File> getFileFromBase64(String base64) async {

    final Uint8List _fileAgainAsInt = base64Decode(base64);
    // await null;

    final File _fileAgain = await getFileFromUint8List(
      uInt8List: _fileAgainAsInt,
      fileName: '${Numeric.createUniqueID()}',
    );

    return _fileAgain;
  }
  // --------------------
  /// DYNAMICS
// ---------------------
  static Future<File> getFileFromDynamics(dynamic pic) async {
    File _file;

    if (pic != null) {
      if (ObjectCheck.objectIsFile(pic) == true) {
        _file = pic;
      }
      // else if (ObjectChecker.objectIsAsset(pic) == true) {
      //   _file = await getFileFromPickerAsset(pic);
      // }
      else if (ObjectCheck.isAbsoluteURL(pic) == true) {
        _file = await getFileFromURL(pic);
      }
      else if (ObjectCheck.objectIsJPGorPNG(pic) == true) {
        // _file = await getFile
      }
    }

    return _file;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFilesAreIdentical({
    @required File file1,
    @required File file2,
    String methodName = 'checkFilesAreIdentical',
  }) {
    bool _identical = false;

    if (file1 == null && file2 == null){
      _identical = true;
    }
    else if (file1 != null && file2 != null){
      if (file1.path == file2.path){
        if (file1.lengthSync() == file2.lengthSync()){
          if (file1.resolveSymbolicLinksSync() == file2.resolveSymbolicLinksSync()){

            final bool _lastModifiedAreIdentical = Timers.checkTimesAreIdentical(
                accuracy: TimeAccuracy.microSecond,
                time1: file1.lastModifiedSync(),
                time2: file2.lastModifiedSync()
            );

            if (_lastModifiedAreIdentical == true){
              _identical = true;
            }

          }
        }
      }
    }

    if (_identical == false){
      blogFilesDifferences(
        file1: file1,
        file2: file2,
      );
    }

    return _identical;
  }
  // --------------------
/*
  static bool checkFileSizeIsBiggerThan({
    @required File file,
    @required double megaBytes,
  }){
    bool _bigger = false;

    if (file != null && megaBytes != null){

      final double fileSize = getFileSize(file);

        _bigger = fileSize > megaBytes;

    }

    return _bigger;
  }
 */
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFile({
    @required File file,
    String methodName = 'BLOG FILE',
  }){

    if (file == null){
      blog('blogFile : file is null');
    }
    else {

      blog('blogFile : $methodName : file.path : ${file.path}');
      blog('blogFile : $methodName : file.absolute : ${file.absolute}');
      blog('blogFile : $methodName : file.fileNameWithExtension : ${file.fileNameWithExtension}');
      blog('blogFile : $methodName : file.runtimeType : ${file.runtimeType}');
      blog('blogFile : $methodName : file.isAbsolute : ${file.isAbsolute}');
      blog('blogFile : $methodName : file.parent : ${file.parent}');
      // blog('blogFile : $methodName : file.resolveSymbolicLinksSync() : ${file.resolveSymbolicLinksSync()}');
      blog('blogFile : $methodName : file.lengthSync() : ${file.lengthSync()}');
      blog('blogFile : $methodName : file.toString() : ${file.toString()}');
      blog('blogFile : $methodName : file.lastAccessedSync() : ${file.lastAccessedSync()}');
      blog('blogFile : $methodName : file.lastModifiedSync() : ${file.lastModifiedSync()}');
      // blog('blogFile : $methodName : file.openSync() : ${file.openSync()}');
      // blog('blogFile : $methodName : file.openWrite() : ${file.openWrite()}');
      // blog('blogFile : $methodName : file.statSync() : ${file.statSync()}');
      blog('blogFile : $methodName : file.existsSync() : ${file.existsSync()}');
      // DynamicLinks.blogURI(
      //   uri: file.uri,
      //   methodName: methodName,
      // );
      blog('blogFile : $methodName : file.hashCode : ${file.hashCode}');

      // blog('blogFile : $methodName : file.readAsLinesSync() : ${file.readAsLinesSync()}'); /// Unhandled Exception: FileSystemException: Failed to decode data using encoding 'utf-8',
      // blog('blogFile : $methodName : file.readAsStringSync() : ${file.readAsStringSync()}'); /// ERROR WITH IMAGE FILES
      // blog('blogFile : $methodName : file.readAsBytesSync() : ${file.readAsBytesSync()}'); /// TOO LONG

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogFilesDifferences({
    @required File file1,
    @required File file2,
  }){

    if (file1 == null){
      blog('file1 is null');
    }
    if (file2 == null){
      blog('file2 is null');
    }
    if (file1 != null && file2 != null){

      if (file1.path != file2.path){
        blog('files paths are not Identical');
      }
      if (file1.lengthSync() != file2.lengthSync()){
        blog('files lengthSync()s are not Identical');
      }
      if (file1.resolveSymbolicLinksSync() != file2.resolveSymbolicLinksSync()){
        blog('files resolveSymbolicLinksSync()s are not Identical');
      }
      final bool _lastModifiedAreIdentical = Timers.checkTimesAreIdentical(
          accuracy: TimeAccuracy.microSecond,
          time1: file1.lastModifiedSync(),
          time2: file2.lastModifiedSync()
      );
      if (_lastModifiedAreIdentical == true){
        blog('files lastModifiedSync()s are not Identical');
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// IMAGE FILE RESIZE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File> resizeImage({
    @required File file,
    /// image width will be resized to this final width
    @required double finalWidth,
  }) async {

    blog('resizeImage : START');

    File _output = file;

    if (file != null){

      img.Image _imgImage = await Floaters.getImgImageFromFile(file);

      /// only resize if final width is smaller than original
      if (finalWidth < _imgImage.width){

        final double _aspectRatio = await Dimensions.getFileAspectRatio(file);

        _imgImage = Floaters.resizeImgImage(
          imgImage: _imgImage,
          width: finalWidth.floor(),
          height: Dimensions.getHeightByAspectRatio(
              aspectRatio: _aspectRatio,
              width: finalWidth
          ).floor(),
        );

        final File _refile = await Filers.getFileFromImgImage(
          imgImage: _imgImage,
          fileName: Filers.getFileNameFromFile(
            file: file,
            withExtension: true,
          ),
        );

        _output = _refile;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<File>> resizeImages({
    @required List<File> files,
    @required double finalWidth,
  }) async {
    final List<File> _files = <File>[];

    if (Mapper.checkCanLoopList(files) == true){

      await Future.wait(<Future>[

        ...List.generate(files.length, (index) async {

          final File _file = await resizeImage(
            file: files[index],
            finalWidth: finalWidth ?? 500,
          );

          if (_file != null){
            _files.add(_file);
          }

        }),

      ]);

    }

    return _files;

  }
  // -----------------------------------------------------------------------------

  /// PICK PDF

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<File> pickPDF() async {

    File _file;

    final FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowCompression: true,
      allowMultiple: false,
      dialogTitle: 'Pick PDF File',
      lockParentWindow: false,
      onFileLoading: (FilePickerStatus status){
        blog('status : ${status.name}');
      },
      /// ??
      allowedExtensions: <String>['pdf'],
      // initialDirectory:
      /// ??
      // withData:
      // withReadStream:
    );

    if (result != null){
      final PlatformFile _platformFile = result.files.first;
      _file = File(_platformFile.path);
    }

    return _file;
  }
  // -----------------------------------------------------------------------------
}

enum FileSizeUnit {
  byte,
  kiloByte,
  megaByte,
  gigaByte,
  teraByte,
}
