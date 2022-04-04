import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:flutter/cupertino.dart';
// -----------------------------------------------------------------------------

/// CREATE

// ------------------------------------------

/// READ

// ------------------------------------------
Future<Chain> readKeywordsChain(BuildContext context) async {

  final Map<String, dynamic> _map  = await Fire.readDoc(
      context: context,
      collName: FireColl.chains,
      docName: FireDoc.chains_keywords,
  );

  final Chain _chain = Chain.decipherChain(_map);

  return _chain;
}
// ------------------------------------------
Future<Chain> readSpecsChain(BuildContext context) async {

  final Map<String, dynamic> _map  = await Fire.readDoc(
    context: context,
    collName: FireColl.chains,
    docName: FireDoc.chains_specs,
  );

  final Chain _chain = Chain.decipherChain(_map);

  return _chain;
}
// -----------------------------------------------------------------------------

/// UPDATES

// ------------------------------------------
Future<void> addChainsToSpecsChainSons({
  @required BuildContext context,
  @required List<Chain> chainsToAdd,
}) async {

  final Chain _specsChain = await readSpecsChain(context);

  final Chain _updatedChain = Chain.addChainsToSonsIfPossible(
    chainsToAdd: chainsToAdd,
    chainToTake: _specsChain,
  );

  final bool _chainsAreTheSame = Chain.chainsAreTheSame(
    chainA: _specsChain,
    chainB: _updatedChain,
  );

  blog('-------------------- > original Chain : -');
  _specsChain.blogChain();
  blog('-------------------- > updated Chain : -');
  _updatedChain.blogChain();

  if (_chainsAreTheSame == false){

    blog('chains are the same : $_chainsAreTheSame');

    await Fire.updateDoc(
        context: context,
        collName: FireColl.chains,
        docName: FireDoc.chains_specs,
        input: _updatedChain.toMap(),
    );

  }

}
// -----------------------------------------------------------------------------
/// DELETE

// ------------------------------------------
