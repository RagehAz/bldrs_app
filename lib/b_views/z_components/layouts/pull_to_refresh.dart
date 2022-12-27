import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class PullToRefresh extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PullToRefresh({
    @required this.child,
    @required this.fadeOnBuild,
    @required this.onRefresh,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onRefresh;
  final bool fadeOnBuild;
  final Widget child;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return RefreshIndicator(
        onRefresh: onRefresh,
        color: Colorz.black230,
        backgroundColor: Colorz.yellow255,
        displacement: 50,//Ratioz.appBarMargin,
        strokeWidth: 4,
        edgeOffset: 50,
        // notificationPredicate: (ScrollNotification scrollNotification){
          // blog('scrollNotification.metrics.pixels : ${scrollNotification.metrics.pixels}');
          // blog('scrollNotification.depth : ${scrollNotification.depth}');
        //   return true;
        // },
      // triggerMode: RefreshIndicatorTriggerMode.onEdge,
        child:

        fadeOnBuild == true ?
        WidgetFader(
          fadeType: FadeType.fadeIn,
          duration: const Duration(milliseconds: 750),
          child: child,
        )
            :
        child

    );

  }
/// --------------------------------------------------------------------------
}
