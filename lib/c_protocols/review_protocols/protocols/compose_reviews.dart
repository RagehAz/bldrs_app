import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/note_events/note_events.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/review_protocols/fire/review_fire_ops.dart';
import 'package:bldrs/c_protocols/review_protocols/protocols/renovate_reviews.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class ComposeReviewProtocols {
  // -----------------------------------------------------------------------------

  const ComposeReviewProtocols();

  // -----------------------------------------------------------------------------

  /// REVIEW

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel?> composeReview({
    required BuildContext context,
    required ReviewModel? reviewModel,
    required String? bzID,
  }) async {

    ReviewModel? _uploadedReview;

    if (reviewModel != null && bzID != null && Authing.userHasID() == true){

      await Future.wait(<Future>[

        ReviewFireOps.createReview(
          reviewModel: reviewModel,
        ).then((ReviewModel reviewModel) {
          _uploadedReview = reviewModel;
        }),

        RecorderProtocols.onComposeReview(
          flyerID: reviewModel.flyerID,
          bzID: bzID,
        ),

        NoteEvent.sendFlyerReceivedNewReviewByMe(
          context: context,
          reviewModel: reviewModel,
          bzID: bzID,
        ),

      ]);
    }


    return _uploadedReview;
  }
  // -----------------------------------------------------------------------------

  /// REPLY

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeReviewReply({
    required String bzID,
    required ReviewModel updatedReview,
  }) async {

    final UserModel? _myUserModel = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    if (_myUserModel != null){

      final bool _imAuthorOfThisBz = AuthorModel.checkUserIsAuthorInThisBz(
        bzID: bzID,
        userModel: _myUserModel,
      );

      if (_imAuthorOfThisBz == true){

      final BzModel? _bzModel = await BzProtocols.fetchBz(
        bzID: bzID,
      );

      await Future.wait(<Future>[

        RenovateReviewProtocols.renovateReview(
          reviewModel: updatedReview,
        ),

        NoteEvent.sendFlyerReviewReceivedBzReply(
          reviewModel: updatedReview,
          bzModel: _bzModel,
        ),

      ]);

    }

    }

  }
  // -----------------------------------------------------------------------------
}
