import 'package:bldrs/a_models/x_secondary/feedback_model.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
/// => TAMAM
class FeedbackRealOps {
  // -----------------------------------------------------------------------------

  const FeedbackRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FeedbackModel?> createFeedback({
    required FeedbackModel? feedback,
  }) async {

    FeedbackModel? _output;

    if (feedback != null){

      final Map<String, dynamic>? _map = await Real.createDoc(
        coll: RealColl.feedbacks,
        map: feedback.toMap(),
      );

      if (_map != null){
        _output = feedback;
      }


    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteFeedback({
    required String? feedbackID,
  }) async {

    if (feedbackID != null){

      await Real.deleteDoc(
          coll: RealColl.feedbacks,
          doc: feedbackID,
      );

    }

  }
  // -----------------------------------------------------------------------------
}
