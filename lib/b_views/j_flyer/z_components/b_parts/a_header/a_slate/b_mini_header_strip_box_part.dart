import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:flutter/material.dart';

class MiniHeaderStripBoxPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MiniHeaderStripBoxPart({
    required this.flyerBoxWidth,
    required this.minHeaderHeight,
    required this.logoSizeRatioTween,
    required this.headerLeftSpacerTween,
    required this.tinyMode,
    required this.headerBorders,
    required this.children,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double minHeaderHeight;
  final Animation<double>? logoSizeRatioTween;
  final Animation<double>? headerLeftSpacerTween;
  final bool tinyMode;
  final BorderRadius? headerBorders;
  final List<Widget> children;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _logoSizeRatioTweenWidth = logoSizeRatioTween?.value ?? 1;
    final double _headerLeftSpacerTweenValue = headerLeftSpacerTween?.value ?? 0;

    return Container(
      key: const ValueKey<String>('miniHeaderStrip'),
      width: flyerBoxWidth,
      height: (minHeaderHeight * _logoSizeRatioTweenWidth) + _headerLeftSpacerTweenValue,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: headerLeftSpacerTween?.value ?? 0),
      decoration: BoxDecoration(
        color: tinyMode == true ? Colorz.white50 : Colorz.black80,
        borderRadius: headerBorders,
      ),
      child: SingleChildScrollView(
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
