import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/z_components/buttons/general_buttons/a_tile_button.dart';
import 'package:bldrs/z_components/buttons/zone_buttons/census_line_unit.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class CensusLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CensusLine({
    required this.censusModel,
    required this.hasFlagSpace,
    required this.isActive,
    this.width,
    this.isPlanetButton = false,
    super.key
  });
  // --------------------------------------------------------------------------
  final CensusModel? censusModel;
  final bool hasFlagSpace;
  final double? width;
  final bool isActive;
  final bool isPlanetButton;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool canShowCensus({
    required CensusModel? censusModel,
    required bool isPlanetButton,
  }){

    if (isPlanetButton == true){
      return true;
    }

    else if (censusModel == null){
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

    if (canShowCensus(censusModel: censusModel, isPlanetButton: isPlanetButton) == true){

      final double _buttonWidth = Bubble.bubbleWidth(
        bubbleWidthOverride: width,
        context: context,
      );

      final double _flagBoxSize = hasFlagSpace == true ? TileButton.defaultHeight : TileButton.defaultHeight;
      final double _censusUnitsTotalWidth = _buttonWidth - _flagBoxSize;

      final double _censusUnitBoxWidth = Scale.getUniformRowItemWidth(
        context: context,
        numberOfItems: 3,
        boxWidth: _censusUnitsTotalWidth,
        spacing: 0,
      );

      // final double _totalHeight = CensusLineUnit.getTotalHeight(
      //   hasTitle: isPlanetButton,
      //   // stripHeight: ,
      // );

      return SizedBox(
        width: _buttonWidth,
        // height: 30,
        child: Container(
          margin: Scale.superInsets(
              context: context,
              appIsLTR: UiProvider.checkAppIsLeftToRight(),
            enLeft: hasFlagSpace == true ? _flagBoxSize : 0
          ),
          decoration: BoxDecoration(
            color: isActive == true ? Colorz.white10 : Colorz.nothing,
            borderRadius: Borderers.constantCornersAll12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              // /// FLAG WIDTH
              // if (hasFlagSpace == true)
              // SizedBox(
              //   width: _flagBoxSize,
              //   height: _flagBoxSize,
              // ),

              /// USERS
              CensusLineUnit(
                width: _censusUnitBoxWidth,
                icon: Iconz.normalUser,
                number: censusModel?.totalUsers,
                isActive: isActive,
                title: isPlanetButton == true ? Verse.trans('phid_users') : null,
              ),

              const CensusLineUnitSeparator(),

              /// BZZ
              CensusLineUnit(
                width: _censusUnitBoxWidth - 1,
                icon: Iconz.bz,
                number: censusModel?.totalBzz,
                isActive: isActive,
                title: isPlanetButton == true ? Verse.trans('phid_bzz') : null,
              ),

              const CensusLineUnitSeparator(),

              /// FLYERS
              CensusLineUnit(
                width: _censusUnitBoxWidth - 1,
                icon: Iconz.flyer,
                number: censusModel?.totalFlyers,
                isActive: isActive,
                title: isPlanetButton == true ? Verse.trans('phid_flyers') : null,
              ),


            ],
          ),
        ),
      );

    }

    else {
      return const SizedBox();
    }

  }
  // -----------------------------------------------------------------------------
}
