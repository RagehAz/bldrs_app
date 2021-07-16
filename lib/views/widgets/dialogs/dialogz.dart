import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:flutter/material.dart';

class Dialogz{
// -----------------------------------------------------------------------------
  static Future<void> maxSlidesReached(BuildContext context, int maxLength) async {
    await superDialog(
      context: context,
      title: 'Max. Images reached',
      body: 'Can not add more than $maxLength images in one slide',
      boolDialog: false,
    );
  }
// -----------------------------------------------------------------------------

// -----------------------------------------------------------------------------

}