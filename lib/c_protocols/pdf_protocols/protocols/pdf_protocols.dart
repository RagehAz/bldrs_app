import 'package:bldrs/a_models/x_utilities/pdf_model.dart';

class PDFProtocols {
  // -----------------------------------------------------------------------------

  const PDFProtocols();

  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  ///
  static Future<PDFModel> fetch(String path) async {

    PDFModel _pdfModel = await PDFLDBOps.readPDF(path);

    if (_pdfModel == null){

      _pdfModel = await PDFStorageOps.readPDF(path);

      if (_pdfModel != null){
        await PDFLDBOps.insertPDF(path);
      }

    }

    return _pdfModel;
  }
  // -----------------------------------------------------------------------------
}
