import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/z_components/loading/loading.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:basics/helpers/streamers/streamer.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
typedef BzModelWidgetBuilder = Widget Function(
    BuildContext context,
    BzModel? bzModel,
    );
// -----------------------------------------------------------------------------
Widget bzModelStreamBuilder({
  required String bzID,
  required BuildContext context,
  required BzModelWidgetBuilder builder,
}) {

  return StreamBuilder<BzModel?>(
    stream: getBzStream(bzID),
    builder: (BuildContext context, AsyncSnapshot<BzModel?> snapshot) {
      if (Streamer.connectionIsLoading(snapshot) == true) {
        return const Loading(
          loading: true,
        );
      } else {

        final BzModel? bzModel = snapshot.data;

        blog('xx bzModel in  stream is : $bzModel');

        bzModel?.blogBz();

        return builder(context, bzModel);
      }
    },
  );

}
// -----------------------------------------------------------------------------
Widget bzModelBuilder({
  required String bzID,
  required BuildContext context,
  required BzModelWidgetBuilder builder,
}) {
  return FutureBuilder<Map<String, dynamic>?>(
      future: Fire.readDoc(
        coll: FireColl.bzz,
        doc: bzID,
      ),
      builder: (BuildContext ctx, AsyncSnapshot<Map<String, dynamic>?> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        }

        else {

          if (snapshot.error != null) {
            return const SizedBox(); // superDialog(context, snapshot.error, 'error');
          }

          else {
            final Map<String, dynamic>? _map = snapshot.data;
            final BzModel? bzModel = BzModel.decipherBz(
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
Stream<BzModel?>? getBzStream(String bzID) {

  final Stream<Map<String, dynamic>?>? _bzSnapshot = Fire.streamDoc(
      coll: FireColl.bzz,
      doc: bzID,
  );

  return _bzSnapshot?.map(BzModel.decipherBzPositioned);
}
// -----------------------------------------------------------------------------
