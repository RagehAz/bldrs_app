import 'package:bldrs/a_models/d_zone/c_city/city_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:stringer/stringer.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class CityPhraseFireOps {
  // -----------------------------------------------------------------------------

  const CityPhraseFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createCityPhrases({
    @required CityModel cityModel,
  }) async {

    if (cityModel != null){

      final String _countryID = cityModel.getCountryID();

      await Future.wait(<Future>[

        ...List.generate(cityModel.phrases.length, (index){

          final Phrase _phrase = cityModel.phrases[index];

          _phrase.blogPhrase(invoker: 'ahooo');

          return OfficialFire.createDoc(
            coll: FireColl.phrases_cities,
            doc: '${cityModel.cityID}+${_phrase.langCode}',
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
  /// TESTED : WORKS PERFECT
  static Future<void> updateCityPhrases({
    @required CityModel cityModel,
  }) async {

    await createCityPhrases(cityModel: cityModel);
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteCityPhrases({
    @required CityModel cityModel,
  }) async {

    if (cityModel != null){

      await Future.wait(<Future>[

        ...List.generate(cityModel.phrases.length, (index){

          final Phrase _phrase = cityModel.phrases[index];

          return OfficialFire.deleteDoc(
            coll: FireColl.phrases_cities,
            doc: '${cityModel.cityID}+${_phrase.langCode}',
          );

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
