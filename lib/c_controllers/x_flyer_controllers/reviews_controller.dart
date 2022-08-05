import 'dart:async';

import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/c_protocols/review_protocols/a_reviews_protocols.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
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
  @required ValueNotifier<Map<String, dynamic>> replaceMap,
  @required bool isAlreadyAgreed,
}) async {

  if (reviewModel != null && reviewModel.id != null){

    final ReviewModel _uploaded = await ReviewProtocols.agreeOnReview(
      context: context,
      reviewModel: reviewModel,
      isAlreadyAgreed: isAlreadyAgreed,
    );

    replaceMap.value = _uploaded.toMap(
      includeID: true,
      includeDocSnapshot: true,
    );

  }

}
// -----------------------------------------------------------------------------
Future<void> onBzReply({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required TextEditingController textController,
  @required ValueNotifier<Map<String, dynamic>> replaceMap,
}) async {

  blog('should reply to this flyer review');


}
// -----------------------------------------------------------------------------
Future<void> onReviewOptions({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required ValueNotifier<Map<String, dynamic>> replaceMapNotifier,
  @required ValueNotifier<Map<String, dynamic>> deleteMapNotifier,
}) async {

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: 2,
      builder: (_, PhraseProvider pro){

        return <Widget>[

          /// EDIT REVIEW
          BottomDialog.wideButton(
              context: context,
              verse: 'Edit',
              verseCentered: true,
              isDeactivated: reviewModel.userID != AuthFireOps.superUserID(),
              onTap: () async {

                Nav.goBack(context);

                await onEditReview(
                  context: context,
                  reviewModel: reviewModel,
                );

              }
          ),

          /// DELETE REVIEW
          BottomDialog.wideButton(
              context: context,
              verse: 'Delete',
              verseCentered: true,
              isDeactivated: reviewModel.userID != AuthFireOps.superUserID(),
              onTap: () async {

                Nav.goBack(context);

                await onDeleteReview(
                  context: context,
                  reviewModel: reviewModel,
                  deleteMap: deleteMapNotifier,
                );

              }
          ),

        ];

      }
  );

}
// -----------------------------------------------------------------------------
Future<void> onEditReview({
  @required BuildContext context,
  @required ReviewModel reviewModel,
}) async {

  blog('should edit this fucking review naaaw');

}
// -----------------------------------------------------------------------------
Future<void> onDeleteReview({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required ValueNotifier<Map<String, dynamic>> deleteMap,
}) async {

  final bool _canContinue = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Delete Review ?',
    body: 'Your review on this flyer will be permanently deleted',
    boolDialog: true,
  );

  if (_canContinue == true){

    await ReviewProtocols.wipeSingleReview(
      context: context,
      reviewModel: reviewModel,
    );

    deleteMap.value = reviewModel.toMap(
        includeID: true,
        includeDocSnapshot: true,
    );

    unawaited(TopDialog.showTopDialog(
      context: context,
      firstLine: 'Review has been deleted successfully',
    ));

  }


}
// -----------------------------------------------------------------------------
