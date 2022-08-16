import 'dart:io';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class FlyerPDF {
  /// --------------------------------------------------------------------------
  const FlyerPDF({
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
  FlyerPDF copyWith({
    String url,
    String fileName,
    double size,
    File file,
  }){
    return FlyerPDF(
      url: url ?? this.url,
      fileName: fileName ?? this.fileName,
      file: file ?? this.file,
      size: size ?? this.size,
    );
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
  static FlyerPDF decipher(Map<String, dynamic> map){
    FlyerPDF _flyerPDF;

    if (map != null){
      _flyerPDF = FlyerPDF(
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
  static void blogFlyerPDF(FlyerPDF pdf){
    blog('blogFlyerPDF | fileName ${pdf?.fileName}\n| file ${pdf?.file}\n| url :${pdf?.url}');
  }
// -----------------------------------------------------------------------------

/// CHECKER

// --------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkFlyerPDFsAreIdentical({
    @required FlyerPDF pdf1,
    @required FlyerPDF pdf2,
  }){
    bool _areIdentical = false;

    if (pdf1 == null && pdf2 == null){
      _areIdentical = true;
    }
    else if (pdf1 != null && pdf2 != null){

      if (
          pdf1.fileName == pdf2.fileName &&
          pdf1.url == pdf2.url &&
          pdf1.size == pdf2.size &&
          Filers.checkFilesAreIdentical(file1: pdf1.file, file2: pdf2.file) == true
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
// --------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkShouldDeleteOldPDFFile({
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
  static bool checkShouldUploadNewPDFFile({
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
// -----------------------------------------------------------------------------

  /// PDF STORAGE NAME

// ------------------------------------------
  /// TESTED : WORKS PERFECT
  static String generatePDFStorageName({
    @required String pdfFileName,
    @required String flyerID,
  }){
    assert(pdfFileName != null && flyerID != null, 'generatePDFName : ypu should name inputs here');

    return '${flyerID}_$pdfFileName';
  }
// -----------------------------------------------------------------------------

  /// MODIFIERS

// ------------------------------------------
  static Future<FlyerPDF> completeModel(FlyerPDF model) async {
    FlyerPDF _output;

    if (model != null){

      _output = model;

      /// ONLY WHEN URL EXITS
      if (_output.url != null){

        /// MISSING FILE
        if (_output.file == null){
          _output = _output.copyWith(
            file: await Filers.transformURLToFile(_output.url),
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
            fileName: Filers.getFileNameFromFile(file: _output.file),
          );
        }

      }

    }

    return _output;
  }
}
