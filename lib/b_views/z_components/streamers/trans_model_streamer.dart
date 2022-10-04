import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
typedef TransWidgetBuilder = Widget Function(
    BuildContext context,
    List<Phrase> phrases,
    );
// -----------------------------------------------------------------------------
Widget phrasesStreamBuilder({
  @required BuildContext context,
  @required TransWidgetBuilder builder,
  @required Stream<List<Phrase>> stream,
}){

  return

    StreamBuilder(
        stream: stream,
        // initialData: null,
        builder: (BuildContext ctx, AsyncSnapshot<List<Phrase>> snapshot){

          // blog('snapshot is : $snapshot');

          if (Streamer.connectionIsLoading(snapshot) == true) {

            return const Center(
              child: Loading(loading: true),
            );

          }

          else {
            final List<Phrase> _phrases = snapshot.data;
            return builder(ctx, _phrases);
          }

        }
    );

}
// -----------------------------------------------------------------------------
class PhrasesStreamer extends StatelessWidget {

  const PhrasesStreamer({
    @required this.stream,
    @required this.builder,
    Key key
  }) : super(key: key);

  final Stream<List<Phrase>> stream;
  final TransWidgetBuilder builder;

  @override
  Widget build(BuildContext context) {

    return phrasesStreamBuilder(
      context: context,
      stream: stream,
      builder: builder,
    );

  }
}
// -----------------------------------------------------------------------------
