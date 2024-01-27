import 'package:basics/components/animators/widget_fader.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/b_screens/d_zoning/b_cities_screen/aa_cities_screen_browse_view.dart';
import 'package:bldrs/b_screens/d_zoning/b_cities_screen/aa_cities_screen_search_view.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/z_components/layouts/custom_layouts/app_bar_holder.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/loading/loading_tiles.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class SelectCityView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SelectCityView({
    required this.onSearch,
    required this.loading,
    required this.isSearching,
    required this.countryCities,
    required this.foundCities,
    required this.onCitySelected,
    required this.shownCitiesIDs,
    required this.citiesCensuses,
    required this.onCityDeactivatedTap,
    required this.countryCensus,
    required this.onTapAllCities,
    required this.selectedZone,
    required this.zoneViewingEvent,
    required this.appBarType,
    super.key
  });
  // --------------------
  final ValueChanged<String?>? onSearch;
  final ValueNotifier<bool> loading;
  final ValueNotifier<bool> isSearching;
  final ValueNotifier<List<CityModel>> countryCities;
  final ValueNotifier<List<CityModel>?> foundCities;
  final Function(String? cityID) onCitySelected;
  final List<String>? shownCitiesIDs;
  final List<CensusModel>? citiesCensuses;
  final Function(String? cityID) onCityDeactivatedTap;
  final CensusModel? countryCensus;
  final Function onTapAllCities;
  final ZoneModel selectedZone;
  final ViewingEvent zoneViewingEvent;
  final AppBarType appBarType;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String? _countryName = CountryModel.translateCountry(
      langCode: Localizer.getCurrentLangCode(),
      countryID: selectedZone.countryID,
    );
    // --------------------
    return AppBarHolder(
      appBarType: AppBarType.main,
      searchButtonIsOn: false,
      onSearchSubmit: onSearch,
      onSearchChanged: onSearch,
      // onBack: () => Nav.goBack(
      //   context: context,
      //   invoker: 'SelectCountryScreen.BACK with null',
      // ),
      canGoBack: false,
      searchHintVerse: Verse(
        id: '${getWord('phid_search_cities_of')} ${_countryName ?? '...'}',
        translate: false,
      ),
      // loading: loading,
      child: ValueListenableBuilder(
          valueListenable: loading,
          builder: (BuildContext context, bool isLoading, Widget? child){

            if (isLoading == true){
              return const LoadingTiles();
            }

            else {

              return WidgetFader(
                fadeType: FadeType.fadeIn,
                child: ValueListenableBuilder(
                  valueListenable: isSearching,
                  builder: (BuildContext context, bool isSearching, Widget? child){

                    /// WHILE SEARCHING
                    if (isSearching == true){

                      return CitiesScreenSearchView(
                        loading: loading,
                        foundCities: foundCities,
                        onCityTap: onCitySelected,
                        shownCitiesIDs: shownCitiesIDs,
                        citiesCensuses: citiesCensuses,
                        onDeactivatedCityTap: onCityDeactivatedTap,
                        selectedZone: selectedZone,
                        appBarType: appBarType,
                      );

                    }

                    /// NOT SEARCHING
                    else {

                      return CitiesScreenBrowseView(
                        onCityTap: onCitySelected,
                        countryCities: countryCities,
                        shownCitiesIDs: shownCitiesIDs,
                        citiesCensuses: citiesCensuses,
                        onDeactivatedCityTap: onCityDeactivatedTap,
                        countryCensus: countryCensus,
                        onTapAllCities: onTapAllCities,
                        selectedZone: selectedZone,
                        showAllCitiesButton: StagingModel.checkMayShowViewAllZonesButton(
                          zoneViewingEvent: zoneViewingEvent,
                        ),
                        appBarType: appBarType,
                      );

                    }

                  },
                ),
              );

            }

          }
      ),

    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
