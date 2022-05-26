import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/e_db/fire/foundation/fire_finder.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// BZZ

// -----------------------------------------------
Future<List<BzModel>> paginateBzzBySearchingBzName({
  @required BuildContext context,
  @required String bzName,
  @required QueryDocumentSnapshot<Object> startAfter,
  @required int limit,

}) async {

  final List<Map<String, dynamic>> _result = await Fire.readCollectionDocs(
    collName: FireColl.bzz,
    addDocSnapshotToEachMap: true,
    startAfter: startAfter,
    limit: limit,
    finders: <FireFinder>[
      FireFinder(
        field: 'trigram',
        comparison: FireComparison.arrayContains,
        value: TextMod.removeAllCharactersAfterNumberOfCharacters(
          input: bzName.trim(),
          numberOfCharacters: Standards.maxTrigramLength,
        ),
      ),
    ],
  );

  List<BzModel> _bzz = <BzModel>[];

  if (Mapper.canLoopList(_result)) {
    _bzz = BzModel.decipherBzz(
      maps: _result,
      fromJSON: false,
    );
  }

  return _bzz;
}
// -----------------------------------------------------------------------------
