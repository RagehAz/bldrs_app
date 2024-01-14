import 'dart:core';

import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/device_checker.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class Iconizer {
  // -----------------------------------------------------------------------------

  const Iconizer();

  // -----------------------------------------------------------------------------

  /// ARROW

  // --------------------
  /// TESTED : WORKS PERFECT
  static String superArrowENRight(BuildContext context) {

    if (Localizer.textDirection() == 'ltr') {
      return Iconz.arrowRight;
    }

    else {
      return Iconz.arrowLeft;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String superArrowENLeft(BuildContext context) {

    if (Localizer.textDirection() == 'ltr') {
      return Iconz.arrowLeft;
    }

    else {
      return Iconz.arrowRight;
    }

  }
  // -----------------------------------------------------------------------------

  /// COLORED ARROW

  // --------------------
  /// TESTED : WORKS PERFECT
  static String superYellowArrowENRight(BuildContext context) {

    if (Localizer.textDirection() == 'ltr') {
      return Iconz.arrowYellowRight;
    }

    else {
      return Iconz.arrowYellowLeft;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String superYellowArrowENLeft(BuildContext context) {

    if (Localizer.textDirection() == 'ltr') {
      return Iconz.arrowYellowLeft;
    }

    else {
      return Iconz.arrowYellowRight;
    }

  }
  // -----------------------------------------------------------------------------

  /// BACK ICON

  // --------------------
  /// TESTED : WORKS PERFECT
  static String superBackIcon(BuildContext context) {
    return UiProvider.checkAppIsLeftToRight() ?
    Iconz.back
        :
    Iconz.backArabic;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String superInverseBackIcon(BuildContext context) {
    return UiProvider.checkAppIsLeftToRight() ?
    Iconz.backArabic
        :
    Iconz.back;
  }
  // -----------------------------------------------------------------------------

  /// SHARE ICON

  // --------------------
  /// TESTED : WORKS PERFECT
  static String shareAppIcon(){

    String _shareIcon = Iconz.share;

    if (DeviceChecker.deviceIsIOS() == true){
      _shareIcon = Iconz.comApple;
    }

    if (DeviceChecker.deviceIsAndroid() == true){
      _shareIcon = Iconz.comGooglePlay;
    }

    return _shareIcon;
  }
  // -----------------------------------------------------------------------------
}
