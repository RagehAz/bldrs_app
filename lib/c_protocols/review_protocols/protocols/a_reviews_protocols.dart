import 'package:bldrs/c_protocols/review_protocols/protocols/compose_reviews.dart';
import 'package:bldrs/c_protocols/review_protocols/protocols/fetch_reviews.dart';
import 'package:bldrs/c_protocols/review_protocols/protocols/renovate_reviews.dart';
import 'package:bldrs/c_protocols/review_protocols/protocols/wipe_reviews.dart';
/// => TAMAM
class ReviewProtocols {
  // -----------------------------------------------------------------------------

  const ReviewProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const composeReview = ComposeReviewProtocols.composeReview;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const composeReviewReply = ComposeReviewProtocols.composeReviewReply;
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const renovateReview = RenovateReviewProtocols.renovateReview;
  // -----------------------------------------------------------------------------

  /// REVIEW AGREE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const agreeOnReview = RenovateReviewProtocols.agreeOnReview;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const readIsAgreed = FetchReviewProtocols.readIsAgreed;
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const wipeSingleReview = WipeReviewProtocols.wipeSingleReview;
  // --------------------
  /// TASK : TEST ME
  static const onWipeFlyer = WipeReviewProtocols.onWipeFlyer;
  // --------------------
  /// TASK : TEST ME
  static const onWipeBz = WipeReviewProtocols.onWipeBz;
  // -----------------------------------------------------------------------------
}
