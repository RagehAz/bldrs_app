import 'package:bldrs/a_models/chain/chain.dart';
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
// ------------------------------------------

/// UPDATES

// ------------------------------------------

/// DELETE

// ------------------------------------------
