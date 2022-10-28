import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/flyers_grid.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class SavedFlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SavedFlyersGrid({
    @required this.flyersIDs,
    @required this.selectionMode,
    @required this.scrollController,
    this.selectedFlyers,
    this.onSelectFlyer,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<String> flyersIDs;
  final List<FlyerModel> selectedFlyers;
  final bool selectionMode;
  final Function onSelectFlyer;
  final ScrollController scrollController;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(flyersIDs) == true){
      return FlyersGrid(
        heroPath: 'SavedFlyersGrid',
        scrollController: scrollController,
        onSelectFlyer: onSelectFlyer,
        selectedFlyers: selectedFlyers,
        flyersIDs: flyersIDs,
        removeFlyerIDFromMySavedFlyersIDIfNoFound: true,
        numberOfColumnsOrRows: 3,
      );
    }

    else {
      return const SizedBox();
    }

  }
  /// --------------------------------------------------------------------------
}
