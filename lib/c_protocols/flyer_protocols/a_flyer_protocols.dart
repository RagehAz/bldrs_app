
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/compose_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fetch_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/renovate_flyers.dart';
import 'package:flutter/cupertino.dart';

class FlyerProtocols {
// -----------------------------------------------------------------------------

  FlyerProtocols();

// -----------------------------------------------------------------------------

  /// COMPOSE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required BzModel bzModel,
  }) => ComposeFlyerProtocol.compose(
      context: context,
      flyerToPublish: flyerModel,
      bzModel: bzModel,
  );
// -----------------------------------------------------------------------------

/// FETCH

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> fetchFlyer({
    @required BuildContext context,
    @required  String flyerID,
  }) => FetchFlyerProtocol.fetchFlyer(
    context: context,
    flyerID: flyerID,
  );
// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> fetchFlyers({
    @required BuildContext context,
    @required List<String> flyersIDs,
}) => FetchFlyerProtocol.fetchFlyersByIDs(
      context: context,
      flyersIDs: flyersIDs
  );
// -----------------------------------------------------------------------------

/// RENOVATE

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateFlyer({
    @required BuildContext context,
    @required FlyerModel newFlyer,
    @required FlyerModel oldFlyer,
    @required BzModel bzModel,
    @required bool sendFlyerUpdateNoteToItsBz,
    @required bool updateFlyerLocally,
  }) => RenovateFlyerProtocols.renovate(
    context: context,
    newFlyer: newFlyer,
    oldFlyer: oldFlyer,
    bzModel: bzModel,
    sendFlyerUpdateNoteToItsBz: sendFlyerUpdateNoteToItsBz,
    updateFlyerLocally: updateFlyerLocally,
  );
// ----------------------------------
  static Future<void> updateFlyerLocally({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required bool notify,
}) => RenovateFlyerProtocols.updateLocally(
      context: context,
      flyerModel: flyerModel,
      notify: notify
  );

// -----------------------------------------------------------------------------

/// WIPE

// ----------------------------------
}
