import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class CallButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CallButton({
    @required this.onCallTap,
    @required this.flyerBoxWidth,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Function onCallTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _callBTHeight = FlyerDim.callButtonHeight(flyerBoxWidth);
    final double _callBTWidth = FlyerDim.followAndCallBoxWidth(flyerBoxWidth);
    // --------------------
    final double _callIconWidth = flyerBoxWidth * 0.05;
    // --------------------
    final BorderRadius _corners = FlyerDim.superFollowOrCallCorners(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        gettingFollowCorner: false
    );
    // --------------------
    return GestureDetector(
      onTap: onCallTap,
      child: Container(
        height: _callBTHeight,
        width: _callBTWidth,
        decoration: BoxDecoration(
          color: FlyerColors.callButtonColor,
          boxShadow: Shadower.superFollowBtShadow(_callBTHeight),
          borderRadius: _corners,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            /// BUTTON GRADIENT
            Container(
              height: _callBTHeight,
              width: _callBTWidth,
              decoration: BoxDecoration(
                borderRadius: _corners,
                gradient: FlyerColors.followButtonGradient,
              ),
            ),

            /// BUTTON COMPONENTS : ICON, NUMBER, VERSE
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                /// CALL ICON
                Container(
                  height: _callIconWidth,
                  width: _callIconWidth,
                  margin: EdgeInsets.all(flyerBoxWidth * 0.01),
                  child: WebsafeSvg.asset(Iconz.comPhone),
                ),

                SizedBox(
                  width: _callIconWidth,
                  height: _callIconWidth * 0.1,
                ),

                /// FLYERS TEXT
                SuperVerse(
                  verse: const Verse(
                    text: 'phid_call',
                    translate: true,
                  ),
                  size: 1,
                  scaleFactor: FlyerDim.flyerFactorByFlyerWidth(context, flyerBoxWidth),
                )

              ],
            ),
          ],
        ),
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}