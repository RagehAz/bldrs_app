import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_progress_bar.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:flutter/material.dart';

class AppBarProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AppBarProgressBar({
    @required this.loading,
    @required this.progressBarModel,
    @required this.appBarType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> loading;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final AppBarType appBarType;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _abWidth = BldrsAppBar.width(context);
    // --------------------
    final double _appBarHeight = BldrsAppBar.height(context, appBarType);
    // --------------------
    final EdgeInsets _margins = EdgeInsets.only(
        top: _appBarHeight - FlyerDim.progressStripThickness(_abWidth)
    );
    // --------------------
    return ValueListenableBuilder(
      valueListenable: loading,
      builder: (_, bool isLoading, Widget child){

        if (isLoading == true){
          return StaticProgressBar(
            index: 0,
            numberOfSlides: 1,
            opacity: 0.4,
            swipeDirection: SwipeDirection.freeze,
            loading: isLoading,
            flyerBoxWidth: _abWidth,
            margins: _margins,
            stripThicknessFactor: 0.4,
          );
        }

        else if (progressBarModel != null){
          return ValueListenableBuilder(
              valueListenable: progressBarModel,
              builder: (_, ProgressBarModel progressBarModel, Widget childB){

                return StaticProgressBar(
                  index: progressBarModel?.index,
                  numberOfSlides: progressBarModel?.numberOfStrips,
                  opacity: 1,
                  swipeDirection: progressBarModel?.swipeDirection,
                  loading: isLoading,
                  flyerBoxWidth: _abWidth,
                  margins: _margins,
                  stripThicknessFactor: 0.4,
                );

              }
          );
        }

        else {
          return const SizedBox();
        }

      },
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
