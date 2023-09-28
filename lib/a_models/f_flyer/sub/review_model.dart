import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/foundation.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/time/timers.dart';
/// => TAMAM
@immutable
class ReviewModel {
  /// --------------------------------------------------------------------------
  const ReviewModel({
    required this.id, // will be random
    required this.text,
    required this.userID,
    required this.time, // will order reviews by time
    required this.flyerID, // will be docName
    required this.replyAuthorID,
    required this.reply,
    required this.replyTime,
    required this.agrees,
    this.docSnapshot,
  });
  /// --------------------------------------------------------------------------
  final String? id;
  final String? text;
  final String? userID;
  final DateTime? time;
  final String? flyerID;
  final String? replyAuthorID;
  final String? reply;
  final DateTime? replyTime;
  final int? agrees;
  final DocumentSnapshot<Object>? docSnapshot;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  ReviewModel copyWith({
    String? id,
    String? text,
    String? userID,
    DateTime? time,
    String? flyerID,
    String? replyAuthorID,
    String? reply,
    DateTime? replyTime,
    int? agrees,
    DocumentSnapshot<Object>? docSnapshot,
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
      agrees: agrees ?? this.agrees ?? 0,
      docSnapshot: docSnapshot ?? this.docSnapshot,
    );
  }
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap({
    bool toJSON = false,
    bool includeID = false,
    bool includeDocSnapshot = false,
  }) {

    Map<String, dynamic> _map = <String, dynamic>{
      'text': text,
      'userID': userID,
      'time': Timers.cipherTime(time: time, toJSON: toJSON),
      'flyerID': flyerID,
      'replyAuthorID': replyAuthorID,
      'reply': reply,
      'replyTime': Timers.cipherTime(time: replyTime, toJSON: toJSON),
      'agrees': agrees ?? 0,
    };

    if (includeID == true){
      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'id',
        value: id,
        overrideExisting: true,
      );
    }

    if (includeDocSnapshot == true){
      _map = Mapper.insertPairInMap(
        map: _map,
        key: 'docSnapshot',
        value: docSnapshot,
        overrideExisting: true,
      );
    }

    return _map;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static ReviewModel? decipherReview({
    required dynamic map,
    required String? reviewID,
    required bool fromJSON
  }) {
    ReviewModel? _review;

    if (map != null) {
      _review = ReviewModel(
        id: reviewID,
        text: map['text'],
        userID: map['userID'],
        time: Timers.decipherTime(time: map['time'], fromJSON: fromJSON,),
        flyerID: map['flyerID'],
        replyAuthorID: map['replyAuthorID'],
        reply: map['reply'],
        replyTime:Timers.decipherTime(time: map['replyTime'], fromJSON: fromJSON,),
        agrees: map['agrees'],
        docSnapshot: map['docSnapshot'],
      );
    }

    return _review;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<ReviewModel> decipherReviews({
    required List<Map<String, dynamic>>? maps,
    required bool fromJSON
  }) {
    final List<ReviewModel> _reviews = <ReviewModel>[];

    if (Mapper.checkCanLoopList(maps) == true) {
      for (final Map<String, dynamic> map in maps!) {

        final ReviewModel? _review = decipherReview(
          map: map,
          reviewID: map['id'],
          fromJSON: fromJSON,
        );

        if (_review != null){
          _reviews.add(_review);
        }

      }
    }
    return _reviews;
  }
  // -----------------------------------------------------------------------------

  /// DECIPHERS OF INTERNAL HASH LINKED MAP OBJECT OBJECT

  // --------------------
  /// TESTED : WORKS PERFECT
  // static ReviewModel decipherFromDataSnapshot(DataSnapshot snapshot){
  //
  //   ReviewModel _review;
  //
  //   if (snapshot != null && snapshot.value != null){
  //
  //     final Map<String, dynamic> _map = Mapper.getMapFromIHLMOO(
  //       ihlmoo: snapshot.value,
  //     );
  //
  //     _review = ReviewModel.decipherReview(
  //       map: _map,
  //       reviewID: snapshot.key,
  //       fromJSON: true,
  //     );
  //
  //   }
  //
  //   return _review;
  // }
  // -----------------------------------------------------------------------------

  /// CREATOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static ReviewModel createNewReview({
    required String text,
    required String? flyerID,
  }){
    return ReviewModel(
      id: 'x',
      text: text,
      userID: Authing.getUserID(),
      time: DateTime.now(),
      flyerID: flyerID,
      replyAuthorID: null,
      reply: null,
      replyTime: null,
      agrees: 0,
    );

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static ReviewModel? incrementAgrees({
    required ReviewModel? reviewModel,
    required bool isIncrementing,
  }){

    int _value = reviewModel?.agrees ?? 0;
    _value = isIncrementing == true ? _value + 1 : _value - 1;

    final ReviewModel? _output = reviewModel?.copyWith(
      agrees: _value < 0 ? 0 : _value,
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// IDS

  // --------------------
  /// bldrs.net/#/flyerPreview:flyerID_reviewID
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? createFlyerIDReviewIDLinkPart({
  required String? flyerID,
  required String? reviewID,
  }){

    if (flyerID == null || reviewID == null){
      return null;
    }
    else {
      return '${flyerID}_$reviewID';
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getFlyerIDFromLinkPart({
    required String? linkPart,
  }){

    if (linkPart == null){
      return null;
    }

    else {

      final String? _flyerID = TextMod.removeTextAfterLastSpecialCharacter(
          text: linkPart,
          specialCharacter: '_',
      );

      return _flyerID;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getReviewIDFromLinkPart({
    required String? linkPart,
  }){

    if (linkPart == null){
      return null;
    }

    else {

      final String? _reviewID = TextMod.removeTextBeforeLastSpecialCharacter(
          text: linkPart,
          specialCharacter: '_',
      );

      return _reviewID;
    }

  }
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /*
  static List<ReviewModel> sortReviews({
    required List<ReviewModel> reviews,
  }){

      List<ReviewModel> _output = <ReviewModel>[];

      if (Mapper.checkCanLoopList(reviews) == true){

        _output = <ReviewModel>[... reviews];
        _output.sort((ReviewModel a, ReviewModel b) => b.time.compareTo(a.time));

      }

      return _output;
    }
   */
  // -----------------------------------------------------------------------------

  /// DUMMIES

  // --------------------
  /// TESTED : WORKS PERFECT
  static ReviewModel dummyReview({
    required String flyerID,
    required String authorID,
  }) {
    return ReviewModel(
      id: 'x',
      text: 'This is a dummy review\nthat extends for several lines you know,,\nlorum ipsum\nplenty of gypsum',
      userID: Authing.getUserID(),
      time: Timers.createDate(year: 1987, month: 06, day: 10),
      flyerID: flyerID,
      replyAuthorID: authorID,
      reply: 'Very cool review, thank you',
      replyTime: DateTime.now(),
      agrees: 454545,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String createTempReviewID({
    required String? flyerID,
    required String? userID,
  }){
    return '${flyerID}_$userID';
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogReview({
    String? invoker = '',
  }){
      blog('blogReview : $invoker ------ START');
      blog('reviewID : $id');
      blog('text : $text');
      blog('userID : $userID');
      blog('time : $time');
      blog('flyerID : $flyerID');
      blog('replyAuthorID : $replyAuthorID');
      blog('reply : $reply');
      blog('replyTime : $replyTime');
      blog('agrees : $agrees');
      blog('blogReview : $invoker  ------ END');
    }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogReviews({
    required List<ReviewModel> reviews,
    String? invoker,
  }){
    blog('blogReviews : $invoker -------------------------------------- START');
    if (Mapper.checkCanLoopList(reviews) == true){
      for (final ReviewModel review in reviews){
        review.blogReview(invoker: invoker);
      }
    }
    else {
      blog('no reviews to blog');
    }

    blog('blogReviews : $invoker -------------------------------------- END');
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkReviewsAreIdentical({
    required ReviewModel? review1,
    required ReviewModel? review2,
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
          review1.agrees == review2.agrees
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is ReviewModel){
      _areIdentical = checkReviewsAreIdentical(
        review1: this,
        review2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
  id.hashCode^
  text.hashCode^
  userID.hashCode^
  time.hashCode^
  flyerID.hashCode^
  replyAuthorID.hashCode^
  reply.hashCode^
  replyTime.hashCode^
  agrees.hashCode^
  docSnapshot.hashCode;
  // -----------------------------------------------------------------------------
}
