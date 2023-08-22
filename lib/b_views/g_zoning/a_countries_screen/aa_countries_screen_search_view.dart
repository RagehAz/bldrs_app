import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/models/phrase_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/america_states_tile_buttons.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/country_tile_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class CountriesScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountriesScreenSearchView({
    required this.onCountryTap,
    required this.onDisabledCountryTap,
    required this.foundCountries,
    required this.activeCountriesIDs,
    required this.disabledCountriesIDs,
    required this.countriesCensus,
    required this.selectedZone,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onCountryTap;
  final ValueChanged<String> onDisabledCountryTap;
  final ValueNotifier<List<Phrase>?> foundCountries;
  final List<String> activeCountriesIDs;
  final List<String> disabledCountriesIDs;
  final List<CensusModel>? countriesCensus;
  final ZoneModel? selectedZone;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WHEN SEARCH RESULTS
    return ValueListenableBuilder(
      valueListenable: foundCountries,
      builder: (_, List<Phrase>? foundPhrases, Widget? child){

        const EdgeInsets _topMargin = EdgeInsets.only(
          top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2,
          bottom: Ratioz.horizon,
        );

        /// WHEN SEARCH RESULTS
        if (Mapper.checkCanLoopList(foundPhrases) == true){

          List<Phrase> _countriesButtons = [...foundPhrases!];

          final List<String> _foundCountriesIDs = Phrase.getPhrasesIDs(foundPhrases);

          final bool _containsStates = America.checkCountriesIDsIncludeAStateID(
              countriesIDs: _foundCountriesIDs,
          );

          if (_containsStates == true){

            _countriesButtons = America.addUSAIDToPhrasesIfContainsStates(
              phrases: _countriesButtons,
            );
            _countriesButtons = America.removeStatesPhrases(
              removeFrom: _countriesButtons,
            );
            _countriesButtons = Phrase.sortNamesAlphabetically(_countriesButtons);
          }

          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _countriesButtons.length,
              padding: _topMargin,
              shrinkWrap: true,
              itemBuilder: (_, int index) {

                final Phrase _countryPhrase = _countriesButtons[index];
                final String _countryID = _countryPhrase.id!;

                /// USA STATES
                if (_countryID == 'usa'){

                  return AmericaStatesTileButtons(
                    activeCountriesIDs: Stringer.getSharedStrings(
                        strings1: activeCountriesIDs,
                        strings2: _foundCountriesIDs,
                    ),
                    disabledCountriesIDs: Stringer.getSharedStrings(
                        strings1: disabledCountriesIDs,
                        strings2: _foundCountriesIDs,
                    ),
                    censusModels: countriesCensus,
                    selectedZone: selectedZone,
                    onStateTap: (String stateID) => onCountryTap(stateID),
                    onDisabledStateTap: (String stateID) => onDisabledCountryTap(_countryID),
                  );

                }
                else {

                  final CensusModel? _census = CensusModel.getCensusFromCensusesByID(
                    censuses: countriesCensus,
                    censusID: _countryID,
                  );

                  return CountryTileButton(
                    countryID: _countryID,
                    isActive: Stringer.checkStringsContainString(
                      strings: activeCountriesIDs,
                      string: _countryID,
                    ),
                    censusModel: _census,
                    isSelected: selectedZone?.countryID == _countryPhrase.id,
                    onTap: () => onCountryTap(_countryPhrase.id!),
                    onDeactivatedTap: () => onDisabledCountryTap(_countryPhrase.id!),
                  );

                }

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
