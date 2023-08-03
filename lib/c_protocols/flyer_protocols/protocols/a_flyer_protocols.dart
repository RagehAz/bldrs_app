import 'package:bldrs/c_protocols/flyer_protocols/protocols/compose_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/fetch_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/flyer_imagification_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/renovate_flyers.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/wipe_flyers.dart';

class FlyerProtocols  {
  // -----------------------------------------------------------------------------

  const FlyerProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const composeFlyer = ComposeFlyerProtocols.compose;
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchFlyer = FetchFlyerProtocols.fetchFlyer;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchFlyers = FetchFlyerProtocols.fetchFlyers;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchAndCombineBzSlidesInOneFlyer = FetchFlyerProtocols.fetchAndCombineBzSlidesInOneFlyer;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const refetch = FetchFlyerProtocols.refetch;
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const renovateDraft = RenovateFlyerProtocols.renovateDraft;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const renovateFlyer = RenovateFlyerProtocols.renovateFlyer;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const updateFlyerLocally = RenovateFlyerProtocols.updateLocally;
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const onWipeSingleFlyer = WipeFlyerProtocols.onWipeSingleFlyer;
  // --------------------
  /// TASK : TEST ME
  static const onWipeBz = WipeFlyerProtocols.onWipeBz;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const deleteFlyersLocally =  WipeFlyerProtocols.deleteFlyersLocally;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const deleteAllBzFlyersLocally = WipeFlyerProtocols.deleteAllBzFlyersLocally;
  // -----------------------------------------------------------------------------

  /// IMAGIFICATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static const renderSmallFlyer = ImagifyFlyerProtocols.renderSmallFlyer;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const renderBigFlyer = ImagifyFlyerProtocols.renderBigFlyer;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const disposeRenderedFlyer = ImagifyFlyerProtocols.disposeRenderedFlyer;
  // -----------------------------------------------------------------------------
}
