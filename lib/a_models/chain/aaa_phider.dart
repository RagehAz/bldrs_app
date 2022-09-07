// ignore_for_file: constant_identifier_names
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';

class Phider {
  // -----------------------------------------------------------------------------

  /// PHID IS : 'phrase ID' : consists of several cuts
  /// Example :-
  /// String phid         = 'phid_k_am_clubHouse'
  /// List<String> cuts   = ['phid', 'k', 'am', 'clubHouse'];
  const Phider();

  // -----------------------------------------------------------------------------

  /// CONSTANTS

  // --------------------
  static const String phid = 'phid';
  static const String phid_k = 'phid_k';
  static const String phid_s = 'phid_s';
  static const String currency = 'currency';
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  // static bool
  // -----------------------------------------------------------------------------

  /// CHECKER

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkIsPhid(dynamic object){
    bool _isPhid = false;

    if (object != null){

      if (object is String){

        _isPhid = TextCheck.textStartsExactlyWith(
            text: object,
            startsWith: phid,
        );

      }

    }

    return _isPhid;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkVerseIsPhid(String text){

    final String _phid = TextMod.removeAllCharactersAfterNumberOfCharacters(
      input: text,
      numberOfChars: phid.length, // 'phid'
    )?.toLowerCase();

    return _phid == phid;
  }
  // --------------------
  ///
  static bool checkVerseIsCurrency(String text){
    bool _isCurrency = false;

    if (text != null){

      final String _phid = TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: text,
        numberOfChars: currency.length,
      )?.toLowerCase();

      /*
    /// SOLUTION 2
    /// CURRENCY PHID COME LIKES THIS : 'currency_xxx'
    final String _phid = TextMod.removeTextAfterFirstSpecialCharacter(phid, '_');
     */

      _isCurrency = _phid == currency;
    }

    return _isCurrency;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkVerseIsTemp(String text){
    final String _temp = TextMod.removeAllCharactersAfterNumberOfCharacters(
      input: text,
      numberOfChars: 2, //'##'
    );
    return _temp == '##';
  }
  // -----------------------------------------------------------------------------
}
