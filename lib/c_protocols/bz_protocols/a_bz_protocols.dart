import 'package:bldrs/a_models/b_bz/author/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/compose_bzz.dart';
import 'package:bldrs/c_protocols/bz_protocols/fetch_bzz.dart';
import 'package:bldrs/c_protocols/bz_protocols/renovate_bzz.dart';
import 'package:bldrs/c_protocols/bz_protocols/wipe_bzz.dart';
import 'package:flutter/material.dart';

class BzProtocols {
  // -----------------------------------------------------------------------------

  const BzProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeBz({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required UserModel userModel,
  }) => ComposeBzProtocols.compose(
    context: context,
    newBzModel: newBzModel,
    userModel: userModel,
  );
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> fetch({
    @required BuildContext context,
    @required String bzID
  }) => FetchBzProtocols.fetch(
    context: context,
    bzID: bzID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> refetch({
    @required BuildContext context,
    @required String bzID
  }) => FetchBzProtocols.refetch(
    context: context,
    bzID: bzID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> fetchBzByFlyerID({
    @required BuildContext context,
    @required String flyerID,
  })=> FetchBzProtocols.fetchBzByFlyerID(
    context: context,
    flyerID: flyerID,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<BzModel>> fetchBzz({
    @required BuildContext context,
    @required List<String> bzzIDs
  }) => FetchBzProtocols.fetchBzz(
    context: context,
    bzzIDs: bzzIDs,
  );
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> renovateBz({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required BzModel oldBzModel,
    @required bool showWaitDialog,
    @required bool navigateToBzInfoPageOnEnd, // should be done in controller not here
  }) => RenovateBzProtocols.renovateBz(
    context: context,
    newBzModel: newBzModel,
    oldBzModel: oldBzModel,
    showWaitDialog: showWaitDialog,
    navigateToBzInfoPageOnEnd: navigateToBzInfoPageOnEnd,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateBzLocally({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required BzModel oldBzModel,
  }) => RenovateBzProtocols.updateBzLocally(
    context: context,
    newBzModel: newBzModel,
    oldBzModel: oldBzModel,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> completeBzZoneModel({
    @required BuildContext context,
    @required BzModel bzModel,
  }) => RenovateBzProtocols.completeBzZoneModel(
      context: context,
      bzModel: bzModel
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateAuthorProtocol({
    @required BuildContext context,
    @required BzModel oldBzModel,
    @required AuthorModel newAuthorModel,
  }) => RenovateBzProtocols.renovateAuthor(
    context: context,
    oldBzModel: oldBzModel,
    newAuthorModel: newAuthorModel,
  );
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  ///
  static Future<void> wipeBz({
    @required BuildContext context,
    @required BzModel bzModel,
    @required bool showWaitDialog,
    @required bool includeMyselfInBzDeletionNote,
  }) => WipeBzProtocols.wipeBz(
    context: context,
    bzModel: bzModel,
    showWaitDialog: showWaitDialog,
    includeMyselfInBzDeletionNote: includeMyselfInBzDeletionNote,
  );
  // --------------------
  ///
  static Future<void> deleteLocally({
    @required BuildContext context,
    @required String bzID,
    @required String invoker,
  }) => WipeBzProtocols.deleteLocally(
    context: context,
    bzID: bzID,
    invoker: invoker,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipePendingAuthor({
    @required BuildContext context,
    @required String bzID,
    @required String pendingUserID,
  }) => WipeBzProtocols.wipePendingAuthor(
    context: context,
    bzID: bzID,
    pendingUserID: pendingUserID,
  );
  // -----------------------------------------------------------------------------
}
