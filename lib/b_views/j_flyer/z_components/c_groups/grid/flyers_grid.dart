import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/future_flyer.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/c_add_flyer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/flyer_selection_stack.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersGrid({
    @required this.heroPath,
    this.gridWidth,
    this.gridHeight,
    this.scrollController,
    this.flyers,
    this.flyersIDs,
    this.topPadding = Ratioz.stratosphere,
    this.numberOfColumnsOrRows = 2,
    this.authorMode = false,
    this.onFlyerOptionsTap,
    this.selectedFlyers,
    this.onSelectFlyer,
    this.scrollDirection = Axis.vertical,
    this.isLoadingGrid = false,
    this.onFlyerNotFound,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<FlyerModel> flyers;
  final List<String> flyersIDs;
  final double gridWidth;
  final double gridHeight;
  final ScrollController scrollController;
  final double topPadding;
  /// depends on scroll dirction (vertical => numberOfColumns, horizontal => numberOfRows)
  final int numberOfColumnsOrRows;
  /// when grid is inside a flyer
  final String heroPath;
  final bool authorMode;
  final ValueChanged<FlyerModel> onFlyerOptionsTap;
  final List<FlyerModel> selectedFlyers;
  final ValueChanged<FlyerModel> onSelectFlyer;
  final Axis scrollDirection;
  final bool isLoadingGrid;
  final ValueChanged<String> onFlyerNotFound;
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
                || isLoadingGrid == true;

        if (_canBuild == false){
          throw FlutterError('FlyersGrid Widget should have either flyers or paginationFlyersIDs initialized');
        }

        return _canBuild;
      }(), 'can not build flyer');
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
            physics: const BouncingScrollPhysics(),
            padding: FlyerDim.flyerGridPadding(
              context: context,
              topPaddingValue: topPadding,
              gridSpacingValue: FlyerDim.flyerGridGridSpacingValue(_gridSlotWidth),
              isVertical: scrollDirection == Axis.vertical,
            ),
            gridDelegate: FlyerDim.flyerGridDelegate(
              flyerBoxWidth: _gridSlotWidth,
              numberOfColumnsOrRows: numberOfColumnsOrRows,
              scrollDirection: scrollDirection,
            ),
            itemCount: FlyerDim.flyerGridNumberOfSlots(
              flyersCount: flyersIDs?.length ?? flyers?.length ?? 0,
              addFlyerButtonIsOn: authorMode,
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
                if (authorMode == true && index == 0){
                  return AddFlyerButton(
                    flyerBoxWidth: _gridSlotWidth,
                  );
                }
                // ---------------------------------------------
                /// OTHERWISE
                else {

                  final int _flyerIndex = authorMode == true ? index-1 : index;

                  /// FLYER BY ID
                  if (flyersIDs != null){

                    final String _flyerID = flyersIDs[_flyerIndex];

                    return FutureFlyer(
                      key: ValueKey<String>('FutureFlyer:flyerID:$_flyerID'),
                      flyerID: _flyerID,
                      heroPath: '$heroPath/$_flyerID',
                      flyerBoxWidth: _gridSlotWidth,
                      isSelected: FlyerModel.flyersContainThisID(
                        flyers: selectedFlyers,
                        flyerID: _flyerID,
                      ),
                      onSelectFlyer: onSelectFlyer,
                      onFlyerOptionsTap: onFlyerOptionsTap,
                      onFlyerNotFound: () => onFlyerNotFound(_flyerID),
                    );

                  }

                  /// FLYER BY MODEL
                  else {

                    final FlyerModel _flyer =  flyers[_flyerIndex];

                    return FlyerSelectionStack(
                      key: ValueKey<String>('FlyerSelectionStack:flyerID:${_flyer?.id}'),
                      flyerModel: _flyer,
                      flyerBoxWidth: _gridSlotWidth,
                      heroPath: '$heroPath/${_flyer.id}',
                      onSelectFlyer: onSelectFlyer == null ? null : () => onSelectFlyer(_flyer),
                      onFlyerOptionsTap: onFlyerOptionsTap == null ? null : () => onFlyerOptionsTap(_flyer),
                      isSelected: FlyerModel.flyersContainThisID(
                        flyers: selectedFlyers,
                        flyerID: _flyer.id,
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
