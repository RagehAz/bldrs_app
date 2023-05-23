import 'dart:async';

import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_real_ops.dart';
import 'package:bldrs/c_protocols/chain_protocols/ldb/chain_ldb_ops.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/real/chain_real_ops.dart';
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
  static Future<List<Chain>> composeBldrsChains({
    @required BuildContext context,
    @required List<Chain> chains,
  }) async {

    pushWaitDialog(
      verse: Verse.plain('Uploading Bldrs Chains to RealTime Database'),
    );

    final List<Chain> _bldrsChains = await ChainRealOps.createBldrsChains(
      chains: chains,
    );

    await WaitDialog.closeWaitDialog();

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
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateBldrsChains({
    @required BuildContext context,
    @required List<Chain> newChains,
  }) async {

    if (newChains != null){

      pushWaitDialog();

      await Future.wait(<Future>[

        ChainRealOps.updateBldrsChains(
            chains: newChains,
        ),

        updateBldrsChainsLocally(
          context: context,
          newChains: newChains,
          showWaitDialog: false,
        ),

        AppStateRealOps.updateGlobalLDBVersion(),

      ]);

      await WaitDialog.closeWaitDialog();

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
        pushWaitDialog();
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
        await WaitDialog.closeWaitDialog();
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// NO NEED
  // -----------------------------------------------------------------------------
}
