import 'dart:typed_data';

import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:fire/super_fire.dart';

class PDFStorageOps {
  // -----------------------------------------------------------------------------

  const PDFStorageOps();

  // -----------------------------------------------------------------------------

  /// CREATE - UPDATE

  // --------------------
  /// TASK : TEST ME
  static Future<PDFModel?> insert(PDFModel? pdfModel) async {

    assert(pdfModel != null, 'picModel is null');
    assert(pdfModel?.bytes != null, 'bytes is null');
    assert(pdfModel?.path != null, 'path is null');
    assert(Lister.checkCanLoopList(pdfModel?.ownersIDs) == true, 'owners are Empty');

    if (pdfModel != null && pdfModel.bytes != null && pdfModel.path != null) {

      final String? _url = await Storage.uploadBytesAndGetURL(
        bytes: pdfModel.bytes,
        path: pdfModel.path!,
        storageMetaModel: pdfModel.createStorageMetaModel()!,
      );

      if (_url == null) {
        return null;
      }

      else {
        return pdfModel;
      }

    }

    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST ME
  static Future<PDFModel?> read(String? path) async {
    PDFModel? _model;

    if (TextCheck.isEmpty(path) == false){

      /// GET BYTES
      final Uint8List? _bytes = await Storage.readBytesByPath(
        path: path!,
      );

      if (Lister.checkCanLoopList(_bytes) == true){

        /// GET META
        final StorageMetaModel? _meta = await Storage.readMetaByPath(
          path: path,
        );

        _model = PDFModel(
          path: path,
          bytes: _bytes,
          name: _meta?.name,
          ownersIDs: _meta?.ownersIDs,
          sizeMB: _meta?.sizeMB,
        );

      }

    }

    return _model;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST ME
  static Future<void> delete(String? path) async {

    if (Authing.getUserID() != null && path != null) {
      await Storage.deleteDoc(
        path: path,
        currentUserID: Authing.getUserID()!,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
