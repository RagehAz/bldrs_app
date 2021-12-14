import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/search/fire_search.dart' as FireSearch;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// BZZ

// -----------------------------------------------
Future<List<BzModel>> bzzByBzName({
  @required BuildContext context,
  @required String bzName
}) async {
  final List<Map<String, dynamic>> _result = await FireSearch.mapsByFieldValue(
    context: context,
    collName: FireColl.bzz,
    field: 'trigram',
    compareValue: TextMod.removeAllCharactersAfterNumberOfCharacters(
      input: bzName.trim(),
      numberOfCharacters: Standards.maxTrigramLength,
    ),
    valueIs: FireSearch.ValueIs.arrayContains,
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
