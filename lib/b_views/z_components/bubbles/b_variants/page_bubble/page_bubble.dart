import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class PageBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PageBubble({
    required this.screenHeightWithoutSafeArea,
    required this.child,
    required this.appBarType,
    this.color = Colorz.black255,
    this.bubbleWidth,
    this.corners,
    this.progressBarIsOn = false,
    this.childrenAlignment = Alignment.topCenter,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Widget child;
  final AppBarType appBarType;
  final Color color;
  final double screenHeightWithoutSafeArea;
  final double? bubbleWidth;
  final dynamic corners;
  final bool progressBarIsOn;
  final Alignment childrenAlignment;
  /// --------------------------------------------------------------------------
  static EdgeInsets topMargin({
    required BuildContext context,
    required AppBarType appBarType,
    required bool withProgressBar,
  }){
    EdgeInsets margins;

    final double _progressBarHeight = withProgressBar == true ?
    FlyerDim.progressBarBoxHeight(Scale.screenWidth(context))
        :
    0;

    /// NO APP BAR
    if (appBarType == AppBarType.non){
      margins = EdgeInsets.only(
          top: Ratioz.appBarMargin + _progressBarHeight,
      );
    }
    /// BIG APP BAR : SEARCH
    else if (appBarType == AppBarType.search){
      margins = EdgeInsets.only(
          top: Ratioz.appBarBigHeight + (2 * Ratioz.appBarMargin) + _progressBarHeight
      );
    }
    /// REMAINING APPBARS : BASIC - MAIN - INTRO - SCROLLABLE
    else {
      margins = EdgeInsets.only(
          top: Ratioz.appBarSmallHeight + (2 * Ratioz.appBarMargin) + _progressBarHeight
      );
    }

    return margins;
  }
  // --------------------
  static double height({
    required AppBarType appBarType,
    required BuildContext context,
    required double screenHeight,
  }){
    double height;


    /// NO APP BAR
    if (appBarType == AppBarType.non){
      height = screenHeight - (2 * Ratioz.appBarMargin);
    }
    /// BIG APP BAR : SEARCH
    else if (appBarType == AppBarType.search){
      height = screenHeight -  Ratioz.appBarBigHeight - (3 * Ratioz.appBarMargin) - 5;
    }
    /// REMAINING APPBARS : BASIC - MAIN - INTRO - SCROLLABLE
    else {
      height = screenHeight - Stratosphere.smallAppBarStratosphere - 10;
      // height = screenHeight -  Ratioz.appBarSmallHeight - (2 * Ratioz.appBarMargin);
    }

    return height;
  }
  // --------------------
  static double width(BuildContext context, {double? override}){
    return override ?? Bubble.bubbleWidth(context: context);
  }
  // --------------------
  static double clearWidth(BuildContext context){
    return PageBubble.width(context) - (Ratioz.appBarMargin * 2);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.screenWidth(context);
    // --------------------
    final BorderRadius _borders = corners == null ?
    BldrsAppBar.corners
    :
    Borderers.superCorners(corners: corners)
    ;
    // --------------------
    return Container(
        key: const ValueKey<String>('PageBubble'),
        width: _screenWidth,
        height: screenHeightWithoutSafeArea,
        padding: topMargin(
          appBarType: appBarType,
          context: context,
          withProgressBar: progressBarIsOn,
        ),
        alignment: Alignment.topCenter,
        child: Container(
          width: width(context, override: bubbleWidth),
          margin: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
          height: height(
              context: context,
              screenHeight: screenHeightWithoutSafeArea,
              appBarType: appBarType,
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: _borders,
          ),
          alignment: childrenAlignment,
          child: ClipRRect(
            borderRadius: _borders,
            child: child,
          ),
        )
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
