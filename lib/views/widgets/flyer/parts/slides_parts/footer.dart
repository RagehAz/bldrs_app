import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/share_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/slide_counters.dart';
import 'package:flutter/material.dart';

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
    double _screenWidth = superScreenWidth(context);

    double _flyerZoneWidth = flyerZoneWidth;
    double _flyerBottomCorners = flyerZoneWidth * Ratioz.xxflyerBottomCorners;
    // ----------------------------------------------------------------------
    bool _miniMode = superFlyerMiniMode(context, flyerZoneWidth) ;

    // --- SHARE & SAVE BUTTONS --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- SHARE & SAVE BUTTONS
    double _footerBTMargins = flyerZoneWidth * 0.025; //
    double _footerBTRadius = _flyerBottomCorners - _footerBTMargins;
    dynamic _footerBTColor = Colorz.GreySmoke;
    String _shareBTIcon = Iconz.Share;
    String _shareBTVerse = Wordz.send(context);
    // String saveBTIcon = ankhOn == true ? Iconz.SaveOn : Iconz.SaveOff;
    // String saveBTVerse = ankhOn == true ? translate(context, 'Saved') :
    // Wordz.save(context);
    // dynamic saveBTColor = ankhOn == true ? Colorz.SkyDarkBlue : footerBTColor;


    // --- FLYER FOOTER CONTAINER--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- FLYER FOOTER
    double _flyerFooterWidth =
        // flyerZoneWidth == MediaQuery.of(context).size.width ?
        // (flyerZoneWidth-(flyerZoneWidth * Ratioz.xxflyerMainMargins * 2 ))
        //     : // * only 1 because it starts from bottom left of the flyer neglecting flyer's left margin from screen boarder kalb
    flyerZoneWidth
    ;
    double _flyerFooterHeight = (2 * _footerBTMargins) + (2 * _footerBTRadius);
    dynamic _flyerFooterColor = Colorz.Nothing;

    // --- FLYER FOOTER
    return Align(
      alignment: Alignment.bottomCenter,
      // --- FLYER FOOTER BOX
      child: Container(
        width: _flyerFooterWidth,
        height: _flyerFooterHeight,
        color: _flyerFooterColor,

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
                    bottomLeft: Radius.circular(_flyerBottomCorners),
                    bottomRight: Radius.circular(_flyerBottomCorners),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colorz.BlackNothing,
                        Colorz.BlackPlastic,
                        Colorz.BlackBlack
                      ],
                      stops: <double>[0.35, 0.85, 1])
              ),
            ),

            if (!_miniMode)
            // --- SHARE BUTTON
            Positioned(
              right: Wordz.textDirection(context) == 'ltr' ? null : 0,
              left: Wordz.textDirection(context) == 'ltr' ? 0 : null,
              bottom: 0,
              child: ShareBT(
                flyerZoneWidth: flyerZoneWidth,
                buttonVerse: _shareBTVerse,
                buttonColor: _footerBTColor,
                buttonIcon: _shareBTIcon,
                buttonMargins: _footerBTMargins,
                buttonRadius: _footerBTRadius,
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

              SlideCounters(
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
              width: _footerBTRadius * 2,
              height: _footerBTRadius * 2,
              margin: EdgeInsets.only(
                left: _footerBTMargins,
                top: _footerBTMargins,
                right: _footerBTMargins,
                bottom: _footerBTMargins,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

