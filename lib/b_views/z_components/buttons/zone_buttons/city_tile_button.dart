import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/census_line.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/zone_button_box.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';

class WideCityButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WideCityButton({
    @required this.city,
    @required this.onSingleTap,
    @required this.isActive,
    @required this.censusModel,
    @required this.onDeactivatedTap,
    this.verse,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CityModel city;
  final Function onSingleTap;
  final bool isActive;
  final Function onDeactivatedTap;
  final CensusModel censusModel;
  final Verse verse;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String _cityNameValue = CityModel.translateCity(
        context: context,
        city: city,
    );
    // --------------------
    return ZoneButtonBox(
      onTap: onSingleTap,
      onDeactivatedTap: onDeactivatedTap,
      isActive: isActive,
      columnChildren: <Widget>[

        /// CITY WIDE TILE
        DreamBox(
          height: 40,
          isDisabled: !isActive,
          width: Bubble.bubbleWidth(context),
          iconSizeFactor: 0.8,
          verse: verse ?? Verse.plain(_cityNameValue),
          bubble: false,
          verseScaleFactor: 0.8,
          // textDirection: superTextDirection(context),
        ),

        /// CENSUS LINE
        CensusLine(
          censusModel: censusModel,
          hasFlagSpace: false,
          isActive: isActive,
        ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
