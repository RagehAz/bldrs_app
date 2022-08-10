import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/e_db/fire/ops/chain_ops.dart';

class ChainProtocols {
// -----------------------------------------------------------------------------
  const ChainProtocols();
// -----------------------------------------------------------------------------

/// COMPOSE

// ----------------------------------
///
// -----------------------------------------------------------------------------

/// FETCH

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Chain> fetchKeywordsChain(BuildContext context) async {

    Chain _keywordsChain;

    /// 1 - search LDB
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.keywordsChain,
    );

    /// 2 - all keywords chain found in LDB
    if (Mapper.checkCanLoopList(_maps)) {
      // blog('keywords chain found in LDB');
      _keywordsChain = Chain.decipherChain(_maps[0]);
    }

    /// 3 - all keywords chain is not found in LDB
    else {
      // blog('keywords chain is NOT found in LDB');
      _keywordsChain = await ChainFireOps.readKeywordsChain(context);

      /// 3 - insert in LDB when found on firebase
      if (_keywordsChain != null){
        // blog('keywords chain is found in FIREBASE and inserted');
        await LDBOps.insertMap(
          input: _keywordsChain.toMap(),
          docName: LDBDoc.keywordsChain,
        );

      }

    }

    return _keywordsChain;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Chain> fetchSpecsChain(BuildContext context) async {

    Chain _specsChain;

    /// 1 - search LDB
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.specsChain,
    );

    /// 2 - all keywords chain found in LDB
    if (Mapper.checkCanLoopList(_maps)) {
      _specsChain = Chain.decipherChain(_maps[0]);
    }

    /// 3 - all keywords chain is not found in LDB
    else {
      _specsChain = await ChainFireOps.readSpecsChain(context);

      /// 3 - insert in LDB when found on firebase
      if (_specsChain != null){

        await LDBOps.insertMap(
          input: _specsChain.toMap(),
          docName: LDBDoc.specsChain,
        );

      }

    }

    return _specsChain;
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
