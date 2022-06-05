import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

/// TASK : may combine this with some methods from Imagers
class ImageSize {
  /// --------------------------------------------------------------------------
  ImageSize({
    @required this.width,
    @required this.height,
  });

  /// --------------------------------------------------------------------------
  final double width;
  final double height;

  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'width': width,
      'height': height,
    };
  }

  double getAspectRatio(){
    return height / width;
  }

  /*

              final double _ratio = _slide.imageSize.getAspectRatio();
            final double _imageHeight = _flyerBoxWidth * _ratio;
            final double _scale = _flyerBoxHeight / _imageHeight;


   */

// -----------------------------------------------------------------------------
  static ImageSize decipherImageSize(Map<String, dynamic> map) {
    ImageSize _imageSize;
    if (map != null) {
// -----------------------------------------------------------------------------
      final dynamic _widthInInt = map['width'];
      final dynamic _heightInInt = map['height'];

      _imageSize = ImageSize(
        width: _widthInInt.toDouble(),
        height: _heightInInt.toDouble(),
      );
    }
    return _imageSize;
  }

// -----------------------------------------------------------------------------
  static ImageSize getImageSizeFromAsset(Asset asset) {
    ImageSize _imageSize;

    if (asset != null) {
      _imageSize = ImageSize(
          width: asset.originalWidth.toDouble(),
          height: asset.originalHeight.toDouble());
    }

    return _imageSize;
  }

// -----------------------------------------------------------------------------
  static Future<ImageSize> superImageSize(dynamic image) async {
    ImageSize _imageSize;

    if (image != null) {
      // -----------------------------------------------------------o
      final bool _isURL = ObjectChecker.objectIsURL(image) == true;
      // blog('_isURL : $_isURL');
      final bool _isAsset = ObjectChecker.objectIsAsset(image) == true;
      // blog('_isAsset : $_isAsset');
      final bool _isFile = ObjectChecker.objectIsFile(image) == true;
      // blog('_isFile : $_isFile');
      final bool _isUints = ObjectChecker.objectIsUint8List(image) == true;
      // blog('_isUints : $_isUints');
      // -----------------------------------------------------------o
      ui.Image _decodedImage;
      Uint8List _uInt8List;
      // -----------------------------------------------------------o
      if (_isURL == true) {
        final File _file = await Imagers.getFileFromURL(image);
        _uInt8List = _file.readAsBytesSync();
        // await null;
        _decodedImage = await Imagers.getUiImageFromUint8List(_uInt8List);
      }
      // --------------------------o
      else if (_isAsset == true) {
        final Asset _asset = image;
        final ByteData _byteData = await _asset.getByteData();
        _uInt8List = Imagers.getUint8ListFromByteData(_byteData);
        // await null;
        _imageSize = ImageSize.getImageSizeFromAsset(image);
      }
      // --------------------------o
      else if (_isFile) {
        // blog('_isFile staring aho : $_isFile');
        _uInt8List = await image.readAsBytesSync();
        // blog('_uInt8List : $_uInt8List');
        _decodedImage = await Imagers.getUiImageFromUint8List(_uInt8List);
        // blog('_decodedImage : $_decodedImage');
      }
      // --------------------------o
      else if (_isUints == true) {
        _decodedImage = await Imagers.getUiImageFromUint8List(image);
      }
      // -----------------------------------------------------------o
      if (_decodedImage != null) {
        _imageSize = ImageSize(
          width: _decodedImage.width
              .toDouble(), // was _decodedImage.size.toDouble() I don't know why,, needs a test
          height: _decodedImage.height.toDouble(),
        );
      }
      // -----------------------------------------------------------o
    }

    return _imageSize;
  }

// -----------------------------------------------------------------------------
  void blogSize({String methodName}) {
    blog('START - PRINT IMAGE SIZE - IN - $methodName - ------------------------------------- START ---');

    blog('image size: W [ $width ] x H [ $height ]');

    blog('END - PRINT IMAGE SIZE - IN - $methodName - ------------------------------------- END ---');
  }

// -----------------------------------------------------------------------------
  static int cipherBoxFit(BoxFit boxFit) {
    switch (boxFit) {
      case BoxFit.fitHeight:
        return 1;
        break;
      case BoxFit.fitWidth:
        return 2;
        break;
      case BoxFit.cover:
        return 3;
        break;
      case BoxFit.none:
        return 4;
        break;
      case BoxFit.fill:
        return 5;
        break;
      case BoxFit.scaleDown:
        return 6;
        break;
      case BoxFit.contain:
        return 7;
        break;
      default:
        return 3;
    }
  }

// -----------------------------------------------------------------------------
  static BoxFit decipherBoxFit(int boxFit) {
    switch (boxFit) {
      case 1:
        return BoxFit.fitHeight;
      case 2:
        return BoxFit.fitWidth;
      case 3:
        return BoxFit.cover;
      case 4:
        return BoxFit.none;
      case 5:
        return BoxFit.fill;
      case 6:
        return BoxFit.scaleDown;
      case 7:
        return BoxFit.contain;
      default:
        return null;
    }
  }

// -----------------------------------------------------------------------------
  static String sqlCipherImageSize(ImageSize size) {
    String _string;

    if (size != null && size.width != null && size.height != null) {
      _string = '${size.width}#${size.height}';
    }

    return _string;
  }

// -----------------------------------------------------------------------------
  static ImageSize sqlDecipherImageSize(String sqlImageSize) {
    ImageSize _imageSize;

    if (sqlImageSize != null) {
      final String _widthString =
          TextMod.removeTextAfterFirstSpecialCharacter(sqlImageSize, '#');
      final double _width = Numeric.transformStringToDouble(_widthString);

      final String _heightString =
          TextMod.removeTextBeforeFirstSpecialCharacter(sqlImageSize, '#');
      final double _height = Numeric.transformStringToDouble(_heightString);

      _imageSize = ImageSize(
        width: _width,
        height: _height,
      );
    }

    return _imageSize;
  }

// -----------------------------------------------------------------------------
  static double concludeHeightByGraphicSizes(
      {@required double width,
      @required double graphicWidth,
      @required double graphicHeight}) {
    /// height / width = graphicHeight / graphicWidth
    return (graphicHeight * width) / graphicWidth;
  }
}
