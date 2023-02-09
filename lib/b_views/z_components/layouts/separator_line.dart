import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';

class SeparatorLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SeparatorLine({
    this.lineIsON = true,
    this.width,
    this.thickness = standardThickness,
    this.color = Colorz.yellow255,
    this.withMargins = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool lineIsON;
  final double width;
  final double thickness;
  final Color color;
  final bool withMargins;
  /// --------------------------------------------------------------------------
  static const double standardThickness = 0.75;
  // --------------------
  static const standardVerticalMarginValue = Ratioz.appBarMargin;
  // --------------------
  static const double getTotalHeight = standardThickness + (2 * standardVerticalMarginValue);
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = width ?? Bubble.clearWidth(context: context);

    return Center(
      child: Container(
        width: _width,
        height: thickness,
        // alignment: Aligners.superCenterAlignment(context),
        margin: withMargins == true ? const EdgeInsets.symmetric(vertical: standardVerticalMarginValue) : null,
        color: lineIsON ? color : null,
        // child: Container(
        //   width: _width * 0.8,
        //   height: 0.25,
        //   color: Colorz.yellow255,
        // ),
      ),
    );
  }
// --------------------------------------------------------------------------
}
