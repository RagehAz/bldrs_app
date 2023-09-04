import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:bldrs/a_models/x_secondary/bldrs_model_type.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/time/timers.dart';
xxx
enum RecordTypeX {
  session,
  review,
  follow,
  unfollow,
  call,
  share,
  view,
  save,
  unSave,
}

enum RecordDetailsType{
  slideIndex,
  text,
  contact,
}

/// => TAMAM
@immutable
class RecordX {
  /// --------------------------------------------------------------------------
  const RecordX({
    required this.recordType,
    required this.userID,
    required this.timeStamp,
    required this.modelType,
    required this.bzID,
    required this.flyerID,
    required this.recordDetailsType,
    required this.recordDetails,
    this.recordID,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final RecordType? recordType;
  final String? userID;
  final String? recordID;
  final DateTime? timeStamp;
  final ModelType? modelType;
  final String? bzID;
  final String? flyerID;
  final RecordDetailsType? recordDetailsType;
  final dynamic recordDetails;
  final DocumentSnapshot<Object>? docSnapshot;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// DEPRECATED
  Map<String, dynamic> toMap({
    required bool toJSON,
  }) {

    final Map<String, dynamic> _map = <String, dynamic>{
      'recordType' : RecordTyper.cipherRecordType(recordType),
      'userID' : userID,
      // 'recordID' : recordID,
      'timeStamp' : Timers.cipherTime(time: timeStamp, toJSON: toJSON),
      'modelType' : cipherModelType(modelType),
      'recordDetailsType' : _cipherRecordDetailsType(recordDetailsType),
      'recordDetails' : recordDetails,
      // 'serverTimeStamp' : serverTimeStamp,
      // 'docSnapshot' : docSnapshot,
    };

    return  Mapper.cleanNullPairs(
        map: _map,
    )!;

  }
  // --------------------
  /// DEPRECATED
  static RecordX? decipherRecord({
    required Map<String, dynamic>? map,
    required String? bzID,
    required String? flyerID,
    required bool fromJSON,
  }) {
    RecordX? _record;

    if (map != null) {

      _record = RecordX(
        recordType: RecordTyper.decipherRecordType(map['recordType']),
        userID: map['userID'],
        recordID: map['id'],
        timeStamp: Timers.decipherTime(
          time: map['timeStamp'],
          fromJSON: fromJSON,
        ),
        modelType: decipherModelType(map['modelType']),
        recordDetailsType: _decipherRecordDetailsType(map['recordDetailsType']),
        recordDetails: map['recordDetails'],
        bzID: bzID,
        flyerID: flyerID,
        // docSnapshot: map['docSnapshot'],
      );

    }

    return _record;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherRecords({
    required List<RecordX> records,
    required bool toJSON,
  }) {

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.checkCanLoopList(records)){

      for (final RecordX record in records){

        final Map<String, dynamic> _map = record.toMap(toJSON: toJSON);
        _maps.add(_map);

      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<RecordX> decipherRecords({
    required List<Map<String, dynamic>> maps,
    required String bzID,
    required String flyerID,
    required bool fromJSON,
  }){
    final List<RecordX> _records = <RecordX>[];

    if (Mapper.checkCanLoopList(maps)){

      for (final Map<String, dynamic> map in maps){

        final RecordX? _record = decipherRecord(
          map: map,
          bzID: bzID,
          flyerID: flyerID,
          fromJSON: fromJSON,
        );

        if (_record != null){
          _records.add(_record);
        }

      }

    }

    return _records;
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
  static ModelType? getModelTypeByRecordType(RecordTypeX? recordType){

    switch(recordType){
      case RecordTypeX.session         : return null;
      case RecordTypeX.review          : return ModelType.flyer;
      case RecordTypeX.follow          : return ModelType.bz;
      case RecordTypeX.unfollow        : return ModelType.bz;
      case RecordTypeX.call            : return ModelType.bz;
      case RecordTypeX.share           : return ModelType.flyer;
      case RecordTypeX.view            : return ModelType.flyer;
      case RecordTypeX.save            : return ModelType.flyer;
      case RecordTypeX.unSave          : return ModelType.flyer;
      default: return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// RECORD DETAILS CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String? _cipherRecordDetailsType(RecordDetailsType? recordDetailsType){
    switch (recordDetailsType){
      case RecordDetailsType.slideIndex:          return 'slideIndex';
      case RecordDetailsType.text:                return 'text';
      case RecordDetailsType.contact:             return 'contact';
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordDetailsType? _decipherRecordDetailsType(String? recordDetailsType){
    switch (recordDetailsType){
      case 'slideIndex':  return RecordDetailsType.slideIndex;
      case 'text':        return RecordDetailsType.text;
      case 'contact':     return RecordDetailsType.contact;
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<RecordX> insertRecordToRecords({
    required List<RecordX>? records,
    required RecordX? record,
  }){

    final List<RecordX> _output = <RecordX>[...?records];

    if (Mapper.checkCanLoopList(records) == true){

      final bool _recordsContainRecord = recordsContainRecord(
        records: _output,
        record: record,
      );

      if (_recordsContainRecord == false && record != null){
        _output.add(record);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<RecordX> insertRecordsToRecords({
    required List<RecordX> originalRecords,
    required List<RecordX> addRecords,
  }){

    List<RecordX> _output = <RecordX>[];

    if (Mapper.checkCanLoopList(addRecords)){

      for (final RecordX record in addRecords){
        _output = insertRecordToRecords(
            records: originalRecords,
            record: record,
        );
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<RecordX> cleanDuplicateUsers({
    required List<RecordX> records,
  }){
    final List<RecordX> _output = <RecordX>[];

    if (Mapper.checkCanLoopList(records) == true){

      for (final RecordX rec in records){

        final bool _contains = recordsContainUserID(
            records: _output,
            userID: rec.userID,
        );

        if (_contains == false){
          _output.add(rec);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool recordsContainRecord({
    required List<RecordX>? records,
    required RecordX? record,
  }){

    bool _contains = false;

    if (Mapper.checkCanLoopList(records) == true && record != null){

      for (final RecordX rec in records!){

        if (rec.recordID == record.recordID){
          _contains = true;
          break;
        }

      }

    }

    return _contains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool recordsContainUserID({
    required List<RecordX>? records,
    required String? userID,
  }){
    bool _includes = false;

    if (Mapper.checkCanLoopList(records) == true){

      final int? _index = records?.indexWhere((element) => element.userID == userID);

      if (_index == null || _index == -1){
        _includes = false;
      }
      else {
        _includes = true;
      }

    }

    return _includes;
  }
  // -----------------------------------------------------------------------------

  /// USER RECORD CREATORS

  // --------------------
  /// DEPRECATED
  /*
  static RecordX generatorsSessionRecord({
    required String userID,
  }){

    return RecordX(
        recordType: RecordType.session,
        userID: userID,
        timeStamp: DateTime.now(),
        modelType: null,
        bzID: null,
        flyerID: null,
        recordDetailsType: null,
        recordDetails: null,
    );

  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordX createReviewRecord({
    required String userID,
    required String flyerID,
  }){

      return RecordX(
          recordType: RecordType.review,
          userID: userID,
          timeStamp: DateTime.now(),
          modelType: getModelTypeByRecordType(RecordTypeX.review),
          bzID: null,
          flyerID: flyerID,
          recordDetailsType: RecordDetailsType.text,
          recordDetails: 'flyerID:$flyerID',
      );
  }
  // -----------------------------------------------------------------------------

  /// BZ RECORD CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordX createFollowRecord({
    required String userID,
    required String bzID,
  }){

    return RecordX(
      recordID: '${bzID}_$userID',
      recordType: RecordType.follow,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordTypeX.follow),
      bzID: bzID,
      flyerID: null,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordX createUnfollowRecord({
    required String userID,
    required String bzID,
  }){

    return RecordX(
      recordID: '${bzID}_$userID',
      recordType: RecordType.unfollow,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordTypeX.unfollow),
      bzID: bzID,
      flyerID: null,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordX createCallRecord({
    required String userID,
    required String bzID,
    required ContactModel contact,
  }){

    return RecordX(
      // recordID: '${bzID}_$userID', // NO MAKE A RECORD FOR EACH CALL
      recordType: RecordType.call,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordTypeX.call),
      bzID: bzID,
      flyerID: null,
      recordDetailsType: RecordDetailsType.contact,
      recordDetails: contact.value,
    );

  }
  // -----------------------------------------------------------------------------

  /// FLYER RECORD CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordX createShareRecord({
    required String userID,
    required String flyerID,
    required String bzID,
  }){

    return RecordX(
      // recordID: '${flyerID}_$userID', // MAKE A RECORD FOR EACH SHARE : LEAVE IT NULL
      recordType: RecordType.share,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordTypeX.share),
      bzID: bzID,
      flyerID: flyerID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordX createViewRecord({
    required String userID,
    required String flyerID,
    required String bzID,
    // required int durationSeconds,
    required int slideIndex,
  }){

    return RecordX(
      recordID: '${flyerID}_${slideIndex}_$userID',
      recordType: RecordType.view,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordTypeX.view),
      bzID: bzID,
      flyerID: flyerID,
      recordDetailsType: RecordDetailsType.slideIndex,
      recordDetails: slideIndex,
      // recordDetails: createIndexAndDurationString(
      //   index: slideIndex,
      //   durationSeconds: durationSeconds,
      // ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String createIndexAndDurationString({
    required int index,
    required int durationSeconds,
  }){

    final String? _index = Numeric.formatNumberWithinDigits(
      num: index,
      digits: 3,
    );

    return '${_index}_$durationSeconds';

  }
  // --------------------
  /*
  static int getIndexFromIndexDurationString(String string){
    final String _index = removeTextAfterLastSpecialCharacter(string, '_');
    return Numeric.transformStringToInt(_index);
  }
  // --------------------
  static int getDurationFromIndexDurationString(String string){
    final String _duration = removeTextBeforeLastSpecialCharacter(string, '_');
    return Numeric.transformStringToInt(_duration);
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordX createSaveRecord({
    required String userID,
    required String flyerID,
    required String bzID,
    required int slideIndex,
  }){

    return RecordX(
      recordID: '${flyerID}_$userID',
      recordType: RecordType.save,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordTypeX.save),
      bzID: bzID,
      flyerID: flyerID,
      recordDetailsType: RecordDetailsType.slideIndex,
      recordDetails: slideIndex,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordX createUnSaveRecord({
    required String userID,
    required String flyerID,
    required String bzID,
  }){

    return RecordX(
      recordID: '${flyerID}_$userID',
      recordType: RecordType.unSave,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordTypeX.unSave),
      bzID: bzID,
      flyerID: flyerID,
      recordDetailsType: null,
      recordDetails: null,
    );

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

  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogRecord({required String invoker}){

    final String _text =
    '''
    $invoker : RecordModel(
      recordID: $recordID,
      recordType: $recordType,
      userID: $userID,
      timeStamp: $timeStamp,
      modelType: $modelType,
      flyerID: $flyerID,
      bzID: $bzID,
      recordDetailsType: $recordDetailsType,
      recordDetails: $recordDetails,
    );
    ''';

    blog(_text);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogRecords({
    required String invoker,
    required List<RecordX> records,
  }){

    if (Mapper.checkCanLoopList(records) == true){

      for (final RecordX record in records){
        record.blogRecord(
          invoker: invoker,
        );
      }

    }

    else {
      blog('BLOG RECORD : records are empty');
    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkRecordsAreIdentical({
    required RecordX? record1,
    required RecordX? record2,
  }){
    bool _identical = false;

    if (record1 == null && record2 == null){
      _identical = true;
    }

    else if (record1 != null && record2 != null){

      if (
          record1.recordType == record2.recordType &&
          record1.userID == record2.userID &&
          record1.recordID == record2.recordID &&
          Timers.checkTimesAreIdentical(
              accuracy: TimeAccuracy.second,
              time1: record1.timeStamp,
              time2: record2.timeStamp
          ) == true &&
          record1.modelType == record2.modelType &&
          record1.bzID == record2.bzID &&
          record1.flyerID == record2.flyerID &&
          record1.recordDetailsType == record2.recordDetailsType &&
          record1.recordDetails == record2.recordDetails
          // record1.docSnapshot == record2.docSnapshot &&
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
     @override
     String toString() => 'MapModel(key: $key, value: ${value.toString()})';
     */
  // --------------------
    @override
    bool operator == (Object other){

      if (identical(this, other)) {
        return true;
      }

      bool _areIdentical = false;
      if (other is RecordX){
        _areIdentical = checkRecordsAreIdentical(
          record1: this,
          record2: other,
        );
      }

      return _areIdentical;
    }
  // --------------------
    @override
    int get hashCode =>
        recordType.hashCode^
        userID.hashCode^
        timeStamp.hashCode^
        modelType.hashCode^
        bzID.hashCode^
        flyerID.hashCode^
        recordDetailsType.hashCode^
        recordDetails.hashCode^
        recordID.hashCode^
        docSnapshot.hashCode;
  // -----------------------------------------------------------------------------
}
