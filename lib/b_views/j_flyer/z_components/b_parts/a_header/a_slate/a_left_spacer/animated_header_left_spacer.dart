import 'package:flutter/material.dart';

class AnimatedHeaderLeftSpacer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AnimatedHeaderLeftSpacer({
    required this.headerLeftSpacerTween,
    required this.logoMinWidth,
    required this.logoSizeRationTween,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Animation<double>? headerLeftSpacerTween;
  final double logoMinWidth;
  final Animation<double>? logoSizeRationTween;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        width: headerLeftSpacerTween?.value ?? 0,
        height: logoMinWidth * (logoSizeRationTween?.value ?? 1),
        // color: Colorz.BloodTest,
      ),
    );

  }
/// --------------------------------------------------------------------------
}
