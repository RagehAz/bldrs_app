import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class FetchReviewProtocols {
  // -----------------------------------------------------------------------------

  const FetchReviewProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> readIsAgreed({
    @required String reviewID,
    @required String flyerID,
    @required String bzID,
  }) async {

    bool _output = false;

    final dynamic _result = await Real.readPath(
      path: RealPath.agrees_bzID_flyerID_reviewID_userID(
        bzID: bzID,
        flyerID: flyerID,
        reviewID: reviewID,
        userID: Authing.getUserID(),
      ),
    );

    if (_result == true){
      _output = true;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
