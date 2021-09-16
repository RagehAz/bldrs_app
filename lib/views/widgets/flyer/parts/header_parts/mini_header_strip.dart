import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:flutter/material.dart';

class MiniHeaderStrip extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;

  MiniHeaderStrip({
    @required this.superFlyer,
    @required this.flyerBoxWidth,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _stripHeight = FlyerBox.headerStripHeight(superFlyer.nav.bzPageIsOn, flyerBoxWidth);
    BorderRadius _stripBorders = Borderers.superHeaderStripCorners(context, superFlyer.nav.bzPageIsOn, flyerBoxWidth);
// -----------------------------------------------------------------------------
    return
      Align(
        alignment: Alignment.topCenter,
        child: Container( // there was Align(Alignment: Alignment.topCenter above this container ,, delete this comment if you see me again
          height: _stripHeight,
          width: flyerBoxWidth,
          padding: EdgeInsets.all(flyerBoxWidth * Ratioz.xxflyerHeaderMainPadding),
          decoration: BoxDecoration(
            borderRadius: _stripBorders,
            gradient: Colorizer.superHeaderStripGradient(Colorz.White50),
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            <Widget>[

              /// --- BzLogo
              BzLogo(
                width: FlyerBox.logoWidth(superFlyer.nav.bzPageIsOn, flyerBoxWidth),
                image: superFlyer.bz.bzLogo,
                tinyMode: FlyerBox.isTinyMode(context, flyerBoxWidth),
                corners: Borderers.superLogoCorner(context: context, flyerBoxWidth: flyerBoxWidth, zeroCornerIsOn: superFlyer.flyerShowsAuthor),
                bzPageIsOn: superFlyer.nav.bzPageIsOn,
                zeroCornerIsOn: superFlyer.flyerShowsAuthor,
                // onTap: superFlyer.onHeaderTap,
              ),

              /// --- B.NAME, B.LOCALE, AUTHOR PICTURE, AUTHOR NAME, AUTHOR TITLE, FOLLOWERS COUNT
              HeaderLabels(
                superFlyer: superFlyer,
                flyerBoxWidth: flyerBoxWidth,
              ),

              /// --- FOLLOW & Call
              FollowAndCallBTs(
                flyerBoxWidth: flyerBoxWidth,
                superFlyer: superFlyer,
              ),

            ],
          ),
        ),
      )
    ;
  }
}
