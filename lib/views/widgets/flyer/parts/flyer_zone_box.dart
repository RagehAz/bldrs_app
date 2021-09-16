import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/editor/editorPanel.dart';
import 'package:flutter/material.dart';

class FlyerBox extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;
  final Function onFlyerZoneTap;
  final List<Widget> stackWidgets;
  final Function onFlyerZoneLongPress;
  final BzModel editorBzModel;
  final bool editorMode;
  final Key key;

  FlyerBox({
    @required this.superFlyer,
    @required this.flyerBoxWidth, // NEVER DELETE THIS
    @required this.onFlyerZoneTap,
    this.stackWidgets,
    this.onFlyerZoneLongPress,
    this.editorBzModel,
    this.editorMode = false,
    this.key,
  });
// -----------------------------------------------------------------------------
  static double width (BuildContext context, double flyerSizeFactor){
    double _screenWidth = Scale.superScreenWidth(context);
    double _flyerBoxWidth = _screenWidth * flyerSizeFactor;
    return _flyerBoxWidth;
  }
// -----------------------------------------------------------------------------
  static double height (BuildContext context, double flyerBoxWidth){
    double _flyerZoneHeight = sizeFactorByWidth(context, flyerBoxWidth) == 1 ?
    Scale.superScreenHeightWithoutSafeArea(context)
        :
    flyerBoxWidth * Ratioz.xxflyerZoneHeight;
    return _flyerZoneHeight;
  }
// -----------------------------------------------------------------------------
  static double sizeFactorByWidth (BuildContext context, double flyerBoxWidth){
    double _flyerSizeFactor = flyerBoxWidth/Scale.superScreenWidth(context);
    return _flyerSizeFactor;
  }
// -----------------------------------------------------------------------------
  static double sizeFactorByHeight (BuildContext context, double flyerZoneHeight){

    double _flyerBoxWidth = flyerZoneHeight == Scale.superScreenHeightWithoutSafeArea(context) ?
    Scale.superScreenWidth(context) : (flyerZoneHeight / Ratioz.xxflyerZoneHeight);

    double _flyerSizeFactor = sizeFactorByWidth(context, _flyerBoxWidth);

    return _flyerSizeFactor;
  }
// -----------------------------------------------------------------------------
  static double topCornerValue(double flyerBoxWidth){
    return flyerBoxWidth * Ratioz.xxflyerTopCorners;
  }
// -----------------------------------------------------------------------------
  static double bottomCornerValue(double flyerBoxWidth){
    return flyerBoxWidth * Ratioz.xxflyerBottomCorners;
  }
// -----------------------------------------------------------------------------
  static BorderRadius borders(BuildContext context, double flyerBoxWidth){

    double _flyerTopCorners = topCornerValue(flyerBoxWidth);
    double _flyerBottomCorners = bottomCornerValue(flyerBoxWidth);

    return
      Borderers.superBorderOnly(
        context: context,
        enTopLeft: _flyerTopCorners,
        enBottomLeft: _flyerBottomCorners,
        enBottomRight: _flyerBottomCorners,
        enTopRight: _flyerTopCorners
    );
  }
// -----------------------------------------------------------------------------
  static bool isTinyMode (BuildContext context, double flyerBoxWidth){
    bool _tinyMode = flyerBoxWidth < (Scale.superScreenWidth(context) * 0.58) ? true : false; // 0.4 needs calibration
    return _tinyMode;
  }
// -----------------------------------------------------------------------------
  static double headerBoxHeight(bool bzPageIsOn, double flyerBoxWidth){
    double _miniHeaderHeightAtMaxState = flyerBoxWidth * Ratioz.xxflyerHeaderMaxHeight;
    double _miniHeaderHeightAtMiniState = flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight;
    double _headerHeight = bzPageIsOn == true ? _miniHeaderHeightAtMaxState : _miniHeaderHeightAtMiniState;
    return _headerHeight;
  }
// -----------------------------------------------------------------------------
  static double headerStripHeight(bool bzPageIsOn, double flyerBoxWidth){
    double _headerStripHeight = bzPageIsOn == true ? flyerBoxWidth : flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight;
    return _headerStripHeight;
  }
// -----------------------------------------------------------------------------
  static double headerOffsetHeight(double flyerBoxWidth){
    double _headerOffsetHeight = (flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight) - (2 * flyerBoxWidth * Ratioz.xxfollowCallSpacing);
    return _headerOffsetHeight;
  }
// -----------------------------------------------------------------------------
  static double logoWidth(bool bzPageIsOn, double flyerBoxWidth ){
    double _headerMainPadding = flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
    double _headerOffsetWidth = flyerBoxWidth - (2 * _headerMainPadding);
    double _logoWidth = bzPageIsOn == true ? _headerOffsetWidth : (flyerBoxWidth*Ratioz.xxflyerLogoWidth);
    return _logoWidth;
  }
// -----------------------------------------------------------------------------
  static double headerAndProgressHeights(BuildContext, double flyerZoneHeight){
    return
      headerBoxHeight(false, flyerZoneHeight) + flyerZoneHeight * Ratioz.xxProgressBarHeightRatio;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // bool _tinyMode = Scale.superFlyerTinyMode(context, flyerBoxWidth);
    bool _isEditorZone = editorMode;

    double _screenWidth = Scale.superScreenWidth(context);
// -----------------------------------------------------------------------------
    double _flyerZoneHeight = FlyerBox.height(context, flyerBoxWidth);
// -----------------------------------------------------------------------------
    BorderRadius _flyerBorders = borders(context, flyerBoxWidth);
// -----------------------------------------------------------------------------
    double _panelWidth = _isEditorZone == true ?
        _screenWidth - flyerBoxWidth - (Ratioz.appBarMargin * 3) : 0;
// -----------------------------------------------------------------------------
//     String _heroTag =
//         superFlyer?.flyerID == null ?
//             '${Numberers.createUniqueIntFrom(existingValues: [1])}' :
//         'flyerTag : ${superFlyer.flyerID}';
// -----------------------------------------------------------------------------
    double _spacerWidth = _isEditorZone == true ? Ratioz.appBarMargin : 0;
// -----------------------------------------------------------------------------
    return GestureDetector(
      onTap: onFlyerZoneTap,
      onLongPress: onFlyerZoneLongPress,
      key: key,
      child: Container(
        width: flyerBoxWidth + _panelWidth + _spacerWidth,
        height: _flyerZoneHeight,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// EditorPanel
            if (_isEditorZone == true)
              EditorPanel(
                superFlyer: superFlyer,
                panelWidth: _panelWidth,
                bzModel: editorBzModel,
                flyerBoxWidth: flyerBoxWidth,
              ),

            /// SPACER WIDTH
            if (_isEditorZone == true)
              SizedBox(
                width: _spacerWidth,
              ),

            /// flyer zone
            Container(
              width: flyerBoxWidth,
              height: _flyerZoneHeight,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colorz.White20,
                borderRadius: _flyerBorders,
                // boxShadow: Shadowz.flyerZoneShadow(_flyerBoxWidth),
              ),
              child: ClipRRect(
                borderRadius: _flyerBorders,

                child: Container(
                  width: flyerBoxWidth,
                  height: _flyerZoneHeight,
                  alignment: Alignment.topCenter,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: stackWidgets == null ? <Widget>[] : stackWidgets,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

