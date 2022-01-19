import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/bz_pg_headline.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/header_shadow.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/max_header.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/header_parts/mini_header_strip.dart';
import 'package:bldrs/f_helpers/drafters/scrollers.dart' as Scrollers;
import 'package:bldrs/f_helpers/drafters/tracers.dart' as Tracer;
import 'package:flutter/material.dart';

class OldFlyerHeader extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OldFlyerHeader({
    @required this.flyerBoxWidth,
    this.superFlyer,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final SuperFlyer superFlyer;
  final double flyerBoxWidth;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    Tracer.traceWidgetBuild(
        widgetName: 'FlyerHeader',
        varName: 'bzID',
        varValue: superFlyer.bz.id,
        tracerIsOn: false);
    return GestureDetector(
        onTap: superFlyer.nav.onHeaderTap,
        child: ListView(
          physics: Scrollers.superScroller(trigger: superFlyer.nav.bzPageIsOn),
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(
              height: OldFlyerBox.headerBoxHeight(
                bzPageIsOn: superFlyer.nav.bzPageIsOn,
                flyerBoxWidth: flyerBoxWidth,
              ),
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
                    country: superFlyer.bzCountry,
                    city: superFlyer.bzCity,
                  ),
                ],
              ),
            ),

            if (superFlyer.nav.bzPageIsOn)
              MaxHeader(
                flyerBoxWidth: flyerBoxWidth,
                bzPageIsOn: superFlyer.nav.bzPageIsOn,
                bzModel: superFlyer.bz,
              ),

          ],
        ));
  }
}
