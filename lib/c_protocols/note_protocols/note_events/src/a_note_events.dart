part of note_events;
/// => TAMAM
class NoteEvent {
  // -----------------------------------------------------------------------------

  const NoteEvent();

  // -----------------------------------------------------------------------------

  /// AUTHORSHIP REQUESTS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendAuthorshipInvitationNote = _NoteEventsOfAuthorship.sendAuthorshipInvitationNote;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendAuthorshipCancellationNote = _NoteEventsOfAuthorship.sendAuthorshipCancellationNote;
  // -----------------------------------------------------------------------------

  /// AUTHORSHIP RESPONSES

  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendAuthorshipAcceptanceNote = _NoteEventsOfAuthorship.sendAuthorshipAcceptanceNote;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendAuthorshipDeclinationsNote = _NoteEventsOfAuthorship.sendAuthorshipDeclinationsNote;
  // -----------------------------------------------------------------------------

  /// Bz Team Management

  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendAuthorRoleChangeNote = _NoteEventsOfBzTeamManagement.sendAuthorRoleChangeNote;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendAuthorDeletionNotes = _NoteEventsOfBzTeamManagement.sendAuthorDeletionNotes;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendBzDeletionNoteToAllAuthors = _NoteEventsOfBzTeamManagement.sendBzDeletionNoteToAllAuthors;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const  sendNoBzContactAvailableNote = _NoteEventsOfBzTeamManagement.sendNoBzContactAvailableNote;
  // -----------------------------------------------------------------------------

  /// Bz Flyers Management

  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendFlyerUpdateNoteToItsBz = _NoteEventsOfBzFlyersManagement.sendFlyerUpdateNoteToItsBz;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendFlyerIsVerifiedNoteToBz = _NoteEventsOfBzFlyersManagement.sendFlyerIsVerifiedNoteToBz;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendBzIsVerifiedNote = _NoteEventsOfBzFlyersManagement.sendBzIsVerifiedNote;
  // -----------------------------------------------------------------------------

  /// FLYER INTERACTIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendFlyerReceivedNewReviewByMe = _NoteEventsOfFlyerInteractions.sendFlyerReceivedNewReviewByMe;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const sendFlyerReviewReceivedBzReply = _NoteEventsOfFlyerInteractions.sendFlyerReviewReceivedBzReply;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const onUserFollowedBz = _NoteEventsOfFlyerInteractions.onUserFollowedBz;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const onUserSavedFlyer = _NoteEventsOfFlyerInteractions.onUserSavedFlyer;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const onUserSharedFlyer = _NoteEventsOfFlyerInteractions.onUserSharedFlyer;
  // -----------------------------------------------------------------------------

  /// ( ADMIN ) NEW USERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const onCreateAnonymousUser = _AdminListeners.onCreateAnonymousUser;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const onUserSignUp = _AdminListeners.onUserSignUp;
  // -----------------------------------------------------------------------------

  /// ( ADMIN ) NEW BZ

  // --------------------
  /// TESTED : WORKS PERFECT
  static const onNewBz = _AdminListeners.onBzCreated;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const onNewFlyer = _AdminListeners.onFlyerCreated;
  // -----------------------------------------------------------------------------
}
