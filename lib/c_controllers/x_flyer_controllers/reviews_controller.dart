import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/c_protocols/review_protocols/a_reviews_protocols.dart';
import 'package:flutter/material.dart';

// void _onShowReviewOptions(ReviewModel reviewModel){
//   blog('_onShowReviewOptions : $reviewModel');
// }
// -----------------------------------------------------------------------------

/// REVIEW

// ----------------------------------
Future<void> onReviewFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required String text,
  // @required ValueNotifier<List<ReviewModel>> reviews,
}) async {

  final ReviewModel _uploadedReview = await ReviewProtocols.composeReview(
    context: context,
    text: text,
    flyerID: flyerModel.id,
  );

  // reviews.value = <ReviewModel>[_uploadedReview, ...reviews.value,];

}
// -----------------------------------------------------------------------------
