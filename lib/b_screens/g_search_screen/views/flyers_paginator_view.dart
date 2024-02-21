import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/g_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class FlyersPaginatorView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersPaginatorView({
    required this.paginationController,
    required this.fireQueryModel,
    required this.gridType,
    required this.hasResponsiveSideMargin,
    this.topPadding,
    this.onFlyerOptionsTap,
    super.key
  });
  // --------------------
  final FireQueryModel? fireQueryModel;
  final PaginationController paginationController;
  final FlyerGridType gridType;
  final bool hasResponsiveSideMargin;
  final double? topPadding;
  final Function(FlyerModel? flyerModel)? onFlyerOptionsTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return  FireCollPaginator(
        paginationQuery: fireQueryModel,
        paginationController: paginationController,
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget? child){

          final List<FlyerModel> _flyers = FlyerModel.decipherFlyers(
              maps: maps,
              fromJSON: false,
          );

          // final bool _nothingFound = isLoading == false && _flyers.isEmpty;
          final bool _isLoading = isLoading == true && _flyers.isEmpty;

          return FlyersGrid(
            gridWidth: Scale.screenWidth(context),
            gridHeight: Scale.screenHeight(context),
            flyers: _flyers,
            scrollController: paginationController.scrollController,
            screenName: 'allFlyersScreenGrid',
            // onFlyerOptionsTap: _onFlyerOptionsTap,
            gridType: _isLoading == true ? FlyerGridType.loading : gridType,
            topPadding: topPadding ?? Stratosphere.getStratosphereValue(
                context: context,
                appBarType: AppBarType.search,
            ),
            bottomPadding: Ratioz.horizon,
            hasResponsiveSideMargin: hasResponsiveSideMargin,
            numberOfColumnsOrRows: Scale.isLandScape(context) == true ? 3 : 2,
            onFlyerOptionsTap: onFlyerOptionsTap,
            // numberOfColumns: 2,
          );

        },
      );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
