import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_heroic_flyer_structure/a_heroic_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/future_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/c_add_flyer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_selection_stack.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:flutter/material.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class FlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersGrid({
    @required this.screenName,
    this.gridWidth,
    this.gridHeight,
    this.scrollController,
    this.flyers,
    this.flyersIDs,
    this.topPadding = Ratioz.stratosphere,
    this.numberOfColumnsOrRows = 2,
    this.showAddFlyerButton = false,
    this.onFlyerOptionsTap,
    this.selectedFlyers,
    this.onSelectFlyer,
    this.scrollDirection = Axis.vertical,
    this.isLoadingGrid = false,
    this.onFlyerNotFound,
    this.scrollable = true,
    this.selectionMode = false,
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
  final List<FlyerModel> selectedFlyers;
  final bool showAddFlyerButton;
  final Axis scrollDirection;
  final bool isLoadingGrid;
  final bool scrollable;
  final bool selectionMode;
  final Function(FlyerModel flyerModel) onFlyerOptionsTap;
  final Function(FlyerModel flyerModel) onSelectFlyer;
  final Function(String flyerID) onFlyerNotFound;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool showLoadingGridInstead({
    @required bool isLoadingGrid,
    @required List<FlyerModel> flyers,
    @required List<String> paginationFlyersIDs,
  }){
    bool _showLoadingGrid = true;

    if (isLoadingGrid == false){
      if (flyers != null || paginationFlyersIDs != null){
        _showLoadingGrid = false;
      }
    }

    return _showLoadingGrid;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    if (flyers == null && flyersIDs == null && isLoadingGrid == false){
      // blog('B1 - BUILDING sizedBox');
      return const SizedBox();
    }

    else {
      // --------------------
      assert((){
        final bool _canBuild =
                flyers != null
                ||
                flyersIDs != null
                ||
                isLoadingGrid == true;

        if (_canBuild == false){
          throw FlutterError('FlyersGrid Widget should have either flyers or paginationFlyersIDs initialized');
        }

        return _canBuild;
      }(), 'You either give me (List<FlyerModel> flyers) or '
          '(List<String> flyersIDs) or '
          'switch on (isLoadingGrid) but '
          'never leave me like this empty handed with nulls & nulls');
      // --------------------
      final bool _isLoadingGrid = showLoadingGridInstead(
        flyers : flyers,
        paginationFlyersIDs: flyersIDs,
        isLoadingGrid: isLoadingGrid,
      );
      // --------------------
      final double _gridSlotWidth = FlyerDim.flyerGridFlyerBoxWidth(
        context: context,
        scrollDirection: scrollDirection,
        numberOfColumnsOrRows: numberOfColumnsOrRows,
        gridHeight: gridHeight,
        gridWidth: gridWidth,
      );
      // --------------------
      return SizedBox(
        key: const ValueKey<String>('Stack_of_flyers_grid'),
        width: FlyerDim.flyerGridWidth(
          context: context,
          givenGridWidth: gridWidth,
        ),
        height: FlyerDim.flyerGridHeight(
          context: context,
          givenGridHeight: gridHeight,
        ),
        child: GridView.builder(
            controller: scrollController,
            physics: scrollable == true ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
            padding: FlyerDim.flyerGridPadding(
              context: context,
              topPaddingValue: topPadding,
              gridSpacingValue: FlyerDim.flyerGridGridSpacingValue(_gridSlotWidth),
              isVertical: scrollDirection == Axis.vertical,
            ),
            gridDelegate: FlyerDim.flyerGridDelegate(
              context: context,
              forceMaxHeight: false,
              flyerBoxWidth: _gridSlotWidth,
              numberOfColumnsOrRows: numberOfColumnsOrRows,
              scrollDirection: scrollDirection,
            ),
            itemCount: FlyerDim.flyerGridNumberOfSlots(
              flyersCount: flyersIDs?.length ?? flyers?.length ?? 0,
              addFlyerButtonIsOn: showAddFlyerButton,
              isLoadingGrid: isLoadingGrid,
              numberOfColumnsOrRows: numberOfColumnsOrRows,
            ),
            scrollDirection: scrollDirection,
            itemBuilder: (BuildContext ctx, int index){
              // ---------------------------------------------------------------
              /// WHEN IS JUST A LOADING GRID
              if (_isLoadingGrid == true){
                return FlyerLoading(
                  flyerBoxWidth: _gridSlotWidth,
                  animate: true,
                  // boxColor: Colorz.bloodTest,
                );
              }
              // ---------------------------------------------------------------
              /// ACTUAL FLYERS
              else {
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

                  /// FLYER BY ID
                  if (flyersIDs != null){

                    final String _flyerID = flyersIDs[_flyerIndex];

                    return FlyerBuilder(
                      key: ValueKey<String>('FutureFlyer:flyerID:$_flyerID'),
                      flyerID: _flyerID,
                      flyerBoxWidth: _gridSlotWidth,
                      onFlyerNotFound: () => onFlyerNotFound(_flyerID),
                      builder: (FlyerModel _flyer) {

                        return FlyerSelectionStack(
                          flyerModel: _flyer,
                          flyerBoxWidth: _gridSlotWidth,
                          onSelectFlyer: onSelectFlyer == null ? null : () => onSelectFlyer(_flyer),
                          onFlyerOptionsTap: onFlyerOptionsTap == null ? null : () => onFlyerOptionsTap(_flyer),
                          selectionMode: selectionMode,
                          flyerWidget: HeroicFlyer(
                            flyerModel: _flyer,
                            flyerBoxWidth: _gridSlotWidth,
                            screenName: screenName,
                          ),
                        );
                      },
                    );

                  }

                  /// FLYER BY MODEL
                  else {

                    final FlyerModel _flyer =  flyers[_flyerIndex];

                    return FlyerSelectionStack(
                      key: ValueKey<String>('FlyerSelectionStack:flyerID:${_flyer?.id}'),
                      flyerModel: _flyer,
                      flyerBoxWidth: _gridSlotWidth,
                      onSelectFlyer: onSelectFlyer == null ? null : () => onSelectFlyer(_flyer),
                      onFlyerOptionsTap: onFlyerOptionsTap == null ? null : () => onFlyerOptionsTap(_flyer),
                      selectionMode: selectionMode,
                      flyerWidget: HeroicFlyer(
                        flyerModel: _flyer,
                        flyerBoxWidth: _gridSlotWidth,
                        screenName: screenName,
                      ),
                    );

                  }

                }
                // ---------------------------------------------
              }
              // ---------------------------------------------------------------
            }

        ),
      );
      // --------------------
    }

  }
  // -----------------------------------------------------------------------------
}
