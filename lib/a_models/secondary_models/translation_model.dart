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
// ----------------------------------------
  static TransModel getTransModelFromStream(DocumentSnapshot<Object> doc) {

    // final DocumentSnapshot<Object> _docSnap = doc.data();

    final Map<String, dynamic> _map = Mapper.getMapFromDocumentSnapshot(doc);

    // blog('map is $_map');

    final TransModel _model = TransModel.decipher(_map);
    return _model;
  }
// -----------------------------------------------------------------------------
}
