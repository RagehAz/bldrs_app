import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:space_time/space_time.dart';
import 'package:filers/filers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
/// => TAMAM
@immutable
class CityModel {
  /// --------------------------------------------------------------------------
  const CityModel({
    this.cityID,
    this.population,
    this.position,
    this.phrases,
  });
  /// --------------------------------------------------------------------------
  final String cityID;
  final int population;
  final GeoPoint position;
  final List<Phrase> phrases;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  CityModel copyWith({
    String cityID,
    int population,
    GeoPoint position,
    List<Phrase> phrases,
  }) {
    return CityModel(
      cityID: cityID ?? this.cityID,
      population: population ?? this.population,
      position: position ?? this.position,
      phrases: phrases ?? this.phrases,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, Object> toMap({
    @required bool toJSON,
    @required bool toLDB,
  }){

    Map<String, dynamic> _map = {
      'population': population ?? 0,
      'position': Atlas.cipherGeoPoint(point: position, toJSON: toJSON),
      'phrases' : Phrase.cipherPhrasesToLangsMap(phrases),
    };

    /// TO LDB
    if (toLDB == true){

      /// INSERT PHRASES
      _map = Mapper.insertMapInMap(
        baseMap: _map,
        insert: {
          'phrases': Phrase.cipherMixedLangPhrasesToMap(
            phrases: phrases,
            // includeTrigrams: true, // DEFAULT
          ),
        },
      );

      /// INSERT CITY ID
      _map = Mapper.insertMapInMap(
        baseMap: _map,
        insert: {'cityID': cityID,},
      );


    }

    /// TO FIRESTORE
    else {

      /// INSERT PHRASES
      _map = Mapper.insertMapInMap(
        baseMap: _map,
        insert: {
          'phrases': Phrase.cipherPhrasesToLangsMap(phrases),
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
    @required bool fromLDB,
  }) {
    CityModel _city;

    if (map != null) {


      final List<Phrase> _phrases =
          fromLDB == true ?
          Phrase.decipherMixedLangPhrasesFromMap(map: map['phrases'])
          :
          Phrase.decipherPhrasesLangsMap(langsMap: map['phrases'], phid: cityID,);

      _city = CityModel(
        cityID: cityID,
        population: map['population'],
        position: Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON,),
        phrases: _phrases,
      );
    }

    return _city;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CityModel> decipherCities({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
    @required bool fromLDB,
  }) {
    final List<CityModel> _cities = <CityModel>[];

    if (Mapper.checkCanLoopList(maps) == true) {
      for (final Map<String, dynamic> map in maps) {
        _cities.add(
            decipherCity(
              map: map,
              fromJSON: fromJSON,
              cityID: map['cityID'] ?? map['id'],
              fromLDB: fromLDB,
            )
        );
      }
    }

    return _cities;
  }
  // --------------------
  /// DEPRECATED
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
  /// TESTED : WORKS PERFECT
  static String getCountryIDFromCityID(String cityID){

    /// NEW IDS
    if (TextCheck.stringContainsSubString(string: cityID, subString: '+') == true){
      return TextMod.removeTextAfterFirstSpecialCharacter(cityID, '+');
    }

    /// SOMETHING IS WRONG
    else {
      return null;
    }

  }
  // -----------------------------------------------------------------------------
  /// DEPRECATED
  /*
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
   */
  // --------------------
  /// DEPRECATED
  /*
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
   */
  // --------------------
  /// DEPRECATED
  /*
  static String translateCityNameWithCurrentLingoIfPossible(BuildContext context, CityModel cityModel) {
    // final String _nameInCurrentLanguage = Phrase.getPhraseByCurrentLangFromPhrases(
    //     context: context,
    //     phrases: cityModel?.phrases
    // )?.value;
    //
    // return _nameInCurrentLanguage ?? cityModel?.cityID;
    return null;
  }
   */
  // --------------------
  /// DEPRECATED
  /*
  static CityModel getCityFromCities({
    @required List<CityModel> cities,
    @required String cityID,
  }) {
    CityModel _city;
    if (Mapper.checkCanLoopList(cities) == true) {
      _city = cities.firstWhere((CityModel city) => city.cityID == cityID,
          orElse: () => null);
    }
    return _city;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<CityModel> getCitiesFromCitiesByIDs({
    @required List<CityModel> citiesModels,
    @required List<String> citiesIDs,
  }){
    final List<CityModel> _output = [];

    if (Mapper.checkCanLoopList(citiesModels) == true && Mapper.checkCanLoopList(citiesIDs) == true){

      for (final CityModel city in citiesModels){

        final bool _isInList = Stringer.checkStringsContainString(
            strings: citiesIDs,
            string: city.cityID,
        );

        if (_isInList == true){

          final bool _alreadyAdded = checkCitiesIncludeCityID(_output, city.cityID);
          if (_alreadyAdded == false){
            _output.add(city);
          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getCitiesIDs(List<CityModel> cities) {

    final List<String> _citiesIDs = <String>[];

    if (Mapper.checkCanLoopList(cities) == true) {
      for (final CityModel city in cities) {
        _citiesIDs.add(city.cityID);
      }
    }

    return _citiesIDs;
  }
  // -----------------------------------------------------------------------------

  /// TRANSLATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String translateCity({
    @required CityModel city,
    String langCode,
  }) {

    Phrase _phrase = Phrase.searchFirstPhraseByLang(
        langCode: langCode ?? Localizer.getCurrentLangCode(),
        phrases: city?.phrases
    );

    _phrase ??= Phrase.searchFirstPhraseByLang(
        langCode: 'en',
        phrases: city?.phrases
    );

    return _phrase?.value;
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

    blog('CITY - PRINT --------------------------------------- END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogCities(List<CityModel> cities){

    if (Mapper.checkCanLoopList(cities) == true){
      for (final CityModel city in cities){
        city.blogCity();
      }
    }

    else {
      blog('blogCities : NO CITIES TO BLOG');
    }

  }
  // -----------------------------------------------------------------------------

  /// IDs

  // --------------------
  /// TESTED : WORKS PERFECT
  static String createCityID({
    @required String countryID,
    @required String cityEnName,
  }){
    String _output;

    if (TextCheck.isEmpty(countryID) == false && TextCheck.isEmpty(cityEnName) == false){
      final String _fixedCityEnName = TextMod.fixCountryName(cityEnName);
      _output = '$countryID+$_fixedCityEnName';
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String oldGetCountryID(){
    return TextMod.removeTextAfterFirstSpecialCharacter(cityID, '_');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String getCountryID(){
    return TextMod.removeTextAfterFirstSpecialCharacter(cityID, '+');
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
      if (_distanceA != null && _distanceB != null){
        return _distanceA.compareTo(_distanceB);
      }
      else {
        return 0;
      }
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
  }){
    List<CityModel> _output = <CityModel>[];

    if (Mapper.checkCanLoopList(cities) == true){

      _output = cities;

      _output.sort((CityModel a, CityModel b){

        final String _nameA = CityModel.translateCity(
          city: a,
        );

        final String _nameB = CityModel.translateCity(
          city: b,
        );

        if (_nameA != null && _nameB != null){
          return _nameA.compareTo(_nameB);
        }
        else {
          return 0;
        }

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
  // --------------------
  /// TESTED : WORKS PERFECT
  static CityModel replacePhraseInCityPhrases({
    @required CityModel city,
    @required Phrase phrase,
  }){
    CityModel _output = city;

    if (phrase != null && _output?.phrases != null) {

      final List<Phrase> _newPhrases = Phrase.replacePhraseByLangCode(
        phrases: _output.phrases,
        phrase: phrase,
      );

      _output = city.copyWith(phrases: _newPhrases);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static CityModel removePhraseFromCityPhrases({
    @required CityModel city,
    @required String langCode,
  }){
    CityModel _output = city;

    if (langCode != null && _output?.phrases != null) {

      final List<Phrase> _newPhrases = Phrase.removePhraseByLangCode(
        phrases: _output.phrases,
        langCode: langCode,
      );

      _output = city.copyWith(phrases: _newPhrases);
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCitiesIncludeCityID(List<CityModel> cities, String cityID){
    bool _output = false;

    if (Mapper.checkCanLoopList(cities) == true && cityID != null){
      for (final CityModel city in cities){
        if (city.cityID == cityID){
          _output = true;
          break;
        }
      }
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

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
      population.hashCode^
      position.hashCode^
      phrases.hashCode;
  // -----------------------------------------------------------------------------
}
