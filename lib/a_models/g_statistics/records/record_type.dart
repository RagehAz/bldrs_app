
enum RecordType {
  session,

  view,

  follow,
  unfollow,

  call,

  save,
  unSave,

  review,

  share,

}
/// => TAMAM
class RecordTyper {
  // -----------------------------------------------------------------------------

  const RecordTyper();

  // -----------------------------------------------------------------------------

  /// RECORD TYPE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherRecordType(RecordType? recordType) {
    switch (recordType) {
      case RecordType.session:        return 'session';
      case RecordType.view:           return 'view';
      case RecordType.follow:         return 'follow';
      case RecordType.unfollow:       return 'unfollow';
      case RecordType.call:           return 'call';
      case RecordType.save:           return 'save';
      case RecordType.unSave:         return 'unSave';
      case RecordType.review:         return 'review';
      case RecordType.share:          return 'share';
      default:return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordType? decipherRecordType(String? type) {
    switch (type) {
      case 'session':         return RecordType.session;
      case 'view':            return RecordType.view;
      case 'follow':          return RecordType.follow;
      case 'unfollow':        return RecordType.unfollow;
      case 'call':            return RecordType.call;
      case 'save':            return RecordType.save;
      case 'unSave':          return RecordType.unSave;
      case 'review':          return RecordType.review;
      case 'share':           return RecordType.share;
      default:return null;
    }
  }
  // -----------------------------------------------------------------------------

}
