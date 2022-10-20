
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
