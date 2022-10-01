import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image/image.dart' as img;

class Floaters {
  // -----------------------------------------------------------------------------

  const Floaters();

  // -----------------------------------------------------------------------------

  /// ByteData

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ByteData> getByteDataFromUiImage(ui.Image uiImage) async {
    ByteData _byteData;

    if (uiImage != null){
      _byteData = await uiImage.toByteData(
        format: ui.ImageByteFormat.png,
      );
    }

    return _byteData;
  }
  // -----------------------------------------------------------------------------

  /// ui.Image

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ui.Image> getUiImageFromUint8List(Uint8List uInt) async {
    ui.Image _decodedImage;

    if (uInt != null) {
      _decodedImage = await decodeImageFromList(uInt);
    }

    return _decodedImage;
  }
  // --------------------
  static Future<ui.Image> getUiImageFromInts(List<int> ints) async {
    final Completer<ui.Image> completer = Completer<ui.Image>();

    ui.decodeImageFromList(ints, completer.complete);

    return completer.future;
  }
  // -----------------------------------------------------------------------------

  /// img.Image

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<img.Image> getImgImageFromFile(File file) async {
    img.Image _image;

    if (file != null){

      final Uint8List uint = await Floaters.getUint8ListFromFile(file);

      _image = await Floaters.getImgImageFromUint8List(uint);

    }

    return _image;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<img.Image> getImgImageFromUint8List(Uint8List uInt) async {
    img.Image imgImage;

    if (uInt != null){
      imgImage = img.decodeImage(uInt);
    }

    return imgImage;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static img.Image resizeImgImage({
    @required img.Image imgImage,
    @required int width,
    @required int height,
  }) {
    img.Image _output;

    if (imgImage != null){
      _output = img.copyResize(imgImage,
        width: width,
        height: height,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  /*
static img.Image decodeToImgImage({
  @required List<int> bytes,
  @required PicFormat picFormat,
}){

    switch (picFormat){
      case PicFormat.image : return img.decodeImage(bytes); break;
      case PicFormat.jpg : return img.decodeJpg(bytes); break;
      case PicFormat.png : return img.decodePng(bytes); break;
      case PicFormat.tga : return img.decodeTga(bytes); break;
      case PicFormat.webP : return img.decodeWebP(bytes); break;
      case PicFormat.gif : return img.decodeGif(bytes); break;
      case PicFormat.tiff : return img.decodeTiff(bytes); break;
      case PicFormat.psd : return img.decodePsd(bytes); break;
      case PicFormat.exr : return img.decodeExr(bytes); break;
      case PicFormat.bmp : return img.decodeBmp(bytes); break;
      case PicFormat.ico : return img.decodeIco(bytes); break;
      // case PicFormat.animation : return img.decodeAnimation(bytes); break;
      // case PicFormat.pngAnimation : return img.decodePngAnimation(bytes); break;
      // case PicFormat.webPAnimation : return img.decodeWebPAnimation(bytes); break;
      // case PicFormat.gifAnimation : return img.decodeGifAnimation(bytes); break;
      default: return null;
    }

}
   */
  // --------------------
  /*
  enum PicFormat {
  image,

  jpg,
  png,
  tga,
  webP,
  gif,
  tiff,
  psd,
  bmp,
  ico,

  exr,

  animation,
  pngAnimation,
  webPAnimation,
  gifAnimation,

// svg,
}
*/
  // -----------------------------------------------------------------------------

  /// uInt8List

  // --------------------
  /// TESTED : WORKS PERFECT
  static Uint8List getUint8ListFromByteData(ByteData byteData) {

    /// METHOD 1 : WORKS PERFECT
    // final Uint8List _uInts = byteData.buffer.asUint8List(
    //   byteData.offsetInBytes,
    //   byteData.lengthInBytes,
    // );

    /// METHOD 2 : WORKS PERFECT
    // final Uint8List _uInts = Uint8List.view(byteData.buffer);

    return byteData.buffer.asUint8List(
      byteData.offsetInBytes,
      byteData.lengthInBytes,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> getUint8ListFromFile(File file) async {
    Uint8List _uInt;

    // blog('transformFileToUint8List : START');
    //
    if (file != null){
    //   await tryAndCatch(
    //       methodName: 'transformFileToUint8List',
    //       functions: () async {
    //
    //         blog('transformFileToUint8List : _uInt : $_uInt');
    _uInt = await file.readAsBytes();
    //         blog('transformFileToUint8List : _uInt : $_uInt');
    //
    //       });
    }

    blog('transformFileToUint8List : END');

    return _uInt;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Uint8List>> getUint8ListsFromFiles(List<File> files) async {
    final List<Uint8List> _screenShots = <Uint8List>[];

    if (Mapper.checkCanLoopList(files)) {
      for (final File file in files) {
        final Uint8List _uInt = await getUint8ListFromFile(file);
        if (_uInt != null){
          _screenShots.add(_uInt);
        }
      }
    }

    return _screenShots;
  }
  // --------------------
  /// TAMAM
  static Future<Uint8List> getUint8ListFromLocalRasterAsset({
    @required String asset,
    @required int width
  }) async {
    final ByteData _byteData = await rootBundle.load(asset);

    final ui.Codec _codec = await ui.instantiateImageCodec(
      _byteData.buffer.asUint8List(),
      targetWidth: width,
    );

    final ui.FrameInfo _fi = await _codec.getNextFrame();

    final Uint8List _result =
    (await _fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();

    return _result;
  }
  // --------------------
  static Future<Uint8List> getUint8ListFromRasterURL(int width, int height, String urlAsset) async {
    final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
    final Canvas _canvas = Canvas(_pictureRecorder);
    final Paint _paint = Paint()..color = Colors.transparent;
    const Radius _radius = Radius.circular(20);

    _canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, 0, width.toDouble(), height.toDouble()),
          topLeft: _radius,
          topRight: _radius,
          bottomLeft: _radius,
          bottomRight: _radius,
        ),
        _paint);

    final ByteData _detail = await rootBundle.load(urlAsset);
    final ui.Image _imaged =
    await getUiImageFromInts(Uint8List.view(_detail.buffer));

    _canvas.drawImage(_imaged, Offset.zero, Paint());

    final ui.Image _img =
    await _pictureRecorder.endRecording().toImage(width, height);
    final ByteData _data = await _img.toByteData(format: ui.ImageByteFormat.png);

    return _data.buffer.asUint8List();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> getUint8ListFromUiImage(ui.Image uiImage) async {
    Uint8List uInt;

    if (uiImage != null){

      final ByteData _byteData = await getByteDataFromUiImage(uiImage);

      if (_byteData != null){
        uInt = Floaters.getUint8ListFromByteData(_byteData);
      }

    }

    return uInt;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Uint8List getUint8ListFromImgImage(img.Image imgImage) {
    Uint8List uInt;

    if (imgImage != null){
      uInt = img.encodeJpg(imgImage, quality: 100);
    }

    return uInt;
  }
  // --------------------
  static Future<Uint8List> getUint8ListFromImgImageAsync(img.Image imgImage) async{
    Uint8List uInt;
    if (imgImage != null){
      uInt = getUint8ListFromImgImage(imgImage);
    }
    return uInt;
  }
  // -----------------------------------------------------------------------------

  /// Base64

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<String> getBase64FromFileOrURL(dynamic image) async {
    File _file;

    final bool _isFile = ObjectCheck.objectIsFile(image);
    // bool _isString = ObjectChecker.objectIsString(image);

    if (_isFile == true) {
      _file = image;
    } else {
      _file = await Filers.getFileFromURL(image);
    }

    final List<int> imageBytes = _file.readAsBytesSync();

    /*

        Uint8List _bytesImage;

        String _imgString = 'iVBORw0KGgoAAAANSUhEUg.....';

        _bytesImage = Base64Decoder().convert(_imgString);

        Image.memory(_bytesImage)

     */

    return base64Encode(imageBytes);
  }
  // -----------------------------------------------------------------------------

  /// BitmapDescriptor

  // --------------------
  static Future<BitmapDescriptor> getBitmapFromSVG({
    @required BuildContext context,
    @required String assetName,
  }) async {
    // Read SVG file as String
    final String svgString =
    await DefaultAssetBundle.of(context).loadString(assetName);
    // Create DrawableRoot from SVG String
    final DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, null);

    // toPicture() and toImage() don't seem to be pixel ratio aware, so we calculate the actual sizes here
    final MediaQueryData queryData = MediaQuery.of(context);
    final double devicePixelRatio = queryData.devicePixelRatio;
    final double width =
        32 * devicePixelRatio; // where 32 is your SVG's original width
    final double height = 32 * devicePixelRatio; // same thing

    // Convert to ui.Picture
    final ui.Picture picture =
    svgDrawableRoot.toPicture(size: Size(width, height));

    // Convert to ui.Image. toImage() takes width and height as parameters
    // you need to find the best size to suit your needs and take into account the
    // screen DPI
    final ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    final ByteData bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }
  // --------------------
  static Future<BitmapDescriptor> getBitmapFromPNG({
    String pngPic = Iconz.flyerPinPNG,
  }) async {
    final BitmapDescriptor _marker =
    await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, pngPic);
    return _marker;
  }
  // -----------------------------------------------------------------------------

  /// INTs : List<int>

  // --------------------
  static List<int> getIntsFromUint8List(Uint8List uInt){
    List<int> _ints;

    if (uInt != null){
      _ints = uInt.toList();
    }

    return _ints;
  }

  static List<int> getIntsFromDynamics(List<dynamic> ints){
    final List<int> _ints = <int>[];

    if (ints != null){
      // _ints.addAll(_ints);

      for (int i = 0; i < ints.length; i++){
        _ints.add(ints[0]);
      }

    }



    return _ints;
  }
  // -----------------------------------------------------------------------------
  /// DOUBLEs : List<double>

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<double> getDoublesFromDynamics(List<dynamic> dynamics){

    final List<double> _output = <double>[];

    if (Mapper.checkCanLoopList(dynamics) == true){

      for (final dynamic dyn in dynamics){

        if (dyn is double){
          final double _double = dyn;
          _output.add(_double);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
