import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/b_phrases_editor/x_phrase_editor_controllers.dart';
import 'package:flutter/material.dart';

enum Casing {
  non,
  upperCase,
  lowerCase,
  capitalizeFirstChar, /// capitalize only first char of string
  // Proper,
  // upperCamelCase,
  // lowerCamelCase,
}

@immutable
class Verse {
  // -----------------------------------------------------------------------------
  const Verse({
    @required this.text,
    @required this.translate,
    this.casing = Casing.non,
    this.varTag,
    this.pseudo,
    this.notifier,
  });
  // -----------------------------------------------------------------------------
  final String text;
  final Casing casing;
  final bool translate;
  final dynamic varTag;
  final String pseudo;
  final ValueNotifier<String> notifier;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  Verse copyWith({
    String text,
    Casing casing,
    bool translate,
    dynamic varTag,
    String pseudo,
    ValueNotifier<String> notifier,
  }){

    return Verse(
      text: text ?? this.text,
      translate: translate ?? this.translate,
      casing: casing ?? this.casing,
      varTag: varTag ?? this.varTag,
      pseudo: pseudo ?? this.pseudo,
      notifier: notifier ?? this.notifier,
    );

  }
  // -----------------------------------------------------------------------------

  /// x

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkCanSuperTranslate({
    @required BuildContext context,
    @required Verse verse,
  }){

    bool _can = false;

    if (TextCheck.isEmpty(verse.text) == false && verse.translate == true){

      final String _translation = xPhrase(context, verse.text);
      if (_translation == null){
        _can = true;
      }
    }

    return _can;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToFastTranslator({
    @required BuildContext context,
    @required Verse verse,
  }) async {

    blog('fuck you : $verse');

    if (verse.pseudo != null){

    }

    await createAPhidFast(
      context: context,
      verse: verse,
    );

    await Keyboard.copyToClipboard(context: context, copy: verse.text);

  }
  // --------------------
  static Verse threeDots(){
    return const Verse(
      text: '...',
      translate: false,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Verse> createVerses({
    @required List<String> strings,
    @required bool translate,
    Casing casing,
  }){
    final List<Verse> _output = <Verse>[];

    if (Mapper.checkCanLoopList(strings) == true){

      for (final String string in strings){

        final Verse _verse = Verse(
          text: string,
          translate: translate,
          casing: casing,
        );

        _output.add(_verse);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getTextsFromVerses(List<Verse> verses){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(verses) == true){

      for (final Verse verse in verses){
        _output.add(verse.text);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse plain(String text){
    return Verse(
      text: text,
      translate: false,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse trans(String phid){
    return Verse(
      text: phid,
      translate: true,
    );
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  static String convertVerseCase({
    @required String verse,
    @required Casing verseCasing,
  }){

    switch (verseCasing){
      case Casing.non:             return verse;                   break;
      case Casing.lowerCase:       return verse.toLowerCase();     break;
      case Casing.upperCase:       return verse.toUpperCase();     break;
    // case VerseCasing.Proper:          return properVerse(verse);      break;
    // case VerseCasing.upperCamelCase:  return upperCemelVerse(verse);  break;
    // case VerseCasing.lowerCamelCase:  return lowelCamelVerse(verse);  break;
      default: return verse;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String bakeVerseToString({
    @required BuildContext context,
    @required Verse verse,
  }){

    String _output = verse?.translate == true ? verse.text.trim() : '.${verse?.text}';

    if (verse?.translate == true){

      /// ADJUST VALUE
      if (TextCheck.isEmpty(_output) == false){

        /// IS PHID
        final bool _isPhid = Phider.checkVerseIsPhid(_output);
        final bool _isCurrency = Phider.checkVerseIsCurrency(_output);
        if (_isPhid == true || _isCurrency == true){

          final String _foundXPhrase = xPhrase(context, verse.text);

          /// X PHRASE NOT FOUND
          if (_foundXPhrase == null){
            _output = '?$_output';
          }

          /// X PHRASE FOUND
          else {
            _output = '.$_foundXPhrase';
          }

        }

        /// NOT NOT PHID
        else {

          /// IS TEMP
          final bool _isTemp = Phider.checkVerseIsTemp(_output);
          if (_isTemp == true){
            _output = TextMod.removeTextBeforeLastSpecialCharacter(_output, '#');
            _output = '##$_output';
          }

          /// NOT TEMP - NOT PHID
          else {
            _output = '>$_output';
          }

        }

      }

    }

    /// ADJUST CASING
    return convertVerseCase(verse: _output, verseCasing: verse?.casing);
  }

  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is Verse){

      if (
          other.text == text &&
          other.translate == translate &&
          other.casing == casing &&
          other.varTag == varTag &&
          other.notifier == notifier
      ){
        _areIdentical = true;
      }

    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      text.hashCode^
      casing.hashCode^
      varTag.hashCode^
      notifier.hashCode^
      translate.hashCode;
// -----------------------------------------------------------------------------
}
