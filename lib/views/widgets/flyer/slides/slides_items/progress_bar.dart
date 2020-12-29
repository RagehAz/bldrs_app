import 'package:bldrs/view_brains/drafters/aligners.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double flyerZoneWidth;
  final bool barIsOn;
  final int numberOfSlides;
  final int currentSlide;

  ProgressBar({
    @required this.flyerZoneWidth,
    this.barIsOn = true,
    @required this.numberOfSlides,
    this.currentSlide = 0,
  });

  @override
  Widget build(BuildContext context) {
    int _numberOfSlides = numberOfSlides == 0 ? 1 : numberOfSlides;
    // ----------------------------------------------------------------------------
    double boxWidth = flyerZoneWidth;
    double boxHeight = flyerZoneWidth * 0.0125;
    EdgeInsets boxTopMargin = EdgeInsets.only(top: flyerZoneWidth * 0.27);
    double allStripsLength = flyerZoneWidth * 0.895;
    double allStripsOneSideMargin = (flyerZoneWidth - allStripsLength) / 2;
    double aStripThickness = flyerZoneWidth * 0.007;
    double aStripOneMargin = aStripThickness / 2;
    double aStripLength = (allStripsLength / _numberOfSlides) - (aStripOneMargin*2);
    Color stripColor = Colorz.WhiteSmoke;
    double stripCorner = aStripThickness * 0.5;
    Color currentStripColor = numberOfSlides == 0 ? Colorz. WhiteAir : Colorz.WhiteLingerie;
    // ----------------------------------------------------------------------------
    bool microMode = superFlyerMicroMode(context, flyerZoneWidth);
    // ----------------------------------------------------------------------------
    return
      microMode == true || barIsOn == false  ? Container() :
      Align(
        alignment: superTopAlignment(context),
        child: Container(
          width: boxWidth,
          height: boxHeight,
          margin: boxTopMargin,
          padding: EdgeInsets.symmetric(horizontal: allStripsOneSideMargin),
          alignment: Alignment.center,
          child: Stack(
            alignment: superCenterAlignment(context),
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
                      width: aStripLength,
                      height: aStripThickness,
                      margin: EdgeInsets.symmetric(horizontal: aStripOneMargin),
                      decoration: BoxDecoration(
                          color: stripColor,
                          borderRadius: BorderRadius.all(Radius.circular(stripCorner))),
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
                      width: aStripLength,
                      height: aStripThickness,
                      margin: EdgeInsets.symmetric(horizontal: aStripOneMargin),
                      decoration: BoxDecoration(
                          color: currentStripColor,
                          borderRadius: BorderRadius.all(Radius.circular(stripCorner))),
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