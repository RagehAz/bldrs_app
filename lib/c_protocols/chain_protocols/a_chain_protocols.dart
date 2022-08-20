import 'dart:async';

import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/city_phid_counters.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/e_db/real/ops/chain_real_ops.dart';
import 'package:bldrs/e_db/real/ops/city_chain_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';

class ChainProtocols {
// -----------------------------------------------------------------------------

  const ChainProtocols();

// -----------------------------------------------------------------------------

  /// COMPOSE

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Chain> composeChainK({
    @required BuildContext context,
    @required Chain chainK,
  }) async {

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Uploading ChainK to RealTime Database',
    ));

    /// NOTE : chain K does not allow duplicate IDs in last node
    final Chain _bigChainK = await ChainRealOps.createBigChainK(
        context: context,
        chainK: chainK,
    );

    WaitDialog.closeWaitDialog(context);

    return _bigChainK;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Chain> composeChainS({
    @required BuildContext context,
    @required Chain chainS,
  }) async {

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Uploading ChainS to RealTime Database',
    ));

    /// NOTE : chain S allows duplicate keys in its last nodes
    final Chain _bigChainS = await ChainRealOps.createBigChainS(
      context: context,
      chainS: chainS,
    );

    WaitDialog.closeWaitDialog(context);

    return _bigChainS;
  }
// -----------------------------------------------------------------------------

  /// FETCH

// ----------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Chain> fetchBigChainK(BuildContext context) async {

    Chain _bigChainK;

    /// 1 - search LDB
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.bigChainK,
    );

    /// 2 - bigChainK found in LDB
    if (Mapper.checkCanLoopList(_maps)) {

      _bigChainK = Chain.decipherBigChainK(
        bigChainKMap: _maps[0],
      );
    }

    /// 3 - bigChainK is not found in LDB
    else {

      _bigChainK = await ChainRealOps.readBigChainK(context);

      /// 3 - insert in LDB when found on firebase
      if (_bigChainK != null){

        await LDBOps.insertMap(
          input: Chain.cipherBigChainK(chainK: _bigChainK),
          docName: LDBDoc.bigChainK,
        );

      }

    }

    return _bigChainK;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<Chain> fetchBigChainS(BuildContext context) async {

    Chain _bigChainS;

    /// 1 - search LDB
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.bigChainS,
    );

    /// 2 - bigChainS found in LDB
    if (Mapper.checkCanLoopList(_maps)) {
      _bigChainS = Chain.decipherBigChainS(
          bigChainSMap: _maps[0],
      );
    }

    /// 3 - bigChainS is not found in LDB
    else {
      _bigChainS = await ChainRealOps.readBigChainS(context);

      /// 3 - insert in LDB when found on firebase
      if (_bigChainS != null){

        await LDBOps.insertMap(
          input: Chain.cipherBigChainS(chainS: _bigChainS),
          docName: LDBDoc.bigChainS,
        );

      }

    }

    return _bigChainS;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<CityPhidCounters> readCityPhidCountersOfCurrentZone({
    @required BuildContext context,
  }) async {
    CityPhidCounters _cityPhidCounters;

    final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: false,
    );

    if (_currentZone != null){

      _cityPhidCounters = await CityChainOps.readCityChain(
        context: context,
        cityID: _currentZone.cityID,
      );

    }

    return _cityPhidCounters;
  }
// -----------------------------------------------------------------------------

  /// RENOVATE

// -------------------------------------
///
// -----------------------------------------------------------------------------

  /// WIPE

// -------------------------------------

}
