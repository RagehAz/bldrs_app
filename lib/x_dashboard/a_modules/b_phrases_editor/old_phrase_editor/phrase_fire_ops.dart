// import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
// import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
// import 'package:bldrs/e_db/fire/foundation/firestore.dart';
// import 'package:bldrs/e_db/fire/foundation/paths.dart';
// import 'package:bldrs/f_helpers/drafters/timers.dart';
// import 'package:bldrs/f_helpers/drafters/tracers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// ---------------------------------------------------------------------------

/// CREATE

// -----------------------------
///
// ---------------------------------------------------------------------------

/// READ

// -----------------------------
///
// -----------------------------
/*
Stream<List<Phrase>> getTransModelStream({
  @required BuildContext context,
  @required String langCode,
}) {

  final Stream<DocumentSnapshot<Object>> _snap = Fire.streamDoc(
    collName: FireColl.phrases,
    docName: langCode,
  );

  final Stream<List<Phrase>> _stream = _snap.map(
      (DocumentSnapshot doc){
        return Phrase.getPhrasesFromStream(
          doc: doc,
          langCode: langCode,
        );
      }
  );

  return _stream;

}
 */
// -----------------------------
// -----------------------------
/*
// Future<Phrase> readCountryPhrase({
//   @required BuildContext context,
//   @required String langCode,
//   @required String countryID,
// }) async {
//
//   final Map<String, dynamic> _map = await Fire.readSubDoc(
//       context: context,
//       collName: FireColl.translations,
//       docName: langCode,
//       subCollName: FireSubColl.translations_xx_countries,
//       subDocName: countryID,
//   );
//
//   final Phrase _countryPhrase = Phrase.decipherPhrase(
//     map: _map,
//     langCodeOverride: langCode,
//   );
//
//   return _countryPhrase;
// }
 */
// -----------------------------
/*
// Future<Phrase> readCityPhrase({
//   @required BuildContext context,
//   @required String langCode,
//   @required String cityID,
// }) async {
//
//   final Map<String, dynamic> _map = await Fire.readSubDoc(
//     context: context,
//     collName: FireColl.phrases,
//     docName: langCode,
//     subCollName: FireSubColl.translations_xx_cities,
//     subDocName: cityID,
//   );
//
//   final Phrase _cityPhrase = Phrase.decipherPhrase(
//     map: _map,
//     langCodeOverride: langCode,
//   );
//
//   return _cityPhrase;
// }
 */
// ---------------------------------------------------------------------------

/// UPDATE

// -----------------------------
/*
Future<bool> updatePhrases({
  @required BuildContext context,
  @required List<Phrase> enPhrases,
  @required List<Phrase> arPhrases,
}) async{

  final DocumentReference<Object> _enDocRef = await Fire.createNamedDoc(
    context: context,
    collName: FireColl.phrases,
    docName: 'en',
    input: Phrase.cipherOneLangPhrasesToMap(phrases: enPhrases),
  );

  await Fire.createNamedDoc(
    context: context,
    collName: FireColl.phrases,
    docName: 'ar',
    input:  Phrase.cipherOneLangPhrasesToMap(phrases: arPhrases),
  );

  return _enDocRef != null;
}
 */
// ---------------------------------------------------------------------------

/// DELETE

// -----------------------------
///
// ---------------------------------------------------------------------------

/// BACK UP

// -----------------------------
/*
/// TESTED : WORKS PERFECT
Future<void> backupPhrasesOps(BuildContext context) async {

  int _numberOfMaps = 0;

  final bool _success = await tryCatchAndReturnBool(
      context: context,
      functions: () async {

        /// GET ALL PHRASES MAPS BY THEIR LANG CODES
        final List<Map<String, dynamic>> _allLangMaps = await Fire.readCollectionDocs(
          context: context,
          collName: FireColl.phrases,
          addDocsIDs: true,
        );
        _numberOfMaps = _allLangMaps.length;

        /// SAVE EACH LANG DOC IN THE BACKUPS DIRECTORY
        for (final Map<String, dynamic> map in _allLangMaps){
          await Fire.createNamedSubDoc(
            context: context,
            collName: FireColl.admin,
            docName: FireDoc.admin_backups,
            subCollName: FireSubColl.admin_backups_phrases,
            subDocName: map['id'],
            input: map,
          );
        }

        /// UPDATE THE BACKUP TIME STAMP
        await Fire.createNamedSubDoc(
          context: context,
          collName: FireColl.admin,
          docName: FireDoc.admin_backups,
          subCollName: FireSubColl.admin_backups_phrases,
          subDocName: 'last_update_time',
          input: {
            'lastUpdate' : Timers.cipherTime(time: DateTime.now(), toJSON: false),
          },

        );

      }
  );

    /// REPORT BACK
  if (_success == true){
    blog('BACK UP SUCCESS : '
        'all $_numberOfMaps phrases docs '
        'are saved in '
        '${FireColl.admin}'
        '/${FireDoc.admin_backups}'
        '/${FireSubColl.admin_backups_phrases}'
    );
  }
  else {
    blog('BACK UP OPERATIONS FAILED : could not back up all phrases');
  }

}
 */
// ---------------------------------------------------------------------------
