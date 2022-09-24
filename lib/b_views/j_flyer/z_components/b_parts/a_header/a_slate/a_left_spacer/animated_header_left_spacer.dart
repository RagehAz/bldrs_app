import 'package:flutter/material.dart';

class AnimatedHeaderLeftSpacer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AnimatedHeaderLeftSpacer({
    @required this.headerLeftSpacerTween,
    @required this.logoMinWidth,
    @required this.logoSizeRationTween,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Animation<double> headerLeftSpacerTween;
  final double logoMinWidth;
  final Animation<double> logoSizeRationTween;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        width: headerLeftSpacerTween.value,
        height: logoMinWidth * logoSizeRationTween.value,
        // color: Colorz.BloodTest,
      ),
    );

  }
/// --------------------------------------------------------------------------
}
