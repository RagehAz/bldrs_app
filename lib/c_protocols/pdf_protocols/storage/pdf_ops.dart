import 'dart:typed_data';

import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/c_protocols/pic_protocols/storage/pic_storage_ops.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage_byte_ops.dart';
import 'package:bldrs/e_back_end/g_storage/storage_ref.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class PDFStorageOps {
  // -----------------------------------------------------------------------------

  const PDFStorageOps();

  // -----------------------------------------------------------------------------

  /// CREATE - UPDATE

  // --------------------
  ///
  static Future<PDFModel> insert(PDFModel pdfModel) async {

    assert(pdfModel != null, 'picModel is null');
    assert(pdfModel.bytes != null, 'bytes is null');
    assert(pdfModel.path != null, 'path is null');
    assert(Mapper.checkCanLoopList(pdfModel.ownersIDs) == true, 'owners are Empty');

    final Reference _ref = await StorageByteOps.uploadBytes(
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
  ///
  static Future<PDFModel> read(String path) async {
    PDFModel _model;

    if (TextCheck.isEmpty(path) == false){

      final Reference _ref = StorageRef.byPath(path);
      Uint8List _bytes;
      FullMetadata _meta;

      try {

        blog('getting meta data for path : $path');

        _meta = await _ref.getMetadata();

        if (_meta != null){

          /// 10'485'760 default max size
          _bytes = await _ref.getData();

        }


      }

      on firebase_core.FirebaseException catch (error){

        blog('the storage error : $error');

      }


      if (Mapper.checkCanLoopList(_bytes) == true){

        _model = PDFModel(
          path: path,
          bytes: _bytes,
          name: _meta.customMetadata['name'],
          ownersIDs: Mapper.getKeysHavingThisValue(
            map: _meta.customMetadata,
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
  ///
  static Future<void> delete(String path) async {

    await PicStorageOps.deletePic(path);

  }
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> checkExists(String path) async {

    bool _exists = false;

    if (TextCheck.isEmpty(path) == false){

      _exists = await LDBOps.checkMapExists(
        id: path,
        docName: LDBDoc.pdfs,
      );

    }

    return _exists;
  }
  // -----------------------------------------------------------------------------
}
