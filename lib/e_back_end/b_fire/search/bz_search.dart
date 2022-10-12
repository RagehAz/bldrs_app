import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/e_back_end/b_fire/fire_models/fire_finder.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// BZZ

// --------------------
Future<List<BzModel>> paginateBzzBySearchingBzName({
  @required BuildContext context,
  @required String bzName,
  @required QueryDocumentSnapshot<Object> startAfter,
  @required int limit,
}) async {

  final List<Map<String, dynamic>> _result = await Fire.readCollectionDocs(
    context: context,
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
          numberOfChars: Standards.maxTrigramLength,
        ),
      ),
    ],
  );

  List<BzModel> _bzz = <BzModel>[];

  if (Mapper.checkCanLoopList(_result)) {
    _bzz = BzModel.decipherBzz(
      maps: _result,
      fromJSON: false,
    );
  }

  return _bzz;
}
// -----------------------------------------------------------------------------
