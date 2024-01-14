import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:flutter/material.dart';

/// => TAMAM
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
  // --------------------------------------------------------------------------

  /// HEADER COLORS

  // --------------------
  static Color headerColorBeginColor({
    required bool tinyMode,
  }){
    return tinyMode == true ? Colorz.nothing : Colorz.blackSemi230;
  }
  // --------------------
  static Color? headerEndColor({
    required List<SlideModel>? slides,
  }){

    if (Lister.checkCanLoop(slides) == true){
      return slides![0].midColor;
    }

    else {
      return Colorz.blackSemi230;
    }

  }
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
  /// DEPRECATED : TOO EXPENSIVE
  /*
  static List<BoxShadow> logoShadows(double? logoWidth){
    return <BoxShadow>[
      if (logoWidth != null)
      CustomBoxShadow(
          color: Colorz.black200,
          blurRadius: logoWidth * 0.15,
          style: BlurStyle.outer
      ),
    ];
  }
   */
  // --------------------

  /// AUTHOR LABEL COLORS

  // --------------------
  static Color authorLabelColor({
    required bool showLabel,
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
    required bool followIsOn,
  }){
    return followIsOn == true ? Colorz.yellow255 : Colorz.white20;
  }
  // --------------------
  static Color followIconColor({
    required bool followIsOn,
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
  static Color? footerButtonColor({
    required bool buttonIsOn,
  }) {
    return buttonIsOn ? Colorz.white255 : Colorz.black255;
  }
  // --------------------------------------------------------------------------
  static Color infoButtonColor({
    required double flyerBoxWidth,
    required bool tinyMode,
    required bool isExpanded,
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
  static const Color progressStripOffColor = Colorz.white10;
  static const Color progressStripFadedColor = Colorz.white125;
  static const Color progressStripOnColor = Colorz.white200;
  static const Color progressStripLoadingColor = Colorz.yellow200;
  // --------------------
  static Color progressStripColor({
    required bool isWhite,
    required int numberOfSlides,
    required Color? colorOverride,
  }) {
    final int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;

    final Color _stripColor = !isWhite ?
    progressStripFadedColor
        :
    _numberOfSlides == 0 ? progressStripOffColor
        :
    colorOverride ?? progressStripOnColor;

    return _stripColor;
  }
  // --------------------------------------------------------------------------

}
