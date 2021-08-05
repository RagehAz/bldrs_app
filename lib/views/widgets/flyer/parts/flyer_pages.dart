import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/controllers/drafters/tracers.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page.dart';
import 'package:flutter/material.dart';

class FlyerPages extends StatelessWidget {
  final SuperFlyer superFlyer;
  final double flyerZoneWidth;

  const FlyerPages({
    @required this.superFlyer,
    @required this.flyerZoneWidth,
  });

  @override
  Widget build(BuildContext context) {

    bool _tinyMode = Scale.superFlyerTinyMode(context, flyerZoneWidth);

    Tracer.traceWidgetBuild(widgetName: 'FlyerPages', varName: '_tinyMode', varValue: _tinyMode);
    return GoHomeOnMaxBounce(
      child: PageView(
        pageSnapping: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        allowImplicitScrolling: true,
        onPageChanged: superFlyer.nav.listenToSwipe ? (i) => superFlyer.nav.onVerticalPageSwipe(i) : (i) => Sliders.zombie(i),
        controller: superFlyer.nav.verticalController,
        children: <Widget>[

          /// SLIDES PAGE
          SlidesPage(
            superFlyer: superFlyer,
            flyerZoneWidth: flyerZoneWidth,
            // key: PageStorageKey('slides_${superFlyer.flyerID}'),
          ),

          /// INFO PAGE
          if (_tinyMode == false && superFlyer.mutableSlides != null)
          InfoPage(
            superFlyer : superFlyer,
            flyerZoneWidth: flyerZoneWidth,
            // key: PageStorageKey('info_${superFlyer.flyerID}'),
          ),

        ],
      ),
    );
  }
}
