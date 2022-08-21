import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class ChainLDBOps {
// -----------------------------------------------------------------------------

  const ChainLDBOps();

// -----------------------------------------------------------------------------

/// CREATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertBigChainK(Chain bigChainK) async {

    await LDBOps.insertMap(
      input: Chain.cipherBigChainK(chainK: bigChainK),
      docName: LDBDoc.bigChainK,
    );

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertBigChainS(Chain bigChainS) async {

    await LDBOps.insertMap(
      input: Chain.cipherBigChainS(chainS: bigChainS),
      docName: LDBDoc.bigChainS,
    );

  }
// -----------------------------------------------------------------------------

/// READ

// ----------------------------------
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
// ----------------------------------
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
// -----------------------------------------------------------------------------

/// UPDATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateBigChainK({
    @required Chain newBigChainK,
  }) async {

    // await deleteBigChainK();

    await insertBigChainK(newBigChainK);

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateBigChainS({
    @required Chain newBigChainS,
  }) async {

    // await deleteBigChainS();

    await insertBigChainS(newBigChainS);

  }
// -----------------------------------------------------------------------------

/// DELETE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteBigChainK() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.bigChainK,
    );

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteBigChainS() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.bigChainS,
    );

  }
// ----------------------------------
}
