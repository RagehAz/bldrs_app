import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/a_models/secondary_models/record_model.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/real/ops/record_ops.dart';
import 'package:bldrs/e_db/real/ops/review_ops.dart';
import 'package:flutter/material.dart';

class ReviewProtocols {
// -----------------------------------------------------------------------------

  ReviewProtocols();

// -----------------------------------------------------------------------------
  static Future<ReviewModel> composeReview({
    @required BuildContext context,
    @required String text,
    @required String flyerID,
}) async {

    final ReviewModel _uploadedReview = await ReviewRealOps.createReview(
        context: context,
        text: text,
        flyerID: flyerID,
    );

    await RecordRealOps.createRecord(
        context: context,
        record: RecordModel.createCreateReviewRecord(
            userID: AuthFireOps.superUserID(),
            flyerID: flyerID,
            text: text,
        ),
    );

    return _uploadedReview;
  }
// -----------------------------------------------------------------------------
}
