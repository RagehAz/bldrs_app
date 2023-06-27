import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/x_secondary/bldrs_model_type.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:basics/helpers/classes/time/timers.dart';

enum RecordType {
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
class RecordModel {
  /// --------------------------------------------------------------------------
  const RecordModel({
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
  final RecordType recordType;
  final String userID;
  final String recordID;
  final DateTime timeStamp;
  final ModelType modelType;
  final String bzID;
  final String flyerID;
  final RecordDetailsType recordDetailsType;
  final dynamic recordDetails;
  final DocumentSnapshot<Object> docSnapshot;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, Object> toMap({
    required bool toJSON,
  }) {
    return <String, Object>{
      'recordType' : cipherRecordType(recordType),
      'userID' : userID,
      'timeStamp' : Timers.cipherTime(time: timeStamp, toJSON: toJSON),
      'modelType' : cipherModelType(modelType),
      'recordDetailsType' : _cipherRecordDetailsType(recordDetailsType),
      'recordDetails' : recordDetails,
      // 'serverTimeStamp' : serverTimeStamp,
      // 'recordID' : recordID,
      // 'docSnapshot' : docSnapshot,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordModel decipherRecord({
    required Map<String, dynamic> map,
    required String bzID,
    required String flyerID,
    required bool fromJSON,
  }) {
    RecordModel _record;

    if (map != null) {

      _record = RecordModel(
        recordType: decipherRecordType(map['recordType']),
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
    required List<RecordModel> records,
    required bool toJSON,
  }) {

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.checkCanLoopList(records)){

      for (final RecordModel record in records){

        final Map<String, dynamic> _map = record.toMap(toJSON: toJSON);
        _maps.add(_map);

      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<RecordModel> decipherRecords({
    required List<Map<String, dynamic>> maps,
    required String bzID,
    required String flyerID,
    required bool fromJSON,
  }){
    final List<RecordModel> _records = <RecordModel>[];

    if (Mapper.checkCanLoopList(maps)){

      for (final Map<String, dynamic> map in maps){

        final RecordModel _record = decipherRecord(
          map: map,
          bzID: bzID,
          flyerID: flyerID,
          fromJSON: fromJSON,
        );
        _records.add(_record);

      }

    }

    return _records;
  }
  // -----------------------------------------------------------------------------

  /// RECORD TYPE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherRecordType(RecordType recordType) {
    switch (recordType) {
      case RecordType.follow:         return 'follow';          break;
      case RecordType.unfollow:       return 'unfollow';        break;
      case RecordType.call:           return 'call';            break;
      case RecordType.share:          return 'share';           break;
      case RecordType.view:           return 'view';            break;
      case RecordType.save:           return 'save';            break;
      case RecordType.unSave:         return 'unSave';          break;
      default:return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordType decipherRecordType(String type) {
    switch (type) {
      case 'follow':          return RecordType.follow;         break;
      case 'unfollow':        return RecordType.unfollow;       break;
      case 'call':            return RecordType.call;           break;
      case 'share':           return RecordType.share;          break;
      case 'view':            return RecordType.view;           break;
      case 'save':            return RecordType.save;           break;
      case 'unSave':          return RecordType.unSave;         break;
      default:return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// MODEL TYPE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherModelType(ModelType modelType){
    switch (modelType){
      case ModelType.flyer:     return 'flyer';     break;
      case ModelType.bz:        return 'bz';        break;
      case ModelType.user:      return 'user';      break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ModelType decipherModelType(String modelType){
    switch (modelType){
      case 'flyer':     return ModelType.flyer;     break;
      case 'bz':        return ModelType.bz;        break;
      case 'user':      return ModelType.user;      break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ModelType getModelTypeByRecordType(RecordType recordType){

    switch(recordType){
      case RecordType.follow          : return ModelType.bz; break;
      case RecordType.unfollow        : return ModelType.bz; break;
      case RecordType.call            : return ModelType.bz; break;
      case RecordType.share           : return ModelType.flyer; break;
      case RecordType.view            : return ModelType.flyer; break;
      case RecordType.save            : return ModelType.flyer; break;
      case RecordType.unSave          : return ModelType.flyer; break;
      default: return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// RECORD DETAILS CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String _cipherRecordDetailsType(RecordDetailsType recordDetailsType){
    switch (recordDetailsType){
      case RecordDetailsType.slideIndex:          return 'slideIndex';  break;
      case RecordDetailsType.text:                return 'text';        break;
      case RecordDetailsType.contact:             return 'contact';     break;
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordDetailsType _decipherRecordDetailsType(String recordDetailsType){
    switch (recordDetailsType){
      case 'slideIndex':  return RecordDetailsType.slideIndex;  break;
      case 'text':        return RecordDetailsType.text;                break;
      case 'contact':     return RecordDetailsType.contact;             break;
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<RecordModel> insertRecordToRecords({
    required List<RecordModel> records,
    required RecordModel record,
  }){

    final List<RecordModel> _output = <RecordModel>[...?records];

    if (Mapper.checkCanLoopList(records) == true){

      final bool _recordsContainRecord = recordsContainRecord(
        records: _output,
        record: record,
      );

      if (_recordsContainRecord == false){
        _output.add(record);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<RecordModel> insertRecordsToRecords({
    required List<RecordModel> originalRecords,
    required List<RecordModel> addRecords,
  }){

    List<RecordModel> _output = <RecordModel>[];

    if (Mapper.checkCanLoopList(addRecords)){

      for (final RecordModel record in addRecords){
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
  static List<RecordModel> cleanDuplicateUsers({
    required List<RecordModel> records,
  }){
    final List<RecordModel> _output = <RecordModel>[];

    if (Mapper.checkCanLoopList(records) == true){

      for (final RecordModel rec in records){

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
    required List<RecordModel> records,
    required RecordModel record,
  }){

    bool _contains = false;

    if (Mapper.checkCanLoopList(records) == true && record != null){

      for (final RecordModel rec in records){

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
    required List<RecordModel> records,
    required String userID,
  }){
    bool _includes = false;

    if (Mapper.checkCanLoopList(records) == true){

      final int _index = records.indexWhere((element) => element.userID == userID);

      if (_index == -1){
        _includes = false;
      }
      else {
        _includes = true;
      }

    }

    return _includes;
  }
  // -----------------------------------------------------------------------------

  /// BZ RECORD CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordModel createFollowRecord({
    required String userID,
    required String bzID,
  }){

    return RecordModel(
      recordID: '${bzID}_$userID',
      recordType: RecordType.follow,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.follow),
      bzID: bzID,
      flyerID: null,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordModel createUnfollowRecord({
    required String userID,
    required String bzID,
  }){

    return RecordModel(
      recordID: '${bzID}_$userID',
      recordType: RecordType.unfollow,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.unfollow),
      bzID: bzID,
      flyerID: null,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordModel createCallRecord({
    required String userID,
    required String bzID,
    required ContactModel contact,
  }){

    return RecordModel(
      // recordID: '${bzID}_$userID', // NO MAKE A RECORD FOR EACH CALL
      recordType: RecordType.call,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.call),
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
  static RecordModel createShareRecord({
    required String userID,
    required String flyerID,
    required String bzID,
  }){

    return RecordModel(
      // recordID: '${flyerID}_$userID', // MAKE A RECORD FOR EACH SHARE : LEAVE IT NULL
      recordType: RecordType.share,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.share),
      bzID: bzID,
      flyerID: flyerID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordModel createViewRecord({
    required String userID,
    required String flyerID,
    required String bzID,
    // required int durationSeconds,
    required int slideIndex,
  }){

    return RecordModel(
      recordID: '${flyerID}_${slideIndex}_$userID',
      recordType: RecordType.view,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.view),
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

    final String _index = Numeric.formatNumberWithinDigits(
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
  static RecordModel createSaveRecord({
    required String userID,
    required String flyerID,
    required String bzID,
    required int slideIndex,
  }){

    return RecordModel(
      recordID: '${flyerID}_$userID',
      recordType: RecordType.save,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.save),
      bzID: bzID,
      flyerID: flyerID,
      recordDetailsType: RecordDetailsType.slideIndex,
      recordDetails: slideIndex,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordModel createUnSaveRecord({
    required String userID,
    required String flyerID,
    required String bzID,
  }){

    return RecordModel(
      recordID: '${flyerID}_$userID',
      recordType: RecordType.unSave,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.unSave),
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
  static Verse getVerseByModelType(ModelType modelType){
    String _text;

    switch(modelType){
      case ModelType.flyer:     _text = 'phid_flyers'; break;
      case ModelType.bz:        _text = 'phid_bzz'; break;
      case ModelType.user:      _text = 'phid_users'; break;
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
    required List<RecordModel> records,
  }){

    if (Mapper.checkCanLoopList(records) == true){

      for (final RecordModel record in records){
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
    required RecordModel record1,
    required RecordModel record2,
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
      if (other is RecordModel){
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
