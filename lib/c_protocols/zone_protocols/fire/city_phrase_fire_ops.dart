import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:flutter/material.dart';

class CityPhraseFireOps {
  // -----------------------------------------------------------------------------

  const CityPhraseFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TASK : TEST ME
  static Future<void> createCityPhrases({
    @required CityModel cityModel,
  }) async {

    if (cityModel == null){

      final String _countryID = cityModel.getCountryID();

      await Future.wait(<Future>[

        ...List.generate(cityModel.phrases.length, (index){

          final Phrase _phrase = cityModel.phrases[index];

          return Fire.createNamedDoc(
            collName: FireColl.phrases_cities,
            docName: '${cityModel.cityID}+${_phrase.langCode}',
            input: {
              'countryID': _countryID,
              'id': cityModel.cityID,
              'value': _phrase.value,
              'langCode': _phrase.langCode,
              'trigram': Stringer.createTrigram(input: _phrase.value),
            },
          );

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// WE  DO NOT READ DATA DIRECTLY FROM CITIES PHRASES,, ONLY USED AS SEARCH HELPER
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TASK : TEST ME
  static Future<void> updateCityPhrases({
    @required CityModel cityModel,
  }) async {
    await createCityPhrases(cityModel: cityModel);
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TASK : TEST ME
  static Future<void> deleteCityPhrases({
    @required CityModel cityModel,
  }) async {

    if (cityModel == null){

      await Future.wait(<Future>[

        ...List.generate(cityModel.phrases.length, (index){

          final Phrase _phrase = cityModel.phrases[index];

          return Fire.deleteDoc(
            collName: FireColl.phrases_cities,
            docName: '${cityModel.cityID}+${_phrase.langCode}',
          );

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
