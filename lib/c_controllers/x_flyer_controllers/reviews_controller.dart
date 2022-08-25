import 'dart:async';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/c_protocols/review_protocols/a_reviews_protocols.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

// void _onShowReviewOptions(ReviewModel reviewModel){
//   blog('_onShowReviewOptions : $reviewModel');
// }
///
// -----------------------------------------------------------------------------

/// CREATE NEW REVIEW

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
    bzID: flyerModel.bzID,
  );

  textController.text = '';
  Keyboard.closeKeyboard(context);

  addMap.value = _uploadedReview.toMap(includeID: true, includeDocSnapshot: true);

}
// -----------------------------------------------------------------------------

/// AGREE

// ----------------------------------
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

/// REVIEW OPTIONS

// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onReviewOptions({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required ValueNotifier<Map<String, dynamic>> replaceMapNotifier,
  @required ValueNotifier<Map<String, dynamic>> deleteMapNotifier,
  @required String bzID,
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
              verse: xPhrase(context, '##Edit'),
              verseCentered: true,
              isDeactivated: reviewModel.userID != AuthFireOps.superUserID(),
              onTap: () async {

                Nav.goBack(
                  context: context,
                  invoker: 'onReviewOptions.Edit',
                );

                await _onEditReview(
                  context: context,
                  reviewModel: reviewModel,
                  replaceMapNotifier: replaceMapNotifier,
                );

              }
          ),

          /// DELETE REVIEW
          BottomDialog.wideButton(
              context: context,
              verse: xPhrase(context, '##Delete'),
              verseCentered: true,
              isDeactivated: reviewModel.userID != AuthFireOps.superUserID(),
              onTap: () async {

                Nav.goBack(
                  context: context,
                  invoker: 'onReviewOptions.Delete',
                );

                await _onDeleteReview(
                  context: context,
                  reviewModel: reviewModel,
                  deleteMap: deleteMapNotifier,
                  bzID: bzID,
                );

              }
          ),

        ];

      }
  );

}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> _onEditReview({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required ValueNotifier<Map<String, dynamic>> replaceMapNotifier,
}) async {

  bool _isConfirmed = false;

  final String _shit = await Dialogs.keyboardDialog(
    context: context,
    keyboardModel: KeyboardModel(
      titleVerse: 'Edit Your Review',
      hintVerse: 'What do you think of this flyer ?',
      controller: TextEditingController(text: reviewModel.text),
      maxLines: 5,
      textInputAction: TextInputAction.newline,
      focusNode: FocusNode(),
      isFloatingField: false,
      onSubmitted: (String text){

        _isConfirmed = true;

        },
    ),

  );

  if (_shit != reviewModel.text && _isConfirmed == true){

    final ReviewModel _updated = reviewModel.copyWith(
      text: _shit,
    );

    await ReviewProtocols.renovateReview(
      context: context,
      reviewModel: _updated,
    );

    replaceMapNotifier.value = _updated.toMap(
      includeID: true,
      includeDocSnapshot: true,
    );

    unawaited(TopDialog.showTopDialog(
      context: context,
      firstLine: 'Review has been updated',
    ));

  }

}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> _onDeleteReview({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required ValueNotifier<Map<String, dynamic>> deleteMap,
  @required String bzID,
}) async {

  final bool _canContinue = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: 'Delete Review ?',
    bodyVerse: 'Your review on this flyer will be permanently deleted',
    boolDialog: true,
  );

  if (_canContinue == true){

    await ReviewProtocols.wipeSingleReview(
      context: context,
      reviewModel: reviewModel,
      bzID: bzID,
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

/// BZ REPLY

// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onBzReply({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required ValueNotifier<Map<String, dynamic>> replaceMapNotifier,
}) async {

  bool _isConfirmed = false;

  final String _shit = await Dialogs.keyboardDialog(
    context: context,
    keyboardModel: KeyboardModel(
      titleVerse: 'Reply to this review',
      hintVerse: 'Reply ...',
      controller: TextEditingController(text: reviewModel.reply),
      maxLines: 5,
      textInputAction: TextInputAction.newline,
      focusNode: FocusNode(),
      isFloatingField: false,
      onSubmitted: (String text){

        _isConfirmed = true;

      },
    ),

  );

  if (_shit != reviewModel.text && _isConfirmed == true){

    final ReviewModel _updated = reviewModel.copyWith(
      reply: _shit,
      replyAuthorID: AuthFireOps.superUserID(),
      replyTime: DateTime.now(),
    );

    await ReviewProtocols.renovateReview(
      context: context,
      reviewModel: _updated,
    );

    replaceMapNotifier.value = _updated.toMap(
      includeID: true,
      includeDocSnapshot: true,
    );

    unawaited(TopDialog.showTopDialog(
      context: context,
      firstLine: 'Your reply has been posted',
    ));

  }

}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onReplyOptions({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required ValueNotifier<Map<String, dynamic>> replaceMapNotifier,
}) async {

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: 2,
      builder: (_, PhraseProvider pro){

        return <Widget>[

          /// EDIT REPLY
          BottomDialog.wideButton(
              context: context,
              verse: xPhrase(context, '##Edit'),
              verseCentered: true,
              onTap: () async {

                Nav.goBack(
                  context: context,
                  invoker: 'onReplyOptions.Edit',
                );

                await _onEditReply(
                  context: context,
                  reviewModel: reviewModel,
                  replaceMapNotifier: replaceMapNotifier,
                );

              }
          ),

          /// DELETE REPLY
          BottomDialog.wideButton(
              context: context,
              verse: xPhrase(context, '##Delete'),
              verseCentered: true,
              onTap: () async {

                Nav.goBack(
                  context: context,
                  invoker: 'onReplyOptions.Delete',
                );

                await _onDeleteReply(
                  context: context,
                  reviewModel: reviewModel,
                  replaceMapNotifier: replaceMapNotifier,
                );

              }
          ),

        ];

      }
  );

}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> _onEditReply({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required ValueNotifier<Map<String, dynamic>> replaceMapNotifier,
}) async {

  bool _isConfirmed = false;

  final String _shit = await Dialogs.keyboardDialog(
    context: context,
    keyboardModel: KeyboardModel(
      titleVerse: 'Edit Your Reply',
      hintVerse: 'Reply',
      controller: TextEditingController(text: reviewModel.reply),
      maxLines: 5,
      textInputAction: TextInputAction.newline,
      focusNode: FocusNode(),
      isFloatingField: false,
      onSubmitted: (String text){

        _isConfirmed = true;

      },
    ),

  );

  if (_shit != reviewModel.text && _isConfirmed == true){

    final ReviewModel _updated = reviewModel.copyWith(
      reply: _shit,
      replyAuthorID: AuthFireOps.superUserID(),
    );

    await ReviewProtocols.renovateReview(
      context: context,
      reviewModel: _updated,
    );

    replaceMapNotifier.value = _updated.toMap(
      includeID: true,
      includeDocSnapshot: true,
    );

    unawaited(TopDialog.showTopDialog(
      context: context,
      firstLine: 'Reply has been updated',
    ));

  }


}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> _onDeleteReply({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required ValueNotifier<Map<String, dynamic>> replaceMapNotifier,
}) async {

  final bool _canContinue = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: 'Delete Reply ?',
    bodyVerse: 'Your reply on this review will be permanently deleted',
    boolDialog: true,
  );

  if (_canContinue == true){

    final ReviewModel _updated = ReviewModel(
      id: reviewModel.id,
      text: reviewModel.text,
      userID: reviewModel.userID,
      time: reviewModel.time,
      flyerID: reviewModel.flyerID,
      replyAuthorID: null,
      reply: null,
      replyTime: null,
      agrees: reviewModel.agrees,
      docSnapshot: reviewModel.docSnapshot,
    );

    await ReviewProtocols.renovateReview(
      context: context,
      reviewModel: _updated,
    );

    replaceMapNotifier.value = _updated.toMap(
      includeID: true,
      includeDocSnapshot: true,
    );

    unawaited(TopDialog.showTopDialog(
      context: context,
      firstLine: 'Reply has been deleted',
    ));

  }


}
// ----------------------------------
