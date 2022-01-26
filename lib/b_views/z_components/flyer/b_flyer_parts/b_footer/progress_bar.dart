import 'package:bldrs/b_views/widgets/specific/flyer/parts/progress_bar_parts/strips.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ProgressBar({
    @required this.flyerBoxWidth,
    /// --------------------------------------------------------------------------
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const bool _loading = true;

    return Container();

    // return SizedBox(
    //   width: flyerBoxWidth,
    //   child: Consumer<ActiveFlyerProvider>(
    //     // child: Container(),
    //     builder: (_, ActiveFlyerProvider activeFlyerProvider, Widget child){
    //
    //       final double _progressBarOpacity = activeFlyerProvider.progressBarOpacity;
    //       final int _currentSlideIndex = activeFlyerProvider.currentSlideIndex;
    //       final SwipeDirection _swipeDirection = activeFlyerProvider.swipeDirection;
    //       final int _numberOfStrips = activeFlyerProvider.numberOfStrips;
    //
    //       return AnimatedOpacity(
    //         duration: Ratioz.durationFading200,
    //         opacity: _progressBarOpacity,
    //         child:
    //
    //         _loading == true || _numberOfStrips == null ?
    //         Container(
    //           width: flyerBoxWidth,
    //           height: 250,
    //           color: Colorz.bloodTest,
    //           child: ProgressBox(
    //               flyerBoxWidth: flyerBoxWidth,
    //               strips: <Widget>[
    //
    //                 Container(
    //                   width: Strips.stripsTotalLength(flyerBoxWidth),
    //                   height: Strips.stripThickness(flyerBoxWidth),
    //                   decoration: BoxDecoration(
    //                     color: Strips.stripOffColor,
    //                     borderRadius: Strips.stripBorders(
    //                         context: context,
    //                         flyerBoxWidth: flyerBoxWidth,
    //                     ),
    //                   ),
    //                   child: LinearProgressIndicator(
    //                     backgroundColor: Colorz.nothing,
    //                     minHeight: Strips.stripThickness(flyerBoxWidth),
    //                     valueColor: const AlwaysStoppedAnimation(Strips.stripFadedColor),
    //                   ),
    //                 ),
    //
    //               ]
    //           ),
    //         )
    //             :
    //         Strips.canBuildStrips(_numberOfStrips) == true ?
    //         Strips(
    //           flyerBoxWidth: flyerBoxWidth,
    //           numberOfStrips: _numberOfStrips,
    //           slideIndex: _currentSlideIndex,
    //           swipeDirection: _swipeDirection,
    //           // margins: null,
    //         )
    //             :
    //         Container(),
    //       );
    //
    //     },
    //   ),
    // );
  }
}
