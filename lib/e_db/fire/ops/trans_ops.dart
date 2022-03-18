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
typedef TransWidgetBuilder = Widget Function(
    BuildContext context,
    TransModel transModel,
    );
// -----------------------------------------------------------------------------
Widget transModelStreamBuilder({
  @required BuildContext context,
  @required TransWidgetBuilder builder,
  @required String langCode,
}){

  return

  StreamBuilder(
      stream: getTransModelStream(
          context: context,
          langCode: langCode,
      ),
      initialData: null,
      builder: (BuildContext ctx, AsyncSnapshot<TransModel> snapshot){

        blog('snapshot is : $snapshot');

        if (StreamChecker.connectionIsLoading(snapshot) == true) {

          return const Center(
            child: Loading(loading: true),
          );

        }

        else {
          final TransModel _transModel = snapshot.data;
          return builder(ctx, _transModel);
        }

      }
  );

}
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
