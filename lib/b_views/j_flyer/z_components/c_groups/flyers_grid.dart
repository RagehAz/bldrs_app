import 'dart:async';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/x_saves_screen_controllers.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/flyer_selection_stack.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/c_add_flyer_button.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
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
    this.paginationFlyersIDs,
    this.topPadding = Ratioz.stratosphere,
    this.numberOfColumnsOrRows = 2,
    this.authorMode = false,
    this.onFlyerOptionsTap,
    this.selectedFlyers,
    this.onSelectFlyer,
    this.scrollDirection = Axis.vertical,
    this.isLoadingGrid = false,
    this.removeFlyerIDFromMySavedFlyersIDIfNoFound = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<FlyerModel> flyers;
  final List<String> paginationFlyersIDs;
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
  final bool removeFlyerIDFromMySavedFlyersIDIfNoFound;
  /// --------------------------------------------------------------------------
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
    // --------------------
    assert((){
      final bool _canBuild =
          flyers != null
              ||
              paginationFlyersIDs != null
              || isLoadingGrid == true;

      if (_canBuild == false){
        throw FlutterError('FlyersGrid Widget should have either flyers or paginationFlyersIDs initialized');
      }

      return _canBuild;
    }(), 'fuck you');
    // --------------------
    final bool _showLoadingGrid = showLoadingGridInstead(
      flyers : flyers,
      paginationFlyersIDs: paginationFlyersIDs,
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
            flyersCount: paginationFlyersIDs?.length ?? flyers?.length ?? 0,
            addFlyerButtonIsOn: authorMode,
            isLoadingGrid: isLoadingGrid,
            numberOfColumnsOrRows: numberOfColumnsOrRows,
          ),
          scrollDirection: scrollDirection,
          itemBuilder: (BuildContext ctx, int index){

            /// WHEN IS JUST A LOADING GRID
            if (_showLoadingGrid == true){

              return FlyerLoading(
                flyerBoxWidth: _gridSlotWidth,
                animate: false,
              );

            }

            /// ACTUAL FLYERS
            else {

              /// AUTHOR MODE FOR FIRST INDEX ADD FLYER BUTTON
              if (authorMode == true && index == 0){
                return AddFlyerButton(
                  flyerBoxWidth: _gridSlotWidth,
                );
              }

              /// OTHERWISE
              else {

                final int _flyerIndex = authorMode == true ? index-1 : index;

                /// FLYERS PAGINATION IDS IS DEFINED
                if (paginationFlyersIDs != null){

                  final String _flyerID = paginationFlyersIDs[_flyerIndex];

                  return FutureBuilder(
                      future: FlyerProtocols.fetchFlyer(
                        context: context,
                        flyerID: _flyerID,
                      ),
                      builder: (_, AsyncSnapshot<Object> snap){

                        final FlyerModel _flyerModel = snap?.data;
                        final bool _isSelected = FlyerModel.flyersContainThisID(
                          flyers: selectedFlyers,
                          flyerID: _flyerModel?.id,
                        );

                        if (Streamer.connectionIsLoading(snap) == true){

                          return FlyerLoading(
                            flyerBoxWidth: _gridSlotWidth,
                            animate: false,
                          );

                        }

                        else {

                          if (_flyerModel == null){

                            if (removeFlyerIDFromMySavedFlyersIDIfNoFound == true){
                              unawaited(autoRemoveSavedFlyerThatIsNotFound(
                                context: context,
                                flyerID: _flyerID,
                              ));
                            }

                            return const SizedBox();
                          }

                          {
                            return FlyerSelectionStack(
                              flyerModel: _flyerModel,
                              flyerBoxWidth: _gridSlotWidth,
                              heroPath: heroPath,
                              onSelectFlyer: onSelectFlyer == null ? null : () => onSelectFlyer(_flyerModel),
                              onFlyerOptionsTap: onFlyerOptionsTap == null ? null : () => onFlyerOptionsTap(_flyerModel),
                              isSelected: _isSelected,
                            );
                          }

                        }

                      }
                  );

                }

                /// SHOULD HAVE FLYERS MODELS GIVEN
                else {

                  final FlyerModel _flyer =  flyers[_flyerIndex];

                  final bool _isSelected = FlyerModel.flyersContainThisID(
                    flyers: selectedFlyers,
                    flyerID: _flyer.id,
                  );

                  return FlyerSelectionStack(
                    flyerModel: _flyer,
                    flyerBoxWidth: _gridSlotWidth,
                    heroPath: heroPath,
                    onSelectFlyer: onSelectFlyer == null ? null : () => onSelectFlyer(_flyer),
                    onFlyerOptionsTap: onFlyerOptionsTap == null ? null : () => onFlyerOptionsTap(_flyer),
                    isSelected: _isSelected,
                  );

                }

              }

            }

          }

      ),

    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
