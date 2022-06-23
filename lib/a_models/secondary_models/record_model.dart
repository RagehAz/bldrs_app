import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;

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
  review,
}

enum RecordDetailsType{
  slideIndexDuration,
  text,
  questionID,
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

  /// MODEL CYPHERS

// ---------------------------------
  Map<String, dynamic> toMap({
    @required bool toJSON,
  }) {
    return <String, dynamic>{
      'activityType' : cipherActivityType(recordType),
      'userID' : userID,
      'timeStamp' : Timers.cipherTime(time: timeStamp, toJSON: toJSON),
      'modelType' : _cipherModelType(modelType),
      'modelID' : modelID,
      'recordDetailsType' : _cipherRecordDetailsType(recordDetailsType),
      'recordDetails' : recordDetails,
      'serverTimeStamp' : serverTimeStamp,
      // 'recordID' : recordID,
      // 'docSnapshot' : docSnapshot,
    };
  }
// ---------------------------------
  static RecordModel decipherRecord({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }) {
    RecordModel _record;

    if (map != null) {

      _record = RecordModel(
        recordType: decipherActivityType(map['activityType']),
        userID: map['userID'],
        recordID: map['id'],
        timeStamp: Timers.decipherTime(
            time: map['timeStamp'],
            fromJSON: fromJSON,
        ),
        modelType: _decipherModelType(map['modelType']),
        modelID: map['modelID'],
        recordDetailsType: _decipherRecordDetailsType(map['recordDetailsType']),
        recordDetails: map['recordDetails'],
        docSnapshot: map['docSnapshot'],
        serverTimeStamp: map['serverTimeStamp'],
      );

    }

    return _record;
  }
// ---------------------------------
  static List<Map<String, dynamic>> cipherRecords({
    @required List<RecordModel> records,
    @required bool toJSON,
  }){

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.checkCanLoopList(records)){

      for (final RecordModel record in records){

        final Map<String, dynamic> _map = record.toMap(toJSON: toJSON);
        _maps.add(_map);

      }

    }

    return _maps;
  }
// ---------------------------------
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

// ---------------------------------
  static String cipherActivityType(RecordType activity) {
    switch (activity) {
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
// ---------------------------------
  static RecordType decipherActivityType(String activity) {
    switch (activity) {
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

// ---------------------------------
  static String _cipherModelType(ModelType modelType){
    switch (modelType){
      case ModelType.flyer:     return 'flyer';     break;
      case ModelType.bz:        return 'bz';        break;
      case ModelType.question:  return 'question';  break;
      case ModelType.answer:    return 'answer';    break;
      case ModelType.review:    return 'review';    break;
      default: return null;
    }
  }
// ---------------------------------
  static ModelType _decipherModelType(String modelType){
    switch (modelType){
      case 'flyer':     return ModelType.flyer;     break;
      case 'bz':        return ModelType.bz;        break;
      case 'question':  return ModelType.question;  break;
      case 'answer':    return ModelType.answer;    break;
      case 'review':    return ModelType.review;    break;
      default: return null;
    }
  }
// -----------------------------------------------------------------------------

  /// RECORD DETAILS CYPHERS

// ---------------------------------
  static String _cipherRecordDetailsType(RecordDetailsType recordDetailsType){
    switch (recordDetailsType){
      case RecordDetailsType.slideIndexDuration:  return 'slideIndex';  break;
      case RecordDetailsType.text:                return 'text';        break;
      case RecordDetailsType.questionID:          return 'questionID';  break;
      default: return null;
    }
  }
// ---------------------------------
  static RecordDetailsType _decipherRecordDetailsType(String recordDetailsType){
    switch (recordDetailsType){
      case 'slideIndex':  return RecordDetailsType.slideIndexDuration;  break;
      case 'text':        return RecordDetailsType.text;                break;
      case 'questionID':  return RecordDetailsType.questionID;          break;
      default: return null;
    }
  }
// -----------------------------------------------------------------------------

  /// MODIFIERS

// ---------------------------------
  static List<RecordModel> insertRecordToRecords({
    @required List<RecordModel> records,
    @required RecordModel record,
  }){

    final bool _recordsContainRecord = recordsContainRecord(
      records: records,
      record: record,
    );

    if (_recordsContainRecord == false){
      records.add(record);
    }

    return records;
  }
// ---------------------------------
  static List<RecordModel> insertRecordsToRecords({
    @required List<RecordModel> originalRecords,
    @required List<RecordModel> addRecords,
}){

    List<RecordModel> _output = <RecordModel>[];

    if (Mapper.checkCanLoopList(addRecords)){

      for (final RecordModel record in addRecords){
        _output = insertRecordToRecords(records: originalRecords, record: record);
      }

    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// ---------------------------------
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
// -----------------------------------------------------------------------------

/// CREATORS

// ---------------------------------
  static RecordModel createFollowRecord({
    @required String userID,
    @required String bzID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.follow,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.bz,
      modelID: bzID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
// ---------------------------------
  static RecordModel createUnfollowRecord({
    @required String userID,
    @required String bzID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.unfollow,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.bz,
      modelID: bzID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
// ---------------------------------
  static RecordModel createCallRecord({
    @required String userID,
    @required String bzID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.call,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.bz,
      modelID: bzID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
// ---------------------------------
  static RecordModel createShareRecord({
    @required String userID,
    @required String flyerID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.share,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.flyer,
      modelID: flyerID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
// ---------------------------------
  static RecordModel createViewRecord({
    @required String userID,
    @required String flyerID,
    @required int durationSeconds,
    @required int slideIndex,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.view,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.flyer,
      modelID: flyerID,
      recordDetailsType: RecordDetailsType.slideIndexDuration,
      recordDetails: createIndexAndDurationString(
        index: slideIndex,
        durationSeconds: durationSeconds,
      ),
    );

  }
// ---------------------------------
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
// ---------------------------------
  static int getIndexFromIndexDurationString(String string){
    final String _index = removeTextAfterLastSpecialCharacter(string, '_');
    return Numeric.transformStringToInt(_index);
  }
// ---------------------------------
  static int getDurationFromIndexDurationString(String string){
    final String _duration = removeTextBeforeLastSpecialCharacter(string, '_');
    return Numeric.transformStringToInt(_duration);
  }
// ---------------------------------
  static RecordModel createSaveRecord({
    @required String userID,
    @required String flyerID,
    @required int slideIndex,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.save,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.flyer,
      modelID: flyerID,
      recordDetailsType: RecordDetailsType.slideIndexDuration,
      recordDetails: slideIndex,
    );

  }
// ---------------------------------
  static RecordModel createUnSaveRecord({
    @required String userID,
    @required String flyerID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.unSave,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.flyer,
      modelID: flyerID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
// ---------------------------------
  static RecordModel createCreateReviewRecord({
    @required String userID,
    @required String reviewID,
    @required String review,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.createReview,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.review,
      modelID: reviewID,
      recordDetailsType: RecordDetailsType.text,
      recordDetails: review,
    );

  }
// ---------------------------------
  static RecordModel createEditReviewRecord({
    @required String userID,
    @required String reviewID,
    @required String reviewEdit,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.editReview,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.review,
      modelID: reviewID,
      recordDetailsType: RecordDetailsType.text,
      recordDetails: reviewEdit,
    );

  }
// ---------------------------------
  static RecordModel createDeleteReviewRecord({
    @required String userID,
    @required String reviewID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.deleteReview,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.review,
      modelID: reviewID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
// ---------------------------------
  static RecordModel createCreateQuestionRecord({
    @required String userID,
    @required String questionID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.createQuestion,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.question,
      modelID: questionID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
// ---------------------------------
  static RecordModel createEditQuestionRecord({
    @required String userID,
    @required String questionID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.editQuestion,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.question,
      modelID: questionID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
// ---------------------------------
  static RecordModel createDeleteQuestionRecord({
    @required String userID,
    @required String questionID,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.deleteQuestion,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: ModelType.question,
      modelID: questionID,
      recordDetailsType: null,
      recordDetails: null,
    );

  }
// ---------------------------------
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
      modelType: ModelType.answer,
      modelID: answerID,
      recordDetailsType: RecordDetailsType.questionID,
      recordDetails: questionID,
    );

  }
// ---------------------------------
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
      modelType: ModelType.answer,
      modelID: answerID,
      recordDetailsType: RecordDetailsType.questionID,
      recordDetails: questionID,
    );

  }
// ---------------------------------
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
      modelType: ModelType.answer,
      modelID: answerID,
      recordDetailsType: RecordDetailsType.questionID,
      recordDetails: questionID,
    );

  }
// ---------------------------------
  static RecordModel createSearchRecord({
    @required String userID,
    @required String searchText,
  }){

    return RecordModel(
      serverTimeStamp: FieldValue.serverTimestamp(),
      recordType: RecordType.search,
      userID: userID,
      timeStamp: DateTime.now(),
      modelType: null,
      modelID: null,
      recordDetailsType: RecordDetailsType.text,
      recordDetails: searchText,
    );

  }
// ---------------------------------

// -----------------------------------------------------------------------------


//   static dynamic _cipherRecordDetails({
//     @required dynamic recordDetails,
//     @required RecordDetailsType recordDetailsType,
//   }){
//
//     dynamic _output;
//
//     if (recordDetailsType == RecordDetailsType.searchText){
//
//       _output = recordDetails;
//
//     }
//
//     else {
//
//       _output = recordDetails;
//
//     }
//
//   }
// // -----------------------------------------------------------------------------
//   static dynamic _decipherRecordDetails({
//     @required dynamic recordDetails,
//     @required RecordDetailsType recordDetailsType,
//   }){
//
//   }
// -----------------------------------------------------------------------------
}
