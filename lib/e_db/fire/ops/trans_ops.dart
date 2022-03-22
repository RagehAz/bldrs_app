import 'package:bldrs/a_models/secondary_models/translation_model.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
Stream<TransModel> getTransModelStream({
  @required BuildContext context,
  @required String langCode,
}) {

  final Stream<DocumentSnapshot<Object>> _snap = Fire.streamDoc(
    collName: FireColl.translations,
    docName: langCode,
  );

  final Stream<TransModel> _stream = _snap.map(TransModel.getTransModelFromStream);

  return _stream;

}
// -----------------------------------------------------------------------------
