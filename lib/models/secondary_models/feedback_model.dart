import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class FeedbackModel{
  final String id;
  final String userID;
  final DateTime timeStamp;
  final String feedback;

  FeedbackModel({
    this.id,
    @required this.userID,
    @required this.timeStamp,
    @required this.feedback,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'userID' : userID,
      'timeStamp' : Timers.cipherDateTimeToString(timeStamp),
      'feedback' : feedback,
    };
  }
// -----------------------------------------------------------------------------
static FeedbackModel decipherFeedbackMap(Map<String, dynamic> map){
    return
        FeedbackModel(
          id: map['id'],
          userID: map['userID'],
          timeStamp: Timers.decipherDateTimeString(map['timeStamp']),
          feedback: map['feedback'],
        );
}
// -----------------------------------------------------------------------------
static List<FeedbackModel> decipherFeedbacks(List<dynamic> maps){
    List<FeedbackModel> _feedbacks = [];

    if (maps != null && maps.isNotEmpty){

      for (var map in maps){

        _feedbacks.add(FeedbackModel.decipherFeedbackMap(map));

      }

    }

    return _feedbacks;
}
// -----------------------------------------------------------------------------
}