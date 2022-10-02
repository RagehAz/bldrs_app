import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class DotSeparator extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DotSeparator({
    this.bottomMarginIsOn = true,
    this.color = Colorz.grey80,
    this.boxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool bottomMarginIsOn;
  final Color color;
  final double boxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double screenWidth = boxWidth ?? Scale.superScreenWidth(context);

    return Container(
      width: screenWidth,
      height: 15,
      alignment: Alignment.center,
      margin: bottomMarginIsOn ? const EdgeInsets.only(bottom: 10) : EdgeInsets.zero,
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
  /// --------------------------------------------------------------------------
}
