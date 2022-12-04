import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/a_tile_button.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/census_mini_line.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class CountryTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountryTileButton({
    @required this.onTap,
    @required this.countryID,
    @required this.isActive,
    this.width,
    this.height,
    this.censusModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final String countryID;
  final double width;
  final double height;
  final bool isActive;
  final CensusModel censusModel;
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

    final double _buttonWidth = Bubble.bubbleWidth(context);

    const double _censusBoxHeight = 30;
    final double _censusUnitsTotalWidth = _buttonWidth - _censusBoxHeight - 10;

    final double _censusUnitBoxWidth = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: 3,
      boxWidth: _censusUnitsTotalWidth,
      spacing: 0,
    );

    return Center(
      child: Container(
        width: _buttonWidth,
        decoration: const BoxDecoration(
         color: Colorz.white10,
         borderRadius: Borderers.constantCornersAll12,
        ),
        margin: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
        child: Column(
          children: <Widget>[

            /// FLAG & COUNTRY NAME
            TileButton(
              isActive: isActive,
              height: height,
              width: width ?? _buttonWidth,
              icon: Flag.getCountryIcon(countryID),
              verse: Verse.plain(Flag.getCountryNameByCurrentLang(context: context, countryID: countryID)),
              onTap: onTap,
              color: Colorz.nothing,
              margins: EdgeInsets.zero,
            ),

            /// CENSUS
            if (canShowCensus(censusModel: censusModel) == true)
            SizedBox(
              width: _buttonWidth,
              height: 30,
              child: Row(
                children: <Widget>[

                  /// FLAG WIDTH
                  const SizedBox(
                    width: TileButton.defaultHeight,
                    height: _censusBoxHeight,
                  ),

                  /// USERS
                  CensusMiniLine(
                    width: _censusUnitBoxWidth,
                    icon: Iconz.normalUser,
                    number: censusModel.totalUsers,
                  ),

                  /// BZZ
                  CensusMiniLine(
                    width: _censusUnitBoxWidth,
                    icon: Iconz.bz,
                    number: censusModel.totalBzz,
                  ),

                  /// FLYERS
                  CensusMiniLine(
                    width: _censusUnitBoxWidth,
                    icon: Iconz.flyer,
                    number: censusModel.totalFlyers,
                  ),

                ],
              ),
            )

          ],
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
