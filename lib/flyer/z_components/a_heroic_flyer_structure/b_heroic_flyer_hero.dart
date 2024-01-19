import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/flyer/z_components/a_heroic_flyer_structure/c_heroic_small_flyer.dart';
import 'package:bldrs/flyer/z_components/a_heroic_flyer_structure/f_flight_flyer.dart';
import 'package:flutter/material.dart';

enum FlightDirection{
  non,
  push,
  pop,
}

class FlyerHero extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerHero({
    required this.renderedFlyer,
    required this.flyerBoxWidth,
    required this.canBuildBigFlyer,
    required this.heroPath,
    required this.invoker,
    required this.gridWidth,
    required this.gridHeight,
    super.key
  });
  /// --------------------------------------------------------------------------
  final FlyerModel? renderedFlyer;
  final bool canBuildBigFlyer;
  final double flyerBoxWidth;
  final String heroPath;
  final String invoker;
  final double gridWidth;
  final double gridHeight;
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
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

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
      //   return Center(
      //     child: Container(
      //       width: flyerBoxWidth,
      //       height: FlyerDim.flyerHeightByFlyerWidth(
      //           flyerBoxWidth: flyerBoxWidth,
      //           forceMaxHeight: false,
      //       ),
      //       color: Colorz.yellow255,
      //       child: child,
      //     ),
      //   );
      // },
      /// THIS IS TO BUILD BIG FLYER
      child: HeroicSmallFlyer(
        flyerBoxWidth: flyerBoxWidth,
        renderedFlyer: renderedFlyer,
        heroTag: heroPath,
        canBuildBigFlyer: canBuildBigFlyer,
        gridWidth: gridWidth,
        gridHeight: gridHeight,
        // flightDirection: FlightDirection.non,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
