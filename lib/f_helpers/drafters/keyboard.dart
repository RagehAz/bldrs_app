import 'dart:async';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_clip_board.dart';
import 'package:basics/helpers/classes/strings/text_mod.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
/// => TAMAM
class Keyboard {
  // -----------------------------------------------------------------------------

  const Keyboard();

  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static StreamSubscription<bool> initializeKeyboardListener({
    required KeyboardVisibilityController controller,
  }){

    /// Subscribe
    final StreamSubscription<bool> _keyboardSubscription = controller.onChange.listen((bool visible) {

      // blog('Keyboard visibility update. Is visible: $visible');

      final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);

      if (visible == false){
        FocusManager.instance.primaryFocus?.unfocus();
        _uiProvider.setKeyboardIsOn(
          setTo: false,
          notify: true,
        );
        // _uiProvider.setKeyboard(
        //     model: null,
        //     notify: true,
        //   invoker: 'initializeKeyboardListener',
        // );
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

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeKeyboard() async {
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
    final UiProvider _uiProvider = Provider.of<UiProvider>(getMainContext(), listen: false);
    final bool _keyboardIsOn = _uiProvider.keyboardIsOn;
    if (_keyboardIsOn == true){
      FocusManager.instance.primaryFocus?.unfocus();
      _uiProvider.setKeyboardIsOn(
        setTo: false,
        notify: true,
      );
      await Future.delayed(const Duration(milliseconds: 500));
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool keyboardIsOn() {
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

    return Provider.of<UiProvider>(getMainContext(), listen: false).keyboardIsOn;
  }
  // -----------------------------------------------------------------------------

  /// TEXT INPUT TYPE

  // --------------------
  static const List<TextInputType> textInputTypes = <TextInputType>[
    TextInputType.text,
    TextInputType.multiline,
    TextInputType.number,
    TextInputType.phone,
    TextInputType.datetime,
    TextInputType.emailAddress,
    TextInputType.url,
    TextInputType.visiblePassword,
    TextInputType.name,
    TextInputType.streetAddress,
    // TextInputType.none,
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? cipherTextInputType(TextInputType type){
    return TextMod.removeTextBeforeLastSpecialCharacter(
        text: type.toJson()['name'],
        specialCharacter: '.',
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TextInputType? decipherTextInputType(String? type){

    switch(type){
      case 'text'            : return TextInputType.text;
      case 'multiline'       : return TextInputType.multiline;
      case 'number'          : return TextInputType.number;
      case 'phone'           : return TextInputType.phone;
      case 'datetime'        : return TextInputType.datetime;
      case 'emailAddress'    : return TextInputType.emailAddress;
      case 'url'             : return TextInputType.url;
      case 'visiblePassword' : return TextInputType.visiblePassword;
      case 'name'            : return TextInputType.name;
      case 'streetAddress'   : return TextInputType.streetAddress;
      case 'none'            : return TextInputType.none;
      default: return null;
    }

  }
  // --------------------
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

  /// COPY TO CLIPBOARD

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> copyToClipboardAndNotify({
    required String? copy,
    int? milliseconds,
  }) async {

    await TextClipBoard.copy(
        copy: copy,
    );

    if (milliseconds != 0){
      await TopDialog.showTopDialog(
        firstVerse: const Verse(
          id: 'phid_copied_to_clipboard',
          translate: true,
        ),
        secondVerse: Verse.plain(copy),
        milliseconds: milliseconds,
      );
    }

    blog('copied to clipboard : $copy');
  }
  // -----------------------------------------------------------------------------

  /// COPY TO CLIPBOARD

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool autoCorrectIsOn(){

    if (DeviceChecker.deviceIsAndroid() == true){
      return false;
    }

    else if (DeviceChecker.deviceIsIOS() == true){
      return true;
    }

    else {
      return false;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool suggestionsEnabled(){

    if (DeviceChecker.deviceIsAndroid() == true){
      return true;
    }

    else if (DeviceChecker.deviceIsIOS() == true){
      return true;
    }

    else {
      return true;
    }

  }
  // -----------------------------------------------------------------------------
}
