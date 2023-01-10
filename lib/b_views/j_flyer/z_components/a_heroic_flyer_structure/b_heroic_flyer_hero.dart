import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/c_heroic_small_flyer.dart';
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
    @required this.renderedFlyer,
    @required this.flyerBoxWidth,
    @required this.canBuildBigFlyer,
    @required this.heroPath,
    @required this.invoker,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel renderedFlyer;
  final bool canBuildBigFlyer;
  final double flyerBoxWidth;
  final String heroPath;
  final String invoker;
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
      renderedFlyer: renderedFlyer,
      flyerBoxWidth: flyerBoxWidth,
      heroTag: heroPath,
      flightDirection: flightDirection,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // blog('heroTag : $heroPath');

    return Hero(
      key: const ValueKey<String>('FlyerHero'),
      tag: heroPath,
      flightShuttleBuilder: buildFlight,
      transitionOnUserGestures: true,
      // createRectTween: (Rect x , Rect y){
      //   return Tween<Rect>(
      //       begin: x,
      //       end: y,
      //   );
      // },
      // placeholderBuilder: (BuildContext context, Size size, Widget child){
      //   return Container(
      //     width: 50,
      //     height: 50,
      //     color: Colorz.yellow255,
      //   );
      // },
      /// THIS IS TO BUILD BIG FLYER
      child: HeroicSmallFlyer(
        flyerBoxWidth: flyerBoxWidth,
        renderedFlyer: renderedFlyer,
        heroTag: heroPath,
        canBuildBigFlyer: canBuildBigFlyer,
        flightTweenValue: 1,
        // flightDirection: FlightDirection.non,
        // contextOwnerGlobalKeyCount: context.owner.globalKeyCount,
        // flightTweenValue: 0, // DEFAULT
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
