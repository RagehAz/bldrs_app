import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_promotion.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
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
    SearchModel searchModel,
    String title,
    String orderBy,
    bool descending,
    int limit = 4,
    String gtaLink,
  }) {
    final QueryOrderBy _orderBy = orderBy == null
        ? null
        : QueryOrderBy(
            fieldName: orderBy,
            descending: descending,
          );

    return FireQueryModel(
      coll: FireColl.flyers,
      orderBy: _orderBy,
      limit: limit,
      // idFieldName: 'id',
      finders: <FireFinder>[
        if (searchModel?.zone?.countryID != null)
          FireFinder(
            field: 'zone.countryID',
            comparison: FireComparison.equalTo,
            value: searchModel?.zone?.countryID,
          ),
        if (searchModel?.zone?.cityID != null)
          FireFinder(
            field: 'zone.cityID',
            comparison: FireComparison.equalTo,
            value: searchModel?.zone?.cityID,
          ),
        if (searchModel?.flyerSearchModel?.flyerType != null)
          FireFinder(
            field: 'flyerType',
            comparison: FireComparison.equalTo,
            value: FlyerTyper.cipherFlyerType(searchModel?.flyerSearchModel?.flyerType),
          ),
        if (searchModel?.flyerSearchModel?.phid != null)
          FireFinder(
            field: 'keywordsIDs',
            comparison: FireComparison.arrayContains,
            value: searchModel?.flyerSearchModel?.phid,
          ),
        if (TextCheck.isEmpty(title?.trim()) == false)
          FireFinder(
              field: 'trigram',
              comparison: FireComparison.arrayContains,
              value: TextMod.removeAllCharactersAfterNumberOfCharacters(
                input: title.trim(),
                numberOfChars: Standards.maxTrigramLength,
              )),
        if (searchModel?.flyerSearchModel?.publishState != null)
          FireFinder(
            field: 'publishState',
            comparison: FireComparison.equalTo,
            value: FlyerModel.cipherPublishState(searchModel?.flyerSearchModel?.publishState),
          ),
        if (searchModel?.flyerSearchModel?.auditState != null)
          FireFinder(
            field: 'auditState',
            comparison: FireComparison.equalTo,
            value: FlyerModel.cipherAuditState(searchModel?.flyerSearchModel?.auditState),
          ),
        if (searchModel?.flyerSearchModel?.onlyShowingAuthors == true)
          const FireFinder(
            field: 'showsAuthor',
            comparison: FireComparison.equalTo,
            value: true,
          ),
        if (searchModel?.flyerSearchModel?.onlyWithPrices == true)
          const FireFinder(
            field: 'specs.phid_s_salePrice',
            comparison: FireComparison.greaterThan,
            value: 0,
          ),
        if (searchModel?.flyerSearchModel?.onlyAmazonProducts == true)
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
        if (searchModel?.flyerSearchModel?.onlyWithPDF == true)
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
