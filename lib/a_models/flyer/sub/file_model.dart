import 'dart:io';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

class FileModel {
  /// --------------------------------------------------------------------------
  const FileModel({
    @required this.url,
    @required this.fileName,
    @required this.size,
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
          url: null,
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
// -----------------------------------------------------------------------------

/// CIPHER

// --------------------------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return {
      'url' : url,
      'fileName' : fileName,
      'size' : size,
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

// ------------------------------------------
  static List<File> getFilesFromModels(List<FileModel> files){
    final List<File> _files = <File>[];

    if (Mapper.checkCanLoopList(files) == true){

      for (final FileModel model in files){
        _files.add(model.file);
      }

    }

    return _files;
  }
// ------------------------------------------
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
  bool checkSizeLimitReached(){

    bool _bigger = false;

    if (size != null){
      _bigger = size > Standards.maxFileSizeLimit;
    }

    return _bigger;
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
        if (Stringer.checkStringIsEmpty(_output.fileName) == true){
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
}