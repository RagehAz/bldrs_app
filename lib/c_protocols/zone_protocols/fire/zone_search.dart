import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:bldrs/a_models/d_zone/zz_old/city_model.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/search.dart' as Search;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// ZONES

// --------------------
/// DEPRECATED
/*
Future<List<CountryModel>> countriesModelsByCountryNameX({
  @required String countryName,
  @required String lingoCode
}) async {

  List<CountryModel> _countries = <CountryModel>[];

  if (countryName != null && countryName.isNotEmpty) {

    final List<Map<String, dynamic>> _result = await Search.subCollectionMapsByFieldValue(
      collName: FireColl.zones,
      docName: FireDoc.zones_countries,
      subCollName: FireSubColl.zones_countries_countries,
      field: 'phrases.$lingoCode.trigram',
      compareValue: TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: TextMod.fixCountryName(countryName),
        numberOfChars: Standards.maxTrigramLength,
      ),
      valueIs: FireComparison.arrayContains,
    );

    if (Mapper.checkCanLoopList(_result)) {
      _countries = CountryModel.decipherCountriesMaps(
        maps: _result,
      );
    }

  }

  return _countries;
}
 */
// --------------------
Future<List<CityModel>> citiesByCityName({
  @required String cityName,
  @required String lingoCode,
}) async {
  List<CityModel> _cities = <CityModel>[];

  if (cityName != null && cityName.isNotEmpty) {

    final List<Map<String, dynamic>> _result = await Search.subCollectionMapsByFieldValue(
      collName: FireColl.zones,
      docName: FireDoc.zones_cities,
      subCollName: FireSubColl.zones_cities_cities,
      field: 'names.$lingoCode.trigram',
      compareValue: TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: TextMod.fixCountryName(cityName),
        numberOfChars: Standards.maxTrigramLength,
      ),
      valueIs: FireComparison.arrayContains,
    );

    if (Mapper.checkCanLoopList(_result)) {
      _cities = CityModel.decipherCitiesMaps(
        maps: _result,
        fromJSON: false,
      );
    }
  }

  return _cities;
}
// --------------------
/// not tested
Future<List<CityModel>> citiesByCityNameAndCountryID({
  @required String cityName,
  @required String countryID,
  @required String lingoCode,
}) async {
  List<CityModel> _cities = <CityModel>[];

  await tryAndCatch(
      invoker: 'mapsByTwoValuesEqualTo',
      functions: () async {
        final CollectionReference<Object> _collRef = Fire.getSubCollectionRef(
          collName: FireColl.zones,
          docName: FireDoc.zones_cities,
          subCollName: FireSubColl.zones_cities_cities,
        );

        final String _searchValue =
        TextMod.removeAllCharactersAfterNumberOfCharacters(
          input: TextMod.fixCountryName(cityName),
          numberOfChars: Standards.maxTrigramLength,
        );

        final QuerySnapshot<Object> _collectionSnapshot = await _collRef
            .where('countryID', isEqualTo: countryID)
            .where('names.$lingoCode.trigram', arrayContains: _searchValue)
            .get();

        final List<dynamic> _maps = Mapper.getMapsFromQuerySnapshot(
          querySnapshot: _collectionSnapshot,
          addDocsIDs: false,
          addDocSnapshotToEachMap: false,
        );

        _cities = CityModel.decipherCitiesMaps(maps: _maps, fromJSON: false);
      });

  return _cities;
}
// -----------------------------------------------------------------------------
