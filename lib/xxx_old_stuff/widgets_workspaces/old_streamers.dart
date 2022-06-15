// -----------------------------------
/// note stream builder
/*

/// TESTED : WORKS PERFECT
Widget noteStreamBuilder({
  @required BuildContext context,
  @required NotiModelsWidgetsBuilder builder,
  @required Stream<List<NoteModel>> stream,
  Widget loadingWidget,
}) {
  return StreamBuilder<List<NoteModel>>(
    key: const ValueKey<String>('notifications_stream_builder'),
    stream: stream,
    initialData: const <NoteModel>[],
    builder: (BuildContext ctx, AsyncSnapshot<List<NoteModel>> snapshot) {

      blog('stream connection state is : ${snapshot.connectionState.toString()}');

      if (snapshot.connectionState == ConnectionState.waiting){
        blog('the shit is looooooooooooooooooooooooading');
        return loadingWidget ?? const LoadingFullScreenLayer();
      }

      else {
        final List<NoteModel> notiModels = snapshot.data;
        blog('the shit is getting reaaaaaaaaaaaaaaaaaaaaaaal');
        return builder(ctx, notiModels);
      }

    },
  );
}

 */
// -----------------------------------
