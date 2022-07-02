import 'dart:async';

import 'package:bldrs/b_views/z_components/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// -------------------------------------
StreamSubscription<bool> initializeKeyboardListener({
  @required BuildContext context,
  @required KeyboardVisibilityController controller,
}){

  /// Subscribe
  final StreamSubscription<bool> _keyboardSubscription = controller.onChange.listen((bool visible) {

    // blog('Keyboard visibility update. Is visible: $visible');

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

    if (visible == false){
      FocusManager.instance.primaryFocus?.unfocus();
      _uiProvider.setKeyboardIsOn(
          setTo: false,
          notify: false
      );
      _uiProvider.setKeyboard(
          model: null,
          notify: true
      );
    }

    else {
      _uiProvider.setKeyboardIsOn(
          setTo: true,
          notify: true,
      );
    }

  });

  return _keyboardSubscription;
}
// -----------------------------------------------------------------------------

  /// CONTROLLING KEYBOARD

// -------------------------------------
void closeKeyboard(BuildContext context) {
  /// SOLUTION 1
  // FocusScope.of(context).requestFocus(FocusNode());
  // blog('x minimizeKeyboardOnTapOutSide() unfocused keyboard');
  /// SOLUTION 2
  // final FocusScopeNode currentFocus = FocusScope.of(context);
  // if (!currentFocus.hasPrimaryFocus) {
  //   currentFocus.unfocus();
  // }
  /// SOLUTION 3
  // FocusScope.of(context).unfocus();
  /// SOLUTION 4
  // final bool _keyboardIsOn = KeyboardVisibilityProvider.isKeyboardVisible(context);
  /// FINAL SOLUTION ISA
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final bool _keyboardIsOn = _uiProvider.keyboardIsOn;
  if (_keyboardIsOn == true){
    FocusManager.instance.primaryFocus?.unfocus();
  }

}
// -----------------------------------------------------------------------------
bool keyboardIsOn(BuildContext context) {
  /// SOLUTION 1
  // bool _keyboardIsOn = FocusScope.of(context).hasFocus;
  /// SOLUTION 2
  // bool _keyboardIsOn;
  // if(_currentFocus.hasFocus){
  //   _keyboardIsOn = true;
  // }
  //
  // /// is off
  // else {
  //   _keyboardIsOn = false;
  // }
  /// SOLUTION 3
  // final bool _keyboardIsOn = MediaQuery.of(context).viewInsets.bottom != 0;
  /// SOLUTION 4
  // final bool _keyboardIsOn = KeyboardVisibilityProvider?.isKeyboardVisible(context);
  /// FINAL SOLUTION ISA
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final bool _keyboardIsOn = _uiProvider.keyboardIsOn;
  return _keyboardIsOn;
}
// -----------------------------------------------------------------------------
/*
// HOW TO DETECT CURRENT KEYBOARD LANGUAGE OF THE DEVICE (NOT SOLVED)
// BEST COMMENT HERE https://github.com/flutter/flutter/issues/25841
// justinmc commented on Jul 9, 2020 •
// On native iOS the current keyboard language can be gotten from [UITextInputMode]
// and listened to with UITextInputCurrentInputModeDidChangeNotification.
//
// On native Android you can use [getCurrentInputMethodSubtype] to get the keyboard
// language, but I'm not seeing a way to listen to keyboard language changes.
// Does anyone know if it's possible to listen for a keyboard language change
// on native Android?
 */
// -----------------------------------------------------------------------------

/// COPY PASTE

// -------------------------------------
Future<void> handlePaste(TextSelectionDelegate delegate) async {

  final TextEditingValue _value = delegate.textEditingValue; // Snapshot the input before using `await`.
  final ClipboardData _data = await Clipboard.getData(Clipboard.kTextPlain);

  if (_data != null) {

    final TextEditingValue _textEditingValue = TextEditingValue(
      text: _value.selection.textBefore(_value.text)
          + _data.text
          + _value.selection.textAfter(_value.text),
      selection: TextSelection.collapsed(
          offset: _value.selection.start
              + _data.text.length
      ),
    );

    const SelectionChangedCause _selectionChangedCause = SelectionChangedCause.tap;

    delegate.userUpdateTextEditingValue(_textEditingValue, _selectionChangedCause);

  }

  delegate.bringIntoView(delegate.textEditingValue.selection.extent);

  delegate.hideToolbar();
}
// -----------------------------------------------------------------------------
Future<void> copyToClipboard({
  @required BuildContext context,
  @required String copy,
}) async {

  await Clipboard.setData(
      ClipboardData(
        text: copy,
      )
  );

  NavDialog.showNavDialog(
    context: context,
    firstLine: 'Copied to clipboard',
    secondLine: copy,
  );

  blog('copied to clipboard : $copy');
}
// -----------------------------------------------------------------------------
