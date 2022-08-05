import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/c_protocols/review_protocols/a_reviews_protocols.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

// void _onShowReviewOptions(ReviewModel reviewModel){
//   blog('_onShowReviewOptions : $reviewModel');
// }
// -----------------------------------------------------------------------------

/// REVIEW

// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onSubmitReview({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required TextEditingController textController,
  @required ValueNotifier<Map<String, dynamic>> addMap,
}) async {

  final ReviewModel _uploadedReview = await ReviewProtocols.composeReview(
    context: context,
    text: textController.text,
    flyerID: flyerModel.id,
  );

  textController.text = '';
  closeKeyboard(context);

  addMap.value = _uploadedReview.toMap(includeID: true, includeDocSnapshot: true);

}
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> onReviewAgree({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required ValueNotifier<Map<String, dynamic>> mapOverride,
  @required bool isAlreadyAgreed,
}) async {

  if (reviewModel != null && reviewModel.id != null){

    final ReviewModel _uploaded = await ReviewProtocols.agreeOnReview(
      context: context,
      reviewModel: reviewModel,
      isAlreadyAgreed: isAlreadyAgreed,
    );

    mapOverride.value = _uploaded.toMap(
      includeID: true,
      includeDocSnapshot: true,
    );

  }

}
// -----------------------------------------------------------------------------
Future<void> onReviewReply({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required TextEditingController textController,
  @required ValueNotifier<Map<String, dynamic>> mapOverride,
}) async {

  blog('should reply to this flyer review');


}
// -----------------------------------------------------------------------------
