import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:flutter/cupertino.dart';

abstract class KeywordOps {
// -----------------------------------------------------------------------------
  static Future<List<KW>> readKeywordsOps({@required BuildContext context}) async {

    final Map<String,  dynamic> _keywordsMap = await Fire. readDoc(
        context: context,
        collName: FireColl.keys,
        docName: FireColl.keys_keywords,
    );

    final List<KW> _keywords = KW.decipherKeywordsMap(map: _keywordsMap);

    return _keywords;
  }
// -----------------------------------------------------------------------------



}