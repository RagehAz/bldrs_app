import 'dart:io';
import 'dart:typed_data';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:flutter/foundation.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class ImageSize{
  final double width;
  final double height;

  ImageSize({
    @required this.width,
    @required this.height,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return
      {
        'width' : width,
        'height' : height,
      };
  }
// -----------------------------------------------------------------------------
  static ImageSize decipherImageSize(Map<String, dynamic> map){
    ImageSize _imageSize;
    if(map != null){
// -----------------------------------------------------------------------------
      dynamic _widthInInt = map['width'];
      dynamic _heightInInt = map['height'];

      _imageSize = ImageSize(
        width: _widthInInt.toDouble(),
        height: _heightInInt.toDouble(),
      );
    }
    return _imageSize;
  }
// -----------------------------------------------------------------------------
  static ImageSize getImageSizeFromAsset(Asset asset){
    ImageSize _imageSize;

    if (asset != null){
      _imageSize = ImageSize(width: asset.originalWidth.toDouble(), height: asset.originalHeight.toDouble());
    }

    return _imageSize;
  }
// -----------------------------------------------------------------------------
  static Future<ImageSize> superImageSize(dynamic image) async {
    ImageSize _imageSize;

    if(image != null){
      // -----------------------------------------------------------o
      bool _isURL = ObjectChecker.objectIsURL(image) == true;
      bool _isAsset = ObjectChecker.objectIsAsset(image) == true;
      bool _isFile = ObjectChecker.objectIsFile(image) == true;
      bool _isUints = ObjectChecker.objectIsUint8List(image) == true;
      // -----------------------------------------------------------o
      var _decodedImage;
      Uint8List _uInt8List;
      // -----------------------------------------------------------o
      if (_isURL == true) {
        File _file = await Imagers.urlToFile(image);
        _uInt8List = await _file.readAsBytesSync();
        _decodedImage = await Imagers.decodeUint8List(_uInt8List);
      }
      // --------------------------o
      else if(_isAsset == true){
        Asset _asset = image;
        ByteData _byteData = await _asset.getByteData();
        _uInt8List = await Imagers.getUint8ListFromByteData(_byteData);
        _imageSize = ImageSize.getImageSizeFromAsset(image);
      }
      // --------------------------o
      else if(_isFile){
        _uInt8List = await image.readAsBytesSync();
        _decodedImage = await Imagers.decodeUint8List(_uInt8List);
      }
      // --------------------------o
      else if (_isUints == true) {
        _decodedImage = await Imagers.decodeUint8List(image);
      }
      // -----------------------------------------------------------o
      if (_decodedImage != null){
        _imageSize = ImageSize(
          width: _decodedImage.width.toDouble(),
          height: _decodedImage.height.toDouble(),
        );
      }
      // -----------------------------------------------------------o
    }

    return _imageSize;
  }
// -----------------------------------------------------------------------------
}
