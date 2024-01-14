import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/files/file_size_unit.dart';
import 'package:basics/helpers/files/filers.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/c_protocols/pdf_protocols/ldb/pdf_ldb_ops.dart';
import 'package:bldrs/c_protocols/pdf_protocols/storage/pdf_storage_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PDFProtocols {
  // -----------------------------------------------------------------------------

  const PDFProtocols();

  // -----------------------------------------------------------------------------

  /// PICK

  // --------------------
  /// TASK : TEST ME
  static Future<PDFModel?> pickPDF({
    required BuildContext context,
    required String? flyerID,
    required String? bzID,
  }) async {

    PDFModel? _output;

    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      // allowCompression: true,
      // allowMultiple: false,
      dialogTitle: getWord('phid_select_a_pdf'),
      // lockParentWindow: false,
      onFileLoading: (FilePickerStatus status){
        blog('status : ${status.name}');
      },
      /// ??
      allowedExtensions: <String>['pdf'],
      // initialDirectory:
      /// ??
      withData: true,
      // withReadStream:
    );

    if (result != null){

      final PlatformFile _platformFile = result.files.first;

      // blog('_platformFile name        : ${_platformFile.name}');
      // blog('_platformFile size        : ${_platformFile.size}');
      // blog('_platformFile path        : ${_platformFile.path}'); // this throws error in web
      // On web `path` is always `null`,
      // You should access `bytes` property instead,
      // blog('_platformFile bytes       : ${_platformFile.bytes?.length} bytes');
      // blog('_platformFile extension   : ${_platformFile.extension}');
      // blog('_platformFile identifier  : ${_platformFile.identifier}');
      // blog('_platformFile identifier  : ${_platformFile.identifier}');


      _output = PDFModel(
        bytes: _platformFile.bytes,
        path: StoragePath.flyers_flyerID_pdf(flyerID),
        name: TextMod.removeTextAfterLastSpecialCharacter(
            text: _platformFile.name,
            specialCharacter: '.',
        ),
        sizeMB: Filers.calculateSize(_platformFile.bytes?.length, FileSizeUnit.megaByte),
        ownersIDs: await FlyerModel.generateFlyerOwners(bzID: bzID),
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TASK : TEST ME
  static Future<void> compose(PDFModel? pdfModel) async {

    if (pdfModel != null){

      await Future.wait(<Future>[

        PDFStorageOps.insert(pdfModel),

        PDFLDBOps.insert(pdfModel),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TASK : TEST ME
  static Future<PDFModel?> fetch(String? path) async {

    PDFModel? _pdfModel = await PDFLDBOps.read(path);

    if (_pdfModel == null){

      _pdfModel = await PDFStorageOps.read(path);

      if (_pdfModel != null){
        await PDFLDBOps.insert(_pdfModel);
      }

    }

    return _pdfModel;
  }
  // -----------------------------------------------------------------------------

  /// DOWNLOAD

  // --------------------
  /// TASK : TEST ME
  static Future<void> download(String? path) async {

    if (TextCheck.isEmpty(path) == false){

      final bool _existsInLDB = await PDFLDBOps.checkExists(path!);

      if (_existsInLDB == false){

        blog('downloadPic : Downloading pic : $path');

        final PDFModel? _pdfModel = await PDFStorageOps.read(path);

        blog('downloadPic : Downloaded pic : $path');

        await PDFLDBOps.insert(_pdfModel);

        blog('downloadPic : inserted in LDB : $path');

      }
      else {
        blog('downloadPic : ---> already downloaded : $path');
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TASK : TEST ME
  static Future<void> renovate(PDFModel? pdfModel) async {

    if (pdfModel != null){

      await compose(pdfModel);

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TASK : TEST ME
  static Future<void> wipe(String? path) async {

    if (TextCheck.isEmpty(path) == false){

      await Future.wait(<Future>[

        PDFLDBOps.delete(path),

        PDFStorageOps.delete(path),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
