import 'package:basics/helpers/classes/files/filers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:fire/super_fire.dart';

/*
Map looks like this :-

Map<String, dynamic> chainKMap = <String,dynamic>{
  'key' : 'path',
  'phid_k_something' : 'chainK/groupID/subGroupID/subSubGroupID/.../phid',
};

 */

class ChainRealOps {
  // -----------------------------------------------------------------------------

  const ChainRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Chain>?> createBldrsChains({
    required List<Chain> chains,
  }) async {
    List<Chain>? _uploaded;

    if (Lister.checkCanLoopList(chains) == true){

      final Map<String, dynamic> _map = Chain.cipherBldrsChains(
        chains: chains,
      );

      final Map<String, dynamic>? _uploadedChainSMap = await Real.createColl(
        coll: RealColl.bldrsChains,
        map: _map,
      );

      _uploaded = Chain.decipherBldrsChains(
          map: _uploadedChainSMap
      );

    }

    return _uploaded;
  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  static const String bldrsChainsFilePath = 'packages/bldrs_keywords/lib/assets/bldrs_chains.json';
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Chain>?> readBldrsChains() async {

    // final Map<String, dynamic>? map = await Real.readPathMap(
    //   path: RealColl.bldrsChains,
    // );

    final Map<String, dynamic>? map = await Filers.readLocalJSON(
        path: bldrsChainsFilePath,
    );

    final List<Chain>? _chains = Chain.decipherBldrsChains(map: map);

    return Phider.sortChainsByIndexes(_chains);
  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateBldrsChains({
    required List<Chain>? chains,
  }) async {

    if (chains != null){

      await Real.updateColl(
        coll: RealColl.bldrsChains,
        map: Chain.cipherBldrsChains(chains: chains),
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// NO NEED
  /*
  static Future<void> deleteChainKPhidK() async {}
  // --------------------
  static Future<void> deleteChainSPhidS() async {}
   */
  // -----------------------------------------------------------------------------
}

/*
  // --------------------
  /// TASK DEPRECATED
  static Future<Chain> createBigChainK({
    required BuildContext context,
    required Chain chainK,
  }) async {

    Chain _uploaded;

    /// NOTE : chain K does not allow duplicate IDs in last node
    if (chainK != null){

      final Map<String, dynamic> _map = Chain.cipherBigChainK(
        chainK: chainK,
      );

      final Map<String, dynamic> _uploadedChainKMap = await Real.createDocInPath(
        context: context,
        pathWithoutDocName: RealColl.chains,
        addDocIDToOutput: false,
        docName: RealDoc.chains_bigChainK,
        map: _map,
      );

      _uploaded = Chain.decipherBigChainK(
          bigChainKMap: _uploadedChainKMap
      );

    }

    return _uploaded;
  }
  // --------------------
  /// TASK DEPRECATED
  static Future<Chain> createBigChainS({
    required BuildContext context,
    required Chain chainS,
  }) async {

    Chain _uploaded;

    /// NOTE : chain K does not allow duplicate IDs in last node
    if (chainS != null){

      final Map<String, dynamic> _map = Chain.cipherBigChainS(
        chainS: chainS,
      );

      final Map<String, dynamic> _uploadedChainSMap = await Real.createDocInPath(
        context: context,
        pathWithoutDocName: RealColl.chains,
        addDocIDToOutput: false,
        docName: RealDoc.chains_bigChainS,
        map: _map,
      );

      _uploaded = Chain.decipherBigChainS(
          bigChainSMap: _uploadedChainSMap
      );

    }

    return _uploaded;
  }

  /// TASK DEPRECATED
  static Future<Chain> readBigChainK(BuildContext context) async {

    final Map<String, dynamic> _bigChainKMap = await Real.readDocOnce(
      context: context,
      collName: RealColl.chains,
      docName: RealDoc.chains_bigChainK,
    );

    final Chain _bigChainK = Chain.decipherBigChainK(
      bigChainKMap: _bigChainKMap,
    );

    return _bigChainK;
  }
  // --------------------
  /// TASK DEPRECATED
  static Future<Chain> readBigChainS(BuildContext context) async {

    final Map<String, dynamic> _bigChainSMap = await Real.readDocOnce(
      context: context,
      collName: RealColl.chains,
      docName: RealDoc.chains_bigChainS,
    );

    final Chain _bigChainS = Chain.decipherBigChainS(
      bigChainSMap: _bigChainSMap,
    );

    return _bigChainS;
  }

  /// TASK DEPRECATED
  static Future<void> updateBigChainK({
    required BuildContext context,
    required Chain bigChainK,
  }) async {

    if (bigChainK != null){

      await Real.updateDoc(
        context: context,
        collName: RealColl.chains,
        docName: RealDoc.chains_bigChainK,
        map: Chain.cipherBigChainK(chainK: bigChainK),
      );

    }

  }
  // --------------------
  /// TASK DEPRECATED
  static Future<void> updateBigChainS({
    required BuildContext context,
    required Chain bigChainS,
  }) async {

    if (bigChainS != null){

      await Real.updateDoc(
        context: context,
        collName: RealColl.chains,
        docName: RealDoc.chains_bigChainS,
        map: Chain.cipherBigChainS(chainS: bigChainS),
      );

    }

  }

  // --------------------
  static Future<void> updateChainKPath({
    required BuildContext context,
    required String phidK, // which is map key for the path
  }) async {



  }
  // --------------------
  static Future<void> updateChainSPath({
    required BuildContext context,
    required String chainSPathKey, // which is combination ( 'lastPartOfParentID' + phidS )
  }) async {

  }



 */
