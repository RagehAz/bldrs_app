import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/compose_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/fetch_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/renovate_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/wipe_flyers.dart';
import 'package:flutter/cupertino.dart';

class FlyerProtocols {
  // -----------------------------------------------------------------------------

  const FlyerProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required BzModel bzModel,
  }) => ComposeFlyerProtocols.compose(
    context: context,
    flyerToPublish: flyerModel,
    bzModel: bzModel,
  );
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<FlyerModel> fetchFlyer({
    @required BuildContext context,
    @required  String flyerID,
  }) => FetchFlyerProtocols.fetchFlyer(
    context: context,
    flyerID: flyerID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FlyerModel>> fetchFlyers({
    @required BuildContext context,
    @required List<String> flyersIDs,
  }) => FetchFlyerProtocols.fetchFlyers(
      context: context,
      flyersIDs: flyersIDs
  );
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateFlyer({
    @required BuildContext context,
    @required FlyerModel newFlyer,
    @required FlyerModel oldFlyer,
    @required BzModel bzModel,
    @required bool sendFlyerUpdateNoteToItsBz,
    @required bool updateFlyerLocally,
    @required bool resetActiveBz,
  }) => RenovateFlyerProtocols.renovate(
    context: context,
    newFlyer: newFlyer,
    oldFlyer: oldFlyer,
    bzModel: bzModel,
    sendFlyerUpdateNoteToItsBz: sendFlyerUpdateNoteToItsBz,
    updateFlyerLocally: updateFlyerLocally,
    resetActiveBz: resetActiveBz,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateFlyerLocally({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required bool notifyFlyerPro,
    @required bool resetActiveBz,
  }) => RenovateFlyerProtocols.updateLocally(
    context: context,
    flyerModel: flyerModel,
    notifyFlyerPro: notifyFlyerPro,
    resetActiveBz: resetActiveBz,
  );
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> wipeTheFlyer({
    @required BuildContext context,
    @required FlyerModel flyerModel,
    @required BzModel bzModel,
    @required bool showWaitDialog,
    @required bool isDeletingBz,
  }) => WipeFlyerProtocols.wipeFlyer(
    context: context,
    flyerModel: flyerModel,
    bzModel: bzModel,
    showWaitDialog: showWaitDialog,
    isDeletingBz: isDeletingBz,
  );
  // --------------------
  static Future<BzModel> wipeFlyers({
    @required BuildContext context,
    @required BzModel bzModel,
    @required List<FlyerModel> flyers,
    @required bool showWaitDialog,
    @required bool updateBzEveryWhere,
    @required bool isDeletingBz,
  }) => WipeFlyerProtocols.wipeMultipleFlyers(
    context: context,
    bzModel: bzModel,
    flyers: flyers,
    showWaitDialog: showWaitDialog,
    updateBzEveryWhere: updateBzEveryWhere,
    isDeletingBz: isDeletingBz,
  );
  // --------------------
}
