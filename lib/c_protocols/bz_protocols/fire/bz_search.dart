import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire_paths.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:fire/fire.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
// -----------------------------------------------------------------------------

/// BZZ

// --------------------
Future<List<BzModel>> paginateBzzBySearchingBzName({
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
