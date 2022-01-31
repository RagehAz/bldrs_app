import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/d_flyer_tree.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
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
  static String createHeroTag({
    @required String heroTag,
    @required String flyerID
  }){
    String _heroTag;

    if (heroTag == null){
      _heroTag = '${flyerID}_';
    }

    else {
      _heroTag = '$heroTag${flyerID}_';
    }

    return _heroTag;
  }
// -----------------------------------------------------------------------------
  static List<String> splitHeroTagIntoFlyersIDs({
    @required String heroTag,
  }){
    final List<String> _flyersIDs = heroTag?.split('_');

    List<String> _output = <String>[];

    if (Mapper.canLoopList(_flyersIDs)){
      _output = [..._flyersIDs];
    }

    return _output;
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

          final double _flyerBoxWidth = FlyerBox.width(flightContext, _flyerWidthFactor);

          return Scaffold(
            backgroundColor: Colorz.nothing,
            body: FlyerTree(
              flyerBoxWidth: _flyerBoxWidth,
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
  @override
  Widget build(BuildContext context) {

    final String _heroTag = createHeroTag(
        heroTag: heroTag,
        flyerID: flyerModel.id,
    );

    final double _factor = isFullScreen ?  1 : minWidthFactor;
    final double _flyerBoxWidth = FlyerBox.width(context, _factor);

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
        flyerBoxWidth: _flyerBoxWidth,
        flyerModel: flyerModel,
        bzModel: bzModel,
        bzCountry: bzCountry,
        bzCity: bzCity,
        heroTag: _heroTag,
      ),

    );
  }
}
