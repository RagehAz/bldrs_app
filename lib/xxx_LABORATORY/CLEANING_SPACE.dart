import 'package:flutter/foundation.dart';

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
/// db : userID / {bzID} / {activityID}
class CustomerJourney {

  final String userID; // docName
  final String bzID; // subDocName
  final Activity activity;
  final DateTime timeStamp;
  final String flyerID;
  final int slideIndex;
  final double duration;


  const CustomerJourney({
    @required this.userID,
    @required this.bzID,
    @required this.activity,
    @required this.timeStamp,
    @required this.flyerID,
    @required this.slideIndex,
    @required this.duration,
});

}

/// follows
/// db : bzID / follows / {userID : followModel that includes tinyUser}
///
/// calls
/// db : bzID / calls / {userID : callModel that includes tinyUser}
///
/// shares
/// db : flyerID / shares / {userID : shareModel that includes tinyUser}
///
/// views
/// shall we save the records
///
///
/// saves
/// db : flyerID / saves / {userID : saveModel that has tinyUser}
///
/// reviews
/// db : flyerID / reviews / {userID} :