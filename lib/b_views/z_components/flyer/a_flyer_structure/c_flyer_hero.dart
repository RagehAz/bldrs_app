import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/d_flyer_tree.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/flyer_controller.dart';
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
    @required this.bzZone,
    @required this.flyerZone,
    @required this.isFullScreen,
    @required this.minWidthFactor,
    @required this.heroTag,
    @required this.currentSlideIndex,
    @required this.onSaveFlyer,
    @required this.flyerIsSaved,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final ZoneModel bzZone;
  final ZoneModel flyerZone;
  final bool isFullScreen;
  final double minWidthFactor;
  final String heroTag;
  final ValueNotifier<int> currentSlideIndex;
  final ValueNotifier<bool> flyerIsSaved;
  final Function onSaveFlyer;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _heroTag = createHeroTag(
        heroTag: heroTag,
        flyerID: flyerModel.id,
    );
    final double _factor = isFullScreen ?  1 : minWidthFactor;
    final double _flyerBoxWidth = FlyerBox.width(context, _factor);

    // blog('THE FUCKING BITCH ASS FLYER : ${flyerModel.id} SHOULD START AT : ${currentSlideIndex.value}');

    return Hero(
      key: ValueKey<String>(_heroTag),
      tag: _heroTag,
      flightShuttleBuilder: (
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
          currentSlideIndex: currentSlideIndex,
          flyerIsSaved: flyerIsSaved,
          onSaveFlyer: onSaveFlyer,
        );
      },

      child: FlyerTree(
        flyerBoxWidth: _flyerBoxWidth,
        flyerModel: flyerModel,
        bzModel: bzModel,
        bzZone: bzZone,
        flyerZone: flyerZone,
        heroTag: _heroTag,
        flightDirection: FlightDirection.non,
        currentSlideIndex: currentSlideIndex,
        onSaveFlyer: onSaveFlyer,
        flyerIsSaved: flyerIsSaved,
      ),

    );
  }
}
