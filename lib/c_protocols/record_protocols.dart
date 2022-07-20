import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/record_ops.dart';
import 'package:flutter/material.dart';

class RecordProtocols {
// -----------------------------------------------------------------------------

  RecordProtocols();

// -----------------------------------------------------------------------------

  /// BZ

// ----------------------------------
  /// TESTED : ...
  static Future<void> followBz({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('RecordProtocols.followBz : START');

    final RecordModel _record = RecordModel.createFollowRecord(
        userID: superUserID(),
        bzID: bzID
    );

    await RecordOps.createRecord(
        context: context,
        record: _record,
    );

    blog('RecordProtocols.followBz : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> unfollowBz({
    @required BuildContext context,
    @required String bzID,
  }) async {

    blog('RecordProtocols.unfollowBz : START');

    final RecordModel _record = RecordModel.createUnfollowRecord(
        userID: superUserID(),
        bzID: bzID,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.unfollowBz : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> callBz({
    @required BuildContext context,
    @required String bzID,
    @required ContactModel contact,
  }) async {

    blog('RecordProtocols.callBz : START');

    final RecordModel _record = RecordModel.createCallRecord(
      userID: superUserID(),
      bzID: bzID,
      contact: contact,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.callBz : END');

  }
// -----------------------------------------------------------------------------

  /// FLYER

// ----------------------------------
  /// TESTED : ...
  static Future<void> shareFlyer({
    @required BuildContext context,
    @required String flyerID,
  }) async {

    blog('RecordProtocols.shareFlyer : START');

    final RecordModel _record = RecordModel.createShareRecord(
      userID: superUserID(),
      flyerID: flyerID,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.shareFlyer : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> viewFlyer({
    @required BuildContext context,
    @required String flyerID,
    @required int slideIndex,
    @required int seconds,
  }) async {

    blog('RecordProtocols.viewFlyer : START');

    final RecordModel _record = RecordModel.createViewRecord(
      userID: superUserID(),
      flyerID: flyerID,
      slideIndex: slideIndex,
      durationSeconds: seconds,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.viewFlyer : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> saveFlyer({
    @required BuildContext context,
    @required String flyerID,
    @required int slideIndex,
  }) async {

    blog('RecordProtocols.saveFlyer : START');

    final RecordModel _record = RecordModel.createSaveRecord(
      userID: superUserID(),
      flyerID: flyerID,
      slideIndex: slideIndex,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.saveFlyer : END');

  }
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> unSaveFlyer({
    @required BuildContext context,
    @required String flyerID,
    @required int slideIndex,
  }) async {

    blog('RecordProtocols.unSaveFlyer : START');

    final RecordModel _record = RecordModel.createUnSaveRecord(
      userID: superUserID(),
      flyerID: flyerID,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.unSaveFlyer : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createCreateReview({
    @required BuildContext context,
    @required String review,
    @required String flyerID,
  }) async {

    blog('RecordProtocols.createCreateReview : START');

    final RecordModel _record = RecordModel.createCreateReviewRecord(
      userID: superUserID(),
      review: review,
      flyerID: flyerID,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createCreateReview : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createEditReview({
    @required BuildContext context,
    @required String reviewEdit,
    @required String flyerID,
  }) async {

    blog('RecordProtocols.createEditReview : START');

    final RecordModel _record = RecordModel.createEditReviewRecord(
      userID: superUserID(),
      reviewEdit: reviewEdit,
      flyerID: flyerID,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createEditReview : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createDeleteReview({
    @required BuildContext context,
    @required String flyerID,
  }) async {

    blog('RecordProtocols.createDeleteReview : START');

    final RecordModel _record = RecordModel.createDeleteReviewRecord(
      userID: superUserID(),
      flyerID: flyerID,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createDeleteReview : END');

  }
// -----------------------------------------------------------------------------

  /// QUESTIONS

// ----------------------------------
  /// TESTED : ...
  static Future<void> createCreateQuestion({
    @required BuildContext context,
    @required String questionID,
  }) async {

    blog('RecordProtocols.createCreateQuestion : START');

    final RecordModel _record = RecordModel.createCreateQuestionRecord(
      userID: superUserID(),
      questionID: questionID,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createCreateQuestion : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createEditQuestion({
    @required BuildContext context,
    @required String questionID,
  }) async {

    blog('RecordProtocols.createEditQuestion : START');

    final RecordModel _record = RecordModel.createEditQuestionRecord(
      userID: superUserID(),
      questionID: questionID,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createEditQuestion : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createDeleteQuestion({
    @required BuildContext context,
    @required String questionID,
  }) async {

    blog('RecordProtocols.createDeleteQuestion : START');

    final RecordModel _record = RecordModel.createDeleteQuestionRecord(
      userID: superUserID(),
      questionID: questionID,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createDeleteQuestion : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createCreateAnswer({
    @required BuildContext context,
    @required String questionID,
    @required String answerID,
  }) async {

    blog('RecordProtocols.createCreateAnswer : START');

    final RecordModel _record = RecordModel.createCreateAnswerRecord(
      userID: superUserID(),
      questionID: questionID,
      answerID: answerID,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createCreateAnswer : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createEditAnswer({
    @required BuildContext context,
    @required String questionID,
    @required String answerID,
  }) async {

    blog('RecordProtocols.createEditAnswer : START');

    final RecordModel _record = RecordModel.createEditAnswerRecord(
      userID: superUserID(),
      questionID: questionID,
      answerID: answerID,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createEditAnswer : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createDeleteAnswer({
    @required BuildContext context,
    @required String questionID,
    @required String answerID,
  }) async {

    blog('RecordProtocols.createDeleteAnswer : START');

    final RecordModel _record = RecordModel.createDeleteAnswerRecord(
      userID: superUserID(),
      questionID: questionID,
      answerID: answerID,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createDeleteAnswer : END');

  }
// ----------------------------------
  /// TESTED : ...
  static Future<void> createSearch({
    @required BuildContext context,
    @required String searchText,
  }) async {

    blog('RecordProtocols.createSearch : START');

    final RecordModel _record = RecordModel.createSearchRecord(
      userID: superUserID(),
      searchText: searchText,
    );

    await RecordOps.createRecord(
      context: context,
      record: _record,
    );

    blog('RecordProtocols.createSearch : END');

  }
// ----------------------------------

}
