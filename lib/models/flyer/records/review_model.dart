import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ReviewModel {
  final String review;
  final String userID;
  final DateTime time;

  ReviewModel ({
    @required this.review,
    @required this.userID,
    @required this.time,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return
        {
          'review' : review,
          'userID' : userID,
          'time' : Timers.cipherDateTimeToString(time),
        };
  }
// -----------------------------------------------------------------------------
  static ReviewModel decipherReview(Map<String, dynamic> map){
    ReviewModel _review;

    if (map != null){
      _review = ReviewModel(
          review: map['review'],
          userID: map['userID'],
          time: Timers.decipherDateTimeString(map['time']),
      );
    }

    return _review;
  }
// -----------------------------------------------------------------------------
  static ReviewModel dummyReview(){
    return
        ReviewModel(
            review: 'This is a dummy review that extends for several lines you know,, lorum ipsum plenty of gypsum',
            userID: '2wviVfmJGyQon98JKRVSv25jxU33',
            time: DateTime.now(),
        );
  }
// -----------------------------------------------------------------------------
  Stream<ReviewModel> decipherReviewsStream(Stream<QuerySnapshot> snapshots){
    // final Stream<QuerySnapshot> _chatSnapshots = _chatsCollection.orderBy(
    //     'at', descending: false).snapshots();

  }
}