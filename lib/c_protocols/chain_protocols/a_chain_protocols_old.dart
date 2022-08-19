import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/city_phid_counters.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/e_db/real/ops/city_chain_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/e_db/fire/ops/chain_fire_ops.dart';

class ChainProtocolsOLD {
// -----------------------------------------------------------------------------
  const ChainProtocolsOLD();
// -----------------------------------------------------------------------------

/// COMPOSE

// ----------------------------------
///
// -----------------------------------------------------------------------------

/// FETCH

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Chain> fetchBigChainKOLD(BuildContext context) async {

    Chain _keywordsChain;

    /// 1 - search LDB
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.keywordsChain,
    );

    /// 2 - all keywords chain found in LDB
    if (Mapper.checkCanLoopList(_maps)) {
      // blog('keywords chain found in LDB');
      _keywordsChain = Chain.decipherChainOLD(_maps[0]);
    }

    /// 3 - all keywords chain is not found in LDB
    else {
      // blog('keywords chain is NOT found in LDB');
      _keywordsChain = await ChainFireOpsOLD.readKeywordsChain(context);

      /// 3 - insert in LDB when found on firebase
      if (_keywordsChain != null){
        // blog('keywords chain is found in FIREBASE and inserted');
        await LDBOps.insertMap(
          input: _keywordsChain.toMapOLD(),
          docName: LDBDoc.keywordsChain,
        );

      }

    }

    return _keywordsChain;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Chain> fetchBigChainSOLD(BuildContext context) async {

    Chain _specsChain;

    /// 1 - search LDB
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.specsChain,
    );

    /// 2 - all keywords chain found in LDB
    if (Mapper.checkCanLoopList(_maps)) {
      _specsChain = Chain.decipherChainOLD(_maps[0]);
    }

    /// 3 - all keywords chain is not found in LDB
    else {
      _specsChain = await ChainFireOpsOLD.readSpecsChain(context);

      /// 3 - insert in LDB when found on firebase
      if (_specsChain != null){

        await LDBOps.insertMap(
          input: _specsChain.toMapOLD(),
          docName: LDBDoc.specsChain,
        );

      }

    }

    return _specsChain;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<CityPhidCounters> readCityPhidCountersOfCurrentZone({
    @required BuildContext context,
  }) async {
    CityPhidCounters _cityPhidCounters;

    final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: false,
    );

    if (_currentZone != null){

      _cityPhidCounters = await CityChainOps.readCityChain(
        context: context,
        cityID: _currentZone.cityID,
      );

    }

    return _cityPhidCounters;
  }
// -----------------------------------------------------------------------------

/// SEARCHERS

// -------------------------------------
/*
  /// TESTED : WORKS PERFECT
  Chain searchAllChainsByID({
  @required String chainID,
    @required bool onlyUseCityChains,
}){

    final Chain _keywordsChain = onlyUseCityChains == true ? _cityKeywordsChain : _allKeywordsChain;

    final List<Chain> _allChains = <Chain>[_keywordsChain, _specsChain];

    final Chain _chain = Chain.getChainFromChainsByID(
      chainID: chainID,
      chains: _allChains,
    );

    return _chain;
  }

 */
// -----------------------------------------------------------------------------

/// RENOVATION

// ----------------------------------
///
// -----------------------------------------------------------------------------

/// WIPE OUT

// ----------------------------------
///
}
