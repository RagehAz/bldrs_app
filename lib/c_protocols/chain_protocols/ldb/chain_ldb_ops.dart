import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:flutter/material.dart';
/// => TAMAM
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
      primaryKey: LDBDoc.getPrimaryKey(LDBDoc.bldrsChains),
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
  /// TESTED : WORKS PERFECT
  static Future<void> updateBldrsChains({
    required List<Chain> chains,
  }) async {

    await insertBldrsChains(chains);

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteBldrsChains() async {

    await LDBOps.deleteAllMapsAtOnce(
      docName: LDBDoc.bldrsChains,
    );

  }
  // --------------------
}
