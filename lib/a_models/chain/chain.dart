import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/a_models/chain/data_creator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:flutter/material.dart';

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

    void addPathSon({
      @required dynamic son,
      @required bool isLastSonInPath,
    }) {

      // blog('addPathSon : adding son : $son : isLastSonInPath : $isLastSonInPath');

      if (isLastSonInPath == false){
        sons.add(son);
      }

      else {
        final bool _contains = Mapper.stringsContainString(
          strings: Mapper.getStringsFromDynamics(dynamics: sons),
          string: son,
        );
        if (_contains == false){
          sons.add(son);
        }
      }

      // else if (sonsAreDataCreator(sons)){
      //   // do nothing
      // }
      //
      // else {
      //   sons.add(son);
      // }

    }

// -----------------------------------------------------------------------------

  /// CYPHERS

// --------------------------------------------
  Map<String, dynamic> toMap(){
    return
        {
          'id': id,
          'sons': _cipherSons(sons),
        };
  }
// --------------------------------------------
  static dynamic _cipherSons(dynamic sons){
    /// can either be DataCreator or List<String> or List<Chain>
    final bool _sonsAreChains = sonsAreChains(sons);
    final bool _sonsAreString = sonsAreStrings(sons);
    final bool _sonsAreDataCreator = sonsAreDataCreator(sons);

    if (_sonsAreChains == true){
      return cipherChains(sons); // List<Map<String, dynamic>>
    }
    else if (_sonsAreString == true){
      return sons; // List<String>
    }
    else if ( _sonsAreDataCreator == true){
      return cipherDataCreator(sons);
    }
    else {
      return null;
    }

  }
// --------------------------------------------
  static String cipherDataCreator(dynamic sons){
    switch (sons){

      case DataCreator.doubleKeyboard:      return 'DataCreator_doubleKeyboard';      break;
      case DataCreator.doubleSlider:        return 'DataCreator_doubleSlider';        break;
      case DataCreator.doubleRangeSlider:   return 'DataCreator_doubleRangeSlider';   break;

      case DataCreator.integerKeyboard:     return 'DataCreator_integerKeyboard';     break;
      case DataCreator.integerSlider:       return 'DataCreator_integerSlider';       break;
      case DataCreator.integerRangeSlider:  return 'DataCreator_integerRangeSlider';  break;

      case DataCreator.boolSwitch:          return 'DataCreator_boolSwitch';          break;
      default: return null;

    }
  }
// --------------------------------------------
  static DataCreator decipherDataCreator(String string){
    switch (string){
      case 'DataCreator_doubleKeyboard':        return DataCreator.doubleKeyboard;      break;
      case 'DataCreator_doubleSlider':          return DataCreator.doubleSlider;        break;
      case 'DataCreator_doubleRangeSlider':     return DataCreator.doubleRangeSlider;   break;

      case 'DataCreator_integerKeyboard':       return DataCreator.integerKeyboard;     break;
      case 'DataCreator_integerSlider':         return DataCreator.integerSlider;       break;
      case 'DataCreator_integerRangeSlider':    return DataCreator.integerRangeSlider;  break;

      case 'DataCreator_boolSwitch':            return DataCreator.boolSwitch;          break;
      default: return null;
    }
  }
// --------------------------------------------
  static List<Map<String, dynamic>> cipherChains(List<Chain> chains){

    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Mapper.canLoopList(chains) == true){

      for (final Chain chain in chains){
        final Map<String, dynamic> _map = chain.toMap();
        _maps.add(_map);
      }

    }

    return _maps;
  }
// --------------------------------------------
  static Chain decipherChain(Map<String, dynamic> map){
    Chain _chain;

    if (map != null){
      _chain = Chain(
        id: map['id'],
        sons: _decipherSons(map['sons']),
      );
    }

    return _chain;
  }
// --------------------------------------------
  static dynamic _decipherSons(dynamic sons){
    dynamic _output;

    if (sons != null){

      // blog('_decipherSons  : sons type (${sons.runtimeType.toString()}) : son ($sons)');

      /// CHAINS AND STRINGS ARE LIST<dynamic>
      if (sons is List<dynamic>){

        /// FIRST SON IS STRING => SONS ARE STRINGS
        if (sons[0] is String){
          _output = Mapper.getStringsFromDynamics(dynamics: sons);
        }

        /// FIRST SON IS NOT STRING => SONS ARE CHAINS
        else {
        _output = decipherChains(sons);
        }

      }

      /// DATA CREATOR IS STRING
      else if (sons is String){
        final bool _isDataCreator = removeTextAfterFirstSpecialCharacter(sons, '_') == 'DataCreator';
        if (_isDataCreator == true){
          _output = decipherDataCreator(sons);
        }
      }

    }

    return  _output;
  }
// --------------------------------------------
  static List<Chain> decipherChains(List<dynamic> maps){
    final List<Chain> _chains = <Chain>[];

    if (Mapper.canLoopList(maps) == true){

      for (final Map<String, dynamic> map in maps){
        final Chain _chain = decipherChain(map);
        _chains.add(_chain);
      }

    }

    return _chains;
  }
// -----------------------------------------------------------------------------

  /// FILTERS

// --------------------------------------------
  static Chain filterSpecListChainRange({
    @required BuildContext context,
    @required SpecPicker specList,
}) {

    final List<String> _filteredIDs = <String>[];
    Chain _filteredChain = superGetChain(context, specList.chainID);

    if (
        Mapper.canLoopList(_filteredChain.sons)
        &&
        Mapper.canLoopList(specList.range)
    ) {

      final List<String> _rangeIDs = Mapper.getStringsFromDynamics(
        dynamics: specList.range,
      );

      for (final String son in _filteredChain.sons) {

        final bool _rangeContainsThisID = Mapper.stringsContainString(
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

// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool sonsAreChains(dynamic sons){
    bool _areChains = false;

    if (sons.runtimeType.toString() == 'List<Chain>'){
      _areChains = true;
    }

    return _areChains;
  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool sonsAreDataCreator(dynamic sons){

    bool _isDataCreator = false;

    if (sons != null){
      _isDataCreator = sons.runtimeType.toString() == 'DataCreator';
    }

    return _isDataCreator;
  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool sonsAreStrings(dynamic sons){
    final bool _areString = sons.runtimeType.toString() == 'List<String>';
    return _areString;
  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool chainsAreTheSame({
    @required Chain chainA,
    @required Chain chainB,
}){
    bool _areTheSame = false;

    if (chainA !=null && chainB != null){

      if (chainA.id == chainB.id){

        if (chainsSonsAreTheSame(chainA, chainB) == true){
          _areTheSame = true;
        }

      }

    }

    return _areTheSame;
  }
// --------------------------------------------
  static bool chainsSonsAreTheSame(Chain chainA, Chain chainB){

    bool _sonsAreTheSame = false;

    final bool sonsAisChains = sonsAreChains(chainA.sons);
    final bool sonsAisDataCreator = sonsAreDataCreator(chainA.sons);
    final bool sonsAIsStrings = sonsAreStrings(chainA.sons);

    final bool sonsBisChains = sonsAreChains(chainB.sons);
    final bool sonsBisDataCreator = sonsAreDataCreator(chainB.sons);
    final bool sonsBIsStrings = sonsAreStrings(chainB.sons);

    if (
    sonsAisChains == sonsBisChains
    &&
    sonsAisDataCreator == sonsBisDataCreator
    &&
    sonsBIsStrings == sonsAIsStrings
    ){

      /// IF SONS ARE CHAINS
      if (sonsAisChains == true){
        _sonsAreTheSame = chainsListsAreTheSameOLDMETHOD(
          chainsA: chainA.sons,
          chainsB: chainB.sons,
        );
      }

      /// IF SONS ARE STRINGS
      if (sonsAIsStrings == true){
        _sonsAreTheSame = Mapper.listsAreTheSame(
            list1: chainA.sons,
            list2: chainB.sons
        );
      }

      /// IF SONS ARE DATA CREATORS
      if (sonsAisDataCreator == true){
        _sonsAreTheSame = chainA.sons == chainB.sons;
      }

    }

    return _sonsAreTheSame;
  }
// --------------------------------------------
  static bool chainsListsAreTheSameOLDMETHOD({
    @required List<Chain> chainsA,
    @required List<Chain> chainsB
  }){

    bool _listsAreTheSame = false;

    if (
    Mapper.canLoopList(chainsA) == true
    &&
    Mapper.canLoopList(chainsB) == true
    ){

      if (chainsA.length == chainsB.length){

        for (int i = 0; i < chainsA.length; i++){

          final bool _twoChainsAreTheSame = chainsAreTheSame(
              chainA: chainsA[i],
              chainB: chainsB[i],
          );

          final String _areTheSame = _twoChainsAreTheSame ? 'ARE THE SAME' : 'ARE NOT THE SAME ----------------------------------- X OPS X';
          blog('( ${chainsA[i].id} ) <=> ( ${chainsB[i].id} ) : $_areTheSame');

          if (_twoChainsAreTheSame == false){
            _listsAreTheSame = false;
            break;
          }
          else {
            _listsAreTheSame = true;
          }

        }

      }

    }

    return _listsAreTheSame;
  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool chainsListPathsAreTheSame({
    @required List<Chain> chainsA,
    @required List<Chain> chainsB,
}){

      final List<String> _pathsA = ChainPathConverter.generateChainsPaths(
          parentID: '',
          chains: chainsA
      );


      final List<String> _pathsB = ChainPathConverter.generateChainsPaths(
          parentID: '',
          chains: chainsB
      );

      // blog('chains : ${_pathsA.length} <=> originals : ${_pathsB.length}');

      // chainsA[1].blogChain();

      // blogStrings(_pathsA);

      // chainsB[1].blogChain();

      return Mapper.listsAreTheSame(
          list1: _pathsA,
          list2: _pathsB
      );

      // blogStrings(_pathsB);

      // bool _areTheSame = true;

      // if (_pathsA.length == _pathsB.length){
      //
      //    for (int i = 0; i < _pathsA.length; i++){
      //
      //      final String _pathA = _pathsA[i];
      //      final String _pathB = _pathsB[i];
      //
      //      if (_pathA == _pathB){
      //        // _areTheSame = true;
      //        // blog('Path# ( ${i+1} / ${_pathsA.length} ) : are the same');
      //      }
      //      else {
      //        blog('Path# ( ${i+1} / ${_pathsA.length} ) : are NOT the same : ( $_pathA ) != ( $_pathB )');
      //        _areTheSame = false;
      //        // break; /// remove the break if you want to print the above dev blog for all differences
      //      }
      //
      //    }
      //
      // }
      // else {
      //   blog('chainsListPathsAreTheSame : paths A : ${_pathsA.length} != B ${_pathsB.length}');
      //   _areTheSame = false;
      // }

      // return _areTheSame;
  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool chainsPathsAreTheSame({
    @required Chain chainA,
    @required Chain chainB,
}){
      return chainsListPathsAreTheSame(
          chainsA: [chainA],
          chainsB: [chainB],
      );
}
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool chainIncludeThisPhid({
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
      else if (sonsAreStrings(chain.sons) == true){
        _includes = Mapper.stringsContainString(
            strings: chain.sons,
            string: phid,
        );
        // blog('boss : chain ${chain.id} STRINGS SONS includes $phid : $_includes');
      }

      /// IF NOT CHAIN ID SEARCH CHAINS SONS
      else if (sonsAreChains(chain.sons) == true){
        _includes = chainsIncludeThisPhid(
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
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool chainsIncludeThisPhid({
    @required List<Chain> chains,
    @required String phid,
}){
    bool _includes = false;

    if (Mapper.canLoopList(chains) == true && phid != null){

      for (final Chain chain in chains){

        final bool _chainIncludes = chainIncludeThisPhid(
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

// --------------------------------------------
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
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  void blogChain({
  int level = 0,
}){

      final String _space = getChainBlogTreeSpacing(level);

      // blog('sons run type is ${sons.runtimeType}');

    if (id != null){
      if (sonsAreDataCreator(sons)){
        blog('$_space $level : $id : sonsDataCreator :  ${sons.toString()}');
        // blogChains(sons, level: level + 1);
      }

      else if (sonsAreStrings(sons)){
        blog('$_space $level : $id : <String>${sons.toString()}');
        // blogChains(sons, level: level + 1);
      }

      else if (sonsAreChains(sons)){
        blog('$_space $level : $id :-');
        blogChains(sons, parentLevel: level);
      }

      else {
        blog('$_space $level : $id : sons dynamics :  ${sons.toString()}');
      }

    }

    else {
      blog('chain is null');
    }

  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogChains(List<dynamic> chains, {int parentLevel = 0}){



    if (Mapper.canLoopList(chains) == true){

      // int _count = 1;
      for (final dynamic chain in chains){
        // blog('--- --- --- --- --->>> BLOGGING CHAIN : $_count / ${chains.length} chains');
        chain?.blogChain(level: parentLevel+1);
        // _count++;
      }

    }
    else {
      final String _space = getChainBlogTreeSpacing(parentLevel);
      blog('$_space $parentLevel : NOTHING IN CHAINS FOUND');
    }

  }
// -----------------------------------------------------------------------------

  /// GETTERS

// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static Chain getChainFromChainsByID({
    @required String chainID,
    @required List<Chain> chains,
}){
      /// gets first matching "either parent or nested chain" in the input chains trees,

    Chain _chain;

    if (Mapper.canLoopList(chains) == true){

      for (final Chain chain in chains){

        if (chain.id == chainID){
          _chain = chain;
          break;
        }

        else if (sonsAreChains(chain.sons) == true){

          final Chain _son = getChainFromChainsByID(
              chainID: chainID,
              chains: chain.sons,
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
// --------------------------------------------
  static List<String> getOnlyChainsIDsFromPhids({
    @required List<Chain> allChains,
    @required List<String> phids,
}){
    final List<String> _chainsIDs = <String>[];

    if (
    Mapper.canLoopList(allChains) == true
    &&
    Mapper.canLoopList(phids) == true
    ){

      for (final String phid in phids){

        final Chain _chain = getChainFromChainsByID(
            chainID: phid,
            chains: allChains,
        );

        if (_chain != null){
          _chainsIDs.add(_chain.id);
        }

      }

    }

    return _chainsIDs;
  }
// --------------------------------------------
  static List<Chain> getOnlyChainsFromPhids({
    List<String> phids,
    List<Chain> allChains,
  }){
    final List<Chain> _foundChains = <Chain>[];

    if (
    Mapper.canLoopList(phids) == true
        &&
        Mapper.canLoopList(allChains) == true
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
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getOnlyStringsSonsIDsFromChain({
  @required Chain chain,
}){
      final List<String> _stringsIDs = <String>[];

      if (chain != null){

        if (sonsAreStrings(chain.sons) == true){

          _stringsIDs.addAll(chain.sons);

        }
        else if (sonsAreChains(chain.sons) == true){

          final List<String> _allNestedStrings = getOnlyStringsSonsIDsFromChains(
            chains: chain.sons,
          );

          _stringsIDs.addAll(_allNestedStrings);

        }

      }

      return _stringsIDs;
  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> getOnlyStringsSonsIDsFromChains({
  @required List<Chain> chains,
}){
      final List<String> _stringsIDs = <String>[];

      if (Mapper.canLoopList(chains) == true){

        for (final Chain chain in chains){

          final List<String> _strings = getOnlyStringsSonsIDsFromChain(
              chain: chain,
          );

          _stringsIDs.addAll(_strings);

        }

      }

      return _stringsIDs;
  }
// -----------------------------------------------------------------------------

/// MODIFIERS

// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static Chain addChainsToSonsIfPossible({
    @required List<Chain> chainsToAdd,
    @required Chain chainToTake,
  }){
    Chain _output = chainToTake;

    if (
    Mapper.canLoopList(chainsToAdd) == true
    &&
    chainToTake != null
    &&
    sonsAreChains(chainToTake.sons) == true
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
// --------------------------------------------
  static List<String> removeAllChainIDsFromKeywordsIDs({
    @required List<Chain> allChains,
    @required List<String> phidKs,
}){

    /// GET ALL CHAINS IDS
    final List<String> _chainsIDs = getOnlyChainsIDsFromPhids(
        allChains: allChains,
        phids: phidKs,
    );

    blog('chains IDs are : $_chainsIDs');

    /// REMOVE CHAINS IDS FROM PHIDKS
    final List<String> _cleaned = Mapper.removeStringsFromStrings(
      removeFrom: phidKs,
      removeThis: _chainsIDs,
    );

    blog('after removing ${_chainsIDs.length} chainsIDs from '
        '${phidKs.length} input phrases : _cleaned IDs are : $_cleaned');

    return _cleaned;
}
// --------------------------------------------
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

      if (Mapper.canLoopList(_chainPaths)){

        for (int i = 0; i< _chainPaths.length; i++){

          final String _path = _chainPaths[i];

          final bool _pathContainOldPhid = TextChecker.stringContainsSubString(
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
// --------------------------------------------

  static List<Chain> replaceChainInChains({
    @required List<Chain> chains,
    @required Chain chainToReplace,
    @required String oldChainID,
}){
      List<Chain> _output = <Chain>[];

      if (Mapper.canLoopList(chains) == true && chainToReplace != null){

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
// -----------------------------------------------------------------------------
}
