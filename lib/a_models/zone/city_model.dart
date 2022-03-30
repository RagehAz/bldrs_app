import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/district_model.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart' as Atlas;
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CityModel {
  /// --------------------------------------------------------------------------
  CityModel({
    this.countryID,
    this.cityID,
    this.districts,
    this.population,
    this.isActivated,
    this.isPublic,
    this.names,
    this.position,
    this.state,
  });
  /// --------------------------------------------------------------------------
  final String countryID;
  final String cityID;
  final List<DistrictModel> districts;
  final int population;
  final bool isActivated;
  final bool isPublic;
  final List<Phrase> names;
  final GeoPoint position;
  final String state; // only for USA
  /// --------------------------------------------------------------------------
  Map<String, Object> toMap({@required bool toJSON}) {
    return <String, Object>{
      'countryID': countryID,
      'cityID': TextMod.fixCountryName(cityID),
      'districts': DistrictModel.cipherDistricts(districts),
      'population': population,
      'isActivated': isActivated,
      'isPublic': isPublic,
      'names': Phrase.cipherPhrasesToMap(phrases: names),
      'position': Atlas.cipherGeoPoint(point: position, toJSON: toJSON)
    };
  }
// -----------------------------------------------------------------------------
  static Map<String, dynamic> cipherCities({
    @required List<CityModel> cities,
    @required bool toJSON,
  }) {
    Map<String, dynamic> _citiesMap = <String, dynamic>{};

    if (Mapper.canLoopList(cities)) {
      for (final CityModel city in cities) {
        _citiesMap = Mapper.insertPairInMap(
          map: _citiesMap,
          key: TextMod.fixCountryName(city.cityID),
          value: city.toMap(toJSON: toJSON),
        );
      }
    }

    return _citiesMap;
  }
// -----------------------------------------------------------------------------
  static CityModel decipherCityMap({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }) {
    CityModel _city;

    if (map != null) {
      _city = CityModel(
        countryID: map['countryID'],
        cityID: map['cityID'],
        districts: DistrictModel.decipherDistrictsMap(map['districts']),
        population: map['population'],
        isActivated: map['isActivated'],
        isPublic: map['isPublic'],
        names: Phrase.decipherPhrasesMap(map['names']),
        position: Atlas.decipherGeoPoint(point: map['position'], fromJSON: fromJSON),
      );
    }

    return _city;
  }
// -----------------------------------------------------------------------------
  static List<CityModel> decipherCitiesMaps({
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }) {
    final List<CityModel> _cities = <CityModel>[];

    if (Mapper.canLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {
        _cities.add(decipherCityMap(map: map, fromJSON: fromJSON));
      }
    }
    return _cities;
  }

// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  static List<String> getTranslatedCitiesNamesFromCities({
    @required BuildContext context,
    @required List<CityModel> cities,
  }) {
    final List<String> _citiesNames = <String>[];

    if (Mapper.canLoopList(cities)) {
      for (final CityModel city in cities) {
        final String _cityName = Phrase.getPhraseByCurrentLangFromPhrases(context: context, phrases: city.names)?.value;
        _citiesNames.add(_cityName);
      }
    }

    return TextMod.sortAlphabetically(_citiesNames);
  }
// -----------------------------------------------------------------------------
  static KW getKeywordFromCity({
    @required BuildContext context,
    @required CityModel city,
  }) {
    // CountryProvider _countryPro =  Provider.of<CountryProvider>(context, listen: false);

    // String _name = _countryPro.getCityNameWithCurrentLanguageIfPossible(context, city.name);

    final KW _keyword = KW(
      id: city.cityID,
      names: city.names,
    );

    return _keyword;
  }
// -----------------------------------------------------------------------------
  static List<KW> getKeywordsFromCities({
    @required BuildContext context,
    @required List<CityModel> cities,
  }) {
    final List<KW> _keywords = <KW>[];

    if (Mapper.canLoopList(cities)) {
      for (final CityModel city in cities) {
        final KW _cityKeyword =
            getKeywordFromCity(context: context, city: city);
        _keywords.add(_cityKeyword);
      }
    }

    return _keywords;
  }
// -----------------------------------------------------------------------------
  void blogCity() {
    blog('CITY - PRINT --------------------------------------- START');

    blog('countryID : $countryID');
    blog('cityID : $cityID');
    blog('districts : $districts');
    blog('population : $population');
    blog('isActivated : $isActivated');
    blog('isPublic : $isPublic');
    blog('names : $names');
    blog('position : $position');

    blog('CITY - PRINT --------------------------------------- END');
  }
// -----------------------------------------------------------------------------
  static void blogCities(List<CityModel> cities){

    if (Mapper.canLoopList(cities)){

      for (final CityModel city in cities){

        city.blogCity();

      }

    }

  }
// -----------------------------------------------------------------------------
  static List<MapModel> getCitiesNamesMapModels({
    @required BuildContext context,
    @required List<CityModel> cities,
  }) {
    final List<MapModel> _citiesMapModels = <MapModel>[];

    if (Mapper.canLoopList(cities)) {
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
// -----------------------------------------------------------------------------
  static CityModel getCityFromCities({
    @required List<CityModel> cities,
    @required String cityID,
  }) {
    CityModel _city;
    if (Mapper.canLoopList(cities)) {
      _city = cities.firstWhere((CityModel city) => city.cityID == cityID,
          orElse: () => null);
    }
    return _city;
  }
// -----------------------------------------------------------------------------
  static String getTranslatedCityNameFromCity({
    @required BuildContext context,
    @required CityModel city,
  }) {
    String _cityName = '...';

    if (city != null) {
      _cityName = Phrase.getPhraseByCurrentLangFromPhrases(
          context: context,
          phrases: city.names)?.value;
    }

    return _cityName;
  }
// -----------------------------------------------------------------------------
  static List<String> getCitiesIDsFromCities({@required List<CityModel> cities}) {
    final List<String> _citiesIDs = <String>[];

    if (Mapper.canLoopList(cities)) {
      for (final CityModel city in cities) {
        _citiesIDs.add(city.cityID);
      }
    }
    return _citiesIDs;
  }
// -----------------------------------------------------------------------------
  static String createCityID({
    @required String countryID,
    @required String cityEnName,
  }) {
    final String _fixedCityEnName = TextMod.fixCountryName(cityEnName);
    final String _cityID = '${countryID}_$_fixedCityEnName';

    return _cityID;
  }
// -----------------------------------------------------------------------------
  static String getCityNameWithCurrentLingoIfPossible(BuildContext context, CityModel cityModel) {
    final String _nameInCurrentLanguage = Phrase.getPhraseByCurrentLangFromPhrases(context: context, phrases: cityModel?.names)?.value;
    return _nameInCurrentLanguage ?? cityModel?.cityID;
  }
// -----------------------------------------------------------------------------
  static List<CityModel> searchCitiesByCurrentLingoName({
    @required BuildContext context,
    @required List<CityModel> sourceCities,
    @required String inputText,
  }){

    /// CREATE NAMES LIST
    final List<Phrase> _citiesNames = <Phrase>[];
    for (final CityModel city in sourceCities){
      final Phrase _nameInLingo = Phrase.getPhraseByCurrentLangFromPhrases(
        context: context,
        phrases: city.names,
      );
      _citiesNames.add(_nameInLingo);
    }


    /// SEARCH NAMES
    final List<Phrase> _foundNames = Phrase.searchPhrasesTrigrams(
      sourcePhrases: _citiesNames,
      inputText: inputText,
    );

    /// GET CITIES BY IDS FROM NAMES
    final List<CityModel> _foundCities = _getCitiesFromNames(
        names: _foundNames,
        sourceCities: sourceCities
    );

    CityModel.blogCities(_foundCities);

    return _foundCities;
  }
// -----------------------------------------------------------------------------
  static List<CityModel> _getCitiesFromNames({
  @required List<Phrase> names,
    @required List<CityModel> sourceCities,
}){
    final List<CityModel> _foundCities = <CityModel>[];

    if (Mapper.canLoopList(sourceCities) && Mapper.canLoopList(names)){

      for (final Phrase name in names){

        for (final CityModel city in sourceCities){

          if (city.names.contains(name)){

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
  static List<CityModel> orderCitiesPerNearestToCity({
    @required CityModel city,
    @required List<CityModel> cities,
  }){

    /// sorting
    cities.sort((CityModel cityA, CityModel cityB){
      final double _distanceA = haversineGeoPoints(pointA: cityA.position, pointB: city.position);
      final double _distanceB = haversineGeoPoints(pointA: cityB.position, pointB: city.position);
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
// -----------------------------------------------------------------------------
}
