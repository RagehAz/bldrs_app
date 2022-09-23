import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/x_flyer_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/f_statics/a_small_flyer.dart';
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
    @required this.flyerZone,
    @required this.isFullScreen,
    @required this.minWidthFactor,
    @required this.heroTag,
    // @required this.progressBarModel,
    // @required this.onSaveFlyer,
    // @required this.flyerIsSaved,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final ZoneModel flyerZone;
  final bool isFullScreen;
  final double minWidthFactor;
  final String heroTag;
  // final ValueNotifier<ProgressBarModel> progressBarModel;
  // final ValueNotifier<bool> flyerIsSaved;
  // final Function onSaveFlyer;
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
      minWidthFactor: minWidthFactor,
      animation: animation,
      flightContext: flightContext,
      flightDirection: flightDirection,
      fromHeroContext: fromHeroContext,
      toHeroContext: toHeroContext,
      // progressBarModel: progressBarModel,
      // flyerIsSaved: flyerIsSaved,
      // onSaveFlyer: onSaveFlyer,
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
      key: const ValueKey<String>('FlyerHero'),
      tag: _heroTag,
      flightShuttleBuilder: buildFlight,
      child: SmallFlyer(
        flyerBoxWidth: _flyerBoxWidth,
        bzModel: bzModel,
        flyerModel: flyerModel,
        heroTag: heroTag,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}