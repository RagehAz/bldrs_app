import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/layouts/handlers/max_bounce_navigator.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';

class GallerySlide extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const GallerySlide({
    required this.flyerBoxWidth,
    required this.flyerBoxHeight,
    required this.flyerModel,
    required this.bzModel,
    required this.onMaxBounce,
    this.heroTag,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final double flyerBoxHeight;
  final FlyerModel flyerModel;
  final BzModel bzModel;
  final String? heroTag;
  final Function onMaxBounce;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _headerAndProgressHeights = FlyerDim.headerSlateAndProgressHeights(
      flyerBoxWidth: flyerBoxWidth,
    );

    return MaxBounceNavigator(
      onNavigate: onMaxBounce,
      boxDistance: flyerBoxHeight - _headerAndProgressHeights,
      slideLimitRatio: 0.1,
      child: Container(
        color: Colorz.blackSemi255,
        child: FlyersGrid(
          gridWidth: flyerBoxWidth,
          gridHeight: flyerBoxHeight,
          flyersIDs: bzModel.publication.published,
          gridType: FlyerGridType.heroic,
          topPadding: _headerAndProgressHeights,
          bottomPadding: FlyerDim.flyerBottomCornerValue(flyerBoxWidth),
          // numberOfColumns: 2,
          screenName: heroTag ?? '',
          // scrollController: _scrollController,
          hasResponsiveSideMargin: false,
          numberOfColumnsOrRows: 2,
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
