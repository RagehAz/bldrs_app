import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'leading_dot.dart';

class RedDot extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const RedDot({
    @required this.labelHeight,
    @required this.labelColor,
    @required this.dotSize,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double labelHeight;
  final Color labelColor;
  final double dotSize;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('the_red_dot'),
      height: labelHeight,
      margin: labelColor == null ?
      EdgeInsets.symmetric(horizontal: labelHeight * 0.2)
          :
      EdgeInsets.symmetric(
          horizontal: labelHeight * 0.05
      ),
      alignment: Alignment.topCenter,
      child: Padding(
        padding: labelColor == null ?
        EdgeInsets.only(top: labelHeight * 0.2)
            :
        EdgeInsets.only(top: labelHeight * 0.05),
        child: LeadingDot.dot(
          dotSize: dotSize,
          color: Colorz.red255,
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
