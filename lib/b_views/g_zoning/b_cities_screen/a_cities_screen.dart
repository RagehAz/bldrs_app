// ignore_for_file: invariant_booleans

import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/aa_cities_screen_browse_view.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/aa_cities_screen_search_view.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/real/census_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/b_zone_search_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class CitiesScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CitiesScreen({
    @required this.zoneViewingEvent,
    @required this.depth,
    @required this.countryID,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneViewingEvent zoneViewingEvent;
  final ZoneDepth depth;
  final String countryID;
  /// --------------------------------------------------------------------------
  @override
  State<CitiesScreen> createState() => _NewSelectCityScreen();
  /// --------------------------------------------------------------------------
}

class _NewSelectCityScreen extends State<CitiesScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<CityModel>> _countryCities = ValueNotifier<List<CityModel>>(<CityModel>[]);
  final ValueNotifier<List<CityModel>> _foundCities = ValueNotifier<List<CityModel>>(null);
  ValueNotifier<ZoneModel> _currentZone;
  List<String> _shownCitiesIDs = <String>[];
  ZoneStages _stages;
  // --------------------
  List<CensusModel> _censuses;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    final ZoneModel _initialZone = ZoneModel(
      countryID: widget.countryID,
    );
    _currentZone = ValueNotifier<ZoneModel>(_initialZone);
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
        // ----------------------------------------

        await _loadCities();

        // ----------------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _isSearching.dispose();
    _foundCities.dispose();
    _countryCities.dispose();
    _currentZone.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LOAD

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadCities() async {

    if (widget.countryID != null){

      /// COMPLETE CURRENT ZONE
      _currentZone.value = await ZoneProtocols.completeZoneModel(
        context: context,
        incompleteZoneModel: _currentZone.value,
      );

      final ZoneStages _citiesStages = await ZoneProtocols.readCitiesStages(
        countryID: widget.countryID,
      );

      final List<CityModel> _cities = await ZoneProtocols.fetchCitiesOfCountryByIDs(
        citiesIDsOfThisCountry: _citiesStages.getAllIDs(),
      );

      if (mounted == true){

        /// SHOWN CITIES IDS
        final List<String> _shownIDs = _citiesStages.getIDsByViewingEvent(
          context: context,
          event: widget.zoneViewingEvent,
        );
        /// SHOWN CITIES MODELS
        final List<CityModel> _shownCities = CityModel.getCitiesFromCitiesByIDs(
          citiesModels: _cities,
          citiesIDs: _shownIDs,
        );

        /// NOT SHOWN CITIES IDS
        final List<String> _notShownIDs = Stringer.removeStringsFromStrings(
          removeFrom: CityModel.getCitiesIDs(_cities),
          removeThis: _shownIDs,
        );
        /// NOT SHOWN CITIES MODELS
        final List<CityModel> _notShownCities = CityModel.getCitiesFromCitiesByIDs(
          citiesModels: _cities,
          citiesIDs: _notShownIDs,
        );

        final List<CityModel> _orderedShownCities = CityModel.sortCitiesAlphabetically(
          context: context,
          cities: _shownCities,
        );
        final List<CityModel> _orderedNotShownCities = CityModel.sortCitiesAlphabetically(
          context: context,
          cities: _notShownCities,
        );

        final List<CensusModel> _citiesCensuses = await CensusRealOps.readCitiesOfCountryCensus(
            countryID: widget.countryID,
        );

        if (mounted == true){
          setState(() {
            _shownCitiesIDs = _shownIDs;
            _stages = _citiesStages;
            _censuses = _citiesCensuses;
          });
        }

        setNotifier(
          notifier: _countryCities,
          mounted: mounted,
          value: <CityModel>[..._orderedShownCities, ..._orderedNotShownCities],
        );


      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT : KEPT FOR REFERENCE
  /*
  Future<void> _oldLoadCities() async {

    /// COMPLETE CURRENT ZONE
    _currentZone.value = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: _currentZone.value,
    );

    List<CityModel> _growingList = <CityModel>[];
    final List<CityModel> _fetchedCities = await ZoneProtocols.fetchCities(
      citiesIDs: _currentZone.value.countryModel?.citiesIDs?.getAllIDs(),
      onCityRead: (CityModel city) async {

        if (mounted == true){

          _growingList = CityModel.addCityToCities(
            cities: _countryCities.value,
            city: city,
          );

          final List<CityModel> _ordered = CityModel.sortCitiesAlphabetically(
            context: context,
            cities: _growingList,
          );

          _countryCities.value = <CityModel>[..._ordered];

        }

      },
    );

    if (mounted == true){
      final List<CityModel> _ordered = CityModel.sortCitiesAlphabetically(
        context: context,
        cities: _fetchedCities,
      );
      _countryCities.value = <CityModel>[..._ordered];
    }

  }
   */
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchCity(String inputText) async {

    TextCheck.triggerIsSearchingNotifier(
        text: inputText,
        isSearching: _isSearching
    );

    /// WHILE SEARCHING
    if (_isSearching.value == true){

      /// START LOADING
      await _triggerLoading(setTo: true);

      /// CLEAR PREVIOUS SEARCH RESULTS
      _foundCities.value = <CityModel>[];

      /// SEARCH COUNTRIES FROM LOCAL PHRASES
      _foundCities.value = await searchCitiesByName(
        context: context,
        input: TextMod.fixCountryName(inputText),
      );

      /// CLOSE LOADING
      await _triggerLoading(setTo: false);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<CityModel>> searchCitiesByName({
    @required BuildContext context,
    @required String input,
  }) async {

    blog('searchCitiesByName : input : $input');

    /// SEARCH SELECTED COUNTRY CITIES
    final List<CityModel> _searchResult = ZoneSearchOps.searchCitiesByNameFromCities(
      context: context,
      sourceCities: _countryCities.value,
      inputText: input,
    );

    CityModel.blogCities(_searchResult,);

    /// SET FOUND CITIES
    return _searchResult;

  }
  // -----------------------------------------------------------------------------

  /// NAV

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onCitySelected(String cityID) async {

    await ZoneSelection.onSelectCity(
        context: context,
        cityID: cityID,
        depth: widget.depth,
        zoneViewingEvent: widget.zoneViewingEvent,
    );

    // blog('_onCityTap : cityID : $cityID');
    //
    // if (mounted == true){
    //   Keyboard.closeKeyboard(context);
    // }
    //
    // final ZoneModel _zoneWithCity = await ZoneProtocols.completeZoneModel(
    //   context: context,
    //   incompleteZoneModel: _currentZone.value.copyWith(
    //     cityID: cityID,
    //   ),
    // );
    //
    // final ZoneStages _cityDistrictsStages = await ZoneProtocols.readDistrictsStages(
    //   cityID: cityID,
    // );
    //
    // _zoneWithCity?.blogZone(invoker: '_onCityTap zone with city');
    //
    // /// TASK : CHECK WHICH STAGE SHOULD BE READ HERE
    // final bool _cityHasDistricts = Mapper.checkCanLoopList(_cityDistrictsStages?.getIDsByStage(null)) == true;
    //
    // /// IF SELECTING COUNTY AND CITY ONLY
    // if (widget.selectCountryAndCityOnly == true || _cityHasDistricts == false){
    //   await Nav.goBack(
    //     context: context,
    //     invoker: '_onCityTap',
    //     passedData: _zoneWithCity,
    //   );
    // }
    //
    // /// IF SELECTING COUNTRY AND CITY AND DISTRICT
    // else {
    //
    //   final ZoneModel _zoneWithDistrict = await Nav.goToNewScreen(
    //       context: context,
    //       screen: DistrictsScreen(
    //         zoneViewingEvent: widget.zoneViewingEvent,
    //         country: _zoneWithCity.countryModel,
    //         city: _zoneWithCity.cityModel,
    //       )
    //   );
    //
    //   /// WHEN NO DISTRICT SELECTED
    //   if (_zoneWithDistrict == null){
    //     await Nav.goBack(
    //       context: context,
    //       invoker: '_onCityTap',
    //       passedData: _zoneWithCity,
    //     );
    //   }
    //
    //   /// WHEN A DISTRICT IS SELECTED
    //   else {
    //     await Nav.goBack(
    //       context: context,
    //       invoker: '_onCityTap',
    //       passedData: _zoneWithDistrict,
    //     );
    //   }
    //
    // }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDeactivatedDistrictTap(String cityID) async {

    blog('onDeactivatedCityTap : browseView : cityID : $cityID');

    await Dialogs.zoneIsNotAvailable(
      context: context,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _countryName = Flag.getCountryNameByCurrentLang(
      context: context,
      countryID: widget.countryID,
    );

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      historyButtonIsOn: false,
      onSearchSubmit: _onSearchCity,
      onSearchChanged: _onSearchCity,
      pageTitleVerse: const Verse(
        text: 'phid_selectCity',
        translate: true,
      ),
      pyramidsAreOn: true,
      onBack: () => Nav.goBack(
        context: context,
        invoker: 'SelectCityScreen',
      ),
      searchHintVerse: Verse(
        text: '${xPhrase( context, 'phid_search_cities_of')} ${_countryName ?? '...'}',
        translate: false,
      ),
      loading: _loading,
      appBarRowWidgets: <Widget>[

        const Expander(),

        /// LOADING COUNTER
        if (Mapper.checkCanLoopList(_stages?.getAllIDs()) == true)
          ValueListenableBuilder(
              valueListenable: _loading,
              builder: (_, bool isLoading, Widget child){

                if (isLoading == true){
                  return ValueListenableBuilder(
                    valueListenable: _countryCities,
                    builder: (_, List<CityModel> cities, Widget child){

                      return SuperVerse(
                        verse: Verse.plain('${cities.length} / ${_stages?.getAllIDs()?.length ?? '-'}'),
                        weight: VerseWeight.thin,
                        size: 1,
                        margin: Scale.superInsets(context: context, bottom: 20, enRight: 10),
                        labelColor: Colorz.white20,
                        color: Colorz.yellow255,
                      );

                    },
                  );
                }

                else {
                  return const SizedBox();
                }
              }
          ),

      ],
      layoutWidget: Scroller(
        child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (BuildContext context, bool isSearching, Widget child){

            /// WHILE SEARCHING
            if (isSearching == true){

              return CitiesScreenSearchView(
                loading: _loading,
                foundCities: _foundCities,
                onCityTap: _onCitySelected,
                shownCitiesIDs: _shownCitiesIDs,
                citiesCensuses: _censuses,
                onDeactivatedCityTap: _onDeactivatedDistrictTap,
              );

            }

            /// NOT SEARCHING
            else {

              return CitiesScreenBrowseView(
                onCityTap: _onCitySelected,
                countryCities: _countryCities,
                shownCitiesIDs: _shownCitiesIDs,
                citiesCensuses: _censuses,
                onDeactivatedCityTap: _onDeactivatedDistrictTap,
                countryCensus: null, // TASK : GET COUNTRY CENSUS HERE,, OR DIRECTLY INSIDE
              );

            }

          },
        ),
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
