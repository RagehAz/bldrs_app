import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/counters/bz_counter_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/a_header/d_bz_slide/b_bz_slide.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class BzSlideTree extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzSlideTree({
    @required this.flyerBoxWidth,
    @required this.bzModel,
    @required this.flyerModel,
    @required this.headerPageOpacity,
    @required this.bzCounters,
    @required this.headerIsExpanded,
    @required this.tinyMode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final BzModel bzModel;
  final FlyerModel flyerModel;
  final ValueNotifier<double> headerPageOpacity;
  final ValueNotifier<BzCounterModel> bzCounters;
  final ValueNotifier<bool> headerIsExpanded;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: headerIsExpanded,
      builder: (_, bool isExpanded, Widget animatedBzSlide){

        if (isExpanded == true && tinyMode == false){
          return animatedBzSlide;
        }

        else {
          return const SizedBox();
        }

      },
      child: ValueListenableBuilder(
        valueListenable: headerPageOpacity,
        builder: (_, double _headerPageOpacity, Widget bzSlide){

          return AnimatedOpacity(
            duration: Ratioz.durationSliding400,
            curve: Curves.easeIn,
            opacity: _headerPageOpacity,
            child: bzSlide,
          );

        },
        child: BzSlide(
          flyerBoxWidth: flyerBoxWidth,
          bzModel: bzModel,
          bzCounters: bzCounters,
        ),

      ),
    );



  }
  /// --------------------------------------------------------------------------
}