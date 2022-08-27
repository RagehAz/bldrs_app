import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/b_pickers_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_protocols/spec_picker_protocols/picker_protocols.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------

/// SYNC

// -----------------------------
Future<void> onSyncSpecPickers({
  @required BuildContext context,
  @required ValueNotifier<List<PickerModel>> initialPickers,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required FlyerType flyerType,
}) async {

  final bool _continue = await Dialogs.confirmProceed(context: context);

  if (_continue == true){

    blog('onSyncSpecPickers');
    // await SpecPickerProtocols.renovatePickers();

    await PickerProtocols.renovateFlyerTypPickers(
        context: context,
        flyerType: flyerType,
        pickers: tempPickers.value,
    );

    initialPickers.value = tempPickers.value;

    await TopDialog.showSuccessDialog(
      context: context,
      firstLine: 'Sync Successful',
    );

  }

}
// ---------------------------------------------------------------------------

/// MODIFIERS

// -----------------------------
/// TESTED : WORKS PERFECT
Future<void> onPickerTileTap({
  @required BuildContext context,
  @required PickerModel picker,
  @required ZoneModel flyerZone,
}) async {

  await Nav.goToNewScreen(
    context: context,
    screen: SpecPickerScreen(
      zone: flyerZone,
      specPicker: picker,
      showInstructions: false,
      isMultipleSelectionMode: false,
      onlyUseCityChains: false,
      originalSpecs: const <SpecModel>[],
    ),
  );

}
// -----------------------------
/// TESTED : WORKS PERFECT
Future<void> onPickerChainIDTap({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<PickerModel>> tempPickers,
}) async {

  final TextEditingController _controller = TextEditingController(text: picker.chainID);

  await Dialogs.keyboardDialog(
    context: context,
    keyboardModel: KeyboardModel(
      titleVerse:  'Edit ChainID',
      hintVerse:  'Edit ChainID',
      controller: _controller,
      isFloatingField: false,
    ),
  );

  if (picker.chainID != _controller.text){

    final PickerModel _updated = picker.copyWith(
      chainID: _controller.text,
    );

    tempPickers.value = PickerModel.replacePicker(
      sourcePickers: tempPickers.value,
      pickerChainIDtoReplace: picker.chainID,
      updatedPicker: _updated,
    );

  }

}
// -----------------------------
/// TESTED : WORKS PERFECT
Future<void> onPickerUnitChainIDTap({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<PickerModel>> tempPickers,
}) async {

  final TextEditingController _controller = TextEditingController(text: picker.unitChainID);

  await Dialogs.keyboardDialog(
    context: context,
    keyboardModel: KeyboardModel(
      titleVerse:  'Edit Unit ChainID',
      hintVerse:  'Edit Unit ChainID',
      controller: _controller,
      isFloatingField: false,
    ),
  );

  if (picker.unitChainID != _controller.text){

    final PickerModel _updated = picker.copyWith(
      unitChainID: _controller.text,
    );

    tempPickers.value = PickerModel.replacePicker(
      sourcePickers: tempPickers.value,
      pickerChainIDtoReplace: picker.chainID,
      updatedPicker: _updated,
    );

  }


}
// -----------------------------
/// TESTED : WORKS PERFECT
Future<void> onSwitchIsRequired({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required bool newValue,
}) async {

  if (picker.isRequired != newValue){

    final PickerModel _updated = picker.copyWith(
        isRequired: newValue
    );

    tempPickers.value = PickerModel.replacePicker(
      sourcePickers: tempPickers.value,
      pickerChainIDtoReplace: picker.chainID,
      updatedPicker: _updated,
    );

  }

}
// -----------------------------
/// TESTED : WORKS PERFECT
Future<void> onSwitchCanPickMany({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required bool newValue,
}) async {

  if (picker.canPickMany != newValue){

    final PickerModel _updated = picker.copyWith(
        canPickMany: newValue
    );

    tempPickers.value = PickerModel.replacePicker(
      sourcePickers: tempPickers.value,
      pickerChainIDtoReplace: picker.chainID,
      updatedPicker: _updated,
    );

  }

}
// ---------------------------------------------------------------------------

///

// -----------------------------
