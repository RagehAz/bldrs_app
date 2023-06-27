import 'package:bldrs/a_models/x_secondary/feedback_model.dart';
import 'package:fire/super_fire.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:flutter/cupertino.dart';

class FeedbackRealOps {
  // -----------------------------------------------------------------------------

  const FeedbackRealOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  ///
  static Future<FeedbackModel> createFeedback({
    required FeedbackModel feedback,
  }) async {

    FeedbackModel _output;

    if (feedback != null){

      final Map<String, dynamic> _map = await Real.createDoc(
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
}
