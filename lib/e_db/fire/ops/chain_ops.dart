import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/cupertino.dart';
// -----------------------------------------------------------------------------

/// CREATE

// ------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> backupChainsOps(BuildContext context) async {

  final bool _success = await tryCatchAndReturnBool(
      context: context,
      functions: () async {

        final Chain _keywordsChain = await readKeywordsChain(context);

        await Fire.createNamedSubDoc(
            context: context,
            collName: FireColl.admin,
            docName: FireDoc.admin_backups,
            subCollName: FireSubColl.admin_backups_chains,
            subDocName: 'keywords',
            input: _keywordsChain.toMap(),
        );

        final Chain _specsChain = await readSpecsChain(context);

        await Fire.createNamedSubDoc(
          context: context,
          collName: FireColl.admin,
          docName: FireDoc.admin_backups,
          subCollName: FireSubColl.admin_backups_chains,
          subDocName: 'specs',
          input: _specsChain.toMap(),
        );

        /// UPDATE THE BACKUP TIME STAMP
        await Fire.createNamedSubDoc(
          context: context,
          collName: FireColl.admin,
          docName: FireDoc.admin_backups,
          subCollName: FireSubColl.admin_backups_chains,
          subDocName: 'last_update_time',
          input: {
            'lastUpdate' : Timers.cipherTime(time: DateTime.now(), toJSON: false),
          },

        );

      }
  );

  /// REPORT BACK
  if (_success == true){
    blog('BACK UP SUCCESS : '
        'all Keywords and specs chains docs '
        'are saved in '
        '${FireColl.admin}'
        '/${FireDoc.admin_backups}'
        '/${FireSubColl.admin_backups_chains}'
    );

    await TopDialog.showTopDialog(
      context: context,
      firstLine: 'Success',
      secondLine: 'Both Keywords and Specs chains have been backed up successfully',
    );

  }
  else {
    blog('BACK UP OPERATIONS FAILED : could not back up all Chains');

    await TopDialog.showTopDialog(
      context: context,
      firstLine: 'Failed',
      secondLine: 'Something went wrong, Try again',
      color: Colorz.red255,
    );


  }

}
// ------------------------------------------

/// READ

// ------------------------------------------
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
Future<List<Chain>> readKeywordsAndSpecsBackups(BuildContext context) async {

  final Map<String, dynamic> _keywordsChainMap = await Fire.readSubDoc(
      context: context,
      collName: FireColl.admin,
      docName: FireDoc.admin_backups,
      subCollName: FireSubColl.admin_backups_chains,
      subDocName: FireSubDoc.admin_backups_chains_keywords,
  );

  final Chain _keywordChain = Chain.decipherChain(_keywordsChainMap);

  final Map<String, dynamic> _specsChainMap = await Fire.readSubDoc(
    context: context,
    collName: FireColl.admin,
    docName: FireDoc.admin_backups,
    subCollName: FireSubColl.admin_backups_chains,
    subDocName: FireSubDoc.admin_backups_chains_specs,
  );

  final Chain _specsChain = Chain.decipherChain(_specsChainMap);

  return <Chain>[_keywordChain, _specsChain];
}
// ------------------------------------------
/// TESTED : WORKS PERFECT
Future<List<Chain>> reloadKeywordsAndSpecsChains(BuildContext context) async {
  final Chain _keywordsChain = await readKeywordsChain(context);
  final Chain _specsChain = await readSpecsChain(context);
  return <Chain>[_keywordsChain, _specsChain];
}
// -----------------------------------------------------------------------------

/// UPDATES

// ------------------------------------------
/// TESTED : WORKS PERFECT
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

  // blog('-------------------- > original Chain : -');
  // _specsChain.blogChain();
  // blog('-------------------- > updated Chain : -');
  // _updatedChain.blogChain();

  if (_chainsAreTheSame == false){
    // blog('chains are the same : $_chainsAreTheSame');
    await Fire.updateDoc(
        context: context,
        collName: FireColl.chains,
        docName: FireDoc.chains_specs,
        input: _updatedChain.toMap(),
    );

  }

}
// ------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> replaceSonChain({
  @required BuildContext context,
  @required Chain sourceChain,
  @required String sonChainIDToReplace,
  @required String fireDoc,
  @required dynamic newSons,
}) async {

  final List<Chain> _newSons = Chain.replaceChainInChains(
    chains: sourceChain.sons,
    oldChainID: sonChainIDToReplace,
    chainToReplace: Chain(
      id: sonChainIDToReplace,
      sons: newSons,
    ),
  );

  final Chain _finalChain = Chain(
    id: sourceChain.id,
    sons: _newSons,
  );

  // _finalChain.blogChain();

  await Fire.createNamedDoc(
    context: context,
    collName: FireColl.chains,
    docName: fireDoc,
    input: _finalChain.toMap(),
  );

}
// ------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> updateKeywordsChain({
  @required BuildContext context,
  @required Chain newKeywordsChain,
}) async {

  await Fire.createNamedDoc(
      context: context,
      collName: FireColl.chains,
      docName: FireDoc.chains_keywords,
      input: newKeywordsChain.toMap(),
  );

}
// ------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> updateSpecsChain({
  @required BuildContext context,
  @required Chain newSpecsChain,
}) async {

  await Fire.createNamedDoc(
    context: context,
    collName: FireColl.chains,
    docName: FireDoc.chains_specs,
    input: newSpecsChain.toMap(),
  );

}
// -----------------------------------------------------------------------------

/// DELETE

// ------------------------------------------
