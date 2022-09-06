import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/c_protocols/author_protocols/compose_authors.dart';
import 'package:bldrs/c_protocols/author_protocols/renovate_authors.dart';
import 'package:bldrs/c_protocols/author_protocols/wipe_authors.dart';
import 'package:flutter/material.dart';

class AuthorProtocols {
  // -----------------------------------------------------------------------------

  const AuthorProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> addMeAsNewAuthorToABzProtocol({
    @required BuildContext context,
    @required BzModel oldBzModel,
  }) => ComposeAuthorProtocols.addMeAsNewAuthorToABzProtocol(
    context: context,
    oldBzModel: oldBzModel,
  );
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  ///
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateAuthorProtocol({
    @required BuildContext context,
    @required BzModel oldBzModel,
    @required AuthorModel newAuthorModel,
  }) => RenovateAuthorProtocols.updateAuthorProtocol(
    context: context,
    oldBzModel: oldBzModel,
    newAuthorModel: newAuthorModel,
  );
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteMyAuthorPicProtocol({
    @required BuildContext context,
    @required String bzID,
  }) => WipeAuthorProtocols.deleteMyAuthorPicProtocol(
      context: context,
      bzID: bzID
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeMeFromBzProtocol({
    @required BuildContext context,
    @required BzModel streamedBzModelWithoutMyID,

  }) => WipeAuthorProtocols.removeMeFromBzProtocol(
      context: context,
      streamedBzModelWithoutMyID: streamedBzModelWithoutMyID
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeFlyerlessAuthorProtocol({
    @required BuildContext context,
    @required BzModel bzModel,
    @required AuthorModel author,
  }) => WipeAuthorProtocols.removeFlyerlessAuthorProtocol(
    context: context,
    bzModel: bzModel,
    author: author,
  );
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> authorBzExitAfterBzDeletionProtocol({
    @required BuildContext context,
    @required String bzID,
  }) => WipeAuthorProtocols.authorBzExitAfterBzDeletionProtocol(
    context: context,
    bzID: bzID,
  );
  // -----------------------------------------------------------------------------
}
