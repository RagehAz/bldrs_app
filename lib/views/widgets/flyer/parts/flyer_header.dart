import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/tiny_models/tiny_user.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/header_shadow.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/max_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header_strip.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:flutter/material.dart';

class FlyerHeader extends StatelessWidget {
  final SuperFlyer superFlyer;

  FlyerHeader({
    this.superFlyer,
  });

  @override
  Widget build(BuildContext context) {
    print('building flyer header');
// -----------------------------------------------------------------------------
    return GestureDetector(
        onTap: superFlyer.onHeaderTap,
        child: ListView(
          physics: Scrollers.superScroller(superFlyer.bzPageIsOn),
          shrinkWrap: true,
          addAutomaticKeepAlives: true,
          children: <Widget>[

            Container(
              height: Scale.superHeaderHeight(superFlyer.bzPageIsOn, superFlyer.flyerZoneWidth),
              width: superFlyer.flyerZoneWidth,
              child: Stack(
                children: <Widget>[

                  // if (stripBlurIsOn)
                  // BlurLayer(
                  //   height: Scale.superHeaderHeight(bzPageIsOn, flyerZoneWidth),
                  //   width: flyerZoneWidth,
                  //   borders: Borderers.superHeaderStripCorners(context, bzPageIsOn, flyerZoneWidth),
                  // ),


                  // --- HEADER SHADOW
                  HeaderShadow(
                    flyerZoneWidth: superFlyer.flyerZoneWidth,
                    bzPageIsOn: superFlyer.bzPageIsOn,
                  ),

                  // --- HEADER COMPONENTS
                  MiniHeaderStrip(
                    superFlyer: superFlyer,
                  ),

                  // --- HEADER'S MAX STATE'S HEADLINE : BZ.NAME AND BZ.LOCALE
                  BzPageHeadline(
                    flyerZoneWidth: superFlyer.flyerZoneWidth,
                    bzPageIsOn: superFlyer.bzPageIsOn,
                    tinyBz: SuperFlyer.getTinyBzFromSuperFlyer(superFlyer),
                  ),

                ],
              ),
            ),

            // TASK : 3ayzeen zorar follow gowwa el bzPage
            if (superFlyer.bzPageIsOn)
            MaxHeader(
              superFlyer: superFlyer,
              flyerZoneWidth: superFlyer.flyerZoneWidth,
              bzPageIsOn: superFlyer.bzPageIsOn,
              tinyBz: SuperFlyer.getTinyBzFromSuperFlyer(superFlyer),
            ),

          ],
        )
    );

  }
}

