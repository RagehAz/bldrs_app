import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/zoomable_flyers_grid.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class FlyersZoomedLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersZoomedLayout({
    this.columnsCount = 2,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final int columnsCount;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _user = UsersProvider.proGetMyUserModel(context: context, listen: false);
    final List<String> _flyersIDs = [..._user.savedFlyers.all];

    return MainLayout(
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      listenToHideLayout: true,
      child: ZoomableFlyersGrid(
        flyersIDs: _flyersIDs,
        gridWidth: Scale.screenWidth(context),
        gridHeight: Scale.screenHeight(context),
        columnCount: columnsCount,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
