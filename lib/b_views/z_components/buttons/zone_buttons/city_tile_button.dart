import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/census_line.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/zone_button_box.dart';
import 'package:flutter/material.dart';

class WideCityButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WideCityButton({
    @required this.city,
    @required this.onSingleTap,
    @required this.isActive,
    @required this.censusModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CityModel city;
  final Function onSingleTap;
  final bool isActive;
  final CensusModel censusModel;
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
      isActive: isActive,
      columnChildren: <Widget>[

        /// CITY WIDE TILE
        DreamBox(
          height: 40,
          isDeactivated: !isActive,
          width: Bubble.bubbleWidth(context),
          iconSizeFactor: 0.8,
          verse: Verse.plain(_cityNameValue),
          bubble: false,
          verseScaleFactor: 0.8,
          // textDirection: superTextDirection(context),
        ),

        /// CENSUS LINE
        if (isActive == true)
        CensusLine(
          censusModel: censusModel,
          hasFlagSpace: false,
        ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
