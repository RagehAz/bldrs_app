import 'package:bldrs/b_views/j_flyer/z_components/b_parts/d_progress_bar/d_progress_box.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/static_strips.dart';
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

    return  ProgressBox(
        flyerBoxWidth: flyerBoxWidth,
        stripsStack: <Widget>[

          Container(
            width: StaticStrips.stripsTotalLength(flyerBoxWidth),
            height: StaticStrips.stripThickness(flyerBoxWidth),
            decoration: BoxDecoration(
              color: StaticStrips.stripOffColor,
              borderRadius: StaticStrips.stripBorders(
                  context: context, flyerBoxWidth: flyerBoxWidth),
            ),
            child: LinearProgressIndicator(
              backgroundColor: Colorz.nothing,
              minHeight: StaticStrips.stripThickness(flyerBoxWidth),
              valueColor: const AlwaysStoppedAnimation(StaticStrips.stripFadedColor),
            ),
          ),

        ]
    );

  }
/// --------------------------------------------------------------------------
}
