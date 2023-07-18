import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:fire/super_fire.dart';

class FlyerSearch {
  // -----------------------------------------------------------------------------

  const FlyerSearch();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static FireQueryModel createQuery({
    SearchModel? searchModel,
    String? orderBy,
    bool descending = true,
    int limit = 4,
    String? gtaLink,
  }) {
    final QueryOrderBy? _orderBy = orderBy == null ? null
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

        /// BY COUNTRY ID
        if (searchModel?.zone?.countryID != null)
          FireFinder(
            field: 'zone.countryID',
            comparison: FireComparison.equalTo,
            value: searchModel?.zone?.countryID,
          ),

        /// BY CITY
        if (searchModel?.zone?.cityID != null)
          FireFinder(
            field: 'zone.cityID',
            comparison: FireComparison.equalTo,
            value: searchModel?.zone?.cityID,
          ),

        /// BY FLYER TYPE
        if (searchModel?.flyerSearchModel?.flyerType != null)
          FireFinder(
            field: 'flyerType',
            comparison: FireComparison.equalTo,
            value: FlyerTyper.cipherFlyerType(searchModel?.flyerSearchModel?.flyerType),
          ),

        /// BY PHID
        if (searchModel?.flyerSearchModel?.phid != null)
          FireFinder(
            field: 'phids',
            comparison: FireComparison.arrayContains,
            value: searchModel?.flyerSearchModel?.phid,
          ),

        /// TITLE
        if (TextCheck.isEmpty(searchModel?.text?.trim()) == false)
          FireFinder(
              field: 'trigram',
              comparison: FireComparison.arrayContains,
              value: TextMod.removeAllCharactersAfterNumberOfCharacters(
                text: searchModel!.text!.trim(),
                numberOfChars: Standards.maxTrigramLength,
              )),

        /// PUBLISH STATE
        if (searchModel?.flyerSearchModel?.publishState != null)
          FireFinder(
            field: 'publishState',
            comparison: FireComparison.equalTo,
            value: FlyerModel.cipherPublishState(searchModel?.flyerSearchModel?.publishState),
          ),

        /// AUDIT STATE
        if (searchModel?.flyerSearchModel?.auditState != null)
          FireFinder(
            field: 'auditState',
            comparison: FireComparison.equalTo,
            value: FlyerModel.cipherAuditState(searchModel?.flyerSearchModel?.auditState),
          ),

        /// SHOWING AUTHORS ONLY
        if (Mapper.boolIsTrue(searchModel?.flyerSearchModel?.onlyShowingAuthors) == true)
          const FireFinder(
            field: 'showsAuthor',
            comparison: FireComparison.equalTo,
            value: true,
          ),

        /// PRICES ONLY
        if (Mapper.boolIsTrue(searchModel?.flyerSearchModel?.onlyWithPrices) == true)
          const FireFinder(
            field: 'hasPriceTag',
            comparison: FireComparison.equalTo,
            value: true,
          ),

        /// AMAZON ONLY
        if (Mapper.boolIsTrue(searchModel?.flyerSearchModel?.onlyAmazonProducts) == true)
          const FireFinder(
            field: 'isAmazonFlyer',
            comparison: FireComparison.equalTo,
            value: true,
          ),

        /// GTA LINK
        if (gtaLink != null)
          FireFinder(
            field: 'gtaLink',
            comparison: FireComparison.equalTo,
            value: gtaLink,
          ),

        /// AFFILIATE LINK
        if (gtaLink != null)
          FireFinder(
            field: 'affiliateLink',
            comparison: FireComparison.equalTo,
            value: gtaLink,
          ),

        /// PDF
        if (Mapper.boolIsTrue(searchModel?.flyerSearchModel?.onlyWithPDF) == true)
          const FireFinder(
            field: 'hasPDF',
            comparison: FireComparison.equalTo,
            value: true,
          ),

      ],
      // orderBy: 'score',
    );
  }
  // -----------------------------------------------------------------------------
}
