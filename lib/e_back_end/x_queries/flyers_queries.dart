import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/m_search/flyer_search_model.dart';
import 'package:bldrs/a_models/m_search/search_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fire/flyer_search.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// ALL FLYERS PAGINATION

// --------------------
///
FireQueryModel homeWallFlyersPaginationQuery(BuildContext context){

    return FlyerSearch.createQuery(
      searchModel: SearchModel(
        zone: ZoneProvider.proGetCurrentZone(context: context, listen: true,),
        userID: Authing.getUserID(),
        id: 'homeWallFlyersPaginationQuery',
        flyerSearchModel: FlyerSearchModel(
          flyerType: ChainsProvider.proGetHomeWallFlyerType(
            context: context,
            listen: true,
          ),
          phid: ChainsProvider.proGetHomeWallPhid(
            context: context,
            listen: true,
          ),
          auditState: AuditState.verified,
          publishState: null,
          onlyAmazonProducts: null,
          onlyWithPDF: null,
          onlyShowingAuthors: null,
          onlyWithPrices: null,
        ),
        bzSearchModel: null,
        text: null,
        time: null,
      ),
      // limit: 4,
      // gtaLink: ,
      // title: ,
      // descending: ,
      // orderBy: ,
    );

}
// -----------------------------------------------------------------------------

/// FLYER AUDITING PAGINATION

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel flyerAuditingPaginationQuery(){

  return FireQueryModel(
    coll: FireColl.flyers,
    orderBy: const QueryOrderBy(
      fieldName: 'id',
      descending: false,
    ),
    limit: 4,
    finders: <FireFinder>[

      FireFinder(
        field: 'auditState',
        comparison: FireComparison.equalTo,
        value: FlyerModel.cipherAuditState(AuditState.pending),
      ),

      // FireFinder(
      //   field: 'publishState',
      //   comparison: FireComparison.equalTo,
      //   value: FlyerModel.cipherAuditState(AuditState.),
      // ),

    ],
  );

}
// -----------------------------------------------------------------------------
