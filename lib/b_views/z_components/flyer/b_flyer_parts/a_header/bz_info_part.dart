import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/counters/bz_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/max_header/max_header.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BzInfoPart extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzInfoPart({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.flyerModel,
    @required this.headerPageOpacity,
    @required this.bzCounters,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  final FlyerModel flyerModel;
  final ValueNotifier<double> headerPageOpacity; /// p
  final ValueNotifier<BzCounterModel> bzCounters;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // blog('BUILDING MAX HEADER INFO PART FOR ${flyerModel.id} where bzID is ${bzModel.id}');

    return ValueListenableBuilder(
        valueListenable: headerPageOpacity,
        child: MaxHeader(
          flyerBoxWidth: flyerBoxWidth,
          bzModel: bzModel,
          bzCounters: bzCounters,
        ),
        builder: (_, double _headerPageOpacity, Widget child){

          return AnimatedOpacity(
            duration: Ratioz.durationSliding400,
            curve: Curves.easeIn,
            opacity: _headerPageOpacity,
            child: child,
          );

        }
    );

  }
  /// --------------------------------------------------------------------------
}
