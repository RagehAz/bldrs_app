import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/city_chain.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/a_chain_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/a_phrase_protocols.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
import 'package:bldrs/e_db/real/ops/city_chain_ops.dart';
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

    await Future.wait(<Future>[

      fetchSetRefinedKeywordsChain(
        context: context,
        notify: notify,
      ),

      _fetchSetSpecsChain(
        context: context,
        notify: notify,
      ),

    ]);

  }
// -------------------------------------
  Future<void> reFetchSetAllChains(BuildContext context) async {

    /// DELETE LDB CHAINS
    await Future.wait(<Future>[
      LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.keywordsChain),
      LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.specsChain),
    ]);

    _allKeywordsChain = null;
    _cityKeywordsChain = null;
    _specsChain = null;

    /// get set all chains
    await fetchSetAllChains(
      context: context,
      notify: true,
    );

  }
// -----------------------------------------------------------------------------

  /// CITY CHAIN

// -------------------------------------
  CityChain _currentCityChain;
  CityChain get currentCityChain => _currentCityChain;
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> fetchSetCurrentCityChain({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final ZoneModel _currentZone = ZoneProvider.proGetCurrentZone(
      context: context,
      listen: false,
    );

    _currentZone.blogZone(methodName: 'fetchSetCurrentCityChain');

    if (_currentZone != null){

      final CityChain _cityChain = await CityChainOps.readCityChain(
        context: context,
        cityID: _currentZone.cityID,
      );

      _cityChain?.blogCityChain(methodName: 'fetchSetCurrentCityChain');

      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      _chainsProvider._setCurrentCityChain(
        cityChain: _cityChain,
        notify: notify,
      );

    }

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
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
  Chain _cityKeywordsChain;
  Chain get cityKeywordsChain => _cityKeywordsChain;
  /// must include trigrams and both languages (en, ar) for search engines
  List<Phrase> _cityKeywordsChainPhrases;
  List<Phrase> get cityKeywordsChainPhrases => _cityKeywordsChainPhrases;

  Chain _allKeywordsChain;
  Chain get allKeywordsChain => _allKeywordsChain;

  List<Phrase> _allKeywordsChainPhrases;
  List<Phrase> get allKeywordsChainPhrases => _allKeywordsChainPhrases;
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Chain proGetKeywordsChain({
    @required BuildContext context,
    @required bool onlyUseCityChains,
    @required bool listen,
  }){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: listen);

    if (onlyUseCityChains == true){
      return _chainsProvider.cityKeywordsChain;
    }
    else {
      return _chainsProvider.allKeywordsChain;
    }

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> fetchSetRefinedKeywordsChain({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final Chain _keywordsChain = await ChainProtocols.fetchKeywordsChain(context);

    if (_keywordsChain != null){
      await refineAndSetKeywordsChainAndGenerateTheirPhrases(
        context: context,
        keywordsChain: _keywordsChain,
        notify: notify,
      );
    }

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> refineAndSetKeywordsChainAndGenerateTheirPhrases({
    @required BuildContext context,
    @required Chain keywordsChain,
    @required bool notify,
  }) async {

    final Chain _refined = CityChain.removeUnusedKeywordsFromChainForThisCity(
      chain: keywordsChain,
      currentCityChain: _currentCityChain,
    );

    final List<Phrase> _cityKeywordsPhrases = await PhraseProtocols.generatePhrasesFromChain(
      context: context,
      chain: _refined,
    );
    final List<Phrase> _allKeywordsPhrases = await PhraseProtocols.generatePhrasesFromChain(
      context: context,
      chain: keywordsChain,
    );

    _cityKeywordsChain = _refined;
    _cityKeywordsChainPhrases = _cityKeywordsPhrases;
    _allKeywordsChain = keywordsChain;
    _allKeywordsChainPhrases = _allKeywordsPhrases;

    if (notify == true){
      notifyListeners();
    }

  }
// -------------------------------------
  void clearKeywordsChainAndTheirPhrases({
    @required bool notify,
  }){
    _cityKeywordsChain = null;
    _allKeywordsChain = null;
    _cityKeywordsChainPhrases = <Phrase>[];
    _allKeywordsChainPhrases = <Phrase>[];

    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Chain getChainKByFlyerType({
    @required FlyerType flyerType,
    @required bool onlyUseCityChains,
  }){

    final String _chainID = FlyerTyper.concludeChainIDByFlyerType(
      flyerType: flyerType,
    );

    final Chain _chain = findChainK(
      chainID: _chainID,
      onlyUseCityChains: onlyUseCityChains,
    );

    return _chain;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Chain findChainK({
    @required String chainID,
    @required bool onlyUseCityChains,
  }){

    final Chain _chain = Chain.getChainFromChainsByID(
      chainID: chainID,
      chains: onlyUseCityChains == true ?
      <Chain>[_cityKeywordsChain]
          :
      <Chain>[_allKeywordsChain],
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

    final Chain _specsChain = await ChainProtocols.fetchSpecsChain(context);

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

    await _flyersProvider.paginateWallFlyers(context);

    _homeWallFlyerType = flyerType;
    _wallPhid = phid;

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
  /// TESTED : WORKS PERFECT
  static Chain superGetChain({
    @required BuildContext context,
    @required String chainID,
    @required bool onlyUseCityChains,
  }){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    final Chain _keywordsChain = onlyUseCityChains == true ?
    _chainsProvider.cityKeywordsChain
        :
    _chainsProvider.allKeywordsChain;

    final List<Chain> _allChains = <Chain>[_keywordsChain, _chainsProvider.specsChain];

    final Chain _chain = Chain.getChainFromChainsByID(
      chainID: chainID,
      chains: _allChains,
    );

    return _chain;
  }
// -----------------------------------------------------------------------------
}

List<Chain> getAllChains({
  @required BuildContext context,
  @required bool getOnlyCityKeywordsChain,
}){
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
  final Chain _keywordsChain = ChainsProvider.proGetKeywordsChain(
    context: context,
    onlyUseCityChains: getOnlyCityKeywordsChain,
    listen: false,
  );
  final Chain _specsChain = _chainsProvider.specsChain;
  return <Chain>[_keywordsChain, _specsChain];
}


// -----------------------------------------------------------------------------
