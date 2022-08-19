

import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/foundation/real_colls.dart';
import 'package:flutter/cupertino.dart';

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

// ------------------------------------------
  static Future<Chain> createChainK({
    @required BuildContext context,
    @required Chain chainK,
  }) async {

    Chain _uploaded;

    /// NOTE : chain K does not allow duplicate IDs in last node
    if (chainK != null){

      final List<String> _paths = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: chainK.sons,
      );

      final Map<String, dynamic> _map = Chain.cipherChainKPaths(
        chainKPaths: _paths,
      );

      final Map<String, dynamic> _uploadedChainKMap = await Real.createDocInPath(
        context: context,
        pathWithoutDocName: RealColl.chains,
        addDocIDToOutput: false,
        docName: RealDoc.chains_bigChainS,
        map: _map,
      );

      _uploaded = Chain.decipherBigChainKRealMap(
          bigChainKMap: _uploadedChainKMap
      );

    }

    return _uploaded;
  }
// -----------------------------------------------------------------------------

/// READ

// ------------------------------------------
  /// TESTED : WORK PERFECT
  static Future<Chain> readBigChainK(BuildContext context) async {

    final Map<String, dynamic> _bigChainKMap = await Real.readDocOnce(
        context: context,
        collName: RealColl.chains,
        docName: RealDoc.chains_bigChainK,
    );

    final Chain _bigChainK = Chain.decipherBigChainKRealMap(
      bigChainKMap: _bigChainKMap,
    );

    return _bigChainK;
  }
// ------------------------------------------
  static Future<Chain> readBigChainS(BuildContext context) async {}
// -----------------------------------------------------------------------------

/// UPDATE

// ------------------------------------------
  static Future<void> updateChainKPath({
    @required BuildContext context,
    @required String phidK, // which is map key for the path
  }) async {



  }
// ------------------------------------------
  static Future<void> updateChainSPath({
    @required BuildContext context,
    @required String chainSPathKey, // which is combination ( 'lastPartOfParentID' + phidS )
  }) async {

  }
// -----------------------------------------------------------------------------

/// DELETE

// ------------------------------------------
  static Future<void> deleteChainKPhidK() async {}
// ------------------------------------------
  static Future<void> deleteChainSPhidS() async {}
// -----------------------------------------------------------------------------
}
