import 'package:bldrs/a_models/secondary_models/translation_model.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart' as StreamChecker;
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
typedef TransWidgetBuilder = Widget Function(
    BuildContext context,
    TransModel transModel,
    );
// -----------------------------------------------------------------------------
Widget transModelStreamBuilder({
  @required BuildContext context,
  @required TransWidgetBuilder builder,
  @required Stream<TransModel> stream,
}){

  return

    StreamBuilder(
        stream: stream,
        initialData: null,
        builder: (BuildContext ctx, AsyncSnapshot<TransModel> snapshot){

          // blog('snapshot is : $snapshot');

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

class TransModelStreamer extends StatelessWidget {

  const TransModelStreamer({
    @required this.stream,
    @required this.builder,
    Key key
  }) : super(key: key);

  final Stream<TransModel> stream;
  final TransWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {

    return transModelStreamBuilder(
      context: context,
      stream: stream,
      builder: builder,
    );

  }
}
