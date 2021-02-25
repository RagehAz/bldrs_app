import 'package:bldrs/view_brains/drafters/keyboarders.dart';
import 'package:bldrs/views/widgets/dialogs/alert_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ---------------------------------------------------------------------------
Future<void> updateFieldOnFirebase({
  BuildContext context ,
  String collectionName,
  String documentName,
  String field,
  dynamic input
}) async {
  final FirebaseFirestore _fireInstance = FirebaseFirestore.instance;
  CollectionReference _collection = _fireInstance.collection(collectionName);
  DocumentReference _doc =  _collection.doc(documentName);

  // if (){}else if(){}else{}
  try {

    await _doc.update({field : input});

    await superDialog(context, 'Successfully updated\n$collectionName\\$documentName\\$field to :\n"$input"','Success');

    minimizeKeyboardOnTapOutSide(context);

  } catch(error) {
    superDialog(context, error, 'Ops !');
  }

}
// ---------------------------------------------------------------------------

