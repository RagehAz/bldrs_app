import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/dialogs/nav_dialog/nav_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Keyboarders {
// -----------------------------------------------------------------------------
  /// TO MINIMIZE KEYBOARD WHEN TAPPING OUTSIDE
  static void minimizeKeyboardOnTapOutSide (BuildContext context){
// FocusScope.of(context).requestFocus(FocusNode());
// print('x minimizeKeyboardOnTapOutSide() unfocused keyboard');
  // // ANOTHER SOLUTION
  FocusScopeNode currentFocus = FocusScope.of(context);
  if(!currentFocus.hasPrimaryFocus){
    currentFocus.unfocus();
  }
}
// -----------------------------------------------------------------------------
  static void closeKeyboard(BuildContext context){
  FocusScope.of(context).unfocus();
}
// -----------------------------------------------------------------------------
  static bool keyboardIsOn(BuildContext context){
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

    bool _keyboardIsOn = MediaQuery.of(context).viewInsets.bottom != 0;

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
  static Future<void> handlePaste(TextSelectionDelegate delegate) async {

  final TextEditingValue value = delegate.textEditingValue; // Snapshot the input before using `await`.
  final ClipboardData data = await Clipboard.getData(Clipboard.kTextPlain);

  if (data != null) {

    TextEditingValue _textEditingValue = TextEditingValue(
      text: value.selection.textBefore(value.text)
          + data.text
          + value.selection.textAfter(value.text),
      selection: TextSelection.collapsed(
          offset: value.selection.start + data.text.length
      ),
    );

    SelectionChangedCause _selectionChangedCause = SelectionChangedCause.tap;

    delegate.userUpdateTextEditingValue(_textEditingValue, _selectionChangedCause);
  }

  delegate.bringIntoView(delegate.textEditingValue.selection.extent);

  delegate.hideToolbar();
}
// -----------------------------------------------------------------------------
  static Future<void> copyToClipboard({BuildContext context, String copy}) async {
    await Clipboard.setData(ClipboardData(text: copy,));

    await NavDialog.showNavDialog(
      context: context,
      isBig: true,
      firstLine: 'Copied to clipboard',
      secondLine: copy,
      color: Colorz.Black255,
    );

    print('copied to clipboard : $copy');

  }
// -----------------------------------------------------------------------------

}