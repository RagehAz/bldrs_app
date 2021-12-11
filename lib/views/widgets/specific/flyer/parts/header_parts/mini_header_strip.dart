import 'package:bldrs/helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/helpers/drafters/colorizers.dart' as Colorizer;
import 'package:bldrs/helpers/theme/colorz.dart';
import 'package:bldrs/helpers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/mini_follow_and_call_bts.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/mini_header_labels.dart';
import 'package:flutter/material.dart';

class MiniHeaderStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MiniHeaderStrip({
    @required this.superFlyer,
    @required this.flyerBoxWidth,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _stripHeight = FlyerBox.headerStripHeight(bzPageIsOn: superFlyer.nav.bzPageIsOn, flyerBoxWidth: flyerBoxWidth);
    final BorderRadius _stripBorders = Borderers.superHeaderStripCorners(
      context: context,
      bzPageIsOn: superFlyer.nav.bzPageIsOn,
      flyerBoxWidth: flyerBoxWidth,
    );
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
            gradient: Colorizer.superHeaderStripGradient(Colorz.white50),
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            <Widget>[

              /// --- BzLogo
              BzLogo(
                width: FlyerBox.logoWidth(
                    bzPageIsOn: superFlyer.nav.bzPageIsOn,
                    flyerBoxWidth: flyerBoxWidth
                ),
                image: superFlyer.bz.logo,
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
