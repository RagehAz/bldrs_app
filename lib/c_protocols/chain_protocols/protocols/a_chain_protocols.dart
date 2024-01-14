import 'dart:async';

import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_real_ops.dart';
import 'package:bldrs/c_protocols/chain_protocols/ldb/chain_ldb_ops.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/real/chain_real_ops.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// => TAMAM
class ChainProtocols {
  // -----------------------------------------------------------------------------

  const ChainProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Chain>?> composeBldrsChains({
    required BuildContext context,
    required List<Chain> chains,
  }) async {

    WaitDialog.showUnawaitedWaitDialog(
      verse: Verse.plain('Uploading Bldrs Chains to RealTime Database'),
    );

    final List<Chain>? _bldrsChains = await ChainRealOps.createBldrsChains(
      chains: chains,
    );

    await WaitDialog.closeWaitDialog();

    return _bldrsChains;
  }
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Chain>?> fetchBldrsChains() async {

    /// 1 - search LDB
    List<Chain>? _chains = await ChainLDBOps.readBldrsChains();

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
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateBldrsChains({
    required List<Chain>? newChains,
  }) async {

    if (newChains != null){

      WaitDialog.showUnawaitedWaitDialog();

      await Future.wait(<Future>[

        ChainRealOps.updateBldrsChains(
            chains: newChains,
        ),

        updateBldrsChainsLocally(
          newChains: newChains,
          showWaitDialog: false,
        ),

        AppStateFireOps.updateGlobalLDBVersion(),

      ]);

      await WaitDialog.closeWaitDialog();

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateBldrsChainsLocally({
    required List<Chain>? newChains,
    required bool showWaitDialog,
  }) async {

    if (newChains != null){

      if (showWaitDialog == true){
        WaitDialog.showUnawaitedWaitDialog();
      }

      /// UPDATE CHAIN S IN LDB
      await ChainLDBOps.updateBldrsChains(
        chains: newChains,
      );

      /// UPDATE CHAIN S IN PRO
      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);
      await _chainsProvider.updateBldrsChainsOps(
        bldrsChains: newChains,
        notify: true,
      );

      if (showWaitDialog == true){
        await WaitDialog.closeWaitDialog();
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// NO NEED
  // -----------------------------------------------------------------------------

  /// SUPER GETTERS

  // --------------------
  static List<String> superGetAllPhidsByFlyerType({
    required FlyerType flyerType,
    required bool onlyUseZoneChains,
  }){

    final List<String> _chainsIDs = FlyerTyper.bzCreatorChainsIDs(flyerType);

    final List<Chain>? _allChains = ChainsProvider.proGetBldrsChains(
      context: getMainContext(),
      onlyUseZoneChains: onlyUseZoneChains,
      listen: false,
    );

    List<Chain> _chainsByIDs = Chain.getChainsFromChainsByIDs(
      allChains: _allChains,
      phids: _chainsIDs,
    );

    if (
    _chainsByIDs.length == 1
        &&
        Chain.checkIsChains(_chainsByIDs.first.sons) == true
    ){
      _chainsByIDs = _chainsByIDs.first.sons;
    }

    return Chain.getOnlyPhidsSonsFromChains(
      chains: _chainsByIDs,
    );

  }
  // -----------------------------------------------------------------------------
}
