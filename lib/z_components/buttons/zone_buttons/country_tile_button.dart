import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/models/flag_model.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/z_components/buttons/general_buttons/a_tile_button.dart';
import 'package:bldrs/z_components/buttons/zone_buttons/census_line.dart';
import 'package:bldrs/z_components/buttons/zone_buttons/zone_button_box.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:flutter/material.dart';

class CountryTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountryTileButton({
    required this.onTap,
    required this.onDeactivatedTap,
    required this.countryID,
    required this.isActive,
    required this.isSelected,
    this.width,
    this.height,
    this.censusModel,
    this.verse,
    this.verseCentered = true,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function? onTap;
  final Function? onDeactivatedTap;
  final String? countryID;
  final bool isActive;
  final bool isSelected;
  final double? width;
  final double? height;
  final CensusModel? censusModel;
  final Verse? verse;
  final bool verseCentered;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool canShowCensus({
    required CensusModel? censusModel,
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
    final bool _isPlanetButton = countryID == null || countryID == Flag.planetID;

    return ZoneButtonBox(
      onTap: onTap,
      onDeactivatedTap: onDeactivatedTap,
      isActive: isActive,
      isSelected: isSelected,
      columnChildren: <Widget>[

        /// FLAG & COUNTRY NAME
        TileButton(
          isActive: isActive,
          height: height,
          width: width ?? _buttonWidth,
          /// IF COUNTRY FLAG IS NULL, IT WILL SHOW PLANET ICON
          icon: Flag.getCountryIcon(countryID),
          verse: verse ?? Verse.plain(
              CountryModel.translateCountry(
                  langCode: Localizer.getCurrentLangCode(),
                  countryID: countryID
              )
          ),
          color: Colorz.nothing,
          margins: EdgeInsets.zero,
          verseCentered: verseCentered,
          // corners: BorderRadius.zero,
        ),

        /// CENSUS LINE
          if (censusModel != null)
          CensusLine(
            width: width ?? _buttonWidth,
            censusModel: censusModel,
            hasFlagSpace: true,
            isActive: isActive,
            isPlanetButton: _isPlanetButton,
          ),

      ],
    );

  }
  /// --------------------------------------------------------------------------
}
