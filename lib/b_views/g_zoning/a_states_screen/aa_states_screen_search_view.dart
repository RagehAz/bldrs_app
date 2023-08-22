import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/models/phrase_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/state_tile_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class StatesScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StatesScreenSearchView({
    required this.onStateTap,
    required this.onDisabledStateTap,
    required this.foundStates,
    required this.shownStatesIDs,
    required this.statesCensus,
    required this.selectedZone,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onStateTap;
  final ValueChanged<String?> onDisabledStateTap;
  final ValueNotifier<List<Phrase>?> foundStates;
  final List<String> shownStatesIDs;
  final List<CensusModel>? statesCensus;
  final ZoneModel? selectedZone;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WHEN SEARCH RESULTS
    return ValueListenableBuilder(
      valueListenable: foundStates,
      builder: (_, List<Phrase>? foundStates, Widget? child){

        const EdgeInsets _topMargin = EdgeInsets.only(
          top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2,
          bottom: Ratioz.horizon,
        );

        /// WHEN SEARCH RESULTS
        if (Mapper.checkCanLoopList(foundStates) == true){

          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: foundStates!.length,
              padding: _topMargin,
              shrinkWrap: true,
              itemBuilder: (_, int index) {

                final Phrase _statePhrase = foundStates[index];

                final CensusModel? _census = CensusModel.getCensusFromCensusesByID(
                  censuses: statesCensus,
                  censusID: _statePhrase.id,
                );

                return StateTileButton(
                  stateID: _statePhrase.id!,
                  isActive: Stringer.checkStringsContainString(
                    strings: shownStatesIDs,
                    string: _statePhrase.id,
                  ),
                  censusModel: _census,
                  isSelected: selectedZone?.countryID == _statePhrase.id,
                  onTap: () => onStateTap(_statePhrase.id!),
                  onDeactivatedTap: () => onDisabledStateTap(_statePhrase.id),
                );

              }
              );

        }

        /// WHEN RESULT IS EMPTY
        else {

          return Container(
            margin: _topMargin,
            child: const BldrsText(
              verse: Verse(
                id: 'phid_no_result_found',
                translate: true,
              ),
              labelColor: Colorz.white10,
              size: 3,
              weight: VerseWeight.thin,
              italic: true,
              color: Colorz.white200,
            ),
          );

        }


        },
    );

  }
// -----------------------------------------------------------------------------
}
