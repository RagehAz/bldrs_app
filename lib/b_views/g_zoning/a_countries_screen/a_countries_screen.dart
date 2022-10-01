import 'dart:async';

import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/aa_countries_screen_browse_view.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/aa_countries_screen_search_view.dart';
import 'package:bldrs/b_views/g_zoning/b_cities_screen/a_cities_screen.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/g_zoning/x_zoning_controllers.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class CountriesScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const CountriesScreen({
    this.selectCountryIDOnly = false,
    this.selectCountryAndCityOnly = false,
    this.settingCurrentZone = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool selectCountryIDOnly;
  final bool selectCountryAndCityOnly;
  final bool settingCurrentZone;
  /// --------------------------------------------------------------------------
  @override
  _CountriesScreenState createState() => _CountriesScreenState();
  /// --------------------------------------------------------------------------
}

class _CountriesScreenState extends State<CountriesScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<Phrase>> _foundCountries = ValueNotifier<List<Phrase>>(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'SelectCountryScreen',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _isSearching.dispose();
    _foundCountries.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onCountryTap(String countryID) async {

    if (mounted == true){
      Keyboard.closeKeyboard(context);
    }

    final ZoneModel _zone = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: ZoneModel(
        countryID: countryID,
      ),
    );

    /// A - WHEN  SEQUENCE IS SELECTING (COUNTRY) ONLY
    if (widget.selectCountryIDOnly){
      await Nav.goBack(
        context: context,
        invoker: '_onCountryTap',
        passedData: _zone,
      );
    }

    else {

      /// A - WHEN SEQUENCE IS SELECTING (COUNTRY + CITY) ONLY
      if (widget.selectCountryAndCityOnly == true) {

        /// C - GO SELECT CITY
        final ZoneModel _zoneWithCity = await Nav.goToNewScreen(
            context: context,
            screen: CitiesScreen(
              country: _zone.countryModel,
              selectCountryAndCityOnly: widget.selectCountryAndCityOnly,
            )
        );

        /// IF SETTING CURRENT ZONE
        if (widget.settingCurrentZone == true){

          await setCurrentZone(
            context: context,
            zone: _zoneWithCity ?? _zone,
          );

        }

        /// IF RETURNING THE ZONE
        else {

          if (_zoneWithCity == null){
            await Nav.goBack(
              context: context,
              invoker: '_onCountryTap',
              passedData: _zone,
            );
          }

          else {
            await Nav.goBack(
              context: context,
              invoker: '_onCountryTap',
              passedData: _zoneWithCity,
            );
          }

        }


      }

      /// A - WHEN SEQUENCE SELECTING (COUNTRY + CITY + DISTRICT)
      else {

        final ZoneModel _zoneWithCityAndDistrict = await Nav.goToNewScreen(
            context: context,
            screen: CitiesScreen(
              country: _zone.countryModel,
              // selectCountryAndCityOnly: false,
            )
        );

        if (_zoneWithCityAndDistrict == null){
          await Nav.goBack(
            context: context,
            invoker: '_onCountryTap',
            passedData: _zone,
          );
        }
        else {
          await Nav.goBack(
            invoker: '_onCountryTap',
            context: context,
            passedData: _zoneWithCityAndDistrict,
          );
        }

      }

    }

  }
  // --------------------
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
      _foundCountries.value = await _searchCountriesPhrasesByName(
        context: context,
        lingoCode: TextCheck.concludeEnglishOrArabicLang(val),
        countryName: val,
      );

      /// CLOSE LOADING
      await _triggerLoading(setTo: false);

    }

  }
  // --------------------
  Future<List<Phrase>> _searchCountriesPhrasesByName({
    @required BuildContext context,
    @required String countryName,
    @required String lingoCode
  }) async {

    List<Phrase> _phrases = <Phrase>[];

    final List<Map<String, dynamic>> _maps = await LDBOps.searchPhrasesDoc(
      docName: LDBDoc.countriesPhrases,
      lingCode: lingoCode,
      searchValue: countryName,
    );
    if (Mapper.checkCanLoopList(_maps) == true){
      _phrases = Phrase.decipherMixedLangPhrases(maps: _maps,);
    }

    final List<Phrase> _cleaned = Phrase.cleanDuplicateIDs(
      phrases: _phrases,
    );

    return _cleaned;
  }
  // --------------------
  Future<void> _onBack() async {

    await Nav.goBack(
      context: context,
      invoker: 'SelectCountryScreen',
    );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      skyType: SkyType.black,
      appBarType: AppBarType.search,
      historyButtonIsOn: false,
      sectionButtonIsOn: false,
      onSearchSubmit: _onSearchCountry,
      onSearchChanged: _onSearchCountry,
      pageTitleVerse: const Verse(
        text: 'phid_select_a_country',
        translate: true,
      ),
      pyramidsAreOn: true,
      onBack: _onBack,
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
                onCountryTap: (String countryID) => _onCountryTap(countryID),
              );

            }

            /// NOT SEARCHING
            else {

              return CountriesScreenBrowseView(
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
