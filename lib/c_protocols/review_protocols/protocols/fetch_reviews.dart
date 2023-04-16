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
  }) async {

    bool _output = false;

    final dynamic _result = await OfficialReal.readPath(
      path: '${RealColl.agreesOnReviews}/$flyerID/$reviewID/${OfficialAuthing.getUserID()}',
    );

    if (_result == true){
      _output = true;
    }

    return _output;
  }
  // -----------------------------------------------------------------------------
}
