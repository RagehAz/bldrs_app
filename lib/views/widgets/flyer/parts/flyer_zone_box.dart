import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/editor/editorPanel.dart';
import 'package:flutter/material.dart';

class FlyerZoneBox extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;
  final Function onFlyerZoneTap;
  final List<Widget> stackWidgets;
  final Function onFlyerZoneLongPress;
  final BzModel editorBzModel;
  final bool editorMode;

  FlyerZoneBox({
    @required this.superFlyer,
    @required this.flyerZoneWidth, // NEVER DELETE THIS
    @required this.onFlyerZoneTap,
    this.stackWidgets,
    this.onFlyerZoneLongPress,
    this.editorBzModel,
    this.editorMode = false,
  });

  @override
  Widget build(BuildContext context) {

    bool _tinyMode = Scale.superFlyerTinyMode(context, flyerZoneWidth);
    bool _isEditorZone = editorMode;

    double _screenWidth = Scale.superScreenWidth(context);
// -----------------------------------------------------------------------------
    double _flyerZoneWidth = flyerZoneWidth;
    double _flyerTopCorners = _flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double _flyerBottomCorners = _flyerZoneWidth * Ratioz.xxflyerBottomCorners;
    double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, flyerZoneWidth);
// -----------------------------------------------------------------------------
    BorderRadius _flyerBorders = Borderers.superBorderOnly(
        context: context,
        enTopLeft: _flyerTopCorners,
        enBottomLeft: _flyerBottomCorners,
        enBottomRight: _flyerBottomCorners,
        enTopRight: _flyerTopCorners
    );
// -----------------------------------------------------------------------------
    double _panelWidth = _isEditorZone == true ?
        _screenWidth - _flyerZoneWidth - (Ratioz.appBarMargin * 3) : 0;
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
      child: Container(
        width: _flyerZoneWidth + _panelWidth + _spacerWidth,
        height: _flyerZoneHeight,
        // color: Colorz.BloodTest,

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
                flyerZoneWidth: _flyerZoneWidth,
              ),

            /// SPACER WIDTH
            if (_isEditorZone == true)
              SizedBox(
                width: _spacerWidth,
              ),

            /// flyer zone
            Container(
              width: _flyerZoneWidth,
              height: _flyerZoneHeight,
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                color: Colorz.White20,
                borderRadius: _flyerBorders,
                // boxShadow: Shadowz.flyerZoneShadow(_flyerZoneWidth),
              ),
              child: ClipRRect(
                borderRadius: _flyerBorders,

                child: Container(
                  width: _flyerZoneWidth,
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

