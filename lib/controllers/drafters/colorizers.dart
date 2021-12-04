import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/controllers/drafters/numeric.dart' as Numeric;
import 'package:bldrs/controllers/drafters/text_mod.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;

  Gradient superSlideGradient(){
    const Gradient slideGradient = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colorz.black200, Colorz.black0],
        stops: <double>[0,0.90]
    );
    return slideGradient;
  }
// -----------------------------------------------------------------------------
  Gradient superHeaderStripGradient(Color color){
    final Gradient headerStripGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colorz.nothing, color],
        stops: const <double>[0.3, 1]);
    return headerStripGradient;
  }
// -----------------------------------------------------------------------------
  Gradient superFollowBTGradient(){
    const Gradient followBTGradient = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colorz.white50, Colorz.nothing],
        stops: <double>[0, 0.5]
    );
    return followBTGradient;
  }
// -----------------------------------------------------------------------------
  ui.ImageFilter superBlur(bool trigger){
    final double blueValue = trigger == true ? 8 : 0;
    final ui.ImageFilter blur = ui.ImageFilter.blur(sigmaX: blueValue, sigmaY: blueValue);
    return blur;
  }
// -----------------------------------------------------------------------------
  /// if i want to black and white a widget, put it as child in here
  /// child: ColorFiltered(
  ///     colorFilter: superDesaturation(blackAndWhite),
  ///     child: ,
  ColorFilter superDesaturation(bool isItBlackAndWhite){
    final Color imageSaturationColor = isItBlackAndWhite == true ? Colorz.grey225 : Colorz.nothing;
    return ColorFilter.mode(
        imageSaturationColor,
        BlendMode.saturation
    );
  }
// -----------------------------------------------------------------------------
  Future<Color> getAverageColor(dynamic pic) async {
    final File _imageFile = await Imagers.getFileFromDynamic(pic);

    final img.Image bitmap =
    img.decodeImage(_imageFile.readAsBytesSync());

    int redBucket = 0;
    int greenBucket = 0;
    int blueBucket = 0;
    int pixelCount = 0;

    for (int y = 0; y < bitmap.height; y++) {
      for (int x = 0; x < bitmap.width; x++) {
        int c = bitmap.getPixel(x, y);

        pixelCount++;
        redBucket += img.getRed(c);
        greenBucket += img.getGreen(c);
        blueBucket += img.getBlue(c);
      }
    }

    final Color _averageColor = Color.fromRGBO(redBucket ~/ pixelCount,
        greenBucket ~/ pixelCount, blueBucket ~/ pixelCount, 1);

    return _averageColor;
  }
// -----------------------------------------------------------------------------
  Color decipherColor(String colorString){
    Color _color;

    // print('decipherColor : colorString : $colorString');

    if(colorString != null){
      /// reference ciphered color code
      // String _string = '${_alpha}*${_r}*${_g}*${_b}';

      /// ALPHA
      final String _a = TextMod.removeTextAfterFirstSpecialCharacter(colorString, '*');
      final int _alpha = Numeric.stringToInt(_a);

      /// RED
      final String _rX_gX_b = TextMod.removeTextBeforeFirstSpecialCharacter(colorString, '*');
      final String _r = TextMod.removeTextAfterFirstSpecialCharacter(_rX_gX_b, '*');
      final int _red = Numeric.stringToInt(_r);

      /// GREEN
      final String _gX_b = TextMod.removeTextBeforeFirstSpecialCharacter(_rX_gX_b, '*');
      final String _g = TextMod.removeTextAfterFirstSpecialCharacter(_gX_b, '*');
      final int _green = Numeric.stringToInt(_g);

      /// BLUE
      final String _b = TextMod.removeTextBeforeFirstSpecialCharacter(_gX_b, '*');
      final int _blue = Numeric.stringToInt(_b);

      _color = Color.fromARGB(_alpha, _red, _green, _blue);

    }

    return _color;
  }
// -----------------------------------------------------------------------------
  String cipherColor(Color color){

    final Color _color = color == null ? Colorz.nothing : color;

      final int _alpha = _color.alpha;
      final int _r = _color.red;
      final int _g = _color.green;
      final int _b = _color.blue;

    final String _string = '${_alpha}*${_r}*${_g}*${_b}';
    return _string;
  }
// -----------------------------------------------------------------------------
  bool colorsAreTheSame(Color colorA, Color colorB){
    bool _areTheSame = false;

    if(
        colorA.alpha == colorB.alpha
        &&
        colorA.red == colorB.red
        &&
        colorA.green == colorB.green
        &&
        colorA.blue == colorB.blue
    ){
      _areTheSame = true;
    }

    return _areTheSame;
  }
// -----------------------------------------------------------------------------
  Color getRandomColor(){
    const List<Color> _bldrsColors = Colorz.allColorz;
    final int _randomIndex = Numeric.createRandomIndex(listLength: _bldrsColors.length);
    return _bldrsColors[_randomIndex];
  }
// -----------------------------------------------------------------------------
  bool isBlack(Color color){
    bool _isBlack = false;

    const Color _black = Colorz.black255;

    if (color !=null && color.red == _black.red && color.green == _black.green && color.blue == _black.blue){
      _isBlack = true;
    }

    return _isBlack;
  }
// -----------------------------------------------------------------------------
