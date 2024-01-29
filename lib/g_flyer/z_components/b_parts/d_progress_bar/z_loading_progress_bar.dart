import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/g_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/g_flyer/z_components/b_parts/d_progress_bar/d_progress_box.dart';
import 'package:flutter/material.dart';

class LoadingProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LoadingProgressBar({
    required this.flyerBoxWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _thickness = FlyerDim.progressStripThickness(flyerBoxWidth);
    final BorderRadius _corners = FlyerDim.progressStripCorners(
        flyerBoxWidth: flyerBoxWidth,
    );

    return  ProgressBox(
        flyerBoxWidth: flyerBoxWidth,
        stripsStack: <Widget>[

          Container(
            width: FlyerDim.progressStripsTotalLength(flyerBoxWidth),
            height: _thickness,
            decoration: BoxDecoration(
              color: FlyerColors.progressStripOffColor,
              borderRadius: _corners,
            ),
            child: LinearProgressIndicator(
              backgroundColor: Colorz.nothing,
              minHeight: _thickness,
              valueColor: const AlwaysStoppedAnimation(FlyerColors.progressStripFadedColor),
              borderRadius: _corners,
            ),
          ),

        ]
    );

  }
/// --------------------------------------------------------------------------
}
