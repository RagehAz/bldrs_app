part of bldrs_engine;

class BzzInitialization {
  // -----------------------------------------------------------------------------

  const BzzInitialization();

  // -----------------------------------------------------------------------------

  /// BZZ_STREAMS_UPDATES_LOCALLY

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<StreamSubscription> initializeMyBzzStreams(){
    final List<StreamSubscription> _output = [];

    final List<String> _myBzzIDs = UsersProvider.proGetMyBzzIDs(
      context: getMainContext(),
      listen: false,
    );

    if (Lister.checkCanLoop(_myBzzIDs) == true){

      for (final String bzID in _myBzzIDs){

        final StreamSubscription? _sub = _initializeMyBzStream(
          bzID: bzID,
        );

        if (_sub != null){
          _output.add(_sub);
        }

      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static StreamSubscription? _initializeMyBzStream({
    required String bzID,
  }){

    final Stream<Map<String, dynamic>?>? _stream = Fire.streamDoc(
      coll: FireColl.bzz,
      doc: bzID,
    );

    final StreamSubscription? _sub = _stream?.listen(
      /// LISTENER
      (Map<String, dynamic>? newMap) async {

        final BzModel? _newBz = BzModel.decipherBz(map: newMap, fromJSON: false);

        if (_newBz == null){

          /// ONLY WHEN I RECEIVE A NOTE SAYING THE BZ IS REMOVED,
          /// THE NOTE FUNCTION WILL TRIGGER THE onIGotRemoved_WITH_isBzDeleted_TRUE
          // await BzProtocols.deleteLocally(
          //   bzID: bzID,
          //   invoker: 'initializeMyBzStream : $bzID',
          // );

        }
        else {

          final BzModel? _oldBz = await BzLDBOps.readBz(bzID);

          if (BzModel.checkBzzAreIdentical(bz1: _oldBz, bz2: _newBz) == false){

            final bool _authorsContainMyUserID = AuthorModel.checkAuthorsContainUserID(
              authors: _newBz.authors,
              userID: Authing.getUserID(),
            );

            if (_authorsContainMyUserID == false){

              await NewAuthorshipExit.onIGotRemoved(
                bzID: _newBz.id,
                isBzDeleted: false, //map == null,
              );

            }

            else {

              await BzProtocols.updateBzLocally(
                newBz: _newBz,
                oldBz: _oldBz,
              );

            }

          }

        }

      },

      /// CANCEL
      cancelOnError: false,

      /// ON DONE
      onDone: (){
        // blog('FireDocStreamer : onStreamDataChanged : done');
      },

      /// ON ERROR
      onError: (Object error){
        // blog('FireDocStreamer : onStreamDataChanged : error : $error');
      },);

    return _sub;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void disposeBzzStreams({
    required List<StreamSubscription> subs,
  }){

    if (Lister.checkCanLoop(subs) == true){
      for (final StreamSubscription sub in subs){
        sub.cancel();
      }
    }

  }
  // -----------------------------------------------------------------------------
}
