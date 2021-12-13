import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:flutter/cupertino.dart';

// -----------------------------------------------------------------------------
Future<List<KW>> readKeywordsOps({@required BuildContext context}) async {
  const List<String> _keywordsDocs = <String>[
    FireDoc.keys_propertiesKeywords,
    FireDoc.keys_designsKeywords,
    FireDoc.keys_craftsKeywords,
    FireDoc.keys_productsKeywords,
    FireDoc.keys_equipmentKeywords,
  ];

  final List<KW> _allKeywords = <KW>[];

  for (final String doc in _keywordsDocs) {
    final Map<String, dynamic> _keywordsMap = await Fire.readDoc(
      context: context,
      collName: FireColl.keys,
      docName: doc,
    );

    final List<KW> _keywords =
        KW.decipherKeywordsFirebaseMap(map: _keywordsMap);

    _allKeywords.addAll(_keywords);
  }

  return _allKeywords;
}
// -----------------------------------------------------------------------------
