import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
  Future<void> _onSearchSubmit(String text) async {
    // blog('_onSearchSubmit : $text');
    await _onSearchChanged(text);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onSearchCancelled() async {
    blog('_onSearchCancelled');
    _searchController.clear();
    setState(() {
      _maps = _initialMap;
    });
  }
  // --------------------
  /// TESTER
  Future<void> _onSearchChanged(String text) async {
    blog('_onSearchChanged : $text');

    await _triggerLoading(setTo: true);

    /// COUNTRIES
    final List<Map<String, dynamic>> _planetCountriesByID = await _searchCountriesByIDFromAllFlags(text);
    final List<Map<String, dynamic>> _planetCountriesByName = await _searchCountriesByNameFromLDBFlags(text);
    /// CITIES
    final List<Map<String, dynamic>> _planetCitiesByID = await _searchCitiesOfPlanetByIDFromFire(text);
    final List<Map<String, dynamic>> _planetCitiesByName = await _searchCitiesOfPlanetByNameFromFire(text);

    setState(() {
      _maps = [
        /// COUNTRIES
        ...?_planetCountriesByID,
        ...?_planetCountriesByName,
        /// CITIES
        ...?_planetCitiesByID,
        ...?_planetCitiesByName,

        /// DISTRICTS

      ];
    });

    await _triggerLoading(setTo: false);

  }
  // --------------------
  Future<List<Map<String, dynamic>>> _searchCitiesOfPlanetByNameFromFire(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchCitiesOfPlanetByNameFromFire(
      text: text,
    );

    return Phrase.cipherMixedLangPhrases(phrases: _phrases,);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchCitiesOfPlanetByIDFromFire(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchCitiesOfPlanetByIDFromFire(
      text: text,
    );

    return Phrase.cipherMixedLangPhrases(phrases: _phrases,);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchCountriesByNameFromLDBFlags(String text) async {

    final List<Phrase> _phrases = await ZoneProtocols.searchCountriesByNameFromLDBFlags(
      text: text,
    );

    return Phrase.cipherMixedLangPhrases(phrases: _phrases,);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<List<Map<String, dynamic>>> _searchCountriesByIDFromAllFlags(String text) async {

    final List<Phrase> _phrases = ZoneProtocols.searchCountriesByIDFromAllFlags(
      text: text,
    );

    return Phrase.cipherMixedLangPhrases(
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
      pageTitleVerse: Verse.plain('Zone Searching Test'),
      loading: _loading,
      appBarType: AppBarType.search,
      searchController: _searchController,
      searchHintVerse: Verse.plain('search zones'),
      onSearchCancelled: _onSearchCancelled,
      onSearchChanged: _onSearchChanged,
      onSearchSubmit: _onSearchSubmit,
      pyramidsAreOn: true,
      layoutWidget: ListView(
        physics: const BouncingScrollPhysics(),
        padding: Stratosphere.getStratosphereSandwich(context: context, appBarType: AppBarType.search),
        children: <Widget>[

          if (Mapper.checkCanLoopList(_maps) == true)
            ...List.generate(_maps.length, (index){

              final Map<String, dynamic> _map = _maps[index];
              final List<String> _keys = _map.keys.toList();

              return Bubble(
                headerViewModel: BubbleHeaderVM(
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
