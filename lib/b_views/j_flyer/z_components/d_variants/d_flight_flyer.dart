import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/b_flyer_hero.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/c_small_flyer.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlightFlyer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlightFlyer({
    @required this.flightContext,
    @required this.animation, // 0 to 1
    @required this.flightDirection,
    @required this.flyerModel,
    @required this.bzModel,
    @required this.flyerBoxWidth,
    @required this.heroTag,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BuildContext flightContext;
  final Animation<double> animation;
  final HeroFlightDirection flightDirection;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final double flyerBoxWidth;
  final String heroTag;
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  FlightDirection getFlightDirection(String direction){

    switch(direction){
      case 'push': return FlightDirection.push; break;
      case 'pop' : return FlightDirection.pop; break;
      default: return FlightDirection.non;
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// 'push' if expanding --- 'pop' if contracting
    final String _flightDirectionName = flightDirection.name;

    final Curve _curve = _flightDirectionName == 'push' ? Curves.fastOutSlowIn : Curves.fastOutSlowIn.flipped;

    final Tween<double> _tween = _flightDirectionName == 'push' ?
    Tween<double>(begin: 0, end: 1)
        :
    Tween<double>(begin: 1, end: 0);

    return TweenAnimationBuilder(
        key: const ValueKey<String>('FlyerHero_TweenAnimationBuilder'),
        tween: _tween,
        duration: Ratioz.duration150ms,
        curve: _curve,
        builder: (ctx, double value, Widget child){

          // final double _flyerWidthFactor = flyerWidthSizeFactor(
          //   tween: value,
          //   minWidthFactor: minWidthFactor,
          //   // maxWidthFactor: 1, REDUNDANT
          // );

          // final double _flyerBoxWidth = FlyerDim.flyerWidthByFactor(flightContext, _flyerWidthFactor);

          final FlightDirection _flightDirection = getFlightDirection(flightDirection.name);

          return Scaffold(
            backgroundColor: Colorz.nothing,
            body: SmallFlyer(
              flyerModel: flyerModel,
              bzModel: bzModel,
              flyerBoxWidth: flyerBoxWidth,
              flightTweenValue: value,
              flightDirection: _flightDirection,
              heroTag: heroTag,
            ),
          );

        }
    );

  }
  // -----------------------------------------------------------------------------
}
