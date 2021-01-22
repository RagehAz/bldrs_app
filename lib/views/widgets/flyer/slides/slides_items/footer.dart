import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:flutter/material.dart';
import 'footer_items/ff_button.dart';
import 'footer_items/ff_counters.dart';

class FlyerFooter extends StatelessWidget {
  final double flyerZoneWidth;
  final int shares;
  final int views;
  final int saves;
  final Function tappingShare;

  FlyerFooter({
    @required this.flyerZoneWidth,
    @required this.shares,
    @required this.views,
    @required this.saves,
    @required this.tappingShare,
  });

  // FlyerLink theFlyerLink = FlyerLink(flyerLink: 'flyer', description: 'flyer to be shared aho');

  @override
  Widget build(BuildContext context) {
    // === === === === === === === === === === === === === === === === === === === === === === === === === === === ===

    // ----------------------------------------------------------------------
    // double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double _flyerZoneWidth = flyerZoneWidth;
    double flyerBottomCorners = flyerZoneWidth * Ratioz.xxflyerBottomCorners;
    // ----------------------------------------------------------------------
    bool miniMode = flyerZoneWidth < screenWidth * 0.75 ? true : false ;

    // --- SHARE & SAVE BUTTONS --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SHARE & SAVE BUTTONS
    double footerBTMargins = flyerZoneWidth * 0.025; //
    double footerBTRadius = flyerBottomCorners - footerBTMargins;
    dynamic footerBTColor = Colorz.GreySmoke;
    String shareBTIcon = Iconz.Share;
    String shareBTVerse = Wordz.send(context);
    // String saveBTIcon = ankhOn == true ? Iconz.SaveOn : Iconz.SaveOff;
    // String saveBTVerse = ankhOn == true ? translate(context, 'Saved') :
    // Wordz.save(context);
    // dynamic saveBTColor = ankhOn == true ? Colorz.SkyDarkBlue : footerBTColor;


    // --- FLYER FOOTER CONTAINER--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- FLYER FOOTER
    double flyerFooterWidth =
        // flyerZoneWidth == MediaQuery.of(context).size.width ?
        // (flyerZoneWidth-(flyerZoneWidth * Ratioz.xxflyerMainMargins * 2 ))
        //     : // * only 1 because it starts from bottom left of the flyer neglecting flyer's left margin from screen boarder kalb
    flyerZoneWidth
    ;
    double flyerFooterHeight = (2 * footerBTMargins) + (2 * footerBTRadius);
    dynamic flyerFooterColor = Colorz.Nothing;

    // --- FLYER FOOTER
    return Align(
      alignment: Alignment.bottomCenter,
      // --- FLYER FOOTER BOX
      child: Container(
        width: flyerFooterWidth,
        height: flyerFooterHeight,
        color: flyerFooterColor,

        // --- FLYER FOOTER COMPONENTS
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // --- BOTTOM SHADOW
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(flyerBottomCorners),
                    bottomRight: Radius.circular(flyerBottomCorners),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colorz.BlackNothing,
                        Colorz.BlackPlastic,
                        Colorz.BlackBlack
                      ],
                      stops: [
                        0.35,
                        0.85,
                        1
                      ])),
            ),
          miniMode == true ? Container() :
            // --- SHARE BUTTON
            Positioned(
              right: Wordz.textDirection(context) == 'ltr' ? null : 0,
              left: Wordz.textDirection(context) == 'ltr' ? 0 : null,
              bottom: 0,
              child: FlyerFooterBT(
                flyerZoneWidth: flyerZoneWidth,
                buttonVerse: shareBTVerse,
                buttonColor: footerBTColor,
                buttonIcon: shareBTIcon,
                buttonMargins: footerBTMargins,
                buttonRadius: footerBTRadius,
                tappingButton: tappingShare,

                //() => share(context, theFlyerLink),
              ),
            ),

            // --- FLYER COUNTERS
            Positioned(
              bottom: 0,
              child: _flyerZoneWidth < MediaQuery.of(context).size.width * 0.75
                  ? Container()
                  :
              Column(
                children: <Widget>[

                  // // --- CONTACT ME BUTTON
                  // DreamBox(
                  //   height: _flyerZoneWidth * 0.105,
                  //   verse: 'اتصل بنا',
                  //   verseWeight: 'black',
                  //   icon: Iconz.ComPhone,
                  //   iconSizeFactor: 0.5,
                  //   color: Colorz.BabyBluePlastic,
                  //   verseColor: Colorz.White,
                  //   iconColor: Colorz.White,
                  //   boxMargins: EdgeInsets.only(bottom: _flyerZoneWidth * 0.01),
                  //   boxFunction: (){print('You mother fackerz');},
                  //   verseScaleFactor: 1.5,
                  //   verseItalic: true,
                  // ),

              FlyerCounters(
                      saves: saves,
                      shares: shares,
                      views: views,
                      flyerZoneWidth: _flyerZoneWidth,
                    ),

                ],
              ),
            ),

            // --- Fake space under save button
            Container(
              width: footerBTRadius * 2,
              height: footerBTRadius * 2,
              margin: EdgeInsets.only(
                left: footerBTMargins,
                top: footerBTMargins,
                right: footerBTMargins,
                bottom: footerBTMargins,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

