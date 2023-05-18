import 'package:bldrs/c_protocols/bz_protocols/protocols/compose_bzz.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/fetch_bzz.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/renovate_bzz.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/wipe_bzz.dart';
/// => TAMAM
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
  static const fetchBz = FetchBzProtocols.fetch;
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
  /// TESTED : WORKS PERFECT
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
  /// TESTED : WORKS PERFECT
  static const wipeBz = WipeBzProtocols.wipeBz;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const deleteLocally = WipeBzProtocols.deleteLocally;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const wipePendingAuthor = WipeBzProtocols.wipePendingAuthor;
  // -----------------------------------------------------------------------------
}
