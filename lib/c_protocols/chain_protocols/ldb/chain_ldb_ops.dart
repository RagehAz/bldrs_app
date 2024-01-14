import 'package:basics/helpers/files/filers.dart';
import 'package:basics/ldb/methods/ldb_ops.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/c_protocols/chain_protocols/real/chain_real_ops.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';

/// => TAMAM
class ChainLDBOps {
  // -----------------------------------------------------------------------------

  const ChainLDBOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> insertBldrsChains(List<Chain>? chains) async {

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
  static Future<List<Chain>?> readBldrsChains() async {

    final Map<String, dynamic>? map = await Filers.readLocalJSON(
        path: ChainRealOps.bldrsChainsFilePath,
    );

    final List<Chain>? _chains = Chain.decipherBldrsChains(
        map: map,
    );

    return _chains;
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateBldrsChains({
    required List<Chain>? chains,
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
