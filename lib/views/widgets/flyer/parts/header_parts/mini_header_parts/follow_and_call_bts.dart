import 'package:bldrs/ambassadors/services/launch_url.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/colorizers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/painting.dart';
import 'package:websafe_svg/websafe_svg.dart';

class FollowAndCallBTs extends StatelessWidget {

  final double flyerZoneWidth;
  final bool bzPageIsOn;
  final bool followIsOn;
  final Function tappingFollow;
  final String phoneNumber;

  FollowAndCallBTs({
    @required this.flyerZoneWidth,
    @required this.bzPageIsOn,
    @required this.followIsOn,
    @required this.tappingFollow,
    @required this.phoneNumber,
});


  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === === ===
    double headerMainHeight = superHeaderStripHeight(bzPageIsOn, flyerZoneWidth);
    double headerMainPadding = flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding;
    double headerOffsetHeight = headerMainHeight - (2 * headerMainPadding);
    // --- FOLLOWERS & GALLERY --- --- --- --- --- --- --- --- --- --- --- --- ---
    double followGalleryHeight = headerOffsetHeight;
    double followGalleryWidth = flyerZoneWidth * Ratioz.xxflyerFollowBtWidth;
    double fakeSpaceBetweenFollowGallery = headerMainPadding;
    // === === === === === === === === === === === === === === === === === === ===
    return
      bzPageIsOn == true ? Container () :
      Container(
        height: followGalleryHeight,
        width: followGalleryWidth,
        child: Column(
          children: <Widget>[

            // --- FOLLOW BUTTON
            FollowBT(
              flyerZoneWidth: flyerZoneWidth,
              tappingFollow: tappingFollow,
              tappingUnfollow: (){},
              followOn: followIsOn,
            ),

            // --- FAKE SPACE PADDING BETWEEN FOLLOW & GALLERY BUTTONS
            SizedBox(
              height: fakeSpaceBetweenFollowGallery,
            ),

            // --- Call BUTTON
            CallBT(
              flyerZoneWidth: flyerZoneWidth,
              tappingCall: (){
                if (phoneNumber == null){print('no phone here');}
                else
                  {launchCall('tel: $phoneNumber');}
              },
            ),

          ],
        ),
      )
    ;
  }
}

class FollowBT extends StatelessWidget {
  final double flyerZoneWidth;
  final Function tappingFollow;
  final Function tappingUnfollow;
  final bool followOn;

  FollowBT({
    @required this.flyerZoneWidth,
    @required this.tappingFollow,
    @required this.tappingUnfollow,
    @required this.followOn,
  });
  // x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-x-
  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === ===
    double screenWidth = superScreenWidth(context);
    bool miniMode = superFlyerMiniMode(context, flyerZoneWidth) ;
    bool versesDesignMode = false;
    bool versesShadow = false;
    // --- FOLLOW BUTTON --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- FOLLOW BUTTON
    Color followBTColor = followOn == true ? Colorz.Yellow : Colorz.WhiteGlass;
    double followBTHeight = flyerZoneWidth * Ratioz.xxfollowBTHeight;
    double followBTWidth = flyerZoneWidth * Ratioz.xxfollowCallWidth;
    // === === === === === === === === === === === === === === === === === ===
    // --- FOLLOW ICON --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- FOLLOW ICON
    String followIcon = Iconz.Follow;
    double followIconHeight = followBTHeight * 0.5;
    double followIconWidth = followIconHeight;
    String followText = Wordz.follow(context);
    Color followTextColor = followOn == true ? Colorz.BlackBlack : Colorz.White;
    // === === === === === === === === === === === === === === === === === ===
    // void followTap() {
    //   tappingFollow();
    // }
    // === === === === === === === === === === === === === === === === === ===
    // void unFollowTap() {
    //   tappingUnfollow();
    // }
    // === === === === === === === === === === === === === === === === === ===
    return
      miniMode == true ? Container() :
      GestureDetector(
        onTap: tappingFollow,
        child: Container(
          height: followBTHeight,
          width: followBTWidth,
          decoration: BoxDecoration(
            color: followBTColor,
            boxShadow: superFollowBtShadow(followBTHeight),
            borderRadius: superFollowOrCallCorners(context, flyerZoneWidth, true),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              // --- BUTTON GRADIENT
              Container(
                height: followBTHeight,
                width: followBTWidth,
                decoration: BoxDecoration(
                  borderRadius: superFollowOrCallCorners(context, flyerZoneWidth, true),
                  gradient: superFollowBTGradient(),
                ),
              ),

              // --- FOLLOW BUTTON CONTENTS
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  // --- FOLLOW ICON
                  Container(
                    height: followIconHeight,
                    width: followIconWidth,
                    child: WebsafeSvg.asset(followIcon, color: followOn == true ? Colorz.BlackBlack : Colorz.White),
                  ),

                  // --- FOLLOW TEXT
                  followOn == true ? Container() :
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
  final Function tappingCall;

  CallBT({
    @required this.tappingCall,
    @required this.flyerZoneWidth,
  });

  @override
  Widget build(BuildContext context) {
// === === === === === === === === === === === === === === === === === === ===
    bool versesDesignMode = false;
    bool versesShadow = false;
    bool miniMode = superFlyerMiniMode(context, flyerZoneWidth);
    // --- call BUTTON --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    Color callBTColor = Colorz.WhiteAir;
    double callBTHeight = flyerZoneWidth * Ratioz.xxCallBTHeight;
    double callBTWidth = flyerZoneWidth * Ratioz.xxfollowCallWidth;
    // --- call ICON --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    String callIcon = Iconz.ComPhone;
    double callIconWidth = flyerZoneWidth * 0.05;
    // === === === === === === === === === === === === === === === === === === ===
    BorderRadius roundCorners = superFollowOrCallCorners(context, flyerZoneWidth, false);
    // === === === === === === === === === === === === === === === === === === ===
    return
      miniMode == true ? Container() :
      GestureDetector(
        onTap: tappingCall,
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
                  gradient: superFollowBTGradient(),
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
                    color: Colorz.White,
                    italic: false,
                    size: 1,
                    centered: true,
                    weight: VerseWeight.bold,
                    shadow: versesShadow,
                    designMode: versesDesignMode,
                    scaleFactor: flyerZoneWidth/superScreenWidth(context),
                  )

                ],
              ),
            ],
          ),
        ),
      );
  }
}

