import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/b_city_phids_model.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/secondary_models/phrase_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/a_chain_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/phrase_protocols.dart';
import 'package:bldrs/c_protocols/spec_picker_protocols/picker_protocols.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_doc.dart';
import 'package:bldrs/e_db/ldb/foundation/ldb_ops.dart';
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
  /// TESTED : WORKS PERFECT
  Future<void> initializeAllChains({
    @required BuildContext context,
    @required bool notify,
  }) async {
    // --------------------
    /// NOTE : initialization for fetching setting :-
    /// BIG CHAIN K
    /// BIG CHAIN S
    /// ALL PICKERS
    /// CITY PHIDS MODEL
    /// CITY CHAIN K
    /// BIG CHAIN K PHRASES
    /// BIG CHAIN S PHRASES
    /// CITY CHAIN K PHRASES
    // --------------------
    /// 1. START WITH : BIG CHAIN K - BIG CHAIN S - CITY PHID COUNTERS
    await Future.wait(<Future>[
      /// BIG CHAIN K
      _fetchSetBigChainK(
          context: context,
          notify: false,
      ),
      /// BIG CHAIN S
      _fetchSetBigChainS(
          context: context,
          notify: false,
      ),
      /// ALL PICKERS
      fetchSetAllPickers(
          context: context,
          notify: false,
      ),
      /// CITY PHID COUNTERS
      _readSetCityPhidsModel(
        context: context,
        notify: false,
      ),
    ]);
    // --------------------
    /// 2. BIG CHAINS ARE LOADED => NOW DO CITY CHAINS & PHRASES
    await Future.wait(<Future>[
      /// CITY CHAIN K
      _refineSetCityChainK(
          bigChainK: _bigChainK,
          notify: false,
      ),
      /// BIG CHAIN K PHRASES
      _generateSetBigChainKPhrases(
          context: context,
          bigChainK: _bigChainK,
          notify: false,
      ),
      /// BIG CHAIN S PHRASES
      _generateSetBigChainSPhrases(
          context: context,
          bigChainS: _bigChainS,
          notify: false,
      ),
    ]);
    // --------------------
    /// 3. CITY CHAIN K PHRASES
    await _generateSetCityChainKPhrases(
      context: context,
      cityChainK: _cityChainK,
      notify: false,
    );
    // --------------------
    /// NOTIFY LISTENERS
    if (notify == true){
      notifyListeners();
    }
    // --------------------
  }
// -------------------------------------
  Future<void> reInitializeAllChains(BuildContext context) async {
    // --------------------
    /// DELETE LDB CHAINS
    await Future.wait(<Future>[
      LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.bigChainK),
      LDBOps.deleteAllMapsAtOnce(docName: LDBDoc.bigChainS),
    ]);
    // --------------------
    /// BIG CHAIN K
    _bigChainK = null;
    /// BIG CHAIN S
    _bigChainS = null;
    /// ALL PICKERS
    _allPickers = {};
    /// CITY PHID COUNTERS
    _cityPhidsModel = null;
    /// CITY CHAIN K
    _cityChainK = null;
    /// BIG CHAIN K PHRASES
    _bigChainKPhrases = <Phrase>[];
    /// BIG CHAIN S PHRASES
    _bigChainSPhrases = <Phrase>[];
    /// CITY CHAIN K PHRASES
    _cityChainKPhrases = <Phrase>[];
    // --------------------
    /// INITIALIZE
    await initializeAllChains(
      context: context,
      notify: true,
    );
    // --------------------
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> reInitializeCityChains(BuildContext context) async {
    // --------------------
    /// KEEP : BIG CHAIN K
    /// KEEP : BIG CHAIN S
    /// KEEP : ALL PICKERS
    /// KEEP : BIG CHAIN K PHRASES
    /// KEEP : BIG CHAIN S PHRASES
    // --------------------
    /// GET : CITY PHID COUNTERS
    /// GET : CITY CHAIN K
    /// GET CITY CHAIN K PHRASES
    // --------------------
    /// 1. CITY PHIDS MODEL
    await _readSetCityPhidsModel(
      context: context,
      notify: false,
    );
    // --------------------
    /// 2. CITY CHAIN K
    await _refineSetCityChainK(
      bigChainK: _bigChainK,
      notify: false,
    );
    // --------------------
    /// 3. CITY CHAIN K PHRASES
    await _generateSetCityChainKPhrases(
      context: context,
      cityChainK: _cityChainK,
      notify: true,
    );
    // --------------------
  }
// -----------------------------------------------------------------------------

  /// UPDATES

// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> updateBigChainKOps({
    @required BuildContext context,
    @required Chain bigChainK,
    @required bool notify,
  }) async {
    // --------------------
    /// UPDATE : BIG CHAIN K
    /// KEEP : BIG CHAIN S
    /// KEEP : CITY PHID COUNTERS
    /// UPDATE : CITY CHAIN K
    /// UPDATE : BIG CHAIN K PHRASES
    /// KEEP : BIG CHAIN S PHRASES
    /// UPDATE : CITY CHAIN K PHRASES
    // --------------------
    /// 1. BIG CHAIN K
    _setBigChainK(
      chain: bigChainK,
      notify: false,
    );
    // --------------------
    /// 2. BIG CHAINS ARE LOADED => NOW DO CITY CHAINS & PHRASES
    await Future.wait(<Future>[
      /// CITY CHAIN K
      _refineSetCityChainK(
        bigChainK: bigChainK,
        notify: false,
      ),
      /// BIG CHAIN K PHRASES
      _generateSetBigChainKPhrases(
        context: context,
        bigChainK: bigChainK,
        notify: false,
      ),
    ]);
    // --------------------
    /// 3. CITY CHAIN K PHRASES
    await _generateSetCityChainKPhrases(
      context: context,
      cityChainK: bigChainK,
      notify: false,
    );
    // --------------------
    /// NOTIFY LISTENERS
    if (notify == true){
      notifyListeners();
    }
    // --------------------
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> updateBigChainSOps({
    @required BuildContext context,
    @required Chain bigChainS,
    @required bool notify,
  }) async {
    // --------------------
    /// KEEP : BIG CHAIN K
    /// UPDATE : BIG CHAIN S
    /// KEEP : CITY PHID COUNTERS
    /// KEEP : CITY CHAIN K
    /// KEEP : BIG CHAIN K PHRASES
    /// UPDATE : BIG CHAIN S PHRASES
    /// KEEP : CITY CHAIN K PHRASES
    // --------------------
    /// 1. BIG CHAIN S
    _setBigChainS(
      bigChainS: bigChainS,
      notify: false,
    );
    // --------------------
      /// BIG CHAIN S PHRASES
    await _generateSetBigChainSPhrases(
      context: context,
      bigChainS: bigChainS,
      notify: false,
    );
    // --------------------
    /// NOTIFY LISTENERS
    if (notify == true){
      notifyListeners();
    }
    // --------------------
  }
// -----------------------------------------------------------------------------

  /// WIPE OUT

// -------------------------------------
  /// TESTED : WORKS PERFECT
  void wipeOutChainsPro({
    @required BuildContext context,
    @required bool notify,
  }){

    /// BIG CHAIN K
    _bigChainK = null;
    /// BIG CHAIN S
    _bigChainS = null;
    /// ALL PICKERS
    _allPickers = {};
    /// CITY PHID COUNTERS
    _cityPhidsModel = null;
    /// CITY CHAIN K
    _cityChainK = null;
    /// BIG CHAIN K PHRASES
    _bigChainKPhrases = <Phrase>[];
    /// BIG CHAIN S PHRASES
    _bigChainSPhrases = <Phrase>[];
    /// CITY CHAIN K PHRASES
    _cityChainKPhrases = <Phrase>[];

    /// WALL FLYER TYPE AND PHID
    clearWallFlyerTypeAndPhid(
        notify: notify
    );

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static void wipeOut({
    @required BuildContext context,
    @required bool notify,
}){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    _chainsProvider.wipeOutChainsPro(
      context: context,
      notify: notify,
    );
  }
// -----------------------------------------------------------------------------

  /// BIG CHAIN-K (main keywords chain)

// -------------------------------------
  Chain _bigChainK;
  Chain get bigChainK => _bigChainK;
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Chain proGetBigChainK({
    @required BuildContext context,
    @required bool onlyUseCityChains,
    @required bool listen,
  }){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: listen);

    if (onlyUseCityChains == true){
      return _chainsProvider.cityChainK;
    }
    else {
      return _chainsProvider.bigChainK;
    }

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _fetchSetBigChainK({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final Chain _bigChainK = await ChainProtocols.fetchBigChainK(context);

    _setBigChainK(
      chain: _bigChainK,
      notify: notify,
    );

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  void _setBigChainK({
    @required Chain chain,
    @required bool notify,
  }){
    _bigChainK = chain;
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// BIG CHAIN S - (main specs chain)

// -------------------------------------
  Chain _bigChainS;
// -------------------------------------
  Chain get bigChainS => _bigChainS;
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Chain proGetBigChainS({
    @required BuildContext context,
    @required bool listen,
  }){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: listen);
    return _chainsProvider.bigChainS;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _fetchSetBigChainS({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final Chain _bigChainS = await ChainProtocols.fetchBigChainS(context);

    _setBigChainS(
      bigChainS: _bigChainS,
      notify: notify,
    );

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  void _setBigChainS({
    @required Chain bigChainS,
    @required bool notify,
  }){
    _bigChainS = bigChainS;
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// CITY PHID COUNTERS

// -------------------------------------
  CityPhidsModel _cityPhidsModel;
  CityPhidsModel get cityPhidsModel => _cityPhidsModel;
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _readSetCityPhidsModel({
    @required BuildContext context,
    @required bool notify,
  }) async {

    final CityPhidsModel _cityPhidsModel = await ChainProtocols.readCityPhidsOfCurrentZone(
      context: context,
    );

    _setCityPhidModels(
      cityPhidsModel: _cityPhidsModel,
      notify: notify,
    );

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  void _setCityPhidModels({
    @required CityPhidsModel cityPhidsModel,
    @required bool notify,
  }){

    _cityPhidsModel = cityPhidsModel;
    if (notify == true){
      notifyListeners();
    }

  }

// -----------------------------------------------------------------------------

  /// CITY CHAIN K ( city's keywords chain according to City Phid Counters )

// -------------------------------------
  Chain _cityChainK;
  Chain get cityChainK => _cityChainK;
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _refineSetCityChainK({
    @required bool notify,
    @required Chain bigChainK,
  }) async {

    final Chain _cityChainK = CityPhidsModel.removeUnusedPhidsFromChainKForThisCity(
      bigChainK: bigChainK,
      currentCityPhidsModel: _cityPhidsModel,
    );

    _setCityChainK(
      notify: notify,
      chain: _cityChainK,
    );

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  void _setCityChainK({
    @required bool notify,
    @required Chain chain,
  }){
    _cityChainK = chain;
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// BIG CHAIN K PHRASES

// -------------------------------------
  List<Phrase> _bigChainKPhrases = <Phrase>[];
  List<Phrase> get bigChainKPhrases => _bigChainKPhrases;
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _generateSetBigChainKPhrases({
    @required BuildContext context,
    @required Chain bigChainK,
    @required bool notify,
  }) async {

    final List<Phrase> _phrases = await PhraseProtocols.generatePhrasesFromChain(
      context: context,
      chain: bigChainK,
    );

    _setBigChainKPhrases(
      phrases: _phrases,
      notify: notify,
    );

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  void _setBigChainKPhrases({
    @required List<Phrase> phrases,
    @required bool notify,
  }){
    _bigChainKPhrases = phrases;
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// BIG CHAIN S PHRASES

// -------------------------------------
  List<Phrase> _bigChainSPhrases = <Phrase>[];
  List<Phrase> get bigChainSPhrases => _bigChainSPhrases;
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _generateSetBigChainSPhrases({
    @required BuildContext context,
    @required Chain bigChainS,
    @required bool notify,
  }) async {

    final List<Phrase> _phrases = await PhraseProtocols.generatePhrasesFromChain(
      context: context,
      chain: bigChainS,
    );

    _setBigChainSPhrases(
      phrases: _phrases,
      notify: notify,
    );

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  void _setBigChainSPhrases({
    @required List<Phrase> phrases,
    @required bool notify,
  }){
    _bigChainSPhrases = phrases;
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// City Chain K Phrases

// -------------------------------------
  /// must include trigrams and both languages (en, ar) for search engines
  List<Phrase> _cityChainKPhrases = <Phrase>[];
  List<Phrase> get cityChainKPhrases => _cityChainKPhrases;
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> _generateSetCityChainKPhrases({
    @required BuildContext context,
    @required Chain cityChainK,
    @required bool notify,
  }) async {

    final List<Phrase> _phrases = await PhraseProtocols.generatePhrasesFromChain(
      context: context,
      chain: cityChainK,
    );

    _setCityChainKPhrases(
      phrases: _phrases,
      notify: notify,
    );

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  void _setCityChainKPhrases({
    @required List<Phrase> phrases,
    @required bool notify,
  }){
    _cityChainKPhrases = phrases;
    if (notify == true){
      notifyListeners();
    }
  }
// -----------------------------------------------------------------------------

  /// HOME WALL FLYER TYPE AND PHID

// -------------------------------------
  FlyerType _wallFlyerType;
  String _wallPhid;
// -------------------------------------
  FlyerType get wallFlyerType => _wallFlyerType ?? FlyerType.design;
  String get wallPhid => _wallPhid;
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static FlyerType proGetHomeWallFlyerType(BuildContext context){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    return _chainsProvider.wallFlyerType;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String proGetHomeWallPhid(BuildContext context){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    return _chainsProvider.wallPhid;
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

    _setWallFlyerAndPhid(
      flyerType: flyerType,
      phid: phid,
      notify: notify,
    );

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  void _setWallFlyerAndPhid({
    @required FlyerType flyerType,
    @required String phid,
    @required bool notify,
  }){
    _wallFlyerType = flyerType;
    _wallPhid = phid;
    if (notify == true){
      notifyListeners();
    }
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  void clearWallFlyerTypeAndPhid({
    @required bool notify,
  }){
    _setWallFlyerAndPhid(
      phid: null,
      flyerType: null,
      notify: notify,
    );
  }
// -----------------------------------------------------------------------------

  /// ALL PICKER

// -------------------------------------
  Map<String, dynamic> _allPickers = {};
  Map<String, dynamic> get allPickers => _allPickers;
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> proGetPickersByFlyerType({
    @required BuildContext context,
    @required FlyerType flyerType,
    @required bool listen,
  }){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: listen);
    final String _pickersKey = PickerModel.getPickersIDByFlyerType(flyerType);
    return  _chainsProvider.allPickers[_pickersKey];
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> proGetPickersByFlyerTypes({
    @required BuildContext context,
    @required List<FlyerType> flyerTypes,
    @required bool listen,
  }){
    final List<PickerModel> _output = <PickerModel>[];

    if (Mapper.checkCanLoopList(flyerTypes) == true){

      for (final FlyerType type in flyerTypes){

        final List<PickerModel> _pickers = ChainsProvider.proGetPickersByFlyerType(
          context: context,
          flyerType: type,
          listen: listen,
        );

        _output.addAll(_pickers);

      }

    }

    return _output;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  Future<void> fetchSetAllPickers({
    @required BuildContext context,
    @required bool notify,
  }) async {

    await Future.wait(<Future>[

      ...List.generate(FlyerTyper.flyerTypesList.length, (index) async {

        final FlyerType _flyerType = FlyerTyper.flyerTypesList[index];

        await PickerProtocols.fetchFlyerTypPickers(
          context: context,
          flyerType: _flyerType,
          onFinish: (List<PickerModel> pickers){

            blog('fetchSetAllPickers : DONE WITH $_flyerType');

            final bool _isLastIndex = index + 1 == FlyerTyper.flyerTypesList.length;
            bool _notify = false;
            if (_isLastIndex == true){
              _notify = notify;
            }

            setFlyerTypePickers(
              context: context,
              flyerType: _flyerType,
              pickers: pickers,
              notify: _notify,
            );

          },
        );


      }),

    ]);

  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  void setFlyerTypePickers({
    @required BuildContext context,
    @required FlyerType flyerType,
    @required List<PickerModel> pickers,
    @required bool notify,
  }){

    final String _pickersID = PickerModel.getPickersIDByFlyerType(flyerType);

    blog('setFlyerTypePickers : $_pickersID : $flyerType');

    _allPickers = Mapper.insertPairInMap(
      map: _allPickers,
      key: _pickersID,
      value: pickers,
      overrideExisting: true,
    );

    if (notify == true){
      notifyListeners();
    }

  }
// -----------------------------------------------------------------------------o


  /// ~~~~~~~ FINDERS ~~~~~~~


// -----------------------------------------------------------------------------o
  /// TESTED : WORKS PERFECT
  Chain findChainByID({
    @required String chainID,
    bool onlyUseCityChains = false,
    bool includeChainSInSearch = true,
  }){
    // ---------------------------
    final Chain _keywordsChain = onlyUseCityChains == true ?
    _cityChainK
        :
    _bigChainK;
    // ---------------------------
    List<Chain> _allChains;
    if (includeChainSInSearch == true){
      _allChains = <Chain>[_keywordsChain, _bigChainS];
    }
    else {
      _allChains = <Chain>[_keywordsChain];
    }
    // ---------------------------
    final Chain _chain = Chain.getChainFromChainsByID(
      chainID: chainID,
      chains: _allChains,
    );
    // ---------------------------
    return _chain;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static Chain proFindChainByID({
    @required BuildContext context,
    @required String chainID,
    bool onlyUseCityChains = false,
    bool includeChainSInSearch = true,
  }){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
  // ---------------------------
    final Chain _chain = _chainsProvider.findChainByID(
      chainID: chainID,
      includeChainSInSearch: includeChainSInSearch,
      onlyUseCityChains: onlyUseCityChains,
    );

    return _chain;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  List<Chain> getChainKAndChainS({
    @required BuildContext context,
    @required bool getOnlyCityKeywordsChain,
  }){
    final Chain _keywordsChain = ChainsProvider.proGetBigChainK(
      context: context,
      onlyUseCityChains: getOnlyCityKeywordsChain,
      listen: false,
    );
    return <Chain>[_keywordsChain, _bigChainS];
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

    final Chain _chain = findChainByID(
      chainID: _chainID,
      onlyUseCityChains: onlyUseCityChains,
      includeChainSInSearch: false,
    );

    return _chain;
  }
// -------------------------------------
  /// TESTED : WORKS PERFECT
  String getPhidIcon({
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
// -------------------------------------
  /// TESTED : WORKS PERFECT
  static String proGetPhidIcon({
    @required BuildContext context,
    @required dynamic son,
  }){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    return _chainsProvider.getPhidIcon(context: context, son: son);
  }
// -----------------------------------------------------------------------------o
}
