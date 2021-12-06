import 'package:bldrs/views/widgets/general/dialogs/nav_dialog/nav_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// -----------------------------------------------------------------------------
  /// TO MINIMIZE KEYBOARD WHEN TAPPING OUTSIDE
  void minimizeKeyboardOnTapOutSide (BuildContext context){
// FocusScope.of(context).requestFocus(FocusNode());
// print('x minimizeKeyboardOnTapOutSide() unfocused keyboard');
  // // ANOTHER SOLUTION
  final FocusScopeNode currentFocus = FocusScope.of(context);
  if(!currentFocus.hasPrimaryFocus){
    currentFocus.unfocus();
  }
}
// -----------------------------------------------------------------------------
  void closeKeyboard(BuildContext context){
  FocusScope.of(context).unfocus();
}
// -----------------------------------------------------------------------------
  bool keyboardIsOn(BuildContext context){
  // bool _keyboardIsOn;
///
//   bool _keyboardIsOn = FocusScope.of(context).hasFocus;
///
  // /// is on
  // if(_currentFocus.hasFocus){
  //   _keyboardIsOn = true;
  // }
  //
  // /// is off
  // else {
  //   _keyboardIsOn = false;
  // }
///

    final bool _keyboardIsOn = MediaQuery.of(context).viewInsets.bottom != 0;

  return _keyboardIsOn;
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
  Future<void> handlePaste(TextSelectionDelegate delegate) async {

  final TextEditingValue _value = delegate.textEditingValue; // Snapshot the input before using `await`.
  final ClipboardData _data = await Clipboard.getData(Clipboard.kTextPlain);

  if (_data != null) {

    final TextEditingValue _textEditingValue = TextEditingValue(
      text: _value.selection.textBefore(_value.text)
          + _data.text
          + _value.selection.textAfter(_value.text),
      selection: TextSelection.collapsed(
          offset: _value.selection.start + _data.text.length
      ),
    );

    const SelectionChangedCause _selectionChangedCause = SelectionChangedCause.tap;

    delegate.userUpdateTextEditingValue(_textEditingValue, _selectionChangedCause);
  }

  delegate.bringIntoView(delegate.textEditingValue.selection.extent);

  delegate.hideToolbar();
}
// -----------------------------------------------------------------------------
  Future<void> copyToClipboard({BuildContext context, String copy}) async {
    await Clipboard.setData(ClipboardData(text: copy,));

    await NavDialog.showNavDialog(
      context: context,
      firstLine: 'Copied to clipboard',
      secondLine: copy,
    );

    print('copied to clipboard : $copy');

  }
// -----------------------------------------------------------------------------
