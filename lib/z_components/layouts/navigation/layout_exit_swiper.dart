import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/checks/device_checker.dart';

class LayoutExitSwiper extends StatelessWidget {
  // --------------------------------------------------------------------------
  const LayoutExitSwiper({
    required this.child,
    required this.isOn,
    required this.onBack,
    super.key
  });
  // --------------------
  final Widget child;
  final bool isOn;
  final Function onBack;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    if (isOn == true && DeviceChecker.deviceIsSmartPhone() == true){

      final bool _isLandScape = Scale.isLandScape(context);
      /// is the swipe threshold in percentage of the screen width
      final double _swipeThreshold = _isLandScape == true ? 0.1 : 0.35;

      return DismissiblePage(
        // key: ,

        /// DIRECTION
        direction: UiProvider.checkAppIsLeftToRight() ?
        DismissiblePageDismissDirection.endToStart
            :
        DismissiblePageDismissDirection.endToStart,

        /// COLORS
        backgroundColor: Colorz.black10,
        startingOpacity: 0,

        /// CONTROLS
        // isFullScreen: true,
        // disabled: false,

        /// ANIMATION
        dismissThresholds: {
          DismissiblePageDismissDirection.startToEnd: _swipeThreshold,
          DismissiblePageDismissDirection.endToStart: _swipeThreshold,
        },
        /// feels like friction 0 is heavier than honey 1 is lighter than air
        dragSensitivity: 0.8,
        dragStartBehavior: DragStartBehavior.start,
        /// limits the horizontal swipe threshold  by this percentage 0 to 1
        maxTransformValue: 1,

        /// SCALE
        minScale: 1,
        // maxRadius: ,
        // minRadius: ,

        /// ON DRAGGING
        // onDragStart: ,
        // onDragEnd: ,
        // onDragUpdate: ,
        onDismissed: (){
          UiProvider.proSetPyramidsAreExpanded(setTo: false, notify: true);
          onBack();
        },

        /// DURATION
        // reverseDuration: ,

        child: child,
      );
    }
    // --------------------
    else {
      return child;
    }
    // --------------------
  }
  // --------------------------------------------------------------------------
}
