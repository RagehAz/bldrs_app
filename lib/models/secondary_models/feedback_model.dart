import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class FeedbackModel{
  final String userID;
  final DateTime timeStamp;
  final String feedback;

  FeedbackModel({
    @required this.userID,
    @required this.timeStamp,
    @required this.feedback,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'userID' : userID,
      'timeStamp' : Timers.cipherDateTimeToString(timeStamp),
      'feedback' : feedback,
    };
  }
// -----------------------------------------------------------------------------
static FeedbackModel decipherFeedbackMap(Map<String, dynamic> map){
    return
        FeedbackModel(
          userID: map['userID'],
          timeStamp: Timers.decipherDateTimeString(map['timeStamp']),
          feedback: map['feedback'],
        );
}
// -----------------------------------------------------------------------------
}