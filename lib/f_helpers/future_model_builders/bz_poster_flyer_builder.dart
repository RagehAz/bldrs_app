import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:basics/helpers/streamers/streamer.dart';
import 'package:flutter/material.dart';

class BzPosterFlyerBuilder extends StatelessWidget {
  // --------------------------------------------------------------------------
  const BzPosterFlyerBuilder({
    required this.bzID,
    required this.builder,
    this.maxSlides = 7,
    super.key
  });
  // -------------------------
  final String? bzID;
  final Widget Function(bool loading, FlyerModel? flyer) builder;
  final int maxSlides;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return FutureBuilder(
      future: FlyerProtocols.fetchAndCombineBzSlidesInOneFlyer(
        bzID: bzID,
        maxSlides: maxSlides,
      ),
      builder: (_, AsyncSnapshot<FlyerModel?> flyerSnap){

        final FlyerModel? _bzSlidesInFlyer = flyerSnap.data;

        return builder(Streamer.connectionIsLoading(flyerSnap), _bzSlidesInFlyer);

        },
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
