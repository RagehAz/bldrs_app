import 'package:bldrs/a_models/x_secondary/record_model.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/real_ops/record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class QuestionRecordRealOps {
  // -----------------------------------------------------------------------------

  const QuestionRecordRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE QUESTIONS RECORDS AND COUNTERS

  // --------------------
  /// TESTED : ...
  static Future<void> createCreateQuestion({
    @required String questionID,
  }) async {
    blog('QuestionRecordOps.createCreateQuestion : START');

    final RecordModel _record = RecordModel.createCreateQuestionRecord(
      userID: AuthFireOps.superUserID(),
      questionID: questionID,
    );

    await RecordRealOps.createRecord(
      record: _record,
    );

    blog('QuestionRecordOps.createCreateQuestion : END');
  }
  // --------------------
  /// TESTED : ...
  static Future<void> createEditQuestion({
    @required String questionID,
  }) async {
    blog('QuestionRecordOps.createEditQuestion : START');

    final RecordModel _record = RecordModel.createEditQuestionRecord(
      userID: AuthFireOps.superUserID(),
      questionID: questionID,
    );

    await RecordRealOps.createRecord(
      record: _record,
    );

    blog('QuestionRecordOps.createEditQuestion : END');
  }
  // --------------------
  /// TESTED : ...
  static Future<void> createDeleteQuestion({
    @required String questionID,
  }) async {
    blog('QuestionRecordOps.createDeleteQuestion : START');

    final RecordModel _record = RecordModel.createDeleteQuestionRecord(
      userID: AuthFireOps.superUserID(),
      questionID: questionID,
    );

    await RecordRealOps.createRecord(
      record: _record,
    );

    blog('QuestionRecordOps.createDeleteQuestion : END');
  }
  // --------------------
  /// TESTED : ...
  static Future<void> createCreateAnswer({
    @required String questionID,
    @required String answerID,
  }) async {
    blog('QuestionRecordOps.createCreateAnswer : START');

    final RecordModel _record = RecordModel.createCreateAnswerRecord(
      userID: AuthFireOps.superUserID(),
      questionID: questionID,
      answerID: answerID,
    );

    await RecordRealOps.createRecord(
      record: _record,
    );

    blog('QuestionRecordOps.createCreateAnswer : END');
  }
  // --------------------
  /// TESTED : ...
  static Future<void> createEditAnswer({
    @required String questionID,
    @required String answerID,
  }) async {
    blog('QuestionRecordOps.createEditAnswer : START');

    final RecordModel _record = RecordModel.createEditAnswerRecord(
      userID: AuthFireOps.superUserID(),
      questionID: questionID,
      answerID: answerID,
    );

    await RecordRealOps.createRecord(
      record: _record,
    );

    blog('QuestionRecordOps.createEditAnswer : END');
  }
  // --------------------
  /// TESTED : ...
  static Future<void> createDeleteAnswer({
    @required String questionID,
    @required String answerID,
  }) async {

    blog('QuestionRecordOps.createDeleteAnswer : START');

    final RecordModel _record = RecordModel.createDeleteAnswerRecord(
      userID: AuthFireOps.superUserID(),
      questionID: questionID,
      answerID: answerID,
    );

    await RecordRealOps.createRecord(
      record: _record,
    );

    blog('QuestionRecordOps.createDeleteAnswer : END');
  }
  // --------------------
}
