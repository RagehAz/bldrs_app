import 'package:bldrs/b_views/z_components/static_progress_bar/static_strips.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:flutter/material.dart';

class StaticStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StaticStrip({
    @required this.flyerBoxWidth,
    @required this.stripWidth,
    @required this.numberOfSlides,
    @required this.isWhite,
    this.margins,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double stripWidth;
  final int numberOfSlides;
  final EdgeInsets margins;
  final bool isWhite;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _aStripThickness = StaticStrips.stripThickness(flyerBoxWidth);
    // int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;
    // double _stripsTotalLength = Strips.stripsTotalLength(flyerBoxWidth);
    final double _aStripOnePadding = _aStripThickness / 2;
    final double _aStripLength = StaticStrips.oneStripLength(
        flyerBoxWidth: flyerBoxWidth, numberOfStrips: numberOfSlides);
    final double _stripCorner = StaticStrips.stripCornerValue(flyerBoxWidth);
    final Color _stripColor = StaticStrips.stripColor(isWhite: isWhite, numberOfSlides: numberOfSlides);
    // --------------------
    return Container(
      width: stripWidth,
      height: _aStripThickness,
      padding: EdgeInsets.symmetric(horizontal: _aStripOnePadding),
      child: Container(
        width: _aStripLength - (2 * _aStripOnePadding),
        height: _aStripThickness,
        decoration: BoxDecoration(
            color: _stripColor,
            borderRadius: Borderers.superBorderAll(context, _stripCorner)),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
