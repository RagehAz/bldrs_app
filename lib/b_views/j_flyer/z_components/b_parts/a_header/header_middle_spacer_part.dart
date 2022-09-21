import 'package:flutter/material.dart';

class HeaderMiddleSpacerPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderMiddleSpacerPart({
    @required this.headerMiddleSpacerWidthTween,
    @required this.logoMinWidth,
    @required this.logoSizeRatioTween,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Animation<double> headerMiddleSpacerWidthTween;
  final double logoMinWidth;
  final Animation<double> logoSizeRatioTween;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        width: headerMiddleSpacerWidthTween.value,
        height: logoMinWidth * logoSizeRatioTween.value,
      ),
    );
  }

}
