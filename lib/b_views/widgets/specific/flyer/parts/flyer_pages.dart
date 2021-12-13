import 'package:bldrs/a_models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/b_views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/flyer_zone_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/info_page.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/drafters/tracers.dart' as Tracer;
import 'package:flutter/material.dart';

class FlyerPages extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerPages({
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
    final bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);

    Tracer.traceWidgetBuild(
        widgetName: 'FlyerPages',
        varName: '_tinyMode',
        varValue: _tinyMode,
        tracerIsOn: false);
    return MaxBounceNavigator(
      notificationListenerKey: ValueKey<String>(
          '${superFlyer.flyerID}_flyerPages_notification_listener_key'),
      child: PageView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        allowImplicitScrolling: true,

        /// test keda w shoof
        onPageChanged: superFlyer.nav.listenToSwipe
            ? (int i) => superFlyer.nav.onVerticalPageSwipe(i)
            : (int i) => Sliders.zombie(i),
        controller: superFlyer.nav.verticalController,
        children: <Widget>[
          /// SLIDES PAGE
          SlidesPage(
            superFlyer: superFlyer,
            flyerBoxWidth: flyerBoxWidth,
          ),

          /// INFO PAGE
          if (_tinyMode == false && superFlyer.mSlides != null)
            InfoPage(
              superFlyer: superFlyer,
              flyerBoxWidth: flyerBoxWidth,
            ),
        ],
      ),
    );
  }
}
