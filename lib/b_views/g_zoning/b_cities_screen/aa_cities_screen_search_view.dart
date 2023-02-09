import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/city_tile_button.dart';
import 'package:bldrs/b_views/z_components/loading/loading_full_screen_layer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';


import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';

class CitiesScreenSearchView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CitiesScreenSearchView({
    @required this.onCityTap,
    @required this.onDeactivatedCityTap,
    @required this.loading,
    @required this.foundCities,
    @required this.shownCitiesIDs,
    @required this.citiesCensuses,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function(String cityID) onCityTap;
  final Function(String cityID) onDeactivatedCityTap;
  final ValueNotifier<bool> loading;
  final ValueNotifier<List<CityModel>> foundCities;
  final List<String> shownCitiesIDs;
  final List<CensusModel> citiesCensuses;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

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
              valueListenable: foundCities,
              builder: (_, List<CityModel> foundCities, Widget child){

                const EdgeInsets _topMargin = EdgeInsets.only(
                  top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2,
                  bottom: Ratioz.horizon,
                );

                /// WHEN SEARCH RESULTS
                if (Mapper.checkCanLoopList(foundCities) == true){


                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: foundCities.length,
                      padding: _topMargin,
                      shrinkWrap: true,
                      itemBuilder: (_, int index) {

                        final CityModel _city = foundCities[index];

                        final bool _isActive = Stringer.checkStringsContainString(
                          strings: shownCitiesIDs,
                          string: _city.cityID,
                        );

                        final CensusModel _census = CensusModel.getCensusFromCensusesByID(
                          censuses: citiesCensuses,
                          censusID: _city.cityID,
                        );

                        return WideCityButton(
                          city: _city,
                          isActive: _isActive,
                          censusModel: _census,
                          onSingleTap: () => onCityTap(_city.cityID),
                          onDeactivatedTap: () => onDeactivatedCityTap(_city.cityID),
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
