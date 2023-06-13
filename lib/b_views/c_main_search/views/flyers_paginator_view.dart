import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class FlyersPaginatorView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersPaginatorView({
    @required this.paginationController,
    @required this.fireQueryModel,
    Key key
  }) : super(key: key);
  // --------------------
  final FireQueryModel fireQueryModel;
  final PaginationController paginationController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return  FireCollPaginator(
        paginationQuery: fireQueryModel,
        paginationController: paginationController,
        builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

          final List<FlyerModel> _flyers = FlyerModel.decipherFlyers(
              maps: maps,
              fromJSON: false,
          );

          return FlyersGrid(
            gridWidth: Scale.screenWidth(context),
            gridHeight: Scale.screenHeight(context),
            flyers: _flyers,
            scrollController: paginationController.scrollController,
            screenName: 'allFlyersScreenGrid',
            // onFlyerOptionsTap: _onFlyerOptionsTap,
            isHeroicGrid: false,
            topPadding: Stratosphere.getStratosphereValue(
                context: context,
                appBarType: AppBarType.search,
            ),
            bottomPadding: Ratioz.horizon,
            // numberOfColumns: 2,
          );

        },
      );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
