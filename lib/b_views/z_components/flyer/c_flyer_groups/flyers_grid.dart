import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/a_flyer_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/d_flyer_tree.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyersGrid extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyersGrid({
    @required this.flyers,
    @required this.gridWidth,
    @required this.gridHeight,
    this.topPadding = Ratioz.stratosphere,
    this.numberOfColumns = 3,
    this.parentFlyerID,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<FlyerModel> flyers;
  final double gridWidth;
  final double gridHeight;
  final double topPadding;
  final int numberOfColumns;
  /// when grid is inside a flyer
  final String parentFlyerID;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _gridZoneWidth = Scale.superScreenWidth(context);
    const double _spacingRatioToGridWidth = 0.03;
    final double _gridFlyerWidth = _gridZoneWidth / (numberOfColumns + (numberOfColumns * _spacingRatioToGridWidth) + _spacingRatioToGridWidth);

    final double _gridSpacing = _gridFlyerWidth * _spacingRatioToGridWidth;

    final EdgeInsets _gridPadding = EdgeInsets.all(_gridSpacing);

    final double _minWidthFactor =  _gridFlyerWidth / _gridZoneWidth;

    return Stack(
      key: const ValueKey<String>('Stack_of_flyers_grid'),
      children: <Widget>[

        Container(
          width: gridWidth,
          height: gridHeight,
          padding: EdgeInsets.only(top: topPadding),
          color: Colorz.blue10,
          child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: _gridPadding,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: _gridSpacing,
                mainAxisSpacing: _gridSpacing,
                childAspectRatio: 1 / Ratioz.xxflyerZoneHeight,
                maxCrossAxisExtent: _gridFlyerWidth,
              ),
              itemCount: flyers.length,
              itemBuilder: (BuildContext ctx, int index){

                return
                  FlyerStarter(
                    key: const ValueKey<String>('Flyer_within_a_flyer'),
                    flyerModel: flyers[index],
                    minWidthFactor: _minWidthFactor,
                    parentFlyerID: parentFlyerID,
                  );
              }


          ),

        ),

      ],
    );
  }
}
