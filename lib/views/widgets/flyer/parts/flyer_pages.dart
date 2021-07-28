import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/scrollers.dart';
import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:bldrs/models/super_flyer.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/info_page.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/slides_page.dart';
import 'package:flutter/material.dart';

class FlyerPages extends StatelessWidget {
  final SuperFlyer superFlyer;

  const FlyerPages({
    @required this.superFlyer,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool _microMode = Scale.superFlyerMicroMode(context, superFlyer.flyerZoneWidth);

    return GoHomeOnMaxBounce(
      child: PageView(
        pageSnapping: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        allowImplicitScrolling: true,
        onPageChanged: superFlyer.listenToSwipe ? (i) => superFlyer.onVerticalPageSwipe(i) : (i) => Sliders.zombie(i),
        controller: superFlyer.verticalController,
        children: <Widget>[

          /// SLIDES PAGE
          SlidesPage(
            superFlyer: superFlyer,
            key: PageStorageKey('slides_${superFlyer.flyerID}'),
          ),

          /// INFO PAGE
          if (_microMode == false)
          InfoPage(
            superFlyer : superFlyer,
            key: PageStorageKey('info_${superFlyer.flyerID}'),
          ),

        ],
      ),
    );
  }
}
