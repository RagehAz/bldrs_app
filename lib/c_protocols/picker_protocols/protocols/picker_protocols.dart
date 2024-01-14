import 'dart:async';

import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/app_state_real_ops.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/picker_protocols/ldb/picker_ldb_ops.dart';
import 'package:bldrs/c_protocols/picker_protocols/real/picker_real_ops.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// => TAMAM
class PickerProtocols {
  // -----------------------------------------------------------------------------

  const PickerProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> composeFlyerTypePickers({
    required List<PickerModel> pickers,
    required FlyerType flyerType,
  }) async {

    WaitDialog.showUnawaitedWaitDialog(
      verse: const Verse(id: 'Uploading ChainK to RealTime Database', translate: false),
    );

    await PickerRealOps.createPickers(
      flyerType: flyerType,
      pickers: pickers,
    );

    await WaitDialog.closeWaitDialog();

  }
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<PickerModel>> fetchFlyerTypPickers({
    required FlyerType? flyerType,
    ValueChanged<List<PickerModel>>? onFinish,
  }) async {

    /// 1 - search LDB
    List<PickerModel> _pickers = await PickerLDBOps.readPickers(
      flyerType: flyerType,
    );

    /// 2 - bigChainK is not found in LDB
    if (Lister.checkCanLoop(_pickers) == false){

      _pickers = await PickerRealOps.readPickers(
        flyerType: flyerType,
      );

      /// 3 - insert in LDB when found on firebase
      if (Lister.checkCanLoop(_pickers) == true){

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
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateFlyerTypePickers({
    required FlyerType flyerType,
    required List<PickerModel> pickers,
  }) async {

    if (Lister.checkCanLoop(pickers) == true){

      WaitDialog.showUnawaitedWaitDialog();

      await Future.wait(<Future>[

        PickerRealOps.updatePickers(
          flyerType: flyerType,
          updatedPickers: pickers,
        ),

        updateFlyerTypePickerLocally(
          flyerType: flyerType,
          pickers: pickers,
          showWaitDialog: false,
        ),

        AppStateFireOps.updateGlobalLDBVersion(),

      ]);

      await WaitDialog.closeWaitDialog();

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateFlyerTypePickerLocally({
    required FlyerType flyerType,
    required List<PickerModel> pickers,
    required bool showWaitDialog,
  }) async {

    if (Lister.checkCanLoop(pickers) == true){

      if (showWaitDialog == true){
        WaitDialog.showUnawaitedWaitDialog();
      }

      /// UPDATE PICKERS IN LDB
      await PickerLDBOps.updatePickers(
        flyerType: flyerType,
        pickers: pickers,
      );

      /// UPDATE PICKERS IN PRO
      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);
      _chainsProvider.setFlyerTypePickers(
        flyerType: flyerType,
        pickers: pickers,
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
