import 'package:bldrs/b_views/widgets/specific/flyer/parts/progress_bar_parts/old_strips.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/d_progress_bar/progress_box.dart';
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
        strips: <Widget>[

          Container(
            width: OldStrips.stripsTotalLength(flyerBoxWidth),
            height: OldStrips.stripThickness(flyerBoxWidth),
            decoration: BoxDecoration(
              color: OldStrips.stripOffColor,
              borderRadius: OldStrips.stripBorders(
                  context: context, flyerBoxWidth: flyerBoxWidth),
            ),
            child: LinearProgressIndicator(
              backgroundColor: Colorz.nothing,
              minHeight: OldStrips.stripThickness(flyerBoxWidth),
              valueColor: const AlwaysStoppedAnimation(OldStrips.stripFadedColor),
            ),
          ),

        ]
    );
  }
}
