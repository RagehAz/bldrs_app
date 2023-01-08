import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'leading_dot.dart';

class RedDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const RedDot({
    @required this.lineHeight,
    @required this.labelColor,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double lineHeight;
  final Color labelColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('the_red_dot'),
      height: lineHeight,
      margin: labelColor == null ?
      EdgeInsets.symmetric(horizontal: lineHeight * 0.2)
          :
      EdgeInsets.symmetric(horizontal: lineHeight * 0.02),
      alignment: Alignment.topCenter,
      child: Padding(
        padding: labelColor == null ?
        EdgeInsets.only(top: lineHeight * 0.2)
            :
        EdgeInsets.only(top: lineHeight * 0.05),
        child: LeadingDot.dot(
          dotSize: lineHeight * 0.15,
          color: Colorz.red255,
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
