import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:flutter/foundation.dart';

class ReviewModel {
  /// --------------------------------------------------------------------------
  const ReviewModel({
    @required this.reviewID, // will be random
    @required this.body,
    @required this.userID,
    @required this.time, // will order reviews by time
    @required this.flyerID, // will be docName
    @required this.replyAuthorID,
    @required this.reply,
    @required this.replyTime,
    @required this.likes,
  });
  /// --------------------------------------------------------------------------
  final String reviewID;
  final String body;
  final String userID;
  final DateTime time;
  final String flyerID;
  final String replyAuthorID;
  final String reply;
  final DateTime replyTime;
  final int likes;
// -----------------------------------------------------------------------------

  /// CLONING

// ------------------------------------------
  /// TESTED : WORKS PERFECT
  ReviewModel copyWith({
    String reviewID,
    String body,
    String userID,
    DateTime time,
    String flyerID,
    String replyAuthorID,
    String reply,
    DateTime replyTime,
    int likes,
  }){
    return ReviewModel(
        reviewID: reviewID ?? this.reviewID,
        body: body ?? this.body,
        userID: userID ?? this.userID,
        time: time ?? this.time,
        flyerID: flyerID ?? this.flyerID,
        replyAuthorID: replyAuthorID ?? this.replyAuthorID,
        reply: reply ?? this.reply,
        replyTime: replyTime ?? this.replyTime,
        likes: likes ?? this.likes,
    );
  }
// -----------------------------------------------------------------------------

  /// CYPHERS

// ------------------------------------------
  Map<String, dynamic> toMap({
    bool toJSON = false
  }) {
    return <String, dynamic>{
      'reviewID': reviewID,
      'body': body,
      'userID': userID,
      'time': Timers.cipherTime(time: time, toJSON: toJSON),
      'flyerID': flyerID,
      'replyAuthorID': replyAuthorID,
      'reply': reply,
      'replyTime': Timers.cipherTime(time: replyTime, toJSON: toJSON),
      'likes': likes,
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
        reviewID: map['reviewID'],
        body: map['body'],
        userID: map['userID'],
        time: Timers.decipherTime(time: map['replyTime'], fromJSON: fromJSON,),
        flyerID: map['flyerID'],
        replyAuthorID: map['replyAuthorID'],
        reply: map['reply'],
        replyTime:Timers.decipherTime(time: map['replyTime'], fromJSON: fromJSON,),
        likes: map['likes'],
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
  static ReviewModel dummyReview({
    @required String flyerID,
    @required String authorID,
  }) {
    return ReviewModel(
      reviewID: 'x',
      body: 'This is a dummy review that extends for several lines you know,, lorum ipsum plenty of gypsum',
      userID: AuthFireOps.superUserID(),
      time: Timers.createDate(year: 1987, month: 06, day: 10),
      flyerID: flyerID,
      replyAuthorID: authorID,
      reply: 'Very cool review, thank you',
      replyTime: DateTime.now(),
      likes: 135,
    );
  }
// -----------------------------------------------------------------------------

}
