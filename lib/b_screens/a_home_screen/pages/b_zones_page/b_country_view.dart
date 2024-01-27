import 'package:basics/components/animators/widget_fader.dart';
import 'package:basics/models/phrase_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/g_statistics/census/census_model.dart';
import 'package:bldrs/b_screens/d_zoning/a_countries_screen/aa_countries_screen_browse_view.dart';
import 'package:bldrs/b_screens/d_zoning/a_countries_screen/aa_countries_screen_search_view.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/z_components/layouts/custom_layouts/app_bar_holder.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/loading/loading_tiles.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class SelectCountryView extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SelectCountryView({
    required this.onSearch,
    required this.loading,
    required this.isSearching,
    required this.foundCountries,
    required this.activeCountriesIDs,
    required this.disabledCountriesIDs,
    required this.censuses,
    required this.onCountryTap,
    required this.onDeactivatedCountryTap,
    required this.planetCensus,
    required this.onPlanetTap,
    super.key
  });
  // --------------------
  final ValueChanged<String?>? onSearch;
  final ValueNotifier<bool> loading;
  final ValueNotifier<bool> isSearching;
  final ValueNotifier<List<Phrase>?> foundCountries;
  final List<String> activeCountriesIDs;
  final List<String> disabledCountriesIDs;
  final List<CensusModel>? censuses;
  final Function(String countryID) onCountryTap;
  final Function(String? countryID) onDeactivatedCountryTap;
  final CensusModel? planetCensus;
  final Function() onPlanetTap;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final ZoneModel? _selectedZone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: true,
    );
    // --------------------
    return AppBarHolder(
      appBarType: AppBarType.main,
      searchButtonIsOn: false,
      onSearchSubmit: onSearch,
      onSearchChanged: onSearch,
      // title: const Verse(
      //   id: 'phid_select_a_country',
      //   translate: true,
      // ),
      // onBack: () => Nav.goBack(
      //   context: context,
      //   invoker: 'SelectCountryScreen.BACK with null',
      // ),
      canGoBack: false,
      searchHintVerse: const Verse(
        id: 'phid_search_countries',
        translate: true,
      ),
      // loading: loading,
      child: ValueListenableBuilder(
          valueListenable: loading,
          builder: (BuildContext context, bool loading, Widget? child){

            if (loading == true){
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

                      return CountriesScreenSearchView(
                        foundCountries: foundCountries,
                        activeCountriesIDs: activeCountriesIDs,
                        disabledCountriesIDs: disabledCountriesIDs,
                        countriesCensus: censuses,
                        selectedZone: _selectedZone,
                        onCountryTap: onCountryTap,
                        onDisabledCountryTap: onDeactivatedCountryTap,
                        appBarType: AppBarType.main,
                      );

                    }

                    /// WHILE BROWSING
                    else {
                      return CountriesScreenBrowseView(
                        shownCountriesIDs: activeCountriesIDs,
                        disabledCountriesIDs: disabledCountriesIDs,
                        countriesCensus: censuses,
                        planetCensus: planetCensus,
                        selectedZone: _selectedZone,
                        onCountryTap: onCountryTap,
                        onDisabledCountryTap: onDeactivatedCountryTap,
                        onPlanetTap: onPlanetTap,
                        showPlanetButton: StagingModel.checkMayShowViewAllZonesButton(
                          zoneViewingEvent: ViewingEvent.homeView,
                        ),
                        appBarType: AppBarType.main,
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
