import 'package:flutter/material.dart';

class HeaderBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HeaderBox({
    @required this.tinyMode,
    @required this.onHeaderTap,
    @required this.flyerBoxWidth,
    @required this.headerHeightTween,
    @required this.headerColor,
    @required this.headerBorders,
    @required this.children,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool tinyMode;
  final Function onHeaderTap;
  final double flyerBoxWidth;
  final Animation<double> headerHeightTween;
  final Color headerColor;
  final BorderRadius headerBorders;
  final List<Widget> children;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: tinyMode == true ? null : onHeaderTap,
      child: Container(
        width: flyerBoxWidth,
        height: headerHeightTween.value,
        decoration: BoxDecoration(
          color: headerColor,
          borderRadius: headerBorders,
        ),
        alignment: Alignment.topCenter,
        child: Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: headerBorders,
            child: Stack(
              alignment: Alignment.topCenter,
              children: children,
            ),
          ),
        ),
      ),
    );

  }
}
