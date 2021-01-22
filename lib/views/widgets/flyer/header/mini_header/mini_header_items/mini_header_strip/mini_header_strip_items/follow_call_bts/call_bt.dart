import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/colorizers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:websafe_svg/websafe_svg.dart';

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
