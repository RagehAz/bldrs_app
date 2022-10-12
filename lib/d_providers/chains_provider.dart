import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/b_city_phids_model.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_secondary/phrase_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/a_chain_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/phrase_protocols.dart';
import 'package:bldrs/c_protocols/picker_protocols/picker_protocols.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
class ChainsProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
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
      _fetchSetBldrsChains(
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
      _refineSetCityChains(
        chains: _chains,
        notify: false,
      ),
      /// BIG CHAIN K PHRASES
      _generateSetChainsPhrases(
        context: context,
        chains: _chains,
        notify: false,
      ),
    ]);
    // --------------------
    /// 3. CITY CHAIN K PHRASES
    await _generateSetCityChainsPhrases(
      context: context,
      cityChains: _cityChains,
      notify: false,
    );
    // --------------------
    /// NOTIFY LISTENERS
    if (notify == true){
      notifyListeners();
    }
    // --------------------
  }
  // --------------------
  /*
  Future<void> reInitializeAllChains(BuildContext context) async {
    // --------------------
    /// DELETE LDB CHAINS
    await ChainLDBOps.deleteBldrsChains();
    // --------------------
    /// BLDRS CHAINS
    _chains = null;
    /// ALL PICKERS
    _allPickers = {};
    /// CITY PHID COUNTERS
    _cityPhidsModel = null;
    /// CITY CHAINS
    _cityChains = null;
    /// CHAINS PHRASES
    _chainsPhrases = <Phrase>[];
    /// CITY CHAINS PHRASES
    _cityChainsPhrases = <Phrase>[];
    // --------------------
    /// INITIALIZE
    await initializeAllChains(
      context: context,
      notify: true,
    );
    // --------------------
  }
   */
  // --------------------
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
    await _refineSetCityChains(
      chains: _chains,
      notify: false,
    );
    // --------------------
    /// 3. CITY CHAIN K PHRASES
    await _generateSetCityChainsPhrases(
      context: context,
      cityChains: _cityChains,
      notify: true,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------

  /// UPDATES

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> updateBldrsChainsOps({
    @required BuildContext context,
    @required List<Chain> bldrsChains,
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
    /// 1. BLDRS CHAINS
    _setBldrsChains(
      chains: bldrsChains,
      notify: false,
    );
    // --------------------
    /// 2. BLDRS CHAINS ARE LOADED => NOW DO CITY CHAINS & PHRASES
    await Future.wait(<Future>[
      /// CITY CHAIN K
      _refineSetCityChains(
        chains: bldrsChains,
        notify: false,
      ),
      /// BIG CHAIN K PHRASES
      _generateSetChainsPhrases(
        context: context,
        chains: bldrsChains,
        notify: false,
      ),
    ]);
    // --------------------
    /// 3. CITY CHAIN K PHRASES
    await _generateSetCityChainsPhrases(
      context: context,
      cityChains: bldrsChains,
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

  // --------------------
  /// TESTED : WORKS PERFECT
  void wipeOutChainsPro({
    @required BuildContext context,
    @required bool notify,
  }){

    /// BLDRS CHAINS
    _chains = null;
    /// ALL PICKERS
    _allPickers = {};
    /// CITY PHID COUNTERS
    _cityPhidsModel = null;
    /// CITY CHAIN K
    _cityChains = null;
    /// BLDRS CHAINS PHRASES
    _chainsPhrases = <Phrase>[];
    /// CITY CHAIN K PHRASES
    _cityChainsPhrases = <Phrase>[];

    /// WALL FLYER TYPE AND PHID
    clearWallFlyerTypeAndPhid(
        notify: notify
    );

  }
  // --------------------
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

  /// BLDRS CHAINS

  // --------------------
  List<Chain> _chains;
  List<Chain> get bldrsChains => _chains;
  // --------------------
  ///
  static List<Chain> proGetBldrsChains({
    @required BuildContext context,
    @required bool onlyUseCityChains,
    @required bool listen,
  }){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: listen);

    if (onlyUseCityChains == true){
      return _chainsProvider.cityChains;
    }
    else {
      return _chainsProvider.bldrsChains;
    }

  }

  static Chain proGetChainByID({
    @required BuildContext context,
    @required String chainID,
  }){

    return Chain.getChainFromChainsByID(
        chainID: chainID,
        chains: proGetBldrsChains(
          context: context,
          onlyUseCityChains: false,
          listen: false,
        ),
    );

  }
  // --------------------
  ///
  Future<void> _fetchSetBldrsChains({
    @required bool notify,
  }) async {

    final List<Chain> _bldrsChains = await ChainProtocols.fetchBldrsChains();

    _setBldrsChains(
      chains: _bldrsChains,
      notify: notify,
    );

  }
  // --------------------
  ///
  void _setBldrsChains({
    @required List<Chain> chains,
    @required bool notify,
  }){
    _chains = chains;
    if (notify == true){
      notifyListeners();
    }
  }
  // -----------------------------------------------------------------------------

  /// CITY PHID COUNTERS

  // --------------------
  CityPhidsModel _cityPhidsModel;
  CityPhidsModel get cityPhidsModel => _cityPhidsModel;
  // --------------------
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
  // --------------------
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

  /// CITY CHAIN ( city's chains according to City Phid Counters )

  // --------------------
  List<Chain> _cityChains;
  List<Chain> get cityChains => _cityChains;
  // --------------------
  ///
  Future<void> _refineSetCityChains({
    @required bool notify,
    @required List<Chain> chains,
  }) async {

    final List<Chain> _cityChains = CityPhidsModel.removeUnusedPhidsFromBldrsChainsForThisCity(
      bldrsChains: _chains,
      currentCityPhidsModel: _cityPhidsModel,
    );

    _setCityChains(
      notify: notify,
      chains: _cityChains,
    );

  }
  // --------------------
  ///
  void _setCityChains({
    @required bool notify,
    @required List<Chain> chains,
  }){
    _cityChains = chains;
    if (notify == true){
      notifyListeners();
    }
  }
  // -----------------------------------------------------------------------------

  /// BLDRS CHAINS PHRASES

  // --------------------
  List<Phrase> _chainsPhrases = <Phrase>[];
  List<Phrase> get chainsPhrases => _chainsPhrases;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _generateSetChainsPhrases({
    @required BuildContext context,
    @required List<Chain> chains,
    @required bool notify,
  }) async {

    final List<Phrase> _phrases = await PhraseProtocols.generatePhrasesFromChains(
      context: context,
      chains: chains,
    );

    _setBldrsChainsPhrases(
      phrases: _phrases,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setBldrsChainsPhrases({
    @required List<Phrase> phrases,
    @required bool notify,
  }){
    _chainsPhrases = phrases;
    if (notify == true){
      notifyListeners();
    }
  }
  // -----------------------------------------------------------------------------

  /// CITY CHAINS PHRASES

  // --------------------
  /// must include trigrams and both languages (en, ar) for search engines
  List<Phrase> _cityChainsPhrases = <Phrase>[];
  List<Phrase> get cityChainsPhrases => _cityChainsPhrases;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _generateSetCityChainsPhrases({
    @required BuildContext context,
    @required List<Chain> cityChains,
    @required bool notify,
  }) async {

    final List<Phrase> _phrases = await PhraseProtocols.generatePhrasesFromChains(
      context: context,
      chains: cityChains,
    );

    _setCityChainsPhrases(
      phrases: _phrases,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setCityChainsPhrases({
    @required List<Phrase> phrases,
    @required bool notify,
  }){
    _cityChainsPhrases = phrases;
    if (notify == true){
      notifyListeners();
    }
  }
  // -----------------------------------------------------------------------------

  /// HOME WALL FLYER TYPE AND PHID

  // --------------------
  FlyerType _wallFlyerType;
  String _wallPhid;
  // --------------------
  FlyerType get wallFlyerType => _wallFlyerType ?? FlyerType.design;
  String get wallPhid => _wallPhid;
  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerType proGetHomeWallFlyerType(BuildContext context){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    return _chainsProvider.wallFlyerType;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String proGetHomeWallPhid(BuildContext context){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
    return _chainsProvider.wallPhid;
  }
  // --------------------

  Future<void> changeHomeWallFlyerType({
    @required BuildContext context,
    @required FlyerType flyerType,
    @required String phid,
    @required bool notify,
  }) async {
    blog('Changing section to $flyerType');

    final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

    await _flyersProvider.paginateWallFlyers(
      context: context,
      listenToZoneChange: false,
    );

    _setWallFlyerAndPhid(
      flyerType: flyerType,
      phid: phid,
      notify: notify,
    );

  }
  // --------------------
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
  // --------------------
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

  // --------------------
  Map<String, dynamic> _allPickers = {};
  Map<String, dynamic> get allPickers => _allPickers;
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> proGetAllPickers({
    @required BuildContext context,
    @required bool listen,
}){

    return proGetSortedPickersByFlyerTypes(
        context: context,
        flyerTypes: FlyerTyper.flyerTypesList,
        sort: true,
        listen: listen
    );

  }

  static PickerModel proGetPickerByChainID({
    @required BuildContext context,
    @required String chainID,
  }){

    return PickerModel.getPickerByChainID(
      chainID: Phider.removeIndexFromPhid(phid: chainID),
      pickers: proGetAllPickers(
        context: context,
        listen: false,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> proGetPickersByFlyerType({
    @required BuildContext context,
    @required FlyerType flyerType,
    @required bool sort,
    @required bool listen,
  }){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: listen);
    final String _pickersKey = PickerModel.getPickersIDByFlyerType(flyerType);
    List<PickerModel> _pickers = _chainsProvider.allPickers[_pickersKey];
    if (sort == true){
      _pickers = PickerModel.sortPickersByIndexes(_pickers);
    }
    return  _pickers;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> proGetSortedPickersByFlyerTypes({
    @required BuildContext context,
    @required List<FlyerType> flyerTypes,
    @required bool sort,
    @required bool listen,
  }){
    final List<PickerModel> _output = <PickerModel>[];

    if (Mapper.checkCanLoopList(flyerTypes) == true){

      for (final FlyerType type in flyerTypes){

        final List<PickerModel> _pickers = ChainsProvider.proGetPickersByFlyerType(
          context: context,
          flyerType: type,
          listen: listen,
          sort: sort,
        );

        _output.addAll(_pickers);

      }

    }

    return sort == true ? PickerModel.correctModelsIndexes(_output) : _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> proGetPickersBySpecs({
    @required BuildContext context,
    @required List<SpecModel> specs,
    @required bool listen,
  }){
    final List<PickerModel> _output = <PickerModel>[];

    if (Mapper.checkCanLoopList(specs)){

      final List<PickerModel> _allPickers = ChainsProvider.proGetAllPickers(
        context: context,
        listen: listen,
      );

      for (final SpecModel _spec in specs){

        final bool _isCurrency = Phider.checkVerseIsCurrency(_spec.value);

        if (_isCurrency == false){

          final PickerModel _picker = PickerModel.getPickerByChainID(
            pickers: _allPickers,
            chainID: _spec.pickerChainID,
          );

          if (_picker != null){

            final bool _alreadyAdded = PickerModel.checkPickersContainPicker(
              pickers: _output,
              picker: _picker,
            );

            if (_alreadyAdded == false){
              _output.add(_picker);
            }

          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> fetchSetAllPickers({
    @required BuildContext context,
    @required bool notify,
  }) async {

    await Future.wait(<Future>[

      ...List.generate(FlyerTyper.flyerTypesList.length, (index) async {

        final FlyerType _flyerType = FlyerTyper.flyerTypesList[index];

        await PickerProtocols.fetchFlyerTypPickers(
          flyerType: _flyerType,
          onFinish: (List<PickerModel> pickers){

            // blog('fetchSetAllPickers : DONE WITH $_flyerType');

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
  // --------------------
  /// TESTED : WORKS PERFECT
  void setFlyerTypePickers({
    @required BuildContext context,
    @required FlyerType flyerType,
    @required List<PickerModel> pickers,
    @required bool notify,
  }){

    final String _pickersID = PickerModel.getPickersIDByFlyerType(flyerType);

    // blog('setFlyerTypePickers : $_pickersID : $flyerType');

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
  ///
  Chain findChainByID({
    @required String chainID,
    bool onlyUseCityChains = false,
  }){

    final List<Chain> _chainsToSearch = onlyUseCityChains == true ?
    _cityChains
        :
    _chains;

    final Chain _chain = Chain.getChainFromChainsByID(
      chainID: chainID,
      chains: _chainsToSearch,
    );

    return _chain;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain proFindChainByID({
    @required BuildContext context,
    @required String chainID,
    bool onlyUseCityChains = false,
  }){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    final Chain _chain = _chainsProvider.findChainByID(
      chainID: chainID,
      onlyUseCityChains: onlyUseCityChains,
    );

    return _chain;
  }
  // --------------------
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
    );

    return _chain;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String getPhidIcon({
    @required BuildContext context,
    @required dynamic son,
  }) {

    String _phid;

    /// WHEN SON IS KEYWORD ID
    if (son.runtimeType == String) {
      _phid  = Phider.removeIndexFromPhid(phid: son);
    }
    /// WHEN SON IS A CHAIN
    else if (son.runtimeType == Chain) {
      final Chain _chain = son;
      _phid = Phider.removeIndexFromPhid(phid: _chain.id);
    }

    return getLocalAssetPath(
      context: context,
      assetName: _phid,
    );

  }
  // --------------------
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

/*
  // -----------------------------------------------------------------------------

  /// BIG CHAIN S - (main specs chain)

  // --------------------
  Chain _bigChainS;
  // --------------------
  Chain get bigChainS => _bigChainS;
  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain proGetBigChainS({
    @required BuildContext context,
    @required bool listen,
  }){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: listen);
    return _chainsProvider.bigChainS;
  }
  // --------------------
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
  // --------------------
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

  /// BIG CHAIN S PHRASES

  // --------------------
  List<Phrase> _bigChainSPhrases = <Phrase>[];
  List<Phrase> get bigChainSPhrases => _bigChainSPhrases;
  // --------------------
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
  // --------------------
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

  // --------------------
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

 */
