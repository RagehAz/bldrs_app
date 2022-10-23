
// -----------------------------------------------------------------------------
/*

WHEN DO WE HAVE NOTIFICATIONS

-- USER RECEIVE
    -> authorship request
    -> my reviews [review received reply - review received agree]

-- USERS RECEIVE AT ONCE
    -> followed bzz flyers [followed bz publish new flyer]
    -> saved flyers [saved flyer updated - saved flyer received new review]
    -> general news


-- AUTHORS (BZ) RECEIVE
    -> bz flyer note : [flyer verification note - flyer update note]
    -> bz team notes : [authorship reply - author role changes - author deletion]
    -> new followers
    -> user-flyer interaction [new flyer share - new flyer save - new flyer review]
    -> general bz related news

    -----> my bz is deleted

 */
// -----------------------------------------------------------------------------
/*
// /// should be re-named and properly handled to become { triggers / function triggers }
// enum NoteType {
//   /// WHEN BZ AUTHOR SENDS INVITATION TO A USER TO BECOME AN AUTHOR OF THE BZ
//   authorship,
//   /// WHEN BLDRS.NET SENDS A USER SOME NEWS
//   notice,
//   /// WHEN FLYER UPDATES ON DB AND NEED TO ACTIVATE [ LOCAL FLYER UPDATE PROTOCOL ]
//   flyerUpdate,
//   /// WHEN A MASTER AUTHOR DELETES BZ, A NOTE IS SENT TO ALL AUTHORS
//   bzDeletion,
// }
 */
// -----------------------------------------------------------------------------
/*
  /// TESTED : WORKS PERFECT
  static String cipherNoteType(NoteType noteType){
    switch(noteType){
      case NoteType.authorship:   return 'authorship';    break;
      case NoteType.notice:       return 'notice';        break;
      case NoteType.flyerUpdate:  return 'flyerUpdate';   break;
      case NoteType.bzDeletion:   return 'bzDeletion';    break;
      default : return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static NoteType decipherNoteType(String noteType){
    switch(noteType){
      case 'authorship':    return NoteType.authorship;   break;
      case 'notice':        return NoteType.notice;       break;
      case 'flyerUpdate':   return NoteType.flyerUpdate;  break;
      case 'bzDeletion':    return NoteType.bzDeletion;   break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static const List<NoteType> noteTypesList = <NoteType>[
    NoteType.notice,
    NoteType.authorship,
    NoteType.flyerUpdate,
    NoteType.bzDeletion,
  ];
   */
// -----------------------------------------------------------------------------
/*
  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> _cipherNotificationField(){
    return <String, dynamic>{
      'notification': <String, dynamic>{
        'title': title,
        'body': body,
      },
      'data': metaData,
    };
  }
    // --------------------
  /// TESTED : WORKS PERFECT
  static String _decipherNotificationField({
    @required dynamic map,
    @required bool titleNotBody,
  }){
    String _field;
    final String _key = titleNotBody == true ? 'title' : 'body';

    if (map != null){

      // title: map['notification']['notification']['title'],

      final dynamic _notification1 = map['notification'];

      dynamic _notification2;
      if (_notification1 != null){
        _notification2 = _notification1['notification'];
      }

      if (_notification2 != null){
        _field = _notification2[_key];
      }

    }

    return _field;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> _decipherNotificationData(dynamic map){
    Map<String, dynamic> _output;

    if (map != null){
      final dynamic _notification = map['notification'];

      if (_notification != null){
        _output = map['data'];
      }

    }
    return _output;
  }


 */
// -----------------------------------------------------------------------------
/*
Future<void> _bzCheckLocalFlyerUpdatesNotesAndProceed({
  @required BuildContext context,
  @required List<NoteModel> newBzNotes,
}) async {

  final List<NoteModel> _flyerUpdatesNotes = NoteModel.getNotesContainingTrigger(
    notes: newBzNotes,
    triggerFunctionName: TriggerProtocols.tridRefetchFlyer,
  );

  if (Mapper.checkCanLoopList(_flyerUpdatesNotes) == true){

    for (int i =0; i < _flyerUpdatesNotes.length; i++){

      final NoteModel note = _flyerUpdatesNotes[i];

      final String _flyerID = note.trigger.argument;

      if (_flyerID != null){

        final FlyerModel flyerModel = await FlyerFireOps.readFlyerOps(
            flyerID: _flyerID
        );

        await FlyerProtocols.updateFlyerLocally(
          context: context,
          flyerModel: flyerModel,
          notifyFlyerPro: (i + 1) == _flyerUpdatesNotes.length,
          resetActiveBz: true,
        );

      }


    }

  }

}
 */
// -----------------------------------------------------------------------------
/*
Future<void> _checkForBzDeletionNoteAndProceed({
  @required BuildContext context,
  @required List<NoteModel> notes,
}) async {

  // blog('_checkForBzDeletionNoteAndProceed : start');

  final UserModel _userModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  if (UserModel.checkUserIsAuthor(_userModel) == true){

    // blog('_checkForBzDeletionNoteAndProceed : user is author');

    final List<NoteModel> _bzDeletionNotes = NoteModel.getNotesContainingTrigger(
      notes: notes,
      triggerFunctionName: TriggerProtocols.tridRemoveBzTracesAfterDeletion,
    );

    if (Mapper.checkCanLoopList(_bzDeletionNotes) == true){

      // blog('_checkForBzDeletionNoteAndProceed : ${_bzDeletionNotes.length} bz deletion notes');

      for (final NoteModel note in _bzDeletionNotes){

        /// in the case of bzDeletion NoteType : trigger argument is bzID
        final String _bzID = note.trigger.argument;

        final bool _bzIDisInMyBzzIDs = Stringer.checkStringsContainString(
          strings: _userModel.myBzzIDs,
          string: _bzID,
        );

        if (_bzIDisInMyBzzIDs == true){
          await AuthorshipProtocols.removeBzTracesAfterDeletion(
            context: context,
            bzID: _bzID,
          );
        }

      }

    }

  }

}
 */
// -----------------------------------------------------------------------------

/// OLD NOTES CONTROLLER METHODS

// --------------------
/// DEPRECATED
/*
/// TESTED : WORKS PERFECT
ValueNotifier<List<Map<String, dynamic>>> _getCipheredProUserUnseenReceivedNotes({
  @required BuildContext context,
}){

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);

  final List<Map<String, dynamic>> _oldNotesMaps = NoteModel.cipherNotesModels(
    notes: _notesProvider.userNotes,
    toJSON: false,
  );

  final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = ValueNotifier(_oldNotesMaps);

  return _oldMaps;
}
 */
// --------------------
/// DEPRECATED
/*
/// TESTED : WORKS PERFECT
ValueNotifier<List<Map<String, dynamic>>> _getCipheredProBzUnseenReceivedNotes ({
  @required BuildContext context,
  @required String bzID,
}){

  final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
  final List<NoteModel> _bzOldNotes = _notesProvider.myBzzNotes[bzID];
  final List<Map<String, dynamic>> _oldNotesMaps = NoteModel.cipherNotesModels(
    notes: _bzOldNotes,
    toJSON: false,
  );
  final ValueNotifier<List<Map<String, dynamic>>> _oldMaps = ValueNotifier(_oldNotesMaps);

  return _oldMaps;
}
 */
// --------------------
/// DEPRECATED
/*
// int _getNotesCount({
//   @required bool thereAreMissingFields,
//   @required List<NoteModel> notes,
// }){
//   int _count;
//
//   if (thereAreMissingFields == false){
//     if (Mapper.checkCanLoopList(notes) == true){
//       _count = NoteModel.getNumberOfUnseenNotes(notes);
//     }
//   }
//
//   return _count;
// }
 */
// -----------------------------------------------------------------------------

/// OLD NOTES PROVIDER METHODS

// --------------------
/*
  // --------------------
  /// GETTING
  // -----
  /// TESTED : WORKS PERFECT
  int _getObeliskNumber({
    @required String navModelID,
  }){

    final MapModel _mapModel = _obeliskBadges.firstWhere(
          (m) => m.key == navModelID,
      orElse: ()=> null,
    );

    return _mapModel?.value;
  }
 */
// -----------------------------------------------------------------------------

/// USER RECEIVED UNSEEN NOTES

// --------------------
/*
  List<NoteModel> _userNotes = <NoteModel>[];
  List<NoteModel> get userNotes => _userNotes;
   */
// --------------------
/*
  static List<NoteModel> proGetUserUnseenNotes({
    @required BuildContext context,
    @required bool listen,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: listen);
    return _notesProvider.userNotes;
  }
   */
// --------------------
/*
  void updateNoteInUserNotes({
    @required NoteModel note,
    @required bool notify,
  }){

    _userNotes = NoteModel.replaceNoteInNotes(
        notes: _userNotes,
        noteToReplace: note
    );

    if (notify == true){
      notifyListeners();
    }

  }
   */
// --------------------
/*
  void deleteNoteInUserNotes({
    @required String noteID,
    @required bool notify,
  }){

    _userNotes = NoteModel.removeNoteFromNotes(
      notes: _userNotes,
      noteID: noteID,
    );

    if (notify == true){
      notifyListeners();
    }

  }
   */
// --------------------
/*
  void wipeUserNotes({
    @required bool notify
  }){
    _userNotes = <NoteModel>[];

    if (notify == true){
      notifyListeners();
    }

  }
   */
// -----------------------------------------------------------------------------
/*
    /// ALL BZZ RECEIVED UNSEEN NOTES

    // --------------------
    /// only the received notes
    Map<String, List<NoteModel>> _myBzzNotes = {}; // {bzID : <NoteModel>[Note, Note, Note..]}
    Map<String, List<NoteModel>> get myBzzNotes => _myBzzNotes;
   */
// --------------------
/*
  void removeNotesFromBzzNotes({
    @required List<NoteModel> notes,
    @required String bzID,
    @required bool notify,
  }){

    if (Mapper.checkCanLoopList(notes) == true){

      final List<NoteModel> _updatedNotes = NoteModel.removeNotesFromNotes(
        notesToRemove: notes,
        sourceNotes: _myBzzNotes[bzID],
      );

      _myBzzNotes[bzID] = _updatedNotes;

      if (notify == true){
        notifyListeners();
      }

    }

  }
   */
// --------------------
/*
  static void proRemoveNotesFromBzzNotes({
    @required BuildContext context,
    @required List<NoteModel> notes,
    @required String bzID,
    @required bool notify,
  }){
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    _notesProvider.removeNotesFromBzzNotes(
      bzID: bzID,
      notify: notify,
      notes: notes,
    );
  }
   */
// --------------------
/*
  void removeAllNotesOfThisBzFromAllBzzNotes({
    @required String bzID,
    @required bool notify,
  }){

    _myBzzNotes.remove(bzID);

    if (notify == true){
      notifyListeners();
    }

  }
   */
// --------------------
/*
  void updateNoteInMyBzzNotes({
    @required NoteModel note,
    @required bool notify,
  }){

    _myBzzNotes = NoteModel.updateNoteInBzzNotesMap(
      note: note,
      bzzNotesMap: _myBzzNotes,
    );

    if (notify == true){
      notifyListeners();
    }

  }
       */
// --------------------
/*
  void deleteNoteInBzzNotes({
    @required String noteID,
    @required bool notify,
  }){

    _myBzzNotes = NoteModel.removeNoteFromBzzNotesMap(
      bzzNotesMap: _myBzzNotes,
      noteID: noteID,
    );

    if (notify == true){
      notifyListeners();
    }

  }
   */
// --------------------
/*
  void wipeAllBzzNotes({
    @required bool notify,
  }){

    _myBzzNotes = {};

    if (notify == true){
      notifyListeners();
    }

  }
   */
// --------------------
/*
  static void proUpdateNoteEverywhereIfExists({
    @required BuildContext context,
    @required NoteModel noteModel,
    @required bool notify,
  }){

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);

    _notesProvider.updateNoteInUserNotes(
      note: noteModel,
      notify: false,
    );

    _notesProvider.updateNoteInMyBzzNotes(
        note: noteModel,
        notify: notify
    );

  }
   */
// --------------------
/*
  static void proDeleteNoteEverywhereIfExists({
    @required BuildContext context,
    @required String noteID,
    @required bool notify,
  }){

    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);

    // _notesProvider.deleteNoteInUserNotes(
    //   noteID: noteID,
    //   notify: false,
    // );

    // _notesProvider.deleteNoteInBzzNotes(
    //     noteID: noteID,
    //     notify: notify
    // );

  }
   */
// -----------------------------------------------------------------------------

/// VALIDATION

// --------------------
/*
  static String receiverVsNoteTypeValidator({
    @required NoteSenderOrRecieverType receiverType,
    @required NoteType noteType,
  }){

    if (receiverType == NoteSenderOrRecieverType.user){
      switch (noteType){
        case NoteType.notice        : return null; break; /// user can receive notice
        case NoteType.authorship    : return null; break; /// only user receive authorship
        case NoteType.bzDeletion    : return null; break; /// only user receive bzDeletion
        case NoteType.flyerUpdate   : return 'User does not receive flyer update note'; break;
        default: return null;
      }
    }
    else if (receiverType == NoteSenderOrRecieverType.bz){
      switch (noteType){
        case NoteType.notice  : return null; break; /// bz can receive notice
        case NoteType.authorship    : return 'Only User receive authorship note'; break;
        case NoteType.bzDeletion    : return 'Only user can receive bzDeletion note'; break;
        case NoteType.flyerUpdate   : return null; break; /// bz can receive flyerUpdate
        default: return null;
      }
    }
    else {
      return 'Receiver can only be a user or a bz';
    }

  }
   */
// --------------------
/*
  static String senderVsNoteTypeValidator({
    @required NoteSenderOrRecieverType senderType,
    @required NoteType noteType,
  }){

    /// USER
    if (senderType == NoteSenderOrRecieverType.user){
      switch (noteType){
        case NoteType.notice        : return null; break; /// user can send notice
        case NoteType.authorship    : return 'Only Bz can send Authorship note'; break;
        case NoteType.bzDeletion    : return 'Only Bldrs can send bzDeletion notes'; break;
        case NoteType.flyerUpdate   : return 'User can not send flyerUpdate note'; break;
        default: return null;
      }
    }

    /// BZ
    else if (senderType == NoteSenderOrRecieverType.bz){
      switch (noteType){
        case NoteType.notice        : return null; break; /// bz can send notice
        case NoteType.authorship    : return null; break; /// only bz send authorship
        case NoteType.bzDeletion    : return 'Only Bldrs can send bzDeletion notes'; break;
        case NoteType.flyerUpdate   : return null; break; /// bz can send flyerUpdate note
        default: return null;
      }
    }

    /// BLDRS
    else if (senderType == NoteSenderOrRecieverType.bldrs){
      switch (noteType){
        case NoteType.notice        : return null; break; /// Bldrs can send notice
        case NoteType.authorship    : return 'Only Bz can send Authorship note'; break;
        case NoteType.bzDeletion    : return null; break; /// only Bldrs send bzDeletion
        case NoteType.flyerUpdate   : return null; break; /// Bldrs can send flyerUpdate note
        default: return null;
      }
    }

    /// COUNTRY
    else if (senderType == NoteSenderOrRecieverType.country){
      switch (noteType){
        case NoteType.notice        : return null; break; /// Country can send notice
        case NoteType.authorship    : return 'Only Bz can send Authorship note'; break;
        case NoteType.bzDeletion    : return 'Only Bldrs can send bzDeletion notes'; break;
        case NoteType.flyerUpdate   : return 'Country can not send FlyerUpdate note'; break;
        default: return null;
      }
    }

    /// OTHERWISE
    else {
      return 'Sender can not be null';
    }

  }
   */
// -----------------------------------------------------------------------------

/// PAGINATOR METHODS

// --------------------
/// DEPRECATED
/*
  List<NoteModel> _combinePaginatorMapsWithProviderNotes({
    @required List<Map<String, dynamic>> paginatedMaps,
    @required List<NoteModel> providerNotes,
  }){


    /// DECIPHER STREAM MAPS
    final List<NoteModel> _paginatedNotes = NoteModel.decipherNotes(
      maps: paginatedMaps,
      fromJSON: false,
    );

    /// COMBINE NOTES FROM PAGINATOR + NOTES FROM PROVIDER
    final List<NoteModel> _combined = NoteModel.insertNotesInNotes(
        notesToGet: <NoteModel>[],
        notesToInsert: <NoteModel>[...providerNotes, ..._paginatedNotes],
        duplicatesAlgorithm: DuplicatesAlgorithm.keepFirst
    );

    blog('_combinePaginatorMapsWithProviderNotes : combining shit : (${providerNotes.length} pro notes) + (${paginatedMaps.length}) pagi notes = ${_combined.length} combined notes');


    final List<NoteModel> _ordered = NoteModel.orderNotesBySentTime(_combined);

    return _ordered;
  }
   */
// --------------------
/// DEPRECATED
/*
    // return Selector<NotesProvider, List<NoteModel>>(
    //     key: const ValueKey<String>('UserNotesPage'),
    //     selector: (_, NotesProvider notesProvider) => notesProvider.userNotes,
    //     shouldRebuild: (before, after) => true,
    //     builder: (_,List<NoteModel> _proNotes, Widget child){
    //
    //       blog('user pro notes rebuilds ${_proNotes.length} notes');
    //
    //       /// ADD USER UNSEEN NOTES TO LOCAL NOTES TO MARK SEEN
    //       _localNotesToMarkUnseen = NoteModel.insertNotesInNotes(
    //         notesToGet: _localNotesToMarkUnseen,
    //         notesToInsert: _proNotes,
    //         duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
    //       );
    //
    //       return FireCollPaginator(
    //           scrollController: _scrollController,
    //           queryModel: getUserNotesPaginationQueryModel(
    //               onDataChanged: _onPaginatorDataChanged
    //           ),
    //           builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){
    //
    //             blog('FireCollPaginator : rebuilding with ${maps.length} map');
    //
    //             /// COMBINE NOTES FROM STREAM + NOTES FROM PROVIDER
    //             final List<NoteModel> _combined = _combinePaginatorMapsWithProviderNotes(
    //               paginatedMaps: maps,
    //               providerNotes: _proNotes,
    //             );
    //
    //             return ListView.builder(
    //               physics: const BouncingScrollPhysics(),
    //               controller: _scrollController,
    //               itemCount: _combined?.length,
    //               padding: Stratosphere.stratosphereSandwich,
    //               itemBuilder: (BuildContext ctx, int index) {
    //
    //                 final NoteModel _notiModel = Mapper.checkCanLoopList(_combined) == true ?
    //                 _combined[index]
    //                     :
    //                 null;
    //
    //                 return NoteCard(
    //                   key: PageStorageKey<String>('user_note_card_${_notiModel.id}'),
    //                   noteModel: _notiModel,
    //                   isDraftNote: false,
    //                 );
    //
    //               },
    //             );
    //
    //           }
    //       );
    //
    //     });

 */
// --------------------
/// DEPRECATED
/*
  void _onProviderDataChanged({
    @required List<NoteModel> bzNotes,
  }){

    /// ADD THIS BZ UNSEEN PROVIDER NOTES TO LOCAL NOTES TO MARK SEEN
    _localNotesToMarkUnseen = NoteModel.insertNotesInNotes(
      notesToGet: _localNotesToMarkUnseen,
      notesToInsert: bzNotes,
      duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
    );

  }
   */
// --------------------
/// DEPRECATED
/*
  List<NoteModel> _combinePaginatorMapsWithProviderNotes({
    @required List<Map<String, dynamic>> paginatedMaps,
    @required List<NoteModel> providerNotes,
  }){

    /// DECIPHER STREAM MAPS
    final List<NoteModel> _paginatedNotes = NoteModel.decipherNotes(
      maps: paginatedMaps,
      fromJSON: false,
    );

    /// COMBINE NOTES FROM PAGINATOR + NOTES FROM PROVIDER
    final List<NoteModel> _combined = NoteModel.insertNotesInNotes(
        notesToGet: <NoteModel>[],
        notesToInsert: <NoteModel>[...providerNotes, ..._paginatedNotes],
        duplicatesAlgorithm: DuplicatesAlgorithm.keepFirst
    );

    final List<NoteModel> _ordered = NoteModel.orderNotesBySentTime(_combined);

    return _ordered;
  }
   */
// --------------------
/// DEPRECATED
/*
    // return Selector<NotesProvider, List<NoteModel>>(
    //     key: const ValueKey<String>('BzNotesPage'),
    //     selector: (_, NotesProvider notesProvider){
    //
    //       final Map<String, List<NoteModel>> _map = notesProvider.myBzzNotes;
    //
    //       final List<NoteModel> _bzNotes = _map[_bzModel.id];
    //
    //       _onProviderDataChanged(
    //         bzNotes: _bzNotes,
    //       );
    //
    //       return _bzNotes;
    //     },
    //     shouldRebuild: (before, after) => true,
    //     builder: (_,List<NoteModel> _providerNotes, Widget child){
    //
    //       return FireCollPaginator(
    //           scrollController: _scrollController,
    //           queryModel: bzNotesPaginationQueryModel(
    //             bzID: _bzModel.id,
    //             onDataChanged: _onPaginatorDataChanged,
    //           ),
    //           builder: (_, List<Map<String, dynamic>> maps, bool isLoading, Widget child){
    //
    //             /// COMBINE NOTES FROM PAGINATOR + NOTES FROM PROVIDER
    //             final List<NoteModel> _combined = _combinePaginatorMapsWithProviderNotes(
    //               providerNotes: _providerNotes ?? [],
    //               paginatedMaps: maps,
    //             );
    //
    //             return ListView.builder(
    //               physics: const BouncingScrollPhysics(),
    //               controller: _scrollController,
    //               itemCount: _combined?.length,
    //               padding: Stratosphere.stratosphereSandwich,
    //               itemBuilder: (BuildContext ctx, int index) {
    //
    //                 final NoteModel _notiModel = Mapper.checkCanLoopList(_combined) == true ?
    //                 _combined[index]
    //                     :
    //                 null;
    //
    //                 return NoteCard(
    //                   key: PageStorageKey<String>('bz_note_card_${_notiModel.id}'),
    //                   noteModel: _notiModel,
    //                   isDraftNote: false,
    //                 );
    //
    //               },
    //             );
    //
    //           }
    //       );
    //
    //     });

    // return FireCollPaginator(
    //     queryParameters: BzModel.allReceivedBzNotesQueryParameters(
    //       bzModel: _bzModel,
    //       context: context,
    //     ),
    //     scrollController: _controller,
    //     builder: (_, List<Map<String, dynamic>> maps, bool isLoading){
    //
    //       final List<NoteModel> _notes = NoteModel.decipherNotesModels(
    //         maps: maps,
    //         fromJSON: false,
    //       );
    //
    //       return ListView.builder(
    //         physics: const BouncingScrollPhysics(),
    //         controller: _controller,
    //         itemCount: _notes.length,
    //         padding: Stratosphere.stratosphereSandwich,
    //         itemBuilder: (_, int index){
    //
    //           final NoteModel _note = _notes[index];
    //
    //           return NoteCard(
    //             noteModel: _note,
    //             isDraftNote: false,
    //             // onNoteOptionsTap: null,
    //             // onCardTap: null,
    //           );
    //
    //         },
    //       );
    //
    //     }
    // );

 */
// -----------------------------------------------------------------------------

/// NOTE FIRE METHODS

// -----------------------------------------------------------------------------

/// ALL NOTES PAGINATION

// --------------------
/*
  static Future<List<NoteModel>> readReceivedNotes({
    @required String recieverID,
    @required PartyType receiverType,
    int limit = 10,
    QueryDocumentSnapshot<Object> startAfter,
    QueryOrderBy orderBy,
  }) async {

    final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
      collName: FireColl.notes,
      limit: limit,
      addDocsIDs: true,
      orderBy: orderBy,
      startAfter: startAfter,
      addDocSnapshotToEachMap: true,
      finders: <FireFinder>[

        FireFinder(
          field: 'receiverID',
          comparison: FireComparison.equalTo,
          value: recieverID,
        ),

        FireFinder(
          field: 'receiverType',
          comparison: FireComparison.equalTo,
          value: NoteParties.cipherPartyType(receiverType),
        ),

      ],
    );

    final List<NoteModel> _notes = NoteModel.decipherNotes(
      maps: _maps,
      fromJSON: false,
    );

    return _notes;
  }
   */
// --------------------
/// DEPRECATED
/*
  static Future<List<NoteModel>> paginateAllSentNotes({
    @required String senderID,
    @required int limit,
    @required QueryDocumentSnapshot<Object> startAfter,
  }) async {

    List<NoteModel> _notes = <NoteModel>[];

    if (senderID != null){

      final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
        collName: FireColl.notes,
        // startAfter: startAfter,
        // orderBy: 'sentTime',
        addDocsIDs: true,
        addDocSnapshotToEachMap: true,
        // limit: limit,
        finders: <FireFinder>[
          FireFinder(
            field: 'senderID',
            comparison: FireComparison.equalTo,
            value: senderID,
          ),
        ],
      );

      Mapper.blogMaps(_maps, methodName: 'paginateAllSentNotes');

      if (Mapper.checkCanLoopList(_maps) == true){

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
  static Future<List<NoteModel>> paginateAllReceivedNotes({
    @required String recieverID,
    @required int limit,
    @required QueryDocumentSnapshot<Object> startAfter,
  }) async {

    List<NoteModel> _notes = <NoteModel>[];

    if (recieverID != null){

      final List<Map<String, dynamic>> _maps = await Fire.readCollectionDocs(
        collName: FireColl.notes,
        startAfter: startAfter,
        orderBy: const QueryOrderBy(fieldName: 'sentTime', descending: true),
        addDocsIDs: true,
        addDocSnapshotToEachMap: true,
        limit: limit,
        finders: <FireFinder>[
          FireFinder(
            field: 'recieverID',
            comparison: FireComparison.equalTo,
            value: recieverID,
          ),
        ],
      );

      if (Mapper.checkCanLoopList(_maps) == true){

        _notes = NoteModel.decipherNotes(
          maps: _maps,
          fromJSON: false,
        );

      }

    }

    return _notes;
  }
   */
// -----------------------------------------------------------------------------

/// STREAMING

// --------------------
/// DEPRECATED
/*
  static Stream<List<NoteModel>> getNoteModelsStream({
    QueryDocumentSnapshot<Object> startAfter,
    int limit,
    QueryOrderBy orderBy,
    List<FireFinder> finders,
  }) {

    Stream<List<NoteModel>> _notiModelsStream;

    tryAndCatch(
        methodName: 'getNoteModelsStream',
        functions: () {

          final Stream<QuerySnapshot<Object>> _querySnapshots = Fire.streamCollection(
            queryModel: FireQueryModel(
                collRef: Fire.getSuperCollRef(aCollName: FireColl.notes),
                startAfter: startAfter,
                limit: limit,
                orderBy: orderBy,
                finders: finders,
                onDataChanged: (List<Map<String, dynamic>> maps){
                  blog('getNoteModelsStream : onDataChanged : ${maps.length} maps');
                }
            ),
          );

          blog('x getNotiModelsStream : _querySnapshots : $_querySnapshots : id : ${_querySnapshots.first}');

          _notiModelsStream = _querySnapshots.map((QuerySnapshot<Object> querySnapshot){

            final List<Map<String, dynamic>> _maps = Mapper.getMapsFromQueryDocumentSnapshotsList(
              queryDocumentSnapshots: querySnapshot.docs,
              addDocsIDs: true,
              addDocSnapshotToEachMap: true,
            );

            final List<NoteModel> _notes = NoteModel.decipherNotes(
                maps: _maps,
                fromJSON: false
            );

            return _notes;
          });

          blog('getNotiModelsStream : _notiModelsStream : $_notiModelsStream');
        });

    return _notiModelsStream;
  }
   */
// -----------------------------------------------------------------------------
/*
///
// static Future<void> deleteAllReceivedNotes({
//   @required String receiverID,
//   @required PartyType receiverType,
// }) async {
//
//   /// TASK : VERY DANGEROUS : SHOULD BE BY A CLOUD FUNCTION
//
//   final List<NoteModel> _notesToDelete = <NoteModel>[];
//
//   /// READ ALL NOTES
//   for (int i = 0; i <= 500; i++){
//     final List<NoteModel> _notes = await readReceivedNotes(
//       // limit: 10,
//       receiverType: receiverType,
//       recieverID: receiverID,
//       startAfter: _notesToDelete.isNotEmpty == true ? _notesToDelete?.last?.docSnapshot : null,
//     );
//
//     if (Mapper.checkCanLoopList(_notes) == true){
//       _notesToDelete.addAll(_notes);
//     }
//
//     else {
//       break;
//     }
//
//   }
//
//   /// DELETE ALL NOTES
//   if (Mapper.checkCanLoopList(_notesToDelete) == true){
//
//     await deleteNotes(
//       notes: _notesToDelete,
//     );
//
//   }
//
// }
*/
// -----------------------------------------------------------------------------
/*
StreamSubscription _sub;
Stream<QuerySnapshot<Object>> _unseenNotesStream;
void _streamNewNotes(){
  // final UserModel _userModel = UsersProvider.proGetMyUserModel(
  //     context: context,
  //     listen: false,
  // );
  //
  // if (_userModel != null){
  //
  //   _unseenNotesStream = userUnseenNotesStream(
  //       context: context
  //   );
  //
  //   _sub = FireCollStreamer.onStreamDataChanged(
  //     stream: _unseenNotesStream,
  //     // oldMaps: _oldMaps,
  //     invoker: 'streamNewNotes',
  //     onChange: (List<Map<String, dynamic>> unseenNotesMaps) async {
  //
  //       // blog('listenToUserUnseenNotes.onStreamDataChanged : unseenNotesMaps are ${unseenNotesMaps.length} maps');
  //       // Mapper.blogMaps(allUpdatedMaps, methodName: 'initializeUserNotes');
  //
  //       injectPaginatorWithNewNotes(
  //         unseenNotesMaps: unseenNotesMaps,
  //       );
  //
  //       _collectUnseenNotesToMarkAtDispose(
  //         unseenNotesMaps: unseenNotesMaps,
  //       );
  //
  //       setState(() {});
  //
  //     },
  //   );
  //
  // }

}
 */
// -----------------------------------------------------------------------------
/*
void _injectPaginatorWithNewNotes({
  @required List<Map<String, dynamic>> unseenNotesMaps,
}){

  if (Mapper.checkCanLoopList(unseenNotesMaps) == true){

    final bool _noteExists = Mapper.checkMapsContainValue(
      listOfMaps: _paginationController.paginatorMaps.value,
      field: 'id',
      value: unseenNotesMaps?.first['id'],
    );

    /// NOTE IS NOT IN LIST : ADD IT
    if (_noteExists == false){
      _paginationController.addMap.value = unseenNotesMaps.first;
    }

    /// NOTE EXISTS : UPDATE IT
    else {

      final List<NoteModel> _paginatorNotes = NoteModel.insertNotesInNotes(
        notesToGet: NoteModel.decipherNotes(maps: _paginationController.paginatorMaps.value, fromJSON: false),
        notesToInsert: NoteModel.decipherNotes(maps: unseenNotesMaps, fromJSON: false),
        duplicatesAlgorithm: DuplicatesAlgorithm.keepSecond,
      );

      _paginationController.paginatorMaps.value = NoteModel.cipherNotesModels(
        notes: _paginatorNotes,
        toJSON: false,
      );

    }

  }

}

 */
// -----------------------------------------------------------------------------
