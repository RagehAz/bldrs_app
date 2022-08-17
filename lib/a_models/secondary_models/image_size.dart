import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

@immutable
class ImageSize {
  /// --------------------------------------------------------------------------
  const ImageSize({
    @required this.width,
    @required this.height,
  });
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
// -----------------------------------------------------------------------------

  /// CYPHERS

// -------------------------------------
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'width': width,
      'height': height,
    };
  }
// -------------------------------------
  static ImageSize decipherImageSize(Map<String, dynamic> map) {
    ImageSize _imageSize;
    if (map != null) {

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

  /// GETTERS

// -------------------------------------
  double getAspectRatio(){

    /*
       final double _ratio = _slide.imageSize.getAspectRatio();
       final double _imageHeight = _flyerBoxWidth * _ratio;
       final double _scale = _flyerBoxHeight / _imageHeight;
   */

    return height / width;
  }
// -------------------------------------
  /*
  static ImageSize getImageSizeFromAsset(Asset asset) {
    ImageSize _imageSize;

    if (asset != null) {
      _imageSize = ImageSize(
          width: asset.originalWidth.toDouble(),
          height: asset.originalHeight.toDouble());
    }

    return _imageSize;
  }
   */
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<ImageSize> superImageSize(dynamic image) async {
    ImageSize _imageSize;

    if (image != null) {
      // -----------------------------------------------------------o
      final bool _isURL = ObjectChecker.objectIsURL(image) == true;
      // blog('_isURL : $_isURL');
      // final bool _isAsset = ObjectChecker.objectIsAsset(image) == true;
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
        final File _file = await Filers.transformURLToFile(image);
        _uInt8List = _file.readAsBytesSync();
        // await null;
        _decodedImage = await Floaters.transformUint8ListToUiImage(_uInt8List);
      }
      // --------------------------o
      /*
      else if (_isAsset == true) {
        final Asset _asset = image;
        final ByteData _byteData = await _asset.getByteData();
        _uInt8List = Imagers.getUint8ListFromByteData(_byteData);
        // await null;
        _imageSize = ImageSize.getImageSizeFromAsset(image);
      }
       */
      // --------------------------o
      else if (_isFile) {
        // blog('_isFile staring aho : $_isFile');
        _uInt8List = await image.readAsBytesSync();
        // blog('_uInt8List : $_uInt8List');
        _decodedImage = await Floaters.transformUint8ListToUiImage(_uInt8List);
        // blog('_decodedImage : $_decodedImage');
      }
      // --------------------------o
      else if (_isUints == true) {
        _decodedImage = await Floaters.transformUint8ListToUiImage(image);
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

  /// BLOGGING

// -------------------------------------
  void blogSize({String methodName = 'ImageSize'}) {
    blog('blogSize : $methodName : image size: W [ $width ] x H [ $height ]');
  }
// -----------------------------------------------------------------------------

  /// BOX FIT

// -------------------------------------
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
      case 1:   return BoxFit.fitHeight;
      case 2:   return BoxFit.fitWidth;
      case 3:   return BoxFit.cover;
      case 4:   return BoxFit.none;
      case 5:   return BoxFit.fill;
      case 6:   return BoxFit.scaleDown;
      case 7:   return BoxFit.contain;
      default:  return null;
    }
  }
// -----------------------------------------------------------------------------

  /// CONCLUDERS

// -------------------------------------
  static double concludeHeightByGraphicSizes({
    @required double width,
    @required double graphicWidth,
    @required double graphicHeight,
  }) {
    /// height / width = graphicHeight / graphicWidth
    return (graphicHeight * width) / graphicWidth;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  static bool checkSizesAreIdentical({
    @required ImageSize sizeA,
    @required ImageSize sizeB,
  }){

    bool _identical = false;

    if (sizeA == null && sizeB == null){
      _identical = true;
    }
    else if (
        sizeA.width == sizeB.width &&
        sizeA.height == sizeB.height
    ){
      _identical = true;
    }

    return _identical;
  }
// -----------------------------------------------------------------

  /// BOX FIT

// ---------------------------------------
  /*
  static BoxFit concludeBoxFitOld(Asset asset) {
    final BoxFit _fit = asset.isPortrait ? BoxFit.fitHeight : BoxFit.fitWidth;
    return _fit;
  }
   */
// ---------------------------------------
  static BoxFit concludeBoxFit({
    @required double picWidth,
    @required double picHeight,
    @required double viewWidth,
    @required double viewHeight,
  }) {
    BoxFit _boxFit;

    /// note : if ratio < 1 image is portrait, if ratio > 1 image is landscape
    // double _originalImageRatio = _originalImageWidth / _originalImageHeight

    // double _slideRatio = 1 / Ratioz.xxflyerZoneHeight;

    // double _fittedImageWidth = flyerBoxWidth; // for info only
    final double _fittedImageHeight = (viewWidth * picHeight) / picWidth;

    final double _heightAllowingFitHeight = (Ratioz.slideFitWidthLimit / 100) * viewHeight;

    /// if fitted height is less than the limit
    if (_fittedImageHeight < _heightAllowingFitHeight) {
      _boxFit = BoxFit.fitWidth;
    }

    /// if fitted height is higher that the limit
    else {
      _boxFit = BoxFit.fitHeight;
    }

    return _boxFit;
  }
// ---------------------------------------
  /*
  BoxFit concludeBoxFitForAsset({
    @required Asset asset,
    @required double flyerBoxWidth,
  }) {
    /// note : if ratio < 1 image is portrait, if ratio > 1 image is landscape
    final double _originalImageWidth = asset.originalWidth.toDouble();
    final double _originalImageHeight = asset.originalHeight.toDouble();
    // double _originalImageRatio = _originalImageWidth / _originalImageHeight

    /// slide aspect ratio : 1 / 1.74 ~= 0.575
    final double _flyerZoneHeight = flyerBoxWidth * Ratioz.xxflyerZoneHeight;

    return concludeBoxFit(
      picWidth: _originalImageWidth,
      picHeight: _originalImageHeight,
      viewWidth: flyerBoxWidth,
      viewHeight: _flyerZoneHeight,
    );
  }
   */
// ---------------------------------------
  /*
  List<BoxFit> concludeBoxesFitsForAssets({
    @required List<Asset> assets,
    @required double flyerBoxWidth,
  }) {
    final List<BoxFit> _fits = <BoxFit>[];

    for (final Asset asset in assets) {
      /// straigh forward solution,, bas ezzay,, I'm Rage7 and I can't just let it go keda,,
      // if(asset.isPortrait){
      //   _fits.add(BoxFit.fitHeight);
      // } else {
      //   _fits.add(BoxFit.fitWidth);
      // }

      /// boss ba2a
      final BoxFit _fit = concludeBoxFitForAsset(
        asset: asset,
        flyerBoxWidth: flyerBoxWidth,
      );

      _fits.add(_fit);
    }

    return _fits;
  }
   */
// -----------------------------------------------------------------
}

/*
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
 */
