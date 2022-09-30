import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
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
    final double _aStripThickness = FlyerDim.progressStripThickness(flyerBoxWidth);

    final double _aStripOnePadding = _aStripThickness / 2;

    final double _aStripLength = FlyerDim.progressStripLength(
        flyerBoxWidth: flyerBoxWidth,
        numberOfStrips: numberOfSlides,
    );

    final double _stripCorner = FlyerDim.progressStripCornerValue(flyerBoxWidth);
    // --------------------
    return Container(
      width: stripWidth,
      height: _aStripThickness,
      padding: EdgeInsets.symmetric(horizontal: _aStripOnePadding),
      child: Container(
        width: _aStripLength - (2 * _aStripOnePadding),
        height: _aStripThickness,
        decoration: BoxDecoration(
            color: FlyerColors.progressStripColor(
                isWhite: isWhite,
                numberOfSlides: numberOfSlides,
            ),
            borderRadius: Borderers.cornerAll(context, _stripCorner),
        ),
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
