import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/country_tile_button.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:flutter/material.dart';

class SelectCountryScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectCountryScreenSearchView({
    required this.onCountryTap,
    required this.onDeactivatedCountryTap,
    required this.loading,
    required this.foundCountries,
    required this.shownCountriesIDs,
    required this.countriesCensus,
    required this.selectedZone,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueChanged<String?> onCountryTap;
  final ValueChanged<String?> onDeactivatedCountryTap;
  final ValueNotifier<bool> loading;
  final ValueNotifier<List<Phrase>?> foundCountries;
  final List<String> shownCountriesIDs;
  final List<CensusModel>? countriesCensus;
  final ZoneModel? selectedZone;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WHEN SEARCH RESULTS
    return ValueListenableBuilder(
        valueListenable: loading,
        builder:(_, bool loading, Widget? child){

          /// WHILE LOADING
          if (loading == true){
            return const LoadingFullScreenLayer();
          }

          /// SEARCH RESULT
          else {
            return ValueListenableBuilder(
              valueListenable: foundCountries,
              builder: (_, List<Phrase>? foundCountries, Widget? child){

                const EdgeInsets _topMargin = EdgeInsets.only(
                  top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2,
                  bottom: Ratioz.horizon,
                );

                /// WHEN SEARCH RESULTS
                if (Mapper.checkCanLoopList(foundCountries) == true){

                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: foundCountries!.length,
                      padding: _topMargin,
                      shrinkWrap: true,
                      itemBuilder: (_, int index) {

                        final Phrase? _countryPhrase = foundCountries[index];

                        final CensusModel? _census = CensusModel.getCensusFromCensusesByID(
                          censuses: countriesCensus,
                          censusID: _countryPhrase?.id,
                        );

                        return CountryTileButton(
                          countryID: _countryPhrase?.id,
                          isActive: Stringer.checkStringsContainString(
                              strings: shownCountriesIDs,
                              string: _countryPhrase?.id,
                          ),
                          censusModel: _census,
                          isSelected: _countryPhrase != null && selectedZone?.countryID == _countryPhrase.id,
                          onTap: () => onCountryTap(_countryPhrase?.id),
                          onDeactivatedTap: () => onDeactivatedCountryTap(_countryPhrase?.id),
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

        }
    );

  }
// -----------------------------------------------------------------------------
}
