import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_utilities/xx_app_controls_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/general_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
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

  final AppControlsModel _appControl = GeneralProvider.proGerAppControls(context);

  List<FireFinder> _finders = [];

  if (_appControl.showAllFlyersInHome == true){
    _finders = [];
  }

  else {

    final FlyerType flyerType =  ChainsProvider.proGetHomeWallFlyerType(
      context: context,
      listen: true,
    );

    final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: true,
    );

    final String phid = ChainsProvider.proGetHomeWallPhid(
        context: context,
        listen: true,
    );

    const bool _showOnlyVerifiedFlyersInHomeWall = false;

    // blog('homeWallFlyersPaginationQuery() flyerType: $flyerType : phid : $phid : appControls?'
    //     '.showAllFlyersInHome: ${_appControl?.showAllFlyersInHome}');

    _finders = <FireFinder>[

          /// FLYER TYPE
          if (flyerType != null)
          FireFinder(
            field: 'flyerType',
            comparison: FireComparison.equalTo,
            value: FlyerTyper.cipherFlyerType(flyerType),
          ),

          /// COUNTRY
          if (_currentZone != null && _currentZone.countryID != null)
          FireFinder(
            field: 'zone.countryID',
            comparison: FireComparison.equalTo,
            value: _currentZone.countryID,
          ),

          /// CITY
          if (_currentZone != null && _currentZone.cityID != null)
          FireFinder(
            field: 'zone.cityID',
            comparison: FireComparison.equalTo,
            value: _currentZone.cityID,
          ),

          if (_currentZone != null && _currentZone.districtID != null)
            FireFinder(
              field: 'zone.districtID',
              comparison: FireComparison.equalTo,
              value: _currentZone.districtID,
            ),

          /// KEYWORDS IDS : phid_k's
          if (phid != null)
          FireFinder(
            field: 'keywordsIDs',
            comparison: FireComparison.arrayContains,
            value: phid,
          ),

          if (_showOnlyVerifiedFlyersInHomeWall == true)
            FireFinder(
              field: 'auditState',
              comparison: FireComparison.equalTo,
              value: FlyerModel.cipherAuditState(AuditState.verified),
            ),

        ];

  }


  return FireQueryModel(
    collRef: Fire.getSuperCollRef(
      aCollName: FireColl.flyers,
    ),
    limit: 4,
    // orderBy: const QueryOrderBy(fieldName: 'times.published', descending: true),
    finders: _finders,
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
