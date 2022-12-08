import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/b_country/country_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/b_views/g_zoning/c_districts_screen/aa_districts_screen_browse_view.dart';
import 'package:bldrs/b_views/g_zoning/c_districts_screen/aa_districts_screen_search_view.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/real/census_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class DistrictsScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const DistrictsScreen({
    @required this.zoneViewingEvent,
    @required this.country,
    @required this.city,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final CountryModel country;
  final CityModel city;
  final ZoneViewingEvent zoneViewingEvent;
  /// --------------------------------------------------------------------------
  @override
  State<DistrictsScreen> createState() => _DistrictsScreenState();
  /// --------------------------------------------------------------------------
}

class _DistrictsScreenState extends State<DistrictsScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<DistrictModel>> _cityDistricts = ValueNotifier<List<DistrictModel>>(<DistrictModel>[]);
  final ValueNotifier<List<DistrictModel>> _foundDistricts = ValueNotifier<List<DistrictModel>>(null);
  ValueNotifier<ZoneModel> _currentZone;
  // --------------------
  List<CensusModel> _censusModels = [];
  List<String> _shownDistrictsIDs = [];
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
      countryID: widget.country.id,
      countryModel: widget.country,
      cityID: widget.city.cityID,
      cityModel: widget.city,
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

        await loadDistricts();

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
    _isSearching.dispose();
    _cityDistricts.dispose();
    _foundDistricts.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LOAD

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> loadDistricts() async {

    /// COMPLETE CURRENT ZONE
    _currentZone.value = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: _currentZone.value,
    );

    final ZoneStages _districtsStages = await ZoneProtocols.readDistrictsStages(
      cityID: widget.city.cityID,
    );

    if (_districtsStages != null){

      final List<DistrictModel> _fetchedDistricts = await ZoneProtocols.fetchDistrictsOfCityByIDs(
        districtsIDsOfThisCity: _districtsStages.getAllIDs(),
      );

      if (mounted == true){

        /// SHOWN DISTRICTS IDS
        final List<String> _shownIDs = _districtsStages.getIDsByViewingEvent(
          context: context,
          event: widget.zoneViewingEvent,
        );
        /// SHOWN DISTRICTS MODELS
        final List<DistrictModel> _shownDistricts = DistrictModel.getDistrictsFromDistrictsByIDs(
          districtsModels: _fetchedDistricts,
          districtsIDs: _shownIDs,
        );

        /// NOT SHOWN DISTRICTS IDS
        final List<String> _notShownIDs = Stringer.removeStringsFromStrings(
          removeFrom: DistrictModel.getDistrictsIDs(_fetchedDistricts),
          removeThis: _shownIDs,
        );
        /// NOT SHOWN DISTRICTS MODELS
        final List<DistrictModel> _notShownDistricts = DistrictModel.getDistrictsFromDistrictsByIDs(
          districtsModels: _fetchedDistricts,
          districtsIDs: _notShownIDs,
        );


        final List<DistrictModel> _orderedShownDistricts = DistrictModel.sortDistrictsAlphabetically(
          context: context,
          districts: _shownDistricts,
        );
        final List<DistrictModel> _orderedNotShownDistricts = DistrictModel.sortDistrictsAlphabetically(
          context: context,
          districts: _notShownDistricts,
        );

        _cityDistricts.value = <DistrictModel>[..._orderedShownDistricts, ..._orderedNotShownDistricts];


        final List<CensusModel> _districtsCensus = await CensusRealOps.readDistrictsOfCityCensus(
          cityID: widget.city.cityID,
        );

        setState(() {
          _shownDistrictsIDs = _shownIDs;
          _censusModels = _districtsCensus;
        });

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchDistrict(String inputText) async {

    TextCheck.triggerIsSearchingNotifier(
        text: inputText,
        isSearching: _isSearching
    );

    /// WHILE SEARCHING
    if (_isSearching.value == true){

      /// START LOADING
      await _triggerLoading(setTo: true);

      /// CLEAR PREVIOUS SEARCH RESULTS
      _foundDistricts.value = <DistrictModel>[];

      /// SEARCH COUNTRIES FROM LOCAL PHRASES
      _foundDistricts.value = DistrictModel.searchDistrictsByCurrentLingoName(
        context: context,
        sourceDistricts: _cityDistricts.value,
        inputText: TextMod.fixCountryName(inputText),
      );

      /// CLOSE LOADING
      await _triggerLoading(setTo: false);

    }

  }
  // -----------------------------------------------------------------------------

  /// NAV

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDistrictTap(String districtID) async {

    await ZoneSelection.onSelectDistrict(
      context: context,
      districtID: districtID,
    );

    // if (mounted == true){
    //   Keyboard.closeKeyboard(context);
    // }
    //
    // final ZoneModel _zoneWithDistrict = await ZoneProtocols.completeZoneModel(
    //   context: context,
    //   incompleteZoneModel: _currentZone.value.copyWith(
    //     districtID: districtID,
    //   ),
    // );
    //
    // await Nav.goBack(
    //   context: context,
    //   invoker: 'SelectDistrictScreen',
    //   passedData: _zoneWithDistrict,
    // );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDeactivatedDistrictTap(String districtID) async {
    blog('onDeactivatedDistrictTap : browse View : districtID: $districtID');

    await Dialogs.zoneIsNotAvailable(
      context: context,
    );

  }
  // --------------------
  /// DEPRECATED
  /*
  Future<void> _onBack() async {
    await Nav.goBack(
      context: context,
      invoker: 'SelectDistrictScreen',
    );
  }
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _cityName = CityModel.translateCity(
      context: context,
      city: widget.city,
    );

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      historyButtonIsOn: false,
      onSearchSubmit: _onSearchDistrict,
      onSearchChanged: _onSearchDistrict,
      pageTitleVerse: const Verse(
        text: 'phid_select_a_district',
        translate: true,
      ),
      pyramidsAreOn: true,
      onBack: () => Nav.goBack(
        context: context,
        invoker: 'SelectDistrictScreen',
      ),
      searchHintVerse: Verse(
        text: '${xPhrase( context, 'phid_search_districts_of')} $_cityName',
        translate: false,
      ),
      loading: _loading,
      layoutWidget: Scroller(
        child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (BuildContext context, bool isSearching, Widget child){

            /// WHILE SEARCHING
            if (isSearching == true){

              return DistrictsScreenSearchView(
                loading: _loading,
                foundDistricts: _foundDistricts,
                onDistrictTap: _onDistrictTap,
                censusModels: _censusModels,
                shownDistrictsIDs: _shownDistrictsIDs,
                onDeactivatedDistrictTap: _onDeactivatedDistrictTap,
              );

            }

            /// NOT SEARCHING
            else {

              return ValueListenableBuilder(
                valueListenable: _cityDistricts,
                builder: (_, List<DistrictModel> districts, Widget child){

                  return DistrictsScreenBrowseView(
                    onDistrictChanged: _onDistrictTap,
                    districts: districts,
                    censusModels: _censusModels,
                    shownDistrictsIDs: _shownDistrictsIDs,
                    onDeactivatedDistrictTap: _onDeactivatedDistrictTap,
                  );

                },
              );

            }

          },
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
