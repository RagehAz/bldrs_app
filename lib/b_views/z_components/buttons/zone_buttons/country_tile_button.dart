import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/buttons/tile_buttons/a_tile_button.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/census_line.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/zone_button_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';

class CountryTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountryTileButton({
    @required this.onTap,
    @required this.onDeactivatedTap,
    @required this.countryID,
    @required this.isActive,
    this.width,
    this.height,
    this.censusModel,
    this.verse,
    this.verseCentered = true,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final Function onDeactivatedTap;
  final String countryID;
  final double width;
  final double height;
  final bool isActive;
  final CensusModel censusModel;
  final Verse verse;
  final bool verseCentered;
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

    final double _buttonWidth = Bubble.bubbleWidth(context: context);

    return ZoneButtonBox(
      onTap: onTap,
      onDeactivatedTap: onDeactivatedTap,
      isActive: isActive,
      columnChildren: <Widget>[

        /// FLAG & COUNTRY NAME
          TileButton(
            isActive: isActive,
            height: height,
            width: width ?? _buttonWidth,
            icon: Flag.getCountryIcon(countryID),
            verse: verse ?? Verse.plain(
                Flag.translateCountry(
                    langCode: Localizer.getCurrentLangCode(context),
                    countryID: countryID
                )
            ),
            color: Colorz.nothing,
            margins: EdgeInsets.zero,
            verseCentered: verseCentered,
            // corners: BorderRadius.zero,
          ),

        /// CENSUS LINE
        //   if (isActive == true)
          CensusLine(
            width: width ?? _buttonWidth,
            censusModel: censusModel,
            hasFlagSpace: true,
            isActive: isActive,
          ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
