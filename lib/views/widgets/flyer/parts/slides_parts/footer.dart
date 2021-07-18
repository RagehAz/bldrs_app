import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/share_button.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/slide_counters.dart';
import 'package:flutter/material.dart';

class FlyerFooter extends StatelessWidget {
  final double flyerZoneWidth;
  final int shares;
  final int views;
  final int saves;
  final Function onShareTap;
  final Function onCountersTap;

  FlyerFooter({
    @required this.flyerZoneWidth,
    @required this.shares,
    @required this.views,
    @required this.saves,
    @required this.onShareTap,
    @required this.onCountersTap,
  });

  // FlyerLink theFlyerLink = FlyerLink(flyerLink: 'flyer', description: 'flyer to be shared aho');

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _flyerZoneWidth = flyerZoneWidth;
    double _flyerBottomCorners = flyerZoneWidth * Ratioz.xxflyerBottomCorners;
// -----------------------------------------------------------------------------
    bool _miniMode = Scale.superFlyerMiniMode(context, flyerZoneWidth) ;
// -----------------------------------------------------------------------------
    /// SHARE & SAVE BUTTONS
    double _footerBTMargins = flyerZoneWidth * 0.025; //
    double _footerBTRadius = _flyerBottomCorners - _footerBTMargins;
    dynamic _footerBTColor = Colorz.Grey80;
    String _shareBTIcon = Iconz.Share;
    String _shareBTVerse = Wordz.send(context);
    // String saveBTIcon = ankhOn == true ? Iconz.SaveOn : Iconz.SaveOff;
    // String saveBTVerse = ankhOn == true ? translate(context, 'Saved') :
    // Wordz.save(context);
    // dynamic saveBTColor = ankhOn == true ? Colorz.SkyDarkBlue : footerBTColor;
// -----------------------------------------------------------------------------
    /// FLYER FOOTER CONTAINER
    double _flyerFooterWidth = flyerZoneWidth;
    double _flyerFooterHeight = Scale.superFlyerFooterHeight(_flyerZoneWidth);
    dynamic _flyerFooterColor = Colorz.Nothing;

    // --- FLYER FOOTER
    return Align(
      alignment: Alignment.bottomCenter,
      // --- FLYER FOOTER BOX
      child: Container(
        width: _flyerFooterWidth,
        height: _flyerFooterHeight,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            /// BOTTOM SHADOW
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
                        Colorz.Black0,
                        Colorz.Black125,
                        Colorz.Black230
                      ],
                      stops: <double>[0.35, 0.85, 1])
              ),
            ),

            /// SHARE BUTTON
            if (!_miniMode)
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
                tappingButton: onShareTap,

                //() => share(context, theFlyerLink),
              ),
            ),

            /// FLYER COUNTERS
            if(!_miniMode)
            SlideCounters(
              saves: saves,
              shares: shares,
              views: views,
              flyerZoneWidth: _flyerZoneWidth,
              onCountersTap: onCountersTap,
            ),

            /// Fake space under save button
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

