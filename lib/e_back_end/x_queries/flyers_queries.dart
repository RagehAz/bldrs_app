import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_query_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// ALL FLYERS PAGINATION

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel allFlyersPaginationQuery(){
  return FireQueryModel(
    collRef: Fire.getCollectionRef(FireColl.flyers),
    limit: 9,
    orderBy: const QueryOrderBy(fieldName: 'times.published', descending: true),
  );
}
// --------------------
///
FireQueryModel homeWallFlyersPaginationQuery(BuildContext context){

  final FlyerType flyerType =  ChainsProvider.proGetHomeWallFlyerType(
    context: context,
    listen: true,
  );
  // final String phid = ChainsProvider.proGetHomeWallPhid(
  //     context: context,
  //     listen: true,
  // );
  // final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(context: context, listen: true);


  return FireQueryModel(
    collRef: Fire.getSuperCollRef(
      aCollName: FireColl.flyers,
    ),
    limit: 4,
    orderBy: const QueryOrderBy(fieldName: 'score', descending: false),
    finders: <FireFinder>[

      /// FLYER TYPE
      FireFinder(
        field: 'flyerType',
        comparison: FireComparison.equalTo,
        value: FlyerTyper.cipherFlyerType(flyerType),
      ),

      // /// KEYWORDS IDS : phid_k's
      // FireFinder(
      //   field: 'keywordsIDs',
      //   comparison: FireComparison.arrayContains,
      //   value: phid,
      // ),

      // /// COUNTRY
      // FireFinder(
      //   field: 'zone.countryID',
      //   comparison: FireComparison.equalTo,
      //   value: _currentZone.countryID,
      // ),

      // /// CITY
      // FireFinder(
      //   field: 'zone.cityID',
      //   comparison: FireComparison.equalTo,
      //   value: _currentZone.cityID,
      // ),

    ],
  );
}
// -----------------------------------------------------------------------------

/// FLYER AUDITING PAGINATION

// --------------------
/// TESTED : WORKS PERFECT
FireQueryModel flyerAuditingPaginationQuery(){

  return FireQueryModel(
    collRef: Fire.getSuperCollRef(
      aCollName: FireColl.flyers,
    ),
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
