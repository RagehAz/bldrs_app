import 'dart:async';

import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/d_zoning/d_1_select_country_screen.dart';
import 'package:bldrs/b_views/x_screens/d_zoning/d_2_select_city_screen.dart';
import 'package:bldrs/b_views/x_screens/d_zoning/d_3_select_district_screen.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/search_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// -----------------------------------------------------------------------------

/// MAIN ZONING NAVIGATORS

// -------------------------------------
Future<ZoneModel> controlSelectCountryOnly(BuildContext context) async {

  final ZoneModel _zone = await goToNewScreen(context,
      const SelectCountryScreen(
        selectCountryIDOnly: true,
      )
  );

  return _zone;
}
// -----------------------------------------------------------------------------
Future<ZoneModel> controlSelectCountryAndCityOnly(BuildContext context) async {

  final ZoneModel _zone = await goToNewScreen(context,
      const SelectCountryScreen(
        selectCountryAndCityOnly: true,
      )
  );

  return _zone;
}
// -----------------------------------------------------------------------------
Future<ZoneModel> controlSelectZone(BuildContext context) async {

}
// -----------------------------------------------------------------------------

/// COUNTRY CONTROLLERS

// -------------------------------------
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
    Nav.goBack(context, argument: _zone);

    _zoneProvider.clearAllSearchesAndSelections();

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
      final String _cityID = await Nav.goToNewScreen(context, SelectCityScreen(
        country: _country,
        selectCountryAndCityOnly: selectCountryAndCityOnly,
      ));

      /// D - IF CITY IS SELECTED
      if (_cityID != null){

        /// D.1 DEFINE ZONE WITH COUNTRY AND CITY
        final ZoneModel _zone = ZoneModel(
          countryID: countryID,
          cityID: _cityID,
        );

        _zoneProvider.clearAllSearchesAndSelections();
        _searchProvider.closeAllZoneSearches();

        /// D.2 GO BACK
        Nav.goBack(context, argument: _zone);


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

      await Nav.goToNewScreen(context,
          SelectCityScreen(
              country: _country
          )
      );

    }

  }

}
// -------------------------------------
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

    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);

    _uiProvider.triggerLoading(setLoadingTo: true);
    _phraseProvider.clearSearchedCountries();

    // final List<ZoneModel> _countries = searchCountriesByNames(
    //   text: searchText,
    // );

    await _phraseProvider.getSetSearchedCountries(
      context: context,
      input: TextMod.fixCountryName(searchText),
    );

    _uiProvider.triggerLoading(setLoadingTo: false);

  }

}
// -------------------------------------
void controlCountryScreenOnBack(BuildContext context,){

  goBack(context);

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  /// CLOSE SEARCH
  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.country,
    setIsSearchingTo: false,
  );

  /// CLOSE SEARCH
  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.city,
    setIsSearchingTo: false,
  );

  /// CLOSE SEARCH
  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.district,
    setIsSearchingTo: false,
  );

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);

  _phraseProvider.clearSearchedCountries();

  _zoneProvider.clearSelectedCountryCities();
  _zoneProvider.clearSearchedCities();

  _zoneProvider.clearSelectedCityDistricts();
  _zoneProvider.clearSearchedDistricts();


}
// -----------------------------------------------------------------------------

/// CITY CONTROLLERS

// -------------------------------------
Future<void> initializeSelectCityScreen({
  @required BuildContext context,
  @required CountryModel countryModel,
}) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  _uiProvider.triggerLoading(setLoadingTo: true);

  await _zoneProvider.getSetSelectedCountryCities(
    context: context,
    countryModel: countryModel,
  );

  _uiProvider.triggerLoading(setLoadingTo: false);

}
// -------------------------------------
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

    _uiProvider.triggerLoading(setLoadingTo: false);
    _searchProvider.triggerIsSearching(
      searchingModel: SearchingModel.city,
      setIsSearchingTo: false,
    );

    _zoneProvider.clearAllSearchesAndSelections();
    Nav.goBack(context, argument: cityID);

  }

  else {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final List<CityModel> _selectedCountryCities = _zoneProvider.selectedCountryCities;

    final CityModel _city = CityModel.getCityFromCities(
      cities: _selectedCountryCities,
      cityID: cityID,
    );

    /// WHEN CITY HAS DISTRICTS
    if (Mapper.canLoopList(_city.districts)) {

      await Nav.goToNewScreen(context,
          SelectDistrictScreen(
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
        await _zoneProvider.getsetCurrentZoneAndCountryAndCity(context: context, zone: _zone);

        final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
        // final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);

        await _flyersProvider.paginateWallFlyers(
          // context: context,
          // section: _keywordsProvider.currentSection,
          // kw: _keywordsProvider.currentKeyword,
          context
        );

      }

      _uiProvider.triggerLoading(setLoadingTo: false);
      _searchProvider.triggerIsSearching(
        searchingModel: SearchingModel.city,
        setIsSearchingTo: false,
      );

      _zoneProvider.clearAllSearchesAndSelections();
      _searchProvider.closeAllZoneSearches();

      Nav.goBackToHomeScreen(context);
    }

  }


}
// -------------------------------------
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

    await _zoneProvider.getSetSearchedCities(
      context: context,
      input: TextMod.fixCountryName(searchText),
    );

  }

}
// -------------------------------------
void controlCityScreenOnBack(BuildContext context){

  goBack(context);

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  /// CLOSE SEARCH
  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.city,
    setIsSearchingTo: false,
  );

  /// CLOSE SEARCH
  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.district,
    setIsSearchingTo: false,
  );

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  _zoneProvider.clearSelectedCountryCities();
  _zoneProvider.clearSearchedCities();

  _zoneProvider.clearSelectedCityDistricts();
  _zoneProvider.clearSearchedDistricts();

}
// -----------------------------------------------------------------------------

/// DISTRICT CONTROLLERS

// -------------------------------------
Future<void> initializeSelectDistrictScreen({
  @required BuildContext context,
  @required CityModel cityModel,
}) async {

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  _uiProvider.triggerLoading(setLoadingTo: true);

  _zoneProvider.setSelectedCityDistricts(cityModel.districts);

  _uiProvider.triggerLoading(setLoadingTo: false);

}
// -------------------------------------
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

    await _zoneProvider.getsetCurrentZoneAndCountryAndCity(context: context, zone: _zone);

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    // final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);

    await _flyersProvider.paginateWallFlyers(
      // context: context,
      // section: _keywordsProvider.currentSection,
      // kw: _keywordsProvider.currentKeyword,
      context
    );

  }

  _uiProvider.triggerLoading(setLoadingTo: false);

  _searchProvider.closeAllZoneSearches();
  _zoneProvider.clearAllSearchesAndSelections();

  Nav.goBackToHomeScreen(context);

}
// -------------------------------------
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

    _zoneProvider.getSetSearchedDistricts(
      context: context,
      textInput: TextMod.fixCountryName(searchText),
    );

  }


}
// -------------------------------------
void controlDistrictScreenOnBack(BuildContext context){

  goBack(context);

  final SearchProvider _searchProvider = Provider.of<SearchProvider>(context, listen: false);

  /// CLOSE SEARCH
  _searchProvider.triggerIsSearching(
    searchingModel: SearchingModel.district,
    setIsSearchingTo: false,
  );


  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  _zoneProvider.clearSelectedCityDistricts();
  _zoneProvider.clearSearchedDistricts();

}
// -----------------------------------------------------------------------------
