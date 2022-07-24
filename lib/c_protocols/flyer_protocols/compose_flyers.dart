import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

/*

protocol level ops

 - create -> compose
 - read -> fetch
 - update -> renovate
 - delete -> wipe

 */

class CreateFlyerProtocols {

  CreateFlyerProtocols();

/// --------------------------------------------------------------------------
  static Future<void> createFlyerByActiveBz({
    @required BuildContext context,
    @required FlyerModel flyerToPublish,
  }) async {

    /// 1 - SHOULD UPLOAD FLYER TO FIREBASE

    blog('CreateFlyerProtocols.createFlyerByActiveBz : START');

    // KOS OMAK MESH ADER LA2 KOS OMAK

    blog('CreateFlyerProtocols.createFlyerByActiveBz : END');
  }


}
