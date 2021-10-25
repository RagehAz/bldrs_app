import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/db/firestore/keyword_ops.dart';
import 'package:bldrs/db/ldb/bldrs_local_dbs.dart';
import 'package:bldrs/models/kw/kw.dart';
import 'package:flutter/cupertino.dart';

// final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);
class KeywordsProvider extends ChangeNotifier{
// -----------------------------------------------------------------------------
  /// FETCHING KEYWORDS
  Future<List<KW>> fetchAllKeywords({@required BuildContext context}) async {

    List<KW> _allKeywords;

    /// 1 - search LDB
      final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
        docName: LDBDoc.keywords,
      );


      if (Mapper.canLoopList(_maps)){
        _allKeywords = KW.decipherKeywordsMaps(maps: _maps);
      }

    /// 2 - if not found, search firebase
    if (_allKeywords == null){

      /// 2.1 read firebase KeywordOps
      _allKeywords = await KeywordOps.readKeywordsOps(
        context: context,
      );

      /// 2.2 if found on firebase, store in ldb keywords
      if (Mapper.canLoopList(_allKeywords) == true){
        await LDBOps.insertMaps(
          inputs: KW.cipherKeywordsToMaps(_allKeywords),
          docName: LDBDoc.keywords,
          primaryKey: 'id',
        );
      }

    }

    return _allKeywords;
  }
// -----------------------------------------------------------------------------
  /// ALL KEYWORDS
  List<KW> _allKeywords = <KW>[];
// -------------------------------------
  List<KW> get allKeywords {
    return <KW>[..._allKeywords];
  }
// -------------------------------------
  Future<void> getsetAllKeywords(BuildContext context) async {

    List<KW> _keywords = await fetchAllKeywords(context: context);

    _allKeywords = _keywords;
    notifyListeners();
  }
// -----------------------------------------------------------------------------
  KW getKeywordByID(String id){
    final KW _kw = _allKeywords.firstWhere((kw) => kw.id == id, orElse: () => null);
    return _kw;
  }
// -----------------------------------------------------------------------------
  List<KW> getKeywordsByKeywordsIDs(List<String> ids){

        final List<KW> _keywords = <KW>[];

    if (Mapper.canLoopList(ids)){

      for (String id in ids){

        final KW _Keyword = getKeywordByID(id);

        if (_Keyword != null){
          _keywords.add(_Keyword);
        }
      }

    }

    return _keywords;

  }
// -----------------------------------------------------------------------------
  String getImagePath(dynamic keywordOrKeywordID){
    String _keywordID;

    if (keywordOrKeywordID.runtimeType == String){
      _keywordID = keywordOrKeywordID;
    }
    else if (keywordOrKeywordID.runtimeType == KW){
      _keywordID = keywordOrKeywordID.keywordID;
    }
    else {
      _keywordID = '';
    }

    String _path;

    // final KW _keyword = getKeywordByID(_keywordID);

      _path = 'assets/keywords/$_keywordID.jpg';

    return _path;
  }
// -----------------------------------------------------------------------------

}