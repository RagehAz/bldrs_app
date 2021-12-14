import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/zone/city_model.dart';
import 'package:bldrs/a_models/zone/country_model.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/search/fire_search.dart' as Search;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// ZONES

// -----------------------------------------------
Future<List<CityModel>> citiesByCityName(
    {@required BuildContext context,
    @required String cityName,
    @required String lingoCode}) async {
  List<CityModel> _cities = <CityModel>[];

  if (cityName != null && cityName.isNotEmpty) {
    final List<Map<String, dynamic>> _result = await Search.subCollectionMapsByFieldValue(
      context: context,
      collName: FireColl.zones,
      docName: FireDoc.zones_cities,
      subCollName: FireSubColl.zones_cities_cities,
      field: 'names.$lingoCode.trigram',
      compareValue: TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: CountryModel.fixCountryName(cityName),
        numberOfCharacters: Standards.maxTrigramLength,
      ),
      valueIs: Search.ValueIs.arrayContains,
    );

    if (Mapper.canLoopList(_result)) {
      _cities = CityModel.decipherCitiesMaps(
        maps: _result,
        fromJSON: false,
      );
    }
  }

  return _cities;
}

// -----------------------------------------------
/// not tested
Future<List<CityModel>> citiesByCityNameAndCountryID({
  @required BuildContext context,
  @required String cityName,
  @required String countryID,
  @required String lingoCode,
}) async {
  List<CityModel> _cities = <CityModel>[];

  await tryAndCatch(
      context: context,
      methodName: 'mapsByTwoValuesEqualTo',
      functions: () async {
        final CollectionReference<Object> _collRef = Fire.getSubCollectionRef(
          collName: FireColl.zones,
          docName: FireDoc.zones_cities,
          subCollName: FireSubColl.zones_cities_cities,
        );

        final String _searchValue =
            TextMod.removeAllCharactersAfterNumberOfCharacters(
          input: CountryModel.fixCountryName(cityName),
          numberOfCharacters: Standards.maxTrigramLength,
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
