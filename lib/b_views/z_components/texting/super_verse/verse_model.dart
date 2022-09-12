import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
  });
  // -----------------------------------------------------------------------------
  final String text;
  final Casing casing;
  final bool translate;
  final dynamic varTag;
  final String pseudo;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  Verse copyWith({
    String text,
    Casing casing,
    bool translate,
    dynamic variable,
    String pseudo,
  }){

    return Verse(
      text: text ?? this.text,
      translate: translate ?? this.translate,
      casing: casing ?? this.casing,
      varTag: variable ?? this.varTag,
      pseudo: pseudo ?? this.pseudo,
    );

  }
  // -----------------------------------------------------------------------------

  /// x

  // --------------------
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
  static Future<void> goToFastTranslator({
    @required BuildContext context,
    @required Verse verse,
  }) async {

    blog('fuck you : $verse');

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
  static List<String> getTextsFromVerses(List<Verse> verses){
    final List<String> _output = <String>[];
    for (final Verse verse in verses){
      _output.add(verse.text);
    }
    return _output;
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
          other.varTag == varTag
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
      translate.hashCode;
// -----------------------------------------------------------------------------
}
