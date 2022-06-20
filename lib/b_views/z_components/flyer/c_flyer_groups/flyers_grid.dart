import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/b_flyer_loading.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyer_selection_stack.dart';
import 'package:bldrs/b_views/z_components/flyer/d_variants/add_flyer_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersGrid({
    @required this.gridWidth,
    @required this.gridHeight,
    @required this.scrollController,
    this.flyers,
    this.paginationFlyersIDs,
    this.topPadding = Ratioz.stratosphere,
    this.numberOfColumns = 2,
    this.heroTag,
    this.authorMode = false,
    this.onFlyerOptionsTap,
    this.selectedFlyers,
    this.onSelectFlyer,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<FlyerModel> flyers;
  final List<String> paginationFlyersIDs;
  final double gridWidth;
  final double gridHeight;
  final ScrollController scrollController;
  final double topPadding;
  final int numberOfColumns;
  /// when grid is inside a flyer
  final String heroTag;
  final bool authorMode;
  final ValueChanged<FlyerModel> onFlyerOptionsTap;
  final List<FlyerModel> selectedFlyers;
  final ValueChanged<FlyerModel> onSelectFlyer;
  /// --------------------------------------------------------------------------
  static double getGridWidth({
    @required BuildContext context,
    @required double givenGridWidth,
}){
    return givenGridWidth ?? Scale.superScreenWidth(context);
  }
// -----------------------------------------------------------------------------
  static double getGridHeight({
    @required BuildContext context,
    @required double givenGridHeight,
}){
    return givenGridHeight ?? Scale.superScreenHeight(context);
}
// -----------------------------------------------------------------------------
  static const double _spacingRatioToGridWidth = 0.03;
// -----------------------------------------------------------------------------
  static double getGridFlyerWidth({
    @required double gridZoneWidth,
    @required int numberOfColumns,
  }){
    final double _gridFlyerWidth =
        gridZoneWidth /
        (
            numberOfColumns
            + (numberOfColumns * _spacingRatioToGridWidth)
            + _spacingRatioToGridWidth
        );
    return _gridFlyerWidth;
  }
// -----------------------------------------------------------------------------
  static double getGridSpacingValue({
    @required double gridFlyerWidth,
  }){
    return gridFlyerWidth * _spacingRatioToGridWidth;
  }
// -----------------------------------------------------------------------------
  static EdgeInsets getGridPadding({
    @required double gridSpacingValue,
    @required double topPaddingValue,
  }){
    return EdgeInsets.only(
      left: gridSpacingValue,
      right: gridSpacingValue,
      top: topPaddingValue,
      bottom: Ratioz.horizon,
    );
  }
// -----------------------------------------------------------------------------
  static double getFlyerMinWidthFactor({
    @required double gridFlyerWidth,
    @required double gridZoneWidth,
  }){
    return gridFlyerWidth / gridZoneWidth;
  }
// -----------------------------------------------------------------------------
  static int getNumberOfGridSlots({
    @required int flyersCount,
    @required bool addFlyerButtonIsOn,
}){
    int _slotsCount = flyersCount;

    if (addFlyerButtonIsOn == true){
      _slotsCount = _slotsCount + 1;
    }

    return _slotsCount;
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  static int gridColumnCount(int flyersLength) {
    final int _gridColumnsCount = flyersLength > 12 ? 3 :
    flyersLength > 6 ?
    2 : 2;
    return _gridColumnsCount;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// ----------------------------------------------------------

    assert((){
      final bool _canBuild =
          flyers != null
          ||
          paginationFlyersIDs != null;
      if (_canBuild == false){
        throw FlutterError('FlyersGrid Widget should have either flyers or paginationFlyersIDs initialized');
      }
      return _canBuild;
    }(), 'fuck you');

// ----------------------------------------------------------
    final double _gridZoneWidth = getGridWidth(
      context: context,
      givenGridWidth: gridWidth,
    );
// ----------------------------------------------------------
    final double _gridZoneHeight = getGridHeight(
        context: context,
        givenGridHeight: gridHeight,
    );
// ----------------------------------------------------------
    final double _gridFlyerWidth = getGridFlyerWidth(
      numberOfColumns: numberOfColumns,
      gridZoneWidth: _gridZoneWidth,
    );
// ----------------------------------------------------------
    final double _gridSpacingValue = getGridSpacingValue(
      gridFlyerWidth: _gridFlyerWidth,
    );
// ----------------------------------------------------------
    final EdgeInsets _gridPadding = getGridPadding(
      topPaddingValue: topPadding,
      gridSpacingValue: _gridSpacingValue,
    );
// ----------------------------------------------------------
/*
    final double _minWidthFactor =  getFlyerMinWidthFactor(
      gridFlyerWidth: _gridFlyerWidth,
      gridZoneWidth: _gridZoneWidth,
    );
 */
// ----------------------------------------------------------
    final int _flyersCount = paginationFlyersIDs?.length ?? flyers?.length ?? 0;
    final int _numberOfItems = getNumberOfGridSlots(
      flyersCount: _flyersCount,
      addFlyerButtonIsOn: authorMode,
    );
// ----------------------------------------------------------

    blog('BUILDING THE FUCKING FLYERS GRID : _flyersCount : $_flyersCount : paginationFlyersIDs : ${paginationFlyersIDs?.length} : flyers?.length ${flyers?.length}');

    return SizedBox(
      key: const ValueKey<String>('Stack_of_flyers_grid'),
      width: _gridZoneWidth,
      height: _gridZoneHeight,
      child: GridView.builder(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: _gridPadding,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: _gridSpacingValue,
            mainAxisSpacing: _gridSpacingValue,
            childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
            maxCrossAxisExtent: _gridFlyerWidth,
          ),
          itemCount: _numberOfItems,
          itemBuilder: (BuildContext ctx, int index){


            /// AUTHOR MODE FOR FIRST INDEX ADD FLYER BUTTON
            if (authorMode == true && index == 0){
              return AddFlyerButton(
                flyerBoxWidth: _gridFlyerWidth,
              );
            }

            /// OTHERWISE
            else {

              final int _flyerIndex = authorMode == true ? index-1 : index;

              /// FLYERS PAGINATION IDS IS DEFINED
              if (paginationFlyersIDs != null){

                final String _flyerID = paginationFlyersIDs[_flyerIndex];

                return FutureBuilder(
                  future: FlyersProvider.proFetchFlyer(
                      context: context,
                      flyerID: _flyerID,
                  ),
                    builder: (_, AsyncSnapshot<Object> snap){

                      final FlyerModel _flyerModel = snap?.data;
                      final bool _isSelected = FlyerModel.flyersContainThisID(
                        flyers: selectedFlyers,
                        flyerID: _flyerModel?.id,
                      );

                      if (connectionIsLoading(snap) == true){
                        return FlyerLoading(
                          flyerBoxWidth: _gridFlyerWidth,
                        );
                      }

                      else {
                        return FlyerSelectionStack(
                          flyerModel: _flyerModel,
                          flyerBoxWidth: _gridFlyerWidth,
                          heroTag: heroTag,
                          onSelectFlyer: onSelectFlyer == null ? null : () => onSelectFlyer(_flyerModel),
                          onFlyerOptionsTap: onFlyerOptionsTap == null ? null : () => onFlyerOptionsTap(_flyerModel),
                          isSelected: _isSelected,
                        );
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
                  flyerBoxWidth: _gridFlyerWidth,
                  heroTag: heroTag,
                  onSelectFlyer: onSelectFlyer == null ? null : () => onSelectFlyer(_flyer),
                  onFlyerOptionsTap: onFlyerOptionsTap == null ? null : () => onFlyerOptionsTap(_flyer),
                  isSelected: _isSelected,
                );

              }

            }

          }


      ),

    );
  }
}
