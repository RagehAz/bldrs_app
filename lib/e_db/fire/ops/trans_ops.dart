import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/secondary_models/translation_model.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ---------------------------------------------------------------------------

/// CREATE

// -----------------------------

// ---------------------------------------------------------------------------

/// READ

// -----------------------------

// -----------------------------
Stream<TransModel> getTransModelStream({
  @required BuildContext context,
  @required String langCode,
}) {

  final Stream<DocumentSnapshot<Object>> _snap = Fire.streamDoc(
    collName: FireColl.translations,
    docName: langCode,
  );

  final Stream<TransModel> _stream = _snap.map(TransModel.getTransModelFromStream);

  return _stream;

}
// -----------------------------
Future<List<Phrase>> readBasicPhrases({
  @required BuildContext context,
  @required String langCode,
}) async {

  final Map<String, dynamic> _transMap = await Fire.readDoc(
      context: context,
      collName: FireColl.translations,
      docName: langCode,
  );

  if (_transMap != null){

    final TransModel _transModel = TransModel.decipher(_transMap);

    return _transModel.phrases;
  }

  else {
    return null;
  }

}
// -----------------------------
Future<Phrase> readCountryPhrase({
  @required BuildContext context,
  @required String langCode,
  @required String countryID,
}) async {

  final Map<String, dynamic> _map = await Fire.readSubDoc(
      context: context,
      collName: FireColl.translations,
      docName: langCode,
      subCollName: FireSubColl.translations_xx_countries,
      subDocName: countryID,
  );

  final Phrase _countryPhrase = Phrase.decipherPhrase(
    map: _map,
    langCodeOverride: langCode,
  );

  return _countryPhrase;
}
// -----------------------------
Future<Phrase> readCityPhrase({
  @required BuildContext context,
  @required String langCode,
  @required String cityID,
}) async {

  final Map<String, dynamic> _map = await Fire.readSubDoc(
    context: context,
    collName: FireColl.translations,
    docName: langCode,
    subCollName: FireSubColl.translations_xx_cities,
    subDocName: cityID,
  );

  final Phrase _cityPhrase = Phrase.decipherPhrase(
    map: _map,
    langCodeOverride: langCode,
  );

  return _cityPhrase;
}
// ---------------------------------------------------------------------------

/// UPDATE

// -----------------------------
Future<void> updatePhrases({
  @required BuildContext context,
  @required List<Phrase> enPhrases,
  @required List<Phrase> arPhrases,
}) async{

  await Fire.updateDocField(
    context: context,
    collName: FireColl.translations,
    docName: 'en',
    field: 'phrases',
    input: Phrase.cipherPhrasesToMap(phrases: enPhrases),
  );

  await Fire.updateDocField(
      context: context,
      collName: FireColl.translations,
      docName: 'ar',
      field: 'phrases',
      input:  Phrase.cipherPhrasesToMap(phrases: arPhrases),
  );

}
// ---------------------------------------------------------------------------

/// DELETE

// -----------------------------

// -----------------------------------------------------------------------------
