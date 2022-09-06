import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:flutter/foundation.dart';

@immutable
class FeedbackModel {
  /// --------------------------------------------------------------------------
  const FeedbackModel({
    @required this.userID,
    @required this.timeStamp,
    @required this.feedback,
    this.id,
    this.modelType,
    this.modelID,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String userID;
  final DateTime timeStamp;
  final String feedback;
  final ModelType modelType;
  final String modelID;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userID': userID,
      'timeStamp': Timers.cipherTime(time: timeStamp, toJSON: true),
      'feedback': feedback,
      'modelType' : RecordModel.cipherModelType(modelType) ?? 'general_feedback',
      'modelID' : modelID,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FeedbackModel decipherFeedback(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'],
      userID: map['userID'],
      timeStamp: Timers.decipherTime(time: map['timeStamp'], fromJSON: true),
      feedback: map['feedback'],
      modelType: map['modelType'],
      modelID: map['modelID'],
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FeedbackModel> decipherFeedbacks(List<Map<String, dynamic>> maps) {

    final List<FeedbackModel> _feedbacks = <FeedbackModel>[];

    if (Mapper.checkCanLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {
        _feedbacks.add(FeedbackModel.decipherFeedback(map));
      }
    }

    return _feedbacks;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  static bool checkFeedbacksAreIdentical({
    @required FeedbackModel feedback1,
    @required FeedbackModel feedback2,
  }){
    bool _areIdentical = false;

    if (feedback1 == null && feedback2 == null){
      _areIdentical = true;
    }
    else if (feedback1 != null && feedback2 != null){

      if (
      feedback1.id == feedback2.id &&
          feedback1.userID == feedback2.userID &&
          feedback1.feedback == feedback2.feedback &&
          feedback1.modelType == feedback2.modelType &&
          feedback1.modelID == feedback2.modelID &&
          Timers.checkTimesAreIdentical(
              accuracy: TimeAccuracy.second,
              time1: feedback1.timeStamp,
              time2: feedback2.timeStamp
          ) == true
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
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
    if (other is FeedbackModel){
      _areIdentical = checkFeedbacksAreIdentical(
        feedback1: this,
        feedback2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      userID.hashCode^
      timeStamp.hashCode^
      feedback.hashCode^
      modelType.hashCode^
      modelID.hashCode;
  // -----------------------------------------------------------------------------
}
