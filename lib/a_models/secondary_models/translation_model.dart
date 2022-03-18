import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:flutter/material.dart';

/// EACH LANGUAGE SHOULD HAVE A TRANSLATIONS DOCUMENT
/// where different translation groups can be separated in Database
class TransModel {
  /// --------------------------------------------------------------------------
  const TransModel({
    @required this.langCode,
    @required this.phrases,
});
  /// --------------------------------------------------------------------------
  final String langCode;
  final List<Phrase> phrases;
// -----------------------------------------------------------------------------

/// CYPHERS

// ----------------------------------------
  Map<String, dynamic> toMap(){
    return {
      'langCode' : langCode,
      'phrases' : Phrase.cipherPhrases(
        phrases: phrases,
      ),
    };
  }
// ----------------------------------------
  static TransModel decipher(Map<String, dynamic> map){

    TransModel _model;

    if (map != null){
      _model = TransModel(
          langCode: map['lang'],
          phrases: Phrase.decipherPhrases(map['phrases']),
      );
    }

    return _model;
  }
// -----------------------------------------------------------------------------
}
