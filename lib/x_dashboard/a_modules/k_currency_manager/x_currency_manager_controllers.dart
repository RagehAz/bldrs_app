import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart';
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:flutter/material.dart';

Future<void> onBackupCurrencies(BuildContext context) async {

  final Map<String, dynamic> _currenciesDoc = await Fire.readDoc(
    context: context,
    collName: FireColl.zones,
    docName: FireDoc.zones_currencies,
  );

  await Fire.createNamedSubDoc(
    context: context,
    collName: FireColl.admin,
    docName: FireDoc.admin_backups,
    subCollName: FireSubColl.admin_backups_currencies,
    subDocName: FireSubDoc.admin_backups_currencies_currencies,
    input: _currenciesDoc,
  );

  await TopDialog.showTopDialog(
    context: context,
    firstVerse: Verse.plain('Currencies have been backed up successfully.'),
  );

}
