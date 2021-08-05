import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:flutter/material.dart';

class MiniHeaderStrip extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;
  final bool stripBlurIsOn;

  MiniHeaderStrip({
    @required this.superFlyer,
    @required this.flyerZoneWidth,
    this.stripBlurIsOn = false,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _stripHeight = Scale.superHeaderStripHeight(superFlyer.bzPageIsOn, flyerZoneWidth);
    BorderRadius _stripBorders = Borderers.superHeaderStripCorners(context, superFlyer.bzPageIsOn, flyerZoneWidth);
// -----------------------------------------------------------------------------
    return
      Align(
        alignment: Alignment.topCenter,
        child: Container( // there was Align(Alignment: Alignment.topCenter above this container ,, delete this comment if you see me again
          height: _stripHeight,
          width: flyerZoneWidth,
          padding: EdgeInsets.all(flyerZoneWidth * Ratioz.xxflyerHeaderMainPadding),
          decoration: BoxDecoration(
            borderRadius: _stripBorders,
            gradient: Colorizer.superHeaderStripGradient(Colorz.White50),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            <Widget>[

              // --- BzLogo
              Expanded(
                flex: superFlyer.bzPageIsOn ? 1 : 26,
                child: BzLogo(
                  width: Scale.superLogoWidth(superFlyer.bzPageIsOn, flyerZoneWidth),
                  image: superFlyer.bzLogo,
                  tinyMode: Scale.superFlyerTinyMode(context, flyerZoneWidth),
                  corners: Borderers.superLogoCorner(context, flyerZoneWidth),
                  bzPageIsOn: superFlyer.bzPageIsOn,
                  zeroCornerIsOn: superFlyer.flyerShowsAuthor,
                  // onTap: superFlyer.onHeaderTap,
                ),
              ),

              // --- B.NAME, B.LOCALE, AUTHOR PICTURE, AUTHOR NAME, AUTHOR TITLE, FOLLOWERS COUNT
              Expanded(
                flex: superFlyer.bzPageIsOn ? 0 : 62,
                child: HeaderLabels(
                  superFlyer: superFlyer,
                  flyerZoneWidth: flyerZoneWidth,
                  // bzPageIsOn: superFlyer.bzPageIsOn,
                  // flyerShowsAuthor: superFlyer.flyerShowsAuthor ?? false,
                  // tinyBz: tinyBz,
                  // tinyAuthor: tinyAuthor,
                ),
              ),

              // --- FOLLOW & Call
              Expanded(
                flex: superFlyer.bzPageIsOn ? 0 : 11,
                child: FollowAndCallBTs(
                  flyerZoneWidth: flyerZoneWidth,
                  bzPageIsOn: superFlyer.bzPageIsOn,
                  followIsOn: superFlyer.followIsOn,
                  onFollowTap: superFlyer.onFollowTap,
                  onCallTap: superFlyer.onCallTap,
                  phoneNumber: superFlyer?.flyerTinyAuthor?.phone,
                ),
              ),

            ],
          ),
        ),
      )
    ;
  }
}
