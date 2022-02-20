import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/a_flyer_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/d_variants/add_flyer_button.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersGrid({
    @required this.flyers,
    @required this.gridWidth,
    @required this.gridHeight,
    @required this.scrollController,
    this.topPadding = Ratioz.stratosphere,
    this.numberOfColumns = 3,
    this.heroTag,
    this.addFlyerButtonIsOn = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<FlyerModel> flyers;
  final double gridWidth;
  final double gridHeight;
  final ScrollController scrollController;
  final double topPadding;
  final int numberOfColumns;
  /// when grid is inside a flyer
  final String heroTag;
  final bool addFlyerButtonIsOn;
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
  static int getNumberOfFlyers({
    @required List<FlyerModel> flyers,
    @required bool addFlyerButtonIsOn,
}){
    int _numberOfRealFlyers = 0;

    /// WHEN FLYERS HAVE LENGTH
    if (Mapper.canLoopList(flyers)){
      _numberOfRealFlyers = flyers.length;
    }

    /// ADD ONE IF THE THE ADD BUTTON IS ON
    if (addFlyerButtonIsOn == true){
      return _numberOfRealFlyers + 1;
    }

    /// KEEP AS IS
    else {
      return _numberOfRealFlyers;
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
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
    final double _minWidthFactor =  getFlyerMinWidthFactor(
      gridFlyerWidth: _gridFlyerWidth,
      gridZoneWidth: _gridZoneWidth,
    );
// ----------------------------------------------------------
    final int _numberOfItems = getNumberOfFlyers(
      flyers: flyers,
      addFlyerButtonIsOn: addFlyerButtonIsOn,
    );
// ----------------------------------------------------------
    if (addFlyerButtonIsOn == true){
      if (Mapper.canLoopList(flyers)){
        flyers.insert(0, null);
      }
    }
// ----------------------------------------------------------
    return Stack(
      key: const ValueKey<String>('Stack_of_flyers_grid'),
      children: <Widget>[

        SizedBox(
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

                /// A - WHEN ADD FLYER BUTTON IS ON
                if (addFlyerButtonIsOn == true){

                  /// B2 - WHEN AT FIRST ELEMENT
                  if (index == 0){
                    return AddFlyerButton(
                      flyerBoxWidth: _gridFlyerWidth,
                    );
                  }

                  /// B3 - WHEN AT ANY ELEMENT AFTER FIRST
                  else {
                    return FlyerStarter(
                      key: const ValueKey<String>('Flyers_grid_FlyerStarter'),
                      flyerModel: flyers[index],
                      minWidthFactor: _minWidthFactor,
                      heroTag: heroTag,
                    );
                  }

                }

                /// A - WHEN ONLY SHOWING FLYERS
                else {
                  return FlyerStarter(
                    key: const ValueKey<String>('Flyers_grid_FlyerStarter'),
                    flyerModel: flyers[index],
                    minWidthFactor: _minWidthFactor,
                    heroTag: heroTag,
                  );
                }

              }


          ),

        ),

      ],
    );
  }
}
