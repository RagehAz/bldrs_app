import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/city_chain.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/chain_ops.dart' as ChainOps;
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/e_db/real/ops/city_chain_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
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
  Future<void> fetchSetAllChains({
    @required BuildContext context,
    @required bool notify,
  }) async {

    await _fetchSetKeywordsChain(context: context, notify: false);
    await _fetchSetSpecsChain(context: context, notify: notify);

  }
// -------------------------------------
  Future<void> reFetchAllChains(BuildContext context) async {

    /// delete LDB chains
    await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.keywordsChain);
    await LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.specsChain);

    _keywordsChain = null;
    _specsChain = null;

    /// get set all chains
    await fetchSetAllChains(
      context: context,
      notify: true,
    );

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
  /// TESTED : WORKS PERFECT
  Future<Chain> fetchKeywordsChain(BuildContext context) async {

    Chain _keywordsChain;

    /// 1 - search LDB
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.keywordsChain,
    );

    /// 2 - all keywords chain found in LDB
    if (Mapper.checkCanLoopList(_maps)) {
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
            input: _keywordsChain.toMap(),
            docName: LDBDoc.keywordsChain,
        );

      }

    }

    return _keywordsChain;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<Chain> fetchSpecsChain(BuildContext context) async {

    Chain _specsChain;

    /// 1 - search LDB
    final List<Map<String, Object>> _maps = await LDBOps.readAllMaps(
      docName: LDBDoc.specsChain,
    );

    /// 2 - all keywords chain found in LDB
    if (Mapper.checkCanLoopList(_maps)) {
      _specsChain = Chain.decipherChain(_maps[0]);
    }

    /// 3 - all keywords chain is not found in LDB
    else {
      _specsChain = await ChainOps.readSpecsChain(context);

      /// 3 - insert in LDB when found on firebase
      if (_specsChain != null){

        await LDBOps.insertMap(
          input: _specsChain.toMap(),
          docName: LDBDoc.specsChain,
        );

      }

    }

    return _specsChain;
  }
// -----------------------------------------------------------------------------

  /// CITY CHAIN

// -------------------------------------
  CityChain _currentCityChain;
  CityChain get currentCityChain => _currentCityChain;
// -------------------------------------
  static Future<void> fetchSetCurrentCityChain({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(
        context: context,
        listen: false,
    );

    if (_currentZone != null){

      final CityChain _cityChain = await CityChainOps.readCityChain(
          context: context,
          cityID: _currentZone.cityID,
      );

      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      _chainsProvider._setCurrentCityChain(
        cityChain: _cityChain,
        notify: notify,
      );

    }

  }
// -------------------------------------
  void _setCurrentCityChain({
    @required CityChain cityChain,
    @required bool notify,
  }){

    _currentCityChain = cityChain;
    if (notify == true){
      notifyListeners();
    }

  }
// -----------------------------------------------------------------------------

  /// KEYWORDS CHAIN

// -------------------------------------
  Chain _keywordsChain;
  /// must include trigrams and both languages (en, ar) for search engines
  List<Phrase> _keywordsChainPhrases;
// -------------------------------------
  Chain get keywordsChain => _keywordsChain;
  List<Phrase> get keywordsChainPhrases => _keywordsChainPhrases;
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _fetchSetKeywordsChain({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final Chain _keywordsChain = await fetchKeywordsChain(context);

    await refineAndSetKeywordsChainAndGenerateTheirPhrasesssss(
      context: context,
      keywordsChain: _keywordsChain,
      notify: notify,
    );

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> refineAndSetKeywordsChainAndGenerateTheirPhrasesssss({
    @required BuildContext context,
    @required Chain keywordsChain,
    @required bool notify,
  }) async {

    final Chain _refined = await removeUnusedKeywordsFromChainForThisCity(
      context: context,
      chain: keywordsChain,
    );

    final List<Phrase> _keywordsPhrases = await generateKeywordsPhrasesFromKeywordsChain(
      context: context,
      keywordsChain: _refined,
    );

    _keywordsChain = _refined;
    _keywordsChainPhrases = _keywordsPhrases;
    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
    void clearKeywordsChainAndTheirPhrases({
    @required bool notify,
  }){
    _keywordsChain = null;
    _keywordsChainPhrases = <Phrase>[];
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<List<Phrase>> generateKeywordsPhrasesFromKeywordsChain({
    @required Chain keywordsChain,
    @required BuildContext context,
  }) async {
    /// should include en - ar phrases for all IDs
    List<Phrase> _keywordsPhrases = <Phrase>[];

    if (keywordsChain != null){

      final List<String> _keywordsIDs = Chain.getOnlyStringsSonsIDsFromChain(
        chain: keywordsChain,
      );

      final PhraseProvider _phraseProvider = Provider.of<PhraseProvider>(context, listen: false);
      _keywordsPhrases = await _phraseProvider.generateMixedLangPhrasesFromPhids(
        context: context,
        phids: _keywordsIDs,
      );

    }

    return _keywordsPhrases;
  }
// -------------------------------------
  Future<Chain> removeUnusedKeywordsFromChainForThisCity({
    @required Chain chain,
    @required BuildContext context,
  }) async {

    final List<String> _usedKeywordsIDs = CityChain.getKeywordsIDsFromCityChain(
      cityChain: _currentCityChain,
    );

    final Chain _refined = Chain.removeAllKeywordsNotUsedInThisList(
      chain: chain,
      usedKeywordsIDs: _usedKeywordsIDs,
    );

    return _refined;
  }
// -------------------------------------
  Chain getKeywordsChainByFlyerType(FlyerType flyerType){

    String _chainID = 'phid_sections';

    switch(flyerType){
      case FlyerType.property   : _chainID = 'phid_k_flyer_type_property'; break;
      case FlyerType.design     : _chainID = 'phid_k_flyer_type_design'; break;
      case FlyerType.project    : _chainID = 'phid_k_flyer_type_design'; break;
      case FlyerType.craft      : _chainID = 'phid_k_flyer_type_crafts'; break;
      case FlyerType.product    : _chainID = 'phid_k_flyer_type_product'; break;
      case FlyerType.equipment  : _chainID = 'phid_k_flyer_type_equipment'; break;
      case FlyerType.all        : _chainID = 'phid_sections'; break;
      case FlyerType.non        : _chainID = 'phid_sections'; break;
    }

    final Chain _chain = Chain.getChainFromChainsByID(
        chainID: _chainID,
        chains: <Chain>[_keywordsChain]
    );

    return _chain;
  }
// -----------------------------------------------------------------------------

  /// SPECS CHAIN

// -------------------------------------
  Chain _specsChain;
// -------------------------------------
  Chain get specsChain => _specsChain;
// -------------------------------------
  Future<void> _fetchSetSpecsChain({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final Chain _specsChain = await fetchSpecsChain(context);

    setSpecsChain(
      specsChain: _specsChain,
      notify: notify,
    );

  }
// -------------------------------------
  void setSpecsChain({
    @required Chain specsChain,
    @required bool notify,
  }){
    _specsChain = specsChain;
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  void clearSpecsChain({@required bool notify}){

    setSpecsChain(
        specsChain: null,
        notify: notify
    );

  }
// -----------------------------------------------------------------------------

  /// KEYWORDS ICONS

// -------------------------------------
  String getKeywordIcon({
    @required BuildContext context,
    @required dynamic son,
  }) {

    String _phid;

    /// WHEN SON IS KEYWORD ID
    if (son.runtimeType == String) {
      _phid  = son;
    }
    /// WHEN SON IS A CHAIN
    else if (son.runtimeType == Chain) {
      final Chain _chain = son;
      _phid = _chain.id;
    }

    return getLocalAssetPath(
        context: context,
        assetName: _phid,
    );

  }
// -----------------------------------------------------------------------------

  /// SELECTED HOME WALL FLYER TYPE

// -------------------------------------
  FlyerType _homeWallFlyerType;
// -------------------------------------
  FlyerType get homeWallFlyerType {
    return _homeWallFlyerType ?? FlyerType.design;
  }
  // -------------------------------------
  Future<void> changeHomeWallFlyerType({
    @required BuildContext context,
    @required FlyerType flyerType,
    @required String phid,
    @required bool notify,
  }) async {
    blog('Changing section to $flyerType');

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

    await _flyersProvider.paginateWallFlyers(
      // context: context,
      // section: section,
      // kw: kw,
        context
    );

    _homeWallFlyerType = flyerType;
    _wallPhid = phid;
    // setSectionGroups();

    if (notify == true){
      notifyListeners();
    }
  }
  // -------------------------------------
  void _setHomeWallFlyerType({
    @required FlyerType flyerType,
    @required bool notify,
  }){
    _homeWallFlyerType = flyerType;
    if (notify == true){
      notifyListeners();
    }
  }
  // -------------------------------------
  void clearHomeWallFlyerType({
    @required bool notify,
  }){
    _setHomeWallFlyerType(
      flyerType: null,
      notify: notify,
    );
  }
  // -------------------------------------
  static FlyerType proGetHomeWallFlyerType(BuildContext context){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    return _chainsProvider.homeWallFlyerType;
  }
// -----------------------------------------------------------------------------

  /// SELECTED HOME WALL PHRASE ID (PHID)

// -------------------------------------
  String _wallPhid;
// -------------------------------------
  String get wallPhid {
    return _wallPhid;
  }
// -----------------------------------------------------------------------------
  void _setWallPhid({
    @required String keywordID,
    @required bool notify,
  }){
    _wallPhid = keywordID;
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  void clearWallPhid({
  @required bool notify,
}){
    _setWallPhid(
      keywordID: null,
      notify: notify,
    );
  }
// -------------------------------------
  static String proGetHomeWallPhid(BuildContext context){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    return _chainsProvider.wallPhid;
  }
// -----------------------------------------------------------------------------

  /// WIPE OUT

// -------------------------------------
  static void wipeOut({
    @required BuildContext context,
    @required bool notify,
  }){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    /// _keywordsChain - _keywordsChainPhrases
    _chainsProvider.clearKeywordsChainAndTheirPhrases(notify: false);

    /// _specsChain
    _chainsProvider.clearSpecsChain(notify: false);

    /// _homeWallFlyerType
    _chainsProvider.clearHomeWallFlyerType(notify: false);

    /// _wallPhid
    _chainsProvider.clearWallPhid(notify: true);

  }
// -----------------------------------------------------------------------------
}

Chain superGetChain(BuildContext context, String chainID){
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
  final Chain _chain = _chainsProvider.searchAllChainsByID(chainID);

  blog('superGetChain : chain is :-');
  _chain?.blogChain();

  return _chain;
}

List<Chain> getAllChains(BuildContext context){
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
  final Chain _keywordsChain = _chainsProvider.keywordsChain;
  final Chain _specsChain = _chainsProvider.specsChain;
  return <Chain>[_keywordsChain, _specsChain];
}

String superIcon(BuildContext context, dynamic icon){
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

  return _chainsProvider.getKeywordIcon(
    context: context,
    son: icon,
  );
// -----------------------------------------------------------------------------
}
