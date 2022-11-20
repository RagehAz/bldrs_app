import 'dart:typed_data';

import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PDFStorageOps {
  // -----------------------------------------------------------------------------

  const PDFStorageOps();

  // -----------------------------------------------------------------------------

  /// CREATE - UPDATE

  // --------------------
  /// TASK : TEST ME
  static Future<PDFModel> insert(PDFModel pdfModel) async {

    assert(pdfModel != null, 'picModel is null');
    assert(pdfModel.bytes != null, 'bytes is null');
    assert(pdfModel.path != null, 'path is null');
    assert(Mapper.checkCanLoopList(pdfModel.ownersIDs) == true, 'owners are Empty');

    final Reference _ref = await Storage.uploadBytes(
      bytes: pdfModel.bytes,
      path: pdfModel.path,
      metaData: pdfModel.createSettableMetadata(),
    );

    if (_ref == null){
      return null;
    }
    else {
      return pdfModel;
    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST ME
  static Future<PDFModel> read(String path) async {
    PDFModel _model;

    if (TextCheck.isEmpty(path) == false){

      /// GET BYTES
      final Uint8List _bytes = await Storage.readBytesByPath(
        path: path,
      );

      if (Mapper.checkCanLoopList(_bytes) == true){

        /// GET META
        final FullMetadata _meta = await Storage.readMetaByPath(
          path: path,
        );

        _model = PDFModel(
          path: path,
          bytes: _bytes,
          name: _meta?.customMetadata['name'],
          ownersIDs: Mapper.getKeysHavingThisValue(
            map: _meta?.customMetadata,
            value: 'cool',
          ),
          sizeMB: Numeric.transformStringToDouble(_meta.customMetadata['sizeMB']),

        );

      }

    }

    return _model;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST ME
  static Future<void> delete(String path) async {

    await Storage.deleteDoc(
      path: path,
    );

  }
  // -----------------------------------------------------------------------------
}