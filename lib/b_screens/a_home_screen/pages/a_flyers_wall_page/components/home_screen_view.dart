import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_screens/a_home_screen/pages/a_flyers_wall_page/components/no_flyers_view.dart';
import 'package:bldrs/flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/e_back_end/x_queries/flyers_queries.dart';
import 'package:basics/z_grid/z_grid.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

class HomeFlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HomeFlyersGrid({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final ZGridController? _zGridController = HomeProvider.proGetHomeZGridController(
      context: context,
      listen: true,
    );

    final PaginationController? _paginationController = HomeProvider.proGetHomePaginationController(
      context: context,
      listen: true,
    );

    return FireCollPaginator(
      key: const ValueKey<String>('UserHomeScreen_FireCollPaginator'),
      paginationQuery: homeWallFlyersPaginationQuery(context),
      paginationController: _paginationController,
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

        if (Lister.checkCanLoop(_wallFlyers) == false){

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
              scrollController: _paginationController?.scrollController,
              zGridController: _zGridController,
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
