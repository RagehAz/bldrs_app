import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_colls.dart';
import 'package:flutter/material.dart';

class FetchReviewProtocols {
  // -----------------------------------------------------------------------------

  const FetchReviewProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<bool> readIsAgreed({
    @required String reviewID,
  }) async {

    bool _output = false;

    final dynamic _result = await Real.readPath(
      path: '${RealColl.agreesOnReviews}/$reviewID/${AuthFireOps.superUserID()}',
    );

    if (_result == true){
      _output = true;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
