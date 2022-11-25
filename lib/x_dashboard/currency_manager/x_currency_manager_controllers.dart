import 'dart:async';

import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

Future<void> onBackupCurrencies(BuildContext context) async {

    blog('NO NEED TO BACKUP ANYMORE CURRENCIES ARE ALREADY SAVED IN JSON : Case Closed');

  // final bool _continue = await Dialogs.confirmProceed(
  //   context: context,
  // );
  //
  // if (_continue == true){
  //
  //   unawaited(WaitDialog.showWaitDialog(context: context));
  //
  //   final Map<String, dynamic> _currenciesDoc = await Fire.readDoc(
  //     collName: FireColl.zones,
  //     docName: FireDoc.zones_currencies,
  //   );
  //
  //   await Fire.createNamedSubDoc(
  //     collName: FireColl.admin,
  //     docName: FireDoc.admin_backups,
  //     subCollName: FireSubColl.admin_backups_currencies,
  //     subDocName: FireSubDoc.admin_backups_currencies_currencies,
  //     input: _currenciesDoc,
  //   );
  //
  //   await WaitDialog.closeWaitDialog(context);
  //
  //   await TopDialog.showTopDialog(
  //     context: context,
  //     firstVerse: Verse.plain('Currencies have been backed up successfully.'),
  //   );
  //
  //
  // }
  //

}
