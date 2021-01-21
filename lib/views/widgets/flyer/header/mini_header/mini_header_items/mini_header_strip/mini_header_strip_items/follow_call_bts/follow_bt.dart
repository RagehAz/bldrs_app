import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/colorizers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/localization/localization_constants.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:websafe_svg/websafe_svg.dart';

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
    String followText = translate(context, 'Follow');
    Color followTextColor = followOn == true ? Colorz.BlackBlack : Colorz.White;
    // === === === === === === === === === === === === === === === === === ===
    void followTap() {
      tappingFollow();
    }
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
