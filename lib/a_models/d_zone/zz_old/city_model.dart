import 'package:bldrs/a_models/d_zone/zz_old/district_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/a_models/x_utilities/map_model.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

@immutable
class CityModel {
  /// --------------------------------------------------------------------------
  const CityModel({
    this.cityID,
    this.districts,
    this.population,
    this.position,
    this.phrases,
  });
  /// --------------------------------------------------------------------------
  final String cityID;
  final List<DistrictModel> districts;
  final int population;
  final GeoPoint position;
  final List<Phrase> phrases;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, Object> toMap({
    @required bool toJSON,
    @required bool toLDB,
  }){

    Map<String, dynamic> _map = {
      'districts': DistrictModel.cipherDistricts(districts: districts, toJSON: toJSON, toLDB: toLDB),
      'population': population,
      'position': Atlas.cipherGeoPoint(point: position, toJSON: toJSON),
      'phrases' : Phrase.cipherPhrasesToLangsMap(phrases),
    };

    if (toLDB == true){
      _map = Mapper.insertMapInMap(
        baseMap: _map,
        insert: {
          'cityID': cityID,
        },
      );
    }


    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherCities({
    @required List<CityModel> cities,
    @required bool toJSON,
    @required bool toLDB,
  }) {
    final List<Map<String, dynamic>> _output = [];

    if (Mapper.checkCanLoopList(cities) == true){

      for (final CityModel _city in cities){

        final Map<String, dynamic> _map = _city.toMap(
            toJSON: toJSON,
            toLDB: toLDB,
        );

        _output.add(_map);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CityModel decipherCity({
    @required Map<String, dynamic> map,
    @required String cityID,
    @required bool fromJSON,
  }) {
    CityModel _city;

    if (map != null) {
      _city = CityModel(
        cityID: cityID,
        districts: DistrictModel.decipherDistricts(map['districts']),
        population: map['population'],
        position: Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON,),
        phrases: Phrase.decipherPhrasesLangsMap(langsMap: map['phrases'], phid: cityID,),
      );
    }

    return _city;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CityModel> decipherCities({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<CityModel> _cities = <CityModel>[];

    if (Mapper.checkCanLoopList(maps) == true) {
      for (final Map<String, dynamic> map in maps) {
        _cities.add(
            decipherCity(
              map: map,
              fromJSON: fromJSON,
              cityID: map['id'],
            )
        );
      }
    }
    return _cities;
  }
  // --------------------
  /*
//   static List<CityModel> decipherCitiesMap({@required Map<String, dynamic> map, @required bool fromJSON}){
//     final List<CityModel> _cities = <CityModel>[];
//
//     final List<String> _keys = map.keys.toList();
//     final List<dynamic> _values = map.values.toList();
//
//     if (Mapper.canLoopList(_keys)){
//
//       for (int i = 0; i<_keys.length; i++){
//
//         final CityModel _city = decipherCityMap(
//           map: _values[i],
//           fromJSON: fromJSON,
//         );
//
//         _cities.add(_city);
//
//       }
//
//     }
//
//     return _cities;
//   }

   */
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TASK : TEST ME
  static List<String> getTranslatedCitiesNamesFromCities({
    @required BuildContext context,
    @required List<CityModel> cities,
  }) {
    // final List<String> _citiesNames = <String>[];
    //
    // if (Mapper.canLoopList(cities)) {
    //   for (final CityModel city in cities) {
    //     final String _cityName = Phrase.getPhraseByCurrentLangFromPhrases(context: context, phrases: city.phrases)?.value;
    //     _citiesNames.add(_cityName);
    //   }
    // }
    //
    // return TextMod.sortAlphabetically(_citiesNames);
    return null;
  }
  // --------------------
  /// TASK : TEST ME
  static List<MapModel> getCitiesNamesMapModels({
    @required BuildContext context,
    @required List<CityModel> cities,
  }) {
    final List<MapModel> _citiesMapModels = <MapModel>[];

    if (Mapper.checkCanLoopList(cities)) {
      for (final CityModel city in cities) {

        _citiesMapModels.add(MapModel(
            key: city.cityID,
            value: CityModel.getTranslatedCityNameFromCity(
                context: context,
                city: city
            )

          // Name.getNameByCurrentLingoFromNames(
          //     context: context,
          //     names: city.names
          // )
        )
        );
      }
    }

    return MapModel.sortValuesAlphabetically(_citiesMapModels);
  }
  // --------------------
  /// TASK : TEST ME
  static CityModel getCityFromCities({
    @required List<CityModel> cities,
    @required String cityID,
  }) {
    CityModel _city;
    if (Mapper.checkCanLoopList(cities)) {
      _city = cities.firstWhere((CityModel city) => city.cityID == cityID,
          orElse: () => null);
    }
    return _city;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getTranslatedCityNameFromCity({
    @required BuildContext context,
    @required CityModel city,
  }) {
    String _cityName;

    if (city != null) {

      final Phrase _phrase = Phrase.searchFirstPhraseByCurrentLang(
          context: context,
          phrases: city.phrases
      );

      if (_phrase != null){
        _cityName = _phrase.value;
      }

    }

    return _cityName;
  }
  // --------------------
  /// TASK : TEST ME
  static List<String> getCitiesIDsFromCities({
    @required List<CityModel> cities,
  }) {

    final List<String> _citiesIDs = <String>[];

    if (Mapper.checkCanLoopList(cities)) {
      for (final CityModel city in cities) {
        _citiesIDs.add(city.cityID);
      }
    }

    return _citiesIDs;
  }
  // --------------------
  /// TASK : TEST ME
  static String translateCityNameWithCurrentLingoIfPossible(BuildContext context, CityModel cityModel) {
    // final String _nameInCurrentLanguage = Phrase.getPhraseByCurrentLangFromPhrases(
    //     context: context,
    //     phrases: cityModel?.phrases
    // )?.value;
    //
    // return _nameInCurrentLanguage ?? cityModel?.cityID;
    return null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CityModel> _getCitiesFromPhrases({
    @required List<Phrase> phrases,
    @required List<CityModel> sourceCities,
  }){
    final List<CityModel> _foundCities = <CityModel>[];

    if (Mapper.checkCanLoopList(sourceCities) && Mapper.checkCanLoopList(phrases)){

      for (final Phrase phrase in phrases){

        for (final CityModel city in sourceCities){

          if (city.phrases.contains(phrase)){

            if (!_foundCities.contains(city)){
              _foundCities.add(city);

            }

          }

        }

      }

    }

    return _foundCities;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogCity() {
    blog('CITY - PRINT --------------------------------------- START');

    blog('cityID : $cityID');
    blog('population : $population');
    blog('position : $position');
    Phrase.blogPhrases(phrases);
    DistrictModel.blogDistricts(districts);

    blog('CITY - PRINT --------------------------------------- END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogCities(List<CityModel> cities){

    if (Mapper.checkCanLoopList(cities)){

      for (final CityModel city in cities){

        city.blogCity();

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// MAR2A3A

  // --------------------
  /// TESTED : WORKS PERFECT
  static String createCityID({
    @required String countryID,
    @required String cityEnName,
  }) {
    String _cityID;

    if (countryID != null && cityEnName != null){
      final String _fixedCityEnName = TextMod.fixCountryName(cityEnName);
      _cityID = '${countryID}_$_fixedCityEnName';
    }

    return _cityID;
  }
  // --------------------
  /// TASK : TEST ME
  String getCountryID(){
    return TextMod.removeTextAfterFirstSpecialCharacter(cityID, '_');
  }
  // -----------------------------------------------------------------------------

  /// SEARCHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CityModel> searchCitiesByName({
    @required BuildContext context,
    @required List<CityModel> sourceCities,
    @required String inputText,
    List<String> langCodes = const <String>['en', 'ar'],
  }){

    /// CREATE PHRASES LIST
    final List<Phrase> _citiesPhrases = <Phrase>[];

    /// ADD ALL MIXED LANG PHRASES IN THE LIST
    for (final String langCode in langCodes){
      for (final CityModel city in sourceCities){

        final Phrase _cityPhrase = Phrase.searchPhraseByIDAndLangCode(
          phid: city.cityID,
          langCode: langCode,
          phrases: city.phrases,
        );
        _citiesPhrases.add(_cityPhrase);

      }

    }


    /// SEARCH PHRASES
    final List<Phrase> _foundPhrases = Phrase.searchPhrasesTrigrams(
      sourcePhrases: _citiesPhrases,
      inputText: inputText,
    );

    /// GET CITIES BY IDS FROM NAMES
    final List<CityModel> _foundCities = _getCitiesFromPhrases(
        phrases: _foundPhrases,
        sourceCities: sourceCities
    );

    // CityModel.blogCities(_foundCities);

    return _foundCities;
  }
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CityModel> sortCitiesPerNearestToCity({
    @required CityModel city,
    @required List<CityModel> cities,
  }){

    /// sorting
    cities.sort((CityModel cityA, CityModel cityB){
      final double _distanceA = Atlas.haversineGeoPoints(pointA: cityA.position, pointB: city.position);
      final double _distanceB = Atlas.haversineGeoPoints(pointA: cityB.position, pointB: city.position);
      return _distanceA.compareTo(_distanceB);
    });

    /// blogger
    // for (int i = 0; i < cities.length; i++){
    //   final int _num = i+1;
    //   final CityModel _city = cities[i];
    //   final double distance = haversineGeoPoints(pointA: _city.position, pointB: city.position);
    //   blog('$_num : ${_city.cityID} : $distance');
    // }

    return cities;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CityModel> sortCitiesAlphabetically({
    @required List<CityModel> cities,
    @required BuildContext context,
  }){
    List<CityModel> _output = <CityModel>[];

    if (Mapper.checkCanLoopList(cities) == true){

      _output = cities;

      _output.sort((CityModel a, CityModel b){

        final String _nameA = CityModel.getTranslatedCityNameFromCity(
          context: context,
          city: a,
        );

        final String _nameB = CityModel.getTranslatedCityNameFromCity(
          context: context,
          city: b,
        );

        return _nameA.compareTo(_nameB);
      });

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CityModel> addCityToCities({
    @required List<CityModel> cities,
    @required CityModel city,
  }){

    List<CityModel> _output = <CityModel>[];

    if (Mapper.checkCanLoopList(cities) == true){
      _output = cities;
    }

    if (city != null){
      _output.add(city);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCitiesAreIdentical(CityModel city1, CityModel city2){
    bool _identical = false;

    if (city1 == null && city2 == null){
      _identical = true;
    }
    else {

      if (city1 != null && city2 != null){

        if (
            city1.cityID == city2.cityID &&
            DistrictModel.checkDistrictsListsAreIdentical(city1.districts, city2.districts) == true &&
            city1.population == city2.population &&
            Atlas.checkPointsAreIdentical(point1: city1.position, point2: city2.position) == true &&
            Phrase.checkPhrasesListsAreIdentical(phrases1: city1.phrases, phrases2: city2.phrases) == true
        ){
          _identical = true;
        }

      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is CityModel){
      _areIdentical = checkCitiesAreIdentical(
        this,
        other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      cityID.hashCode^
      districts.hashCode^
      population.hashCode^
      position.hashCode^
      phrases.hashCode;
  // -----------------------------------------------------------------------------
}
