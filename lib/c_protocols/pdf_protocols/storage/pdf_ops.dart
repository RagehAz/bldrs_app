
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:flutter/material.dart';

class PDFStorageOps {

  const PDFStorageOps();

  // --------------------
  ///
  static Future<PDFModel> uploadFlyerPDFAndGetFlyerPDF({
    @required PDFModel pdf,
    @required String flyerID,
    @required List<String> ownersIDs,
    ValueChanged<PDFModel> onFinished,
  }) async {

    // PDFModel _pdf = pdf?.copyWith();
    //
    // if (pdf != null && pdf.bytes != null){
    //
    //   final bool _shouldUploadNewFile = pdf.bytes != null;
    //   final bool _shouldReUploadExistingURL = pdf.bytes == null && pdf.url != null;
    //
    //   final String _pdfStorageName = FileModel.generateFlyerPDFStorageName(
    //     pdfFileName: pdf.fileName,
    //     flyerID: flyerID,
    //   );
    //
    //   String _url;
    //   File _fileFromURL;
    //
    //   /// A NEW FILE WAS GIVEN
    //   if (_shouldUploadNewFile == true){
    //
    //     if (ObjectCheck.objectIsFile(pdf.bytes) == true){
    //
    //       _fileFromURL = pdf.bytes;
    //
    //       _url = await StorageFileOps.uploadFileAndGetURL(
    //         bytes: pdf.bytes,
    //         storageCollName: StorageColl.flyersPDFs,
    //         docName: _pdfStorageName,
    //         ownersIDs: ownersIDs,
    //         // metaDataAddOn: ,
    //       );
    //
    //     }
    //
    //   }
    //
    //   /// NO NEW FILE GIVEN - BUT NEED TO RE-UPLOAD EXISTING URL WITH NEW NAME
    //   else if (_shouldReUploadExistingURL == true){
    //
    //     _fileFromURL = await Filers.getFileFromURL(pdf.url);
    //     final FullMetadata _meta = await StorageMetaOps.getMetaByURL(
    //       url: pdf.url,
    //     );
    //
    //     _url = await StorageFileOps.uploadFileAndGetURL(
    //       bytes: _fileFromURL,
    //       storageCollName: StorageColl.flyersPDFs,
    //       docName: _pdfStorageName,
    //       ownersIDs: ownersIDs,
    //       metaDataAddOn: _meta.customMetadata,
    //     );
    //
    //   }
    //
    //   _pdf = FileModel(
    //     fileName: pdf.fileName,
    //     sizeMB: Filers.getFileSizeInMb(_fileFromURL),
    //     url: _url,
    //     // file: null,
    //   );
    //
    // }
    //
    // if (onFinished != null){
    //   onFinished(_pdf);
    // }
    //
    // return _pdf;

  }
  // -----------------------------------------------------------------------------
}
