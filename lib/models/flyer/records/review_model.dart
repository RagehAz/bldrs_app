import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:flutter/foundation.dart';

class ReviewModel {
  final String reviewID; // has to be the userID for security rules
  final String body;
  final String userID;
  final DateTime time;

  /// TASK : Review model should be
  // final List<ReviewPost> posts; // ReviewPost(body:, time: , bzReply:, bzReplyTime: ,replyAuthorID: )
  // final DateTime lastTimeStamp; // to help firebase query

  const ReviewModel ({
    this.reviewID,
    @required this.body,
    @required this.userID,
    @required this.time,
});
// -----------------------------------------------------------------------------
  Map<String, dynamic> toMap(){
    return
        {
          'body' : body,
          'userID' : userID,
          'time' : Timers.cipherDateTimeToString(time),
        };
  }
// -----------------------------------------------------------------------------
  static ReviewModel decipherReview(Map<String, dynamic> map){
    ReviewModel _review;

    if (map != null){
      _review = ReviewModel(
          body: map['body'],
          userID: map['userID'],
          time: Timers.decipherDateTimeString(map['time']),
      );
    }

    return _review;
  }

  static List<ReviewModel> decipherReviews(List<dynamic> maps){
    final List<ReviewModel> _reviews = <ReviewModel>[];

    if (maps != null && maps.length != 0){

      for (var map in maps){
        _reviews.add(decipherReview(map));
      }

    }
    return _reviews;
  }
// -----------------------------------------------------------------------------
  static ReviewModel dummyReview(){
    return
        ReviewModel(
            body: 'This is a dummy review that extends for several lines you know,, lorum ipsum plenty of gypsum',
            userID: '2wviVfmJGyQon98JKRVSv25jxU33',
            time: DateTime.now(),
        );
  }
// -----------------------------------------------------------------------------
//   Stream<ReviewModel> decipherReviewsStream(Stream<QuerySnapshot> snapshots){
//     // final Stream<QuerySnapshot> _chatSnapshots = _chatsCollection.orderBy(
//     //     'at', descending: false).snapshots();
//
//   }
}