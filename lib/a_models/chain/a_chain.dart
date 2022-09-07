import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/a_models/chain/dd_data_creator.dart';
import 'package:bldrs/a_models/chain/c_picker_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/e_db/real/foundation/real_colls.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:flutter/material.dart';

@immutable
class Chain {
  /// --------------------------------------------------------------------------
  const Chain({
    @required this.id,
    @required this.sons,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final dynamic sons;
  // -----------------------------------------------------------------------------

  /// TESTED : WORKS PERFECT
  void addPathSon({
    @required dynamic son,
    @required bool isLastSonInPath,
  }) {


    if (isLastSonInPath == false){
      sons.add(son);
    }

    else {
      final bool _contains = Stringer.checkStringsContainString(
        strings: Stringer.getStringsFromDynamics(dynamics: sons),
        string: son,
      );
      if (_contains == false){
        sons.add(son);
      }
    }

  }

  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  Chain copyWith({
    String id,
    dynamic sons,
  }){
    return Chain(
      id: id ?? this.id,
      sons: sons ?? this.sons,
    );
  }
  // -----------------------------------------------------------------------------

  /// REAL CYPHERS

  // --------------------
  /// TASK DEPRECATED
  static Map<String, dynamic> cipherBigChainK({
    @required Chain chainK,
  }){

    final List<String> chainKPaths = ChainPathConverter.generateChainsPaths(
      parentID: '',
      chains: chainK.sons,
    );

    Map<String, dynamic> _map = {};

    if (Mapper.checkCanLoopList(chainKPaths) == true){

      for (int i = 0; i < chainKPaths.length; i++){

        final String _path = chainKPaths[i];
        final String _key = ChainPathConverter.getLastPathNode(_path);

        if (_map[_key] == null){
          _map = Mapper.insertPairInMap(
            map: _map,
            key: _key,
            value: _path,
          );
        }

        else {
          blog('cipherChainKPaths : error here key is taken : _key $_key : ${_map[_key]}');
          throw Error();
        }

      }


    }

    return _map;
  }
  // --------------------
  /// TASK DEPRECATED
  static Chain decipherBigChainK({
    @required Map<String, dynamic> bigChainKMap,
  }) {
    Chain _bigChainK;

    if (bigChainKMap != null) {

      final List<dynamic> _dynamicsValues = bigChainKMap.values.toList();
      _dynamicsValues.remove(RealDoc.chains_bigChainK);

      final List<String> _paths = Stringer.getStringsFromDynamics(
        dynamics: _dynamicsValues,
      );

      final List<Chain> _chainKSons = ChainPathConverter.createChainsFromPaths(
        paths: _paths,
      );

      _bigChainK = Chain(
        id: 'chainK',
        sons: _chainKSons,
      );

    }

    return _bigChainK;
  }
  // --------------------
  /// TASK DEPRECATED
  static Map<String, dynamic> cipherBigChainS({
    @required Chain chainS,
  }){

    /// NOTE : CHAIN S HAS DUPLICATE LAST NODES IN THEIR PATHS

    final List<String> chainSPaths = ChainPathConverter.generateChainsPaths(
      parentID: '',
      chains: chainS.sons,
    );

    Map<String, dynamic> _map = {};

    if (Mapper.checkCanLoopList(chainSPaths) == true){

      for (int i = 0; i < chainSPaths.length; i++){

        final String _path = chainSPaths[i];
        final String _key = Phider.generatePhidPathUniqueKey(
          path: _path,
        );

        /// THIS KEY IS UNIQUE
        if (_map[_key] == null){
          _map = Mapper.insertPairInMap(
            map: _map,
            key: _key,
            value: _path,
          );
        }

        /// THE KEY IS TAKEN ALREADY
        else {
          blog('cipherChainSPaths : error here key is taken : _key $_key : ${_map[_key]}');
          throw Error();
        }

      }


    }

    return _map;
  }
  // --------------------
  /// TASK DEPRECATED
  static Chain decipherBigChainS({
    @required Map<String, dynamic> bigChainSMap,
  }) {
    Chain _bigChainS;

    if (bigChainSMap != null) {

      final List<dynamic> _dynamicsValues = bigChainSMap.values.toList();
      _dynamicsValues.remove(RealDoc.chains_bigChainS);

      final List<String> _paths = Stringer.getStringsFromDynamics(
        dynamics: _dynamicsValues,
      );

      final List<Chain> _chainSSons = ChainPathConverter.createChainsFromPaths(
        paths: _paths,
      );

      _bigChainS = Chain(
        id: 'chainS',
        sons: _chainSSons,
      );

    }

    return _bigChainS;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherBldrsChains({
    @required List<Chain> chains,
  }){
    Map<String, dynamic> _map = {};

    if (Mapper.checkCanLoopList(chains) == true){

      final List<String> paths = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: chains,
      );

      // Stringer.blogStrings(strings: paths);

      for (int i = 0; i < paths.length; i++){

        final String _path = paths[i];

        final String _key = Phider.generatePhidPathUniqueKey(
          path: _path,
        );
        // final String _pathWithPhidIndex =

        /// THIS KEY IS UNIQUE
        if (_map[_key] == null){
          _map = Mapper.insertPairInMap(
            map: _map,
            key: _key,
            value: _path,
          );
        }

        /// THE KEY IS TAKEN ALREADY
        else {
          blog('cipherChainSPaths : error here key is taken : _key $_key : ${_map[_key]}');
          throw Error();
        }

      }

    }

    return _map;
  }
  // --------------------

  static List<Chain> decipherBldrsChains({
    @required Map<String, dynamic> map,
  }) {
    List<Chain> _bldrsChains;

    if (map != null) {

      final List<dynamic> _dynamicsValues = map.values.toList();
      _dynamicsValues.remove(RealColl.bldrsChains);

      final List<String> _paths = Stringer.getStringsFromDynamics(
        dynamics: _dynamicsValues,
      );

      _bldrsChains = ChainPathConverter.createChainsFromPaths(
        paths: _paths,
      );

    }

    return _bldrsChains;
  }
  // -----------------------------------------------------------------------------

  /// OLD FIRE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMapOLD(){
    return
      {
        'id': id,
        'sons': _cipherSonsOLD(sons),
      };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static dynamic _cipherSonsOLD(dynamic sons){
    /// can either be DataCreator or List<String> or List<Chain>
    final bool _sonsAreChains = checkSonsAreChains(sons);
    final bool _sonsArePhids = checkSonsArePhids(sons);
    final bool _sonsAreDataCreator = checkSonsAreDataCreator(sons);

    if (_sonsAreChains == true){
      return cipherChainsOLD(sons); // List<Map<String, dynamic>>
    }
    else if (_sonsArePhids == true){
      return sons; // List<String>
    }
    else if ( _sonsAreDataCreator == true){
      return cipherDataCreator(sons);
    }
    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String cipherDataCreator(dynamic sons){
    switch (sons){

      case DataCreator.doubleKeyboard:      return 'DataCreator_doubleKeyboard';      break;
      case DataCreator.doubleSlider:        return 'DataCreator_doubleSlider';        break;
      case DataCreator.doubleRangeSlider:   return 'DataCreator_doubleRangeSlider';   break;

      case DataCreator.integerKeyboard:     return 'DataCreator_integerKeyboard';     break;
      case DataCreator.integerSlider:       return 'DataCreator_integerSlider';       break;
      case DataCreator.integerRangeSlider:  return 'DataCreator_integerRangeSlider';  break;

      case DataCreator.boolSwitch:          return 'DataCreator_boolSwitch';          break;
      case DataCreator.country:             return 'DataCreator_country';             break;
      default: return null;

    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DataCreator decipherDataCreator(dynamic sons){

    /// IS DATA CREATOR
    if (sons is DataCreator){
      return sons;
    }
    else {

      /// IS String
      if (sons is String){

        /// DataCreator_doubleKeyboard
        if (sons == 'DataCreator_doubleKeyboard'){
          return DataCreator.doubleKeyboard;
        }

        /// DataCreator_doubleSlider
        else if (sons == 'DataCreator_doubleSlider'){
          return DataCreator.doubleSlider;
        }

        /// DataCreator_doubleSlider
        else if (sons == 'DataCreator_doubleRangeSlider'){
          return DataCreator.doubleRangeSlider;
        }

        /// DataCreator_integerKeyboard
        else if (sons == 'DataCreator_integerKeyboard'){
          return DataCreator.integerKeyboard;
        }

        /// DataCreator_integerSlider
        else if (sons == 'DataCreator_integerSlider'){
          return DataCreator.integerSlider;
        }

        /// DataCreator_integerRangeSlider
        else if (sons == 'DataCreator_integerRangeSlider'){
          return DataCreator.integerRangeSlider;
        }

        /// DataCreator_boolSwitch
        else if (sons == 'DataCreator_boolSwitch'){
          return DataCreator.boolSwitch;
        }

        /// DataCreator_country
        else if (sons == 'DataCreator_country'){
          return DataCreator.country;
        }

        /// NOTHING => is String but not DataCreator
        else {
          return null;
        }

      }

      /// IS List<String>
      else if (sons is List<String>){

        final String _sonsAsString = sons.toString();

        /// DataCreator_doubleKeyboard
        if (_sonsAsString == '[DataCreator_doubleKeyboard]'){
          return DataCreator.doubleKeyboard;
        }

        /// DataCreator_doubleSlider
        if (_sonsAsString == '[DataCreator_doubleSlider]'){
          return DataCreator.doubleSlider;
        }

        /// DataCreator_doubleSlider
        if (_sonsAsString == '[DataCreator_doubleRangeSlider]'){
          return DataCreator.doubleRangeSlider;
        }

        /// DataCreator_integerKeyboard
        if (_sonsAsString == '[DataCreator_integerKeyboard]'){
          return DataCreator.integerKeyboard;
        }

        /// DataCreator_integerSlider
        if (_sonsAsString == '[DataCreator_integerSlider]'){
          return DataCreator.integerSlider;
        }

        /// DataCreator_integerRangeSlider
        if (_sonsAsString == '[DataCreator_integerRangeSlider]'){
          return DataCreator.integerRangeSlider;
        }

        /// DataCreator_boolSwitch
        if (_sonsAsString == '[DataCreator_boolSwitch]'){
          return DataCreator.boolSwitch;
        }

        /// DataCreator_country
        if (_sonsAsString == '[DataCreator_country]'){
          return DataCreator.country;
        }

        /// NOTHING => is List<String> but not DataCreator
        else {
          return null;
        }

      }

      /// NOTHING
      else {
        return null;
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherChainsOLD(List<Chain> chains){

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.checkCanLoopList(chains) == true){

      for (final Chain chain in chains){
        final Map<String, dynamic> _map = chain.toMapOLD();
        _maps.add(_map);
      }

    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain decipherChainOLD(Map<String, dynamic> map){
    Chain _chain;

    if (map != null){
      _chain = Chain(
        id: map['id'],
        sons: _decipherSonsOLD(map['sons']),
      );
    }

    return _chain;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static dynamic _decipherSonsOLD(dynamic sons){
    dynamic _output;

    if (sons != null){

      // blog('_decipherSons  : sons type (${sons.runtimeType.toString()}) : son ($sons)');

      /// CHAINS AND STRINGS ARE LIST<dynamic>
      if (sons is List<dynamic>){

        /// FIRST SON IS STRING => SONS ARE STRINGS
        if (sons[0] is String){
          _output = Stringer.getStringsFromDynamics(dynamics: sons);
        }

        /// FIRST SON IS NOT STRING => SONS ARE CHAINS
        else {
          _output = decipherChainsOLD(sons);
        }

      }

      /// DATA CREATOR IS STRING
      else if (sons is String){
        final bool _isDataCreator = TextMod.removeTextAfterFirstSpecialCharacter(sons, '_') == 'DataCreator';
        if (_isDataCreator == true){
          _output = decipherDataCreator(sons);
        }
      }

    }

    return  _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Chain> decipherChainsOLD(List<dynamic> maps){
    final List<Chain> _chains = <Chain>[];

    if (Mapper.checkCanLoopList(maps) == true){

      for (final Map<String, dynamic> map in maps){
        final Chain _chain = decipherChainOLD(map);
        _chains.add(_chain);
      }

    }

    return _chains;
  }
  // -----------------------------------------------------------------------------

  /// STANDARDS

  // --------------------
  static const String propertyChainID = 'phid_k_flyer_type_property';
  static const String designChainID = 'phid_k_flyer_type_design';
  static const String tradesChainID = 'phid_k_flyer_type_trades';
  static const String productChainID = 'phid_k_flyer_type_product';
  static const String equipmentChainID = 'phid_k_flyer_type_equipment';
  // --------------------
  static List<String> chainKSonsIDs = <String>[
    propertyChainID,
    designChainID,
    tradesChainID,
    productChainID,
    equipmentChainID,
  ];
  // -----------------------------------------------------------------------------

  /// FILTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain filterSpecPickerChainRange({
    @required BuildContext context,
    @required PickerModel picker,
    @required bool onlyUseCityChains,
  }) {

    final List<String> _filteredIDs = <String>[];
    Chain _filteredChain = ChainsProvider.proFindChainByID(
      context: context,
      chainID: picker.chainID,
      onlyUseCityChains: onlyUseCityChains,
    );

    if (
    Mapper.checkCanLoopList(_filteredChain?.sons)
        &&
        Mapper.checkCanLoopList(picker?.range)
    ) {

      final List<String> _rangeIDs = Stringer.getStringsFromDynamics(
        dynamics: picker.range,
      );

      for (final String son in _filteredChain.sons) {

        final bool _rangeContainsThisID = Stringer.checkStringsContainString(
          strings: _rangeIDs,
          string: son,
        ) == true;

        if (_rangeContainsThisID == true) {
          _filteredIDs.add(son);
        }

      }

      _filteredChain = Chain(
        id: _filteredChain.id,
        sons: _filteredIDs,
      );
    }

    return _filteredChain;
  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSonsAreChains(dynamic sons){
    bool _areChains = false;

    if (sons.runtimeType.toString() == 'List<Chain>'){
      _areChains = true;
    }

    return _areChains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSonsAreDataCreator(dynamic sons){

    bool _isDataCreator = false;

    // blog('checkSonsAreDataCreator : ${sons.runtimeType} : $sons');

    if (sons != null){

      if (sons is DataCreator){
        _isDataCreator = true;
      }
      else if (sons is List<DataCreator>){
        _isDataCreator = true;
      }

      else if (sons.runtimeType.toString() == 'DataCreator'){
        _isDataCreator = true;
      }

      else if (sons is List<String>){

        final List<String> _sons = sons;

        if (Mapper.checkCanLoopList(_sons) == true){

          final String _first = _sons.first;

          final String _dataCreator = TextMod.removeTextAfterFirstSpecialCharacter(_first, '_');
          if (_dataCreator == 'DataCreator'){
            _isDataCreator = true;
          }

        }
      }

    }

    return _isDataCreator;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSonsAreDataCreatorOfType({
    @required dynamic sons,
    @required DataCreator dataCreator,
  }){

    bool _indeed = false;

    if (sons == dataCreator){
      _indeed = true;
    }
    else {

      final bool _isDataCreator = checkSonsAreDataCreator(sons);

      if (_isDataCreator == true){

        if (sons is List<String>){

          final List<String> _sons = sons;
          if (Mapper.checkCanLoopList(_sons) == true){

            final String _first = _sons.first;
            final String _cipheredType = Chain.cipherDataCreator(dataCreator);

            // blog('_first : $_first');
            // blog('dataCreator : $dataCreator');
            // blog('dataCreator.toString() : ${dataCreator.toString()} || ${dataCreator.toString() == _first}');
            // blog('_cipheredType : $_cipheredType || ${_cipheredType == _first}');

            if (_cipheredType == _first){
              _indeed = true;
            }

          }


        }


      }

    }



    return _indeed;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkSonsArePhids(dynamic sons){

    bool _arePhids = false;

    if (sons != null){

      if (sons is List<String>){

        final List<String> _sons = sons;

        if (Mapper.checkCanLoopList(_sons) == true){

          _arePhids = Phider.checkIsPhid(_sons.first);

        }

      }

    }

    return _arePhids;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainsAreIdentical({
    @required Chain chain1,
    @required Chain chain2,
  }){
    bool _areIdentical = false;

    if (chain1 !=null && chain2 != null){

      if (chain1.id == chain2.id){

        if (checkChainsSonsAreIdentical(chain1, chain2) == true){
          _areIdentical = true;
        }

      }

    }

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainsSonsAreIdentical(Chain chain1, Chain chain2){

    bool _sonsAreIdentical = false;

    final bool sonsAisChains = checkSonsAreChains(chain1.sons);
    final bool sonsAisDataCreator = checkSonsAreDataCreator(chain1.sons);
    final bool sonsAisPhids = checkSonsArePhids(chain1.sons);

    final bool sonsBisChains = checkSonsAreChains(chain2.sons);
    final bool sonsBisDataCreator = checkSonsAreDataCreator(chain2.sons);
    final bool sonsBIsPhids = checkSonsArePhids(chain2.sons);

    if (
    sonsAisChains == sonsBisChains
        &&
        sonsAisDataCreator == sonsBisDataCreator
        &&
        sonsBIsPhids == sonsAisPhids
    ){

      /// IF SONS ARE CHAINS
      if (sonsAisChains == true){
        _sonsAreIdentical = checkChainsListsAreIdenticalOLDMETHOD(
          chains1: chain1.sons,
          chains2: chain2.sons,
        );
      }

      /// IF SONS ARE PHIDS
      if (sonsAisPhids == true){
        _sonsAreIdentical = Mapper.checkListsAreIdentical(
            list1: chain1.sons,
            list2: chain2.sons
        );
      }

      /// IF SONS ARE DATA CREATORS
      if (sonsAisDataCreator == true){
        _sonsAreIdentical = chain1.sons?.toString() == chain2.sons?.toString();
      }

    }

    if (_sonsAreIdentical == false){
      blog('xxx ~~~> checkChainsSonsAreIdentical : TAKE CARE : _sonsAreIdentical : $_sonsAreIdentical');
      blog('xxx ~~~> sonsAisChains : $sonsAisChains : sonsAisDataCreator : $sonsAisDataCreator : sonsAisPhids : $sonsAisPhids');
      blog('xxx ~~~> sonsBisChains : $sonsBisChains : sonsBisDataCreator : $sonsBisDataCreator : sonsBIsPhids : $sonsBIsPhids');
      blog('xxx ~~~> chain1.sons : ${chain1.sons}');
      blog('xxx ~~~> chain2.sons : ${chain2.sons}');
      blog('xxx ~~~> checkChainsSonsAreIdentical - TAMAM KEDA !');
    }

    return _sonsAreIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainsListsAreIdenticalOLDMETHOD({
    @required List<Chain> chains1,
    @required List<Chain> chains2
  }){

    bool _listsAreIdentical = false;

    if (
    Mapper.checkCanLoopList(chains1) == true
        &&
        Mapper.checkCanLoopList(chains2) == true
    ){

      if (chains1.length == chains2.length){

        for (int i = 0; i < chains1.length; i++){

          final bool _twoChainsAreIdentical = checkChainsAreIdentical(
            chain1: chains1[i],
            chain2: chains2[i],
          );


          if (_twoChainsAreIdentical == false){
            final String _areIdentical = _twoChainsAreIdentical ? 'ARE IDENTICAL' : 'ARE NOT IDENTICAL ------------ X OPS X';
            blog('($i : ${chains1[i].id} ) <=> ( ${chains2[i].id} ) : $_areIdentical');
            _listsAreIdentical = false;
            break;
          }
          else {
            _listsAreIdentical = true;
          }

        }

      }

    }

    return _listsAreIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainsListPathsAreIdentical({
    @required List<Chain> chains1,
    @required List<Chain> chains2,
  }){

    final List<String> _pathsA = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: chains1
    );


    final List<String> _pathsB = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: chains2
    );

    final bool _identical = Mapper.checkListsAreIdentical(
        list1: _pathsA,
        list2: _pathsB
    );

    if (_identical == false){
      Stringer.blogStringsListsDifferences(
        strings1: _pathsA,
        strings2: _pathsB,
      );
    }

    return _identical;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainsPathsAreIdentical({
    @required Chain chain1,
    @required Chain chain2,
  }){
    return checkChainsListPathsAreIdentical(
      chains1: [chain1],
      chains2: [chain2],
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainIncludeThisPhid({
    @required Chain chain,
    @required String phid,
  }){
    bool _includes = false;

    if (chain != null && phid != null){

      /// IF ITS CHAIN ID
      if (chain.id == phid){
        _includes = true;
        // blog('boss : chain ${chain.id} includes $phid : $_includes');
      }

      /// IF NOT CHAIN ID SEARCH STRINGS SONS
      else if (checkSonsArePhids(chain.sons) == true){
        _includes = Stringer.checkStringsContainString(
          strings: chain.sons,
          string: phid,
        );
        // blog('boss : chain ${chain.id} STRINGS SONS includes $phid : $_includes');
      }

      /// IF NOT CHAIN ID SEARCH CHAINS SONS
      else if (checkSonsAreChains(chain.sons) == true){
        _includes = checkChainsIncludeThisPhid(
          chains: chain.sons,
          phid: phid,
        );
        // blog('boss : chain ${chain.id} CHAINS SONS includes $phid : $_includes');
      }

    }

    else {
      blog('boss : chain NULL includes $phid : $_includes');
    }

    return _includes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainsIncludeThisPhid({
    @required List<Chain> chains,
    @required String phid,
  }){
    bool _includes = false;

    if (Mapper.checkCanLoopList(chains) == true && phid != null){

      for (final Chain chain in chains){

        final bool _chainIncludes = checkChainIncludeThisPhid(
            chain: chain,
            phid: phid
        );

        if (_chainIncludes == true){
          _includes = true;
          break;
        }

      }

    }

    return _includes;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static String getChainBlogTreeSpacing(int level){

    final String _space =
    level == 0 ? '-->' :
    level == 1 ? '---->' :
    level == 2 ? '------>' :
    level == 3 ? '-------->' :
    level == 4 ? '---------->' :
    level == 5 ? '------------>' :
    level == 6 ? '-------------->' :
    level == 7 ? '---------------->' :
    '---------------->';

    return _space;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void blogChain({
    int level = 0,
  }){

    final String _space = getChainBlogTreeSpacing(level);

    if (id != null){
      if (checkSonsAreDataCreator(sons) == true){
        blog('$_space $level : $id : sonsDataCreator :  ${sons.toString()}');
        // blogChains(sons, level: level + 1);
      }

      else if (checkSonsArePhids(sons) == true){
        blog('$_space $level : $id : <String>${sons.toString()}');
        // blogChains(sons, level: level + 1);
      }

      else if (checkSonsAreChains(sons) == true){
        blog('$_space $level : <Chain>{$id} :-');
        blogChains(sons, parentLevel: level);
      }

      else {
        blog('$_space $level : $id : sons |${sons.runtimeType}| :  ${sons.toString()}');
      }

    }

    else {
      blog('chain is null');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogChains(List<Chain> chains, {int parentLevel = 0}){

    if (Mapper.checkCanLoopList(chains) == true){

      // int _count = 1;
      for (final Chain chain in chains){
        // blog('--- --- --- --- --->>> BLOGGING CHAIN : $_count / ${chains.length} chains');

        chain?.blogChain(level: parentLevel+1);


        // _count++;
      }

    }
    else {
      final String _space = getChainBlogTreeSpacing(parentLevel);
      blog('$_space $parentLevel : NO CHAINS TO BLOG');
    }

  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getOnlyChainSonsIDs({
    @required Chain chain,
  }){

    /// NOTE : THIS GETS IDS OF ONLY "CHAIN SONS" OF THE GIVEN CHAIN
    final List<String> _chainSonsIDs = <String>[];

    if (chain != null && Mapper.checkCanLoopList(chain.sons) == true){

      for (final dynamic son in chain.sons){

        if (son is Chain){
          final Chain _chain = son;
          _chainSonsIDs.add(_chain.id);
        }

      }

    }

    return _chainSonsIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain getChainFromChainsByID({
    @required String chainID,
    @required List<Chain> chains,
  }){
    /// gets first matching "either parent or nested chain" in the input chains trees,

    Chain _chain;

    if (Mapper.checkCanLoopList(chains) == true){


      for (final Chain chain in chains){

        if (chain?.id == chainID){
          _chain = chain;
          break;
        }

        else if (checkSonsAreChains(chain?.sons) == true){

          final Chain _son = getChainFromChainsByID(
            chainID: chainID,
            chains: chain?.sons,
          );

          if (_son != null){
            _chain = _son;
            break;
          }

        }

      }

    }

    return _chain;
  }
  // --------------------
  /// TESTED : WORKS PERFECT FOR [ FlyerTyper.concludeFlyerTypeByChainID() ]
  static String getRootChainIDOfPhid({
    @required List<Chain> allChains,
    @required String phid,
  }){

    String _chainID;

    if (Mapper.checkCanLoopList(allChains) == true && phid != null){

      final List<Chain> _chains = ChainPathConverter.findPhidRelatedChains(
          allChains: allChains,
          phid: phid
      );

      if (Mapper.checkCanLoopList(_chains) == true){

        final Chain _chain = _chains.first;
        _chainID = _chain.id;

      }

    }

    return _chainID;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getOnlyChainsIDsFromPhids({
    @required List<Chain> allChains,
    @required List<String> phids,
  }){
    final List<String> _chainsIDs = <String>[];

    if (
    Mapper.checkCanLoopList(allChains) == true
        &&
        Mapper.checkCanLoopList(phids) == true
    ){

      for (final String phid in phids){

        final String _chainID = getRootChainIDOfPhid(
            allChains: allChains,
            phid: phid
        );

        if (_chainID != null){
          _chainsIDs.add(_chainID);
        }

      }

    }

    return _chainsIDs;
  }
  // --------------------
  static List<Chain> getChainsFromChainsByIDs({
    List<String> phids,
    List<Chain> allChains,
  }){
    final List<Chain> _foundChains = <Chain>[];

    if (
    Mapper.checkCanLoopList(phids) == true
        &&
        Mapper.checkCanLoopList(allChains) == true
    ){

      for (final String id in phids){

        final Chain _chain = getChainFromChainsByID(
            chainID: id,
            chains: allChains
        );

        if (_chain != null){
          _foundChains.add(_chain);
        }

      }

    }

    return _foundChains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getOnlyPhidsSonsFromChain({
    @required Chain chain,
  }){
    final List<String> _phids = <String>[];

    if (chain != null){

      if (checkSonsArePhids(chain.sons) == true){

        _phids.addAll(chain.sons);

      }
      else if (checkSonsAreChains(chain.sons) == true){

        final List<String> _allNestedStrings = getOnlyPhidsSonsFromChains(
          chains: chain.sons,
        );

        _phids.addAll(_allNestedStrings);

      }

    }

    return _phids;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getOnlyPhidsSonsFromChains({
    @required List<Chain> chains,
  }){
    final List<String> _phids = <String>[];

    if (Mapper.checkCanLoopList(chains) == true){

      for (final Chain chain in chains){

        final List<String> _strings = getOnlyPhidsSonsFromChain(
          chain: chain,
        );

        _phids.addAll(_strings);

      }

    }

    return _phids;
  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain addChainsToSonsIfPossible({
    @required List<Chain> chainsToAdd,
    @required Chain chainToTake,
  }){
    Chain _output = chainToTake;

    if (
    Mapper.checkCanLoopList(chainsToAdd) == true
        &&
        chainToTake != null
        &&
        checkSonsAreChains(chainToTake.sons) == true
    ){

      final List<Chain> _newSons = <Chain>[
        ...chainToTake.sons,
        ...chainsToAdd,
      ];

      _output = Chain(
        id: chainToTake.id,
        sons: _newSons,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> removeAllChainIDsFromKeywordsIDs({
    @required List<Chain> allChains,
    @required List<String> phids,
  }){

    /// GET ALL CHAINS IDS
    final List<String> _chainsIDs = getOnlyChainsIDsFromPhids(
      allChains: allChains,
      phids: phids,
    );

    blog('chains IDs are : $_chainsIDs');

    /// REMOVE CHAINS IDS FROM PHIDKS
    final List<String> _cleaned = Stringer.removeStringsFromStrings(
      removeFrom: phids,
      removeThis: _chainsIDs,
    );

    blog('after removing ${_chainsIDs.length} chainsIDs from '
        '${phids.length} input phrases : _cleaned IDs are : $_cleaned');

    return _cleaned;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Chain> updateNode({
    @required BuildContext context,
    @required String oldPhid,
    @required String newPhid,
    @required Chain sourceChain,
  }) async {

    List<String> _modifiedPaths = <String>[];
    // int _numberOfModifiedPaths = 0;
    // final List<String> _pathsContainingOldPhid = ChainPathConverter.findPathsContainingPhid(
    //   phid: oldPhid,
    //   paths: _chainPaths,
    // );

    final List<String> _chainPaths = ChainPathConverter.generateChainPaths(
      chain: sourceChain,
    );

    if (Mapper.checkCanLoopList(_chainPaths)){

      for (int i = 0; i< _chainPaths.length; i++){

        final String _path = _chainPaths[i];

        final bool _pathContainOldPhid = TextCheck.stringContainsSubString(
          string: _path,
          subString: oldPhid,
        );

        /// PATH CONTAINS OLD PHID
        if (_pathContainOldPhid == true){
          final List<String> _nodes = ChainPathConverter.splitPathNodes(_path);

          /// get level / index of the old phid
          final int _index = _nodes.indexOf(oldPhid);

          /// loop in all paths
          if (_index != -1){

            // _numberOfModifiedPaths++;

            // final bool _result = await CenterDialog.showCenterDialog(
            //   context: context,
            //   title: 'Replace ( $oldPhid ) with ( $newPhid ) ?',
            //   body: '${_pathsContainingOldPhid.length} paths has this ID'
            //       '\n${_pathsContainingOldPhid.length - _numberOfModifiedPaths} paths remaining to be modified'
            //       '\npath is : $_path'
            //       '\n${_chainPaths.length} total number of all paths in this chain',
            //   boolDialog: true,
            // );

            // if (_result == true){
            _nodes[_index] = newPhid;
            final String _combinedPath = ChainPathConverter.combinePathNodes(_nodes);

            _modifiedPaths = ChainPathConverter.addPathToPaths(
              paths: _modifiedPaths,
              path: _combinedPath,
            );

            // }
            // else {
            //   _modifiedPaths = ChainPathConverter.addPathToPaths(
            //     paths: _modifiedPaths,
            //     path: _path,
            //   );
            // }

          }

        }

        /// PATH DOES NOT CONTAIN OLD PHID
        else {
          _modifiedPaths = ChainPathConverter.addPathToPaths(
            paths: _modifiedPaths,
            path: _path,
          );
        }

      }

    }

    final List<Chain> _output = ChainPathConverter.createChainsFromPaths(paths: _modifiedPaths);

    return _output?.first;
  }
  // --------------------
  static List<Chain> replaceChainInChains({
    @required List<Chain> chains,
    @required Chain chainToReplace,
    @required String oldChainID,
  }){
    List<Chain> _output = <Chain>[];

    if (Mapper.checkCanLoopList(chains) == true && chainToReplace != null){

      final int _index = chains.indexWhere((chain) => oldChainID == chain.id);

      /// WHEN NO CHAIN TO UPDATE FOUND
      if (_index == -1){
        _output = chains;
      }

      /// WHEN FOUND
      else {
        chains.removeAt(_index);
        chains.insert(_index, chainToReplace);
        _output = <Chain>[...chains];
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain removeAllPhidsNotUsedInThisList({
    @required Chain chain,
    @required List<String> usedPhids,
  }){
    Chain _output;

    if (chain != null){

      _output = Chain(
        id: chain?.id,
        sons: const <dynamic>[],
      );

      if (Mapper.checkCanLoopList(usedPhids) == true){

        final List<Chain> _foundPathsChains = ChainPathConverter.findPhidsRelatedChains(
          allChains: chain.sons,
          phids: usedPhids,
        );

        _output = Chain(
          id: chain.id,
          sons: _foundPathsChains,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain addPathToChain({
    @required Chain chain,
    @required String path,
  }){
    // blog('addPathToChain : START');

    Chain _output = chain;

    if (chain != null && path != null){

      final List<String> _chainPaths = ChainPathConverter.generateChainsPaths(
        parentID: chain.id,
        chains: chain.sons,
      );

      final List<String> _updated = ChainPathConverter.addPathToPaths(
          paths: _chainPaths,
          path: path
      );

      _output = ChainPathConverter.createChainFromPaths(
        chainID: chain.id,
        paths: _updated,
      );

    }

    // blog('addPathToChain : END');
    return _output;
  }
  // --------------------
  /// TEST : WORKS PERFECT
  static Chain removePathFromChain({
    @required Chain chain,
    @required String path,
  }){
    // blog('addPathToChain : START');

    Chain _output = chain;

    if (chain != null && path != null){

      final List<String> _chainPaths = ChainPathConverter.generateChainsPaths(
        parentID: chain.id,
        chains: chain.sons,
      );

      final String _fixedPath = ChainPathConverter.fixPathFormatting(path);

      final List<String> _updated = Stringer.removeStringsFromStrings(
        removeFrom: _chainPaths,
        removeThis: <String>[_fixedPath],
      );

      _output = ChainPathConverter.createChainFromPaths(
        chainID: chain.id,
        paths: _updated,
      );

    }

    // blog('addPathToChain : END');
    return _output;
  }
  // --------------------
  /// TEST : WORKS PERFECT
  static Chain replaceChainPathWithPath({
    @required Chain chain,
    @required String pathToRemove,
    @required String pathToReplace,
  }){
    Chain _output = chain;

    if (
    chain !=null
        &&
        pathToRemove != null
        &&
        pathToReplace != null
        &&
        pathToRemove != pathToReplace
    ){

      final List<String> _chainPaths = ChainPathConverter.generateChainsPaths(
        parentID: chain.id,
        chains: chain.sons,
      );

      /// REMOVE ORIGINAL PATH
      final List<String> _afterRemove = Stringer.removeStringsFromStrings(
        removeFrom: _chainPaths,
        removeThis: <String>[pathToRemove],
      );

      /// INSERT NEW PATH
      final List<String> _afterInsert = Stringer.addStringToListIfDoesNotContainIt(
        strings: _afterRemove,
        stringToAdd: pathToReplace,
      );

      _output = ChainPathConverter.createChainFromPaths(
        chainID: chain.id,
        paths: _afterInsert,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DUMMY

  // --------------------
  /// TEST : WORKS PERFECT
  static Chain dummyChain(){

    return const Chain(
      id: 'dummyx',
      sons: <Chain>[

        Chain(
          id: 'phids_Sons',
          sons: <String>['phidA', 'phidB', 'phidC'],
        ),

        Chain(
          id: 'chains_sons',
          sons: <Chain>[
            Chain(id: 'chainSon', sons: <String>['phid_sonA', 'phid_sonB']),
          ],
        ),

        Chain(
          id: 'DataCreator',
          sons: DataCreator.doubleKeyboard,
        ),

        Chain(
          id: 'phids_Bzzz',
          sons: <String>['phidXX', 'phidYY', 'phidZZ'],
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is Chain){
      _areIdentical = checkChainsPathsAreIdentical(
        chain1: this,
        chain2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      sons.hashCode;
  // -----------------------------------------------------------------------------
}
