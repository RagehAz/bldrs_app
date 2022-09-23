

import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerColor {
  /// --------------------------------------------------------------------------

  const FlyerColor();

  // --------------------------------------------------------------------------
  static Color footerButtonColor({
    @required bool buttonIsOn,
  }) {
    return buttonIsOn ? Colorz.yellow255 : Colorz.black255;
  }
  // --------------------------------------------------------------------------

  /// INFO BUTTON COLORS

  // --------------------
  static const Color _infoButtonTinyColor = Colorz.black255;
  // --------------------
  static const Color _tinyButtonCollapsedColor = Colorz.black230;
  // --------------------
  static const Color _tinyButtonExpandedColor = Colorz.black255;

  // --------------------------------------------------------------------------
  static Color infoButtonColor({
    @required double flyerBoxWidth,
    @required bool tinyMode,
    @required bool isExpanded,
  }){

    Color _color;

    if (tinyMode == true){
      _color = _infoButtonTinyColor;
    }

    else {

      if (isExpanded == true){
        _color = _tinyButtonExpandedColor;
      }

      else {
        _color = _tinyButtonCollapsedColor;
      }

    }

    return _color;
  }
// --------------------------------------------------------------------------
  static const Color progressStripOffColor = Colorz.white10;
  static const Color progressStripFadedColor = Colorz.white80;
  static const Color progressStripOnColor = Colorz.white200;
  static const Color progressStripLoadingColor = Colorz.yellow200;
  // --------------------
  static Color progressStripColor({
    bool isWhite,
    int numberOfSlides,
  }) {
    final int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;

    final Color _stripColor = !isWhite ?
    progressStripFadedColor
        :
    _numberOfSlides == 0 ? progressStripOffColor
        :
    progressStripOnColor;

    return _stripColor;
  }
  // --------------------------------------------------------------------------
}
