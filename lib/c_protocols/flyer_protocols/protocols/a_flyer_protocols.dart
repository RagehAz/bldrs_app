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
  /// TASK : TEST ME
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
  /// TASK : TEST ME
  static const renovate = RenovateFlyerProtocols.renovate;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const updateFlyerLocally = RenovateFlyerProtocols.updateLocally;
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TASK : TEST ME
  static const wipeFlyer = WipeFlyerProtocols.wipeFlyer;
  // --------------------
  /// TASK : TEST ME
  static const wipeFlyers = WipeFlyerProtocols.wipeFlyers;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const deleteFlyersLocally =  WipeFlyerProtocols.deleteFlyersLocally;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const deleteAllBzFlyersLocally = WipeFlyerProtocols.deleteAllBzFlyersLocally;
  // -----------------------------------------------------------------------------

  /// IMAGIFICATION

  // --------------------
  /// TASK : TEST ME
  static const renderSmallFlyer = ImagifyFlyerProtocols.renderSmallFlyer;
  // --------------------
  /// TASK : TEST ME
  static const renderBigFlyer = ImagifyFlyerProtocols.renderBigFlyer;
  // --------------------
  /// TASK : TEST ME
  static const disposeRenderedFlyer = ImagifyFlyerProtocols.disposeRenderedFlyer;
  // // --------------------
  // /// TESTED : WORKS PERFECT
  // static const imagifyBzLogo = ImagifyFlyerProtocols.imagifyBzLogo;
  // // --------------------
  // /// TESTED : WORKS PERFECT
  // static const imagifyAuthorPic = ImagifyFlyerProtocols.imagifyAuthorPic;
  // -----------------------------------------------------------------------------
}
