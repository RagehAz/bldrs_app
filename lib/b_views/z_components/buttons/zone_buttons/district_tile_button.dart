import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/census_line.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/zone_button_box.dart';
import 'package:flutter/material.dart';

class WideDistrictButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WideDistrictButton({
    @required this.district,
    @required this.censusModel,
    @required this.onTap,
    @required this.isActive,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final DistrictModel district;
  final CensusModel censusModel;
  final ValueChanged<String> onTap;
  final bool isActive;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _districtNameValue = DistrictModel.translateDistrict(
        context: context,
        district: district,
    );
    // --------------------
    return ZoneButtonBox(
      onTap: () => onTap(district.id),
      isActive: isActive,
      columnChildren: <Widget>[

        /// CITY WIDE TILE
        DreamBox(
          isDeactivated: !isActive,
          height: 40,
          width: Bubble.bubbleWidth(context),
          iconSizeFactor: 0.8,
          verse: Verse.plain(_districtNameValue),
          bubble: false,
          // margins: const EdgeInsets.symmetric(vertical: 5),
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
