import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/c_heroic_small_flyer.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class FlightFlyer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlightFlyer({
    required this.flightDirection,
    required this.renderedFlyer,
    required this.flyerBoxWidth,
    required this.heroTag,
    super.key
  });
  /// --------------------------------------------------------------------------
  final HeroFlightDirection flightDirection;
  final FlyerModel renderedFlyer;
  final double flyerBoxWidth;
  final String heroTag;

  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  FlightDirection getFlightDirection(String direction){

    switch(direction){
      case 'push': return FlightDirection.push; break;
      case 'pop' : return FlightDirection.pop; break;
      default: return FlightDirection.non;
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// 'push' if expanding --- 'pop' if contracting
    final String _flightDirectionName = flightDirection.name;

    final Curve _curve = _flightDirectionName == 'push' ? Curves.fastOutSlowIn : Curves.fastOutSlowIn.flipped;

    final Tween<double> _tween = _flightDirectionName == 'push' ?
    Tween<double>(begin: 0.3, end: 1)
        :
    Tween<double>(begin: 1.5, end: 1);

    return TweenAnimationBuilder(
        key: const ValueKey<String>('FlyerHero_TweenAnimationBuilder'),
        tween: _tween,
        duration: Ratioz.duration150ms,
        curve: _curve,
        builder: (ctx, double value, Widget? child){

          final FlightDirection _flightDirection = getFlightDirection(flightDirection.name);
          // final double _maxWidth = Scale.screenWidth(context);
          // final double _tweenWidth = (_maxWidth * (1 - value)) - (flyerBoxWidth * value);
          // final double _scale = Animators.limitTweenImpact(
          //     maxDouble: 1,
          //     minDouble: FlyerDim.flyerFactorByFlyerWidth(context, flyerBoxWidth),
          //     tweenValue: value
          // );
          //
          // blog('FLIGHT FLYER : value : $value : _flightDirection : $_flightDirection');

          return Material(
            type: MaterialType.transparency,
            child: Transform.scale(
              scale: value,
              child: HeroicSmallFlyer(
                renderedFlyer: renderedFlyer,
                flyerBoxWidth: flyerBoxWidth,
                // flightTweenValue: 0,
                flightDirection: _flightDirection,
                heroTag: heroTag,
                gridWidth: Scale.screenWidth(context),
                gridHeight: Scale.screenHeight(context),
                // canBuildBigFlyer: false, // DEFAULT
              ),
            ),
            // child: Transform.scale(
            //   scale: value,
            //   child: StaticFlyer(
            //     flyerBoxWidth: flyerBoxWidth,
            //     flyerModel: renderedFlyer,
            //     bzModel: renderedFlyer.bzModel,
            //     canPinch: false,
            //     canUseFilter: false,
            //     canAnimateMatrix: false,
            //     // slideShadowIsOn: true,
            //     // slideIndex: 0,
            //     // flyerShadowIsOn: true,
            //     // bluerLayerIsOn: true,
            //   ),
            // ),
          );

        }
    );

  }
  /// --------------------------------------------------------------------------
}
