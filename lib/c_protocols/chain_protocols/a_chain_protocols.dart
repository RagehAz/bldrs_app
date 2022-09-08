import 'dart:async';
import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/b_city_phids_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/ldb/ops/chain_ldb_ops.dart';
import 'package:bldrs/e_db/real/ops/chain_real_ops.dart';
import 'package:bldrs/e_db/real/ops/city_phids_real_ops.dart';
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
      loadingVerse:  'Uploading Bldrs Chains to RealTime Database',
    ));

    final List<Chain> _bldrsChains = await ChainRealOps.createBldrsChains(
      context: context,
      chains: chains,
    );

    WaitDialog.closeWaitDialog(context);

    return _bldrsChains;
  }
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------

  static Future<List<Chain>> fetchBldrsChains(BuildContext context) async {

    /// 1 - search LDB
    List<Chain> _chains = await ChainLDBOps.readBldrsChains();

    /// 2 - BLDRS CHAINS not found in LDB
    if (_chains == null) {

      _chains = await ChainRealOps.readBldrsChains(context);

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
        context: context,
        cityID: _currentZone.cityID,
      );

    }

    return _cityPhidCounters;
  }
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  ///
  static Future<void> renovateBldrsChains({
    @required BuildContext context,
    @required List<Chain> newChains,
  }) async {

    if (newChains != null){

      unawaited(WaitDialog.showWaitDialog(context: context,));

      await Future.wait(<Future>[

        ChainRealOps.updateBldrsChains(
            context: context,
            chains: newChains,
        ),

        updateBldrsChainsLocally(
          context: context,
          newChains: newChains,
          showWaitDialog: false,
        ),

      ]);

      WaitDialog.closeWaitDialog(context);

    }

  }
  // --------------------

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
        WaitDialog.closeWaitDialog(context);
      }

    }

  }

  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// NO NEED
  // -----------------------------------------------------------------------------
}
// -----------------------------------------------------------------------------
  /*
  // --------------------
  /// TASK DEPRECATED
  static Future<Chain> composeChainK({
    @required BuildContext context,
    @required Chain chainK,
  }) async {

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingVerse:  'Uploading ChainK to RealTime Database',
    ));

    /// NOTE : chain K does not allow duplicate IDs in last node
    final Chain _bigChainK = await ChainRealOps.createBigChainK(
      context: context,
      chainK: chainK,
    );

    WaitDialog.closeWaitDialog(context);

    return _bigChainK;
  }

 */
  // --------------------
  /*
  /// TASK DEPRECATED
  static Future<Chain> composeChainS({
    @required BuildContext context,
    @required Chain chainS,
  }) async {

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingVerse:  'Uploading ChainS to RealTime Database',
    ));

    /// NOTE : chain S allows duplicate keys in its last nodes
    final Chain _bigChainS = await ChainRealOps.createBigChainS(
      context: context,
      chainS: chainS,
    );

    WaitDialog.closeWaitDialog(context);

    return _bigChainS;
  }

 */
  // --------------------
  /*
  /// TASK DEPRECATED
  static Future<Chain> fetchBigChainK(BuildContext context) async {

    /// 1 - search LDB
    Chain _bigChainK = await ChainLDBOps.readBigChainK();

    /// 2 - bigChainK is not found in LDB
    if (_bigChainK == null){

      _bigChainK = await ChainRealOps.readBigChainK(context);

      /// 3 - insert in LDB when found on firebase
      if (_bigChainK != null){

        await ChainLDBOps.insertBigChainK(_bigChainK);

      }

    }

    return _bigChainK;
  }
  */
  // --------------------
  /*
  /// TASK DEPRECATED
  static Future<Chain> fetchBigChainS(BuildContext context) async {

    /// 1 - search LDB
    Chain _bigChainS = await ChainLDBOps.readBigChainS();

    /// 2 - bigChainS is not found in LDB
    if (_bigChainS == null) {

      _bigChainS = await ChainRealOps.readBigChainS(context);

      /// 3 - insert in LDB when found on firebase
      if (_bigChainS != null){

        await ChainLDBOps.insertBigChainS(_bigChainS);

      }

    }

    return _bigChainS;
  }
  */
  // --------------------
  /*
  /// TASK DEPRECATED
  static Future<void> renovateBigChainK({
    @required BuildContext context,
    @required Chain bigChainK,
  }) async {

    if (bigChainK != null){

      unawaited(WaitDialog.showWaitDialog(context: context,));

      await Future.wait(<Future>[

        ChainRealOps.updateBigChainK(
            context: context,
            bigChainK: bigChainK
        ),

        updateBigChainKLocally(
          context: context,
          bigChainK: bigChainK,
          showWaitDialog: false,
        ),

      ]);

      WaitDialog.closeWaitDialog(context);

    }

  }
  */
  // --------------------
  /*
  /// TASK DEPRECATED
  static Future<void> renovateBigChainS({
    @required BuildContext context,
    @required Chain bigChainS,
  }) async {

    if (bigChainS != null){

      unawaited(WaitDialog.showWaitDialog(context: context,));

      await Future.wait(<Future>[

        ChainRealOps.updateBigChainS(
            context: context,
            bigChainS: bigChainS
        ),

        updateBigChainSLocally(
          context: context,
          bigChainS: bigChainS,
          showWaitDialog: false,
        ),

      ]);

      WaitDialog.closeWaitDialog(context);

    }

  }*/
  // --------------------
  /*
  /// TASK DEPRECATED
  static Future<void> updateBigChainKLocally({
    @required BuildContext context,
    @required Chain bigChainK,
    @required bool showWaitDialog,
  }) async {

    if (bigChainK != null){

      if (showWaitDialog == true){
        unawaited(WaitDialog.showWaitDialog(context: context,));
      }

      /// UPDATE CHAIN K IN LDB
      await ChainLDBOps.updateBigChainK(
        newBigChainK: bigChainK,
      );

      /// UPDATE CHAIN K IN PRO
      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      await _chainsProvider.updateBigChainKOps(
        context: context,
        bigChainK: bigChainK,
        notify: true,
      );

      if (showWaitDialog == true){
        WaitDialog.closeWaitDialog(context);
      }


    }

  }

   */
  // --------------------
  /*
  /// TASK DEPRECATED
  static Future<void> updateBigChainSLocally({
    @required BuildContext context,
    @required Chain bigChainS,
    @required bool showWaitDialog,
  }) async {

    if (bigChainS != null){

      if (showWaitDialog == true){
        unawaited(WaitDialog.showWaitDialog(context: context,));
      }

      /// UPDATE CHAIN S IN LDB
      await ChainLDBOps.updateBigChainS(
        newBigChainS: bigChainS,
      );

      /// UPDATE CHAIN S IN PRO
      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      await _chainsProvider.updateBigChainSOps(
        context: context,
        bigChainS: bigChainS,
        notify: true,
      );

      if (showWaitDialog == true){
        WaitDialog.closeWaitDialog(context);
      }

    }

  }
   */
// -----------------------------------------------------------------------------
