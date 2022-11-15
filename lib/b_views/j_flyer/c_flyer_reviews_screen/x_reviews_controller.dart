import 'dart:async';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/a_models/x_ui/keyboard_model.dart';
import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/review_protocols/protocols/a_reviews_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/e_back_end/z_helpers/pagination_controller.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// LAST SESSION

// ---------------------------------------
/// TESTED : WORKS PERFECT
Future<void> loadReviewEditorLastSession({
  @required BuildContext context,
  @required TextEditingController reviewController,
  @required String flyerID,
}) async {

  final ReviewModel _lastSessionReview = await FlyerLDBOps.loadReviewSession(
    reviewID: ReviewModel.createTempReviewID(
      flyerID: flyerID,
      userID: AuthFireOps.superUserID(),
    ),
  );

  if (_lastSessionReview != null){

    // final bool _continue = await CenterDialog.showCenterDialog(
    //   context: context,
    //   titleVerse: 'phid_load_last_session_data_q',
    //   bodyVerse: 'phid_want_to_load_last_session_q',
    //   boolDialog: true,
    // );
    //
    // if (_continue == true){

    reviewController.text = _lastSessionReview.text;

    // }

  }

}
// ---------------------------------------
/// TESTED : WORKS PERFECT
Future<void> saveReviewEditorSession({
  @required TextEditingController reviewController,
  @required String flyerID,
}) async {

  await FlyerLDBOps.saveReviewSession(
    review: ReviewModel(
        id: ReviewModel.createTempReviewID(
          flyerID: flyerID,
          userID: AuthFireOps.superUserID(),
        ),
        text: reviewController.text,
        userID: AuthFireOps.superUserID(),
        time: DateTime.now(),
        flyerID: flyerID,
        replyAuthorID: null,
        reply: null,
        replyTime: null,
        agrees: null
    ),
  );

}
// -----------------------------------------------------------------------------

/// CREATE NEW REVIEW

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSubmitReview({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required TextEditingController textController,
  @required PaginationController paginationController,
  @required ValueNotifier<bool> isUploading,
  @required bool mounted,
}) async {

  /// USER IS NOT SIGNED IN
  if (AuthModel.userIsSignedIn() == false){
    await Dialogs.youNeedToBeSignedInDialog(context);
  }

  /// USER IS SIGNED IN
  else {

    /// TEXT FIELD IS EMPTY
    if (TextCheck.isEmpty(textController.text.trim()) == true){
      await Dialogs.centerNotice(
        context: context,
        verse: const Verse(
          text: 'phid_add_review_to_submit',
          translate: true,
        ),
      );
    }

    /// CAN POST REVIEW
    else {

      Keyboard.closeKeyboard(context);

      final ReviewModel _reviewModel = ReviewModel.createNewReview(
        text: textController.text,
        flyerID: flyerModel.id,
      );

      setNotifier(
        notifier: isUploading,
        mounted: mounted,
        value: true,
      );

      await Future.wait(<Future>[

        FlyerLDBOps.deleteReviewSession(
          reviewID: ReviewModel.createTempReviewID(
            flyerID: flyerModel.id,
            userID: AuthFireOps.superUserID(),
          ),
        ),

        ReviewProtocols.composeReview(
          context: context,
          reviewModel: _reviewModel,
          bzID: flyerModel.bzID,
        ).then((ReviewModel uploadedReview){

          paginationController.addMap.value = uploadedReview.toMap(
            includeID: true,
            includeDocSnapshot: true,
          );

          textController.text = '';

        }),

      ]);

      setNotifier(
        notifier: isUploading,
        mounted: mounted,
        value: false,
      );

    }

  }

}
// -----------------------------------------------------------------------------

/// AGREE

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onReviewAgree({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required PaginationController paginationController,
  @required bool isAgreed,
}) async {

  /// USER IS NOT SIGNED IN
  if (AuthFireOps.superUserID() == null){
    await Dialogs.youNeedToBeSignedInDialog(context);
  }

  /// USER IS SIGNED IN
  else {
    if (reviewModel != null && reviewModel.id != null){

      final ReviewModel _uploaded = await ReviewProtocols.agreeOnReview(
        reviewModel: reviewModel,
        isAgreed: isAgreed,
      );

      paginationController.replaceMapByID(
        map: _uploaded.toMap(
          includeID: true,
          includeDocSnapshot: true,
        ),
      );

    }
  }


}
// -----------------------------------------------------------------------------

/// REVIEW OPTIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onReviewOptions({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required PaginationController paginationController,
  @required String bzID,
}) async {

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: 2,
      builder: (_){

        return <Widget>[

          /// EDIT REVIEW
          BottomDialog.wideButton(
              context: context,
              verse: const Verse(
                text: 'phid_edit',
                translate: true,
              ),
              verseCentered: true,
              isDeactivated: reviewModel.userID != AuthFireOps.superUserID(),
              onTap: () async {

                await Nav.goBack(
                  context: context,
                  invoker: 'onReviewOptions.Edit',
                );

                await _onEditReview(
                  context: context,
                  reviewModel: reviewModel,
                  paginationController: paginationController,
                );

              }
          ),

          /// DELETE REVIEW
          BottomDialog.wideButton(
              context: context,
              verse: const Verse(
                text: 'phid_delete',
                translate: true,
              ),
              verseCentered: true,
              isDeactivated: reviewModel.userID != AuthFireOps.superUserID(),
              onTap: () async {

                await Nav.goBack(
                  context: context,
                  invoker: 'onReviewOptions.Delete',
                );

                await _onDeleteReview(
                  context: context,
                  reviewModel: reviewModel,
                  paginationController: paginationController,
                  bzID: bzID,
                );

              }
          ),

        ];

      }
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onEditReview({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required PaginationController paginationController,
}) async {

  bool _isConfirmed = false;

  final String _shit = await Dialogs.keyboardDialog(
    context: context,
    keyboardModel: KeyboardModel(
      titleVerse: const Verse(
        text: 'phid_edit_your_review',
        translate: true,
      ),
      hintVerse: const Verse(
        text: 'phid_what_do_you_think_of_this_flyer_?',
        translate: true,
      ),
      initialText: reviewModel.text,
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
      reviewModel: _updated,
    );

    paginationController.replaceMap.value = _updated.toMap(
      includeID: true,
      includeDocSnapshot: true,
    );

    unawaited(TopDialog.showTopDialog(
      context: context,
      firstVerse: const Verse(
        text: 'phid_review_has_been_updated',
        translate: true,
      ),
    ));

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onDeleteReview({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required PaginationController paginationController,
  @required String bzID,
}) async {

  final bool _canContinue = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      text: 'phid_delete_review_?',
      translate: true,
    ),
    bodyVerse: const Verse(
      text: 'phid_review_will_be_deleted',
      translate: true,
    ),
    boolDialog: true,
    invertButtons: true,
  );

  if (_canContinue == true){

    await ReviewProtocols.wipeSingleReview(
      reviewModel: reviewModel,
      bzID: bzID,
    );

    paginationController.deleteMap.value = reviewModel.toMap(
      includeID: true,
      includeDocSnapshot: true,
    );

    unawaited(TopDialog.showTopDialog(
      context: context,
      firstVerse: const Verse(
        pseudo: 'Review has been deleted successfully',
        text: 'phid_review_deleted_successfully',
        translate: true,
      ),
    ));

  }

}
// -----------------------------------------------------------------------------

/// GO TO REVIEWER - REPLIER PROFILES

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onReviewUserBalloonTap({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  await Nav.jumpToUserPreviewScreen(
    context: context,
    userID: userModel.id,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onReplyBzBalloonTap({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  await Nav.jumpToBzPreviewScreen(
    context: context,
    bzID: bzModel.id,
  );

}
// -----------------------------------------------------------------------------

/// BZ REPLY

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onBzReply({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required PaginationController paginationController,
  @required String bzID,
}) async {

  final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
  );

  final bool _imAuthorInThisBz = AuthorModel.checkUserIsAuthorInThisBz(
      bzID: bzID,
      userModel: _myUserModel
  );

  if (_imAuthorInThisBz == true){

    bool _isConfirmed = false;

    final String _reply = await Dialogs.keyboardDialog(
      context: context,
      keyboardModel: KeyboardModel(
        titleVerse: const Verse(
          text: 'phid_reply_to_flyer',
          translate: true,
        ),
        hintVerse: const Verse(
          pseudo: 'Reply ...',
          text: 'phid_reply_dots',
          translate: true,
        ),
        initialText: reviewModel.reply,
        maxLines: 5,
        textInputAction: TextInputAction.newline,
        focusNode: FocusNode(),
        isFloatingField: false,
        onSubmitted: (String text){

          _isConfirmed = true;

        },
      ),

    );

    blog('reply : $_reply : _isConfirmed : $_isConfirmed');

    if (TextCheck.isEmpty(_reply) == false && _isConfirmed == true){

      final ReviewModel _updated = reviewModel.copyWith(
        reply: _reply,
        replyAuthorID: AuthFireOps.superUserID(),
        replyTime: DateTime.now(),
      );

      paginationController.replaceMap.value = _updated.toMap(
        includeID: true,
        includeDocSnapshot: true,
      );

      await ReviewProtocols.composeReviewReply(
          context: context,
          updatedReview: _updated,
          bzID: bzID,
      );

      unawaited(TopDialog.showTopDialog(
        context: context,
        firstVerse: const Verse(
          pseudo: 'Your reply has been posted',
          text: 'phid_your_reply_has_been_posted',
          translate: true,
        ),
      ));

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onReplyOptions({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required PaginationController paginationController,
}) async {

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: 2,
      builder: (_){

        return <Widget>[

          /// EDIT REPLY
          BottomDialog.wideButton(
              context: context,
              verse: const Verse(text: 'phid_edit', translate: true),
              verseCentered: true,
              onTap: () async {

                await Nav.goBack(
                  context: context,
                  invoker: 'onReplyOptions.Edit',
                );

                await _onEditReply(
                  context: context,
                  reviewModel: reviewModel,
                  paginationController: paginationController,
                );

              }
          ),

          /// DELETE REPLY
          BottomDialog.wideButton(
              context: context,
              verse: const Verse(text: 'phid_delete', translate: true),
              verseCentered: true,
              onTap: () async {

                await Nav.goBack(
                  context: context,
                  invoker: 'onReplyOptions.Delete',
                );

                await _onDeleteReply(
                  context: context,
                  reviewModel: reviewModel,
                  paginationController: paginationController,
                );

              }
          ),

        ];

      }
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onEditReply({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required PaginationController paginationController,
}) async {

  bool _isConfirmed = false;

  final String _shit = await Dialogs.keyboardDialog(
    context: context,
    keyboardModel: KeyboardModel(
      titleVerse: const Verse(
        text: 'phid_edit_your_reply',
        translate: true,
      ),
      hintVerse: const Verse(
        text: 'phid_reply',
        translate: true,
      ),
      initialText: reviewModel.reply,
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
      reviewModel: _updated,
    );

    paginationController.replaceMap.value = _updated.toMap(
      includeID: true,
      includeDocSnapshot: true,
    );

    unawaited(TopDialog.showTopDialog(
      context: context,
      firstVerse: const Verse(
        text: 'phid_reply_has_been_updated',
        translate: true,
      ),
    ));

  }


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onDeleteReply({
  @required BuildContext context,
  @required ReviewModel reviewModel,
  @required PaginationController paginationController,
}) async {

  final bool _canContinue = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      text: 'phid_delete_reply_?',
      translate: true,
    ),
    bodyVerse: const Verse(
      text: 'phid_delete_reply_description',
      translate: true,
    ),
    boolDialog: true,
    invertButtons: true,
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
      reviewModel: _updated,
    );

    paginationController.replaceMap.value = _updated.toMap(
      includeID: true,
      includeDocSnapshot: true,
    );

    unawaited(TopDialog.showTopDialog(
      context: context,
      firstVerse: const Verse(
        pseudo: 'Reply has been deleted',
        text: 'phid_reply_has_been_deleted',
        translate: true,
      ),
    ));

  }


}
// -----------------------------------------------------------------------------
