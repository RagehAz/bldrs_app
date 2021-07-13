import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
enum BottomSheetType {
  Country,
  Province,
  District,
  Language,
  BottomSheet,
}
// -----------------------------------------------------------------------------
/// TASK: should check draggable scrollable sheet
class BldrsBottomSheet extends StatelessWidget {
  final double height;
  final bool draggable;
  final Widget child;

  BldrsBottomSheet({
    this.height,
    this.draggable = true,
    this.child,
});

// -----------------------------------------------------------------------------
  /// one side value only
  double draggerMarginValue(){
    double _draggerHeight = draggerHeight();
    double _draggerZoneHeight = draggerZoneHeight();
    double _draggerMarginValue = (_draggerZoneHeight - _draggerHeight)/2;
    return _draggerMarginValue;
  }
// -----------------------------------------------------------------------------
  double draggerZoneHeight(){
    double _draggerZoneHeight = Ratioz.appBarMargin * 3;
    return _draggerZoneHeight;
  }
// -----------------------------------------------------------------------------
  double draggerHeight(){
    double _draggerZoneHeight = draggerZoneHeight();
    double _draggerHeight = _draggerZoneHeight * 0.35 * 0.5;
    return _draggerHeight;
  }


  @override
  Widget build(BuildContext context) {


    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenHeight(context);
    double _sheetHeight = height == null ? _screenHeight*0.5 : height;
    BorderRadius _sheetBorders = Borderers.superBorderRadius(
        context: context,
        enTopLeft: Ratioz.bottomSheetCorner,
        enBottomLeft: 0,
        enBottomRight: 0,
        enTopRight: Ratioz.bottomSheetCorner
    );

    double _draggerZoneHeight = draggerZoneHeight();
    double _draggerHeight = draggerHeight();
    double _draggerWidth = _screenWidth * 0.35;
    double _draggerCorner = _draggerHeight *0.5;
    double _draggerMarginValue = draggerMarginValue();
    EdgeInsets _draggerMargins = EdgeInsets.symmetric(vertical: _draggerMarginValue);

    double _contentWidth = _screenWidth - (_draggerZoneHeight*2*0.5);
    double _contentHeight  = _sheetHeight - _draggerZoneHeight;
    double _contentCorners = Ratioz.appBarCorner;

    return Container(
      height: _sheetHeight,
      width: _screenWidth,
      decoration: BoxDecoration(
      color: Colorz.White10,
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
                  color: Colorz.White200,
                  borderRadius: Borderers.superBorderAll(context, _draggerCorner),
                ),
              ),

              // --- SHEET CONTENT
              Container(
                width: _contentWidth,
                height: _contentHeight,
                decoration: BoxDecoration(
                  // color: Colorz.WhiteAir,
                  borderRadius: Borderers.superBorderRadius(
                      context: context,
                      enTopLeft: _contentCorners,
                      enBottomLeft: 0,
                      enBottomRight: 0,
                      enTopRight: _contentCorners
                  ),
                  gradient: Colorizer.superHeaderStripGradient(Colorz.White20)
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
// -----------------------------------------------------------------------------
class BottomSlider{
// -----------------------------------------------------------------------------
  static void slideBottomSheet({BuildContext context, double height, bool draggable, Widget child}){
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius:
        Borderers.superBorderRadius(
          context:context,
          enTopLeft:Ratioz.bottomSheetCorner,
          enBottomLeft:0,
          enBottomRight:0,
          enTopRight:Ratioz.bottomSheetCorner,
        )),
        backgroundColor: Colorz.Black255,
        barrierColor: Colorz.Black150,
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
// -----------------------------------------------------------------------------
  static void slideButtonsBottomSheet({
    BuildContext context,
    bool draggable,
    List<Widget> buttons,
    double buttonHeight,
  }){

    double _spacing = buttonHeight * 0.1;
    double _height = (buttonHeight * buttons.length) + (_spacing * buttons.length) + 30 ;

    slideBottomSheet(
      context: context,
      draggable: draggable,
      height: _height,
      child: Column(
        children: <Widget>[

          ...List.generate(buttons.length, (index){
            return
                Column(
                  children: <Widget>[

                    buttons[index],

                    SizedBox(height: _spacing),

                  ],
                );
          }),

        ],
      ),
    );
}
// -----------------------------------------------------------------------------
  static slideStatefulBottomSheet({BuildContext context, double height, bool draggable, Widget Function(BuildContext) builder}){
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: Borderers.superBorderRadius(
          context: context,
          enTopLeft: Ratioz.bottomSheetCorner,
          enBottomLeft: 0,
          enBottomRight: 0,
          enTopRight: Ratioz.bottomSheetCorner
      )),
      backgroundColor: Colorz.Nothing,
      barrierColor: Colorz.Black10,
      enableDrag: draggable,
      elevation: 20,
      isScrollControlled: true,
      context: context,
      builder: builder,
    );
  }
// -----------------------------------------------------------------------------
  static double bottomSheetClearWidth (BuildContext context){
    double _clearWidth = Scale.superScreenWidth(context) - (Ratioz.appBarMargin * 2) - (Ratioz.appBarPadding * 2);
    return
      _clearWidth ; // 0.95 to avoid having the parent container trim buttons shadows
  }
// -----------------------------------------------------------------------------
  /// height ratio is by which factor from 0 to 1 the bottom sheet occupy the space
  /// from screen height
  static double bottomSheetClearHeight (BuildContext context, double heightRatio){
    double _clearHeight =
    // bottom sheet height
    (Scale.superScreenHeight(context) * heightRatio) -
        // dragger height
        BldrsBottomSheet().draggerHeight() -
        // dragger margins
        (BldrsBottomSheet().draggerMarginValue() *2)
    ;
    return _clearHeight;
  }
// -----------------------------------------------------------------------------
}