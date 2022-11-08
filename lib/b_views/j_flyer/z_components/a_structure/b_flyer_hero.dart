import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_small_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/d_flight_flyer.dart';
import 'package:flutter/material.dart';

enum FlightDirection{
  non,
  push,
  pop,
}

class FlyerHero extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerHero({
    @required this.flyerModel,
    @required this.bzModel,
    @required this.flyerBoxWidth,
    @required this.isFullScreen,
    @required this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final bool isFullScreen;
  final double flyerBoxWidth;
  final String heroTag;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Widget buildFlight(
      BuildContext flightContext,
      Animation<double> animation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext,
      ){

    return FlightFlyer(
      flyerModel: flyerModel,
      bzModel: bzModel,
      flyerBoxWidth: flyerBoxWidth,
      heroTag: heroTag,
      animation: animation,
      flightContext: flightContext,
      flightDirection: flightDirection,
      // fromHeroContext: fromHeroContext,
      // toHeroContext: toHeroContext,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // final String _heroTag = createFlyerHeroTag(
    //   flyerID: flyerModel.id,
    //   heroPath: heroTag,
    // );
    // final double _factor = isFullScreen ?  1 : minWidthFactor;
    // final double _flyerBoxWidth = FlyerDim.flyerWidthByFactor(context, _factor);

    // blog('FlyerHero : heroTag : $heroTag');

    return Hero(
      key: const ValueKey<String>('FlyerHero'),
      tag: heroTag,
      flightShuttleBuilder: buildFlight,
      transitionOnUserGestures: true,
      // createRectTween: (Rect x , Rect y){
      //   return Tween<Rect>(
      //       begin: x,
      //       end: y,
      //   );
      // },
      // placeholderBuilder: (BuildContext context, Size size, Widget child){
      //
      //   return Container(
      //     width: 50,
      //     height: 50,
      //     color: Colorz.yellow255,
      //   );
      //
      // },
      child: SmallFlyer(
        flyerBoxWidth: flyerBoxWidth,
        bzModel: bzModel,
        flyerModel: flyerModel,
        heroTag: heroTag,
        // flightTweenValue: 0, // DEFAULT
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
