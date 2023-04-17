import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_promotion.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';

class FlyerSearch {
  // -----------------------------------------------------------------------------

  const FlyerSearch();

  // -----------------------------------------------------------------------------
  /// TASK : TEST ME
  static Future<List<FlyerModel>> superSearch({
    @required String countryID,
    String cityID,
    FlyerType flyerType,
    String keywordID,
    String title,
    QueryDocumentSnapshot<Object> startAfter,
    int limit = 6,
  }) async {

    final List<Map<String, dynamic>> _maps = await OfficialFire.readColl(
      addDocSnapshotToEachMap: true,
      startAfter: startAfter,
      addDocsIDs: true,
      queryModel: FireQueryModel(
        coll: FireColl.flyers,
        limit: limit,
        finders: <FireFinder>[
        if (countryID != null)
          FireFinder(
            field: 'zone.countryID',
            comparison: FireComparison.equalTo,
            value: countryID,
          ),
        if (cityID != null)
          FireFinder(
            field: 'zone.cityID',
            comparison: FireComparison.equalTo,
            value: cityID,
          ),
        if (flyerType != null)
          FireFinder(
            field: 'flyerType',
            comparison: FireComparison.equalTo,
            value: FlyerTyper.cipherFlyerType(flyerType),
          ),
        if (keywordID != null)
          FireFinder(
            field: 'keywordsIDs',
            comparison: FireComparison.arrayContains,
            value: keywordID,
          ),
        if (title != null)
          FireFinder(
              field: 'trigram',
              comparison: FireComparison.arrayContains,
              value: TextMod.removeAllCharactersAfterNumberOfCharacters(
                input: title.trim(),
                numberOfChars: Standards.maxTrigramLength,
              )),
      ],
        // orderBy: 'score',
      ),
    );

    if (Mapper.checkCanLoopList(_maps) == true) {
      return FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);
    } else {
      return [];
    }
  }
  // -----------------------------------------------------------------------------

  /// FLYER PROMOTION

  // --------------------
  /// TASK : TEST ME
  static Future<List<FlyerPromotion>> flyerPromotionsByCity({
    @required String cityID,
    // @required List<String> districts,
    // @required DateTime timeLimit,
  }) async {

    final List<Map<String, dynamic>> _maps = await OfficialFire.readColl(
      queryModel: FireQueryModel(
        coll: FireColl.flyersPromotions,
        limit: 10,
        finders: <FireFinder>[
          FireFinder(
            field: 'cityID',
            comparison: FireComparison.equalTo,
            value: cityID,
          ),
        ],
      ),
    );

    final List<FlyerPromotion> _flyerPromotions = FlyerPromotion.decipherFlyersPromotions(
      maps: _maps,
      fromJSON: false,
    );

    return _flyerPromotions;
  }
  // -----------------------------------------------------------------------------
}
