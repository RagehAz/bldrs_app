import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/kw/chain/chain.dart';
import 'package:bldrs/a_models/kw/kw.dart';
import 'package:bldrs/a_models/secondary_models/app_updates.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/general_provider.dart';
import 'package:bldrs/e_db/fire/ops/keyword_ops.dart' as FireKeywordOps;
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/xxx_dashboard/exotic_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);
class KeywordsProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------
  Future<List<KW>> _readAllKeywordsThenWipeLDBThenInsertAll(BuildContext context) async {
    /// 1 - read firebase KeywordOps
    final List<KW> _allKeywords = await FireKeywordOps.readKeywordsOps(
      context: context,
    );

    /// 2 - if found on firebase, store in ldb keywords
    if (Mapper.canLoopList(_allKeywords) == true) {
      /// TASK : temp until release
      await ExoticMethods.updateNumberOfKeywords(context, _allKeywords);

      /// 2.1 - assure that LDB is clean first
      await LDBOps.deleteAllMapsOneByOne(docName: LDBDoc.keywords);

      /// 2.2 insert all keywords to LDB
      await LDBOps.insertMaps(
        inputs: KW.cipherKeywordsToLDBMaps(_allKeywords),
        docName: LDBDoc.keywords,
        primaryKey: 'id',
      );
    }

    return _allKeywords;
  }
// -----------------------------------------------------------------------------

  /// FETCHING KEYWORDS

// -------------------------------------
  Future<List<KW>> fetchAllKeywords({@required BuildContext context}) async {
    final GeneralProvider _generalProvider =
        Provider.of<GeneralProvider>(context, listen: false);
    final AppState _appState = _generalProvider.appState;

    List<KW> _allKeywords;

    /// 1 - search LDB
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.keywords,
    );

    if (Mapper.canLoopList(_maps)) {
      _allKeywords = KW.decipherKeywordsLDBMaps(maps: _maps);
    }

    /// 2 - all keywords found in LDB
    if (Mapper.canLoopList(_allKeywords)) {
      /// 2.A app state required readOps
      if (_appState.keywordsUpdateRequired == true ||
          _appState.numberOfKeywords != _allKeywords.length) {
        /// 2.A.1 read firebase KeywordOps
        _allKeywords = await _readAllKeywordsThenWipeLDBThenInsertAll(context);
      }
    }

    /// 3 - all keywords are not found in LDB
    else {
      /// 3.1 read firebase KeywordOps
      _allKeywords = await _readAllKeywordsThenWipeLDBThenInsertAll(context);
    }

    return _allKeywords;
  }
// -----------------------------------------------------------------------------

  /// ALL KEYWORDS

// -------------------------------------
  List<KW> _allKeywords = <KW>[];
// -------------------------------------
  List<KW> get allKeywords {
    return <KW>[..._allKeywords];
  }
// -------------------------------------
  Future<void> getsetAllKeywords(BuildContext context) async {
    final List<KW> _keywords = await fetchAllKeywords(context: context);

    _setAllKeywords(_keywords);
  }
// -------------------------------------
  void _setAllKeywords(List<KW> kws){
    _allKeywords = kws;
    notifyListeners();
  }
// -------------------------------------
  void clearAllKeywords() {
    _setAllKeywords(<KW>[]);
  }
// -----------------------------------------------------------------------------
  String getKeywordIcon({@required BuildContext context, @required dynamic son}) {
    String _icon;

    tryAndCatch(
        context: context,
        methodName: 'get icon',
        functions: () {
          /// WHEN SON IS KEYWORD ID "never happens"
          if (son.runtimeType == String) {
            _icon = 'assets/keywords/$son.jpg';
            blog('HEY : Im  a son, and im a keyword ID $son');
          }

          /// WHEN SON IS A KEYWORD
          else if (son.runtimeType == KW) {
            final KW _keyword = son;
            _icon = 'assets/keywords/${_keyword.id}.jpg';
          }

          /// WHEN SON IS A CHAIN
          else if (son.runtimeType == Chain) {
            final Chain _chain = son;

            if (_chain.icon == null) {
              // _icon = null;
            } else if (_chain.icon == 'id') {
              _icon = 'assets/keywords/${_chain.id}.jpg';
            } else {
              _icon = _chain.icon;
            }
          }

          /// HOWEVER
          else {
            // _keywordID = null;
          }
        });

    return _icon;
  }
// -----------------------------------------------------------------------------

  /// SELECTED SECTION

// -------------------------------------
  FlyerType _currentSection;
// -------------------------------------
  FlyerType get currentSection {
    return _currentSection ?? FlyerType.design;
  }
  // -------------------------------------
  Future<void> changeSection({
    @required BuildContext context,
    @required FlyerType section,
    @required String keywordID,
  }) async {
    blog('Changing section to $section');

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

    await _flyersProvider.paginateWallFlyers(
      // context: context,
      // section: section,
      // kw: kw,
        context
    );

    _currentSection = section;
    _currentKeywordID = keywordID;
    // setSectionGroups();

    notifyListeners();
  }
  // -------------------------------------
  void _setCurrentSection(FlyerType section){
    _currentSection = section;
    notifyListeners();
  }
  // -------------------------------------
  void clearCurrentSection(){
    _setCurrentSection(null);
  }
// -----------------------------------------------------------------------------

  /// CURRENT KEYWORD

// -------------------------------------
  String _currentKeywordID;
// -------------------------------------
  String get currentKeywordID {
    return _currentKeywordID;
  }
// -----------------------------------------------------------------------------
  void _setCurrentKeyword(String keywordID){
    _currentKeywordID = keywordID;
    notifyListeners();
  }
// -------------------------------------
  void clearCurrentKeyword(){
    _setCurrentKeyword(null);
  }
// -----------------------------------------------------------------------------
}
