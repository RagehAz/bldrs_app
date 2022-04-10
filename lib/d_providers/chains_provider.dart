import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/e_db/fire/ops/chain_ops.dart' as ChainOps;
import 'package:bldrs/e_db/ldb/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
class ChainsProvider extends ChangeNotifier {
// -----------------------------------------------------------------------------

  /// INITIALIZATION

// -------------------------------------
  /// All chains are [ Keywords chain - specs chain ]
  Future<void> getSetAllChains(BuildContext context) async {

    await _getsetKeywordsChain(context: context, notify: true);
    await _getsetSpecsChain(context: context, notify: true);

  }
// -------------------------------------
  Future<void> reloadAllChains(BuildContext context) async {

    /// delete LDB chains
    await LDBOps.deleteAllAtOnce(docName: LDBDoc.keywordsChain);
    await LDBOps.deleteAllAtOnce(docName: LDBDoc.specsChain);

    /// get set all chains
    await getSetAllChains(context);
  }
// -----------------------------------------------------------------------------

  /// SEARCHERS

// -------------------------------------
  Chain searchAllChainsByID(String chainID){

    final List<Chain> _allChains = <Chain>[_keywordsChain, _specsChain];

    final Chain _chain = Chain.getChainFromChainsByID(
      chainID: chainID,
      chains: _allChains,
    );

    return _chain;
  }
// -----------------------------------------------------------------------------

  /// FETCHING CHAINS

// -------------------------------------
  Future<Chain> fetchKeywordsChain(BuildContext context) async {

    Chain _keywordsChain;

    /// 1 - search LDB
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.keywordsChain,
    );

    /// 2 - all keywords chain found in LDB
    if (Mapper.canLoopList(_maps)) {
      // blog('keywords chain found in LDB');
      _keywordsChain = Chain.decipherChain(_maps[0]);
    }

    /// 3 - all keywords chain is not found in LDB
    else {
      // blog('keywords chain is NOT found in LDB');
      _keywordsChain = await ChainOps.readKeywordsChain(context);

      /// 3 - insert in LDB when found on firebase
      if (_keywordsChain != null){
        // blog('keywords chain is found in FIREBASE and inserted');
        await LDBOps.insertMap(
            primaryKey: 'id',
            input: _keywordsChain.toMap(),
            docName: LDBDoc.keywordsChain,
        );

      }

    }

    return _keywordsChain;
  }
// -------------------------------------
  Future<Chain> fetchSpecsChain(BuildContext context) async {

    Chain _specsChain;

    /// 1 - search LDB
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.specsChain,
    );

    /// 2 - all keywords chain found in LDB
    if (Mapper.canLoopList(_maps)) {
      _specsChain = Chain.decipherChain(_maps[0]);
    }

    /// 3 - all keywords chain is not found in LDB
    else {
      _specsChain = await ChainOps.readSpecsChain(context);

      /// 3 - insert in LDB when found on firebase
      if (_specsChain != null){

        await LDBOps.insertMap(
          primaryKey: 'id',
          input: _specsChain.toMap(),
          docName: LDBDoc.specsChain,
        );

      }

    }

    return _specsChain;
  }
// -----------------------------------------------------------------------------

  /// KEYWORDS CHAIN

// -------------------------------------
  Chain _keywordsChain;
// -------------------------------------
  Chain get keywordsChain => _keywordsChain;
// -------------------------------------
  Future<void> _getsetKeywordsChain({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final Chain _keywordsChain = await fetchKeywordsChain(context);

    _setKeywordsChain(
      keywordsChain: _keywordsChain,
      notify: notify,
    );
  }
// -------------------------------------
  void _setKeywordsChain({
    @required Chain keywordsChain,
    @required bool notify,
  }){
    _keywordsChain = keywordsChain;
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// SPECS CHAIN

// -------------------------------------
  Chain _specsChain;
// -------------------------------------
  Chain get specsChain => _specsChain;
// -------------------------------------
  Future<void> _getsetSpecsChain({
    @required BuildContext context,
    @required bool notify,
  }) async {
    final Chain _specsChain = await fetchSpecsChain(context);
    _setSpecsChain(
      specsChain: _specsChain,
      notify: notify,
    );
  }
// -------------------------------------
  void _setSpecsChain({
    @required Chain specsChain,
    @required bool notify,
  }){
    _specsChain = specsChain;
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// KEYWORDS ICONS

// -------------------------------------
  String getKeywordIcon({
    @required BuildContext context,
    @required dynamic son,
  }) {
    String _icon;

    tryAndCatch(
        context: context,
        methodName: 'get icon',
        functions: () {

          /// WHEN SON IS KEYWORD ID
          if (son.runtimeType == String) {
            _icon = 'assets/keywords/$son.jpg';
          }

          /// WHEN SON IS A CHAIN
          else if (son.runtimeType == Chain) {

            final Chain _chain = son;

            if (_chain.icon == null) {
              // _icon = null;
            }

            else if (_chain.icon == 'id') {
              _icon = 'assets/keywords/${_chain.id}.jpg';
            }

            else {
              _icon = _chain.icon;
            }

          }

          // /// HOWEVER
          // else {
          //   // _keywordID = null;
          // }

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

Chain superGetChain(BuildContext context, String chainID){
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
  final Chain _chain = _chainsProvider.searchAllChainsByID(chainID);
  return _chain;
}

List<Chain> getAllChains(BuildContext context){
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
  final Chain _keywordsChain = _chainsProvider.keywordsChain;
  final Chain _specsChain = _chainsProvider.specsChain;
  return <Chain>[_keywordsChain, _specsChain];
}