import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:flutter/foundation.dart';

// -----------------------------------------------------------------------------
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
  /// --------------------------------------------------------------------------
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

// -----------------------------------------------------------------------------
  static FeedbackModel decipherFeedbackMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'],
      userID: map['userID'],
      timeStamp: Timers.decipherTime(time: map['timeStamp'], fromJSON: true),
      feedback: map['feedback'],
      modelType: map['modelType'],
      modelID: map['modelID'],
    );
  }

// -----------------------------------------------------------------------------
  static List<FeedbackModel> decipherFeedbacks(List<Map<String, dynamic>> maps) {

    final List<FeedbackModel> _feedbacks = <FeedbackModel>[];

    if (Mapper.checkCanLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {
        _feedbacks.add(FeedbackModel.decipherFeedbackMap(map));
      }
    }

    return _feedbacks;
  }
// -----------------------------------------------------------------------------
}
