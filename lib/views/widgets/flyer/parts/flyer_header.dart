import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/header_shadow.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/max_header.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/mini_header_strip.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:flutter/material.dart';

class FlyerHeader extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;

  FlyerHeader({
    this.superFlyer,
    @required this.flyerZoneWidth,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    Tracer.traceWidgetBuild(widgetName: 'FlyerHeader', varName: 'bzID', varValue: superFlyer.bzID);
    return GestureDetector(
        onTap: superFlyer.nav.onHeaderTap,
        child: ListView(
          physics: Scrollers.superScroller(superFlyer.nav.bzPageIsOn),
          shrinkWrap: true,
          addAutomaticKeepAlives: true,
          children: <Widget>[

            Container(
              height: Scale.superHeaderHeight(superFlyer.nav.bzPageIsOn, flyerZoneWidth),
              width: flyerZoneWidth,
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
                    flyerZoneWidth: flyerZoneWidth,
                    bzPageIsOn: superFlyer.nav.bzPageIsOn,
                  ),

                  // --- HEADER COMPONENTS
                  MiniHeaderStrip(
                    superFlyer: superFlyer,
                    flyerZoneWidth: flyerZoneWidth,
                  ),

                  // --- HEADER'S MAX STATE'S HEADLINE : BZ.NAME AND BZ.LOCALE
                  BzPageHeadline(
                    flyerZoneWidth: flyerZoneWidth,
                    bzPageIsOn: superFlyer.nav.bzPageIsOn,
                    tinyBz: SuperFlyer.getTinyBzFromSuperFlyer(superFlyer),
                  ),

                ],
              ),
            ),

            // TASK : 3ayzeen zorar follow gowwa el bzPage
            if (superFlyer.nav.bzPageIsOn)
            MaxHeader(
              superFlyer: superFlyer,
              flyerZoneWidth: flyerZoneWidth,
              bzPageIsOn: superFlyer.nav.bzPageIsOn,
              tinyBz: SuperFlyer.getTinyBzFromSuperFlyer(superFlyer),
            ),

          ],
        )
    );

  }
}

