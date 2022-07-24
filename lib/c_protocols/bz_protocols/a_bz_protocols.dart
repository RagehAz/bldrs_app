

import 'package:bldrs/a_models/bz/bz_model.dart';
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
  static Future<void> composeBz() => ComposeBzProtocol.compose();
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
  static Future<void> renovateBz() => RenovateBzProtocol.renovateBz();
// -----------------------------------------------------------------------------

/// WIPE

// ----------------------------------
  static Future<void> wipeBz() => WipeBzProtocol.wipeBz();
// -----------------------------------------------------------------------------
}
