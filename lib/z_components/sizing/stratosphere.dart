import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:flutter/material.dart';

/// --- STRATOSPHERE IS UPPER SCREEN PADDING THAT RESPECTS APPBAR HEIGHT
class Stratosphere extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Stratosphere({
    this.heightFactor = 1,
    this.bigAppBar = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double heightFactor;
  final bool bigAppBar;
  /// --------------------------------------------------------------------------
  static const EdgeInsets stratosphereInsets = EdgeInsets.only(top: Ratioz.stratosphere);
  static const EdgeInsets stratosphereSandwich = EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon);
  static const double _margins = Ratioz.appBarMargin * 2;
  static const double bigAppBarStratosphere = Ratioz.appBarBigHeight + _margins;
  static const double smallAppBarStratosphere = Ratioz.appBarSmallHeight + _margins;
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getStratosphereValue({
    required BuildContext context,
    required AppBarType appBarType,
  }){
    final double _appBarHeight = BldrsAppBar.collapsedHeight(context, appBarType);
    final double _topPadding =  _appBarHeight + (2 * Ratioz.appBarMargin);
    return _topPadding;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static EdgeInsets getStratosphereSandwich({
    required BuildContext context,
    required AppBarType appBarType,
    bool withHorizon = true
  }){

    final double _topPadding =  getStratosphereValue(
      context: context,
      appBarType: appBarType,
    );
    final double _horizon = withHorizon == true ? Ratioz.horizon : 0;

    return EdgeInsets.only(
        top: _topPadding,
        bottom: _horizon,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _height = bigAppBar == true ? bigAppBarStratosphere : smallAppBarStratosphere;

    return SizedBox(
      width: Scale.screenWidth(context),
      height: _height * heightFactor,
    );

  }
  /// --------------------------------------------------------------------------
}
