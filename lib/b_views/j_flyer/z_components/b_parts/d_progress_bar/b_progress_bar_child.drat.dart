import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/c_strips.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/z_loading_progress_bar.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:flutter/material.dart';

class ProgressBarChild extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ProgressBarChild({
    required this.flyerBoxWidth,
    required this.progressBarModel,
    required this.tinyMode,
    this.loading = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final ValueNotifier<ProgressBarModel?> progressBarModel;
  final bool tinyMode;
  final bool loading;
  /// --------------------------------------------------------------------------
  bool _progressBarIsLoading({
    required int? numberOfSlides
  }){
    bool _isLoading = false;

    if (loading == true || numberOfSlides == null){
      _isLoading = true;
    }

    return _isLoading;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: progressBarModel,
        child: Strips(
          flyerBoxWidth: flyerBoxWidth,
          progressBarModel: progressBarModel,
          tinyMode: tinyMode,
        ),
        builder: (_, ProgressBarModel? progModel, Widget? child){

          if (_progressBarIsLoading(numberOfSlides: progModel?.numberOfStrips) == true){
            return LoadingProgressBar(
              flyerBoxWidth: flyerBoxWidth,
            );
          }

          else if (Strips.canBuildStrips(progModel?.numberOfStrips) == true){
            return child!;
          }

          else {
            return const SizedBox();
          }


        }
    );

  }
// -----------------------------------------------------------------------------
}
