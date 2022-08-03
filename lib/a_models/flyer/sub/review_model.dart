import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';

class ReviewModel {
  /// --------------------------------------------------------------------------
  const ReviewModel({
    @required this.id, // will be random
    @required this.text,
    @required this.userID,
    @required this.time, // will order reviews by time
    @required this.flyerID, // will be docName
    @required this.replyAuthorID,
    @required this.reply,
    @required this.replyTime,
    @required this.likesUsersIDs,
    @required this.number,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String text;
  final String userID;
  final DateTime time;
  final String flyerID;
  final String replyAuthorID;
  final String reply;
  final DateTime replyTime;
  final List<String> likesUsersIDs;
  final int number; // used to order reviews
// -----------------------------------------------------------------------------

  /// CLONING

// --------------------------------------
  /// TESTED : WORKS PERFECT
  ReviewModel copyWith({
    String id,
    String text,
    String userID,
    DateTime time,
    String flyerID,
    String replyAuthorID,
    String reply,
    DateTime replyTime,
    int likesUsersIDs,
    int number,
  }){
    return ReviewModel(
      id: id ?? this.id,
      text: text ?? this.text,
      userID: userID ?? this.userID,
      time: time ?? this.time,
      flyerID: flyerID ?? this.flyerID,
      replyAuthorID: replyAuthorID ?? this.replyAuthorID,
      reply: reply ?? this.reply,
      replyTime: replyTime ?? this.replyTime,
      likesUsersIDs: likesUsersIDs ?? this.likesUsersIDs,
      number: number ?? this.number,
    );
  }
// -----------------------------------------------------------------------------

  /// CYPHERS

// --------------------------------------
  Map<String, dynamic> toMap({
    bool toJSON = false,
    bool includeID = false,
  }) {

    Map<String, dynamic> _map = <String, dynamic>{
      'text': text,
      'userID': userID,
      'time': Timers.cipherTime(time: time, toJSON: toJSON),
      'flyerID': flyerID,
      'replyAuthorID': replyAuthorID,
      'reply': reply,
      'replyTime': Timers.cipherTime(time: replyTime, toJSON: toJSON),
      'likesUsersIDs': likesUsersIDs,
      'number': number,
    };

    if (includeID == true){
      _map = Mapper.insertPairInMap(
          map: _map,
          key: 'id',
          value: id,
      );
    }

    return _map;
  }
// --------------------------------------
  static ReviewModel decipherReview({
    @required dynamic map,
    bool fromJSON
  }) {
    ReviewModel _review;

    if (map != null) {
      _review = ReviewModel(
        id: map['id'],
        text: map['text'],
        userID: map['userID'],
        time: Timers.decipherTime(time: map['time'], fromJSON: fromJSON,),
        flyerID: map['flyerID'],
        replyAuthorID: map['replyAuthorID'],
        reply: map['reply'],
        replyTime:Timers.decipherTime(time: map['replyTime'], fromJSON: fromJSON,),
        likesUsersIDs: Mapper.getStringsFromDynamics(dynamics: map['likesUsersIDs']),
        number: map['number'],
      );
    }

    return _review;
  }
// --------------------------------------
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

// --------------------------------------
  static ReviewModel createNewReview({
    @required String text,
    @required String flyerID,
  }){
    return ReviewModel(
      id: 'x',
      text: text,
      userID: AuthFireOps.superUserID(),
      time: DateTime.now(),
      flyerID: flyerID,
      replyAuthorID: null,
      reply: null,
      replyTime: null,
      likesUsersIDs: <String>[],
      number: Numeric.createUniqueID(),
    );

  }
// -----------------------------------------------------------------------------

  /// SORTING

// --------------------------------------
  static List<ReviewModel> sortReviews({
  @required List<ReviewModel> reviews,
}){

    List<ReviewModel> _output = <ReviewModel>[];

    if (Mapper.checkCanLoopList(reviews) == true){

      _output = <ReviewModel>[... reviews];
      _output.sort((ReviewModel a, ReviewModel b) => b.time.compareTo(a.time));

    }

    return _output;
  }
// -----------------------------------------------------------------------------

  /// DUMMIES

// --------------------------------------
  static ReviewModel dummyReview({
    @required String flyerID,
    @required String authorID,
  }) {
    return ReviewModel(
      id: 'x',
      text: 'This is a dummy review\nthat extends for several lines you know,,\nlorum ipsum\nplenty of gypsum',
      userID: AuthFireOps.superUserID(),
      time: Timers.createDate(year: 1987, month: 06, day: 10),
      flyerID: flyerID,
      replyAuthorID: authorID,
      reply: 'Very cool review, thank you',
      replyTime: DateTime.now(),
      number: Numeric.createUniqueID(),
      likesUsersIDs: <String>[
        AuthFireOps.superUserID(),
      ],
    );
  }
// -----------------------------------------------------------------------------

/// BLOGGING

// --------------------------------------
  void blogReview({
  String methodName = '',
}){
    blog('blogReview : $methodName ------ START');
    blog('reviewID : $id');
    blog('text : $text');
    blog('userID : $userID');
    blog('time : $time');
    blog('flyerID : $flyerID');
    blog('replyAuthorID : $replyAuthorID');
    blog('reply : $reply');
    blog('replyTime : $replyTime');
    blog('likesUsersIDs : $likesUsersIDs');
    blog('blogReview : $methodName  ------ END');
  }
// --------------------------------------
  static void blogReviews({
    @required List<ReviewModel> reviews,
    String methodName,
  }){
    blog('blogReviews : $methodName -------------------------------------- START');
    if (Mapper.checkCanLoopList(reviews) == true){
      for (final ReviewModel review in reviews){
        review.blogReview(methodName: methodName);
      }
    }
    else {
      blog('no reviews to blog');
    }

    blog('blogReviews : $methodName -------------------------------------- END');
  }
// -----------------------------------------------------------------------------

  /// CHECKERS

// --------------------------------------
  /// TESTED : WORKS PERFECT
  static bool checkReviewsAreIdentical({
    @required ReviewModel review1,
    @required ReviewModel review2,
  }){
    bool _areIdentical = false;

    if (review1 != null && review2 != null){

      if (
          review1.id == review2.id &&
          review1.text == review2.text &&
          review1.userID == review2.userID &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.second, time1: review1.time, time2: review2.time) == true &&
          review1.flyerID == review2.flyerID &&
          review1.replyAuthorID == review2.replyAuthorID &&
          review1.reply == review2.reply &&
          Timers.checkTimesAreIdentical(accuracy: TimeAccuracy.second, time1: review1.replyTime, time2: review2.replyTime) == true &&
          Mapper.checkListsAreIdentical(list1: review1.likesUsersIDs, list2: review2.likesUsersIDs) &&
          review1.number == review2.number
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
// -----------------------------------------------------------------------------
}
