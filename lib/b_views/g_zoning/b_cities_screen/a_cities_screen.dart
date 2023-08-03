// ignore_for_file: invariant_booleans
import 'package:basics/animators/widgets/scroller.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/staging_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/aa_cities_screen_browse_view.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/aa_cities_screen_search_view.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/census_protocols/census_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/b_zone_search_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_protocols.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:flutter/material.dart';

class CitiesScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CitiesScreen({
    required this.zoneViewingEvent,
    required this.depth,
    required this.countryID,
    required this.viewerCountryID,
    required this.selectedZone,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ViewingEvent zoneViewingEvent;
  final ZoneDepth depth;
  final String? countryID;
  final String? viewerCountryID;
  final ZoneModel? selectedZone;
  /// --------------------------------------------------------------------------
  @override
  State<CitiesScreen> createState() => _NewSelectCityScreen();
  /// --------------------------------------------------------------------------
}

class _NewSelectCityScreen extends State<CitiesScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<CityModel>> _countryCities = ValueNotifier<List<CityModel>>(<CityModel>[]);
  final ValueNotifier<List<CityModel>?> _foundCities = ValueNotifier<List<CityModel>?>(null);
  ValueNotifier<ZoneModel>? _currentZone;
  List<String>? _shownCitiesIDs = <String>[];
  // Staging _stages;
  // --------------------
  List<CensusModel>? _censuses;
  CensusModel? _countryCensus;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
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
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {
        // ----------------------------------------

        await _loadCities();

        // ----------------------------------------
        await _triggerLoading(setTo: false);
      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _isSearching.dispose();
    _foundCities.dispose();
    _countryCities.dispose();
    _currentZone?.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LOAD

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadCities() async {

    if (widget.countryID != null){

      /// COMPLETE CURRENT ZONE
      final ZoneModel? _completedZone = await ZoneProtocols.completeZoneModel(
        incompleteZoneModel: _currentZone?.value,
      );

      setNotifier(
          notifier: _currentZone,
          mounted: mounted,
          value: _completedZone,
      );

      final StagingModel? _citiesStages = await StagingProtocols.fetchCitiesStaging(
        countryID: widget.countryID,
      );

      // blog('CITIES STAGES : ${_citiesStages?.getAllIDs()}');
      // _citiesStages?.blogStaging();

      final List<CityModel> _cities = await ZoneProtocols.fetchCitiesOfCountryByIDs(
        citiesIDsOfThisCountry: _citiesStages?.getAllIDs(),
      );

      // CityModel.blogCities(_cities);

      if (mounted == true){

        /// SHOWN CITIES IDS
        final List<String>? _shownIDs = _citiesStages?.getIDsByViewingEvent(
          event: widget.zoneViewingEvent,
          countryID: widget.countryID,
          viewerCountryID: widget.viewerCountryID,
        );
        /// SHOWN CITIES MODEL
        final List<CityModel> _orderedShownCities = CityModel.sortCitiesAlphabetically(
          cities: CityModel.getCitiesFromCitiesByIDs(
            citiesModels: _cities,
            citiesIDs: _shownIDs,
          ),
        );

        /// NOT SHOWN CITIES IDS
        final List<String>? _notShownIDs = Stringer.removeStringsFromStrings(
          removeFrom: CityModel.getCitiesIDs(_cities),
          removeThis: _shownIDs,
        );
        /// NOT SHOWN CITIES MODELS
        final List<CityModel> _orderedNotShownCities = CityModel.sortCitiesAlphabetically(
          cities: CityModel.getCitiesFromCitiesByIDs(
            citiesModels: _cities,
            citiesIDs: _notShownIDs,
          ),
        );

        final List<CensusModel> _citiesCensuses = await CensusProtocols.fetchCitiesCensuses(
            citiesIDs: <String>[...?_shownIDs, ...?_notShownIDs]
        );
        final CensusModel? _censusOfCountry = await CensusProtocols.fetchCountryCensus(
            countryID: widget.countryID,
        );

        if (mounted == true){
          setState(() {
            _shownCitiesIDs = _shownIDs;
            // _stages = _citiesStages;
            _censuses = _citiesCensuses;
            _countryCensus = _censusOfCountry;
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
    _currentZone.value  = await ZoneProtocols.completeZoneModel(
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

          _countryCities.value  = <CityModel>[..._ordered];

        }

      },
    );

    if (mounted == true){
      final List<CityModel> _ordered = CityModel.sortCitiesAlphabetically(
        context: context,
        cities: _fetchedCities,
      );
      _countryCities.value  = <CityModel>[..._ordered];
    }

  }
   */
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchCity(String? inputText) async {

    TextCheck.triggerIsSearchingNotifier(
      text: inputText,
      isSearching: _isSearching,
      mounted: mounted,
    );

    /// WHILE SEARCHING
    if (_isSearching.value  == true){

      /// START LOADING
      await _triggerLoading(setTo: true);

      /// CLEAR PREVIOUS SEARCH RESULTS
      setNotifier(
          notifier: _foundCities,
          mounted: mounted,
          value: <CityModel>[],
      );

      /// SEARCH COUNTRIES FROM LOCAL PHRASES
      final List<CityModel> _cities = await searchCitiesByName(
        context: context,
        input: TextMod.fixCountryName(input: inputText),
      );

      setNotifier(
          notifier: _foundCities,
          mounted: mounted,
          value: _cities,
      );

      /// CLOSE LOADING
      await _triggerLoading(setTo: false);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<CityModel>> searchCitiesByName({
    required BuildContext context,
    required String? input,
  }) async {

    /// SEARCH SELECTED COUNTRY CITIES
    final List<CityModel> _searchResult = ZoneSearchOps.searchCitiesByNameFromCities(
      context: context,
      sourceCities: _countryCities.value,
      inputText: input,
    );

    /// SET FOUND CITIES
    return _searchResult;

  }
  // -----------------------------------------------------------------------------

  /// NAV

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onCitySelected(String? cityID) async {

    await ZoneSelection.onSelectCity(
        context: context,
        cityID: cityID,
        depth: widget.depth,
        zoneViewingEvent: widget.zoneViewingEvent,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDeactivatedTap(String? cityID) async {

    blog('onDeactivatedCityTap : browseView : cityID : $cityID');

    await Dialogs.zoneIsNotAvailable();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onTapAllCities() async {

    await Nav.goBack(
      context: context,
    );

    await ZoneSelection.onSelectCountry(
      context: context,
      countryID: widget.countryID,
      depth: ZoneDepth.country,
      zoneViewingEvent: widget.zoneViewingEvent,
      viewerCountryID: widget.viewerCountryID,
      selectedZone: ZoneModel(
        countryID: widget.countryID,
      ),
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String? _countryName = Flag.translateCountry(
      langCode: Localizer.getCurrentLangCode(),
      countryID: widget.countryID,
    );

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      searchButtonIsOn: false,
      onSearchSubmit: _onSearchCity,
      onSearchChanged: _onSearchCity,
      title: const Verse(
        id: 'phid_selectCity',
        translate: true,
      ),
      pyramidsAreOn: true,
      onBack: () => Nav.goBack(
        context: context,
        invoker: 'SelectCityScreen',
      ),
      searchHintVerse: Verse(
        id: '${getWord('phid_search_cities_of')} ${_countryName ?? '...'}',
        translate: false,
      ),
      loading: _loading,
      // appBarRowWidgets: <Widget>[
      //
      //   // const Expander(),
      //
      //   // /// LOADING COUNTER
      //   // if (Mapper.checkCanLoopList(_stages?.getAllIDs()) == true)
      //   //   ValueListenableBuilder(
      //   //       valueListenable: _loading,
      //   //       builder: (_, bool isLoading, Widget child){
      //   //
      //   //         if (isLoading == false){
      //   //           return ValueListenableBuilder(
      //   //             valueListenable: _countryCities,
      //   //             builder: (_, List<CityModel> cities, Widget child){
      //   //
      //   //               return BldrsText(
      //   //                 verse: Verse.plain('${cities.length} / ${_stages?.getAllIDs()?.length ?? '-'}'),
      //   //                 weight: VerseWeight.thin,
      //   //                 size: 1,
      //   //                 margin: Scale.superInsets(
      //   //                   context: context,
      //   //                   appIsLTR: UiProvider.checkAppIsLeftToRight(),
      //   //                   bottom: 20,
      //   //                   enRight: 10,
      //   //                 ),
      //   //                 labelColor: Colorz.white20,
      //   //                 color: Colorz.yellow255,
      //   //               );
      //   //
      //   //             },
      //   //           );
      //   //         }
      //   //
      //   //         else {
      //   //           return const SizedBox();
      //   //         }
      //   //       }
      //   //   ),
      //
      // ],
      child: Scroller(
        child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (BuildContext context, bool isSearching, Widget? child){

            /// WHILE SEARCHING
            if (isSearching == true){

              return CitiesScreenSearchView(
                loading: _loading,
                foundCities: _foundCities,
                onCityTap: _onCitySelected,
                shownCitiesIDs: _shownCitiesIDs,
                citiesCensuses: _censuses,
                onDeactivatedCityTap: _onDeactivatedTap,
                selectedZone: widget.selectedZone,
              );

            }

            /// NOT SEARCHING
            else {

              return CitiesScreenBrowseView(
                onCityTap: _onCitySelected,
                countryCities: _countryCities,
                shownCitiesIDs: _shownCitiesIDs,
                citiesCensuses: _censuses,
                onDeactivatedCityTap: _onDeactivatedTap,
                countryCensus: _countryCensus,
                onTapAllCities: _onTapAllCities,
                selectedZone: widget.selectedZone,
                showAllCitiesButton: StagingModel.checkMayShowViewAllZonesButton(
                  zoneViewingEvent: widget.zoneViewingEvent,
                ),
              );

            }

          },
        ),
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
