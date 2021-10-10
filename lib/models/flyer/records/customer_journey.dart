import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Activity {
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
}

/// shall store customer journey map in firebase
/// db : records / logs / {activity} / {recordID}
class Record {

  final String userID; // docName
  final String bzID; // subDocName
  final String flyerID;
  final Activity activity;
  final DateTime timeStamp;
  final int slideIndex;
  final double duration;

  const Record({
    @required this.userID,
    @required this.bzID,
    @required this.activity,
    @required this.timeStamp,
    @required this.flyerID,
    @required this.slideIndex,
    @required this.duration,
  });
// -----------------------------------------------------------------------------
  Map<String, dynamic> cipher(){

    return
      {
        'userID' : userID,
        'bzID' : bzID,
        'activity' : cipherActivity(activity),
        'timeStamp' : timeStamp,
        'flyerID' : flyerID,
        'slideIndex' : slideIndex,
        'duration' : duration,
      };

  }
// -----------------------------------------------------------------------------
  static Record decipherRecord(Map<String, dynamic> map){

    Record _record;

    if (map != null){

      _record = Record(
        userID : map['userID'],
        bzID : map['bzID'],
        activity : decipherActivity(map['activity']),
        timeStamp : map['timeStamp'].toDate(),
        flyerID : map['flyerID'],
        slideIndex : map['slideIndex'],
        duration : map['duration'],
      );

    }

    return _record;
  }
// -----------------------------------------------------------------------------
  static String cipherActivity(Activity activity){
    switch (activity){
      case Activity.follow : return 'follow'; break;
      case Activity.unfollow : return 'unfollow'; break;
      case Activity.call : return 'call'; break;
      case Activity.share : return 'share'; break;
      case Activity.view : return 'view'; break;
      case Activity.save : return 'save'; break;
      case Activity.unSave : return 'unSave'; break;
      case Activity.review : return 'review'; break;
      case Activity.editReview : return 'editReview'; break;
      case Activity.deleteReview : return 'deleteReview'; break;
      case Activity.question : return 'question'; break;
      case Activity.editQuestion : return 'editQuestion'; break;
      case Activity.deleteQuestion : return 'deleteQuestion'; break;
      case Activity.answer : return 'answer'; break;
      case Activity.editAnswer : return 'editAnswer'; break;
      case Activity.deleteAnswer : return 'deleteAnswer'; break;
      default: return null;
    }
  }
// -----------------------------------------------------------------------------
  static Activity decipherActivity(String activity){
    switch (activity){
      case 'follow' : return Activity.follow; break;
      case 'unfollow' : return Activity.unfollow; break;
      case 'call' : return Activity.call; break;
      case 'share' : return Activity.share; break;
      case 'view' : return Activity.view; break;
      case 'save' : return Activity.save; break;
      case 'unSave' : return Activity.unSave; break;
      case 'review' : return Activity.review; break;
      case 'editReview' : return Activity.editReview; break;
      case 'deleteReview' : return Activity.deleteReview; break;
      case 'question' : return Activity.question; break;
      case 'editQuestion' : return Activity.editQuestion; break;
      case 'deleteQuestion' : return Activity.deleteQuestion; break;
      case 'answer' : return Activity.answer; break;
      case 'editAnswer' : return Activity.editAnswer; break;
      case 'deleteAnswer' : return Activity.deleteAnswer; break;
      default : return null;
    }

  }
// -----------------------------------------------------------------------------

}

