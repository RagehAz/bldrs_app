import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
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
  review,
  editReview,
  deleteReview,
  question,
  editQuestion,
  deleteQuestion,
  answer,
  editAnswer,
  deleteAnswer,
  search,
}

enum ModelType{
  flyer,
  bz,
  question,
  answer,
  search,
}

enum RecordDetailsType{
  slideIndex,
  searchText,
}

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
      case RecordType.review:         return 'review';          break;
      case RecordType.editReview:     return 'editReview';      break;
      case RecordType.deleteReview:   return 'deleteReview';    break;
      case RecordType.question:       return 'question';        break;
      case RecordType.editQuestion:   return 'editQuestion';    break;
      case RecordType.deleteQuestion: return 'deleteQuestion';  break;
      case RecordType.answer:         return 'answer';          break;
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
      case 'review':          return RecordType.review;         break;
      case 'editReview':      return RecordType.editReview;     break;
      case 'deleteReview':    return RecordType.deleteReview;   break;
      case 'question':        return RecordType.question;       break;
      case 'editQuestion':    return RecordType.editQuestion;   break;
      case 'deleteQuestion':  return RecordType.deleteQuestion; break;
      case 'answer':          return RecordType.answer;         break;
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
      case ModelType.search:    return 'search';    break;
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
      case 'search':    return ModelType.search;    break;
      default: return null;
    }
  }
// -----------------------------------------------------------------------------

  /// RECORD DETAILS CYPHERS

// ---------------------------------
  static String _cipherRecordDetailsType(RecordDetailsType recordDetailsType){
    switch (recordDetailsType){
      case RecordDetailsType.slideIndex:        return 'slideIndex';     break;
      case RecordDetailsType.searchText:        return 'searchText';        break;
      default: return null;
    }
  }
// ---------------------------------
  static RecordDetailsType _decipherRecordDetailsType(String recordDetailsType){
    switch (recordDetailsType){
      case 'slideIndex':      return RecordDetailsType.slideIndex;      break;
      case 'searchText':      return RecordDetailsType.searchText;      break;
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


// -----------------------------------------------------------------------------

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
