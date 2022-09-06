import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_strips.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class PageBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PageBubble({
    @required this.screenHeightWithoutSafeArea,
    @required this.child,
    @required this.appBarType,
    this.color = Colorz.black255,
    this.bubbleWidth,
    this.corners,
    this.progressBarIsOn = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final AppBarType appBarType;
  final Color color;
  final double screenHeightWithoutSafeArea;
  final double bubbleWidth;
  final dynamic corners;
  final bool progressBarIsOn;
  /// --------------------------------------------------------------------------
  static EdgeInsets topMargin({
    @required BuildContext context,
    @required AppBarType appBarType,
    @required bool withProgressBar,
  }){
    EdgeInsets margins;

    final double _progressBarHeight = withProgressBar == true ?
    StaticStrips.boxHeight(Scale.superScreenWidth(context))
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
    @required AppBarType appBarType,
    @required BuildContext context,
    @required double screenHeight,
  }){
    double height;


    /// NO APP BAR
    if (appBarType == AppBarType.non){
      height = screenHeight - (2 * Ratioz.appBarMargin);
    }
    /// BIG APP BAR : SEARCH
    else if (appBarType == AppBarType.search){
      height = screenHeight -  Ratioz.appBarBigHeight - (3 * Ratioz.appBarMargin);
    }
    /// REMAINING APPBARS : BASIC - MAIN - INTRO - SCROLLABLE
    else {
      height = screenHeight - Stratosphere.smallAppBarStratosphere - 10;
      // height = screenHeight -  Ratioz.appBarSmallHeight - (2 * Ratioz.appBarMargin);
    }

    return height;
  }
  // --------------------
  static double width(BuildContext context, {double override}){
    return override ?? BldrsAppBar.width(context);
  }
  // --------------------
  static double clearWidth(BuildContext context){
    return PageBubble.width(context) - (Ratioz.appBarMargin * 2);
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    // --------------------
    final BorderRadius _borders = corners == null ?
    Borderers.superBorderAll(context, Ratioz.appBarCorner)
    :
    Borderers.superBorder(context: context, corners: corners)
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
        alignment: Alignment.topRight,
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
          alignment: Alignment.topCenter,
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
