import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/country_tile_button.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class SelectCountryScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SelectCountryScreenSearchView({
    @required this.onCountryTap,
    @required this.onDeactivatedCountryTap,
    @required this.loading,
    @required this.foundCountries,
    @required this.shownCountriesIDs,
    @required this.countriesCensus,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueChanged<String> onCountryTap;
  final ValueChanged<String> onDeactivatedCountryTap;
  final ValueNotifier<bool> loading;
  final ValueNotifier<List<Phrase>> foundCountries;
  final List<String> shownCountriesIDs;
  final List<CensusModel> countriesCensus;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WHEN SEARCH RESULTS
    return ValueListenableBuilder(
        valueListenable: loading,
        builder:(_, bool loading, Widget child){

          /// WHILE LOADING
          if (loading == true){
            return const LoadingFullScreenLayer();
          }

          /// SEARCH RESULT
          else {
            return ValueListenableBuilder(
              valueListenable: foundCountries,
              builder: (_, List<Phrase> foundCountries, Widget child){

                const EdgeInsets _topMargin = EdgeInsets.only(
                  top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2,
                  bottom: Ratioz.horizon,
                );

                /// WHEN SEARCH RESULTS
                if (Mapper.checkCanLoopList(foundCountries) == true){

                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: foundCountries.length,
                      padding: _topMargin,
                      shrinkWrap: true,
                      itemBuilder: (_, int index) {

                        final Phrase _countryPhrase = foundCountries[index];

                        final CensusModel _census = CensusModel.getCensusFromCensusesByID(
                          censuses: countriesCensus,
                          censusID: _countryPhrase.id,
                        );

                        return CountryTileButton(
                          countryID: _countryPhrase.id,
                          isActive: Stringer.checkStringsContainString(strings: shownCountriesIDs, string: _countryPhrase.id),
                          censusModel: _census,
                          onTap: () => onCountryTap(_countryPhrase.id),
                          onDeactivatedTap: () => onDeactivatedCountryTap(_countryPhrase.id),
                        );

                      }
                  );

                }

                /// WHEN RESULT IS EMPTY
                else {

                  return Container(
                    margin: _topMargin,
                    child: const SuperVerse(
                      verse: Verse(
                        text: 'phid_no_result_found',
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
