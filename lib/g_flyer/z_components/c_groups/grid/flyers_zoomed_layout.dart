import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/g_flyer/z_components/c_groups/grid/components/flyers_z_grid.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/space/scale.dart';

class FlyersZoomedLayout extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersZoomedLayout({
    required this.canSwipeBack,
    this.columnsCount = 2,
    super.key
  });
  /// --------------------------------------------------------------------------
  final int columnsCount;
  final bool canSwipeBack;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel? _user = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final List<String> _flyersIDs = [...?_user?.savedFlyers?.all];

    return MainLayout(
      canSwipeBack: canSwipeBack,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      listenToHideLayout: true,
      child: FlyersZGrid(
        flyersIDs: _flyersIDs,
        gridWidth: Scale.screenWidth(context),
        gridHeight: Scale.screenHeight(context),
        columnCount: columnsCount,
        hasResponsiveSideMargin: true,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
