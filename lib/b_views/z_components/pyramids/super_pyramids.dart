import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_expanding_pyramid.dart';
import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/obelisk/obelisk_pyramids.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:flutter/material.dart';

class SuperPyramids extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperPyramids({
    @required this.progressBarModel,
    @required this.onRowTap,
    @required this.onExpansion,
    @required this.isExpanded,
    @required this.navModels,
    this.isYellow = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<bool> isExpanded;
  final ValueNotifier<ProgressBarModel> progressBarModel;
  final Function onExpansion;
  final ValueChanged<int> onRowTap;
  final List<NavModel> navModels;
  final bool isYellow;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Stack(
      key: const ValueKey('SuperPyramids'),
      children: <Widget>[

        /// SINGLE PYRAMID
        ObeliskExpandingPyramid(
          isExpanded: isExpanded,
        ),

        /// OBELISK
        Obelisk(
          isExpanded: isExpanded,
          onTriggerExpansion: onExpansion,
          onRowTap: onRowTap,
          progressBarModel: progressBarModel,
          navModels: navModels,
        ),

        /// PYRAMIDS
        ObeliskPyramids(
          isExpanded: isExpanded,
          isYellow: isYellow,
        ),

      ],
    );

  }
// -----------------------------------------------------------------------------
}
