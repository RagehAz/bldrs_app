import 'package:bldrs/a_models/d_zone/c_city/district_model.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:stringer/stringer.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class DistrictPhraseFireOps {
  // -----------------------------------------------------------------------------

  const DistrictPhraseFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createDistrictPhrases({
    @required DistrictModel districtModel,
  }) async {

    if (districtModel != null){

      final String _countryID = DistrictModel.getCountryIDFromDistrictID(districtModel.id);
      final String _cityID = DistrictModel.getCityIDFromDistrictID(districtModel.id);

      await Future.wait(<Future>[

        ...List.generate(districtModel.phrases.length, (index){

          final Phrase _phrase = districtModel.phrases[index];

          _phrase.blogPhrase(invoker: 'fuck you');

          return Fire.createNamedDoc(
            collName: FireColl.phrases_districts,
            docName: DistrictModel.getDistrictPhraseDocName(
              districtID: districtModel.id,
              langCode: _phrase.langCode,
            ),
            input: {
              'countryID': _countryID,
              'cityID': _cityID,
              'id': districtModel.id,
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
  /// WE  DO NOT READ DATA DIRECTLY FROM DISTRICTS PHRASES,, ONLY USED AS SEARCH HELPER
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateDistrictPhrases({
    @required DistrictModel districtModel,
  }) async {
    await createDistrictPhrases(districtModel: districtModel);
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteDistrictPhrases({
    @required DistrictModel districtModel,
  }) async {

    if (districtModel != null){

      await Future.wait(<Future>[

        ...List.generate(districtModel.phrases.length, (index){

          final Phrase _phrase = districtModel.phrases[index];

          return Fire.deleteDoc(
            collName: FireColl.phrases_districts,
            docName: DistrictModel.getDistrictPhraseDocName( //'${districtModel.id}+${_phrase.langCode}'
                districtID: districtModel.id,
                langCode: _phrase.langCode,
            ),
          );

        }),

      ]);

    }

  }
  // -----------------------------------------------------------------------------
}
