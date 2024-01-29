import 'package:flutter/material.dart';

class HeaderRightSpacerPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderRightSpacerPart({
    required this.headerRightSpacerTween,
    required this.logoMinWidth,
    required this.logoSizeRatioTween,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Animation<double>? headerRightSpacerTween;
  final double logoMinWidth;
  final Animation<double>? logoSizeRatioTween;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        width: headerRightSpacerTween?.value ?? 0,
        height: logoMinWidth * (logoSizeRatioTween?.value ?? 1),
        // color: Colorz.BloodTest,
      ),
    );

  }
/// --------------------------------------------------------------------------
}
