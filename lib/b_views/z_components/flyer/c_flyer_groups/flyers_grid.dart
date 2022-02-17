import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/a_flyer_starter.dart';
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
    return Stack(
      key: const ValueKey<String>('Stack_of_flyers_grid'),
      children: <Widget>[

        SizedBox(
          width: _gridZoneWidth,
          height: _gridZoneHeight,
          // color: Colorz.blue10,
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
              itemCount: flyers.length,
              itemBuilder: (BuildContext ctx, int index){

                return
                  FlyerStarter(
                    key: const ValueKey<String>('Flyers_grid_FlyerStarter'),
                    flyerModel: flyers[index],
                    minWidthFactor: _minWidthFactor,
                    heroTag: heroTag,
                  );
              }


          ),

        ),

      ],
    );
  }
}
