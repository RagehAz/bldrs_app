import 'dart:async';

import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/e_db/real/ops/chain_real_ops.dart';
import 'package:flutter/material.dart';

class ChainProtocols {
// -----------------------------------------------------------------------------

  const ChainProtocols();

// -----------------------------------------------------------------------------

  /// COMPOSE

// -------------------------------------
  static Future<Chain> composeChainK({
    @required BuildContext context,
    @required Chain chainK,
  }) async {

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Uploading ChainK to RealTime Database',
    ));

    /// NOTE : chain K does not allow duplicate IDs in last node
    final Chain _bigChainK = await ChainRealOps.createChainK(
        context: context,
        chainK: chainK,
    );

    WaitDialog.closeWaitDialog(context);

    return _bigChainK;
  }
// -----------------------------------------------------------------------------

  /// FETCH

// -------------------------------------

// -----------------------------------------------------------------------------

  /// RENOVATE

// -------------------------------------

// -----------------------------------------------------------------------------

  /// WIPE

// -------------------------------------

}
