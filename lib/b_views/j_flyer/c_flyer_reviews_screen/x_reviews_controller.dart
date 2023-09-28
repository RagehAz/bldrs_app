import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/layouts/separators/dot_separator.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/a_models/x_ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/review_protocols/protocols/a_reviews_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// LAST SESSION

// ---------------------------------------
/// TESTED : WORKS PERFECT
Future<void> loadReviewEditorLastSession({
  required BuildContext context,
  required TextEditingController reviewController,
  required String? flyerID,
}) async {

  final ReviewModel? _lastSessionReview = await FlyerLDBOps.loadReviewSession(
    reviewID: ReviewModel.createTempReviewID(
      flyerID: flyerID,
      userID: Authing.getUserID(),
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

    reviewController.text = _lastSessionReview.text ?? '';

    // }

  }

}
// ---------------------------------------
/// TESTED : WORKS PERFECT
Future<void> saveReviewEditorSession({
  required TextEditingController reviewController,
  required String? flyerID,
}) async {

  await FlyerLDBOps.saveReviewSession(
    review: ReviewModel(
        id: ReviewModel.createTempReviewID(
          flyerID: flyerID,
          userID: Authing.getUserID(),
        ),
        text: reviewController.text,
        userID: Authing.getUserID(),
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
  required BuildContext context,
  required FlyerModel? flyerModel,
  required TextEditingController textController,
  required PaginationController paginationController,
  required ValueNotifier<bool> isUploading,
  required bool mounted,
}) async {

  final UserModel? _user = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  /// USER IS NOT SIGNED IN
  if (Authing.userIsSignedUp(_user?.signInMethod) == false){
    await Dialogs.youNeedToBeSignedUpDialog(
      afterHomeRouteName: RouteName.flyerReviews,
      afterHomeRouteArgument: ReviewModel.createFlyerIDReviewIDLinkPart(
        flyerID: flyerModel?.id,
        reviewID: null,
      )
    );
  }

  /// USER IS SIGNED IN
  else {

    /// TEXT FIELD IS EMPTY
    if (TextCheck.isEmpty(textController.text.trim()) == true){
      await Dialogs.centerNotice(
        verse: const Verse(
          id: 'phid_add_review_to_submit',
          translate: true,
        ),
      );
    }

    /// CAN POST REVIEW
    else {

      setNotifier(
        notifier: isUploading,
        mounted: mounted,
        value: true,
      );

      await Keyboard.closeKeyboard();

      final ReviewModel _reviewModel = ReviewModel.createNewReview(
        text: textController.text,
        flyerID: flyerModel?.id,
      );

      await FlyerLDBOps.deleteReviewSession(
        reviewID: ReviewModel.createTempReviewID(
            flyerID: flyerModel?.id,
            userID: Authing.getUserID(),
          ),
      );

      final ReviewModel? uploadedReview = await ReviewProtocols.composeReview(
          context: context,
          reviewModel: _reviewModel,
          bzID: flyerModel?.bzID,
        );

      setNotifier(
        notifier: paginationController.addMap,
        mounted: mounted,
        value: uploadedReview?.toMap(
          includeID: true,
          includeDocSnapshot: true,
        ),
      );

      textController.text = '';

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
  required ReviewModel? reviewModel,
  required PaginationController paginationController,
  required bool isAgreed,
  required bool mounted,
}) async {

  final UserModel? _user = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  /// USER IS NOT SIGNED IN
  if (Authing.userIsSignedUp(_user?.signInMethod) == false){
    await Dialogs.youNeedToBeSignedUpDialog(
      afterHomeRouteName: RouteName.flyerReviews,
      afterHomeRouteArgument: ReviewModel.createFlyerIDReviewIDLinkPart(
        flyerID: reviewModel?.flyerID,
        reviewID: reviewModel?.id,
      ),
    );
  }

  /// USER IS SIGNED IN
  else {
    if (reviewModel != null && reviewModel.id != null){

      final ReviewModel? _uploaded = await ReviewProtocols.agreeOnReview(
        reviewModel: reviewModel,
        isAgreed: isAgreed,
      );

      if (_uploaded != null){


      paginationController.replaceMapByID(
        mounted: mounted,
        map: _uploaded.toMap(
          includeID: true,
          includeDocSnapshot: true,
        ),
      );

      }
    }
  }


}
// -----------------------------------------------------------------------------

/// REVIEW OPTIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onReviewOptions({
  required ReviewModel reviewModel,
  required PaginationController paginationController,
  required String? bzID,
  required bool mounted,
}) async {

  final BuildContext context = getMainContext();

  await BottomDialog.showButtonsBottomDialog(
      numberOfWidgets: 3,
      builder: (_){

        return <Widget>[

          /// EDIT REVIEW
          BottomDialog.wideButton(
              verse: const Verse(
                id: 'phid_edit',
                translate: true,
              ),
              verseCentered: true,
              isDeactivated: reviewModel.userID != Authing.getUserID(),
              onTap: () async {

                await Nav.goBack(
                  context: context,
                  invoker: 'onReviewOptions.Edit',
                );

                await _onEditReview(
                  reviewModel: reviewModel,
                  paginationController: paginationController,
                  mounted: mounted,
                );

              }
          ),

          /// DELETE REVIEW
          BottomDialog.wideButton(
              verse: const Verse(
                id: 'phid_delete',
                translate: true,
              ),
              verseCentered: true,
              isDeactivated: reviewModel.userID != Authing.getUserID(),
              onTap: () async {

                await Nav.goBack(
                  context: context,
                  invoker: 'onReviewOptions.Delete',
                );

                await _onDeleteReview(
                  reviewModel: reviewModel,
                  paginationController: paginationController,
                  bzID: bzID,
                  mounted: mounted,
                );

              }
          ),

          const DotSeparator(),

        ];

      }
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onEditReview({
  required ReviewModel reviewModel,
  required PaginationController paginationController,
  required bool mounted,
}) async {

  bool _isConfirmed = false;

  final String? _shit = await Dialogs.keyboardDialog(
    keyboardModel: KeyboardModel(
      titleVerse: const Verse(
        id: 'phid_edit_your_review',
        translate: true,
      ),
      hintVerse: const Verse(
        id: 'phid_what_do_you_think_of_this_flyer_?',
        translate: true,
      ),
      initialText: reviewModel.text,
      maxLines: 5,
      textInputAction: TextInputAction.newline,
      focusNode: FocusNode(),
      isFloatingField: false,
      enableSuggestions: Keyboard.suggestionsEnabled(),
      autoCorrect: Keyboard.autoCorrectIsOn(),
      onSubmitted: (String? text){

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

    setNotifier(
        notifier: paginationController.replaceMap,
        mounted: mounted,
        value: _updated.toMap(
          includeID: true,
          includeDocSnapshot: true,
        ),
    );

    await TopDialog.showTopDialog(
      firstVerse: const Verse(
        id: 'phid_review_has_been_updated',
        translate: true,
      ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onDeleteReview({
  required ReviewModel? reviewModel,
  required PaginationController paginationController,
  required String? bzID,
  required bool mounted,
}) async {

  if (reviewModel != null && bzID != null){

    final UserModel? _user = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    if (Authing.userIsSignedUp(_user?.signInMethod) == false){
      await Dialogs.youNeedToBeSignedUpDialog(
        afterHomeRouteName: RouteName.flyerReviews,
        afterHomeRouteArgument: ReviewModel.createFlyerIDReviewIDLinkPart(
          flyerID: reviewModel.flyerID,
          reviewID: reviewModel.id,
        ),
      );
    }

    else {

      final bool _canContinue = await BldrsCenterDialog.showCenterDialog(
        titleVerse: const Verse(
          id: 'phid_delete_review_?',
          translate: true,
        ),
        bodyVerse: const Verse(
          id: 'phid_review_will_be_deleted',
          translate: true,
        ),
        boolDialog: true,
        invertButtons: true,
      );

      if (_canContinue == true) {

        await ReviewProtocols.wipeSingleReview(
          reviewModel: reviewModel,
          bzID: bzID,
        );

        setNotifier(
          notifier: paginationController.deleteMap,
          mounted: mounted,
          value: reviewModel.toMap(
            includeID: true,
            includeDocSnapshot: true,
          ),
        );

        await TopDialog.showTopDialog(
          firstVerse: const Verse(
            pseudo: 'Review has been deleted successfully',
            id: 'phid_review_deleted_successfully',
            translate: true,
          ),
        );

      }

    }

  }


}
// -----------------------------------------------------------------------------

/// GO TO REVIEWER - REPLIER PROFILES

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onReviewUserBalloonTap({
  required UserModel? userModel,
}) async {

  if (userModel != null){
    await BldrsNav.jumpToUserPreviewScreen(
      userID: userModel.id,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onReplyBzBalloonTap({
  required BzModel? bzModel,
}) async {

  if (bzModel != null){
    await BldrsNav.jumpToBzPreviewScreen(
      bzID: bzModel.id,
    );
  }


}
// -----------------------------------------------------------------------------

/// BZ REPLY

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onBzReply({
  required ReviewModel? reviewModel,
  required PaginationController paginationController,
  required String? bzID,
  required bool mounted,
}) async {

  if (reviewModel != null && bzID != null) {

    final UserModel? _myUserModel = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    if (Authing.userIsSignedUp(_myUserModel?.signInMethod) == false) {
      await Dialogs.youNeedToBeSignedUpDialog(
        afterHomeRouteName: RouteName.flyerReviews,
        afterHomeRouteArgument: ReviewModel.createFlyerIDReviewIDLinkPart(
          flyerID: reviewModel.flyerID,
          reviewID: reviewModel.id,
        ),
      );
    }

    else {

      final bool _imAuthorInThisBz = AuthorModel.checkUserIsAuthorInThisBz(
          bzID: bzID,
          userModel: _myUserModel,
      );

      if (_imAuthorInThisBz == true) {

        bool _isConfirmed = false;

        final String? _reply = await Dialogs.keyboardDialog(
          keyboardModel: KeyboardModel(
            titleVerse: const Verse(
              id: 'phid_reply_to_flyer',
              translate: true,
            ),
            hintVerse: const Verse(
              pseudo: 'Reply ...',
              id: 'phid_reply_dots',
              translate: true,
            ),
            initialText: reviewModel.reply,
            maxLines: 5,
            textInputAction: TextInputAction.newline,
            focusNode: FocusNode(),
            isFloatingField: false,
            autoCorrect: Keyboard.autoCorrectIsOn(),
            enableSuggestions: Keyboard.suggestionsEnabled(),
            onSubmitted: (String? text) {
              _isConfirmed = true;
            },
          ),
        );

        blog('reply : $_reply : _isConfirmed : $_isConfirmed');

        if (TextCheck.isEmpty(_reply) == false && _isConfirmed == true) {

          final ReviewModel _updated = reviewModel.copyWith(
            reply: _reply,
            replyAuthorID: Authing.getUserID(),
            replyTime: DateTime.now(),
          );

          setNotifier(
            notifier: paginationController.replaceMap,
            mounted: mounted,
            value: _updated.toMap(
              includeID: true,
              includeDocSnapshot: true,
            ),

          );

          await ReviewProtocols.composeReviewReply(
            updatedReview: _updated,
            bzID: bzID,
          );

          await TopDialog.showTopDialog(
            firstVerse: const Verse(
              pseudo: 'Your reply has been posted',
              id: 'phid_your_reply_has_been_posted',
              translate: true,
            ),
          );

        }
      }

    }
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onReplyOptions({
  required ReviewModel reviewModel,
  required PaginationController paginationController,
  required bool mounted,
}) async {

  final BuildContext context = getMainContext();

  await BottomDialog.showButtonsBottomDialog(
      numberOfWidgets: 2,
      builder: (_){

        return <Widget>[

          /// EDIT REPLY
          BottomDialog.wideButton(
              verse: const Verse(id: 'phid_edit', translate: true),
              verseCentered: true,
              onTap: () async {

                await Nav.goBack(
                  context: context,
                  invoker: 'onReplyOptions.Edit',
                );

                await _onEditReply(
                  reviewModel: reviewModel,
                  paginationController: paginationController,
                  mounted: mounted,
                );

              }
          ),

          /// DELETE REPLY
          BottomDialog.wideButton(
              verse: const Verse(id: 'phid_delete', translate: true),
              verseCentered: true,
              onTap: () async {

                await Nav.goBack(
                  context: context,
                  invoker: 'onReplyOptions.Delete',
                );

                await _onDeleteReply(
                  reviewModel: reviewModel,
                  paginationController: paginationController,
                  mounted: mounted,
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
  required ReviewModel reviewModel,
  required PaginationController paginationController,
  required bool mounted,
}) async {

  bool _isConfirmed = false;

  final String? _shit = await Dialogs.keyboardDialog(
    keyboardModel: KeyboardModel(
      titleVerse: const Verse(
        id: 'phid_edit_your_reply',
        translate: true,
      ),
      hintVerse: const Verse(
        id: 'phid_reply',
        translate: true,
      ),
      initialText: reviewModel.reply,
      maxLines: 5,
      textInputAction: TextInputAction.newline,
      focusNode: FocusNode(),
      isFloatingField: false,
      autoCorrect: Keyboard.autoCorrectIsOn(),
      enableSuggestions: Keyboard.suggestionsEnabled(),
      onSubmitted: (String? text){

        _isConfirmed = true;

      },
    ),

  );

  if (_shit != reviewModel.text && _isConfirmed == true){

    final ReviewModel _updated = reviewModel.copyWith(
      reply: _shit,
      replyAuthorID: Authing.getUserID(),
    );

    await ReviewProtocols.renovateReview(
      reviewModel: _updated,
    );

    setNotifier(
        notifier: paginationController.replaceMap,
        mounted: mounted,
        value: _updated.toMap(
          includeID: true,
          includeDocSnapshot: true,
        ),
    );

    await TopDialog.showTopDialog(
      firstVerse: const Verse(
        id: 'phid_reply_has_been_updated',
        translate: true,
      ),
    );

  }


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onDeleteReply({
  required ReviewModel reviewModel,
  required PaginationController paginationController,
  required bool mounted,
}) async {

  final bool _canContinue = await BldrsCenterDialog.showCenterDialog(
    titleVerse: const Verse(
      id: 'phid_delete_reply_?',
      translate: true,
    ),
    bodyVerse: const Verse(
      id: 'phid_delete_reply_description',
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

    setNotifier(
      notifier: paginationController.replaceMap,
      mounted: mounted,
      value: _updated.toMap(
        includeID: true,
        includeDocSnapshot: true,
      ),
    );

    await TopDialog.showTopDialog(
      firstVerse: const Verse(
        pseudo: 'Reply has been deleted',
        id: 'phid_reply_has_been_deleted',
        translate: true,
      ),
    );

  }


}
// -----------------------------------------------------------------------------
