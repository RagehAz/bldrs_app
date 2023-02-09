import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_ui/keyboard_model.dart';
import 'package:bldrs/b_views/i_chains/b_picker_screen/b_picker_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/keyboard_screen/keyboard_screen.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/picker_protocols/protocols/picker_protocols.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/phrase_editor/x_phrase_editor_controllers.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stringer/stringer.dart';

// -----------------------------------------------------------------------------

/// SYNC

// --------------------
Future<void> onSyncSpecPickers({
  @required BuildContext context,
  @required ValueNotifier<List<PickerModel>> initialPickers,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required FlyerType flyerType,
  @required bool mounted,
}) async {

  final bool _continue = await Dialogs.confirmProceed(context: context);

  if (_continue == true){

    blog('onSyncSpecPickers');
    // await SpecPickerProtocols.renovatePickers();

    await PickerProtocols.renovateFlyerTypePickers(
      context: context,
      flyerType: flyerType,
      pickers: tempPickers.value,
    );

    setNotifier(
        notifier: initialPickers,
        mounted: mounted,
        value: tempPickers.value,
    );

    await Dialogs.showSuccessDialog(
      context: context,
      firstLine: const Verse(
        id: 'Sync Successful',
        translate: false,
      ),
    );

  }

}
// -----------------------------------------------------------------------------

/// NAV

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onGoToPickerScreen({
  @required BuildContext context,
  @required PickerModel picker,
  @required ZoneModel flyerZone,
}) async {

  await Nav.goToNewScreen(
    context: context,
    screen: PickerScreen(
      zone: flyerZone,
      picker: picker,
      showInstructions: false,
      isMultipleSelectionMode: false,
      onlyUseCityChains: false,
    ),
  );

}
// -----------------------------------------------------------------------------

/// MODIFIERS

// --------------------
/// TESTED : WORKS PERFECT
void onReorderPickers({
  @required int oldIndex,
  @required int newIndex,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required List<PickerModel> refinedPickers,
  @required bool mounted,
}){

  final List<PickerModel> _pickers = <PickerModel>[...refinedPickers];
  final PickerModel _picker = _pickers[oldIndex];

  // blog('before remove');
  // PickerModel.blogIndexes(_pickers);
  _pickers.removeAt(oldIndex);

  // blog('after remove');
  // PickerModel.blogIndexes(_pickers);
  _pickers.insert(newIndex, _picker);

  // blog('after insert');
  PickerModel.blogIndexes(_pickers);

  // blog('after correction');
  // PickerModel.blogIndexes(_pickers);

  setNotifier(
      notifier: tempPickers,
      mounted: mounted,
      value: PickerModel.correctModelsIndexes(_pickers),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
/*
Future<void> onChangeGroupIDForAllItsPickers({
  @required BuildContext context,
  @required String oldGroupID,
  @required ValueNotifier<List<PickerModel>> tempPickers,
}) async {

  final String _phid = await pickAPhidFast(context);

  if (oldGroupID != _phid){

    final bool _continue = await Dialogs.confirmProceed(
      context: context,
      titleVerse: Verse(
        text: 'replace ( $oldGroupID ) with ( $_phid ) ?',
        translate: false,
      ),
      bodyVerse: Verse(
        text: 'This will change all pickers of this group ( $oldGroupID )',
        translate: false,
      ),
    );

    if (_continue == true){

      final List<PickerModel> _updated = PickerModel.replaceAGroupID(
        pickers: tempPickers.value,
        oldGroupName: oldGroupID,
        newGroupName: _phid,
      );

      tempPickers.value  = _updated;

    }

  }

}
*/
// --------------------
/*
Future<void> onChangeGroupIDForSinglePicker({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<PickerModel>> tempPickers,
}) async {

  String _initialText = picker.groupID;

  _initialText = await Dialogs.keyboardDialog(
    context: context,
    keyboardModel: KeyboardModel(
      titleVerse: const Verse(
        text: 'Edit ChainID',
        translate: false,
      ),
      hintVerse: const Verse(
        text: 'Edit ChainID',
        translate: false,
      ),
      initialText: _initialText,
      isFloatingField: false,
    ),
  );

  if (_initialText != picker.groupID){

    final bool _continue = await Dialogs.confirmProceed(
      context: context,
      titleVerse: Verse(
        text: 'replace ( ${picker.groupID} ) with ( $_initialText ) ?',
        translate: false,
      ),
      bodyVerse: Verse(
        text: 'This will impact only this picker of chainID ( ${picker.chainID} )',
        translate: false,
      ),
    );

    if (_continue == true){

      final PickerModel _picker = picker.copyWith(
        groupID: _initialText,
      );

      tempPickers.value  = PickerModel.replacePicker(
          sourcePickers: tempPickers.value,
          pickerChainIDtoReplace: _picker.chainID,
          updatedPicker: _picker
      );

    }

  }

}
 */
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onPickerChainIDTap({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required bool mounted,
}) async {

  String _initialText = picker.chainID;

  _initialText = await KeyboardScreen.goToKeyboardScreen(
    context: context,
    keyboardModel: KeyboardModel(
        titleVerse: const Verse(
          id: 'Edit ChainID',
          translate: false,
        ),
        hintVerse: const Verse(
          id: 'Edit ChainID',
          translate: false,
        ),
        initialText: _initialText,
        isFloatingField: false,
        validator: (String text){
          if (TextCheck.isEmpty(text) == true){
            return 'ChainID can not be Empty';
          }
          else if (text == picker.chainID){

            return Formers.colorizeValidatorMessage(
              message: 'No changes happened to ChainID',
              color: Colorz.blue20,
            );

          }
          else {
            return null;
          }
        }
        ),
  );

  blog('onPickerChainIDTap : _initialText aho : $_initialText');

  if (picker.chainID != _initialText){

    final PickerModel _updated = picker.copyWith(
      chainID: _initialText,
    );

    setNotifier(
        notifier: tempPickers,
        mounted: mounted,
        value: PickerModel.replacePicker(
          sourcePickers: tempPickers.value,
          pickerChainIDtoReplace: picker.chainID,
          updatedPicker: _updated,
        ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onPickerUnitChainIDTap({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required bool mounted,
}) async {

  String _initialText = picker.unitChainID;

  _initialText = await Dialogs.keyboardDialog(
    context: context,
    keyboardModel: KeyboardModel(
      titleVerse: const Verse(
        id: 'Edit Unit ChainID',
        translate: false,
      ),
      hintVerse: const Verse(
        id: 'Edit Unit ChainID',
        translate: false,
      ),
      initialText: _initialText,
      isFloatingField: false,
    ),
  );

  if (picker.unitChainID != _initialText){

    final PickerModel _updated = picker.copyWith(
      unitChainID: _initialText,
    );

    setNotifier(
        notifier: tempPickers,
        mounted: mounted,
        value: PickerModel.replacePicker(
          sourcePickers: tempPickers.value,
          pickerChainIDtoReplace: picker.chainID,
          updatedPicker: _updated,
        ),
    );



  }


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSwitchIsRequired({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required bool newValue,
  @required bool mounted,
}) async {

  if (picker.isRequired != newValue){

    final PickerModel _updated = picker.copyWith(
        isRequired: newValue
    );

    setNotifier(
        notifier: tempPickers,
        mounted: mounted,
        value: PickerModel.replacePicker(
          sourcePickers: tempPickers.value,
          pickerChainIDtoReplace: picker.chainID,
          updatedPicker: _updated,
        ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSwitchCanPickMany({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required bool newValue,
  @required bool mounted,
}) async {

  if (picker.canPickMany != newValue){

    final PickerModel _updated = picker.copyWith(
        canPickMany: newValue
    );

    setNotifier(
        notifier: tempPickers,
        mounted: mounted,
        value: PickerModel.replacePicker(
          sourcePickers: tempPickers.value,
          pickerChainIDtoReplace: picker.chainID,
          updatedPicker: _updated,
        ),
    );


  }

}
// -----------------------------------------------------------------------------

///

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAddNewPickers({
  @required BuildContext context,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required bool mounted,
}) async {

  final String _phid = await pickAPhidFast(context);

  if (_phid != null){

    final bool _continue = await Dialogs.confirmProceed(
      context: context,
      titleVerse: Verse.plain('Add ( $_phid ) as chainID for new picker ?'),
    );

    if (_continue == true){

      final List<PickerModel> _updated = <PickerModel>[...tempPickers.value];

      final PickerModel _newPicker = PickerModel(
        chainID: _phid,
        index: tempPickers.value.length,
        isHeadline: false,
        // unitChainID: null,
        range: const [],
        blockers: const [],
      );


      final bool _containsPhid = PickerModel.checkPickersContainPicker(
        picker: _newPicker,
        pickers: _updated,
      );

      if (_containsPhid == true){
        await CenterDialog.showCenterDialog(
          context: context,
          titleVerse: Verse.plain('$_phid is already taken'),
          bodyVerse: Verse.plain('Can not add an new picker with this chain ID'),
          confirmButtonVerse: Verse.plain('Eshta'),
        );
      }
      else {
        _updated.add(_newPicker);

        setNotifier(
            notifier: tempPickers,
            mounted: mounted,
            value: _updated,
        );


      }


    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onDeletePicker({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required bool mounted,
}) async {

  final bool _continue = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: Verse.plain('Delete this picker of chainID : ( ${picker.chainID} )'),
    boolDialog: true,
    confirmButtonVerse: Verse.plain('Delete'),
  );

  if (_continue == true){

    final List<PickerModel> _pickers = <PickerModel>[...tempPickers.value];

    _pickers.removeWhere((element) => element.chainID == picker.chainID);

    setNotifier(
        notifier: tempPickers,
        mounted: mounted,
        value: _pickers,
    );


  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> switchHeadline({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required bool mounted,
}) async {

  final String _notice = picker.isHeadline == true ?
  'Switch headline ( ${picker.chainID} ) to normal picker ?'
      :
  'Switch picker ( ${picker.chainID} ) to headline ?';

  final bool _continue = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: Verse.plain(_notice),
    boolDialog: true,
    confirmButtonVerse: Verse.plain('Switch'),
  );

  if (_continue == true){

    final PickerModel _picker = picker.copyWith(
      isHeadline: !picker.isHeadline,
    );

    setNotifier(
        notifier: tempPickers,
        mounted: mounted,
        value: PickerModel.replacePicker(
            sourcePickers: tempPickers.value,
            pickerChainIDtoReplace: _picker.chainID,
            updatedPicker: _picker
        ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onHeadlineTap({
  @required BuildContext context,
  @required PickerModel picker,
  @required ValueNotifier<List<PickerModel>> tempPickers,
  @required bool mounted,
}) async {

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      numberOfWidgets: 4,
      titleVerse:  Verse.plain('Edit Headline ( ${picker.chainID} )'),
      // buttonHeight: BottomDialog.wideButtonHeight,
      builder: (_){

        return <Widget>[

          /// SWITCH HEADLINE TO NORMAL PICKER
          BottomDialog.wideButton(
            context: context,
            verse: const Verse(id: 'Switch to Normal Picker', translate: false),
            onTap: () async {

              await Dialogs.closDialog(context);

              await switchHeadline(
                context: context,
                picker: picker,
                tempPickers: tempPickers,
                mounted: mounted,
              );

            },
          ),

          /// CHANGE CHAIN ID
          BottomDialog.wideButton(
            context: context,
            verse: const Verse(id: 'change ChainID', translate: false),
            onTap: () async {

              await Dialogs.closDialog(context);

              await onPickerChainIDTap(
                context: context,
                picker: picker,
                tempPickers: tempPickers,
                mounted: mounted,
              );

            },
          ),

          /// DELETE
          BottomDialog.wideButton(
            context: context,
            verse: const Verse(id: 'Delete', translate: false),
            onTap: () async {

              await Dialogs.closDialog(context);

              await onDeletePicker(
                context: context,
                picker: picker,
                tempPickers: tempPickers,
                mounted: mounted,
              );

            },
          ),

        ];

      }
  );

}
// -----------------------------------------------------------------------------
