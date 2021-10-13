import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/header_shadow.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/max_header.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/mini_header_strip.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:flutter/material.dart';

class FlyerHeader extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;

  const FlyerHeader({
    this.superFlyer,
    @required this.flyerBoxWidth,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    Tracer.traceWidgetBuild(widgetName: 'FlyerHeader', varName: 'bzID', varValue: superFlyer.bz.bzID, tracerIsOn: false);
    return GestureDetector(
        onTap: superFlyer.nav.onHeaderTap,
        child: ListView(
          physics: Scrollers.superScroller(superFlyer.nav.bzPageIsOn),
          shrinkWrap: true,
          addAutomaticKeepAlives: true,
          children: <Widget>[

            Container(
              height: FlyerBox.headerBoxHeight(superFlyer.nav.bzPageIsOn, flyerBoxWidth),
              width: flyerBoxWidth,
              child: Stack(
                children: <Widget>[

                  // if (stripBlurIsOn)
                  // BlurLayer(
                  //   height: Scale.superHeaderHeight(bzPageIsOn, flyerBoxWidth),
                  //   width: flyerBoxWidth,
                  //   borders: Borderers.superHeaderStripCorners(context, bzPageIsOn, flyerBoxWidth),
                  // ),


                  /// HEADER SHADOW
                  HeaderShadow(
                    flyerBoxWidth: flyerBoxWidth,
                    bzPageIsOn: superFlyer.nav.bzPageIsOn,
                  ),

                  /// HEADER COMPONENTS
                  MiniHeaderStrip(
                    superFlyer: superFlyer,
                    flyerBoxWidth: flyerBoxWidth,
                  ),

                  /// HEADER'S MAX STATE'S HEADLINE : BZ.NAME AND BZ.LOCALE
                  BzPageHeadline(
                    flyerBoxWidth: flyerBoxWidth,
                    bzPageIsOn: superFlyer.nav.bzPageIsOn,
                    bzModel: superFlyer.bz,
                  ),

                ],
              ),
            ),

            if (superFlyer.nav.bzPageIsOn)
            MaxHeader(
              superFlyer: superFlyer,
              flyerBoxWidth: flyerBoxWidth,
              bzPageIsOn: superFlyer.nav.bzPageIsOn,
              bzModel: superFlyer.bz,
            ),

          ],
        )
    );

  }
}

