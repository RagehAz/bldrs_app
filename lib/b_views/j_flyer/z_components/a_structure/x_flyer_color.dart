import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FlyerColors {
  /// --------------------------------------------------------------------------

  const FlyerColors();
  // --------------------------------------------------------------------------
  /// INFO BUTTON COLORS
  // --------------------
  static const Color _infoButtonTinyColor = Colorz.black255;
  static const Color _tinyButtonCollapsedColor = Colorz.black230;
  static const Color _tinyButtonExpandedColor = Colorz.black255;
  // --------------------------------------------------------------------------
  ///
  // --------------------
  static const  Color bzSlideTileColor = Colorz.black80;
  // --------------------------------------------------------------------------
  ///
  // --------------------
  static const Color progressStripOffColor = Colorz.white10;
  static const Color progressStripFadedColor = Colorz.white80;
  static const Color progressStripOnColor = Colorz.white200;
  static const Color progressStripLoadingColor = Colorz.yellow200;
  // --------------------------------------------------------------------------

  /// HEADER COLORS

  // --------------------
  static const Color headerColor = Colorz.blackSemi125;
  // --------------------
  static const Gradient headerGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[Colorz.nothing, Colorz.white50],
      stops: <double>[0.3, 1],
  );
  // --------------------
  /// BZ LOGO COLORS
  // --------------------
  static List<BoxShadow> logoShadows(double logoWidth){
    return <BoxShadow>[
      CustomBoxShadow(
          color: Colorz.black200,
          blurRadius: logoWidth * 0.15,
          style: BlurStyle.outer
      ),
    ];
  }
  // --------------------

  /// AUTHOR LABEL COLORS

  // --------------------
  static Color authorLabelColor({
    @required bool showLabel,
  }){
    return showLabel == false ? Colorz.nothing : Colorz.white20;
  }
  // --------------------

  /// CALL BUTTON COLORS

  // --------------------
  static const Color callButtonColor = Colorz.white10;
  // --------------------

  /// FOLLOW BUTTON COLORS

  // --------------------
  static Color followButtonColor({
    @required bool followIsOn,
  }){
    return followIsOn == true ? Colorz.yellow255 : Colorz.white20;
  }
  // --------------------
  static Color followIconColor({
    @required bool followIsOn,
  }){
    return followIsOn == true ? Colorz.black230 : Colorz.white255;
  }
  // --------------------
  static const Gradient followButtonGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Colorz.white50, Colorz.nothing],
    stops: <double>[0, 0.5],
  );
  // --------------------------------------------------------------------------

  /// SLIDE COLORS

  // --------------------
  /*
  static const Gradient superSlideGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[Colorz.black200, Colorz.black0],
    stops: <double>[0, 0.90],
  );
   */
  // --------------------------------------------------------------------------

  /// FOOTER COLORS

  // --------------------
  static Color footerButtonColor({
    @required bool buttonIsOn,
  }) {
    return buttonIsOn ? Colorz.yellow255 : Colorz.black255;
  }
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

  /// PROGRESS BAR COLORS

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
