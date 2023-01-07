import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/b_heroic_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/c_heroic_small_flyer.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlightFlyer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlightFlyer({
    @required this.flightDirection,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.flyerBoxWidth,
    @required this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final HeroFlightDirection flightDirection;
  final FlyerModel flyerModel;
  final BzModel bzModel;
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
    Tween<double>(begin: 0.01, end: 0.95)
        :
    Tween<double>(begin: 0.95, end: 0);

    return TweenAnimationBuilder(
        key: const ValueKey<String>('FlyerHero_TweenAnimationBuilder'),
        tween: _tween,
        duration: Ratioz.duration150ms,
        curve: _curve,
        builder: (ctx, double value, Widget child){

          final FlightDirection _flightDirection = getFlightDirection(flightDirection.name);

          return Material(
            type: MaterialType.transparency,
            child: HeroicSmallFlyer(
              flyerModel: flyerModel,
              bzModel: bzModel,
              flyerBoxWidth: flyerBoxWidth,
              flightTweenValue: value,
              flightDirection: _flightDirection,
              heroTag: heroTag,
              // canBuildBigFlyer: false, // DEFAULT
            ),
          );

        }
    );

  }
  /// --------------------------------------------------------------------------
}
