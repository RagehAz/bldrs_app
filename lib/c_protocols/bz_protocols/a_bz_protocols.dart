

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/compose_bzz.dart';
import 'package:bldrs/c_protocols/bz_protocols/fetch_bzz.dart';
import 'package:bldrs/c_protocols/bz_protocols/renovate_bzz.dart';
import 'package:bldrs/c_protocols/bz_protocols/wipe_bzz.dart';
import 'package:flutter/material.dart';

class BzProtocols {
// -----------------------------------------------------------------------------

  BzProtocols();

// -----------------------------------------------------------------------------

/// COMPOSE

// ----------------------------------
  static Future<void> composeBz({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required UserModel userModel,
  }) => ComposeBzProtocol.compose(
    context: context,
    newBzModel: newBzModel,
    userModel: userModel,
  );
// -----------------------------------------------------------------------------

/// FETCH

// ----------------------------------
  static Future<BzModel> fetchBz({
    @required BuildContext context,
    @required String bzID
  }) => FetchBzProtocol.fetchBz(
    context: context,
    bzID: bzID,
  );
// ----------------------------------
  static Future<List<BzModel>> fetchBzz({
    @required BuildContext context,
    @required List<String> bzzIDs
  }) => FetchBzProtocol.fetchBzz(
    context: context,
    bzzIDs: bzzIDs,
  );
// -----------------------------------------------------------------------------

/// RENOVATE

// ----------------------------------
  static Future<BzModel> renovateBz({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required BzModel oldBzModel,
    @required bool showWaitDialog,
    @required bool navigateToBzInfoPageOnEnd,
  }) => RenovateBzProtocol.renovateBz(
    context: context,
    newBzModel: newBzModel,
    oldBzModel: oldBzModel,
    showWaitDialog: showWaitDialog,
    navigateToBzInfoPageOnEnd: navigateToBzInfoPageOnEnd,
  );
// ----------------------------------
  static Future<void> updateBzLocally({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required BzModel oldBzModel,
}) => RenovateBzProtocol.updateBzLocally(
    context: context,
    newBzModel: newBzModel,
    oldBzModel: oldBzModel,
  );
// ----------------------------------
  static Future<BzModel> completeBzZoneModel({
    @required BuildContext context,
    @required BzModel bzModel,
  }) => RenovateBzProtocol.completeBzZoneModel(
      context: context,
      bzModel: bzModel
  );
// -----------------------------------------------------------------------------

/// WIPE

// ----------------------------------
  static Future<void> wipeBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required bool showWaitDialog,
  }) => WipeBzProtocol.wipeBz(
    context: context,
    bzModel: bzModel,
    showWaitDialog: showWaitDialog,
  );
// ----------------------------------
  static Future<void> deleteLocally({
    @required BuildContext context,
    @required String bzID,
  }) => WipeBzProtocol.deleteLocally(
    context: context,
    bzID: bzID,
  );
// -----------------------------------------------------------------------------
}
