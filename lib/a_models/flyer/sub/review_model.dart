import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:flutter/foundation.dart';

/// TASK :  should use record model instead of review model
class ReviewModel {
  /// --------------------------------------------------------------------------
  const ReviewModel({
    @required this.body,
    @required this.userID,
    @required this.time,
    this.reviewID,
  });
  /// --------------------------------------------------------------------------
  final String reviewID; // has to be the userID for security rules
  final String body;
  final String userID;
  final DateTime time;

  /// TASK : Review model should be
  // final List<ReviewPost> posts; // ReviewPost(body:, time: , bzReply:, bzReplyTime: ,replyAuthorID: )
  // final DateTime lastTimeStamp; // to help firebase query
// -----------------------------------------------------------------------------

  /// CYPHERS

// ------------------------------------------
  Map<String, dynamic> toMap({
    bool toJSON = false
  }) {
    return <String, dynamic>{
      'body': body,
      'userID': userID,
      'time': Timers.cipherTime(time: time, toJSON: toJSON),
    };
  }
// ------------------------------------------
  static ReviewModel decipherReview({
    @required Map<String, dynamic> map,
    bool fromJSON
  }) {
    ReviewModel _review;

    if (map != null) {
      _review = ReviewModel(
        body: map['body'],
        userID: map['userID'],
        time: Timers.decipherTime(
            time: map['time'],
            fromJSON: fromJSON,
        ),
      );
    }

    return _review;
  }
// ------------------------------------------
  static List<ReviewModel> decipherReviews({
    @required List<Map<String, dynamic>> maps,
    bool fromJSON
  }) {
    final List<ReviewModel> _reviews = <ReviewModel>[];

    if (Mapper.checkCanLoopList(maps)) {
      for (final Map<String, dynamic> map in maps) {
        _reviews.add(decipherReview(
          map: map,
          fromJSON: fromJSON,
        ));
      }
    }
    return _reviews;
  }
// -----------------------------------------------------------------------------

  /// DUMMIES

// ------------------------------------------
  static ReviewModel dummyReview() {
    return ReviewModel(
      body:
          'This is a dummy review that extends for several lines you know,, lorum ipsum plenty of gypsum',
      userID: '2wviVfmJGyQon98JKRVSv25jxU33',
      time: DateTime.now(),
    );
  }
// -----------------------------------------------------------------------------

}
