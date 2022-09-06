import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

/// --- STRATOSPHERE IS UPPER SCREEN PADDING THAT RESPECTS APPBAR HEIGHT
class Stratosphere extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Stratosphere({
    this.heightFactor = 1,
    this.bigAppBar = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double heightFactor;
  final bool bigAppBar;
  /// --------------------------------------------------------------------------
  static const EdgeInsets stratosphereInsets = EdgeInsets.only(top: Ratioz.stratosphere);
  static const EdgeInsets stratosphereSandwich = EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon);
  static const double _margins = Ratioz.appBarMargin * 2;
  static const double bigAppBarStratosphere = Ratioz.appBarBigHeight + _margins;
  static const double smallAppBarStratosphere = Ratioz.appBarSmallHeight + _margins;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _height = bigAppBar == true ? bigAppBarStratosphere : smallAppBarStratosphere;

    return SizedBox(
      width: Scale.superScreenWidth(context),
      height: _height * heightFactor,
    );

  }
/// --------------------------------------------------------------------------
}
