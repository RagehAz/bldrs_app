// ignore_for_file: unused_element
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class ZoneSearchingTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ZoneSearchingTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _ZoneSearchingTestScreenState createState() => _ZoneSearchingTestScreenState();
/// --------------------------------------------------------------------------
}

class _ZoneSearchingTestScreenState extends State<ZoneSearchingTestScreen> {
  // -----------------------------------------------------------------------------
  List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];
  final TextEditingController _searchController = TextEditingController();
  static const List<Map<String, dynamic>> _initialMap = [
    {'id' : 'some ID', 'name' : 'some name',},
    {'id' : 'some ID2', 'name' : 'some name2',},
  ];
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

    _maps = _initialMap;

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchCancelled() async {
    blog('_onSearchCancelled');
    _searchController.clear();
    setState(() {
      _maps = _initialMap;
    });
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchSubmit(String text) async {
    // blog('_onSearchSubmit : $text');
    await _onSearchChanged(text);
  }
  // -----------------------------------------------------------------------------

  ///  ==> TESTER
  Future<void> _onSearchChanged(String text) async {
    blog('_onSearchChanged : $text');

    await _triggerLoading(setTo: true);

    /// COUNTRIES
    final List<Map<String, dynamic>> _countriesByID = await _searchCountriesByIDFromAllFlags(text);
    final List<Map<String, dynamic>> _countriesByName = await _searchCountriesByNameFromLDBFlags(text);
    /// CITIES OF PLANET
    final List<Map<String, dynamic>> _citiesOfPlanetByID = await _searchCitiesOfPlanetByIDFromFire(text);
    final List<Map<String, dynamic>> _citiesOfPlanetByName = await _searchCitiesOfPlanetByNameFromFire(text);
    /// CITIES OF COUNTRY
    final List<Map<String, dynamic>> _citiesOfCountryByID = await _searchCountryCitiesByIDFromFire(text);
    final List<Map<String, dynamic>> _citiesOfCountryByName = await _searchCountryCitiesByNameFromFire(text);

    /// DISTRICTS OF PLANET
    final List<Map<String, dynamic>> _districtsOfPlanetByID = await _searchDistrictsOfPlanetByIDFromFire(text);
    final List<Map<String, dynamic>> _districtsOfPlanetByName = await _searchDistrictOfPlanetByNameFromFire(text);
    /// DISTRICTS OF COUNTRY
    final List<Map<String, dynamic>> _districtsOfCountryByID = await _searchDistrictsOfCountryByIDFromFire(text);
    final List<Map<String, dynamic>> _districtsOfCountryByName = await _searchDistrictsOfCountryByNameFromFire(text);
    /// DISTRICTS OF CITY
    final List<Map<String, dynamic>> _districtsOfCityByID = await _searchDistrictsOfCityByIDFromFire(text);
    final List<Map<String, dynamic>> _districtsOfCityByName = await _searchDistrictsOfCityByNameFromFire(text);

    // final List<CityModel> _cities = await ZoneSearchOps.searchLDBCitiesByName(
    //   cityName: text,
    //   langCode: 'en',
    // );

    final List<Map<String, dynamic>> _found = [
      /// COUNTRIES
      ...?_countriesByID,
      ...?_countriesByName,
      /// CITIES OF PLANET
      ...?_citiesOfPlanetByID,
      ...?_citiesOfPlanetByName,
      /// CITIES OF COUNTRY
      ...?_citiesOfCountryByID,
      ...?_citiesOfCountryByName,

      /// DISTRICTS OF PLANET
       ...?_districtsOfPlanetByID,
       ...?_districtsOfPlanetByName,
      /// DISTRICTS OF COUNTRY
      ...?_districtsOfCountryByID,
      ...?_districtsOfCountryByName,
      /// DISTRICTS OF CITY
      ...?_districtsOfCityByID,
      ...?_districtsOfCityByName,

      // ...?CityModel.cipherCities(cities: _cities, toJSON: true, toLDB: true),
    ];

    setState(() {
      _maps = Mapper.cleanDuplicateMaps(maps: _found);
    });

    await _triggerLoading(setTo: false);

  }
  // -----------------------------------------------------------------------------

  /// DISTRICTS OF CITY

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchDistrictsOfCityByIDFromFire(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchDistrictsOfCityByIDFromFire(
      text: text,
      cityID: 'egy+alexandria',
    );

    return Phrase.cipherMixedLangPhrasesToMaps(phrases: _phrases,);
  }
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchDistrictsOfCityByNameFromFire(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchDistrictsOfCityByNameFromFire(
      text: text,
      cityID: 'egy+alexandria',
    );

    return Phrase.cipherMixedLangPhrasesToMaps(phrases: _phrases,);
  }
  // -----------------------------------------------------------------------------

  /// DISTRICTS OF COUNTRY

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchDistrictsOfCountryByIDFromFire(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchDistrictsOfCountryByIDFromFire(
      text: text,
      countryID: 'egy',
    );

    return Phrase.cipherMixedLangPhrasesToMaps(phrases: _phrases,);
  }
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchDistrictsOfCountryByNameFromFire(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchDistrictsOfCountryByNameFromFire(
      text: text,
      countryID: 'egy',
    );

    return Phrase.cipherMixedLangPhrasesToMaps(phrases: _phrases,);
  }
  // -----------------------------------------------------------------------------

  /// DISTRICTS OF PLANET

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchDistrictsOfPlanetByIDFromFire(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchDistrictsOfPlanetByIDFromFire(
      text: text,
    );

    return Phrase.cipherMixedLangPhrasesToMaps(phrases: _phrases,);
  }
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchDistrictOfPlanetByNameFromFire(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchDistrictOfPlanetByNameFromFire(
      text: text,
    );

    return Phrase.cipherMixedLangPhrasesToMaps(phrases: _phrases,);
  }
  // -----------------------------------------------------------------------------

  /// CITIES OF PLANET

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchCountryCitiesByNameFromFire(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchCountryCitiesByNameFromFire(
      text: text,
      countryID: 'egy',
    );

    return Phrase.cipherMixedLangPhrasesToMaps(phrases: _phrases,);
  }
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchCountryCitiesByIDFromFire(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchCountryCitiesByIDFromFire(
      text: text,
      countryID: 'egy',
    );

    return Phrase.cipherMixedLangPhrasesToMaps(phrases: _phrases,);
  }
  // -----------------------------------------------------------------------------

  /// CITIES OF PLANET

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchCitiesOfPlanetByNameFromFire(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchCitiesOfPlanetByNameFromFire(
      text: text,
    );

    return Phrase.cipherMixedLangPhrasesToMaps(phrases: _phrases,);
  }
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchCitiesOfPlanetByIDFromFire(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchCitiesOfPlanetByIDFromFire(
      text: text,
    );

    return Phrase.cipherMixedLangPhrasesToMaps(phrases: _phrases,);
  }
  // -----------------------------------------------------------------------------

  /// COUNTRIES

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchCountriesByNameFromLDBFlags(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchCountriesByNameFromLDBFlags(
      text: text,
    );

    return Phrase.cipherMixedLangPhrasesToMaps(phrases: _phrases,);

  }
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchCountriesByIDFromAllFlags(String text) async {

    final List<Phrase> _phrases = ZoneProtocols.searchCountriesByIDFromAllFlags(
      text: text,
    );

    return Phrase.cipherMixedLangPhrasesToMaps(
      phrases: _phrases,
      // includeTrigrams: true,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _clearWidth = Bubble.clearWidth(context);
    // --------------------
    return MainLayout(
      title: Verse.plain('Zone Searching Test'),
      loading: _loading,
      appBarType: AppBarType.search,
      searchController: _searchController,
      searchHintVerse: Verse.plain('search zones'),
      onSearchCancelled: _onSearchCancelled,
      onSearchChanged: _onSearchChanged,
      onSearchSubmit: _onSearchSubmit,
      pyramidsAreOn: true,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.getStratosphereSandwich(context: context, appBarType: AppBarType.search),
        children: <Widget>[

          if (Mapper.checkCanLoopList(_maps) == true)
            ...List.generate(_maps.length, (index){

              final Map<String, dynamic> _map = _maps[index];
              final List<String> _keys = _map.keys.toList();

              return Bubble(
                bubbleHeaderVM: BubbleHeaderVM(
                  headlineVerse: Verse.plain(index.toString()),
                ),
                columnChildren: <Widget>[

                  if (Mapper.checkCanLoopList(_keys) == true)
                  ...List.generate(_keys.length, (index){

                    final String _key = _keys[index];

                    return DataStrip(
                      dataKey: _key,
                      dataValue: _map[_key],
                      width: _clearWidth,
                      height: 30,
                      color: Colorz.black50,
                      highlightText: _searchController,
                    );

                  }),

                ],
              );

            }),

        ],
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
