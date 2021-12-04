import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:flutter/foundation.dart';
// -----------------------------------------------------------------------------
class FeedbackModel{
  final String id;
  final String userID;
  final DateTime timeStamp;
  final String feedback;

  const FeedbackModel({
    @required this.userID,
    @required this.timeStamp,
    @required this.feedback,
    this.id,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return <String,dynamic>{
      'id' : id,
      'userID' : userID,
      'timeStamp' : Timers.cipherTime(time: timeStamp, toJSON: false),
      'feedback' : feedback,
    };
  }
// -----------------------------------------------------------------------------
static FeedbackModel decipherFeedbackMap(Map<String, dynamic> map){
    return
        FeedbackModel(
          id: map['id'],
          userID: map['userID'],
          timeStamp: Timers.decipherTime(time: map['timeStamp'], fromJSON: false),
          feedback: map['feedback'],
        );
}
// -----------------------------------------------------------------------------
static List<FeedbackModel> decipherFeedbacks(List<Map<String, dynamic>> maps){
    final List<FeedbackModel> _feedbacks = <FeedbackModel>[];

    if (Mapper.canLoopList(maps)){

      for (Map<String, dynamic> map in maps){

        _feedbacks.add(FeedbackModel.decipherFeedbackMap(map));

      }

    }

    return _feedbacks;
}
// -----------------------------------------------------------------------------
}