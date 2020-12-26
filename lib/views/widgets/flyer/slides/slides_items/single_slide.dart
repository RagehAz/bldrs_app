import 'package:bldrs/models/flyer_link_model.dart';
import 'package:bldrs/view_brains/controllers/flyer_controllers.dart';
import 'package:bldrs/view_brains/drafters/borderers.dart';
import 'package:bldrs/view_brains/drafters/colorizers.dart';
import 'package:bldrs/view_brains/drafters/imagers.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'footer.dart';
import 'slide_headline.dart';

class SingleSlide extends StatelessWidget {
  final double flyerZoneWidth;
  final String picture;
  final String title;
  final int shares;
  final int views;
  final int saves;
  final int slideIndex;

  SingleSlide({
    @required this.flyerZoneWidth,
    @required this.picture,
    @required this.title,
    @required this.shares,
    @required this.views,
    @required this.saves,
    @required this.slideIndex,
  });

  @override
  Widget build(BuildContext context) {

    // ----------------------------------------------------------------------
    double screenWidth = superScreenWidth(context);
    // ----------------------------------------------------------------------
    bool microMode = superFlyerMicroMode(context, flyerZoneWidth);
    // ----------------------------------------------------------------------
    int slideTitleSize =
    flyerZoneWidth <= screenWidth && flyerZoneWidth > (screenWidth*0.75) ? 4 :
    flyerZoneWidth <= (screenWidth*0.75) && flyerZoneWidth > (screenWidth*0.5) ? 3 :
        flyerZoneWidth <= (screenWidth*0.5) && flyerZoneWidth > (screenWidth*0.25) ? 2 :
        flyerZoneWidth <= (screenWidth*0.25) && flyerZoneWidth > (screenWidth*0.1) ? 1 : 0
    ;
    // ----------------------------------------------------------------------
    FlyerLink theFlyerLink = FlyerLink(flyerLink: 'flyer @ index: $slideIndex', description: 'flyer to be shared aho');
    // ----------------------------------------------------------------------

    return Container(
      width: flyerZoneWidth,
      height: superFlyerZoneHeight(context, flyerZoneWidth),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: superFlyerCorners(context, flyerZoneWidth),
        image: superImage(picture),
      ),

      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          // --- SHADOW UNDER PAGE HEADER & OVER PAGE PICTURE
          Container(
            width: flyerZoneWidth,
            height: flyerZoneWidth * 0.65,
            decoration: BoxDecoration(
                borderRadius: superFlyerCorners(context, flyerZoneWidth),
                gradient: superSlideGradient(),
            ),
          ),

          microMode == true ? Container() :
          SlideTitle(
            flyerZoneWidth: flyerZoneWidth,
            verse: title,
            verseSize: slideTitleSize,
            verseColor: Colorz.White,
            tappingVerse: () {
              print('Flyer Title clicked');
              },
          ),

          FlyerFooter(
            flyerZoneWidth: flyerZoneWidth,
            views: views,
            shares: shares,
            saves: saves,
            tappingShare: () {shareFlyer(context, theFlyerLink);}, // this will user slide index
          ),

        ],
      ),
    );
  }
}
