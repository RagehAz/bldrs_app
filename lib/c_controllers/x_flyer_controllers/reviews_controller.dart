import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/c_protocols/review_protocols/a_reviews_protocols.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
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
  @required TextEditingController textController,
  @required ValueNotifier<List<Map<String, dynamic>>> extraMaps,
}) async {

  final ReviewModel _uploadedReview = await ReviewProtocols.composeReview(
    context: context,
    text: textController.text,
    flyerID: flyerModel.id,
  );

  textController.text = '';
  closeKeyboard(context);

  extraMaps.value = <Map<String, dynamic>>[...extraMaps.value, _uploadedReview.toMap()];

}
// -----------------------------------------------------------------------------
