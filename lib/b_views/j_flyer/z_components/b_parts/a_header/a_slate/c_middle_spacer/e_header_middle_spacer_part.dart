import 'package:flutter/material.dart';

class HeaderMiddleSpacerPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderMiddleSpacerPart({
    required this.headerMiddleSpacerWidthTween,
    required this.logoMinWidth,
    required this.logoSizeRatioTween,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Animation<double>? headerMiddleSpacerWidthTween;
  final double logoMinWidth;
  final Animation<double>? logoSizeRatioTween;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        width: headerMiddleSpacerWidthTween?.value ?? 0,
        height: logoMinWidth * (logoSizeRatioTween?.value ?? 1),
      ),
    );
  }

}
