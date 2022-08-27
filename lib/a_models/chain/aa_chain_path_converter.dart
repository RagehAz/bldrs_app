import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/dd_data_creator.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';

@immutable
class ChainPathConverter {
// -----------------------------------------------------------------------------

  const ChainPathConverter();

// -----------------------------------------------------------------------------

  /// DEBUG BLOGGING

// --------------------------------------------
  static const canBlog = false;
  // --------------------------------------------
  /// TESTED : WORKS PERFECT
  static void _dBlog(String text){
    if (canBlog == true){
      blog(text);
    }
  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static void blogPaths(List<String> paths){

    if (Mapper.checkCanLoopList(paths) == true){
      blog('blogging ${paths.length} paths ---------------- start');

      for (final String string in paths){
        blog('path : [ $string ]');
      }
      blog('blogging paths ------------------------------------ end ');
    }
    else {
      blog('ALERT : paths are empty');
    }

  }
// -----------------------------------------------------------------------------

  /// CREATE CHAINS FROM PATHS

// --------------------------------------------
  /// TEST : WORKS PERFECT
  static Chain createChainFromPaths({
    @required String chainID,
    @required List<String> paths,
  }){

    final List<Chain> _sons = ChainPathConverter.createChainsFromPaths(
      paths: paths,
    );

    final Chain _output = _combineSonsIfChainsIntoOneChain(
      rootChainID: chainID,
      chains: _sons,
    );

    return _output;
  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static Chain createChainFromSinglePath({
    @required String path,
  }) {

    Chain _chain;

    if (Stringer.checkStringIsNotEmpty(path)){
      final List<Chain> chains = createChainsFromPaths(
        paths: <String>[path],
      );

      if (Mapper.checkCanLoopList(chains)){
        _chain = chains.first;
      }
    }

    return _chain;
  }
// -------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Chain> createChainsFromPaths({
  @required List<String> paths,
}) {

    final List<Chain> chains = [];

    _addPathsToChains(
      allChains: chains,
      pathsToAdd: paths,
    );

    _dBlog('finished all ops of addPathsToChains and will print the ( ${chains.length} ) chains now' );

    // Chain.blogChains(chains);

    return chains;
  }
// -------------------------------------------
  /// TESTED : WORKS PERFECT
  static Chain _createNewEmptyChainForPath({
    @required List<String> dividedPath,
  }){

    final Chain _chain = Chain(
      id: dividedPath.first,
      sons: dividedPath.length == 2 ? <String>[dividedPath.last] : <Chain>[],
    );

    return _chain;

  }
// -----------------------------------------------------------------------------

  /// CHAIN MODIFIERS

// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static void _addPathsToChains({
    @required List<Chain> allChains,
    @required List<String> pathsToAdd,
  }){

    for (final String path in pathsToAdd) {

      _addPathToChains(
        allChains: allChains,
        pathToAdd: path,
      );

    }

  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static Chain _combineSonsIfChainsIntoOneChain({
    @required List<Chain> chains,
    @required String rootChainID,
  }){
    Chain _output;

    if (Mapper.checkCanLoopList(chains) == true && rootChainID != null){

      final List<Chain> combinesSons = <Chain>[];

      for (final Chain chain in chains){

        if (Chain.checkSonsAreChains(chain.sons) == true){
          final List<Chain> _chains = chain.sons;
          combinesSons.addAll(_chains);
        }
        else if (chain is Chain){
          combinesSons.add(chain);
        }

      }

      _output = Chain(
        id: rootChainID,
        sons: combinesSons,
      );

    }

    return _output;
  }
// -------------------------------------------
  /// TESTED : WORKS PERFECT
  static void _addPathToChains({
    @required List<Chain> allChains,
    @required String pathToAdd,
  }){

    final List<String> _divided = splitPathNodes(pathToAdd);

    _dBlog('XXX - adding path of ( $pathToAdd )');

    _addDividedPathToAllChains(
      allChains: allChains,
      dividedPath: _divided,
    );

    _dBlog('zzz - added path to chain :-');
    // Chain.blogChains(allChains);

  }
// -------------------------------------------
  /// TESTED : WORKS PERFECT
  static void _addDividedPathToAllChains({
    @required List<Chain> allChains,
    @required List<String> dividedPath,
  }) {

    /// GET ROOT CHAIN IF EXISTED OR NULL IF NOT
    final String _rootChainID = dividedPath.first;
    final Chain _rooChain = _getRootChainFromChains(
      chains: allChains,
      rootChainID: _rootChainID,
    );
    final List<String> _nestedSonsIDs = _getNestedSonsIDsFromDividedPath(
      dividedPath: dividedPath,
    );

    /// ROOT CHAIN FOUND => add nestedSonsIDs to sub tree
    if (_rooChain != null) {

      _dBlog('1 - found chainID ( $_rootChainID )');


      _addNestedSonsIDsToChain(
        parentChain: _rooChain,
        nestedSonsIDs: _nestedSonsIDs,
        level: 1,
      );

      _dBlog('2 - added sons ( $_nestedSonsIDs ) to chainID ( $_rootChainID )');
    }

    /// when not found : doesn't exist => create new root chain then add sons
    else {

      _dBlog('1 - did not find chainID ( $_rootChainID )');

      final Chain _chain = _createNewEmptyChainForPath(
          dividedPath: dividedPath
      );

      /// add new chain
      allChains.add(_chain);

      _dBlog('2 - created new chainID ( ${dividedPath.first} )');

      /// add sons to the new chain just added at the end of the list
      _addNestedSonsIDsToChain(
        parentChain: allChains[allChains.length - 1],
        nestedSonsIDs: _nestedSonsIDs,
        level: 1,
      );

      _dBlog('3 - added sons ( $_nestedSonsIDs ) to chainID ( $_rootChainID )');

    }
  }

// -------------------------------------------
  /// TESTED : WORKS PERFECT
  static void _addNestedSonsIDsToChain({
    @required Chain parentChain, // has sons type defined already
    @required List<String> nestedSonsIDs, // does not include parent chain id
    @required int level,
  }) {

    final String _space = Chain.getChainBlogTreeSpacing(level);

    if (Mapper.checkCanLoopList(nestedSonsIDs) == true && parentChain != null){
      _dBlog('$_space A - starting to add nested sons IDs ( $nestedSonsIDs ) to chainID ( ${parentChain.id} )');

      /// A - CHECK IF PARENT CHAIN HAS THIS SON ID
      final bool _parentChainHasThisSon = _chainSonsIncludeID(
        chain: parentChain,
        sonID: nestedSonsIDs.first,
      );

      _dBlog('$_space B - parent chainID ( ${parentChain.id} ) sons are ( ${parentChain.sons.runtimeType} )');

      /// B - IF SONS ARE DEFINED STRINGS
      if (parentChain.sons is List<String> || Chain.checkSonsAreDataCreator(parentChain.sons) == true){

        /// C - IF STRING IS ALREADY ADDED
        if (_parentChainHasThisSon == true){
          _dBlog('$_space C - chainID ( ${parentChain.id} ) already have this son string ( ${nestedSonsIDs.first} )');
          // DO NOTHING
        }
        /// C - IS STRING IS NOT ADDED
        else {
          _dBlog('$_space C - Adding son string ( ${nestedSonsIDs.first} ) to chainID ( ${parentChain.id} )');
          parentChain.addPathSon(
            son: nestedSonsIDs.first,
            isLastSonInPath: true,
          );
        }

      }

      /// B - IF SONS ARE DEFINED CHAINS
      if (Chain.checkSonsAreChains(parentChain.sons) == true){

        /// C - IF CHAIN HAS THIS SON ADDED
        if (_parentChainHasThisSon == true){
          _dBlog('$_space C - chainID ( ${parentChain.id} ) already have this son chain ( ${nestedSonsIDs.first} )');

          final List<Chain> _parentChainSons = parentChain.sons;
          final Chain _chainOfFirstNestedID = _parentChainSons.firstWhere((chain) => chain.id == nestedSonsIDs.first);

          /// D - ADD REMAINING NESTED IDS IN THIS CHAIN
          _addNestedSonsIDsToChain(
            parentChain: _chainOfFirstNestedID,
            nestedSonsIDs: nestedSonsIDs.sublist(1),
            level: level + 1,
          );

          _dBlog('$_space D - chainID ( ${_chainOfFirstNestedID.id} ) had ( ${nestedSonsIDs.sublist(1)} ) added');
        }

        /// C - IF CHAIN DID HAVE THIS SON ADDED
        else {
          _dBlog('$_space D - chainID ( ${parentChain.id} ) does not have this son chain ( ${nestedSonsIDs.first} )');

          /// D - CREATE NEW EMPTY CHAIN
          final Chain _newNestedChain = _createNewEmptyChainForPath(
            dividedPath: nestedSonsIDs,
          );
          _dBlog('$_space E - created new chainID ( ${nestedSonsIDs.first} )');

          /// E - ADD REMAINING NESTED IDS IN THIS CHAIN
          _addNestedSonsIDsToChain(
            parentChain: _newNestedChain,
            nestedSonsIDs: nestedSonsIDs.sublist(1),
            level: level + 1,
          );
          _dBlog('$_space E - chainID ( ${nestedSonsIDs.first} ) had ( ${nestedSonsIDs.sublist(1)} ) added');

          /// F - ADD REMAINING NESTED IDS IN THIS CHAIN
          parentChain.addPathSon(
            isLastSonInPath: false,
            son: _newNestedChain,
          );
          _dBlog('$_space F - chainID ( ${parentChain.id} ) had ( $_newNestedChain ) added');

        }

      }

    }

  }
// -----------------------------------------------------------------------------

  /// CHAIN / PATHS / NODES GETTERS

// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static Chain _getRootChainFromChains({
    @required List<Chain> chains,
    @required String rootChainID
  }){

    final int index = chains.indexWhere((chain) => chain.id == rootChainID);

    if (index == -1){
      return null;
    }

    else {
      return chains[index];
    }
  }
// -------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> _getNestedSonsIDsFromDividedPath({
    @required List<String> dividedPath,
  }){

    List<String> _output;

    if (Mapper.checkCanLoopList(dividedPath) == true){
      _output = dividedPath.sublist(1);
    }

    return _output;
  }
// -------------------------------------------
  /// TESTED : WORKS PERFECT
  static String getFirstPathNode({
    @required String path
  }){
    /// FIRST PATH NODE IS CHAIN ROOT ID, in this example it's [phid_a] => 'phid_a/phid_b/phid_c'
    final String _cleanedPath = TextMod.removeTextAfterLastSpecialCharacter(path, '/');
    /// => <String>[phid_a, phid_b, phid_c]
    final List<String> _pathNodes = _cleanedPath.split('/');
    /// => phid_c
    return _pathNodes.first;
  }
// -------------------------------------------
  /// TESTED : WORKS PERFECT
  static String getLastPathNode(String path){
    /// LAST PATH NODE IS the FURTHEST FROM ROOT ID, in this example it's [phid_c] => 'phid_a/phid_b/phid_c'

    String _node;

    if (Stringer.checkStringIsNotEmpty(path) == true){

      final String _cleanedPath = TextMod.removeTextAfterLastSpecialCharacter(path, '/');
      final List<String> _pathNodes = _cleanedPath.split('/');
      _node = _pathNodes.last;

    }
    return _node;
  }
// -----------------------------------------------------------------------------

/// CREATE PATHS FROM CHAINS

// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateChainPaths({
    @required Chain chain,
    String previousPath = '', // ...xx/
  }){
    final List<String> _allPaths = <String>[];

    if (chain != null){

      /// CAUTION : DO NO INCLUDE CHAINS IDS PATHS, INCLUDE ONLY SONS PATHS
      // /// CHAIN ID PATH
      // final _chainPath = '$previousPath${chain.id}/';
      // _allPaths.add(_chainPath);

      /// STRINGS SONS PATHS
      if (Chain.checkSonsArePhidsss(chain.sons) == true){

        final List<String> _sons = chain.sons;
        final List<String> _sonsPaths = _generateChainPathsFromPhidsSons(
          parentID: chain.id,
          phids: _sons,
          previousPath: previousPath,
        );
        _allPaths.addAll(_sonsPaths);
      }

      /// CHAINS SONS PATHS
      if (Chain.checkSonsAreChains(chain.sons) == true){

        final List<Chain> _sons = chain.sons;
        final List<String> _sonsPaths = generateChainsPaths(
          parentID: chain.id,
          chains: _sons,
          previousPath: previousPath,
        );
        _allPaths.addAll(_sonsPaths);

      }

      /// DATA CREATOR SONS PATHS
      if (Chain.checkSonsAreDataCreator(chain.sons) == true){

        final DataCreator _sons = Chain.decipherDataCreator(chain.sons);
        final String _dc = Chain.cipherDataCreatorOLD(_sons);
        final String _path = '$previousPath${chain.id}/$_dc/';

        _allPaths.add(_path);

      }

    }

    return _allPaths;
  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateChainsPaths({
    @required String parentID,
    @required List<Chain> chains,
    String previousPath = '', // ...xxx/
  }){
    final List<String> _allPaths = <String>[];

    if (Mapper.checkCanLoopList(chains) == true && parentID != null){

      for (final Chain sonChain in chains){

        final String _parentID = Stringer.checkStringIsEmpty(parentID) ? '' : '$parentID/';

        final List<String> _paths = generateChainPaths(
          chain : sonChain,
          previousPath: '$previousPath$_parentID',
        );

        _allPaths.addAll(_paths);

      }

    }

    final List<String> _cleaned = Stringer.cleanDuplicateStrings(
      strings: _allPaths,
    );

    return _cleaned;
  }
  // --------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> _generateChainPathsFromPhidsSons({
    @required String parentID,
    @required List<String> phids,
    String previousPath = '', // ...xx/
  }){

    final List<String> _paths = <String>[];

    if (Mapper.checkCanLoopList(phids) == true && parentID != null){

      for (final String phid in phids){

        _paths.add('$previousPath$parentID/$phid/');

      }

    }

    return _paths;
  }
// -----------------------------------------------------------------------------

/// PATHS FINDERS

// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> findPathsContainingPhid({
    @required List<String> paths,
    @required String phid,
  }){
    final List<String> _foundPaths = <String>[];

    if (Mapper.checkCanLoopList(paths) && phid != null){

      for (final String path in paths){

        final bool _containsSubString = TextChecker.stringContainsSubString(
          string: path,
          subString: phid,
        );

        if (_containsSubString == true){
          _foundPaths.add(path);
        }

      }

    }

    return _foundPaths;
  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> findPathsContainingPhids({
    @required List<String> paths,
    @required List<String> phids,
}){
    List<String> _output = <String>[];

    if (Mapper.checkCanLoopList(paths) == true && Mapper.checkCanLoopList(phids) == true){

      for (final String phid in phids){

        final List<String> _foundPaths = ChainPathConverter.findPathsContainingPhid(
          paths: paths,
          phid: phid,
        );

        if (Mapper.checkCanLoopList(_foundPaths) == true){
          _output = Stringer.addStringsToStringsIfDoNotContainThem(
              listToTake: _output,
              listToAdd: _foundPaths,
          );
        }

      }

    }

    return _output;
  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Chain> findPhidRelatedChains({
    @required List<Chain> allChains,
    @required String phid,
}){

    final List<String> _allChainsPaths = ChainPathConverter.generateChainsPaths(
      parentID: '',
      chains: allChains,
    );

    /// SEARCH CHAINS FOR MATCH CASES
    final List<String> _foundPaths = ChainPathConverter.findPathsContainingPhid(
        paths: _allChainsPaths,
        phid: phid,
    );

    final List<Chain> _foundPathsChains = ChainPathConverter.createChainsFromPaths(
      paths: _foundPaths,
    );

    return _foundPathsChains;
  }
// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<Chain> findPhidsRelatedChains({
    @required List<Chain> allChains,
    @required List<String> phids,
}){

    final List<String> _allChainsPaths = ChainPathConverter.generateChainsPaths(
      parentID: '',
      chains: allChains,
    );

    final List<String> _foundPaths = ChainPathConverter.findPathsContainingPhids(
      paths: _allChainsPaths,
      phids: phids,
    );

    final List<Chain> _foundPathsChains = ChainPathConverter.createChainsFromPaths(
      paths: _foundPaths,
    );

    return _foundPathsChains;
  }
// -----------------------------------------------------------------------------

/// PATHS MODIFIERS

// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> addPathToPaths({
    @required List<String> paths,
    @required String path,
}){

    final List<String> _output = <String>[...paths];

    if (_output != null && Stringer.checkStringIsNotEmpty(path) == true){

      if (_output.contains(path) == false){
        _output.add(path);
      }

    }

    return _output;
  }
// -------------------------------------------
  /// TESTED : WORKS PERFECT
  static List<String> splitPathNodes(String path){

    List<String> _divisions = <String>[];

    if (Stringer.checkStringIsNotEmpty(path) == true){

      // final String _cleaned = TextMod.removeTextAfterLastSpecialCharacter(path, '/');
      _divisions = path.split('/').toList();
      _divisions.removeWhere((element) => element == '');

    }

    return _divisions;
  }
// -------------------------------------------
  /// TESTED : WORKS PERFECT
  static String combinePathNodes(List<String> nodes){
    String _path = '';

    if (Mapper.checkCanLoopList(nodes) == true){

      for (final String node in nodes){

        _path = _path == '' ? '$node/' : '$_path$node/';

      }

    }

    return _path;
  }
// -----------------------------------------------------------------------------

/// PATH CHECKERS

// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static bool _chainSonsIncludeID({
    @required Chain chain,
    @required String sonID,
  }){
    bool _include = false;

    if (Chain != null && sonID != null){

      /// SONS ARE CHAINS
      if (Chain.checkSonsAreChains(chain.sons) == true){
        final List<Chain> _sonsChains = chain.sons;
        final int _index = _sonsChains.indexWhere((sonChain) => sonChain.id == sonID);
        _include = _index != -1;
      }

      /// SONS ARE PHIDS
      else if (Chain.checkSonsArePhidsss(chain.sons) == true){
        final List<String> _sonsStrings = chain.sons;
        final int _index = _sonsStrings.indexWhere((sonString) => sonString == sonID);
        _include = _index != -1;
      }

      /// SONS ARE DATA CREATOR
      else if (Chain.checkSonsAreDataCreator(chain.sons) == true){
        final DataCreator _dc = Chain.decipherDataCreator(chain.sons);
        final DataCreator _deciphered = Chain.decipherDataCreator(sonID);
        _include = _dc == _deciphered;
      }

    }

    return _include;
  }
// -----------------------------------------------------------------------------

  /// SPECIAL GENERATORS

// --------------------------------------------
  /// TESTED : WORKS PERFECT
  static String generateChainSPathKeyForFirebase({
    @required String path,
  }){

    /// NOTE : WORKS ONLY WITH CHAIN S paths
    // map pair looks like this
    /// style_phid_s_arch_style_arabian : chainS/phid_s_style/phid_s_arch_style_arabian/
    // => '{secondNode_xxx} + {yyy}
    // => key = 'xxx_yyy'

    final String _phid = ChainPathConverter.getLastPathNode(path);
    final List<String> _split = ChainPathConverter.splitPathNodes(path);

    final String _groupLine = _split[_split.length - 2];
    final String group = TextMod.removeTextBeforeLastSpecialCharacter(_groupLine, '_');
    final String _key = '${group}_$_phid';

    return _key;
  }
// -----------------------------------------------------------------------------
/*
  static bool phidIsAChainID({
    @required List<String> paths,
    @required String phid,
}){

    /// when paths include this phid more than once => its a chain
    bool _isChainID = false;

    if (Mapper.canLoopList(paths) && phid != null){

      final List<String> _pathsContainingPhid = findPathsContainingPhid(
          paths: paths,
          phid: phid,
      );

      if (_pathsContainingPhid.length > 1){
        _isChainID = true;
      }

    }

    return _isChainID;
  }

  static Chain insertPathIntoChain({
    @required Chain chain,
    @required String path,
}){

    // final Chain _chain = chain ?? Chain

  }

  static Chain createChainByPath(String path){

    if (stringIsNotEmpty(path) == true){

      final List<String> _divisions = _createPathDivisions(path);

      if (Mapper.canLoopList(_divisions) == true){

        final int _numberOfPhids = _divisions.length;

        for (int i = 0; i< _numberOfPhids; i++){

          final String _id = _divisions[i];

          /// if last phid => the keyword ID
          if (i == _numberOfPhids - 1){
            final List<String> _stringsSons = <String>[_id];
          }

          /// if previouse phids => the chains IDs
          else {

          }

        }

      }

    }


  }

  static Map<String, dynamic> chainMapFromPaths(List<String> paths){
    Map<String, dynamic> _map = {};

    if (Mapper.canLoopList(paths) == true){

      for (final String path in paths){

        final List<String> _phids = _createPathDivisions(path);

        for (int i = 0; i < _phids.length; i++){

          // final int level = i;
          final int _lastIndex = _phids.length - 1;
          final String phid = _phids[i];

          /// if at parents indexes
          // if (i != _lastIndex){

            if (i == 0){
              // cars
              _map[phid] = _lastIndex == 1 ? <String>[_phids[1]] : {};
            }
            else if (i == 1){
              // sports
              _map[_phids[0]][_phids[1]] = _lastIndex == 2 ? <String>[_phids[2]] : {};
            }
            else if (i == 2){
              // ferrari
              _map[_phids[0]][_phids[1]][_phids[2]] = _lastIndex == 3 ? <String>[_phids[3]] : {};
            }
            else if (i == 3){
              // comp - corvette
              _map[_phids[0]][_phids[1]][_phids[2]][_phids[3]] = _lastIndex == 4 ? <String>[_phids[4]] : {};
            }
            else if (i == 4){
              _map[_phids[0]][_phids[1]][_phids[2]][_phids[3]][_phids[4]] = _lastIndex == 5 ? <String>[_phids[5]] : {};
            }
            else if (i == 5){
              _map[_phids[0]][_phids[1]][_phids[2]][_phids[3]][_phids[4]][_phids[5]] = _lastIndex == 6 ? <String>[_phids[6]] : {};
            }


          // }

          // /// if at last index
          // else {
          //
          // }

          /*

          map = {

            }

           */

        }

      }

    }

    return _map;
  }

 */
// -----------------------------------------------------------------------------

/// FIXERS

// --------------------------------------------
  static String fixPathFormatting(String path){

    /// NOTE : GOOD FORMAT SHOULD BE
    // 'chainK/blah_blah/phid/
    /// => no '/' in the beggining
    /// => there MUST '/' in the end

    String _output = path.trim();

    if (Stringer.checkStringIsNotEmpty(path) == true){

      /// REMOVE INITIAL SLASH IS EXISTS
      if (_output[0] == '/'){
        _output = TextMod.removeTextBeforeFirstSpecialCharacter(_output, '/');
      }

      /// REMOVE LAST '//////' IF EXISTS
      int _lastIndex = _output.length - 1;
      if (_output[_lastIndex] == '/'){
          _output = TextMod.removeTextAfterLastSpecialCharacter(_output, '/');
          _output = '$_output/'; // should always keep one last slash
      }

      /// ASSURE LAST SLASH EXISTS
      _lastIndex = _output.length - 1;
      if (_output[_lastIndex] != '/'){
        _output = '$_output/'; // should always keep one last slash
      }

    }

      return _output;
  }
// -----------------------------------------------------------------------------
}
