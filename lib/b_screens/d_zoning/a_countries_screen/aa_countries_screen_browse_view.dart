import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/models/america.dart';
import 'package:basics/models/flag_model.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/z_components/buttons/zone_buttons/america_states_tile_buttons.dart';
import 'package:bldrs/z_components/buttons/zone_buttons/country_tile_button.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class CountriesScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountriesScreenBrowseView({
    required this.onCountryTap,
    required this.onDisabledCountryTap,
    required this.shownCountriesIDs,
    required this.disabledCountriesIDs,
    required this.countriesCensus,
    required this.showPlanetButton,
    required this.planetCensus,
    required this.onPlanetTap,
    required this.selectedCountries,
    this.padding,
    this.appBarType = AppBarType.search,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onCountryTap;
  final ValueChanged<String?>? onDisabledCountryTap;
  final EdgeInsets? padding;
  final List<String> shownCountriesIDs;
  final List<String> disabledCountriesIDs;
  final List<CensusModel>? countriesCensus;
  final bool showPlanetButton;
  final CensusModel? planetCensus;
  final Function onPlanetTap;
  final List<String> selectedCountries;
  final AppBarType appBarType;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<String> _shown = [...shownCountriesIDs];
    // --------------------
    List<String> _countriesButtons = <String>[..._shown, ...disabledCountriesIDs];
    _countriesButtons = Stringer.removeStringsFromStrings(
        removeFrom: _countriesButtons,
        removeThis: America.getStatesIDs(),
    );
    // --------------------
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _countriesButtons.length + 1,
      padding: padding ?? Stratosphere.getStratosphereSandwich(context: context, appBarType: appBarType),
      itemBuilder: (_, int index) {

        if (index == 0){

          /// NO PLANET BUTTON
          if (showPlanetButton == false){
            return const SizedBox();
          }

          /// PLANET BUTTON
          else {

          return CountryTileButton(
            countryID: Flag.planetID,
            isActive: true,
            censusModel: planetCensus,
            onTap: onPlanetTap,
            isSelected: selectedCountries.isEmpty,
            verse: const Verse(
              id: 'phid_the_entire_world',
              translate: true,
            ), // ZoneModel.planetZone.countryName
            onDeactivatedTap: onDisabledCountryTap == null ? null
                              :
                              () => onDisabledCountryTap!(null),
          );

          }

        }

        else {

          final String _countryID = _countriesButtons[index-1];

          /// USA STATES
          if (_countryID == 'usa'){

            return AmericaStatesTileButtons(
              disabledCountriesIDs: disabledCountriesIDs,
              activeCountriesIDs: shownCountriesIDs,
              censusModels: countriesCensus,
              onStateTap: (String stateID) => onCountryTap(stateID),
              selectedCountries: selectedCountries,
              onDisabledStateTap: onDisabledCountryTap == null ? null
                  :
                  (String stateID) => onDisabledCountryTap?.call(_countryID),
            );

          }

          /// NORMAL COUNTRIES
          else {

            final CensusModel? _census = CensusModel.getCensusFromCensusesByID(
              censuses: countriesCensus,
              censusID: _countryID,
            );

            final bool _isSelected = Stringer.checkStringsContainString(
                strings: selectedCountries,
                string: _countryID,
            );

            return CountryTileButton(
              countryID: _countryID,
              isActive: Stringer.checkStringsContainString(
                  strings: shownCountriesIDs,
                  string: _countryID,
              ),
              censusModel: _census,
              isSelected: _isSelected,
              onTap: () => onCountryTap(_countryID),
              onDeactivatedTap: onDisabledCountryTap == null ? null
                  :
                  () => onDisabledCountryTap?.call(_countryID),
            );

          }

        }

      },
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
