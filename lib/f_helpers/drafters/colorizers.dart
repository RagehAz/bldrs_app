// ignore_for_file: non_constant_identifier_names
import 'dart:io';
import 'dart:ui' as ui;
import 'package:bldrs/f_helpers/drafters/filers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as Image;

class Colorizer {
// -----------------------------------------------------------------------------

  const Colorizer();

// -----------------------------------------------------------------------------

  /// CYPHERS

// -------------------------------------
  static Color decipherColor(String colorString) {
    Color _color;

    // print('decipherColor : colorString : $colorString');

    if (colorString != null) {
      /// reference ciphered color code
      // String _string = '${_alpha}*${_r}*${_g}*${_b}';

      /// ALPHA
      final String _a = TextMod.removeTextAfterFirstSpecialCharacter(colorString, '*');
      final int _alpha = Numeric.transformStringToInt(_a);

      /// RED
      final String _rX_gX_b = TextMod.removeTextBeforeFirstSpecialCharacter(colorString, '*');
      final String _r = TextMod.removeTextAfterFirstSpecialCharacter(_rX_gX_b, '*');
      final int _red = Numeric.transformStringToInt(_r);

      /// GREEN
      final String _gX_b = TextMod.removeTextBeforeFirstSpecialCharacter(_rX_gX_b, '*');
      final String _g = TextMod.removeTextAfterFirstSpecialCharacter(_gX_b, '*');
      final int _green = Numeric.transformStringToInt(_g);

      /// BLUE
      final String _b = TextMod.removeTextBeforeFirstSpecialCharacter(_gX_b, '*');
      final int _blue = Numeric.transformStringToInt(_b);

      _color = Color.fromARGB(_alpha, _red, _green, _blue);
    }

    return _color;
  }
// -------------------------------------
  static String cipherColor(Color color) {
    final Color _color = color ?? Colorz.nothing;

    final int _alpha = _color.alpha;
    final int _r = _color.red;
    final int _g = _color.green;
    final int _b = _color.blue;

    final String _string = '$_alpha*$_r*$_g*$_b';
    return _string;
  }
// -----------------------------------------------------------------------------


  /// CREATOR

// -------------------------------------
  static Color createRandomColor(){
    final int _red = Numeric.createRandomIndex(listLength: 256);
    final int _green = Numeric.createRandomIndex(listLength: 256);
    final int _blue = Numeric.createRandomIndex(listLength: 256);
    final int _alpha = Numeric.createRandomIndex(listLength: 256);
    final Color _color = Color.fromARGB(_alpha, _red, _green, _blue);
    return _color;
  }
// -------------------------------------
  static Color createRandomColorFromBldrsPalette() {
    const List<Color> _bldrsColors = Colorz.allColorz;
    final int _randomIndex = Numeric.createRandomIndex(listLength: _bldrsColors.length);
    return _bldrsColors[_randomIndex];
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// -------------------------------------
  static bool checkColorIsBlack(Color color) {
    bool _isBlack = false;

    const Color _black = Colorz.black255;

    if (color != null &&
        color.red == _black.red &&
        color.green == _black.green &&
        color.blue == _black.blue) {
      _isBlack = true;
    }

    return _isBlack;
  }
// -------------------------------------
  static bool checkColorsAreIdentical(Color color1, Color color2) {
    bool _areIdentical = false;

    if (color1.alpha == color2.alpha &&
        color1.red == color2.red &&
        color1.green == color2.green &&
        color1.blue == color2.blue) {
      _areIdentical = true;
    }

    return _areIdentical;
  }
// -----------------------------------------------------------------------------

  /// AVERAGE COLOR

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Color> getAverageColor(dynamic pic) async {

    final File _imageFile = await Filers.getFileFromDynamics(pic);

    final Image.Image bitmap = Image.decodeImage(_imageFile.readAsBytesSync());

    int redBucket = 0;
    int greenBucket = 0;
    int blueBucket = 0;
    int pixelCount = 0;

    for (int y = 0; y < bitmap.height; y++) {
      for (int x = 0; x < bitmap.width; x++) {
        final int c = bitmap.getPixel(x, y);

        pixelCount++;
        redBucket += Image.getRed(c);
        greenBucket += Image.getGreen(c);
        blueBucket += Image.getBlue(c);
      }
    }

    final Color _averageColor = Color.fromRGBO(redBucket ~/ pixelCount,
        greenBucket ~/ pixelCount, blueBucket ~/ pixelCount, 1);

    return _averageColor;
  }
// -----------------------------------------------------------------------------

  /// BLUR

// -------------------------------------
  static ui.ImageFilter superBlur({
    @required bool trigger,
  }) {
    final double blueValue = trigger == true ? 8 : 0;

    final ui.ImageFilter blur = ui.ImageFilter.blur(
      sigmaX: blueValue,
      sigmaY: blueValue,
    );

    return blur;
  }
// -----------------------------------------------------------------------------

  /// GRADIENTS

// -------------------------------------
  static Gradient superSlideGradient() {
    const Gradient slideGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colorz.black200, Colorz.black0],
        stops: <double>[0, 0.90]);
    return slideGradient;
  }
// -------------------------------------
  static Gradient superHeaderStripGradient(Color color) {
    final Gradient headerStripGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colorz.nothing, color],
        stops: const <double>[0.3, 1]);
    return headerStripGradient;
  }
// -------------------------------------
  static Gradient superFollowBTGradient() {
    const Gradient followBTGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colorz.white50, Colorz.nothing],
        stops: <double>[0, 0.5]);
    return followBTGradient;
  }
// -----------------------------------------------------------------------------

  /// DESATURATION

// -------------------------------------
  static ColorFilter desaturationColorFilter({
    @required bool isItBlackAndWhite,
  }) {

    /// if i want to black and white a widget, put it as child in here
    /// child: ColorFiltered(
    ///     colorFilter: superDesaturation(blackAndWhite),
    ///     child: ,

    final Color imageSaturationColor = isItBlackAndWhite == true ? Colorz.grey255 : Colorz.nothing;
    return ColorFilter.mode(imageSaturationColor, BlendMode.saturation);
  }
// -----------------------------------------------------------------------------
  static Color errorize({
    @required bool errorIsOn,
    @required Color defaultColor,
    @required bool canErrorize,
  }){
    Color _color = defaultColor;

    /// if condition is true => error is on
    if (errorIsOn == true && canErrorize == true){
      _color = Colorz.errorColor;
    }
    return _color;
  }
// ---------------------------------------
  static Color ValidatorColor({
    @required String Function() validator,
    @required Color defaultColor,
    @required bool canErrorize,
}){

    return errorize(
        errorIsOn: validator() != null,
        defaultColor: defaultColor,
        canErrorize: canErrorize,
    );

  }
// -----------------------------------------------------------------------------
}
