import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/country_tile_button.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/state_tile_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class StatesScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StatesScreenBrowseView({
    required this.onStateTap,
    required this.onDisabledStateTap,
    required this.shownStateIDs,
    required this.notShownStatesIDs,
    required this.statesCensus,
    required this.showAmericaButton,
    required this.americaCensus,
    required this.onAmericaTap,
    required this.selectedZone,
    this.padding,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onStateTap;
  final ValueChanged<String?>? onDisabledStateTap;
  final EdgeInsets? padding;
  final List<String>? shownStateIDs;
  final List<String>? notShownStatesIDs;
  final List<CensusModel>? statesCensus;
  final bool showAmericaButton;
  final CensusModel? americaCensus;
  final Function onAmericaTap;
  final ZoneModel? selectedZone;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<String> _statesIDs = <String>[...?shownStateIDs, ...?notShownStatesIDs];
    // --------------------
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _statesIDs.length + 1,
      padding: padding ?? Stratosphere.getStratosphereSandwich(context: context, appBarType: AppBarType.search),
      itemBuilder: (_, int index) {

        if (index == 0){

          if (showAmericaButton == false){
            return const SizedBox();
          }

          else {

          return CountryTileButton(
            countryID: 'usa',
            isActive: true,
            censusModel: americaCensus,
            onTap: onAmericaTap,
            isSelected: selectedZone == null,
            verse: const Verse(
              translate: true,
              id: 'phid_all_states',
            ), // ZoneModel.planetZone.countryName
            onDeactivatedTap: onDisabledStateTap == null ? null
                :
                () => onDisabledStateTap!(null),
          );

          }

        }

        else {

          final String _stateID = _statesIDs[index-1];

          final CensusModel? _census = CensusModel.getCensusFromCensusesByID(
          censuses: statesCensus,
          censusID: _stateID,
        );

          return StateTileButton(
            stateID: _stateID,
            isActive: Stringer.checkStringsContainString(strings: shownStateIDs, string: _stateID),
            censusModel: _census,
            isSelected: selectedZone?.countryID == _stateID,
            onTap: () => onStateTap(_stateID),
            onDeactivatedTap: onDisabledStateTap == null ? null :
                () => onDisabledStateTap?.call(_stateID),
          );

        }

      },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
