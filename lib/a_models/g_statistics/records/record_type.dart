import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';

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

enum ModelType{
  flyer,
  bz,
  user,
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

  /// MODEL TYPE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherModelType(ModelType? modelType){
    switch (modelType){
      case ModelType.flyer:     return 'flyer';
      case ModelType.bz:        return 'bz';
      case ModelType.user:      return 'user';
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ModelType? decipherModelType(String? modelType){
    switch (modelType){
      case 'flyer':     return ModelType.flyer;
      case 'bz':        return ModelType.bz;
      case 'user':      return ModelType.user;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ModelType? getModelTypeByRecordType(RecordType? recordType){

    switch(recordType){
      case RecordType.session         : return null;
      case RecordType.review          : return ModelType.flyer;
      case RecordType.follow          : return ModelType.bz;
      case RecordType.unfollow        : return ModelType.bz;
      case RecordType.call            : return ModelType.bz;
      case RecordType.share           : return ModelType.flyer;
      case RecordType.view            : return ModelType.flyer;
      case RecordType.save            : return ModelType.flyer;
      case RecordType.unSave          : return ModelType.flyer;
      default: return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getIconByModelType(ModelType? modelType){

    switch(modelType){
      case ModelType.flyer: return Iconz.flyer;
      case ModelType.bz: return Iconz.bz;
      case ModelType.user: return Iconz.normalUser;
      default: return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse getVerseByModelType(ModelType? modelType){
    String? _text;

    if (modelType != null){
      switch(modelType){
        case ModelType.flyer:     _text = 'phid_flyers'; break;
        case ModelType.bz:        _text = 'phid_bzz'; break;
        case ModelType.user:      _text = 'phid_users'; break;
      }
    }

    return Verse(
      id: _text,
      translate: true,
    );
  }
  // // -----------------------------------------------------------------------------

}
