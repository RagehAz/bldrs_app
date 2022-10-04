import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/saved_flyers_grid.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/x_saves_screen_controllers.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedFlyersScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersScreenView({
    @required this.selectionMode,
    @required this.scrollController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool selectionMode;
  final ScrollController scrollController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final UserModel _userModel = UsersProvider.proGetMyUserModel(context: context, listen: true);

    if (selectionMode == true){
      return Consumer<FlyersProvider>(
        builder: (_, FlyersProvider flyersProvider, Widget child){

          final List<FlyerModel> _selectedFlyers = flyersProvider.selectedFlyers;

          return SavedFlyersGrid(
            scrollController: scrollController,
            selectionMode: true,
            onSelectFlyer: (FlyerModel flyer) => onSelectFlyerFromSavedFlyers(
              context: context,
              flyer: flyer,
            ),
            selectedFlyers: _selectedFlyers,
            flyersIDs: _userModel.savedFlyersIDs,
          );

        },
      );
    }

    else {
      return SavedFlyersGrid(
        scrollController: scrollController,
        selectionMode: false,
        flyersIDs: _userModel.savedFlyersIDs,
      );
    }

  }
  // -----------------------------------------------------------------------------
}
