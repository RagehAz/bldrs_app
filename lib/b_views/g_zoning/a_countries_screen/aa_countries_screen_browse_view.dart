import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/america_states_tile_buttons.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/country_tile_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:flutter/material.dart';

class CountriesScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CountriesScreenBrowseView({
    required this.onCountryTap,
    required this.onDisabledCountryTap,
    required this.shownCountriesIDs,
    required this.notShownCountriesIDs,
    required this.countriesCensus,
    required this.showPlanetButton,
    required this.planetCensus,
    required this.onPlanetTap,
    required this.selectedZone,
    this.padding,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onCountryTap;
  final ValueChanged<String?>? onDisabledCountryTap;
  final EdgeInsets? padding;
  final List<String>? shownCountriesIDs;
  final List<String>? notShownCountriesIDs;
  final List<CensusModel>? countriesCensus;
  final bool showPlanetButton;
  final CensusModel? planetCensus;
  final Function onPlanetTap;
  final ZoneModel? selectedZone;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<String> _countriesList = <String>[...?shownCountriesIDs, ...?notShownCountriesIDs];
    // --------------------
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _countriesList.length + 1,
      padding: padding ?? Stratosphere.getStratosphereSandwich(context: context, appBarType: AppBarType.search),
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
            isSelected: selectedZone == null,
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

          final String _countryID = _countriesList[index-1];

          /// USA STATES
          if (_countryID == 'usa'){

            return AmericaStatesTileButtons(
              censusModels: const [],
              onStateTap: (String stateID) => onCountryTap(stateID),
            );

          }

          /// NORMAL COUNTRIES
          else {

            final CensusModel? _census = CensusModel.getCensusFromCensusesByID(
              censuses: countriesCensus,
              censusID: _countryID,
            );

            return CountryTileButton(
              countryID: _countryID,
              isActive: Stringer.checkStringsContainString(strings: shownCountriesIDs, string: _countryID),
              censusModel: _census,
              isSelected: selectedZone?.countryID == _countryID,
              onTap: () => onCountryTap(_countryID),
              onDeactivatedTap: onDisabledCountryTap == null ? null :
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
