import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/painting.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FollowAndCallBTs extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;

  FollowAndCallBTs({
    @required this.superFlyer,
    @required this.flyerZoneWidth,
});
// -----------------------------------------------------------------------------
  static double getPaddings({double flyerZoneWidth}){
    return flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding;
  }
// -----------------------------------------------------------------------------
  static double getBoxHeight({double flyerZoneWidth, bool bzPageIsOn}){
    double _headerMainHeight = Scale.superHeaderStripHeight(bzPageIsOn, flyerZoneWidth);
    double _headerMainPadding = flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding;
    double _followGalleryHeight = _headerMainHeight - (2 * _headerMainPadding);
    return _followGalleryHeight;
  }
// -----------------------------------------------------------------------------
  static double getBoxWidth({double flyerZoneWidth}){
    return (flyerZoneWidth * Ratioz.xxflyerFollowBtWidth) - 1;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _paddings = getPaddings(flyerZoneWidth: flyerZoneWidth);
    // --- FOLLOWERS & GALLERY --- --- --- --- --- --- --- --- --- --- --- --- ---
    double followGalleryHeight = getBoxHeight(flyerZoneWidth: flyerZoneWidth, bzPageIsOn: superFlyer.nav.bzPageIsOn);
    double followGalleryWidth = getBoxWidth(flyerZoneWidth: flyerZoneWidth);
// -----------------------------------------------------------------------------
    return
      superFlyer.nav.bzPageIsOn == true ? Container () :
      Container(
        height: followGalleryHeight,
        width: followGalleryWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// --- FOLLOW BUTTON
            FollowBT(
              flyerZoneWidth: flyerZoneWidth,
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
              flyerZoneWidth: flyerZoneWidth,
              onCallTap: superFlyer.rec.onCallTap,
            ),

          ],
        ),
      )
    ;
  }
}

class FollowBT extends StatelessWidget {
  final double flyerZoneWidth;
  final Function onFollowTap;
  final Function tappingUnfollow;
  final bool followOn;

  FollowBT({
    @required this.flyerZoneWidth,
    @required this.onFollowTap,
    @required this.tappingUnfollow,
    @required this.followOn,
  });
  // x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-
  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === ===
    double screenWidth = Scale.superScreenWidth(context);
    bool miniMode = Scale.superFlyerMiniMode(context, flyerZoneWidth) ;
    bool versesDesignMode = false;
    bool versesShadow = false;
    // --- FOLLOW BUTTON --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- FOLLOW BUTTON
    Color followBTColor = followOn == true ? Colorz.Yellow255 : Colorz.White20;
    double followBTHeight = flyerZoneWidth * Ratioz.xxfollowBTHeight;
    double followBTWidth = flyerZoneWidth * Ratioz.xxfollowCallWidth;
    // === === === === === === === === === === === === === === === === === ===
    // --- FOLLOW ICON --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- FOLLOW ICON
    String followIcon = Iconz.Follow;
    double followIconHeight = followBTHeight * 0.5;
    double followIconWidth = followIconHeight;
    String followText = Wordz.follow(context);
    Color followTextColor = followOn == true ? Colorz.Black230 : Colorz.White255;
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
      miniMode == true ? Container() :
      GestureDetector(
        onTap: onFollowTap,
        child: Container(
          height: followBTHeight,
          width: followBTWidth,
          decoration: BoxDecoration(
            color: followBTColor,
            boxShadow: superFollowBtShadow(followBTHeight),
            borderRadius: Borderers.superFollowOrCallCorners(context, flyerZoneWidth, true),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// BUTTON GRADIENT
              Container(
                height: followBTHeight,
                width: followBTWidth,
                decoration: BoxDecoration(
                  borderRadius: Borderers.superFollowOrCallCorners(context, flyerZoneWidth, true),
                  gradient: Colorizer.superFollowBTGradient(),
                ),
              ),

              /// FOLLOW BUTTON CONTENTS
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  /// FOLLOW ICON
                  Container(
                    height: followIconHeight,
                    width: followIconWidth,
                    child: WebsafeSvg.asset(followIcon, color: followOn == true ? Colorz.Black230 : Colorz.White255),
                  ),

                  /// FOLLOW TEXT
                  if (followOn == false)
                  SuperVerse(
                    verse: followText,
                    centered: true,
                    color: followTextColor,
                    designMode: versesDesignMode,
                    size: 0,
                    weight: VerseWeight.bold,
                    shadow: versesShadow,
                    italic: false,
                    scaleFactor: flyerZoneWidth/screenWidth,
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
  final double flyerZoneWidth;
  final Function onCallTap;

  CallBT({
    @required this.onCallTap,
    @required this.flyerZoneWidth,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    bool versesDesignMode = false;
    bool versesShadow = false;
    bool miniMode = Scale.superFlyerMiniMode(context, flyerZoneWidth);
    // --- call BUTTON
    Color callBTColor = Colorz.White10;
    double callBTHeight = flyerZoneWidth * Ratioz.xxCallBTHeight;
    double callBTWidth = flyerZoneWidth * Ratioz.xxfollowCallWidth;
    // --- call ICON
    String callIcon = Iconz.ComPhone;
    double callIconWidth = flyerZoneWidth * 0.05;
// -----------------------------------------------------------------------------
    BorderRadius roundCorners = Borderers.superFollowOrCallCorners(context, flyerZoneWidth, false);
// -----------------------------------------------------------------------------
    return
      miniMode == true ? Container() :
      GestureDetector(
        onTap: onCallTap,
        child: Container(
          height: callBTHeight,
          width: callBTWidth,
          decoration: BoxDecoration(
              color: callBTColor,
              boxShadow: superFollowBtShadow(callBTHeight),
              borderRadius: roundCorners
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              // --- BUTTON GRADIENT
              Container(
                height: callBTHeight,
                width: callBTWidth,
                decoration: BoxDecoration(
                  borderRadius: roundCorners,
                  gradient: Colorizer.superFollowBTGradient(),
                ),
              ),

              // --- BUTTON COMPONENTS : ICON, NUMBER, VERSE
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  // --- call ICON
                  Container(
                    height: callIconWidth,
                    width: callIconWidth,
                    margin: EdgeInsets.all(flyerZoneWidth*0.01),
                    child: WebsafeSvg.asset(callIcon),
                  ),


                  SizedBox(
                    width: callIconWidth,
                    height: callIconWidth * 0.1,
                  ),

                  // --- FLYERS TEXT
                  SuperVerse(
                    verse: Wordz.call(context),//'$callText',
                    color: Colorz.White255,
                    italic: false,
                    size: 1,
                    centered: true,
                    weight: VerseWeight.bold,
                    shadow: versesShadow,
                    designMode: versesDesignMode,
                    scaleFactor: flyerZoneWidth/Scale.superScreenWidth(context),
                  )

                ],
              ),
            ],
          ),
        ),
      );
  }
}

