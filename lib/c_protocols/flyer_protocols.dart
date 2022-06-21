// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/d_providers/flyers_provider.dart';
// import 'package:bldrs/e_db/fire/ops/flyer_ops.dart';
// import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';

/// PROTOCOLS ARE SET OF OPS CALLED BY CONTROLLERS TO LAUNCH FIRE OPS AND LDB OPS.

class FlyerProtocol {

  FlyerProtocol();

// -----------------------------------------------------------------------------

  /// CREATE

// ----------------------------------
  static Future<void> createFlyerProtocol() async {

  }
// -----------------------------------------------------------------------------

/// UPDATE

// ----------------------------------
  static Future<void> updateFlyerProtocol() async {

  }
// -----------------------------------------------------------------------------

/// DELETE

// ----------------------------------
  /*
  static Future<void> deleteFlyerProtocol({
    @required BuildContext context,
    @required FlyerModel flyer,
    @required BzModel bzModel,
  }) async {

    /// DELETE FLYER OPS ON FIREBASE
    await FlyerFireOps.deleteFlyerOps(
      context: context,
      flyerModel: flyer,
      bzModel: bzModel,
      bzFireUpdateOps: true,
    );

    /// DELETE FLYER ON LDB
    await FlyerLDBOps.deleteFlyers(<String>[flyer.id]);

    /// REMOVE FLYER FROM FLYERS PROVIDER
    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
    _flyersProvider.removeFlyerFromProFlyers(
      flyerID: flyer.id,
      notify: notify,
    );


  }
   */
// -----------------------------------------------------------------------------
}
