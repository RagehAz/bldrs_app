import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final AppBarType appBarType;
  final Color color;
  final double screenHeightWithoutSafeArea;
  /// --------------------------------------------------------------------------
  static EdgeInsets topMargin(AppBarType appBarType){
    EdgeInsets margins;

    /// NO APP BAR
    if (appBarType == AppBarType.non){
      margins = const EdgeInsets.only(
          top: Ratioz.appBarMargin,
      );
    }
    /// BIG APP BAR : SEARCH
    else if (appBarType == AppBarType.search){
      margins = const EdgeInsets.only(
          top: Ratioz.appBarBigHeight + (2 * Ratioz.appBarMargin)
      );
    }
    /// REMAINING APPBARS : BASIC - MAIN - INTRO - SCROLLABLE
    else {
      margins = const EdgeInsets.only(
          top: Ratioz.appBarSmallHeight + (2 * Ratioz.appBarMargin)
      );
    }

    return margins;
  }
// -----------------------------------------------------------------------------
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
      height = screenHeight -  Ratioz.appBarSmallHeight - (2 * Ratioz.appBarMargin);
    }

    return height;
  }
// -----------------------------------------------------------------------------
  static double clearWidth(BuildContext context){
    return Scale.appBarWidth(context);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _screenWidth = Scale.superScreenWidth(context);

    final BorderRadius _borders = superBorderAll(context, Ratioz.appBarCorner);


    return Container(
        key: const ValueKey<String>('PageBubble'),
        width: _screenWidth,
        height: screenHeightWithoutSafeArea,
        padding: topMargin(appBarType),
        alignment: Alignment.topCenter,
        child: Container(
          width: Scale.appBarWidth(context),
          height: height(
              screenHeight: screenHeightWithoutSafeArea,
              appBarType: appBarType,
              context: context
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
  }
}
