import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/the_flyer.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerHero extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerHero({
    @required this.flyerModel,
    @required this.isFullScreen,
    @required this.minWidthFactor,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final bool isFullScreen;
  final double minWidthFactor;
  /// --------------------------------------------------------------------------
  static double flyerWidthSizeFactor({
    @required double tween,
    /// minimum flyer width factor to be multiplied by screen width to
    /// conclude minimum flyer width
    @required double minWidthFactor,
    /// maximum flyer width factor to be multiplied by screen width to
    /// conclude maximum flyer width
    double maxWidthFactor = 1,
  }) {
    /// EW3AAA
    final double _flyerWidthSizeFactor =
        minWidthFactor + (tween * (maxWidthFactor - minWidthFactor));
    return _flyerWidthSizeFactor;
  }
// -----------------------------------------------------------------------------
  static Widget flyerFlightShuttle({
    @required BuildContext flightContext,
    @required Animation<double> animation, // 0 to 1
    @required HeroFlightDirection flightDirection,
    @required BuildContext fromHeroContext,
    @required BuildContext toHeroContext,
    @required FlyerModel flyerModel,
    @required double minWidthFactor,
  }) {

    // final Hero toHero = toHeroContext.widget;
    // final double _flyerBoxWidth = FlyerBox.width(fromHeroContext, 1);
    // final double _flyerZoneHeight = FlyerBox.height(fromHeroContext, _flyerBoxWidth);
    // final double _headerHeight = FlyerBox.headerBoxHeight(
    //     bzPageIsOn: false,
    //     flyerBoxWidth: _flyerBoxWidth
    // );
    // final double _footerHeight = FlyerFooter.boxHeight(
    //     context: fromHeroContext,
    //     flyerBoxWidth: _flyerBoxWidth
    // );
    // final double _flyerSmallWidth = FlyerBox.width(fromHeroContext, 0.4);
    // final double _flyerSmallHeight = FlyerBox.height(fromHeroContext, _flyerSmallWidth);
    // final double _flyerBigWidth = Scale.superScreenWidth(fromHeroContext);
    // final double _flyerBigHeight = FlyerBox.height(fromHeroContext, _flyerBigWidth);

    /// 'push' if expanding --- 'pop' if contracting
    final String _curveName = flightDirection.name;

    final Curve _curve = _curveName == 'push' ? Curves.fastOutSlowIn : Curves.fastOutSlowIn.flipped;

    final Tween<double> _tween = _curveName == 'push' ?
    Tween<double>(begin: 0, end: 1)
        :
    Tween<double>(begin: 1, end: 0);

    return  TweenAnimationBuilder(
        tween: _tween,
        duration: Ratioz.duration150ms,
        curve: _curve,
        builder: (ctx, double value, Widget child){

          final double _sizeFactor = flyerWidthSizeFactor(
            tween: value,
            minWidthFactor: minWidthFactor,
            // maxWidthFactor: 1,
          );

          return AbstractFlyer(
            sizeFactor: _sizeFactor,
            flyerModel: flyerModel,
          );

        }
    );
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Hero(
      key: ValueKey<String>('flyerID_${flyerModel.id}'),
      tag: flyerModel.id,
      flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
          ){

        return FlyerHero.flyerFlightShuttle(
          flyerModel: flyerModel,
          animation: animation,
          flightContext: flightContext,
          flightDirection: flightDirection,
          fromHeroContext: fromHeroContext,
          toHeroContext: toHeroContext,
          minWidthFactor: minWidthFactor,
        );

      },

      child: AbstractFlyer(
        sizeFactor: isFullScreen ? 1 : minWidthFactor,
        flyerModel: flyerModel,
      ),

    );
  }
}
