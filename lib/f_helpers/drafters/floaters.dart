import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Floaters {
// -----------------------------------------------------------------

  const Floaters();

// -----------------------------------------------------------------

  /// ui.Image

// ---------------------------------------
  static Future<ui.Image> getUiImageFromUint8List(Uint8List uInt) async {
    ui.Image _decodedImage;

    if (uInt != null) {
      _decodedImage = await decodeImageFromList(uInt);
    }

    return _decodedImage;
  }
// ---------------------------------------
  static Future<ui.Image> getUiImageFromIntList(List<int> img) async {
    final Completer<ui.Image> completer = Completer<ui.Image>();

    ui.decodeImageFromList(img, completer.complete);

    return completer.future;
  }
// -----------------------------------------------------------------

  /// uInt8List

// ---------------------------------------
  static Uint8List getUint8ListFromByteData(ByteData byteData) {
    final Uint8List _uInts = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return _uInts;
  }
// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List> getUint8ListFromFile(File file) async {
    final Uint8List _uInt = await file.readAsBytes();
    return _uInt;
  }
// ---------------------------------------
  static Future<List<Uint8List>> getUint8ListsFromFiles(List<File> files) async {
    final List<Uint8List> _screenShots = <Uint8List>[];

    if (Mapper.checkCanLoopList(files)) {
      for (final File file in files) {
        final Uint8List _uInt = await getUint8ListFromFile(file);
        _screenShots.add(_uInt);
      }
    }

    return _screenShots;
  }
// ---------------------------------------
  /// TAMAM
  static Future<Uint8List> getUint8ListFromLocalRasterAsset({
    @required String asset,
    @required int width
  }) async {
    final ByteData _byteData = await rootBundle.load(asset);

    final ui.Codec _codec = await ui.instantiateImageCodec(
        _byteData.buffer.asUint8List(),
        targetWidth: width);
    final ui.FrameInfo _fi = await _codec.getNextFrame();
    final Uint8List _result =
    (await _fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
    return _result;
  }
// ---------------------------------------
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
    await getUiImageFromIntList(Uint8List.view(_detail.buffer));

    _canvas.drawImage(_imaged, Offset.zero, Paint());

    final ui.Image _img =
    await _pictureRecorder.endRecording().toImage(width, height);
    final ByteData _data = await _img.toByteData(format: ui.ImageByteFormat.png);

    return _data.buffer.asUint8List();
  }
// -----------------------------------------------------------------

  /// Base64

// ---------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<String> getBase64FromFileOrURL(dynamic image) async {
    File _file;

    final bool _isFile = ObjectChecker.objectIsFile(image);
    // bool _isString = ObjectChecker.objectIsString(image);

    if (_isFile == true) {
      _file = image;
    } else {
      _file = await Filers.getFileFromURL(image);
    }

    final List<int> imageBytes = _file.readAsBytesSync();

    final String _base64Image = base64Encode(imageBytes);

    /*

        Uint8List _bytesImage;

        String _imgString = 'iVBORw0KGgoAAAANSUhEUg.....';

        _bytesImage = Base64Decoder().convert(_imgString);

        Image.memory(_bytesImage)

     */

    return _base64Image;
  }
// -----------------------------------------------------------------

  /// BitmapDescriptor

// ---------------------------------------
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

// ---------------------------------------
  static Future<BitmapDescriptor> getBitmapFromPNG({
    String pngPic = Iconz.flyerPinPNG,
  }) async {
    final BitmapDescriptor _marker =
    await BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, pngPic);
    return _marker;
  }
// -----------------------------------------------------------------

  /// DOUBLES

// ---------------------------------------
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
// -----------------------------------------------------------------
}
