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
    @required FireQueryModel queryModel,
    QueryDocumentSnapshot<Object> startAfter,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.readColl(
      addDocSnapshotToEachMap: true,
      startAfter: startAfter,
      queryModel: queryModel,
    );

    if (Mapper.checkCanLoopList(_maps) == true) {
      return FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);
    } else {
      return [];
    }
  }
  // --------------------
  /// TASK : TEST ME
  static FireQueryModel createQuery({
    String countryID,
    String cityID,
    FlyerType flyerType,
    String keywordID,
    String title,
    String orderBy,
    bool descending,
    int limit = 4,
    PublishState publishState,
    AuditState auditState,
    bool showsAuthor,
    bool hasPrice,
    String currencyID,
    bool hasAffiliateLink,
    String gtaLink,
    bool hasPDF,
  }){

    final QueryOrderBy _orderBy = orderBy == null ? null : QueryOrderBy(
      fieldName: orderBy,
      descending: descending,
    );

    return FireQueryModel(
        coll: FireColl.flyers,
        orderBy: _orderBy,
        limit: limit,
        // idFieldName: 'id',
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

          if (publishState != null)
            FireFinder(
              field: 'publishState',
              comparison: FireComparison.equalTo,
              value: FlyerModel.cipherPublishState(publishState),
            ),

          if (auditState != null)
            FireFinder(
            field: 'auditState',
            comparison: FireComparison.equalTo,
            value: FlyerModel.cipherAuditState(auditState),
          ),

          if (showsAuthor == true)
            FireFinder(
              field: 'showsAuthor',
              comparison: FireComparison.equalTo,
              value: showsAuthor,
            ),

          if (hasPrice == true)
            const FireFinder(
              field: 'specs.phid_s_salePrice',
              comparison: FireComparison.greaterThan,
              value: 0,
            ),

          if (currencyID != null && hasPrice == true)
            FireFinder(
              field: 'specs.phid_s_currency',
              comparison: FireComparison.equalTo,
              value: currencyID,
            ),

          if (hasAffiliateLink == true)
            const FireFinder(
              field: 'affiliateLink',
              comparison: FireComparison.nullValue,
              value: false,
            ),

          if (gtaLink != null)
            FireFinder(
              field: 'gtaLink',
              comparison: FireComparison.equalTo,
              value: gtaLink,
            ),

          if (gtaLink != null)
            FireFinder(
              field: 'affiliateLink',
              comparison: FireComparison.equalTo,
              value: gtaLink,
            ),

          if (hasPDF == true)
            const FireFinder(
              field: 'pdfPath',
              comparison: FireComparison.nullValue,
              value: false,
            ),

      ],
        // orderBy: 'score',
      );

  }
  // -----------------------------------------------------------------------------

  /// FLYER PROMOTION

  // --------------------
  /// TASK : TEST ME
  static Future<List<FlyerPromotion>> flyerPromotionsByCity({
    @required String cityID,
    // @required DateTime timeLimit,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.readColl(
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
