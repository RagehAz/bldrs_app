import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
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

class OldFollowAndCallBTs extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OldFollowAndCallBTs({
    @required this.flyerBoxWidth,
    @required this.headerIsExpanded,
    @required this.onFollowTap,
    @required this.followIsOn,
    @required this.onCallTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final bool headerIsExpanded;
  final Function onFollowTap;
  final Function onCallTap;
  final bool followIsOn;
  /// --------------------------------------------------------------------------
  static double getPaddings({double flyerBoxWidth}) {
    return flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
  }
  // --------------------
  static double getBoxHeight({double flyerBoxWidth, bool bzPageIsOn}) {
    final double _headerMainHeight = FlyerBox.headerStripHeight(
        headerIsExpanded: bzPageIsOn,
        flyerBoxWidth: flyerBoxWidth
    );
    final double _headerMainPadding = flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
    final double _followGalleryHeight = _headerMainHeight - (2 * _headerMainPadding);
    return _followGalleryHeight;
  }
  // --------------------
  static double getBoxWidth({double flyerBoxWidth}) {
    return (flyerBoxWidth * Ratioz.xxflyerFollowBtWidth) - 1;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _paddings = getPaddings(flyerBoxWidth: flyerBoxWidth);
    // --------------------
    /// --- FOLLOWERS & GALLERY
    final double followGalleryHeight = getBoxHeight(
        flyerBoxWidth: flyerBoxWidth,
        bzPageIsOn: headerIsExpanded
    );
    // --------------------
    final double followGalleryWidth = getBoxWidth(flyerBoxWidth: flyerBoxWidth);
    // --------------------
    return SizedBox(
      height: followGalleryHeight,
      width: followGalleryWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// --- FOLLOW BUTTON
          OldFollowBT(
            flyerBoxWidth: flyerBoxWidth,
            onFollowTap: onFollowTap,
            tappingUnfollow: () {},
            followOn: followIsOn,
          ),

          /// --- FAKE SPACE PADDING BETWEEN FOLLOW & GALLERY BUTTONS
          SizedBox(
            height: _paddings,
          ),

          /// --- Call BUTTON
          OldCallBT(
            flyerBoxWidth: flyerBoxWidth,
            onCallTap: onCallTap,
          ),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

class OldFollowBT extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OldFollowBT({
    @required this.flyerBoxWidth,
    @required this.onFollowTap,
    @required this.tappingUnfollow,
    @required this.followOn,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final Function onFollowTap;
  final Function tappingUnfollow;
  final bool followOn;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double screenWidth = Scale.superScreenWidth(context);
    // const bool versesShadow = false;
    /// --- FOLLOW BUTTON
    final Color followBTColor = followOn == true ? Colorz.yellow255 : Colorz.white20;
    final double followBTHeight = flyerBoxWidth * Ratioz.xxfollowBTHeight;
    final double followBTWidth = flyerBoxWidth * Ratioz.xxfollowCallWidth;
    // --------------------
    /// --- FOLLOW ICON
    const String followIcon = Iconz.follow;
    final double followIconHeight = followBTHeight * 0.5;
    final double followIconWidth = followIconHeight;
    const String followText = 'phid_follow';
    final Color followTextColor = followOn == true ? Colorz.black230 : Colorz.white255;
    // --------------------
    return GestureDetector(
            onTap: onFollowTap,
            child: Container(
              height: followBTHeight,
              width: followBTWidth,
              decoration: BoxDecoration(
                color: followBTColor,
                boxShadow: Shadower.superFollowBtShadow(followBTHeight),
                borderRadius: Borderers.superFollowOrCallCorners(
                    context: context,
                    flyerBoxWidth: flyerBoxWidth,
                    gettingFollowCorner: true),
              ),

              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  /// BUTTON GRADIENT
                  Container(
                    height: followBTHeight,
                    width: followBTWidth,
                    decoration: BoxDecoration(
                      borderRadius: Borderers.superFollowOrCallCorners(
                          context: context,
                          flyerBoxWidth: flyerBoxWidth,
                          gettingFollowCorner: true),
                      gradient: Colorizer.superFollowBTGradient(),
                    ),
                  ),

                  /// FOLLOW BUTTON CONTENTS
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      /// FOLLOW ICON
                      SizedBox(
                        height: followIconHeight,
                        width: followIconWidth,
                        child: WebsafeSvg.asset(followIcon,
                            color: followOn == true ? Colorz.black230 : Colorz.white255
                        ),
                      ),

                      /// FOLLOW TEXT
                      if (followOn == false)
                        SuperVerse(
                          verse: followText,
                          color: followTextColor,
                          size: 0,
                          scaleFactor: flyerBoxWidth / screenWidth,
                        )

                    ],
                  )

                ],
              ),
            ),
          );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}

class OldCallBT extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OldCallBT({
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
                  verse: 'phid_call',
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
