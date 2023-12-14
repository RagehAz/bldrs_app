

class NoteEventsOfProfileDeletion {
  // -----------------------------------------------------------------------------

  const NoteEventsOfProfileDeletion();

  // -----------------------------------------------------------------------------

  /// USER DELETION

  // --------------------
  /// DEPRECATED
  /*
  static Future<void> wipeUserReceivedNotes({
    required String userID,
  }) async {

    blog('NoteProtocol.deleteAllUserReceivedNotes : START');

    await NoteFireOps.deleteAllReceivedNotes(
      receiverID: userID,
      receiverType: PartyType.user,
    );

    blog('NoteProtocol.deleteAllUserReceivedNotes : END');

  }
   */
  // -----------------------------------------------------------------------------

  /// BZ DELETION

  // --------------------
  /// DEPRECATED
  /*
  static Future<void> wipeBzReceivedNotes({
    required String bzID,
  }) async {

    blog('NoteProtocol.deleteAllBzReceivedNotes : START');

    await NoteFireOps.deleteAllReceivedNotes(
      receiverID: bzID,
      receiverType: PartyType.bz,
    );

    blog('NoteProtocol.deleteAllBzReceivedNotes : END');

  }
   */
  // --------------------
  /// DEPRECATED
  /*
  static Future<void> wipeBzSentAuthorshipNotes({
    required String bzID,
  }) async {

    if (bzID != null){

      final List<NoteModel> _notesToDelete = <NoteModel>[];

      /// READ ALL NOTES
      for (int i = 0; i <= 500; i++){
        final List<NoteModel> _notes = await _paginatePendingSentAuthorshipNotes(
          limit: 10,
          senderID: bzID,
          startAfter: _notesToDelete.isNotEmpty == true ? _notesToDelete?.last?.docSnapshot : null,
        );

        if (Lister.checkCanLoop(_notes) == true){
          _notesToDelete.addAll(_notes);
        }

        else {
          break;
        }

      }

      /// DELETE ALL NOTES
      if (Lister.checkCanLoop(_notesToDelete) == true){

        await NoteFireOps.deleteNotes(
          notes: _notesToDelete,
        );

      }

    }

  }
   */
  // --------------------
  /// DEPRECATED
  /*
  static Future<List<NoteModel>> _paginatePendingSentAuthorshipNotes({
    required String senderID,
    required int limit,
    required QueryDocumentSnapshot<Object>? startAfter,
  }) async {

    List<NoteModel> _notes = <NoteModel>[];

    if (senderID != null){

      final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
        collName: FireColl.notes,
        limit: limit,
        addDocSnapshotToEachMap: true,
        addDocsIDs: true,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        startAfter: startAfter,
        finders: _generatePendingSentAuthorshipNotesFireFinder(
          senderID: senderID,
        ),
      );

      if (Lister.checkCanLoop(_maps) == true){

        _notes = NoteModel.decipherNotes(
          maps: _maps,
          fromJSON: false,
        );

      }
    }

    return _notes;
  }
   */
  // --------------------
  /// DEPRECATED
  /*
  static List<FireFinder> _generatePendingSentAuthorshipNotesFireFinder({
    required String senderID,
  }){
    return <FireFinder>[
      FireFinder(
        field: 'senderID',
        comparison: FireComparison.equalTo,
        value: senderID,
      ),
      const FireFinder(
        field: 'poll.reply',
        comparison: FireComparison.equalTo,
        value: PollModel.pending,
      ),
      const FireFinder(
        field: 'seen',
        comparison: FireComparison.equalTo,
        value: false,
      ),
    ];
  }
   */
  // -----------------------------------------------------------------------------
}
