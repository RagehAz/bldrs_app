import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:provider/provider.dart';
import 'package:stringer/stringer.dart';

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
    @required this.id,
    @required this.translate,
    this.casing = Casing.non,
    this.variables,
    this.pseudo,
    this.notifier,
  });
  // -----------------------------------------------------------------------------
  final String id;
  final Casing casing;
  final bool translate;
  final dynamic variables;
  final String pseudo;
  final ValueNotifier<String> notifier;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  Verse copyWith({
    String id,
    Casing casing,
    bool translate,
    dynamic variables,
    String pseudo,
    ValueNotifier<String> notifier,
  }){

    return Verse(
      id: id ?? this.id,
      translate: translate ?? this.translate,
      casing: casing ?? this.casing,
      variables: variables ?? this.variables,
      pseudo: pseudo ?? this.pseudo,
      notifier: notifier ?? this.notifier,
    );

  }
  // -----------------------------------------------------------------------------

  /// STANDARDS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse threeDots(){
    return const Verse(
      id: '...',
      translate: false,
    );
  }
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse plain(String text){
    return Verse(
      id: text ?? '',
      translate: false,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse trans(String phid){
    return Verse(
      id: phid,
      translate: true,
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
          id: string,
          translate: translate,
          casing: casing,
        );

        _output.add(_verse);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getVersesIDs(List<Verse> verses){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(verses) == true){

      for (final Verse verse in verses){
        _output.add(verse.id);
      }

    }

    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static List<String> bakeVerses({
    @required List<Verse> verses,
    @required BuildContext context,
  }){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(verses) == true){

      for (final Verse verse in verses){

        final String _baked = bakeVerseToString(
            context: context,
            verse: verse
        );

        _output.add(_baked);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CASING

  // --------------------
  /// TESTED : WORKS PERFECT
  static String convertVerseCase({
    @required String verse,
    @required Casing verseCasing,
  }){

    switch (verseCasing){
      case Casing.non:             return verse;                   break;
      case Casing.lowerCase:       return verse?.toLowerCase();     break;
      case Casing.upperCase:       return verse?.toUpperCase();     break;
    // case VerseCasing.Proper:          return properVerse(verse);      break;
    // case VerseCasing.upperCamelCase:  return upperCemelVerse(verse);  break;
    // case VerseCasing.lowerCamelCase:  return lowelCamelVerse(verse);  break;
      default: return verse;
    }

  }
  // -----------------------------------------------------------------------------

  /// TRANSLATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkShouldTranslateButNotFound({
    @required BuildContext context,
    @required Verse verse,
  }){

    bool _shouldButNotFound = false;

    if (TextCheck.isEmpty(verse.id) == false && verse.translate == true){

      final String _translation = xPhrase(context, verse.id);
      if (_translation == null){
        _shouldButNotFound = true;
      }
    }

    return _shouldButNotFound;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkPendingAssigningPhid(String string){
    bool _need = false;

    if (
    TextMod.removeAllCharactersAfterNumberOfCharacters(
        input: string,
        numberOfChars: 2
    ) == '##'
    ){
      _need = true;
    }

    return _need;
  }
  // -----------------------------------------------------------------------------

  /// BAKING

  // --------------------
  /// TESTED : WORKS PERFECT
  static String bakeVerseToString({
    @required BuildContext context,
    @required Verse verse,
    PhraseProvider phrasePro,
  }){

    String _output;

    if (verse != null && TextCheck.isEmpty(verse?.id) == false){

      _output = verse?.translate == true ? verse.id.trim() : verse?.id;

      if (verse?.translate == true){

        /// ADJUST VALUE
        if (TextCheck.isEmpty(_output) == false){

          /// IS PHID
          final bool _isPhid = Phider.checkVerseIsPhid(_output);
          final bool _isCurrency = Phider.checkVerseIsCurrency(_output);
          final bool _isHeadline = Phider.checkVerseIsHeadline(_output);
          if (_isPhid == true || _isCurrency == true || _isHeadline == true){

            final PhraseProvider _phraseProvider = phrasePro ?? Provider.of<PhraseProvider>(context, listen: false);
            final String _foundXPhrase = xPhrase(context, verse.id, phrasePro: _phraseProvider);

            /// X PHRASE NOT FOUND
            if (_foundXPhrase == null){
              _output = 'τ.$_output'; // τ : should be translated : phid assigned : not found in allPhrases
            }

            /// X PHRASE FOUND
            else {
              _output = _foundXPhrase; // . : perfect and finished
            }

          }

          /// NOT NOT PHID
          else {

            /// IS TEMP
            final bool _isTemp = Phider.checkVerseIsTemp(_output);
            if (_isTemp == true){
              _output = TextMod.removeTextBeforeLastSpecialCharacter(_output, '#');
              _output = '##$_output'; // should be translated : phid not assigned yet : not yet in allPhrases
            }

            /// NOT TEMP - NOT PHID
            else {
              _output = '?$_output'; // should be translated : phid not assigned : not found in all phrases : something is wrong
            }

          }

        }

      }

    }

    /// ADJUST CASING
    return convertVerseCase(verse: _output, verseCasing: verse?.casing);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String transBake(BuildContext context, String phid, {PhraseProvider phrasePro}){
    return Verse.bakeVerseToString(
      phrasePro: phrasePro,
      context: context,
      verse: Verse(
        id: phid,
        translate: true,
      ),
    );
  }
  // -----------------------------------------------------------------------------

  /// CHECKING

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool isEmpty(Verse verse){
    bool _isEmpty = true;

    if (verse != null){
      if (TextCheck.isEmpty(verse.id) == false){
        _isEmpty = false;
      }
    }

    return _isEmpty;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  void blogVerse({String invoker = 'Blog'}){
    blog('Verse.$invoker : ($id) : translate : $translate');
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
          other.id == id &&
          other.translate == translate &&
          other.casing == casing &&
          other.variables == variables &&
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
      id.hashCode^
      casing.hashCode^
      variables.hashCode^
      notifier.hashCode^
      translate.hashCode;
// -----------------------------------------------------------------------------
}
