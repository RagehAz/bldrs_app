import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:ldb/ldb.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';

class PDFLDBOps {
  // -----------------------------------------------------------------------------

  const PDFLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE - UPDATE

  // --------------------
  /// TASK : TEST ME
  static Future<void> insert(PDFModel pdfModel) async {

    if (pdfModel != null){

      await LDBOps.insertMap(
        docName: LDBDoc.pdfs,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pdfs),
        input: pdfModel.toMap(includeBytes: true),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TASK : TEST ME
  static Future<PDFModel> read(String path) async {
    PDFModel _picModel;

    if (TextCheck.isEmpty(path) == false){

      final List<Map<String, dynamic>> maps = await LDBOps.readMaps(
        docName: LDBDoc.pdfs,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pdfs),
        ids: [path],
      );

      if (Mapper.checkCanLoopList(maps) == true){

        _picModel = PDFModel.decipherFromMap(maps.first);

      }

    }

    return _picModel;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST ME
  static Future<void> delete(String path) async {

    if (TextCheck.isEmpty(path) == false){
      await LDBOps.deleteMap(
        docName: LDBDoc.pdfs,
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pdfs),
        objectID: path,
      );
    }

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
        primaryKey: LDBDoc.getPrimaryKey(LDBDoc.pdfs),
      );

    }

    return _exists;
  }
  // -----------------------------------------------------------------------------
}
