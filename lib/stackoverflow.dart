// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/services.dart';
// import 'package:wechat_camera_picker/wechat_camera_picker.dart';

/// --------------------------------------------------------------------------------
//
// Future<Uint8List> putWatermarkOnImage(AssetEntity asset) async {
//   Uint8List _output;
//
//   if (asset != null){
//
//     final File assetFile = await asset.file;
//
//     final ByteData watermarkImgByteData = await BytesHandlers.getByteDataFromPath('assets/images/ournow_logo.png');
//
//     _output = await BytesHandlers.getUint8ListFromFile(assetFile);
//
//     _output = await ImageWatermark.addImageWatermark(
//         originalImageBytes: _output,
//         waterkmarkImageBytes: watermarkImgByteData,
//         imgHeight: 200,
//         imgWidth: 200,
//         dstY: 400,
//         dstX: 400
//     );
//
//   }
//
//   return _output;
// }
//
// class BytesHandlers {
//   // --------------------
//   BytesHandlers();
//   // --------------------
//   static Future<ByteData> getByteDataFromPath(String assetPath) async {
//     /// NOTE : Asset path can be local path or url
//     ByteData _byteData;
//
//     if (assetPath != null){
//       _byteData = await rootBundle.load(assetPath);
//     }
//
//     return _byteData;
//   }
//   // --------------------
//   static Future<Uint8List> getUint8ListFromFile(File file) async {
//     Uint8List _uInt;
//
//     if (file != null){
//       _uInt = await file.readAsBytes();
//     }
//     return _uInt;
//   }
//   // --------------------
// }
/// --------------------------------------------------------------------------------
