import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/models/america.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/buttons/zone_buttons/census_line.dart';
import 'package:bldrs/z_components/buttons/zone_buttons/zone_button_box.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class StateTileButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StateTileButton({
    required this.stateID,
    required this.onTap,
    required this.isActive,
    required this.censusModel,
    required this.onDeactivatedTap,
    required this.isSelected,
    this.verse,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String stateID;
  final Function? onTap;
  final bool isActive;
  final Function? onDeactivatedTap;
  final CensusModel? censusModel;
  final Verse? verse;
  final bool isSelected;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String? _stateNameValue = America.getStateName(
      stateID: stateID,
      withISO2: America.useISO2,
    );
    // --------------------
    return ZoneButtonBox(
      onTap: onTap == null ? null : () => onTap?.call(),
      onDeactivatedTap: onDeactivatedTap,
      isActive: isActive,
      isSelected: isSelected,
      columnChildren: <Widget>[

        /// STATE WIDE TILE
        BldrsBox(
          height: 40,
          isDisabled: !isActive,
          width: Bubble.bubbleWidth(context: context),
          iconSizeFactor: 0.8,
          verse: verse ?? Verse.plain(_stateNameValue),
          bubble: false,
          verseScaleFactor: 0.9 / 0.8,
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
