import 'dart:async';

import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/a_models/k_statistics/census_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/aa_countries_screen_browse_view.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/aa_countries_screen_search_view.dart';
import 'package:bldrs/b_views/g_zoning/x_zoning_controllers.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/c_protocols/census_protocols/real/census_real_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class CountriesScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CountriesScreen({
    @required this.zoneViewingEvent,
    @required this.depth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ZoneViewingEvent zoneViewingEvent;
  final ZoneDepth depth;
  /// --------------------------------------------------------------------------
  @override
  _CountriesScreenState createState() => _CountriesScreenState();
  /// --------------------------------------------------------------------------
}

class _CountriesScreenState extends State<CountriesScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<Phrase>> _foundCountries = ValueNotifier<List<Phrase>>(null);
  // --------------------
  List<String> _shownCountriesIDs = <String>[];
  List<String> _notShownCountriesIDs = <String>[];
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
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        await _loadCountries();

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _isSearching.dispose();
    _foundCountries.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// LOADING

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _loadCountries() async {

    /// COUNTRIES STAGES
    final ZoneStages _countriesStages = await ZoneProtocols.readCountriesStages();

    /// SHOWN IDS
    final List<String> _shownIDs = _countriesStages.getIDsByViewingEvent(
      context: context,
      event: widget.zoneViewingEvent,
    );

    /// NOT SHOWN IDS
    final List<String> _notShownIDs = Stringer.removeStringsFromStrings(
      removeFrom: Flag.getAllCountriesIDs(),
      removeThis: _shownIDs,
    );

    /// CENSUS
    final List<CensusModel> _countriesCensuses = await CensusRealOps.readAllCountriesCensus();

    if (mounted) {
      setState(() {

        _shownCountriesIDs = Flag.sortCountriesNamesAlphabetically(
          context: context,
          countriesIDs: _shownIDs,
        );

        _notShownCountriesIDs = Flag.sortCountriesNamesAlphabetically(
          context: context,
          countriesIDs: _notShownIDs,
        );

        _censuses = _countriesCensuses;

      });
    }


  }
  // -----------------------------------------------------------------------------

  /// SEARCH

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchCountry(String val) async {

    TextCheck.triggerIsSearchingNotifier(
        text: val,
        isSearching: _isSearching
    );

    /// WHILE SEARCHING
    if (_isSearching.value == true){

      /// START LOADING
      await _triggerLoading(setTo: true);

      /// CLEAR PREVIOUS SEARCH RESULTS
      _foundCountries.value = <Phrase>[];

      /// SEARCH COUNTRIES FROM LOCAL PHRASES
       final List<Phrase> _byName = await ZoneProtocols.searchCountriesByNameFromLDBFlags(
        text: val,
      );

       final List<Phrase> _byID = ZoneProtocols.searchCountriesByIDFromAllFlags(
         text: val,
       );

      // _foundCountries.value = <Phrase>[..._byID, ..._byName];

      _foundCountries.value = Phrase.insertPhrases(
        insertIn: _byName,
        phrasesToInsert: _byID,
        overrideDuplicateID: true,
        allowDuplicateIDs: false,
      );

      /// CLOSE LOADING
      await _triggerLoading(setTo: false);

    }

  }
  // -----------------------------------------------------------------------------

  /// NAVIGATION

  // --------------------
  /// TASK : TEST ME
  Future<void> _onCountryTap(String countryID) async {

    await ZoneSelection.onSelectCountry(
        context: context,
        countryID: countryID,
        depth: widget.depth,
        zoneViewingEvent: widget.zoneViewingEvent,
    );

    /*
    if (mounted == true){
      Keyboard.closeKeyboard(context);
    }

    final ZoneModel _zone = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: ZoneModel(
        countryID: countryID,
      ),
    );

    /// SELECTING (COUNTRY) ONLY
    if (widget.selectCountryIDOnly == true){
      await _goBack(zone: _zone);
    }

    /// SELECTING (COUNTRY + CITY) ONLY
    else if (widget.selectCountryAndCityOnly == true) {

      await _navigationWhileSelectingCountryAndCityOnly(
        zone: _zone,
      );

    }

    /// SELECTING (COUNTRY + CITY + DISTRICT)
    else {

      await _navigationWhileSelectingCountryAndCityAndDistrict(
        zone: _zone,
      );

      blog('finished _navigationWhileSelectingCountryAndCityAndDistrict');

    }


     */
  }
  // -----------------------------------------------------------------------------
  /// DEPRECATED
  // -----------------------------------------------------------------------------
  // /// TESTED : WORKS PERFECT
  // Future<void> _goBack({
  //   ZoneModel zone,
  // }) async {
  //
  //   await Nav.goBack(
  //     context: context,
  //     invoker: 'SelectCountryScreen',
  //     passedData: zone,
  //   );
  //
  // }
  // -----------------------------------------------------------------------------
  //
  // / NAVIGATION WHILE SELECTING (COUNTRY + CITY) ONLY
  //
  // --------------------
  // /// TESTED : WORKS PERFECT
  // Future<void> _navigationWhileSelectingCountryAndCityOnly({
  //   @required ZoneModel zone,
  // }) async {
  //
  //   /// GO SELECT CITY
  //   final ZoneModel _zoneWithCity = await _goBringACity(zone: zone);
  //
  //   /// EXIT
  //   await _goBack(zone: _zoneWithCity ?? zone);
  //
  // }
  // --------------------
  // /// TESTED : WORKS PERFECT
  // Future<ZoneModel> _goBringACity({
  //   @required ZoneModel zone,
  // }) async {
  //   final ZoneModel _zoneWithCity = await Nav.goToNewScreen(
  //       context: context,
  //       screen: CitiesScreen(
  //         zoneViewingEvent: widget.zoneViewingEvent,
  //         country: zone.countryModel,
  //         selectCountryAndCityOnly: widget.selectCountryAndCityOnly,
  //       )
  //   );
  //   return _zoneWithCity;
  // }
  // -----------------------------------------------------------------------------
  //
  // / NAVIGATION WHILE SELECTING (COUNTRY + CITY + DISTRICT) ONLY
  //
  // --------------------
  // /// TESTED : WORKS PERFECT
  // Future<void> _navigationWhileSelectingCountryAndCityAndDistrict({
  //   @required ZoneModel zone,
  // }) async {
  //
  //   blog('_navigationWhileSelectingCountryAndCityAndDistrict : START');
  //
  //   /// GO SELECT CITY
  //   final ZoneModel _zoneWithCity = await _goBringACity(zone: zone);
  //
  //   if (_zoneWithCity?.cityID != null){
  //
  //     /// GO SELECT DISTRICT
  //     final ZoneModel _zoneWithCityAndDistrict = await _goBringADistrict(
  //       zone: _zoneWithCity,
  //     );
  //
  //     if (_zoneWithCityAndDistrict.districtID != null){
  //       await _goBack(zone: _zoneWithCityAndDistrict ?? _zoneWithCity ?? zone);
  //     }
  //
  //   }
  //
  // }
  // --------------------
  // /// TESTED : WORKS PERFECT
  // Future<ZoneModel> _goBringADistrict({
  //   @required ZoneModel zone,
  // }) async {
  //
  //   final ZoneModel _zoneWithCityAndDistrict = await Nav.goToNewScreen(
  //       context: context,
  //       screen: DistrictsScreen(
  //         zoneViewingEvent: widget.zoneViewingEvent,
  //         country: zone.countryModel,
  //         city: zone.cityModel,
  //       )
  //   );
  //
  //   return _zoneWithCityAndDistrict;
  // }
  // -----------------------------------------------------------------------------
  ///
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      historyButtonIsOn: false,
      onSearchSubmit: _onSearchCountry,
      onSearchChanged: _onSearchCountry,
      pageTitleVerse: const Verse(
        text: 'phid_select_a_country',
        translate: true,
      ),
      pyramidsAreOn: true,
      onBack: () => Nav.goBack(
        context: context,
        invoker: 'SelectCountryScreen.BACK with null',
      ),
      searchHintVerse: const Verse(
        text: 'phid_search_countries',
        translate: true,
      ),
      loading: _loading,
      layoutWidget: Scroller(
        child: ValueListenableBuilder(
          valueListenable: _isSearching,
          builder: (BuildContext context, bool isSearching, Widget child){

            /// WHILE SEARCHING
            if (isSearching == true){

              return SelectCountryScreenSearchView(
                loading: _loading,
                foundCountries: _foundCountries,
                shownCountriesIDs: _shownCountriesIDs,
                countriesCensus: _censuses,
                onCountryTap: (String countryID) => _onCountryTap(countryID),
              );

            }

            /// NOT SEARCHING
            else {

              return CountriesScreenBrowseView(
                shownCountriesIDs: _shownCountriesIDs,
                notShownCountriesIDs: _notShownCountriesIDs,
                countriesCensus: _censuses,
                onCountryTap: (String countryID) => _onCountryTap(countryID),
              );

            }

          },
        ),
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
