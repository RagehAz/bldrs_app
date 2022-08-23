import 'dart:async';

import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/e_db/ldb/ops/picker_ldb_ops.dart';
import 'package:bldrs/e_db/real/ops/picker_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PickerProtocols {
// -----------------------------------------------------------------------------

  const PickerProtocols();

// -----------------------------------------------------------------------------

  /// COMPOSE

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeFlyerTypePickers({
    @required BuildContext context,
    @required List<PickerModel> pickers,
    @required FlyerType flyerType,
  }) async {

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Uploading ChainK to RealTime Database',
    ));

    await PickerRealOps.createPickers(
      context: context,
      flyerType: flyerType,
      pickers: pickers,
    );

    WaitDialog.closeWaitDialog(context);

  }
// -----------------------------------------------------------------------------

  /// FETCH

// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<List<PickerModel>> fetchFlyerTypPickers({
    @required BuildContext context,
    @required FlyerType flyerType,
    ValueChanged<List<PickerModel>> onFinish,
  }) async {

    /// 1 - search LDB
     List<PickerModel> _pickers = await PickerLDBOps.readPickers(
        flyerType: flyerType,
    );

    /// 2 - bigChainK is not found in LDB
    if (Mapper.checkCanLoopList(_pickers) == false){

      _pickers = await PickerRealOps.readPickers(
        context: context,
        flyerType: flyerType,
      );

      /// 3 - insert in LDB when found on firebase
      if (Mapper.checkCanLoopList(_pickers) == true){

        await PickerLDBOps.insertPickers(
          pickers: _pickers,
          flyerType: flyerType,
        );

      }

    }

    if (onFinish != null){
      onFinish(_pickers);
    }

    return _pickers;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateFlyerTypPickers({
    @required BuildContext context,
    @required FlyerType flyerType,
    @required List<PickerModel> pickers,
  }) async {

    if (Mapper.checkCanLoopList(pickers) == true){

      unawaited(WaitDialog.showWaitDialog(context: context,));

      await Future.wait(<Future>[

        PickerRealOps.updatePickers(
          context: context,
          flyerType: flyerType,
          updatedPickers: pickers,
        ),

        updateFlyerTypePickerLocally(
          context: context,
          flyerType: flyerType,
          pickers: pickers,
          showWaitDialog: false,
        ),

      ]);

      WaitDialog.closeWaitDialog(context);

    }

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateFlyerTypePickerLocally({
    @required BuildContext context,
    @required FlyerType flyerType,
    @required List<PickerModel> pickers,
    @required bool showWaitDialog,
  }) async {

    if (Mapper.checkCanLoopList(pickers) == true){

      if (showWaitDialog == true){
        unawaited(WaitDialog.showWaitDialog(context: context,));
      }

      /// UPDATE PICKERS IN LDB
      await PickerLDBOps.updatePickers(
        flyerType: flyerType,
        pickers: pickers,
      );

      /// UPDATE PICKERS IN PRO
      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      _chainsProvider.setFlyerTypePickers(
        context: context,
        flyerType: flyerType,
        pickers: pickers,
        notify: true,
      );

      if (showWaitDialog == true){
        WaitDialog.closeWaitDialog(context);
      }

    }

  }
// -----------------------------------------------------------------------------

/// WIPE

// -------------------------------------
/// NO NEED
// -----------------------------------------------------------------------------
}
