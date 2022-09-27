import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// TEXT DIRECTION
class TextDir {
  // -----------------------------------------------------------------------------

  const TextDir();

  // -----------------------------------------------------------------------------
  /// TASK : need to test this method to detect text direction
  /*
 import 'package:intl/intl.dart' as international;
 bool isRTL(String text) {
   return international.Bidi.detectRtlDirectionality(text);
 }
  */
  // -----------------------------------------------------------------------------

    /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkAppIsLeftToRight(BuildContext context) {

    if (Words.textDirection(context) == 'ltr') {
      return true;
    }

    else {
      return false;
    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static TextDirection getAppLangTextDirection(BuildContext context) {

    if (Provider.of<PhraseProvider>(context, listen: false).currentLangCode == 'en') {
      return TextDirection.ltr;
    }

    else {
      return TextDirection.rtl;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TextDirection getAppLangInverseTextDirection(BuildContext context) {

    if (checkAppIsLeftToRight(context)) {
      return TextDirection.rtl;
    }

    else {
      return TextDirection.ltr;
    }

  }
  // -----------------------------------------------------------------------------

  /// AUTO SWITCHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static TextDirection autoSwitchTextDirectionByController(TextEditingController controller) {

    /// if keyboard lang is ltr ? ltr : rtl
    /// On native iOS the current keyboard language can be gotten from
    /// UITextInputMode
    /// and listened to with
    /// UITextInputCurrentInputModeDidChangeNotification.
    /// On native Android you can use
    /// getCurrentInputMethodSubtype
    /// to get the keyboard language, but I'm not seeing a way to listen
    /// to keyboard language changes.

    if (TextCheck.textControllerIsEmpty(controller) == false) {

      /// first character defines the direction
      final String _trimmedVal = TextMod.removeSpacesFromAString(controller.text.trim());
      final String _firstCharacter = TextMod.cutNumberOfCharactersOfAStringBeginning(_trimmedVal, 1);

      if (TextCheck.textStartsInEnglish(_firstCharacter) == true) {
        return TextDirection.ltr;
      }

      else if (TextCheck.textStartsInArabic(_firstCharacter) == true) {
        return TextDirection.rtl;
      }

      else {
        return null;
      }

    }

    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static TextDirection autoSwitchTextDirection({
    @required BuildContext context,
    @required String val,
  }) {

    // bool _appIsLeftToRight = appIsLeftToRight(context);
    // TextDirection _defaultByLang = _appIsLeftToRight == true ? TextDirection.ltr : TextDirection.rtl;

    /// when val has a value
    if (TextCheck.isEmpty(val) == false) {

      /// first character defines the direction
      final String _trimmedVal = TextMod.removeSpacesFromAString(val.trim());
      final String _firstCharacter = TextMod.cutNumberOfCharactersOfAStringBeginning(_trimmedVal, 1);

      if (TextCheck.textStartsInEnglish(_firstCharacter)) {
        return TextDirection.ltr;
      }

      else if (TextCheck.textStartsInArabic(_firstCharacter)) {
        return TextDirection.rtl;
      }

      else {
        // _textDirection = _defaultByLang; // can not check app is left to right in initState of SuperTextField
        return TextDirection.ltr; // instead of null
      }

    }

    /// when val is empty
    else {
      // _textDirection = _defaultByLang;
      /// can not check app is left to right in initState of SuperTextField
      return getAppLangTextDirection(context); // instead of null
    }

  }
  // -----------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static TextDirection concludeTextDirection({
    @required BuildContext context,
    @required TextDirection definedDirection,
    @required TextDirection detectedDirection,
  }) {

    /// when definedDirection is already defined, it overrides all
    if (definedDirection != null) {
      return definedDirection;
    }

    /// when it is not defined outside, and detectedDirection hadn't changed yet we
    /// use default superTextDirection that detects current app language
    else if (detectedDirection == null) {
      return getAppLangTextDirection(context);
    }

    /// so otherwise we use detectedDirection that auto detects current input
    /// language
    else {
      return detectedDirection;
    }

  }
  // -----------------------------------------------------------------------------
}
