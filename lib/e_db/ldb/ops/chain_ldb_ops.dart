import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class ChainLDBOps {
  // -----------------------------------------------------------------------------

  const ChainLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertBldrsChains(List<Chain> chains) async {

    await LDBOps.insertMap(
      docName: LDBDoc.bldrsChains,
      input: Chain.cipherBldrsChains(chains: chains),
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Chain>> readBldrsChains() async {

    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.bldrsChains,
    );

    List<Chain> _chains;

    if (Mapper.checkCanLoopList(_maps) == true) {

      _chains = Chain.decipherBldrsChains(
        map: _maps[0],
      );

    }

    return _chains;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  ///
  static Future<void> updateBldrsChains({
    @required List<Chain> chains,
  }) async {

    await insertBldrsChains(chains);

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  ///
  static Future<void> deleteBldrsChains() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.bldrsChains,
    );

  }
  // --------------------
}

/*

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertBigChainK(Chain bigChainK) async {

    await LDBOps.insertMap(
      input: Chain.cipherBigChainK(chainK: bigChainK),
      docName: LDBDoc.bigChainK,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertBigChainS(Chain bigChainS) async {

    await LDBOps.insertMap(
      input: Chain.cipherBigChainS(chainS: bigChainS),
      docName: LDBDoc.bigChainS,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Chain> readBigChainK() async {

    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.bigChainK,
    );

    Chain _bigChainK;

    if (Mapper.checkCanLoopList(_maps) == true) {

      _bigChainK = Chain.decipherBigChainK(
        bigChainKMap: _maps[0],
      );

    }

    return _bigChainK;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Chain> readBigChainS() async {

    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.bigChainS,
    );

    Chain _bigChainS;

    if (Mapper.checkCanLoopList(_maps) == true) {

      _bigChainS = Chain.decipherBigChainS(
        bigChainSMap: _maps[0],
      );

    }

    return _bigChainS;
  }

    // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateBigChainK({
    @required Chain newBigChainK,
  }) async {

    // await deleteBigChainK();

    await insertBigChainK(newBigChainK);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateBigChainS({
    @required Chain newBigChainS,
  }) async {

    // await deleteBigChainS();

    await insertBigChainS(newBigChainS);

  }

 */
