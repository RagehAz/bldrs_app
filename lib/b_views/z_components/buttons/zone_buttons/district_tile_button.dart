import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/census_line.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/zone_button_box.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';

class WideDistrictButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const WideDistrictButton({
    @required this.district,
    @required this.censusModel,
    @required this.onTap,
    @required this.isActive,
    @required this.onDeactivatedTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final DistrictModel district;
  final CensusModel censusModel;
  final ValueChanged<String> onTap;
  final ValueChanged<String> onDeactivatedTap;
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
      onDeactivatedTap: () => onDeactivatedTap(district.id),
      isActive: isActive,
      columnChildren: <Widget>[

        /// CITY WIDE TILE
        DreamBox(
          isDisabled: !isActive,
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
