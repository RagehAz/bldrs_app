import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/colorizers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
// ---------------------------------------------------------------------------
void slideBottomSheet({BuildContext context, double height, bool draggable, Widget child}){
    showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: superBorderRadius(context, Ratioz.ddBottomSheetCorner, 0, 0, Ratioz.ddBottomSheetCorner)),
    backgroundColor: Colorz.Nothing,
    barrierColor: Colorz.BlackAir,
    enableDrag: draggable,
    elevation: 20,
    isScrollControlled: true,
    context: context,
    builder: (bCtx){
      return BldrsBottomSheet(
        height: height,
        draggable: draggable,
        child: child,
      );}
    );
}
// ---------------------------------------------------------------------------
class BldrsBottomSheet extends StatelessWidget {
  final double height;
  final bool draggable;
  final Widget child;

  BldrsBottomSheet({
    this.height,
    this.draggable = true,
    this.child,
});

  @override
  Widget build(BuildContext context) {


    double _screenWidth = superScreenWidth(context);
    double _screenHeight = superScreenHeight(context);
    double _sheetHeight = height == null ? _screenHeight*0.5 : height;
    BorderRadius _sheetBorders = superBorderRadius(context, Ratioz.ddBottomSheetCorner, 0, 0, Ratioz.ddBottomSheetCorner);

    double _draggerZoneHeight = Ratioz.ddAppBarMargin * 2;
    double _draggerHeight = _draggerZoneHeight * 0.35 * 0.5;
    double _draggerWidth = _screenWidth * 0.35;
    double _draggerCorner = _draggerHeight *0.5;
    double _draggerMarginValue = (_draggerZoneHeight - _draggerHeight)/2;
    EdgeInsets _draggerMargins = EdgeInsets.symmetric(vertical: _draggerMarginValue);

    double _contentWidth = _screenWidth - (_draggerZoneHeight*2*0.5);
    double _contentHeight  = _sheetHeight - _draggerZoneHeight;
    double _contentCorners = Ratioz.ddAppBarCorner;

    return Container(
      height: _sheetHeight,
      width: _screenWidth,
      decoration: BoxDecoration(
      color: Colorz.WhiteAir,
        borderRadius: _sheetBorders,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          // --- SHADOW LAYER
          Container(
            width: _screenWidth,
            height: _sheetHeight,
            decoration: BoxDecoration(
                borderRadius: _sheetBorders,
                boxShadow: Shadowz.appBarShadow,
            ),
          ),

          // --- BLUR LAYER
          BlurLayer(
            width: _screenWidth,
            height: _sheetHeight,
            borders: _sheetBorders,
          ),

          // --- SHEET CONTENTS
          Column(
            children: <Widget>[

              // --- DRAGGER
              Container(
                width: _draggerWidth,
                height: _draggerHeight,
                margin: _draggerMargins,
                decoration: BoxDecoration(
                  color: Colorz.WhiteLingerie,
                  borderRadius: superBorderAll(context, _draggerCorner),
                ),
              ),

              // --- SHEET CONTENT
              Container(
                width: _contentWidth,
                height: _contentHeight,
                decoration: BoxDecoration(
                  // color: Colorz.WhiteAir,
                  borderRadius: superBorderRadius(context, _contentCorners, 0, 0, _contentCorners),
                  gradient: superHeaderStripGradient(Colorz.WhiteGlass)
                ),
                child: child,
              ),
            ],
          ),

        ],
      ),
    );
  }
}
// ---------------------------------------------------------------------------
double bottomSheetClearWidth (BuildContext context){
  double _clearWidth = superScreenWidth(context) - Ratioz.ddAppBarMargin;
  return
      _clearWidth * 0.95; // 0.95 to avoid having the parent container trim buttons shadows
}
// ---------------------------------------------------------------------------
