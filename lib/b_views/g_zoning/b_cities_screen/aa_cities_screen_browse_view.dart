import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/z_components/buttons/zone_buttons/city_tile_button.dart';
import 'package:bldrs/z_components/buttons/zone_buttons/country_tile_button.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class CitiesScreenBrowseView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const CitiesScreenBrowseView({
    required this.countryCities,
    required this.onCityTap,
    required this.shownCitiesIDs,
    required this.citiesCensuses,
    required this.onDeactivatedCityTap,
    required this.countryCensus,
    required this.onTapAllCities,
    required this.showAllCitiesButton,
    required this.selectedZone,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<List<CityModel>> countryCities;
  final Function(String? cityID) onCityTap;
  final Function(String? cityID) onDeactivatedCityTap;
  final List<String>? shownCitiesIDs;
  final List<CensusModel>? citiesCensuses;
  final CensusModel? countryCensus;
  final Function onTapAllCities;
  final bool showAllCitiesButton;
  final ZoneModel? selectedZone;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {


    return ValueListenableBuilder(
      key: const ValueKey<String>('CitiesScreenBrowseView'),
      valueListenable: countryCities,
      builder: (_, List<CityModel> cities, Widget? child){

        if (Lister.checkCanLoop(cities) == false){
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

                  final CityModel? _city = Lister.checkCanLoop(cities) == true ? cities.first : null;
                  final String? _countryID = CityModel.getCountryIDFromCityID(_city?.cityID);

                  return CountryTileButton(
                    verse: const Verse(
                      id: 'phid_view_all_cities',
                      translate: true,
                    ),
                    countryID: _countryID,
                    isActive: true,
                    censusModel: countryCensus,
                    onTap: onTapAllCities,
                    isSelected: selectedZone?.countryID != null && selectedZone?.cityID == null,
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
                final CensusModel? _census = CensusModel.getCensusFromCensusesByID(
                  censuses: citiesCensuses,
                  censusID: _city.cityID,
                );

                return CityTileButton(
                  city: _city,
                  isActive: _isActive,
                  censusModel: _census,
                  isSelected: selectedZone?.cityID == _city.cityID,
                  onTap: () => onCityTap(_city.cityID),
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
