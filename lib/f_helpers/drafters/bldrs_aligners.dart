import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
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
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
      // inverse: false,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment superBottomAlignment(BuildContext context) {

    return Aligner.bottom(
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
      // inverse: false,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment superCenterAlignment(BuildContext context) {

    return Aligner.center(
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment superInverseCenterAlignment(BuildContext context) {

    return Aligner.center(
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
      inverse: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment superInverseTopAlignment(BuildContext context) {

    return Aligner.top(
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
      inverse: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Alignment superInverseBottomAlignment(BuildContext context) {

    return Aligner.bottom(
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
      inverse: true,
    );

  }
  // -----------------------------------------------------------------------------

  /// POSITION IN RIGHT ALIGNMENT

  // --------------------
  /// TESTED : WORKS PERFECT
  static double rightPositionInLeftAlignmentEn(BuildContext context, double offsetFromRight) {

    return Aligner.rightOffsetInLeftAlignmentEn(
        appIsLTR: UiProvider.checkAppIsLeftToRight(context),
        offsetFromRight: offsetFromRight
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double leftPositionInLeftAlignmentEn(BuildContext context, double offsetFromLeft) {

    return Aligner.leftOffsetInLeftAlignmentEn(
        appIsLTR: UiProvider.checkAppIsLeftToRight(context),
        offsetFromLeft: offsetFromLeft
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double rightPositionInRightAlignmentEn(BuildContext context, double offsetFromRight) {

    return Aligner.rightOffsetInRightAlignmentEn(
        appIsLTR: UiProvider.checkAppIsLeftToRight(context),
        offsetFromRight: offsetFromRight
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double leftPositionInRightAlignmentEn(BuildContext context, double offsetFromLeft) {

    return Aligner.leftOffsetInRightAlignmentEn(
        appIsLTR: UiProvider.checkAppIsLeftToRight(context),
        offsetFromLeft: offsetFromLeft
    );

  }
  // -----------------------------------------------------------------------------
}
