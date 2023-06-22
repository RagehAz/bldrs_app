import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/flyers_grid_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/a_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/c_add_flyer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_builder.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_selection_stack.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';

class JumpingFlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const JumpingFlyersGrid({
    @required this.screenName,
    @required this.gridWidth,
    @required this.gridHeight,
    @required this.scrollController,
    @required this.flyers,
    @required this.flyersIDs,
    @required this.topPadding,
    @required this.numberOfColumnsOrRows,
    @required this.showAddFlyerButton,
    @required this.onFlyerOptionsTap,
    @required this.onSelectFlyer,
    @required this.scrollDirection,
    @required this.onFlyerNotFound,
    @required this.scrollable,
    @required this.selectionMode,
    @required this.bottomPadding,
    @required this.hasResponsiveSideMargin,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<FlyerModel> flyers;
  final List<String> flyersIDs;
  final double gridWidth;
  final double gridHeight;
  final ScrollController scrollController;
  final double topPadding;
  final int numberOfColumnsOrRows;
  final String screenName;
  final bool showAddFlyerButton;
  final Axis scrollDirection;
  final bool scrollable;
  final bool selectionMode;
  final Function(FlyerModel flyerModel) onFlyerOptionsTap;
  final Function(FlyerModel flyerModel) onSelectFlyer;
  final Function(String flyerID) onFlyerNotFound;
  final double bottomPadding;
  final bool hasResponsiveSideMargin;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _gridSlotWidth = FlyerDim.flyerGridFlyerBoxWidth(
      context: context,
      scrollDirection: scrollDirection,
      numberOfColumnsOrRows: numberOfColumnsOrRows,
      gridHeight: gridHeight,
      gridWidth: gridWidth,
      hasResponsiveSideMargin: hasResponsiveSideMargin,
    );
    // --------------------
    return FlyersGridBuilder(
        gridWidth: gridWidth,
        gridHeight: gridHeight,
        scrollController: scrollController,
        scrollable: scrollable,
        topPadding: topPadding,
        bottomPadding: bottomPadding,
        numberOfColumnsOrRows: numberOfColumnsOrRows,
        scrollDirection: scrollDirection,
        hasResponsiveSideMargin: hasResponsiveSideMargin,
        itemCount: FlyerDim.flyerGridNumberOfSlots(
          flyersCount: flyersIDs?.length ?? flyers?.length ?? 0,
          addFlyerButtonIsOn: showAddFlyerButton,
          isLoadingGrid: false,
          numberOfColumnsOrRows: numberOfColumnsOrRows,
        ),
        builder: (BuildContext ctx, int index){
          // ---------------------------------------------
          /// AUTHOR MODE FOR FIRST INDEX ADD FLYER BUTTON
          if (showAddFlyerButton == true && index == 0){
            return AddFlyerButton(
              flyerBoxWidth: _gridSlotWidth,
            );
          }
          // ---------------------------------------------
          /// OTHERWISE
          else {

            final int _flyerIndex = showAddFlyerButton == true ? index-1 : index;
            final String _flyerID = (flyersIDs?.length ?? 0) == 0 ? null : flyersIDs[_flyerIndex];
            final FlyerModel _flyer = (flyers?.length ?? 0) == 0 ? null : flyers[_flyerIndex];

            return FlyerBuilder(
              key: const ValueKey<String>('FlyerBuilder_inGrid'),
              flyerID: _flyerID,
              flyerModel: _flyer,
              flyerBoxWidth: _gridSlotWidth,
              onFlyerNotFound: onFlyerNotFound == null || _flyerID == null ?
              null : (String flyerID) => onFlyerNotFound(_flyerID),
              renderFlyer: RenderFlyer.firstSlide,
              builder: (FlyerModel smallFlyer) {

                return FlyerSelectionStack(
                  flyerModel: smallFlyer,
                  flyerBoxWidth: _gridSlotWidth,
                  onSelectFlyer: onSelectFlyer == null ? null : () => onSelectFlyer(smallFlyer),
                  onFlyerOptionsTap: onFlyerOptionsTap == null ? null : () => onFlyerOptionsTap(smallFlyer),
                  selectionMode: selectionMode,
                  flyerWidget: FlyerBox(
                    flyerBoxWidth: _gridSlotWidth,
                    boxColor: Colorz.bloodTest,
                    onTap: (){
                      blog('fuck you');
                    },
                  ),
                );
              },

            );

          }
          // ---------------------------------------------
        }
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
