import 'dart:async';

import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// SET CURRENT ZONE

// --------------------
/// TESTED : WORKS PERFECT
Future<void> setCurrentZone({
  @required BuildContext context,
  @required ZoneModel zone,
}) async {

  if (zone != null && zone.countryID != null){

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingVerse: const Verse(
        text: 'phid_loading',
        translate: true,
      ),
    ));

    final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    /// SET ZONE
    zoneProvider.setCurrentZone(
      zone: zone,
      notify: false,
    );
    /// SET CURRENCY
    zoneProvider.getSetCurrentCurrency(
      context: context,
      zone: zone,
      notify: true,
    );

    /// SET CHAINS
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    await _chainsProvider.reInitializeCityChains(context);

    await WaitDialog.closeWaitDialog(context);

    await Nav.goBackToHomeScreen(
        context: context,
        invoker: 'SelectCountryScreen._onCountryTap'
    );

  }

}
// -----------------------------------------------------------------------------

/// MAIN ZONING NAVIGATORS

// --------------------
/// TESTED : WORKS PERFECT
Future<ZoneModel> controlSelectCountryOnly(BuildContext context) async {

  final ZoneModel _zone = await Nav.goToNewScreen(
      context: context,
      screen: const CountriesScreen(
        selectCountryIDOnly: true,
      )
  );

  return _zone;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<ZoneModel> controlSelectCountryAndCityOnly(BuildContext context) async {

  final ZoneModel _zone = await Nav.goToNewScreen(
    context: context,
    screen: const CountriesScreen(
      selectCountryAndCityOnly: true,

    ),

  );

  return _zone;
}
// -----------------------------------------------------------------------------
/*
Future<ZoneModel> controlSelectZone(BuildContext context) async {
}
 */
// -----------------------------------------------------------------------------

/// COUNTRY CONTROLLERS

// --------------------
/*
Future<void> controlCountryOnTap({
  @required BuildContext context,
  @required String countryID,
  @required bool selectCountryIDOnly,
  @required bool selectCountryAndCityOnly,
}) async {

  // blog('controlCountryOnTap : countryID : $countryID : selectCountryIDOnly : $selectCountryIDOnly : selectCountryAndCityOnly : $selectCountryAndCityOnly');
  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  /// A - WHEN  SEQUENCE IS SELECTING (COUNTRY) ONLY
  if (selectCountryIDOnly){

    /// B - DEFINE ZONE WITH COUNTRY ID ONLY
    final ZoneModel _zone = ZoneModel(
      countryID: countryID,
    );

    /// C - TAMAM
    await Nav.goBack(context, passedData: _zone);

    _zoneProvider.clearAllSearchesAndSelections(
      notify: true,
    );

  }


  else {

    /// A - WHEN SEQUENCE IS SELECTING (COUNTRY + CITY) ONLY
    if (selectCountryAndCityOnly) {

      /// B - FETCH COUNTRY MODEL
      final CountryModel _country= await _zoneProvider.fetchCountryByID(
          context: context,
          countryID: countryID,
      );

      /// C - GO SELECT CITY
      final String _cityID = await Nav.goToNewScreen(
          context: context,
          screen: SelectCityScreen(
            country: _country,
            selectCountryAndCityOnly: selectCountryAndCityOnly,
          )
      );

      /// D - IF CITY IS SELECTED
      if (_cityID != null){

        /// D.1 DEFINE ZONE WITH COUNTRY AND CITY
        final ZoneModel _zone = ZoneModel(
          countryID: countryID,
          cityID: _cityID,
        );

        _zoneProvider.clearAllSearchesAndSelections(
          notify: true,
        );
        _searchProvider.closeAllZoneSearches(
          notify: true,
        );

        /// D.2 GO BACK
        Nav.goBack(context, passedData: _zone);


      }

      /// D - IF CITY IS NOT SELECTED
      else {
        // ??
      }

    }

    /// A - WHEN SEQUENCE SELECTING (COUNTRY + CITY + DISTRICT)
    else {

      final CountryModel _country = await _zoneProvider.fetchCountryByID(
          context: context,
          countryID: countryID
      );

      await Nav.goToNewScreen(
          context: context,
          screen: SelectCityScreen(
              country: _country
          )
      );

    }

  }

}
// --------------------
Future<void> controlCountrySearch({
  @required BuildContext context,
  @required String searchText,
}) async {

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  final bool _isSearchingCountry = _searchProvider.isSearchingCountry;

  _searchProvider.triggerIsSearchingAfterMaxTextLength(
    searchModel: SearchingModel.country,
    isSearching: _isSearchingCountry,
    setIsSearchingTo: true,
    text: searchText,
  );

  if (_searchProvider.isSearchingCountry == true) {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    _uiProvider.triggerLoading(
      setLoadingTo: true,
      callerName: 'controlCountrySearch',
      notify: true,
    );
    _zoneProvider.clearSearchedCountries(
      notify: false,
    );

    // final List<ZoneModel> _countries = searchCountriesByNames(
    //   text: searchText,
    // );

    await _zoneProvider.searchSetCountriesByName(
      context: context,
      input: TextMod.fixCountryName(searchText),
      notify: true,
    );

    _uiProvider.triggerLoading(
      setLoadingTo: false,
      callerName: 'controlCountrySearch',
      notify: true,
    );

  }

}
// --------------------
void controlCountryScreenOnBack(BuildContext context,){

  Nav.goBack(context);

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  /// CLOSE SEARCH
  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.country,
    setIsSearchingTo: false,
    notify: false,
  );

  /// CLOSE SEARCH
  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.city,
    setIsSearchingTo: false,
    notify: false,
  );

  /// CLOSE SEARCH
  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.district,
    setIsSearchingTo: false,
    notify: true,
  );

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  _zoneProvider.clearSearchedCountries(
    notify: false,
  );

  _zoneProvider.clearSelectedCountryCities(
    notify: false,
  );
  _zoneProvider.clearSearchedCities(
    notify: false,
  );

  _zoneProvider.clearSelectedCityDistricts(
    notify: false,
  );
  _zoneProvider.clearSearchedDistricts(
    notify: true,
  );


}
 */
// -----------------------------------------------------------------------------

/// CITY CONTROLLERS

// --------------------
/*
Future<void> initializeSelectCityScreen({
  @required BuildContext context,
  @required CountryModel countryModel,
}) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  _uiProvider.triggerLoading(
    setLoadingTo: true,
    callerName: 'initializeSelectCityScreen',
    notify: true,
  );

  await _zoneProvider.fetchSetSelectedCountryCities(
    context: context,
    countryModel: countryModel,
    notify: true,
  );

  _uiProvider.triggerLoading(
    setLoadingTo: false,
    callerName: 'initializeSelectCityScreen',
    notify: true,
  );

}
// --------------------
Future<void> controlCityOnTap({
  @required BuildContext context,
  @required bool selectCountryAndCityOnly,
  @required String cityID,
  @required CountryModel country,
  @required bool settingCurrentZone,
}) async {

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    /// A - WHEN SELECTING (COUNTRY AND CITY) ONLY
  if (selectCountryAndCityOnly){

    _uiProvider.triggerLoading(
      setLoadingTo: false,
      callerName: 'controlCityOnTap',
      notify: true,
    );
    _searchProvider.triggerIsSearching(
      searchingModel: SearchingModel.city,
      setIsSearchingTo: false,
      notify: true,
    );

    _zoneProvider.clearAllSearchesAndSelections(
      notify: true,
    );

    Nav.goBack(context, passedData: cityID);

  }

  else {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final List<CityModel> _selectedCountryCities = _zoneProvider.selectedCountryCities;

    final CityModel _city = CityModel.getCityFromCities(
      cities: _selectedCountryCities,
      cityID: cityID,
    );

    /// WHEN CITY HAS DISTRICTS
    if (Mapper.checkCanLoopList(_city.districts)) {

      await Nav.goToNewScreen(
          context: context,
          screen: SelectDistrictScreen(
            city: _city,
            country: country,
            settingCurrentZone: settingCurrentZone,
          )
      );

    }

    /// WHEN CITY HAS NO DISTRICTS
    else {

      final ZoneModel _zone = ZoneModel(
        countryID: _city.countryID,
        cityID: _city.cityID,
      );
      _zone.blogZone(methodName: 'SELECTED ZONE');

      /// WHEN SEQUENCE IS TO SET CURRENT ZONE
      if (settingCurrentZone == true){

        final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
        await _zoneProvider.fetchSetCurrentCompleteZone(
          context: context,
          zone: _zone,
          notify: true,
        );

        final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
        // final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);

        await _flyersProvider.paginateWallFlyers(
          // context: context,
          // section: _keywordsProvider.currentSection,
          // kw: _keywordsProvider.currentKeyword,
          context
        );

      }

      _uiProvider.triggerLoading(
        setLoadingTo: false,
        callerName: 'controlCityOnTap',
        notify: true,
      );
      _searchProvider.triggerIsSearching(
        searchingModel: SearchingModel.city,
        setIsSearchingTo: false,
        notify: false,
      );

      _zoneProvider.clearAllSearchesAndSelections(
        notify: true,
      );
      _searchProvider.closeAllZoneSearches(
        notify: true,
      );

      Nav.goBackToHomeScreen(context);
    }

  }


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> controlCitySearch({
  @required BuildContext context,
  @required String searchText,
}) async {

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
  final bool _isSearchingCity = _searchProvider.isSearchingCity;

  _searchProvider.triggerIsSearchingAfterMaxTextLength(
    text: searchText,
    searchModel: SearchingModel.city,
    isSearching: _isSearchingCity,
    setIsSearchingTo: true,
  );

  if (_searchProvider.isSearchingCity == true) {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    await _zoneProvider.searchSetCitiesByName(
      context: context,
      input: TextMod.fixCountryName(searchText),
      notify: true,
    );

  }

}
// --------------------
void controlCityScreenOnBack(BuildContext context){

  Nav.goBack(context);

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  /// CLOSE SEARCH
  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.city,
    setIsSearchingTo: false,
    notify: false,
  );

  /// CLOSE SEARCH
  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.district,
    setIsSearchingTo: false,
    notify: true,
  );

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  _zoneProvider.clearSelectedCountryCities(
    notify: false,
  );
  _zoneProvider.clearSearchedCities(
    notify: false,
  );

  _zoneProvider.clearSelectedCityDistricts(
    notify: false,
  );
  _zoneProvider.clearSearchedDistricts(
    notify: true,
  );

}
 */
// -----------------------------------------------------------------------------

/// DISTRICT CONTROLLERS

// --------------------
/*
Future<void> initializeSelectDistrictScreen({
  @required BuildContext context,
  @required CityModel cityModel,
}) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  _uiProvider.triggerLoading(
    setLoadingTo: true,
    callerName: 'initializeSelectDistrictScreen',
    notify: true,
  );

  _zoneProvider.setSelectedCityDistricts(
    districts: cityModel.districts,
    notify: true,
  );

  _uiProvider.triggerLoading(
    setLoadingTo: false,
    callerName: 'initializeSelectDistrictScreen',
    notify: true,
  );

}
// --------------------
Future<void> controlDistrictOnTap({
  @required BuildContext context,
  @required String districtID,
  @required CityModel cityModel,
  @required bool settingCurrentZone,
}) async {

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  final ZoneModel _zone = ZoneModel(
    countryID: cityModel.countryID,
    cityID: cityModel.cityID,
    districtID: districtID,
  );


  _zone.blogZone(methodName: 'SELECTED ZONE');

  /// WHEN SEQUENCE IS TO SET CURRENT ZONE
  if (settingCurrentZone == true){

    await _zoneProvider.fetchSetCurrentCompleteZone(
      context: context,
      zone: _zone,
      notify: true,
    );

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    // final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);

    await _flyersProvider.paginateWallFlyers(
      // context: context,
      // section: _keywordsProvider.currentSection,
      // kw: _keywordsProvider.currentKeyword,
      context
    );

  }

  _uiProvider.triggerLoading(
    setLoadingTo: false,
    callerName: 'controlDistrictOnTap',
    notify: true,
  );

  _searchProvider.closeAllZoneSearches(
    notify: true,
  );
  _zoneProvider.clearAllSearchesAndSelections(
    notify: true,
  );

  Nav.goBackToHomeScreen(context);

}
// --------------------
Future<void> controlDistrictSearch({
  @required BuildContext context,
  @required String searchText,
}) async {

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);
  final bool _isSearchingDistrict = _searchProvider.isSearchingDistrict;

  _searchProvider.triggerIsSearchingAfterMaxTextLength(
    text: searchText,
    searchModel: SearchingModel.district,
    isSearching: _isSearchingDistrict,
    setIsSearchingTo: true,
  );

  if (_searchProvider.isSearchingDistrict == true) {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

    _zoneProvider.searchSetDistrictsByName(
      context: context,
      textInput: TextMod.fixCountryName(searchText),
      notify: true,
    );

  }


}
// --------------------
void controlDistrictScreenOnBack(BuildContext context){

  Nav.goBack(context);

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  /// CLOSE SEARCH
  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.district,
    setIsSearchingTo: false,
    notify: true,
  );


  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  _zoneProvider.clearSelectedCityDistricts(
    notify: false,
  );
  _zoneProvider.clearSearchedDistricts(
    notify: true,
  );

}
 */
// -----------------------------------------------------------------------------
