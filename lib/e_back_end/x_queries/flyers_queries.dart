import 'package:basics/models/flag_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/publication_model.dart';
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
/// TAMAM : WORKS PERFECT
FireQueryModel homeWallFlyersPaginationQuery(BuildContext context){

    return FlyerSearch.createQuery(
      searchModel: SearchModel(
        zone: _concludeHomeZone(context),
        userID: Authing.getUserID(),
        id: 'homeWallFlyersPaginationQuery',
        flyerSearchModel: FlyerSearchModel(
          // flyerType: null,
          // flyerType: ChainsProvider.proGetHomeWallFlyerType(
          //   context: context,
          //   listen: true,
          // ),
          phid: ChainsProvider.proGetHomeWallPhid(
            context: context,
            listen: true,
          ),
          publishState: PublishState.published,
          // onlyAmazonProducts: null,
          // onlyWithPDF: null,
          // onlyShowingAuthors: null,
          // onlyWithPrices: null,
        ),
        // bzSearchModel: null,
        // text: null,
        // time: null,
      ),
      limit: 12,
      // gtaLink: ,
      // title: ,
      // descending: true,
      orderBy: 'times.published',
      // orderBy: 'score',
    );

}
// --------------------
/// TAMAM : WORKS PERFECT
ZoneModel? _concludeHomeZone(BuildContext context){

  final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(context: context, listen: true);
  final bool _showWorld = _currentZone == ZoneModel.planetZone;
  final bool _showOnlyCountry = _currentZone.cityID == null || _currentZone.cityID == Flag.allCitiesID;

  if (_showWorld == true){
    return null;
  }

  else if (_showOnlyCountry == true){
    return _currentZone.nullifyField(
      cityID: true,
      cityName: true,
      cityModel: true,
    );
  }

  else {
    return _currentZone;
  }

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
        field: 'publishState',
        comparison: FireComparison.equalTo,
        value: PublicationModel.cipherPublishState(PublishState.pending),
      ),

    ],
  );

}
// -----------------------------------------------------------------------------
