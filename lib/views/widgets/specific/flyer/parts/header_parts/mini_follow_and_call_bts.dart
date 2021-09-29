import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/painting.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FollowAndCallBTs extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;

  FollowAndCallBTs({
    @required this.superFlyer,
    @required this.flyerBoxWidth,
});
// -----------------------------------------------------------------------------
  static double getPaddings({double flyerBoxWidth}){
    return flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
  }
// -----------------------------------------------------------------------------
  static double getBoxHeight({double flyerBoxWidth, bool bzPageIsOn}){
    double _headerMainHeight = FlyerBox.headerStripHeight(bzPageIsOn, flyerBoxWidth);
    double _headerMainPadding = flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding;
    double _followGalleryHeight = _headerMainHeight - (2 * _headerMainPadding);
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
    double _paddings = getPaddings(flyerBoxWidth: flyerBoxWidth);
    // --- FOLLOWERS & GALLERY --- --- --- --- --- --- --- --- --- --- --- --- ---
    double followGalleryHeight = getBoxHeight(flyerBoxWidth: flyerBoxWidth, bzPageIsOn: superFlyer.nav.bzPageIsOn);
    double followGalleryWidth = getBoxWidth(flyerBoxWidth: flyerBoxWidth);
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

  FollowBT({
    @required this.flyerBoxWidth,
    @required this.onFollowTap,
    @required this.tappingUnfollow,
    @required this.followOn,
  });
  // x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-
  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === ===
    double screenWidth = Scale.superScreenWidth(context);
    bool _isTinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth) ;
    bool versesDesignMode = false;
    bool versesShadow = false;
    // --- FOLLOW BUTTON --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- FOLLOW BUTTON
    Color followBTColor = followOn == true ? Colorz.Yellow255 : Colorz.White20;
    double followBTHeight = flyerBoxWidth * Ratioz.xxfollowBTHeight;
    double followBTWidth = flyerBoxWidth * Ratioz.xxfollowCallWidth;
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
      _isTinyMode == true ? Container() :
      GestureDetector(
        onTap: onFollowTap,
        child: Container(
          height: followBTHeight,
          width: followBTWidth,
          decoration: BoxDecoration(
            color: followBTColor,
            boxShadow: superFollowBtShadow(followBTHeight),
            borderRadius: Borderers.superFollowOrCallCorners(context, flyerBoxWidth, true),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              /// BUTTON GRADIENT
              Container(
                height: followBTHeight,
                width: followBTWidth,
                decoration: BoxDecoration(
                  borderRadius: Borderers.superFollowOrCallCorners(context, flyerBoxWidth, true),
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

  CallBT({
    @required this.onCallTap,
    @required this.flyerBoxWidth,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    bool versesDesignMode = false;
    bool versesShadow = false;
    bool isTinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);
    // --- call BUTTON
    Color callBTColor = Colorz.White10;
    double callBTHeight = flyerBoxWidth * Ratioz.xxCallBTHeight;
    double callBTWidth = flyerBoxWidth * Ratioz.xxfollowCallWidth;
    // --- call ICON
    String callIcon = Iconz.ComPhone;
    double callIconWidth = flyerBoxWidth * 0.05;
// -----------------------------------------------------------------------------
    BorderRadius roundCorners = Borderers.superFollowOrCallCorners(context, flyerBoxWidth, false);
// -----------------------------------------------------------------------------
    return
      isTinyMode == true ? Container() :
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
                    margin: EdgeInsets.all(flyerBoxWidth*0.01),
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

