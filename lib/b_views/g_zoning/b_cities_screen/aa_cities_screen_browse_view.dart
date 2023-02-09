import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/city_tile_button.dart';
import 'package:bldrs/b_views/z_components/buttons/zone_buttons/country_tile_button.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';

import 'package:flutter/material.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class CitiesScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CitiesScreenBrowseView({
    @required this.countryCities,
    @required this.onCityTap,
    @required this.shownCitiesIDs,
    @required this.citiesCensuses,
    @required this.onDeactivatedCityTap,
    @required this.countryCensus,
    @required this.onTapAllCities,
    @required this.showAllCitiesButton,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ValueNotifier<List<CityModel>> countryCities;
  final Function(String cityID) onCityTap;
  final Function(String cityID) onDeactivatedCityTap;
  final List<String> shownCitiesIDs;
  final List<CensusModel> citiesCensuses;
  final CensusModel countryCensus;
  final Function onTapAllCities;
  final bool showAllCitiesButton;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    return ValueListenableBuilder(
      key: const ValueKey<String>('CitiesScreenBrowseView'),
      valueListenable: countryCities,
      builder: (_, List<CityModel> cities, Widget child){

        if (Mapper.checkCanLoopList(cities) == false){
          return const SizedBox();
        }

        else {

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: cities.length + 1,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: Ratioz.appBarBigHeight + Ratioz.appBarMargin * 2, bottom: Ratioz.horizon),
            itemBuilder: (BuildContext context, int index) {

              /// ALL CITIES BUTTON
              if (index == 0){

                if (showAllCitiesButton == false){
                  return const SizedBox();
                }

                else {
                  final String _countryID = CityModel.getCountryIDFromCityID(cities.first.cityID);
                  return CountryTileButton(
                    verse: const Verse(
                      id: 'phid_view_all_cities',
                      translate: true,
                    ),
                    countryID: _countryID,
                    isActive: true,
                    censusModel: countryCensus,
                    onTap: onTapAllCities,
                    onDeactivatedTap: (){
                      blog(
                          'onDeactivatedTap : for country : $_countryID '
                              'in CitiesScreenBrowseView, very weird, '
                              'should not happen'
                      );
                    },
                  );
                }

              }

              /// CITIES BUTTONS
              else {

                final CityModel _city = cities[index - 1];
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


            },
          );

        }

      },
    );

  }
// -----------------------------------------------------------------------------
}
