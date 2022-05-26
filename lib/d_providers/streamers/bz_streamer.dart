import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart' as StreamChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      if (StreamChecker.connectionIsLoading(snapshot) == true) {
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
        context: context,
        collName: FireColl.bzz,
        docName: bzID,
      ),
      builder: (BuildContext ctx, AsyncSnapshot<Object> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          if (snapshot.error != null) {
            return Container(); // superDialog(context, snapshot.error, 'error');
          } else {
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
  final Stream<DocumentSnapshot<Object>> _bzSnapshot =
      Fire.streamDoc(
          collName: FireColl.bzz,
          docName: bzID
      );

  final Stream<BzModel> _bzStream = _bzSnapshot.map(BzModel.getBzModelFromSnapshot);

  return _bzStream;
}
// -----------------------------------------------------------------------------
