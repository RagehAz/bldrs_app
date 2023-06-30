import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/x_saves_screen_controllers.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/z_grid/z_grid.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/space/scale.dart';

class SavedFlyersScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersScreenView({
    required this.selectionMode,
    required this.scrollController,
    required this.zGridController,
    super.key
  });
  /// --------------------------------------------------------------------------
  final bool selectionMode;
  final ScrollController scrollController;
  final ZGridController zGridController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: true,
    );

    return FlyersGrid(
      screenName: 'SavedFlyersGrid',
      scrollController: scrollController,
      selectionMode: selectionMode,
      onSelectFlyer: (FlyerModel flyer) => onSelectFlyerFromSavedFlyers(
        flyer: flyer,
      ),
      flyersIDs: _userModel?.savedFlyers?.all,
      onFlyerNotFound: (String flyerID) => autoRemoveSavedFlyerThatIsNotFound(
        flyerID: flyerID,
      ),
      numberOfColumnsOrRows: Scale.isLandScape(context) == true ? 4 : 3,
      gridType: FlyerGridType.zoomable,
      gridHeight: Scale.screenHeight(context),
      gridWidth: Scale.screenWidth(context),
      zGridController: zGridController,
      hasResponsiveSideMargin: true,
      // showAddFlyerButton: false,
      // scrollDirection: Axis.vertical,
    );

  }
  // -----------------------------------------------------------------------------
}
