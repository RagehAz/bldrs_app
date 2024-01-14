import 'package:basics/helpers/space/aligner.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class BldrsAligners {
  // -----------------------------------------------------------------------------
  /// BLDRS ALIGNERS CLASS
  // -----------------------------------------------------------------------------

  const BldrsAligners();

  // -----------------------------------------------------------------------------

  /// POSITION IN RIGHT ALIGNMENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment superTopAlignment(BuildContext context) {

    return Aligner.top(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      // inverse: false,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment superBottomAlignment(BuildContext context) {

    return Aligner.bottom(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      // inverse: false,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment superCenterAlignment(BuildContext context) {

    return Aligner.center(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment superInverseCenterAlignment(BuildContext context) {

    return Aligner.center(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      inverse: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment superInverseTopAlignment(BuildContext context) {

    return Aligner.top(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      inverse: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment superInverseBottomAlignment(BuildContext context) {

    return Aligner.bottom(
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      inverse: true,
    );

  }
  // -----------------------------------------------------------------------------

  /// POSITION IN RIGHT ALIGNMENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static double? rightPositionInLeftAlignmentEn(double? offsetFromRight) {

    return Aligner.rightOffsetInLeftAlignmentEn(
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        offsetFromRight: offsetFromRight
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? leftPositionInLeftAlignmentEn(double? offsetFromLeft) {

    return Aligner.leftOffsetInLeftAlignmentEn(
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        offsetFromLeft: offsetFromLeft
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? rightPositionInRightAlignmentEn(double offsetFromRight) {

    return Aligner.rightOffsetInRightAlignmentEn(
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        offsetFromRight: offsetFromRight
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double? leftPositionInRightAlignmentEn(double offsetFromLeft) {

    return Aligner.leftOffsetInRightAlignmentEn(
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        offsetFromLeft: offsetFromLeft
    );

  }
  // -----------------------------------------------------------------------------
}
