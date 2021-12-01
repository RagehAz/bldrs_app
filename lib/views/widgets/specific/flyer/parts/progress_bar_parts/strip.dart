import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/progress_bar_parts/strips.dart';
import 'package:flutter/material.dart';

class Strip extends StatelessWidget {
  final double flyerBoxWidth;
  final double stripWidth;
  final int numberOfSlides;
  final EdgeInsets margins;
  final bool isWhite;

  const Strip({
    @required this.flyerBoxWidth,
    @required this.stripWidth,
    @required this.numberOfSlides,
    @required this.isWhite,
    this.margins,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;
// -----------------------------------------------------------------------------
//     double _stripsTotalLength = Strips.stripsTotalLength(flyerBoxWidth);
    final double _aStripThickness = Strips.stripThickness(flyerBoxWidth);
    final double _aStripOnePadding = _aStripThickness / 2;
    final double _aStripLength = Strips.oneStripLength(flyerBoxWidth: flyerBoxWidth, numberOfStrips: numberOfSlides);
    final double _stripCorner = Strips.stripCornerValue(flyerBoxWidth);
    final Color _stripColor = Strips.stripColor(isWhite: isWhite, numberOfSlides: numberOfSlides);
// -----------------------------------------------------------------------------

    return

      Container(
        width: stripWidth,
        height: _aStripThickness,
        padding: EdgeInsets.symmetric(horizontal: _aStripOnePadding),
        child: Container(
          width: _aStripLength - (2 * _aStripOnePadding),
          height: _aStripThickness,
          decoration: BoxDecoration(
              color: _stripColor,
              borderRadius: Borderers.superBorderAll(context, _stripCorner)
          ),
        ),
      );
  }
}
