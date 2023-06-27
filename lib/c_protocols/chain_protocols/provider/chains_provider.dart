import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/b_zone_phids_model.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/protocols/a_chain_protocols.dart';
import 'package:bldrs/c_protocols/zone_phids_protocols/zone_phids_real_ops.dart';
import 'package:bldrs/c_protocols/phrase_protocols/protocols/phrase_protocols.dart';
import 'package:bldrs/c_protocols/picker_protocols/protocols/picker_protocols.dart';
import 'package:bldrs/world_zoning/world_zoning.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
class ChainsProvider extends ChangeNotifier {
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> initializeAllChains({
    required bool notify,
  }) async {
    // --------------------
    /// NOTE : initialization for fetching setting :-
    /// BIG CHAIN K
    /// BIG CHAIN S
    /// ALL PICKERS
    /// ZONE PHIDS MODEL
    /// ZONE CHAIN K
    /// BIG CHAIN K PHRASES
    /// BIG CHAIN S PHRASES
    /// ZONE CHAIN K PHRASES
    // --------------------
    /// 1. START WITH : BIG CHAIN K - BIG CHAIN S - ZONE PHIDS MODEL
    await Future.wait(<Future>[
      /// BIG CHAIN K
      fetchSortSetBldrsChains(
        notify: false,
      ),
      /// ALL PICKERS
      fetchSetAllPickers(
        notify: false,
      ),
      /// ZONE PHID COUNTERS
      _readSetZonePhidsModel(
        notify: false,
      ),
    ]);
    // --------------------
    /// 2. BIG CHAINS ARE LOADED => NOW DO ZONE CHAINS & PHRASES
    await Future.wait(<Future>[
      /// ZONE CHAIN K
      _refineSetZoneChains(
        chains: _chains,
        notify: false,
      ),
      /// BIG CHAIN K PHRASES
      _generateSetChainsPhrases(
        chains: _chains,
        notify: false,
      ),
    ]);
    // --------------------
    /// 3. ZONE CHAIN K PHRASES
    await _generateSetZoneChainsPhrases(
      zoneChains: _zoneChains,
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
  /// TESTED : WORKS PERFECT
  Future<void> reInitializeZoneChains() async {
    blog('reInitializeZoneChains');
    // --------------------
    /// KEEP : BIG CHAIN K
    /// KEEP : BIG CHAIN S
    /// KEEP : ALL PICKERS
    /// KEEP : BIG CHAIN K PHRASES
    /// KEEP : BIG CHAIN S PHRASES
    // --------------------
    /// GET : ZONE PHID COUNTERS
    /// GET : ZONE CHAIN K
    /// GET ZONE CHAIN K PHRASES
    // --------------------
    /// 1. ZONE PHIDS MODEL
    await _readSetZonePhidsModel(
      notify: false,
    );
    // --------------------
    /// 2. ZONE CHAIN K
    await _refineSetZoneChains(
      chains: _chains,
      notify: false,
    );
    // --------------------
    /// 3. ZONE CHAIN K PHRASES
    await _generateSetZoneChainsPhrases(
      zoneChains: _zoneChains,
      notify: true,
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------

  /// UPDATES

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> updateBldrsChainsOps({
    required List<Chain> bldrsChains,
    required bool notify,
  }) async {
    // --------------------
    /// UPDATE : BIG CHAIN K
    /// KEEP : BIG CHAIN S
    /// KEEP : ZONE PHID COUNTERS
    /// UPDATE : ZONE CHAIN K
    /// UPDATE : BIG CHAIN K PHRASES
    /// KEEP : BIG CHAIN S PHRASES
    /// UPDATE : ZONE CHAIN K PHRASES
    // --------------------
    /// 1. BLDRS CHAINS
    _setBldrsChains(
      chains: bldrsChains,
      notify: false,
    );
    // --------------------
    /// 2. BLDRS CHAINS ARE LOADED => NOW DO ZONE CHAINS & PHRASES
    await Future.wait(<Future>[
      /// ZONE CHAIN K
      _refineSetZoneChains(
        chains: bldrsChains,
        notify: false,
      ),
      /// BIG CHAIN K PHRASES
      _generateSetChainsPhrases(
        chains: bldrsChains,
        notify: false,
      ),
    ]);
    // --------------------
    /// 3. ZONE CHAIN K PHRASES
    await _generateSetZoneChainsPhrases(
      zoneChains: bldrsChains,
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
    required bool notify,
  }){

    /// BLDRS CHAINS
    _chains = null;
    /// ALL PICKERS
    _allPickers = {};
    /// ZONE PHID COUNTERS
    _zonePhidsModel = null;
    /// ZONE CHAIN K
    _zoneChains = null;
    /// BLDRS CHAINS PHRASES
    _chainsPhrases = <Phrase>[];
    /// ZONE CHAIN K PHRASES
    _zoneChainsPhrases = <Phrase>[];

    /// WALL FLYER TYPE AND PHID
    clearWallFlyerTypeAndPhid(
        notify: notify
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void wipeOut({
    required bool notify,
  }){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(
        getMainContext(),
        listen: false);

    _chainsProvider.wipeOutChainsPro(
      notify: notify,
    );
  }
  // -----------------------------------------------------------------------------

  /// BLDRS CHAINS

  // --------------------
  List<Chain> _chains;
  List<Chain> get bldrsChains => _chains;
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Chain> proGetBldrsChains({
    required BuildContext context,
    required bool onlyUseZoneChains,
    required bool listen,
  }){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: listen);

    if (onlyUseZoneChains == true){
      return _chainsProvider.zoneChains;
    }
    else {
      return _chainsProvider.bldrsChains;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain proGetChainByID({
    required String chainID,
  }){

    return Chain.getChainFromChainsByID(
        chainID: chainID,
        chains: proGetBldrsChains(
          context: getMainContext(),
          onlyUseZoneChains: false,
          listen: false,
        ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> fetchSortSetBldrsChains({
    required bool notify,
  }) async {

    List<Chain> _bldrsChains = await ChainProtocols.fetchBldrsChains();

    _bldrsChains = Chain.sortChainsAlphabetically(
      chains: _bldrsChains,
    );

    _setBldrsChains(
      chains: _bldrsChains,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setBldrsChains({
    required List<Chain> chains,
    required bool notify,
  }){
    _chains = chains;
    if (notify == true){
      notifyListeners();
    }
  }
  // -----------------------------------------------------------------------------

  /// ZONE PHIDS MODEL

  // --------------------
  ZonePhidsModel _zonePhidsModel;
  ZonePhidsModel get zonePhidsModel => _zonePhidsModel;
  // --------------------
  /// TESTED : WORKS PERFECT
  static ZonePhidsModel proGetZonePhids({
    required BuildContext context,
    required bool listen,
  }){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: listen);
    return _chainsProvider.zonePhidsModel;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _readSetZonePhidsModel({
    required bool notify,
  }) async {

    final ZonePhidsModel _zonePhidsModel = await ZonePhidsRealOps.readZonePhidsOfCurrentZone();

    _setZonePhidModels(
      zonePhidsModel: _zonePhidsModel,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setZonePhidModels({
    required ZonePhidsModel zonePhidsModel,
    required bool notify,
  }){

    _zonePhidsModel = zonePhidsModel;
    if (notify == true){
      notifyListeners();
    }

  }
  // -----------------------------------------------------------------------------

  /// ZONE CHAIN ( zone's chains according to Zone Phids Model )

  // --------------------
  List<Chain> _zoneChains;
  List<Chain> get zoneChains => _zoneChains;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _refineSetZoneChains({
    required bool notify,
    required List<Chain> chains,
  }) async {

    final List<Chain> _zoneChains = ZonePhidsModel.removeUnusedPhidsFromBldrsChainsForThisZone(
      bldrsChains: _chains,
      currentZonePhidsModel: _zonePhidsModel,
    );

    _setZoneChains(
      notify: notify,
      chains: _zoneChains,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setZoneChains({
    required bool notify,
    required List<Chain> chains,
  }){
    _zoneChains = chains;
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
    required List<Chain> chains,
    required bool notify,
  }) async {

    final List<Phrase> _phrases = await PhraseProtocols.generatePhrasesFromChains(
      context: getMainContext(),
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
    required List<Phrase> phrases,
    required bool notify,
  }){
    _chainsPhrases = phrases;
    if (notify == true){
      notifyListeners();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String translateChainPhid({
    required String phid,
    required String langCode,
  }){

    final Phrase _phrase = Phrase.searchPhraseByIDAndLangCode(
      phrases: _chainsPhrases,
      langCode: langCode,
      phid: phid,
    );

    return _phrase?.value;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  List<String> translateChainPhids({
    required List<String> phids,
    required String langCode,
  }){
    final List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(phids) == true){

      for (final String phid in phids){

        final String _translation = translateChainPhid(
          phid: phid,
          langCode: langCode,
        );
        
        _output.add(_translation);

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// ZONE CHAINS PHRASES

  // --------------------
  /// must include trigrams and both languages (en, ar) for search engines
  List<Phrase> _zoneChainsPhrases = <Phrase>[];
  List<Phrase> get zoneChainsPhrases => _zoneChainsPhrases;
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _generateSetZoneChainsPhrases({
    required List<Chain> zoneChains,
    required bool notify,
  }) async {

    final List<Phrase> _phrases = await PhraseProtocols.generatePhrasesFromChains(
      context: getMainContext(),
      chains: zoneChains,
    );

    _setZoneChainsPhrases(
      phrases: _phrases,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setZoneChainsPhrases({
    required List<Phrase> phrases,
    required bool notify,
  }){
    _zoneChainsPhrases = phrases;
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
  FlyerType get wallFlyerType => _wallFlyerType;
  String get wallPhid => _wallPhid;
  // --------------------
  /// TESTED : WORKS PERFECT
  static FlyerType proGetHomeWallFlyerType({
    required BuildContext context,
    required bool listen,
  }){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: listen);
    return _chainsProvider.wallFlyerType;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String proGetHomeWallPhid({
    required BuildContext context,
    required bool listen,
  }){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: listen);
    return _chainsProvider.wallPhid;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> changeHomeWallFlyerType({
    required FlyerType flyerType,
    required String phid,
    required bool notify,
  }) async {

    // blog('Changing section to $flyerType');

    _setWallFlyerAndPhid(
      flyerType: flyerType,
      phid: phid,
      notify: notify,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setWallFlyerAndPhid({
    required FlyerType flyerType,
    required String phid,
    required bool notify,
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
    required bool notify,
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
    required BuildContext context,
    required bool listen,
  }){

    return proGetSortedPickersByFlyerTypes(
      context: context,
        flyerTypes: FlyerTyper.flyerTypesList,
        sort: true,
        listen: listen
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PickerModel proGetPickerByChainID({
    required String chainID,
  }){

    return PickerModel.getPickerByChainID(
      chainID: Phider.removeIndexFromPhid(phid: chainID),
      pickers: proGetAllPickers(
        context: getMainContext(),
        listen: false,
      ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<PickerModel> proGetPickersByFlyerType({
    required BuildContext context,
    required FlyerType flyerType,
    required bool sort,
    required bool listen,
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
    required BuildContext context,
    required List<FlyerType> flyerTypes,
    required bool sort,
    required bool listen,
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
    required BuildContext context,
    required List<SpecModel> specs,
    required bool listen,
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
    required bool notify,
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
    required FlyerType flyerType,
    required List<PickerModel> pickers,
    required bool notify,
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
  /// TESTED : WORKS PERFECT
  Chain findChainByID({
    required String chainID,
    bool onlyUseZoneChains = false,
  }){

    final List<Chain> _chainsToSearch = onlyUseZoneChains == true ?
    _zoneChains
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
    required String chainID,
    bool onlyUseZoneChains = false,
  }){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);

    final Chain _chain = _chainsProvider.findChainByID(
      chainID: chainID,
      onlyUseZoneChains: onlyUseZoneChains,
    );

    return _chain;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Chain getChainKByFlyerType({
    required FlyerType flyerType,
    required bool onlyUseZoneChains,
  }){

    final String _chainID = FlyerTyper.concludeChainIDByFlyerType(
      flyerType: flyerType,
    );

    final Chain _chain = findChainByID(
      chainID: _chainID,
      onlyUseZoneChains: onlyUseZoneChains,
    );

    return _chain;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String getPhidIcon({
    required dynamic son,
  }) {

    String? _phid;

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
      assetName: _phid,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String proGetPhidIcon({
    required dynamic son,
  }){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);
    return _chainsProvider.getPhidIcon(son: son);
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
    required BuildContext context,
    required bool listen,
  }){
    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: listen);
    return _chainsProvider.bigChainS;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _fetchSetBigChainS({
    required BuildContext context,
    required bool notify,
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
    required Chain bigChainS,
    required bool notify,
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
    required BuildContext context,
    required Chain bigChainS,
    required bool notify,
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
    required List<Phrase> phrases,
    required bool notify,
  }){
    _bigChainSPhrases = phrases;
    if (notify == true){
      notifyListeners();
    }
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> updateBigChainSOps({
    required BuildContext context,
    required Chain bigChainS,
    required bool notify,
  }) async {
    // --------------------
    /// KEEP : BIG CHAIN K
    /// UPDATE : BIG CHAIN S
    /// KEEP : ZONE PHID COUNTERS
    /// KEEP : ZONE CHAIN K
    /// KEEP : BIG CHAIN K PHRASES
    /// UPDATE : BIG CHAIN S PHRASES
    /// KEEP : ZONE CHAIN K PHRASES
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
