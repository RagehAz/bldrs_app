import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/helpers/models/phrase_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:fire/super_fire.dart';
/// => TAMAM
class CityPhraseFireOps {
  // -----------------------------------------------------------------------------

  const CityPhraseFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createCityPhrases({
    required CityModel? cityModel,
  }) async {

    if (cityModel != null){

      final String? _countryID = cityModel.getCountryID();

      if (Lister.checkCanLoopList(cityModel.phrases) == true){

        await Future.wait(<Future>[

        ...List.generate(cityModel.phrases!.length, (index){

          final Phrase _phrase = cityModel.phrases![index];

          _phrase.blogPhrase(invoker: 'there you go my dear');

          return Fire.createDoc(
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
    required CityModel cityModel,
  }) async {

    await createCityPhrases(cityModel: cityModel);
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteCityPhrases({
    required CityModel? cityModel,
  }) async {

    if (cityModel != null && Lister.checkCanLoopList(cityModel.phrases) == true){

      await Future.wait(<Future>[

        ...List.generate(cityModel.phrases!.length, (index){

          final Phrase _phrase = cityModel.phrases![index];

          return Fire.deleteDoc(
            coll: FireColl.phrases_cities,
            doc: '${cityModel.cityID}+${_phrase.langCode}',
          );

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
