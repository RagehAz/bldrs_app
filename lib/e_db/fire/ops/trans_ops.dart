import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/translation_model.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/streamers/bz_streamer.dart';
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart' as StreamChecker;
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;

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
