import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/numberers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
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

  FlyerZoneBox({
    @required this.superFlyer,
    @required this.flyerZoneWidth, // NEVER DELETE THIS
    @required this.onFlyerZoneTap,
    this.stackWidgets,
    this.onFlyerZoneLongPress,
    this.editorBzModel,
  });

  @override
  Widget build(BuildContext context) {

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
    double _panelWidth =
        editorBzModel == null ? 0 :
        _screenWidth - _flyerZoneWidth - (Ratioz.appBarMargin * 3);
// -----------------------------------------------------------------------------
    String _heroTag =
        superFlyer.flyerID == null ?
            '${Numberers.createUniqueIntFrom(existingValues: [1])}' :
        'flyerTag : ${superFlyer.flyerID}';
// -----------------------------------------------------------------------------
    double _spacerWidth = editorBzModel == null ? 0 : Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
    return GestureDetector(
      onTap: onFlyerZoneTap,
      onLongPress: onFlyerZoneLongPress,
      child: Container(
        width: _flyerZoneWidth + _panelWidth + _spacerWidth,
        height: _flyerZoneHeight,
        // color: Colorz.BloodTest,

        child: Row(
          mainAxisAlignment: editorBzModel == null ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// EditorPanel
            if (editorBzModel != null)
              EditorPanel(
                superFlyer: superFlyer,
                panelWidth: _panelWidth,
                bzModel: editorBzModel,
                flyerZoneWidth: _flyerZoneWidth,
              ),

            /// SPACER WIDTH
            if (editorBzModel != null)
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

