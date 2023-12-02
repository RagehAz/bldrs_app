import 'package:basics/animators/widgets/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/aa_no_flyers_view.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/e_back_end/x_queries/flyers_queries.dart';
import 'package:bldrs/z_grid/z_grid.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class HomeFlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HomeFlyersGrid({
    required this.paginationController,
    required this.zGridController,
    required this.loading,
    super.key
  });
  /// --------------------------------------------------------------------------
  final PaginationController? paginationController;
  final ZGridController? zGridController;
  final ValueNotifier<bool> loading;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FireCollPaginator(
      key: const ValueKey<String>('UserHomeScreen_FireCollPaginator'),
      paginationQuery: homeWallFlyersPaginationQuery(context),
      paginationController: paginationController,
      onDataChanged: (List<Map<String, dynamic>>? maps) async {

        final List<FlyerModel>? _wallFlyers = FlyerModel.decipherFlyers(
          maps: maps,
          fromJSON: false,
        );

        await FlyerLDBOps.insertFlyers(_wallFlyers);

      },
      builder: (_, List<Map<String, dynamic>>? maps, bool isLoading, Widget? child){

        final List<FlyerModel>? _wallFlyers = FlyerModel.decipherFlyers(
          maps: maps,
          fromJSON: false,
        );

        if (Mapper.checkCanLoopList(_wallFlyers) == false){

          if (isLoading == true){
            return FlyersGrid(
              gridType: FlyerGridType.loading,
              hasResponsiveSideMargin: true,
              screenName: 'userHomeScreen',
              numberOfColumnsOrRows: Scale.isLandScape(context) == true ? 3 : 2,
            );
          }

          else {

            return const WidgetFader(
                fadeType: FadeType.fadeIn,
                duration: Duration(seconds: 1),
                child: NoFlyersView()
            );
          }

        }

        else {


          return Center(
            child: FlyersGrid(
              scrollController: paginationController?.scrollController,
              zGridController: zGridController,
              gridWidth: Scale.screenWidth(context),
              gridHeight: Scale.screenHeight(context),
              flyers: _wallFlyers,
              screenName: 'userHomeScreen',
              gridType: FlyerGridType.zoomable,
              bottomPadding: Ratioz.horizon,
              numberOfColumnsOrRows: Scale.isLandScape(context) == true ? 3 : 2,
              hasResponsiveSideMargin: true,
            ),
          );
        }

      },
    );

  }
  /// --------------------------------------------------------------------------
}
