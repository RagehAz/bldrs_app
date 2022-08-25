import 'dart:async';

import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/aaa_select_country_screen_all_countries_view.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/aaa_select_country_screen_search_view.dart';
import 'package:bldrs/b_views/x_screens/h_zoning/b_select_city_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/c_protocols/zone_protocols/a_zone_protocols.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCountryScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SelectCountryScreen({
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
  _SelectCountryScreenState createState() => _SelectCountryScreenState();
/// --------------------------------------------------------------------------
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
// -----------------------------------------------------------------------------
  final ValueNotifier<bool> _isSearching = ValueNotifier<bool>(false);
  final ValueNotifier<List<Phrase>> _foundCountries = ValueNotifier<List<Phrase>>(null);
// -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
// -----------
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
// -----------------------------------------------------------------------------
  /// TAMAM
  @override
  void dispose() {
    _isSearching.dispose();
    _foundCountries.dispose();
    _loading.dispose();
    super.dispose();
  }
// ------------------------------------------------
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
      Nav.goBack(
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
            screen: SelectCityScreen(
              country: _zone.countryModel,
              selectCountryAndCityOnly: widget.selectCountryAndCityOnly,
            )
        );

        /// IF SETTING CURRENT ZONE
        if (widget.settingCurrentZone == true){

          unawaited(WaitDialog.showWaitDialog(
            context: context,
            loadingVerse: '##Loading, please wait',
          ));

          final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
          zoneProvider.setCurrentZone(
            zone: _zoneWithCity ?? _zone,
            notify: true,
          );

          final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
          await _chainsProvider.reInitializeCityChains(context);

          WaitDialog.closeWaitDialog(context);

          Nav.goBackToHomeScreen(
            context: context,
            invoker: 'SelectCountryScreen._onCountryTap'
          );

        }

        /// IF RETURNING THE ZONE
        else {

          if (_zoneWithCity == null){
            Nav.goBack(
              context: context,
              invoker: '_onCountryTap',
              passedData: _zone,
            );
          }

          else {
            Nav.goBack(
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
            screen: SelectCityScreen(
              country: _zone.countryModel,
              // selectCountryAndCityOnly: false,
            )
        );

        if (_zoneWithCityAndDistrict == null){
          Nav.goBack(
            context: context,
            invoker: '_onCountryTap',
            passedData: _zone,
          );
        }
        else {
          Nav.goBack(
              invoker: '_onCountryTap',
              context: context,
              passedData: _zoneWithCityAndDistrict,
          );
        }

      }

    }

  }
// -----------------------------------------------------------------------------
  Future<void> _onSearchCountry(String val) async {

    TextChecker.triggerIsSearchingNotifier(
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
        lingoCode: TextChecker.concludeEnglishOrArabicLang(val),
        countryName: val,
      );

      /// CLOSE LOADING
      await _triggerLoading(setTo: false);

    }

  }
// -------------------------------------
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
// -------------------------------------
  void _onBack(){

    Nav.goBack(
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
      pageTitleVerse: 'phid_select_a_country',
      pyramidsAreOn: true,
      onBack: _onBack,
      searchHintVerse: 'phid_search_countries',
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

              return SelectCountryScreenAllCountriesView(
                  onCountryTap: (String countryID) => _onCountryTap(countryID),
                );

            }

          },
        ),
      ),

    );

  }

}
