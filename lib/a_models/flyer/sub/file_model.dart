import 'dart:io';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

@immutable
class FileModel {
  /// --------------------------------------------------------------------------
  const FileModel({
    this.url,
    this.fileName,
    this.size,
    this.file,
  });
  /// --------------------------------------------------------------------------
  final String url;
  final String fileName;
  final File file;
  final double size;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------------------------
  /// TESTED : WORKS PERFECT
  FileModel copyWith({
    String url,
    String fileName,
    double size,
    File file,
  }){
    return FileModel(
      url: url ?? this.url,
      fileName: fileName ?? this.fileName,
      file: file ?? this.file,
      size: size ?? this.size,
    );
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static FileModel createModelByNewFile(File file){
    FileModel _model;

    if (file != null){
      _model = FileModel(
        // url: null,
        file: file,
        size: Filers.getFileSize(file),
        fileName: Filers.getFileNameFromFile(
          file: file,
          withExtension: true,
        ),
      );
    }

    return _model;
  }
  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static List<FileModel> createModelsByNewFiles(List<File> files){
    final List<FileModel> _models = <FileModel>[];

    if (Mapper.checkCanLoopList(files) == true){

      for (final File file in files){

        final FileModel _model = createModelByNewFile(file);
        _models.add(_model);

      }

    }

    return _models;
  }
  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FileModel> createModelByUrl({
    @required String url,
    @required String fileName,
  }) async {
    FileModel _model;

    if (url != null){

      final File _file = await Filers.getFileFromURL(url);

      _model = FileModel(
        url: url,
        file: _file,
        size: Filers.getFileSize(_file),
        fileName: fileName ?? Filers.getFileNameFromFile(
          file: _file,
          withExtension: true,
        ),
      );

    }

    return _model;
  }
  // --------------------------------------
  static FileModel initializePicForEditing({
    @required dynamic pic,
    @required String fileName,
  }){

    FileModel _fileModel;

    if (pic != null){

      if (pic is FileModel){
        _fileModel = pic;
      }
      else if (ObjectCheck.isAbsoluteURL(pic) == true){
        _fileModel = FileModel(url: pic, fileName: fileName,);
      }
      else if (ObjectCheck.objectIsFile(pic) == true){
        _fileModel = FileModel(file: pic, fileName: fileName,);
      }

    }

    return _fileModel;
  }
  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FileModel> preparePicForEditing({
    @required dynamic pic,
    @required String fileName,
  }) async {

    FileModel _fileModel;

    // blog('initializePicForEditing : pic : $pic : pic.runtimeType : ${pic.runtimeType}');

    if (ObjectCheck.isAbsoluteURL(pic) == true){
      _fileModel = await createModelByUrl(
        url: pic,
        fileName: fileName,
      );
    }
    else if (ObjectCheck.objectIsFile(pic) == true){
      _fileModel = createModelByNewFile(pic);
    }
    else if (pic is FileModel){
      _fileModel = pic;
    }
    else if (pic is String){
      final String path = pic;
      final File _file = File(path);
      _fileModel = createModelByNewFile(_file);
    }

    return completeModel(_fileModel);

  }
  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static dynamic bakeFileForUpload({
    @required dynamic newFile,
    @required dynamic existingPic,
  }){

    dynamic _pic;

    if (newFile is FileModel){
      final FileModel _fileModel = newFile;
      _pic = _fileModel.file ?? _fileModel.url;
    }
    else {
      _pic = existingPic;
    }

    return _pic;
  }
  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static String bakeFileForLDB(dynamic pic){
    String _pic;

    if (ObjectCheck.isAbsoluteURL(pic) == true){
      _pic = pic;
    }
    else if (ObjectCheck.objectIsFile(pic) == true){
      final File _file = pic;
      _pic = _file.path;
    }
    else if (pic is FileModel){
      final FileModel _fileModel = pic;
      _pic = _fileModel?.file?.path ?? _fileModel?.url;
    }

    return _pic;
  }
  // -----------------------------------------------------------------------------

  /// CIPHER

  // --------------------------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'url' : url,
      'fileName' : fileName,
      'size' : size,
      'file' : file?.path,
    };
  }
  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static FileModel decipher(Map<String, dynamic> map){
    FileModel _flyerPDF;

    if (map != null){
      _flyerPDF = FileModel(
        url: map['url'],
        fileName: map['fileName'],
        size: map['size'],
        file: map['file'] == null ? null : File(map['file']),
      );
    }

    return _flyerPDF;
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogFlyerPDF(FileModel pdf){
    blog('blogFlyerPDF | fileName ${pdf?.fileName}\n| file ${pdf?.file}\n| url :${pdf?.url}');
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static List<File> getFilesFromModels(List<FileModel> files){
    final List<File> _files = <File>[];

    if (Mapper.checkCanLoopList(files) == true){

      for (final FileModel model in files){
        _files.add(model.file);
      }

    }

    return _files;
  }
  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getNamesFromModels(List<FileModel> files){
    final List<String> _names = <String>[];

    if (Mapper.checkCanLoopList(files) == true){

      for (final FileModel model in files){
        _names.add(model.fileName);
      }

    }

    return _names;
  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkFileModelsAreIdentical({
    @required FileModel model1,
    @required FileModel model2,
  }){
    bool _areIdentical = false;

    if (model1 == null && model2 == null){
      _areIdentical = true;
    }
    else if (model1 != null && model2 != null){

      if (
      model1.fileName == model2.fileName &&
          model1.url == model2.url &&
          model1.size == model2.size &&
          Filers.checkFilesAreIdentical(file1: model1.file, file2: model2.file) == true
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkShouldDeleteOldFlyerPDFFileModel({
    @required FlyerModel oldFlyer,
    @required FlyerModel newFlyer,
  }){
    bool _shouldDelete = false;

    if (oldFlyer != null && newFlyer != null){
      // -----------------------------
      final bool _oldPDFExists = oldFlyer.pdf != null;
      final bool _newPDFExists = newFlyer.pdf != null;
      // final bool _filesAreIdentical = Filers.checkFilesAreIdentical(
      //     file1: newFlyer.pdf?.file,
      //     file2: oldFlyer.pdf?.file
      // );
      final bool _namesAreIdentical = newFlyer.pdf?.fileName == oldFlyer.pdf?.fileName;
      // -----------------------------

      /// OLD PDF EXISTS
      if (_oldPDFExists == true){

        /// GOT NEW PDF FILE
        if (_newPDFExists == true){

          /// NAME HAS CHANGED
          if (_namesAreIdentical == false){

            /// FILE HAS CHANGED
            // if (_filesAreIdentical == false){
            //   /// as need to re-upload the file with the new name and delete old file with old name
            _shouldDelete = true;
            // }
            /// FILE WAS NOT CHANGED
            // else {
            //   /// as need to re-upload the new name file
            //   _shouldDelete = true;
            // }

          }

          /// NAME WAS NOT CHANGED
          else {

            /// new file will override that file with same name
            _shouldDelete = false;

          }


        }

        /// NO NEW PDF GIVE
        else {
          _shouldDelete = true;
        }

        if (_namesAreIdentical == false){

          _shouldDelete = true;

        }

      }

      /// OLD PDF DOES NOT EXIST
      else {

        /// no old file to delete ya zaki
        _shouldDelete = false;

      }

    }

    return _shouldDelete;
  }
  // --------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkShouldUploadNewPDFFileModel({
    @required FlyerModel oldFlyer,
    @required FlyerModel newFlyer,
  }){
    bool _shouldUpload = false;

    if (newFlyer != null){
      // -----------------------------
      final bool _newPDFExists = newFlyer?.pdf != null;
      // final bool _oldPDFExists = oldFlyer?.pdf != null;
      final bool _filesAreIdentical = Filers.checkFilesAreIdentical(
          file1: newFlyer.pdf?.file,
          file2: oldFlyer.pdf?.file
      );
      final bool _namesAreIdentical = newFlyer.pdf?.fileName == oldFlyer?.pdf?.fileName;
      // -----------------------------

      /// GIVEN NEW PDF
      if (_newPDFExists == true){

        /// DONT UPLOAD NO CHANGES IN PDFS
        if (_filesAreIdentical == true && _namesAreIdentical == true){
          _shouldUpload = false;
        }

        /// OTHERWISE
        else {
          _shouldUpload = true;
        }

      }

      /// NO NEW PDF GIVEN
      else {
        /// NOTHING TO UPLOAD
        _shouldUpload = false;
      }
    }

    return _shouldUpload;
  }
  // --------------------------------------
  /// TESTED : WORKS PERFECT
  bool checkSizeLimitReached(){

    bool _bigger = false;

    if (size != null){
      _bigger = size > Standards.maxFileSizeLimit;
    }

    return _bigger;
  }
  // --------------------------------------
  static bool checkModelIsEmpty(FileModel model){
    bool _isEmpty = true;

    if (model != null){

      _isEmpty = TextCheck.isEmpty(model.url);

      if (_isEmpty == true){
        _isEmpty = model.file == null;
      }

    }

    return _isEmpty;
  }
  // -----------------------------------------------------------------------------

  /// PDF STORAGE NAME

  // ------------------------------------------
  /// TESTED : WORKS PERFECT
  static String generateFlyerPDFStorageName({
    @required String pdfFileName,
    @required String flyerID,
  }){
    assert(pdfFileName != null && flyerID != null, 'generatePDFName : ypu should name inputs here');

    return '${flyerID}_$pdfFileName';
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // ------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FileModel> completeModel(FileModel model) async {
    FileModel _output;

    if (model != null){

      _output = model;

      /// ONLY WHEN URL EXITS
      if (_output.url != null){

        /// MISSING FILE
        if (_output.file == null){
          blog('this bitch ass link is : ${_output.url}');
          _output = _output.copyWith(
            file: await Filers.getFileFromURL(_output.url),
          );
        }

      }

      /// ONLY IF FILE EXISTS
      if (_output.file != null){

        /// MISSING SIZE
        if (_output.size == null){
          _output = _output.copyWith(
            size: Filers.getFileSize(_output.file),
          );
        }

        /// MISSING NAME
        if (TextCheck.isEmpty(_output.fileName) == true){
          _output = _output.copyWith(
            fileName: Filers.getFileNameFromFile(
              file: _output.file,
              withExtension: true,
            ),
          );
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // ------------------------------------------
  /// TESTED : WORKS PERFECT
  void blogFileModel(){
    blog('blogFileModel : fileName : $fileName : size : $size : urlExists : ${url != null} : fileExists : ${file != null}');
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // ----------------------------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // ----------------------------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is FileModel){
      _areIdentical = checkFileModelsAreIdentical(
        model1: this,
        model2: other,
      );
    }

    return _areIdentical;
  }
  // ----------------------------------------
  @override
  int get hashCode =>
      url.hashCode^
      fileName.hashCode^
      size.hashCode^
      file.hashCode;
  // -----------------------------------------------------------------------------

}
