import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
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

    return Mapper.checkCanLoopList(flyersIDs) == false ?
    const SizedBox()
        :
    FlyersGrid(
      heroTag: 'SavedFlyersGrid',
      scrollController: scrollController,
      onSelectFlyer: onSelectFlyer,
      selectedFlyers: selectedFlyers,
      paginationFlyersIDs: flyersIDs,
      removeFlyerIDFromMySavedFlyersIDIfNoFound: true,
      numberOfColumnsOrRows: 3,
    );

  }
/// --------------------------------------------------------------------------
}
