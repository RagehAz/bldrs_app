import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/a_models/f_flyer/sub/review_model.dart';
import 'package:bldrs/c_protocols/review_protocols/fire/review_fire_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';

/// => TAMAM
class RenovateReviewProtocols {
  // -----------------------------------------------------------------------------

  const RenovateReviewProtocols();

  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateReview({
    required ReviewModel? reviewModel,
  }) async {

    if (reviewModel != null){

      await ReviewFireOps.updateReview(
        reviewModel: reviewModel,
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// REVIEW AGREE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel?> agreeOnReview({
    required ReviewModel? reviewModel,
    required bool? isAgreed,
  }) async {

    ReviewModel? _output = reviewModel;

    if (reviewModel != null && isAgreed != null){

      /// AGREE : was false and to be true
      if (isAgreed == false){
        _output = await _addAgree(
          reviewModel: reviewModel,
        );
      }

      /// REMOVE AGREE : was true and to be false
      else {
        _output = await _removeAgree(
          reviewModel: reviewModel,
        );
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel?> _addAgree({
    required ReviewModel? reviewModel,
  }) async {

      /// UPDATE MODEL
      final ReviewModel? _updated = ReviewModel.incrementAgrees(
        reviewModel: reviewModel,
        isIncrementing: true,
      );

      final FlyerModel? _flyer = await FlyerProtocols.fetchFlyer(
        flyerID: reviewModel?.flyerID,
      );

    if (
        reviewModel?.id != null
        &&
        reviewModel?.flyerID != null
        &&
        _flyer?.bzID != null
        &&
        Authing.getUserID() != null
    ){


      /// FIRE AND REAL UPDATES
      await Future.wait(<Future>[

            /// RENOVATE FIRE DOC
            renovateReview(
              reviewModel: _updated,
            ),

            /// ADD MY ID IN REVIEW AGREES LIST
            Real.updateDocInPath(
              path: RealPath.agrees_bzID_flyerID_reviewID(
                bzID: _flyer!.bzID!,
                flyerID: reviewModel!.flyerID!,
                reviewID: reviewModel.id!,
              ),
              map: {
                Authing.getUserID()!: true,
              },
            ),

          ]);

    }

    return _updated;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ReviewModel?> _removeAgree({
    required ReviewModel? reviewModel,
  }) async {

    blog('_removeAgree : START');

      /// UPDATE MODEL
      final ReviewModel? _updated = ReviewModel.incrementAgrees(
        reviewModel: reviewModel,
        isIncrementing: false,
      );

      final FlyerModel? _flyer = await FlyerProtocols.fetchFlyer(
        flyerID: reviewModel?.flyerID,
      );

    if (
        _flyer?.bzID != null
        &&
        reviewModel?.flyerID != null
        &&
        reviewModel?.id != null
        &&
        Authing.getUserID() != null
    ){

      /// FIRE AND REAL UPDATES
      await Future.wait(<Future>[
        /// RENOVATE FIRE DOC
        renovateReview(
          reviewModel: _updated,
        ),
        /// REMOVE ID IN REVIEW AGREES LIST
        Real.deletePath(
          pathWithDocName: RealPath.agrees_bzID_flyerID_reviewID_userID(
            bzID: _flyer!.bzID!,
            flyerID: reviewModel!.flyerID!,
            reviewID: reviewModel.id!,
            userID: Authing.getUserID()!,
          ),
        ),
      ]);

    }

    blog('_removeAgree : end');

    return _updated;
  }
  // -----------------------------------------------------------------------------
}
