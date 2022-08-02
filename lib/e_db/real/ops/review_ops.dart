import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/e_db/real/foundation/real.dart';
import 'package:bldrs/e_db/real/foundation/real_colls.dart';
import 'package:flutter/material.dart';

class ReviewRealOps {
// -----------------------------------------------------------------------------

  const ReviewRealOps();

// -----------------------------------------------------------------------------
  static String createRealPath(String flyerID){
    return '/${RealColl.reviews}/$flyerID';
  }
// -----------------------------------------------------------------------------
  static Future<void> createReview({
    @required BuildContext context,
    @required String text,
    @required String flyerID,
  }) async {

    final ReviewModel _review = ReviewModel.createNewReview(
      text: text,
      flyerID: flyerID,
    );

    await Real.createDocInPath(
        context: context,
        pathWithoutDocName: createRealPath(flyerID),
        addDocIDToOutput: true,
        map: _review.toMap(toJSON: true),
    );

  }
// -----------------------------------------------------------------------------
}
