import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/colorizers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/shadowers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
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
    /*
       //     const bool _versesShadow = false;
       //     final bool _isTinyMode = OldFlyerBox.isTinyMode(context, flyerBoxWidth);
          */
    // --------------------
    /// call BUTTON
    const Color _callBTColor = Colorz.white10;
    final double _callBTHeight = flyerBoxWidth * Ratioz.xxCallBTHeight;
    final double _callBTWidth = flyerBoxWidth * Ratioz.xxfollowCallWidth;
    // --------------------
    /// call ICON
    const String _callIcon = Iconz.comPhone;
    final double _callIconWidth = flyerBoxWidth * 0.05;
    // --------------------
    final BorderRadius _corners = Borderers.superFollowOrCallCorners(
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
          color: _callBTColor,
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
                gradient: Colorizer.superFollowBTGradient(),
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
                  child: WebsafeSvg.asset(_callIcon),
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
                  scaleFactor: flyerBoxWidth / Scale.superScreenWidth(context),
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
