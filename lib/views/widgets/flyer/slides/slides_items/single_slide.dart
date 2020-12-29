import 'dart:io';
import 'dart:ui';

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

enum SlideMode {
  View,
  MicroView,
  Editor,
  Creation,
}

class SingleSlide extends StatelessWidget {
  final double flyerZoneWidth;
  final String picture;
  final String title;
  final int shares;
  final int views;
  final int saves;
  final int slideIndex;
  final SlideMode slideMode;
  final File picFile;
  final BoxFit boxFit;

  SingleSlide({
    @required this.flyerZoneWidth,
    this.picture,
    this.title,
    this.shares,
    this.views,
    this.saves,
    this.slideIndex,
    this.slideMode,
    this.picFile,
    this.boxFit = BoxFit.cover,
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
    bool dontBlur =
    picFile == null
    ||
        (boxFit != BoxFit.fitWidth &&
        boxFit != BoxFit.contain &&
        boxFit != BoxFit.scaleDown )
        ?
    true : false;
    // ----------------------------------------------------------------------

    return Container(
      width: flyerZoneWidth,
      height: superFlyerZoneHeight(context, flyerZoneWidth),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: superFlyerCorners(context, flyerZoneWidth),
        image: picture == null ? null : superImage(picture, boxFit),
      ),

      child: ClipRRect(
        borderRadius: superFlyerCorners(context, flyerZoneWidth),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[

            // // --- IMAGE FILE FULL HEIGHT
            dontBlur ? Container() :
            Image.file(
              picFile,
              fit: BoxFit.fitHeight,
              width: flyerZoneWidth,
              height: superFlyerZoneHeight(context, flyerZoneWidth),
              // colorBlendMode: BlendMode.overlay,
              // color: Colorz.WhiteAir,
            ),

            // // --- IMAGE FILE BLUR LAYER
            dontBlur ? Container() :
            ClipRRect( // this ClipRRect fixed a big blur issue,, never ever  delete
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  width: flyerZoneWidth,
                  height: superFlyerZoneHeight(context, flyerZoneWidth),
                  color: Colorz.Nothing,
                ),
              ),
            ),

            // --- IMAGE FILE
            picFile == null ? Container() :
                Image.file(
                    picFile,
                    fit: boxFit,
                    width: flyerZoneWidth,
                    height: superFlyerZoneHeight(context, flyerZoneWidth)
                ),

            // --- SHADOW UNDER PAGE HEADER & OVER PAGE PICTURE
            Container(
              width: flyerZoneWidth,
              height: flyerZoneWidth * 0.65,
              decoration: BoxDecoration(
                  borderRadius: superFlyerCorners(context, flyerZoneWidth),
                  gradient: superSlideGradient(),
              ),
            ),

            microMode == true || title == null ? Container() :
            SlideTitle(
              flyerZoneWidth: flyerZoneWidth,
              verse: title,
              verseSize: slideTitleSize,
              verseColor: Colorz.White,
              tappingVerse: () {
                print('Flyer Title clicked');
                },
            ),

            slideMode != SlideMode.View ? Container() :
            FlyerFooter(
              flyerZoneWidth: flyerZoneWidth,
              views: views,
              shares: shares,
              saves: saves,
              tappingShare: () {shareFlyer(context, theFlyerLink);}, // this will user slide index
            ),

          ],
        ),
      ),
    );
  }
}
