import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart';
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
            'lastUpdate' : cipherTime(time: DateTime.now(), toJSON: false),
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
      verse: 'Success',
      secondLine: 'Both Keywords and Specs chains have been backed up successfully',
    );

  }
  else {
    blog('BACK UP OPERATIONS FAILED : could not back up all Chains');

    await TopDialog.showTopDialog(
      context: context,
      verse: 'Failed',
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
