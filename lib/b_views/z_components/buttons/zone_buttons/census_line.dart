import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/a_tile_button.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/census_line_unit.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class CensusLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CensusLine({
    @required this.censusModel,
    @required this.hasFlagSpace,
    this.width,
    Key key
  }) : super(key: key);
  // --------------------------------------------------------------------------
  final CensusModel censusModel;
  final bool hasFlagSpace;
  final double width;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool canShowCensus({
    @required CensusModel censusModel,
  }){

    if (censusModel == null){
      return false;
    }

    else if (
    censusModel.totalUsers != 0 ||
        censusModel.totalBzz != 0 ||
        censusModel.totalFlyers != 0
    ){
      return true;
    }

    else {
      return false;
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (canShowCensus(censusModel: censusModel) == true){

      final double _buttonWidth = width ?? Bubble.bubbleWidth(context);

      final double _flagBoxSize = hasFlagSpace == true ? TileButton.defaultHeight : TileButton.defaultHeight;
      final double _censusUnitsTotalWidth = _buttonWidth - _flagBoxSize;

      final double _censusUnitBoxWidth = Scale.getUniformRowItemWidth(
        context: context,
        numberOfItems: 3,
        boxWidth: _censusUnitsTotalWidth,
        spacing: 0,
      );

      return SizedBox(
        width: _buttonWidth,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            /// FLAG WIDTH
            if (hasFlagSpace == true)
            SizedBox(
              width: _flagBoxSize,
              height: _flagBoxSize,
            ),

            /// USERS
            CensusLineUnit(
              width: _censusUnitBoxWidth,
              icon: Iconz.normalUser,
              number: censusModel.totalUsers,
            ),

            /// BZZ
            CensusLineUnit(
              width: _censusUnitBoxWidth,
              icon: Iconz.bz,
              number: censusModel.totalBzz,
            ),

            /// FLYERS
            CensusLineUnit(
              width: _censusUnitBoxWidth,
              icon: Iconz.flyer,
              number: censusModel.totalFlyers,
            ),

          ],
        ),
      );

    }

    else {
      return const SizedBox();
    }

  }
  // -----------------------------------------------------------------------------
}