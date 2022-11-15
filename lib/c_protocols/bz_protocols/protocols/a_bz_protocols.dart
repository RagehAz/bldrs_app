import 'package:bldrs/c_protocols/bz_protocols/protocols/compose_bzz.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/fetch_bzz.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/renovate_bzz.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/wipe_bzz.dart';

class BzProtocols {
  // -----------------------------------------------------------------------------

  const BzProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const composeBz = ComposeBzProtocols.compose;
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetch = FetchBzProtocols.fetch;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const refetch = FetchBzProtocols.refetch;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchBzByFlyerID = FetchBzProtocols.fetchBzByFlyerID;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchBzz = FetchBzProtocols.fetchBzz;
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TASK : TEST ME
  static const renovateBz = RenovateBzProtocols.renovateBz;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const updateBzLocally = RenovateBzProtocols.updateBzLocally;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const completeBzZoneModel = RenovateBzProtocols.completeBzZoneModel;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const renovateAuthorProtocol = RenovateBzProtocols.renovateAuthor;
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TASK : TEST ME
  static const wipeBz = WipeBzProtocols.wipeBz;
  // --------------------
  /// TASK : TEST ME
  static const deleteLocally = WipeBzProtocols.deleteLocally;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const wipePendingAuthor = WipeBzProtocols.wipePendingAuthor;
  // -----------------------------------------------------------------------------
}
