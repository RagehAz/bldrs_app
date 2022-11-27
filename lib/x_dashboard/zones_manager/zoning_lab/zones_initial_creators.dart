import 'package:bldrs/a_models/d_zone/a_zoning/zone_level.dart';
import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/f_helpers/drafters/atlas.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

// ------------------------------------o

Future<void> createCityPhrases({
  @required CityModel city,
  @required String newCItyID,
  @required String countryID,
}) async {

  final List<Phrase> _phrases= city.phrases;

  blog('createCityPhrases: DONE : cityID: $newCItyID');

  await Future.wait(<Future>[

    ...List.generate(_phrases.length, (index){

      return _createCityPhrase(
        countryID: countryID,
        newCityID: newCItyID,
        phrase: _phrases[index],
      );

    }),

  ]);

}

Future<void> _createCityPhrase({
  @required Phrase phrase,
  @required String newCityID,
  @required String countryID,
}) async {
  blog('_createCityPhrase: DONE : cityID: $newCityID');

  await Fire.createNamedDoc(
      collName: FireColl.phrases_cities,
      docName: '$newCityID+${phrase.langCode}',
      input: {
        'countryID': countryID,
        'id': newCityID,
        'value': phrase.value,
        'langCode': phrase.langCode,
        'trigram': Stringer.createTrigram(input: phrase.value),
      },
  );

}

// ------------------------------------o

Future<void> createNewCityModel({
  @required CityModel city,
  @required String newCityID,
  @required String countryID,
}) async {

  Map<String, dynamic> _newCityMap = {
    'population': city.population ?? 0,
    'position': Atlas.cipherGeoPoint(point: city.position, toJSON: true),
  };

  /// PHRASES
  Map<String, dynamic> _phrasesMap = {};
  for (final Phrase phrase in city.phrases){
    _phrasesMap = Mapper.insertPairInMap(
      map: _phrasesMap,
      key: phrase.langCode,
      value: phrase.value,
    );
  }
  _newCityMap = Mapper.insertPairInMap(
    map: _newCityMap,
    key: 'phrases',
    value: _phrasesMap,
  );

  await Real.createDocInPath(
    pathWithoutDocName: 'zones/cities/$countryID',
    docName: newCityID,
    addDocIDToOutput: false,
    map: _newCityMap,
  );

  blog('createNewCityModel: DONE : cityID: $newCityID');

}

// ------------------------------------o

Future<void> removeOldCityModel({
  @required String countryID,
  @required String oldCityID,
}) async {

  await Real.deletePath(
    pathWithDocName: 'zones/cities/$countryID/$oldCityID',
  );

  blog('removeOldCityModel: DONE : cityID: $oldCityID');

}

// ------------------------------------o

Future<void> createCityBackup({
  @required String countryID,
  @required CityModel city,
}) async {

  await Real.createNamedDoc(
      collName: 'citiesBackups',
      docName: city.cityID,
      map: city.toMap(toJSON: true, toLDB: true),
  );

  blog('createCityBackup: DONE : cityID: ${city.cityID}');

}

// ------------------------------------o

Future<void> createDistrictPhrasesModelsAndEverything({
  @required String countryID,
  @required CityModel city,
}) async {

  if (Mapper.checkCanLoopList(city.districts) == true){

    final List<DistrictModel> _districts = city.districts;

    await Future.wait(<Future>[

      ...List.generate(_districts.length, (index){

        final DistrictModel _district = _districts[index];

        final String _newDistrictID = '${city.cityID}+${_district.id}';

        /// PHRASES IN REAL
        Map<String, dynamic> _newDistrict = {};
        Map<String, dynamic> _phrasesMap = {};
        for (final Phrase phrase in city.phrases){
          _phrasesMap = Mapper.insertPairInMap(
            map: _phrasesMap,
            key: phrase.langCode,
            value: phrase.value,
          );
        }
        _newDistrict = Mapper.insertPairInMap(
          map: _newDistrict,
          key: 'phrases',
          value: _phrasesMap,
        );

        /// PHRASES IN FIRE


        return Future.wait(<Future>[

          /// CREATE DISTRICT PHRASES IN FIRE
          _createDistrictPhrases(
            countryID: countryID,
            newDistrictID: _newDistrictID,
            district: _district,
            newCItyID: city.cityID,
          ),

          /// CREATE NEW REAL DISTRICT MODEL
          Real.createDocInPath(
              pathWithoutDocName: 'zones/districts/$countryID/${city.cityID}',
              docName: _newDistrictID,
              addDocIDToOutput: false,
              map: _phrasesMap,
          ),

        ]);

    }),

    ]);

    blog('createDistrictPhrasesModelsAndEverything: DONE : cityID: ${city.cityID}');

  }

}

Future<void> _createDistrictPhrases({
  @required DistrictModel district,
  @required String newDistrictID,
  @required String countryID,
  @required String newCItyID,
}) async {

  final List<Phrase> _phrases = district?.phrases;

  if (Mapper.checkCanLoopList(_phrases) == true){

    await Future.wait(<Future>[

      ...List.generate(_phrases.length, (index){

        return _createDistrictPhrase(
          countryID: countryID,
          newCityID: newCItyID,
          districtID: newDistrictID,
          phrase: _phrases[index],
        );

      }),

    ]);

    blog('_createDistrictPhrases: DONE : cityID: $newCItyID');

  }

}

Future<void> _createDistrictPhrase({
  @required Phrase phrase,
  @required String newCityID,
  @required String countryID,
  @required String districtID,
}) async {

  await Fire.createNamedDoc(
    collName: FireColl.phrases_districts,
    docName: '$newCityID+$districtID+${phrase.langCode}',
    input: {
      'countryID': countryID,
      'cityID': newCityID,
      'id': districtID,
      'value': phrase.value,
      'langCode': phrase.langCode,
      'trigram': Stringer.createTrigram(input: phrase.value),
    },
  );

  blog('_createDistrictPhrase: DONE : cityID: $newCityID : districtID : $districtID');

}

// ------------------------------------o

Future<void> createDistrictsLevels({
  @required String countryID,
  @required CityModel city,
}) async {

  if (Mapper.checkCanLoopList(city.districts) == true){

    final List<String> _districtsIDs = [];
    for (final DistrictModel district in city.districts){
      _districtsIDs.add('${city.cityID}+${district.id}');
    }

    final ZoneLevel _lvl = ZoneLevel(
        hidden: const [],
        inactive: _districtsIDs,
        active: null,
        public: null,
    );

    await Real.createDocInPath(
      pathWithoutDocName: 'zones/districtsLevels/$countryID',
      docName: city.cityID,
      addDocIDToOutput: false,
      map: _lvl.toMap(),
    );

    blog('createDistrictsLevels: DONE : cityID: ${city.cityID}');

  }


}

// ------------------------------------o
