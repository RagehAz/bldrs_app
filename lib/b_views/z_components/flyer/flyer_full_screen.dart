import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/flyer_hero.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';

class FlyerFullScreen extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerFullScreen({
    @required this.minWidthFactor,
    this.flyerModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final double minWidthFactor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismiss: () => Navigator.of(context).pop(),
      isFullScreen: false,
      dragSensitivity: .4,
      maxTransformValue: 4,
      // direction: DismissDirection.horizontal,
      reverseDuration: Ratioz.duration150ms,


      child: Material(
        color: Colors.transparent,
        type: MaterialType.transparency,

        child: FlyerHero(
          flyerModel: flyerModel,
          isFullScreen: true,
          minWidthFactor: minWidthFactor,
        ),
        // child: Hero(
        //   tag: flyerModel.id,
        //   flightShuttleBuilder: (
        //       BuildContext flightContext,
        //       Animation<double> animation,
        //       HeroFlightDirection flightDirection,
        //       BuildContext fromHeroContext,
        //       BuildContext toHeroContext,
        //       ) {
        //     return FlyerHero.flyerFlightShuttle(
        //       flyerModel: flyerModel,
        //       animation: animation,
        //       flightContext: flightContext,
        //       flightDirection: flightDirection,
        //       fromHeroContext: fromHeroContext,
        //       toHeroContext: toHeroContext,
        //     );
        //   },
        //   child: AbstractFlyer(
        //     sizeFactor: 1,
        //     flyerModel: flyerModel,
        //   ),
        // ),
      ),
    );
  }
}
