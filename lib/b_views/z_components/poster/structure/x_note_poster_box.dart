import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:basics/mediator/models/dimension_model.dart';

class NotePosterBox extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NotePosterBox({
    required this.width,
    this.child,
    this.color = Colorz.white10,
    super.key
  });
  // --------------------
  final double width;
  final Color color;
  final Widget? child;
  // --------------------

  /// STANDARD WIDTH AND HEIGHT

  // --------
  /// TESTED : WORKS PERFECT
  static double getBoxHeight(double? boxWidth){
    return Dimensions.getHeightByAspectRatio(
        aspectRatio: Standards.posterDimensions.getAspectRatio(),
        width: boxWidth,
    )!;
  }
  // --------------------

  /// ASPECT RATIO

  // --------
  /// TESTED : WORKS PERFECT
  static double getAspectRatio(){
    return Standards.posterDimensions.getAspectRatio()!;
  }
  // --------------------

  /// PADDING

  // --------
  /// TESTED : WORKS PERFECT
  static double getPaddingValue(double boxWidth){
    return boxWidth * 0.05;
  }
  // --------
  /// TESTED : WORKS PERFECT
  static EdgeInsets getPaddings(double boxWidth){
    return EdgeInsets.all(getPaddingValue(boxWidth));
  }
  // --------------------

  /// CLEAR SPACE

  // --------
  /// TESTED : WORKS PERFECT
  static double getClearWidth(double boxWidth){
    return boxWidth - (getPaddingValue(boxWidth) * 2);
  }
  // --------
  /// TESTED : WORKS PERFECT
  static double getClearHeight(double boxWidth){
    return getBoxHeight(boxWidth) - (getPaddingValue(boxWidth) * 2);
  }
  // --------------------

  /// CORNERS

  // --------
  /// TESTED : WORKS PERFECT
  static double getCornerValue(double boxWidth){
    // const double posterCornerValue = Bubble.cornersValue - Ratioz.appBarMargin;
    return boxWidth * 0.03;
  }
  // --------
  /// TESTED : WORKS PERFECT
  static BorderRadius getCorners({
    required double boxWidth,
  }){
    // const BorderRadius posterCorners = BorderRadius.all(Radius.circular(posterCornerValue));
    return Borderers.superCorners(
      corners: getCornerValue(boxWidth),
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: getBoxHeight(width),
      color: Colorz.white10,
      // decoration: BoxDecoration(
        // borderRadius: getCorners(
        //   context: context,
        //   boxWidth: width,
        // ),
      // ),
      alignment: Alignment.center,
      child: child,
    );

  }
  // -----------------------------------------------------------------------------
}
