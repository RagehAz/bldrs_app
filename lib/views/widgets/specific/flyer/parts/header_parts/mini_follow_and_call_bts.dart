import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/drafters/colorizers.dart' as Colorizer;
import 'package:bldrs/controllers/drafters/scalers.dart' as Scale;
import 'package:bldrs/controllers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart' as Wordz;
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FollowAndCallBTs extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;

  const FollowAndCallBTs({
    @required this.superFlyer,
    @required this.flyerBoxWidth,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  static double getPaddings({double flyerBoxWidth}){
    return flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
  }
// -----------------------------------------------------------------------------
  static double getBoxHeight({double flyerBoxWidth, bool bzPageIsOn}){
    final double _headerMainHeight = FlyerBox.headerStripHeight(bzPageIsOn: bzPageIsOn, flyerBoxWidth: flyerBoxWidth);
    final double _headerMainPadding = flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
    final double _followGalleryHeight = _headerMainHeight - (2 * _headerMainPadding);
    return _followGalleryHeight;
  }
// -----------------------------------------------------------------------------
  static double getBoxWidth({double flyerBoxWidth}){
    return (flyerBoxWidth * Ratioz.xxflyerFollowBtWidth) - 1;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _paddings = getPaddings(flyerBoxWidth: flyerBoxWidth);
    /// --- FOLLOWERS & GALLERY
    final double followGalleryHeight = getBoxHeight(flyerBoxWidth: flyerBoxWidth, bzPageIsOn: superFlyer.nav.bzPageIsOn);
    final double followGalleryWidth = getBoxWidth(flyerBoxWidth: flyerBoxWidth);
// -----------------------------------------------------------------------------
    return
      superFlyer.nav.bzPageIsOn == true ? Container () :
      SizedBox(
        height: followGalleryHeight,
        width: followGalleryWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// --- FOLLOW BUTTON
            FollowBT(
              flyerBoxWidth: flyerBoxWidth,
              onFollowTap: superFlyer.rec.onFollowTap,
              tappingUnfollow: (){},
              followOn: superFlyer.rec.followIsOn,
            ),

            /// --- FAKE SPACE PADDING BETWEEN FOLLOW & GALLERY BUTTONS
            SizedBox(
              height: _paddings,
            ),

            /// --- Call BUTTON
            CallBT(
              flyerBoxWidth: flyerBoxWidth,
              onCallTap: superFlyer.rec.onCallTap,
            ),

          ],
        ),
      )
    ;
  }
}

class FollowBT extends StatelessWidget {
  final double flyerBoxWidth;
  final Function onFollowTap;
  final Function tappingUnfollow;
  final bool followOn;

  const FollowBT({
    @required this.flyerBoxWidth,
    @required this.onFollowTap,
    @required this.tappingUnfollow,
    @required this.followOn,
    Key key,
  }) : super(key: key);
  // x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-
  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === ===
    final double screenWidth = Scale.superScreenWidth(context);
    final bool _isTinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth) ;
    // const bool versesShadow = false;
    /// --- FOLLOW BUTTON
    final Color followBTColor = followOn == true ? Colorz.yellow255 : Colorz.white20;
    final double followBTHeight = flyerBoxWidth * Ratioz.xxfollowBTHeight;
    final double followBTWidth = flyerBoxWidth * Ratioz.xxfollowCallWidth;
    // === === === === === === === === === === === === === === === === === ===
    /// --- FOLLOW ICON
    const String followIcon = Iconz.follow;
    final double followIconHeight = followBTHeight * 0.5;
    final double followIconWidth = followIconHeight;
    final String followText = Wordz.follow(context);
    final Color followTextColor = followOn == true ? Colorz.black230 : Colorz.white255;
    // === === === === === === === === === === === === === === === === === ===
    // void followTap() {
    //   onFollowTap();
    // }
    // === === === === === === === === === === === === === === === === === ===
    // void unFollowTap() {
    //   tappingUnfollow();
    // }
    // === === === === === === === === === === === === === === === === === ===
    return
      _isTinyMode == true ? Container() :
      GestureDetector(
        onTap: onFollowTap,
        child: Container(
          height: followBTHeight,
          width: followBTWidth,
          decoration: BoxDecoration(
            color: followBTColor,
            boxShadow: Shadowz.superFollowBtShadow(followBTHeight),
            borderRadius: Borderers.superFollowOrCallCorners(
                context: context,
                flyerBoxWidth: flyerBoxWidth,
                gettingFollowCorner: true
            ),
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
                      gettingFollowCorner: true
                  ),
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
                    child: WebsafeSvg.asset(followIcon, color: followOn == true ? Colorz.black230 : Colorz.white255),
                  ),

                  /// FOLLOW TEXT
                  if (followOn == false)
                  SuperVerse(
                    verse: followText,
                    color: followTextColor,
                    size: 0,
                    scaleFactor: flyerBoxWidth/screenWidth,
                  )

                ],
              )
            ],
          ),
        ),
      );
  }
}

class CallBT extends StatelessWidget {
  final double flyerBoxWidth;
  final Function onCallTap;

  const CallBT({
    @required this.onCallTap,
    @required this.flyerBoxWidth,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
//     const bool _versesShadow = false;
    final bool _isTinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);
    /// call BUTTON
    const Color _callBTColor = Colorz.white10;
    final double _callBTHeight = flyerBoxWidth * Ratioz.xxCallBTHeight;
    final double _callBTWidth = flyerBoxWidth * Ratioz.xxfollowCallWidth;
    /// call ICON
    const String _callIcon = Iconz.comPhone;
    final double _callIconWidth = flyerBoxWidth * 0.05;
// -----------------------------------------------------------------------------
    final BorderRadius _corners = Borderers.superFollowOrCallCorners(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        gettingFollowCorner: false
    );
// -----------------------------------------------------------------------------
    return
      _isTinyMode == true ? Container() :
      GestureDetector(
        onTap: onCallTap,
        child: Container(
          height: _callBTHeight,
          width: _callBTWidth,
          decoration: BoxDecoration(
              color: _callBTColor,
              boxShadow: Shadowz.superFollowBtShadow(_callBTHeight),
              borderRadius: _corners
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

                  /// call ICON
                  Container(
                    height: _callIconWidth,
                    width: _callIconWidth,
                    margin: EdgeInsets.all(flyerBoxWidth*0.01),
                    child: WebsafeSvg.asset(_callIcon),
                  ),


                  SizedBox(
                    width: _callIconWidth,
                    height: _callIconWidth * 0.1,
                  ),

                  /// FLYERS TEXT
                  SuperVerse(
                    verse: Wordz.call(context),
                    size: 1,
                    scaleFactor: flyerBoxWidth/Scale.superScreenWidth(context),
                  )

                ],
              ),
            ],
          ),
        ),
      );
  }
}
