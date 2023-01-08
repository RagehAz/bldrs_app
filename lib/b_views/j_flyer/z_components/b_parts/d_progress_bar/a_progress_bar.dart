import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/b_progress_bar_child.drat.dart';

import 'package:flutter/material.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class ProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ProgressBar({
    @required this.flyerBoxWidth,
    @required this.progressBarModel,
    @required this.progressBarOpacity,
    @required this.tinyMode,
    this.loading = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final ValueNotifier<double> progressBarOpacity;
  final bool loading;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: const ValueKey<String>('ProgressBar'),
      width: flyerBoxWidth,
      child: ValueListenableBuilder<double>(
        valueListenable: progressBarOpacity,
        builder: (_, double _progressBarOpacity, Widget child){

          return AnimatedOpacity(
            duration: Ratioz.durationFading200,
            opacity: _progressBarOpacity,
            child: child,
          );

        },

        child: ProgressBarChild(
          flyerBoxWidth: flyerBoxWidth,
          progressBarModel: progressBarModel,
          tinyMode: tinyMode,
          loading: loading,
        ),

      ),
    );

  }
/// --------------------------------------------------------------------------
}
