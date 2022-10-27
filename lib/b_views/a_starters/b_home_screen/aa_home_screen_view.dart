import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/a_starters/b_home_screen/x_home_screen_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/pull_to_refresh.dart';
import 'package:bldrs/e_back_end/b_fire/widgets/fire_coll_paginator.dart';
import 'package:bldrs/e_back_end/x_queries/flyers_queries.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const UserHomeScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
  /// --------------------------------------------------------------------------
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  // -----------------------------------------------------------------------------
  final ScrollController _scrollController = ScrollController();
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return FireCollPaginator(
      paginationQuery: homeWallFlyersPaginationQuery(context),
      builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){

        final List<FlyerModel> _wallFlyers = FlyerModel.decipherFlyers(
          maps: maps,
          fromJSON: false,
        );

        return PullToRefresh(
          onRefresh: () => onRefreshHomeWall(context),
          fadeOnBuild: true,
          child: FlyersGrid(
            gridWidth: Scale.superScreenWidth(context),
            gridHeight: Scale.superScreenHeight(context),
            flyers: _wallFlyers,
            scrollController: _scrollController,
            heroPath: 'userHomeScreen',
            // isLoadingGrid: isLoading,
          ),
        );

      },
    );

  }
  // -----------------------------------------------------------------------------
}
