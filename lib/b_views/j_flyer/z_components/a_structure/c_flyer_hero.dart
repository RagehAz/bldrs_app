import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/a_small_flyer.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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

    return flyerFlightShuttle(
      flyerModel: flyerModel,
      bzModel: bzModel,
      flyerBoxWidth: flyerBoxWidth,
      heroTag: heroTag,
      animation: animation,
      flightContext: flightContext,
      flightDirection: flightDirection,
      fromHeroContext: fromHeroContext,
      toHeroContext: toHeroContext,
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

    blog('FlyerHero : heroTag : $heroTag');

    return Hero(
      key: const ValueKey<String>('FlyerHero'),
      tag: heroTag,
      flightShuttleBuilder: buildFlight,
      child: SmallFlyer(
        flyerBoxWidth: flyerBoxWidth,
        bzModel: bzModel,
        flyerModel: flyerModel,
        heroTag: heroTag,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
