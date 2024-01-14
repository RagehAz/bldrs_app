import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/z_components/buttons/zone_buttons/city_tile_button.dart';
import 'package:bldrs/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class CitiesScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CitiesScreenSearchView({
    required this.onCityTap,
    required this.onDeactivatedCityTap,
    required this.loading,
    required this.foundCities,
    required this.shownCitiesIDs,
    required this.citiesCensuses,
    required this.selectedZone,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function(String? cityID)? onCityTap;
  final Function(String? cityID) onDeactivatedCityTap;
  final ValueNotifier<bool> loading;
  final ValueNotifier<List<CityModel>?> foundCities;
  final List<String>? shownCitiesIDs;
  final List<CensusModel>? citiesCensuses;
  final ZoneModel? selectedZone;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

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
              valueListenable: foundCities,
              builder: (_, List<CityModel>? foundCities, Widget? child){

                const EdgeInsets _topMargin = EdgeInsets.only(
                  top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2,
                  bottom: Ratioz.horizon,
                );

                /// WHEN SEARCH RESULTS
                if (Lister.checkCanLoop(foundCities) == true){

                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: foundCities!.length,
                      padding: _topMargin,
                      shrinkWrap: true,
                      itemBuilder: (_, int index) {

                        final CityModel? _city = foundCities[index];

                        final bool _isActive = Stringer.checkStringsContainString(
                          strings: shownCitiesIDs,
                          string: _city?.cityID,
                        );

                        final CensusModel? _census = CensusModel.getCensusFromCensusesByID(
                          censuses: citiesCensuses,
                          censusID: _city?.cityID,
                        );

                        return CityTileButton(
                          city: _city,
                          isActive: _isActive,
                          censusModel: _census,
                          isSelected: selectedZone?.countryID != null && selectedZone?.cityID == _city?.cityID,
                          onTap: onCityTap == null ? null : () => onCityTap?.call(_city?.cityID),
                          onDeactivatedTap: () => onDeactivatedCityTap(_city?.cityID),
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
