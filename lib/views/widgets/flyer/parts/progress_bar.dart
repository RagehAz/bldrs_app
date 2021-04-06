import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double flyerZoneWidth;
  final bool barIsOn;
  final int numberOfSlides;
  final int currentSlide;
  final EdgeInsets margins;

  ProgressBar({
    @required this.flyerZoneWidth,
    this.barIsOn = true,
    @required this.numberOfSlides,
    this.currentSlide = 0,
    this.margins,
  });

  @override
  Widget build(BuildContext context) {
    int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;
    // ----------------------------------------------------------------------------
    double _boxWidth = flyerZoneWidth;
    double _boxHeight = flyerZoneWidth * 0.0125;
    EdgeInsets _margins = margins == null ? EdgeInsets.only(top: flyerZoneWidth * 0.27) : margins;
    double _allStripsLength = flyerZoneWidth * 0.895;
    double _allStripsOneSideMargin = (flyerZoneWidth - _allStripsLength) / 2;
    double _aStripThickness = flyerZoneWidth * 0.007;
    double _aStripOneMargin = _aStripThickness / 2;
    double _aStripLength = (_allStripsLength / _numberOfSlides) - (_aStripOneMargin*2);
    Color _stripColor = Colorz.WhiteSmoke;
    double _stripCorner = _aStripThickness * 0.5;
    Color _currentStripColor = numberOfSlides == 0 ? Colorz. WhiteAir : Colorz.WhiteLingerie;
    // ----------------------------------------------------------------------------
    bool _microMode = superFlyerMicroMode(context, flyerZoneWidth);
    // ----------------------------------------------------------------------------
    return
      _microMode == true || barIsOn == false  ? Container() :
      Align(
        alignment: Aligners.superTopAlignment(context),
        child: Container(
          width: _boxWidth,
          height: _boxHeight,
          margin: _margins,
          padding: EdgeInsets.symmetric(horizontal: _allStripsOneSideMargin),
          alignment: Alignment.center,
          child: Stack(
            alignment: Aligners.superCenterAlignment(context),
            children: <Widget>[

              // --- BASE STRIP
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_numberOfSlides, (index) {

                  // --- PROGRESS BAR BASE STRIP
                  return Flexible(
                    child: Container(
                      width: _aStripLength,
                      height: _aStripThickness,
                      margin: EdgeInsets.symmetric(horizontal: _aStripOneMargin),
                      decoration: BoxDecoration(
                          color: _stripColor,
                          borderRadius: Borderers.superBorderAll(context, _stripCorner)),
                    ),
                  );

                }),
              ),

              // --- TOP STRIP
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(currentSlide + 1, (index) {
                  // --- PROGRESS BAR BASE STRIP
                  return Flexible(
                    child: Container(
                      width: _aStripLength,
                      height: _aStripThickness,
                      margin: EdgeInsets.symmetric(horizontal: _aStripOneMargin),
                      decoration: BoxDecoration(
                          color: _currentStripColor,
                          borderRadius: Borderers.superBorderAll(context, _stripCorner)),
                    ),
                  );
                }),
              )

            ],
          ),
    ),
      );
  }
}