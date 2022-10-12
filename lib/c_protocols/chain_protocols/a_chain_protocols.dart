import 'dart:async';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/b_city_phids_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_back_end/x_ops/fire_ops/app_state_fire_ops.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/chain_ldb_ops.dart';
import 'package:bldrs/e_back_end/x_ops/real_ops/chain_real_ops.dart';
import 'package:bldrs/e_back_end/x_ops/real_ops/city_phids_real_ops.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChainProtocols {
  // -----------------------------------------------------------------------------

  const ChainProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Chain>> composeBldrsChains({
    @required BuildContext context,
    @required List<Chain> chains,
  }) async {

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingVerse: Verse.plain('Uploading Bldrs Chains to RealTime Database'),
    ));

    final List<Chain> _bldrsChains = await ChainRealOps.createBldrsChains(
      chains: chains,
    );

    await WaitDialog.closeWaitDialog(context);

    return _bldrsChains;
  }
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Chain>> fetchBldrsChains() async {

    /// 1 - search LDB
    List<Chain> _chains = await ChainLDBOps.readBldrsChains();

    /// 2 - BLDRS CHAINS not found in LDB
    if (_chains == null) {

      _chains = await ChainRealOps.readBldrsChains();

      /// 3 - insert in LDB when found on firebase
      if (_chains != null){

        await ChainLDBOps.insertBldrsChains(_chains);

      }

    }

    return _chains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<CityPhidsModel> readCityPhidsOfCurrentZone({
    @required BuildContext context,
  }) async {
    CityPhidsModel _cityPhidCounters;

    final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: false,
    );

    if (_currentZone != null){

      _cityPhidCounters = await CityPhidsRealOps.readCityPhids(
        cityID: _currentZone.cityID,
      );

    }

    return _cityPhidCounters;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateBldrsChains({
    @required BuildContext context,
    @required List<Chain> newChains,
  }) async {

    if (newChains != null){

      unawaited(WaitDialog.showWaitDialog(context: context,));

      await Future.wait(<Future>[

        ChainRealOps.updateBldrsChains(
            chains: newChains,
        ),

        updateBldrsChainsLocally(
          context: context,
          newChains: newChains,
          showWaitDialog: false,
        ),

        AppStateFireOps.updateGlobalChainsVersion(),

      ]);

      await WaitDialog.closeWaitDialog(context);

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateBldrsChainsLocally({
    @required BuildContext context,
    @required List<Chain> newChains,
    @required bool showWaitDialog,
  }) async {

    if (newChains != null){

      if (showWaitDialog == true){
        unawaited(WaitDialog.showWaitDialog(context: context,));
      }

      /// UPDATE CHAIN S IN LDB
      await ChainLDBOps.updateBldrsChains(
        chains: newChains,
      );

      /// UPDATE CHAIN S IN PRO
      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      await _chainsProvider.updateBldrsChainsOps(
        context: context,
        bldrsChains: newChains,
        notify: true,
      );

      if (showWaitDialog == true){
        await WaitDialog.closeWaitDialog(context);
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// NO NEED
  // -----------------------------------------------------------------------------
}
