import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum RecordType {
  follow,
  unfollow,
  call,
  share,
  view,
  save,
  unSave,
  createReview,
  editReview,
  deleteReview,

  createQuestion,
  editQuestion,
  deleteQuestion,
  createAnswer,
  editAnswer,
  deleteAnswer,

  search,
}

enum ModelType{
  flyer,
  bz,
  question,
  answer,
  // review,
  user,
}

enum RecordDetailsType{
  slideIndex,
  text,
  questionID,
  answerID,
  contact,
}

@immutable
class RecordModel {
  /// --------------------------------------------------------------------------
  const RecordModel({
    @required this.recordType,
    @required this.userID,
    @required this.timeStamp,
    @required this.modelType,
    @required this.modelID,
    @required this.recordDetailsType,
    @required this.recordDetails,
    this.recordID,
    this.docSnapshot,
    this.serverTimeStamp,
  });
  /// --------------------------------------------------------------------------
  final RecordType recordType;
  final String userID;
  final String recordID;
  final DateTime timeStamp;
  final ModelType modelType;
  final String modelID; /// flyerID - bzID - QuestionID - AnswerID
  final RecordDetailsType recordDetailsType;
  final dynamic recordDetails;
  final DocumentSnapshot<Object> docSnapshot;
  final FieldValue serverTimeStamp;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, Object> toMap({
    @required bool toJSON,
  }) {
    return <String, Object>{
      'recordType' : cipherRecordType(recordType),
      'userID' : userID,
      'timeStamp' : Timers.cipherTime(time: timeStamp, toJSON: toJSON),
      'modelType' : cipherModelType(modelType),
      'modelID' : modelID,
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
    @required Map<String, dynamic> map,
    @required bool fromJSON,
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
        modelID: map['modelID'],
        recordDetailsType: _decipherRecordDetailsType(map['recordDetailsType']),
        recordDetails: map['recordDetails'],
        // docSnapshot: map['docSnapshot'],
        serverTimeStamp: map['serverTimeStamp'],
      );

    }

    return _record;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherRecords({
    @required List<RecordModel> records,
    @required bool toJSON,
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
    @required List<Map<String, dynamic>> maps,
    @required bool fromJSON,
  }){
    final List<RecordModel> _records = <RecordModel>[];

    if (Mapper.checkCanLoopList(maps)){

      for (final Map<String, dynamic> map in maps){

        final RecordModel _record = decipherRecord(
          map: map,
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
      case RecordType.createReview:   return 'createReview';    break;
      case RecordType.editReview:     return 'editReview';      break;
      case RecordType.deleteReview:   return 'deleteReview';    break;
      case RecordType.createQuestion: return 'createQuestion';  break;
      case RecordType.editQuestion:   return 'editQuestion';    break;
      case RecordType.deleteQuestion: return 'deleteQuestion';  break;
      case RecordType.createAnswer:   return 'createAnswer';    break;
      case RecordType.editAnswer:     return 'editAnswer';      break;
      case RecordType.deleteAnswer:   return 'deleteAnswer';    break;
      case RecordType.search:         return 'search';          break;
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
      case 'createReview':    return RecordType.createReview;   break;
      case 'editReview':      return RecordType.editReview;     break;
      case 'deleteReview':    return RecordType.deleteReview;   break;
      case 'question':        return RecordType.createQuestion; break;
      case 'editQuestion':    return RecordType.editQuestion;   break;
      case 'deleteQuestion':  return RecordType.deleteQuestion; break;
      case 'createAnswer':    return RecordType.createAnswer;   break;
      case 'editAnswer':      return RecordType.editAnswer;     break;
      case 'deleteAnswer':    return RecordType.deleteAnswer;   break;
      case 'search':          return RecordType.search;         break;
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
      case ModelType.question:  return 'question';  break;
      case ModelType.answer:    return 'answer';    break;
    // case ModelType.review:    return 'review';    break;
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
      case 'question':  return ModelType.question;  break;
      case 'answer':    return ModelType.answer;    break;
    // case 'review':    return ModelType.review;    break;
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
      case RecordType.createReview    : return ModelType.flyer; break;
      case RecordType.editReview      : return ModelType.flyer; break;
      case RecordType.deleteReview    : return ModelType.flyer; break;
      case RecordType.createQuestion  : return ModelType.question; break;
      case RecordType.editQuestion    : return ModelType.question; break;
      case RecordType.deleteQuestion  : return ModelType.question; break;
      case RecordType.createAnswer    : return ModelType.question; break;
      case RecordType.editAnswer      : return ModelType.question; break;
      case RecordType.deleteAnswer    : return ModelType.question; break;
      case RecordType.search          : return ModelType.user; break;
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
      case RecordDetailsType.questionID:          return 'questionID';  break;
      case RecordDetailsType.answerID:            return 'answerID';    break;
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
      case 'questionID':  return RecordDetailsType.questionID;          break;
      case 'answerID':    return RecordDetailsType.answerID;            break;
      case 'contact':     return RecordDetailsType.contact;             break;
      default: return null;
    }
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<RecordModel> insertRecordToRecords({
    @required List<RecordModel> records,
    @required RecordModel record,
  }){

    final List<RecordModel> _output = <RecordModel>[...?records];

    if (Mapper.checkCanLoopList(_output) == true){

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
    @required List<RecordModel> originalRecords,
    @required List<RecordModel> addRecords,
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
    @required List<RecordModel> records,
  }){
    List<RecordModel> _output = <RecordModel>[];

    if (Mapper.checkCanLoopList(records) == true){

      for (final RecordModel rec in records){

        final bool _contains = recordsContainUserID(
            records: _output,
            userID: rec.userID,
        );

        if (_contains == true){
          // do nothing
        }
        else {
          _output = insertRecordToRecords(
              records: _output,
              record: rec,
          );
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
    @required List<RecordModel> records,
    @required RecordModel record,
  }){

    bool _contains = false;

    if (Mapper.checkCanLoopList(records) && record != null){

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
    @required List<RecordModel> records,
    @required String userID,
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
    @required String userID,
    @required String bzID,
  }){

    return RecordModel(
      recordID: '${bzID}_$userID',
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.follow,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.follow),
      modelID: bzID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordModel createUnfollowRecord({
    @required String userID,
    @required String bzID,
  }){

    return RecordModel(
      recordID: '${bzID}_$userID',
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.unfollow,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.unfollow),
      modelID: bzID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordModel createCallRecord({
    @required String userID,
    @required String bzID,
    @required ContactModel contact,
  }){

    return RecordModel(
      // recordID: '${bzID}_$userID', // NO MAKE A RECORD FOR EACH CALL
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.call,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.call),
      modelID: bzID,
      recordDetailsType: RecordDetailsType.contact,
      recordDetails: contact.value,
    );

  }
  // -----------------------------------------------------------------------------

  /// FLYER RECORD CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordModel createShareRecord({
    @required String userID,
    @required String flyerID,
  }){

    return RecordModel(
      // recordID: '${flyerID}_$userID', // MAKE A RECORD FOR EACH SHARE : LEAVE IT NULL
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.share,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.share),
      modelID: flyerID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------
  static RecordModel createViewRecord({
    @required String userID,
    @required String flyerID,
    // @required int durationSeconds,
    @required int slideIndex,
  }){

    return RecordModel(
      recordID: '${flyerID}_${slideIndex}_$userID',
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.view,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.view),
      modelID: flyerID,
      recordDetailsType: RecordDetailsType.slideIndex,
      recordDetails: slideIndex,
      // recordDetails: createIndexAndDurationString(
      //   index: slideIndex,
      //   durationSeconds: durationSeconds,
      // ),
    );

  }
  // --------------------
  static String createIndexAndDurationString({
    @required int index,
    @required int durationSeconds,
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
    @required String userID,
    @required String flyerID,
    @required int slideIndex,
  }){

    return RecordModel(
      recordID: '${flyerID}_$userID',
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.save,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.save),
      modelID: flyerID,
      recordDetailsType: RecordDetailsType.slideIndex,
      recordDetails: slideIndex,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordModel createUnSaveRecord({
    @required String userID,
    @required String flyerID,
  }){

    return RecordModel(
      recordID: '${flyerID}_$userID',
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.unSave,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.unSave),
      modelID: flyerID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------

  static RecordModel createCreateReviewRecord({
    @required String userID,
    @required String flyerID,
    @required String text,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.createReview,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.createReview),
      modelID: flyerID,
      recordDetailsType: RecordDetailsType.text,
      recordDetails: text,
    );

  }
  // --------------------

  static RecordModel createEditReviewRecord({
    @required String userID,
    @required String flyerID,
    @required String reviewEdit,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.editReview,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.editReview),
      modelID: flyerID,
      recordDetailsType: RecordDetailsType.text,
      recordDetails: reviewEdit,
    );

  }
  // --------------------

  static RecordModel createDeleteReviewRecord({
    @required String userID,
    @required String flyerID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.deleteReview,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.deleteReview),
      modelID: flyerID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // -----------------------------------------------------------------------------

  /// QUESTION RECORD CREATORS

  // --------------------
  static RecordModel createCreateQuestionRecord({
    @required String userID,
    @required String questionID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.createQuestion,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.createQuestion),
      modelID: questionID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------
  static RecordModel createEditQuestionRecord({
    @required String userID,
    @required String questionID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.editQuestion,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.editQuestion),
      modelID: questionID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------
  static RecordModel createDeleteQuestionRecord({
    @required String userID,
    @required String questionID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.deleteQuestion,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.deleteQuestion),
      modelID: questionID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
  // --------------------
  static RecordModel createCreateAnswerRecord({
    @required String userID,
    @required String questionID,
    @required String answerID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.createAnswer,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.createAnswer),
      modelID: questionID,
      recordDetailsType: RecordDetailsType.answerID,
      recordDetails: answerID,
    );

  }
  // --------------------
  static RecordModel createEditAnswerRecord({
    @required String userID,
    @required String questionID,
    @required String answerID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.editAnswer,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.editAnswer),
      modelID: questionID,
      recordDetailsType: RecordDetailsType.answerID,
      recordDetails: answerID,
    );

  }
  // --------------------
  static RecordModel createDeleteAnswerRecord({
    @required String userID,
    @required String questionID,
    @required String answerID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.deleteAnswer,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.deleteAnswer),
      modelID: questionID,
      recordDetailsType: RecordDetailsType.answerID,
      recordDetails: answerID,
    );

  }
  // -----------------------------------------------------------------------------

  /// SEARCH RECORD CREATORS

  // --------------------
  static RecordModel createSearchRecord({
    @required String userID,
    @required String searchText,
  }){

    return RecordModel(
      // recordID: , // MAKE A RECORD FOR EACH SEARCH
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.search,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(RecordType.search),
      modelID: userID,
      recordDetailsType: RecordDetailsType.text,
      recordDetails: searchText,
    );

  }
  // -----------------------------------------------------------------------------

  /// DUMMY RECORD

  // --------------------
  /// TESTED : WORKS PERFECT
  static RecordModel dummyRecord(){

    const RecordType recordType = RecordType.search;

    final RecordModel _recordModel = RecordModel(
      recordType: recordType,
      userID: AuthFireOps.superUserID(),
      timeStamp: DateTime.now(),
      modelType: getModelTypeByRecordType(recordType),
      modelID: AuthFireOps.superUserID(),
      recordDetailsType: RecordDetailsType.text,
      recordDetails: 'This is a dummy record',
      serverTimeStamp: FieldValue.serverTimestamp(),
    );

    return _recordModel;
  }
  // -----------------------------------------------------------------------------

  /// BLOG

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogRecord(){
    blog('BLOG RECORD : START');
    blog('recordID : $recordID : recordType : $recordType');
    blog('userID : $userID');
    blog('modelType : $modelType : modelID : $modelID');
    blog('recordDetailsType : $recordDetailsType : recordDetails : $recordDetails');
    blog('timeStamp : $timeStamp : serverTimeStamp : $serverTimeStamp');
    blog('docSnapshot : $docSnapshot');
    blog('BLOG RECORD : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogRecords({
    @required List<RecordModel> records,
  }){

    if (Mapper.checkCanLoopList(records) == true){

      for (final RecordModel record in records){
        record.blogRecord();
      }

    }

    else {
      blog('BLOG RECORD : records are empty');
    }

  }
  // -----------------------------------------------------------------------------

/// OVERRIDES

  // --------------------
/*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
/*
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is RecordModel){
      _areIdentical = checkBzCounterModelsAreIdentical(
        counter1: this,
        counter2: other,
      );
    }

    return _areIdentical;
  }
   */
  // --------------------
/*
  @override
  int get hashCode =>
      bzID.hashCode^
      follows.hashCode^
      calls.hashCode^
      allSaves.hashCode^
      allShares.hashCode^
      allSlides.hashCode^
      allViews.hashCode^
      allReviews.hashCode;
   */
  // -----------------------------------------------------------------------------
}
