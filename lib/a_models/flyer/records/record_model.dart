import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ActivityType {
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

/// shall store customer journey map in firebase
/// db : records / {recordID}
class RecordModel {
  /// --------------------------------------------------------------------------
  const RecordModel({
    @required this.activityType,

    @required this.userID,
    @required this.recordID,
    @required this.timeStamp,

    @required this.modelType,
    @required this.modelID,

    @required this.recordDetailsType,
    @required this.recordDetails,
  });
  /// --------------------------------------------------------------------------
  final ActivityType activityType;

  final String userID;
  final String recordID;
  final DateTime timeStamp;

  final ModelType modelType;
  final String modelID; /// flyerID - bzID - QuestionID - AnswerID

  final RecordDetailsType recordDetailsType;
  final dynamic recordDetails;

  /// --------------------------------------------------------------------------
  Map<String, dynamic> toMap({@required bool toJSON}) {
    return <String, dynamic>{
      'activityType' : _cipherActivityType(activityType),
      'userID' : userID,
      // 'recordID' : recordID,
      'timeStamp' : Timers.cipherTime(time: timeStamp, toJSON: toJSON),
      'modelType' : cipherModelType(modelType),
      'modelID' : modelID,
      'recordDetailsType' : _cipherRecordDetailsType(recordDetailsType),
      'recordDetails' : recordDetails,
    };
  }
// -----------------------------------------------------------------------------
  static RecordModel decipherRecord({
    @required Map<String, dynamic> map,
    @required bool fromJSON,
  }) {
    RecordModel _record;

    if (map != null) {

      _record = RecordModel(
        activityType: _decipherActivityType(map['activityType']),
        userID: map['userID'],
        recordID: map['id'],
        timeStamp: Timers.decipherTime(time: map['timeStamp'], fromJSON: fromJSON),

        modelType: decipherModelType(map['modelType']),
        modelID: map['modelID'],

        recordDetailsType: _decipherRecordDetailsType(map['recordDetailsType']),
        recordDetails: map['recordDetails'],
      );

    }

    return _record;
  }
// -----------------------------------------------------------------------------
  static List<Map<String, dynamic>> cipherRecords({@required List<RecordModel> records, @required bool toJSON}){

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.canLoopList(records)){

      for (final RecordModel record in records){

        final Map<String, dynamic> _map = record.toMap(toJSON: toJSON);
        _maps.add(_map);

      }

    }

    return _maps;
  }
// -----------------------------------------------------------------------------
  static List<RecordModel> decipherRecords({@required List<Map<String, dynamic>> maps, @required bool fromJSON}){
    final List<RecordModel> _records = <RecordModel>[];

    if (Mapper.canLoopList(maps)){

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
  static String _cipherActivityType(ActivityType activity) {
    switch (activity) {
      case ActivityType.follow:         return 'follow';          break;
      case ActivityType.unfollow:       return 'unfollow';        break;
      case ActivityType.call:           return 'call';            break;
      case ActivityType.share:          return 'share';           break;
      case ActivityType.view:           return 'view';            break;
      case ActivityType.save:           return 'save';            break;
      case ActivityType.unSave:         return 'unSave';          break;
      case ActivityType.review:         return 'review';          break;
      case ActivityType.editReview:     return 'editReview';      break;
      case ActivityType.deleteReview:   return 'deleteReview';    break;
      case ActivityType.question:       return 'question';        break;
      case ActivityType.editQuestion:   return 'editQuestion';    break;
      case ActivityType.deleteQuestion: return 'deleteQuestion';  break;
      case ActivityType.answer:         return 'answer';          break;
      case ActivityType.editAnswer:     return 'editAnswer';      break;
      case ActivityType.deleteAnswer:   return 'deleteAnswer';    break;
      case ActivityType.search:         return 'search';          break;
      default:return null;
    }
  }
// -----------------------------------------------------------------------------
  static ActivityType _decipherActivityType(String activity) {
    switch (activity) {
      case 'follow':          return ActivityType.follow;         break;
      case 'unfollow':        return ActivityType.unfollow;       break;
      case 'call':            return ActivityType.call;           break;
      case 'share':           return ActivityType.share;          break;
      case 'view':            return ActivityType.view;           break;
      case 'save':            return ActivityType.save;           break;
      case 'unSave':          return ActivityType.unSave;         break;
      case 'review':          return ActivityType.review;         break;
      case 'editReview':      return ActivityType.editReview;     break;
      case 'deleteReview':    return ActivityType.deleteReview;   break;
      case 'question':        return ActivityType.question;       break;
      case 'editQuestion':    return ActivityType.editQuestion;   break;
      case 'deleteQuestion':  return ActivityType.deleteQuestion; break;
      case 'answer':          return ActivityType.answer;         break;
      case 'editAnswer':      return ActivityType.editAnswer;     break;
      case 'deleteAnswer':    return ActivityType.deleteAnswer;   break;
      case 'search':          return ActivityType.search;         break;
      default:return null;
    }
  }
// -----------------------------------------------------------------------------
  static String cipherModelType(ModelType modelType){
    switch (modelType){
      case ModelType.flyer:     return 'flyer';     break;
      case ModelType.bz:        return 'bz';        break;
      case ModelType.question:  return 'question';  break;
      case ModelType.answer:    return 'answer';    break;
      case ModelType.search:    return 'search';    break;
      default: return null;
    }
  }
// -----------------------------------------------------------------------------
  static ModelType decipherModelType(String modelType){
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
  static String _cipherRecordDetailsType(RecordDetailsType recordDetailsType){
    switch (recordDetailsType){
      case RecordDetailsType.slideIndex:        return 'slideIndex';     break;
      case RecordDetailsType.searchText:        return 'searchText';        break;
      default: return null;
    }
  }
// -----------------------------------------------------------------------------
  static RecordDetailsType _decipherRecordDetailsType(String recordDetailsType){
    switch (recordDetailsType){
      case 'slideIndex':      return RecordDetailsType.slideIndex;      break;
      case 'searchText':      return RecordDetailsType.searchText;      break;
      default: return null;
    }
  }
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
