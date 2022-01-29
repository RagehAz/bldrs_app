import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/d_flyer_tree.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerHero extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerHero({
    @required this.flyerModel,
    @required this.bzModel,
    @required this.bzCountry,
    @required this.bzCity,
    @required this.isFullScreen,
    @required this.minWidthFactor,
    @required this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final CountryModel bzCountry;
  final CityModel bzCity;
  final bool isFullScreen;
  final double minWidthFactor;
  final String heroTag;
  /// --------------------------------------------------------------------------
  static double flyerWidthSizeFactor({
    @required double tween,
    /// min flyer width factor * screen width = minimum flyer width
    @required double minWidthFactor,
    /// max flyer width factor * screen width = max flyer width
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
    @required BzModel bzModel,
    @required double minWidthFactor,
  }) {

    /*
    final Hero toHero = toHeroContext.widget;
    final double _flyerBoxWidth = FlyerBox.width(fromHeroContext, 1);
    final double _flyerZoneHeight = FlyerBox.height(fromHeroContext, _flyerBoxWidth);
    final double _headerHeight = FlyerBox.headerBoxHeight(
        bzPageIsOn: false,
        flyerBoxWidth: _flyerBoxWidth
    );
    final double _footerHeight = FlyerFooter.boxHeight(
        context: fromHeroContext,
        flyerBoxWidth: _flyerBoxWidth
    );
    final double _flyerSmallWidth = FlyerBox.width(fromHeroContext, 0.4);
    final double _flyerSmallHeight = FlyerBox.height(fromHeroContext, _flyerSmallWidth);
    final double _flyerBigWidth = Scale.superScreenWidth(fromHeroContext);
    final double _flyerBigHeight = FlyerBox.height(fromHeroContext, _flyerBigWidth);
 */

    /// 'push' if expanding --- 'pop' if contracting
    final String _curveName = flightDirection.name;

    final Curve _curve = _curveName == 'push' ? Curves.fastOutSlowIn : Curves.fastOutSlowIn.flipped;

    final Tween<double> _tween = _curveName == 'push' ?
    Tween<double>(begin: 0, end: 1)
        :
    Tween<double>(begin: 1, end: 0);

    return TweenAnimationBuilder(
      key: const ValueKey<String>('FlyerHero_TweenAnimationBuilder'),
        tween: _tween,
        duration: Ratioz.duration150ms,
        curve: _curve,
        builder: (ctx, double value, Widget child){

          final double _flyerWidthFactor = flyerWidthSizeFactor(
            tween: value,
            minWidthFactor: minWidthFactor,
            // maxWidthFactor: 1, REDUNDANT
          );

          return Scaffold(
            backgroundColor: Colorz.nothing,
            body: FlyerTree(
              flyerWidthFactor: _flyerWidthFactor,
              flyerModel: flyerModel,
              bzModel: bzModel,
              bzCountry: null,
              bzCity: null,
              loading: true,
            ),
          );

        }
    );
  }
// -----------------------------------------------------------------------------
  String _createHeroTag(){
    String _heroTag;

    if (heroTag == null){
      _heroTag = '${flyerModel.id}_';
    }

    else {
      _heroTag = '$heroTag${flyerModel.id}_';
    }

    return _heroTag;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _heroTag = _createHeroTag();

    return Hero(
      key: ValueKey<String>(_heroTag),//const ValueKey<String>('FlyerHero_Hero'),
      tag: _heroTag,
      flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
          ){
        return FlyerHero.flyerFlightShuttle(
          flyerModel: flyerModel,
          bzModel: bzModel,
          minWidthFactor: minWidthFactor,
          animation: animation,
          flightContext: flightContext,
          flightDirection: flightDirection,
          fromHeroContext: fromHeroContext,
          toHeroContext: toHeroContext,
        );
      },

      child: FlyerTree(
        flyerWidthFactor: isFullScreen ? 1 : minWidthFactor,
        flyerModel: flyerModel,
        bzModel: bzModel,
        bzCountry: bzCountry,
        bzCity: bzCity,
        heroTag: _heroTag,
      ),

    );
  }
}
