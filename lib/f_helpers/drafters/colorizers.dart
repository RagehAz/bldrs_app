// ignore_for_file: non_constant_identifier_names
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class Colorizer {
  // -----------------------------------------------------------------------------

  const Colorizer();

  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Color decipherColor(String colorString) {
    Color _color;

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
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherColor(Color color) {

    final Color _color = color ?? Colorz.nothing;

    final int _alpha = _color.alpha;
    final int _r = _color.red;
    final int _g = _color.green;
    final int _b = _color.blue;

    /// PLAN : CREATE FUNCTION THAT VALIDATES THIS REGEX PATTERN ON DECIPHER COLOR METHOD
    final String _string = '$_alpha*$_r*$_g*$_b';
    return _string;
  }
  // -----------------------------------------------------------------------------

  /// CREATOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static Color createRandomColor(){
    final int _red = Numeric.createRandomIndex(listLength: 256);
    final int _green = Numeric.createRandomIndex(listLength: 256);
    final int _blue = Numeric.createRandomIndex(listLength: 256);
    final int _alpha = Numeric.createRandomIndex(listLength: 256);
    final Color _color = Color.fromARGB(_alpha, _red, _green, _blue);
    return _color;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Color createRandomColorFromBldrsPalette() {
    const List<Color> _bldrsColors = Colorz.allColorz;
    final int _randomIndex = Numeric.createRandomIndex(listLength: _bldrsColors.length);
    return _bldrsColors[_randomIndex];
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
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
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkColorsAreIdentical(Color color1, Color color2) {
    bool _areIdentical = false;

    if (color1 == null && color2 == null){
      _areIdentical = true;
    }
    else if (color1 != null && color2 != null){

      if (
          color1.alpha == color2.alpha &&
          color1.red == color2.red &&
          color1.green == color2.green &&
          color1.blue == color2.blue
      ) {
        _areIdentical = true;
      }

    }


    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// AVERAGE COLOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Color> getAverageColor(Uint8List bytes) async {

    Color _color;

    if (bytes != null){

      final img.Image bitmap = await Floaters.getImgImageFromUint8List(bytes);

      int redBucket = 0;
      int greenBucket = 0;
      int blueBucket = 0;
      int pixelCount = 0;

      for (int y = 0; y < bitmap.height; y++) {
        for (int x = 0; x < bitmap.width; x++) {
          final int c = bitmap.getPixel(x, y);

          pixelCount++;
          redBucket += img.getRed(c);
          greenBucket += img.getGreen(c);
          blueBucket += img.getBlue(c);
        }
      }

      _color = Color.fromRGBO(redBucket ~/ pixelCount,
          greenBucket ~/ pixelCount, blueBucket ~/ pixelCount, 1);

    }

    return _color;
  }
  // -----------------------------------------------------------------------------

  /// BLUR

  // --------------------
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

  /// DESATURATION

  // --------------------
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

  /// HEX

  // --------------------
  /// NOT TESTED
  static String convertColorToHex(Color color){
    final String hex = color.toHex(
      // leadingHashSign: true,
    );
    return hex;
  }
  // --------------------
  /// NOT TESTED
  static Color convertHexToColor1(String hex) {

    String _hexString = hex;

    final RegExp hexColorRegex = RegExp(r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$');

    if (_hexString.startsWith('rgba')) {
      final List rgbaList = _hexString.substring(5, _hexString.length - 1).split(',');
      return Color.fromRGBO(
          int.parse(rgbaList[0]),
          int.parse(rgbaList[1]),
          int.parse(rgbaList[2]),
          double.parse(rgbaList[3]),
      );
    }

    else if (_hexString.startsWith('rgb')) {
      final List rgbList = _hexString.substring(4, _hexString.length - 1)
          .split(',')
          .map((c) => int.parse(c)).toList();

      return Color.fromRGBO(
          rgbList[0],
          rgbList[1],
          rgbList[2],
          1,
      );
    }

    else if (hexColorRegex.hasMatch(_hexString)) {

      if (_hexString.length == 4) {
        _hexString = _hexString + _hexString.substring(1, 4);
      }

      if (_hexString.length == 7) {
        final int colorValue = int.parse(_hexString.substring(1), radix: 16);
        return Color(colorValue).withOpacity(1);
      }

      else {
        final int colorValue = int.parse(_hexString.substring(1, 7), radix: 16);
        final double opacityValue = int.parse(_hexString.substring(7), radix: 16).toDouble() / 255;
        return Color(colorValue).withOpacity(opacityValue);
      }

    }

    else if (_hexString.isEmpty) {
      throw UnsupportedError('Empty color field found.');
    }

    else if (_hexString == 'none') {
      return Colors.transparent;
    }

    else {
      throw UnsupportedError('Only hex, rgb, or rgba color format currently supported. String: $_hexString');
    }

  }
  // --------------------
  /// NOT TESTED
  static Color convertHexToColor2(String hex){
    final Color color = HexColor.fromHex(hex);
    return color;
  }

// -----------------------------------------------------------------------------
}

extension HexColor on Color {
  // -----------------------------------------------------------------------------
  /// REFERENCE
  // --------------------
  /// https://stackoverflow.com/questions/50081213/how-do-i-use-hexadecimal-color-strings-in-flutter
  // -----------------------------------------------------------------------------

  /// FROM HEX

  // --------------------
  static Color fromHex(String hexString) {

    /// NOTE : String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".

    final buffer = StringBuffer();

    if (hexString.length == 6 || hexString.length == 7){
      buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    }

    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// TO HEX

  // --------------------
  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
  // -----------------------------------------------------------------------------
}
