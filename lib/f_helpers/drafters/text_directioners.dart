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
  static bool appIsLeftToRight(BuildContext context) {
    bool _isLTR;

    if (Words.textDirection(context) == 'ltr') {
      _isLTR = true;
    } else {
      _isLTR = false;
    }

    return _isLTR;
  }
  // -----------------------------------------------------------------------------
  static TextDirection textDirectionAsPerAppDirection(BuildContext context) {

    final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);

    if (_phraseProvider.currentLangCode == 'en') {
      return TextDirection.ltr;
    } else {
      return TextDirection.rtl;
    }
  }
  // -----------------------------------------------------------------------------
  static TextDirection superInverseTextDirection(BuildContext context) {
    if (appIsLeftToRight(context)) {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }
  // -----------------------------------------------------------------------------
  static TextDirection superTextDirectionSwitcherByController(TextEditingController controller) {

    /// if keyboard lang is ltr ? ltr : rtl
    /// On native iOS the current keyboard language can be gotten from
    /// UITextInputMode
    /// and listened to with
    /// UITextInputCurrentInputModeDidChangeNotification.
    /// On native Android you can use
    /// getCurrentInputMethodSubtype
    /// to get the keyboard language, but I'm not seeing a way to listen
    /// to keyboard language changes.

    TextDirection _textDirection;

    final bool controllerIsEmpty = TextCheck.textControllerIsEmpty(controller);

    if (!controllerIsEmpty) {
      final String _string = controller.text;

      final String _trimmedVal = TextMod.removeSpacesFromAString(_string.trim());

      final String _firstCharacter = TextMod.cutNumberOfCharactersOfAStringBeginning(_trimmedVal, 1);

      // String _val = _trimmedVal; // first character defines the direction

      // print('_firstCharacter is ($_firstCharacter)');

      if (TextCheck.textStartsInEnglish(_firstCharacter)) {
        _textDirection = TextDirection.ltr;
      } else if (TextCheck.textStartsInArabic(_firstCharacter)) {
        _textDirection = TextDirection.rtl;
      } else {
        _textDirection = null;
      }
    } else {
      _textDirection = null;
    }

    return _textDirection;
  }
  // -----------------------------------------------------------------------------
  static TextDirection superTextDirectionSwitcher({
    @required BuildContext context,
    @required String val,
  }) {
    TextDirection _textDirection;

    // bool _appIsLeftToRight = appIsLeftToRight(context);
    // TextDirection _defaultByLang = _appIsLeftToRight == true ? TextDirection.ltr : TextDirection.rtl;

    final bool _controllerIsEmpty = TextCheck.isEmpty(val);

    /// when val has a value
    if (!_controllerIsEmpty) {
      final String _trimmedVal = TextMod.removeSpacesFromAString(val.trim());

      final String _firstCharacter = TextMod.cutNumberOfCharactersOfAStringBeginning(_trimmedVal, 1);

      // String _val = _trimmedVal; // first character defines the direction

      // print('_firstCharacter is ($_firstCharacter)');

      if (TextCheck.textStartsInEnglish(_firstCharacter)) {
        _textDirection = TextDirection.ltr;
      } else if (TextCheck.textStartsInArabic(_firstCharacter)) {
        _textDirection = TextDirection.rtl;
      } else {
        // _textDirection = _defaultByLang; // can not check app is left to right in initState of SuperTextField

        _textDirection = TextDirection.ltr; // instead of null
      }
    }

    /// when val is empty
    else {
      // _textDirection = _defaultByLang;
      /// can not check app is left to right in initState of SuperTextField
      _textDirection = textDirectionAsPerAppDirection(context); // instead of null

    }

    return _textDirection;
  }
  // -----------------------------------------------------------------------------
  static TextDirection concludeTextDirection({
    @required BuildContext context,
    @required TextDirection definedDirection,
    @required TextDirection detectedDirection,
  }) {
    TextDirection _concludedTextDirection;

    /// when definedDirection is already defined, it overrides all
    if (definedDirection != null) {
      _concludedTextDirection = definedDirection;
    }

    /// when it is not defined outside, and detectedDirection hadn't changed yet we
    /// use default superTextDirection that detects current app language
    else if (detectedDirection == null) {
      _concludedTextDirection = textDirectionAsPerAppDirection(context);
    }

    /// so otherwise we use detectedDirection that auto detects current input
    /// language
    else {
      _concludedTextDirection = detectedDirection;
    }

    return _concludedTextDirection;
  }
  // -----------------------------------------------------------------------------
}
