import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/pull_to_refresh.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_paginator.dart';
import 'package:bldrs/e_back_end/x_queries/flyers_queries.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:scale/scale.dart';
import 'package:flutter/material.dart';

class HomeFlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const HomeFlyersGrid({
    @required this.scrollController,
    Key key
  }) : super(key: key);

  final ScrollController scrollController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('fuck');

    return FireCollPaginator(
      key: const ValueKey<String>('UserHomeScreen_FireCollPaginator'),
      paginationQuery: homeWallFlyersPaginationQuery(context),
      // scrollController: scrollController,
      onDataChanged: (List<Map<String, dynamic>> maps) async {

        final List<FlyerModel> _wallFlyers = FlyerModel.decipherFlyers(
          maps: maps,
          fromJSON: false,
        );

        await FlyerLDBOps.insertFlyers(_wallFlyers);

      },
      builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

        final List<FlyerModel> _wallFlyers = FlyerModel.decipherFlyers(
          maps: maps,
          fromJSON: false,
        );

        blog('fuck2 : ${_wallFlyers.length} : isLoading : $isLoading');

        return PullToRefresh(
          onRefresh: () => onRefreshHomeWall(context),
          fadeOnBuild: true,
          child: FlyersGrid(
            // scrollController: scrollController,
            gridWidth: Scale.screenWidth(context),
            gridHeight: Scale.screenHeight(context),
            flyers: _wallFlyers,
            screenName: 'userHomeScreen',
            isHeroicGrid: true,
          ),
        );

      },
    );

  }
  /// --------------------------------------------------------------------------
}

/// DEPRECATED
// class UserHomeScreen extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const UserHomeScreen({
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   @override
//   _UserHomeScreenState createState() => _UserHomeScreenState();
//   /// --------------------------------------------------------------------------
// }
//
// class _UserHomeScreenState extends State<UserHomeScreen> {
//   // -----------------------------------------------------------------------------
//   final ScrollController _scrollController = ScrollController();
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     blog('UserHomeScreen : initState');
//     super.initState();
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//     if (_isInit) {
//
//     }
//     _isInit = false;
//     super.didChangeDependencies();
//   }
//   // --------------------
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return FireCollPaginator(
//       key: const ValueKey<String>('UserHomeScreen_FireCollPaginator'),
//       paginationQuery: homeWallFlyersPaginationQuery(context),
//       builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){
//
//         final List<FlyerModel> _wallFlyers = FlyerModel.decipherFlyers(
//           maps: maps,
//           fromJSON: false,
//         );
//
//         return PullToRefresh(
//           onRefresh: () => onRefreshHomeWall(context),
//           fadeOnBuild: true,
//           child: FlyersGrid(
//             gridWidth: Scale.screenWidth(context),
//             gridHeight: Scale.screenHeight(context),
//             flyers: _wallFlyers,
//             scrollController: _scrollController,
//             heroPath: 'userHomeScreen',
//             // isLoadingGrid: isLoading,
//           ),
//         );
//
//       },
//     );
//
//   }
//   // -----------------------------------------------------------------------------
// }
