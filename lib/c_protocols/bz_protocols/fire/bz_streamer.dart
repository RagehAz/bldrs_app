import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
typedef BzModelWidgetBuilder = Widget Function(
    BuildContext context,
    BzModel bzModel,
    );
// -----------------------------------------------------------------------------
Widget bzModelStreamBuilder({
  String bzID,
  BuildContext context,
  BzModelWidgetBuilder builder,
}) {

  return StreamBuilder<BzModel>(
    stream: getBzStream(bzID),
    builder: (BuildContext context, AsyncSnapshot<BzModel> snapshot) {
      if (Streamer.connectionIsLoading(snapshot) == true) {
        return const Loading(
          loading: true,
        );
      } else {
        final BzModel bzModel = snapshot.data;

        blog('xx bzModel in  stream is : $bzModel');

        bzModel.blogBz();

        return builder(context, bzModel);
      }
    },
  );

}
// -----------------------------------------------------------------------------
Widget bzModelBuilder({
  String bzID,
  BuildContext context,
  BzModelWidgetBuilder builder,
}) {
  return FutureBuilder<Map<String, dynamic>>(
      future: Fire.readDoc(
        collName: FireColl.bzz,
        docName: bzID,
      ),
      builder: (BuildContext ctx, AsyncSnapshot<Object> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }

        else {

          if (snapshot.error != null) {
            return const SizedBox(); // superDialog(context, snapshot.error, 'error');
          }

          else {
            final Map<String, dynamic> _map = snapshot.data;
            final BzModel bzModel = BzModel.decipherBz(
              map: _map,
              fromJSON: false,
            );

            return builder(context, bzModel);
          }

        }

      });
}
// -----------------------------------------------------------------------------
/// get bz doc stream
Stream<BzModel> getBzStream(String bzID) {

  final Stream<DocumentSnapshot<Object>> _bzSnapshot = Fire.streamDoc(
      collName: FireColl.bzz,
      docName: bzID
  );

  return _bzSnapshot.map(BzModel.convertDocSnapshotIntoBzModel);
}
// -----------------------------------------------------------------------------