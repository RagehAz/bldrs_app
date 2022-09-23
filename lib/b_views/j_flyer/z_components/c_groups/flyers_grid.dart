import 'dart:async';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/flyer_selection_stack.dart';
import 'package:bldrs/b_views/j_flyer/z_components/d_variants/add_flyer_button.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/x_saves_screen_controllers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersGrid({
    @required this.heroTag,
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
  final String heroTag;
  final bool authorMode;
  final ValueChanged<FlyerModel> onFlyerOptionsTap;
  final List<FlyerModel> selectedFlyers;
  final ValueChanged<FlyerModel> onSelectFlyer;
  final Axis scrollDirection;
  final bool isLoadingGrid;
  final bool removeFlyerIDFromMySavedFlyersIDIfNoFound;
  /// --------------------------------------------------------------------------
  static double getGridWidth({
    @required BuildContext context,
    @required double givenGridWidth,
  }){
    return givenGridWidth ?? Scale.superScreenWidth(context);
  }
  // --------------------
  static double getGridHeight({
    @required BuildContext context,
    @required double givenGridHeight,
  }){
    return givenGridHeight ?? Scale.superScreenHeight(context);
  }
  // --------------------
  static const double _spacingRatio = 0.03;
  // --------------------
  static double getVerticalScrollFlyerBoxWidth({
    @required double gridZoneWidth,
    @required int numberOfColumns,
  }){
    final double _flyerBoxWidth =
        gridZoneWidth /
            (
                numberOfColumns
                    + (numberOfColumns * _spacingRatio)
                    + _spacingRatio
            );
    return _flyerBoxWidth;
  }
  // --------------------
  static double getHorizontalScrollFlyerBoxWidth({
    @required BuildContext context,
    @required double gridZoneHeight,
    @required int numberOfRows,
  }){

    final double _flyerBoxWidth =
        gridZoneHeight
            /
            ( (numberOfRows * FlyerDim.xFlyerBoxHeight) + (numberOfRows * _spacingRatio) + _spacingRatio );

    /// REVERSE MATH TEST
    // final double _flyerBoxHeight = _flyerBoxWidth * Ratioz.xxflyerZoneHeight;
    // final double spacing = getGridSpacingValue(flyerBoxWidth: _flyerBoxWidth);
    // final double _result = (_flyerBoxHeight * numberOfRows) + (spacing * (numberOfRows + 1));
    // blog('result : $_result = ($_flyerBoxHeight * $numberOfRows) + ($spacing * ($numberOfRows + 1))');

    return _flyerBoxWidth;
  }
  // --------------------
  static double getGridSpacingValue({
    @required double flyerBoxWidth,
  }){
    return flyerBoxWidth * _spacingRatio;
  }
  // --------------------
  static EdgeInsets getGridPadding({
    @required BuildContext context,
    @required double gridSpacingValue,
    @required double topPaddingValue,
    @required bool isVertical,
  }){

    return Scale.superInsets(
      context: context,
      enLeft: gridSpacingValue,
      top: isVertical == true ? topPaddingValue : gridSpacingValue,
      enRight: isVertical == true ? gridSpacingValue : Ratioz.horizon,
      bottom: isVertical == true ? Ratioz.horizon : 0,
    );

  }
  // --------------------
  static double getFlyerMinWidthFactor({
    @required double gridFlyerWidth,
    @required double gridZoneWidth,
  }){
    return gridFlyerWidth / gridZoneWidth;
  }
  // --------------------
  static int getNumberOfGridSlots({
    @required int flyersCount,
    @required bool addFlyerButtonIsOn,
    @required bool isLoadingGrid,
    @required int numberOfColumnsOrRows,
  }){
    int _slotsCount = flyersCount;

    if (isLoadingGrid == true){
      _slotsCount = numberOfColumnsOrRows * numberOfColumnsOrRows;
      if (_slotsCount == 1){
        _slotsCount = 5;
      }
    }

    else if (addFlyerButtonIsOn == true){
      _slotsCount = _slotsCount + 1;
    }

    return _slotsCount;
  }
  // --------------------
  static double calculateFlyerBoxWidth({
    BuildContext context,
    int flyersLength
  }) {
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _gridWidth = _screenWidth - (2 * Ratioz.appBarMargin);
    final int _numberOfColumns = gridColumnCount(flyersLength);
    final double _flyerBoxWidth =
        (_gridWidth - ((_numberOfColumns - 1) * Ratioz.appBarMargin)) / _numberOfColumns;
    return _flyerBoxWidth;
  }
  // --------------------
  static int gridColumnCount(int flyersLength) {
    final int _gridColumnsCount = flyersLength > 12 ? 3 :
    flyersLength > 6 ?
    2 : 2;
    return _gridColumnsCount;
  }
  // --------------------
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
    final bool _isVertical = scrollDirection == Axis.vertical;
    final bool _showLoadingGrid = showLoadingGridInstead(
      flyers : flyers,
      paginationFlyersIDs: paginationFlyersIDs,
      isLoadingGrid: isLoadingGrid,
    );
    // --------------------
    final double _gridZoneWidth = getGridWidth(
      context: context,
      givenGridWidth: gridWidth,
    );
    // --------------------
    final double _gridZoneHeight = getGridHeight(
      context: context,
      givenGridHeight: gridHeight,
    );
    // --------------------
    final double _flyerBoxWidth = scrollDirection == Axis.vertical ?
    getVerticalScrollFlyerBoxWidth(
      numberOfColumns: numberOfColumnsOrRows,
      gridZoneWidth: _gridZoneWidth,
    )
        :
    getHorizontalScrollFlyerBoxWidth(
      context: context,
      numberOfRows: numberOfColumnsOrRows,
      gridZoneHeight: _gridZoneHeight,
    )
    ;
    // --------------------
    final double _gridSpacingValue = getGridSpacingValue(
      flyerBoxWidth: _flyerBoxWidth,
    );
    // --------------------
    final EdgeInsets _gridPadding = getGridPadding(
      context: context,
      topPaddingValue: topPadding,
      gridSpacingValue: _gridSpacingValue,
      isVertical: _isVertical,
    );
    // --------------------
    /*
    final double _minWidthFactor =  getFlyerMinWidthFactor(
      gridFlyerWidth: _flyerBoxWidth,
      gridZoneWidth: _gridZoneWidth,
    );
 */
    // ----------------------------------------------------------
    final int _flyersCount = paginationFlyersIDs?.length ?? flyers?.length ?? 0;
    final int _numberOfItems = getNumberOfGridSlots(
      flyersCount: _flyersCount,
      addFlyerButtonIsOn: authorMode,
      isLoadingGrid: isLoadingGrid,
      numberOfColumnsOrRows: numberOfColumnsOrRows,
    );
    // --------------------
    return SizedBox(
      key: const ValueKey<String>('Stack_of_flyers_grid'),
      width: _gridZoneWidth,
      height: _gridZoneHeight,
      child: GridView.builder(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: _gridPadding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: scrollDirection == Axis.vertical ? _gridSpacingValue : 0,
            mainAxisSpacing: _gridSpacingValue,
            childAspectRatio: 1 / FlyerDim.xFlyerBoxHeight,
            crossAxisCount: numberOfColumnsOrRows,
            mainAxisExtent: scrollDirection == Axis.vertical ? _flyerBoxWidth * FlyerDim.xFlyerBoxHeight : _flyerBoxWidth,
            // maxCrossAxisExtent: scrollDirection == Axis.vertical ? _flyerBoxWidth : Ratioz.xxflyerZoneHeight,
          ),
          itemCount: _numberOfItems,
          scrollDirection: scrollDirection,
          itemBuilder: (BuildContext ctx, int index){

            /// WHEN IS JUST A LOADING GRID
            if (_showLoadingGrid == true){

              return FlyerLoading(
                flyerBoxWidth: _flyerBoxWidth,
              );

            }

            /// ACTUAL FLYERS
            else {

              /// AUTHOR MODE FOR FIRST INDEX ADD FLYER BUTTON
              if (authorMode == true && index == 0){
                return AddFlyerButton(
                  flyerBoxWidth: _flyerBoxWidth,
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
                            flyerBoxWidth: _flyerBoxWidth,
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
                              flyerBoxWidth: _flyerBoxWidth,
                              heroTag: heroTag,
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
                    flyerBoxWidth: _flyerBoxWidth,
                    heroTag: heroTag,
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
