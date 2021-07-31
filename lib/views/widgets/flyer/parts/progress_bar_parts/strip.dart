import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/flyer/parts/progress_bar_parts/strips.dart';
import 'package:flutter/material.dart';

class Strip extends StatelessWidget {
  final double flyerZoneWidth;
  final double stripWidth;
  final int numberOfSlides;
  final EdgeInsets margins;
  final bool isWhite;

  Strip({
    @required this.flyerZoneWidth,
    @required this.stripWidth,
    @required this.numberOfSlides,
    this.margins,
    @required this.isWhite,
  });

  @override
  Widget build(BuildContext context) {
    int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;
// -----------------------------------------------------------------------------
    double _stripsTotalLength = Strips.stripsTotalLength(flyerZoneWidth);
    double _aStripThickness = Strips.stripThickness(flyerZoneWidth);
    double _aStripOnePadding = _aStripThickness / 2;
    double _aStripLength = Strips.oneStripLength(flyerZoneWidth: flyerZoneWidth, numberOfStrips: numberOfSlides);
    double _stripCorner = Strips.stripCornerValue(flyerZoneWidth);
    Color _stripColor = Strips.stripColor(isWhite: isWhite, numberOfSlides: numberOfSlides);
// -----------------------------------------------------------------------------

    /// DESIGN MODE
    bool _designMode = false;

    return
      _designMode == true ?
      Stack(
        children: <Widget>[

          if(isWhite == true)
            Container(
              width: _aStripLength,
              height: _aStripThickness,
              color: Colorz.Red255,
            ),

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
          ),

        ],
      )

          :

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
