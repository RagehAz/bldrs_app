import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum TransDoc{
  general,
  keywordsAndSpecs,

}

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
      'phrases' : Phrase.cipherPhrasesToMap(
        phrases: phrases,
      ),
    };
  }
// ----------------------------------------
  static TransModel decipher(Map<String, dynamic> map){

    TransModel _model;

    if (map != null){
      _model = TransModel(
          langCode: map['langCode'],
          phrases: Phrase.decipherPhrasesMap(map['phrases']),
      );
    }

    return _model;
  }
// ----------------------------------------
  static TransModel getTransModelFromStream(DocumentSnapshot<Object> doc) {

    // final DocumentSnapshot<Object> _docSnap = doc.data();

    final Map<String, dynamic> _map = Mapper.getMapFromDocumentSnapshot(doc);

    // blog('map is $_map');

    final TransModel _model = TransModel.decipher(_map);

    final TransModel _afterAddingLangCodeToPhrases = TransModel.addLangCodeInEachPhrase(_model);

    return _afterAddingLangCodeToPhrases;
  }
// -----------------------------------------------------------------------------

/// MODIFIERS

// ----------------------------------------
static TransModel addLangCodeInEachPhrase(TransModel transModel){

    if (
    // transModel != null
    //     &&
    //     Mapper.canLoopList(transModel.phrases) == true
    '' is String
    ){

      final List<Phrase> _editedPhrases = <Phrase>[];

      for (final Phrase _phrase in transModel.phrases){

        _editedPhrases.add(
          Phrase(
            id: _phrase.id,
            value: _phrase.value,
            trigram: _phrase.trigram,
            langCode: transModel.langCode,
          )
        );
      }

      return TransModel(
        langCode: transModel.langCode,
        phrases: _editedPhrases,
      );

    }

    else {
      return transModel;
    }
}
// -----------------------------------------------------------------------------
}
