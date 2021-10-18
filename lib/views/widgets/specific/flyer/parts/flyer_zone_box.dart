import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/editor/editorPanel.dart';
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

  const FlyerBox({
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
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _flyerBoxWidth = _screenWidth * flyerSizeFactor;
    return _flyerBoxWidth;
  }
// -----------------------------------------------------------------------------
  static double height (BuildContext context, double flyerBoxWidth){
    final double _flyerZoneHeight = sizeFactorByWidth(context, flyerBoxWidth) == 1 ?
    Scale.superScreenHeightWithoutSafeArea(context)
        :
    flyerBoxWidth * Ratioz.xxflyerZoneHeight;
    return _flyerZoneHeight;
  }
// -----------------------------------------------------------------------------
  static double sizeFactorByWidth (BuildContext context, double flyerBoxWidth){
    final double _flyerSizeFactor = flyerBoxWidth/Scale.superScreenWidth(context);
    return _flyerSizeFactor;
  }
// -----------------------------------------------------------------------------
  static double sizeFactorByHeight (BuildContext context, double flyerZoneHeight){

    final double _flyerBoxWidth = flyerZoneHeight == Scale.superScreenHeightWithoutSafeArea(context) ?
    Scale.superScreenWidth(context) : (flyerZoneHeight / Ratioz.xxflyerZoneHeight);

    final double _flyerSizeFactor = sizeFactorByWidth(context, _flyerBoxWidth);

    return _flyerSizeFactor;
  }
// -----------------------------------------------------------------------------
  static double heightBySizeFactor({BuildContext context, double flyerSizeFactor}){
    final double _flyerBoxWidth = width(context, flyerSizeFactor);
    final double _flyerZoneHeight = height(context, _flyerBoxWidth);
    return _flyerZoneHeight;
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

    final double _flyerTopCorners = topCornerValue(flyerBoxWidth);
    final double _flyerBottomCorners = bottomCornerValue(flyerBoxWidth);

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
    final bool _tinyMode = flyerBoxWidth < (Scale.superScreenWidth(context) * 0.58) ? true : false; // 0.4 needs calibration
    return _tinyMode;
  }
// -----------------------------------------------------------------------------
  static double headerBoxHeight(bool bzPageIsOn, double flyerBoxWidth){
    final double _miniHeaderHeightAtMaxState = flyerBoxWidth * Ratioz.xxflyerHeaderMaxHeight;
    final double _miniHeaderHeightAtMiniState = flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight;
    final double _headerHeight = bzPageIsOn == true ? _miniHeaderHeightAtMaxState : _miniHeaderHeightAtMiniState;
    return _headerHeight;
  }
// -----------------------------------------------------------------------------
  static double headerStripHeight(bool bzPageIsOn, double flyerBoxWidth){
    final double _headerStripHeight = bzPageIsOn == true ? flyerBoxWidth : flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight;
    return _headerStripHeight;
  }
// -----------------------------------------------------------------------------
  static double headerOffsetHeight(double flyerBoxWidth){
    final double _headerOffsetHeight = (flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight) - (2 * flyerBoxWidth * Ratioz.xxfollowCallSpacing);
    return _headerOffsetHeight;
  }
// -----------------------------------------------------------------------------
  static double logoWidth(bool bzPageIsOn, double flyerBoxWidth ){
    final double _headerMainPadding = flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
    final double _headerOffsetWidth = flyerBoxWidth - (2 * _headerMainPadding);
    final double _logoWidth = bzPageIsOn == true ? _headerOffsetWidth : (flyerBoxWidth*Ratioz.xxflyerLogoWidth);
    return _logoWidth;
  }
// -----------------------------------------------------------------------------
  static double headerAndProgressHeights(BuildContext, double flyerZoneHeight){
    return
      headerBoxHeight(false, flyerZoneHeight) + flyerZoneHeight * Ratioz.xxProgressBarHeightRatio;
  }
// -----------------------------------------------------------------------------
  static const double editorPanelWidth = 50;

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // bool _tinyMode = Scale.superFlyerTinyMode(context, flyerBoxWidth);
    final bool _isEditorZone = editorMode;

    // double _screenWidth = Scale.superScreenWidth(context);
// -----------------------------------------------------------------------------
    final double _flyerZoneHeight = FlyerBox.height(context, flyerBoxWidth);
// -----------------------------------------------------------------------------
    final BorderRadius _flyerBorders = borders(context, flyerBoxWidth);
// -----------------------------------------------------------------------------
    final double _panelWidth = _isEditorZone == true ? editorPanelWidth : 0;
// -----------------------------------------------------------------------------
//     String _heroTag =
//         superFlyer?.flyerID == null ?
//             '${Numberers.createUniqueIntFrom(existingValues: [1])}' :
//         'flyerTag : ${superFlyer.flyerID}';
// -----------------------------------------------------------------------------
    final double _spacerWidth = _isEditorZone == true ? Ratioz.appBarMargin : 0;
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
                color: Colorz.white20,
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

