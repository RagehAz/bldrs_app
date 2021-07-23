import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
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
    double _allStripsLength = flyerZoneWidth * 0.895;
    double _aStripThickness = flyerZoneWidth * 0.007;
    double _aStripOnePadding = _aStripThickness / 2;
    double _aStripLength = (_allStripsLength / _numberOfSlides);
    double _stripCorner = _aStripThickness * 0.5;
    Color _stripColor = !isWhite ? Colorz.White80 : numberOfSlides == 0 ? Colorz. White10 : Colorz.White200;
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
