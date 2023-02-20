import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:real/real.dart';
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
  }) async {

    bool _output = false;

    final dynamic _result = await Real.readPath(
      path: '${RealColl.agreesOnReviews}/$flyerID/$reviewID/${AuthFireOps.superUserID()}',
    );

    if (_result == true){
      _output = true;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
