import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/d_progress_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class LoadingProgressBar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const LoadingProgressBar({
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _thickness = FlyerDim.progressStripThickness(flyerBoxWidth);

    return  ProgressBox(
        flyerBoxWidth: flyerBoxWidth,
        stripsStack: <Widget>[

          Container(
            width: FlyerDim.progressStripsTotalLength(flyerBoxWidth),
            height: _thickness,
            decoration: BoxDecoration(
              color: FlyerColors.progressStripOffColor,
              borderRadius: FlyerDim.progressStripCorners(
                  context: context,
                  flyerBoxWidth: flyerBoxWidth,
              ),
            ),
            child: LinearProgressIndicator(
              backgroundColor: Colorz.nothing,
              minHeight: _thickness,
              valueColor: const AlwaysStoppedAnimation(FlyerColors.progressStripFadedColor),
            ),
          ),

        ]
    );

  }
/// --------------------------------------------------------------------------
}
