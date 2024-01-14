import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/pathing.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:basics/helpers/strings/text_check.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/a_models/c_chain/c_picker_model.dart';
import 'package:bldrs/a_models/c_chain/dd_data_creation.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/e_back_end/c_real/foundation/real_paths.dart';
import 'package:flutter/material.dart';

@immutable
class Chain {
  /// --------------------------------------------------------------------------
  const Chain({
    required this.id,
    required this.sons,
  });
  /// --------------------------------------------------------------------------
  final String? id;
  final dynamic sons;
  // -----------------------------------------------------------------------------
  static const bldrsChainsMapID = 'bldrsChains';
  // -----------------------------------------------------------------------------

  /// TESTED : WORKS PERFECT
  void addPathSon({
    required dynamic son,
    required bool isLastSonInPath,
  }) {
    if (isLastSonInPath == false) {
      sons.add(son);
    } else {
      final bool _contains = Stringer.checkStringsContainString(
        strings: Stringer.getStringsFromDynamics(sons),
        string: son,
      );
      if (_contains == false) {
        sons.add(son);
      }
    }
  }
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  Chain copyWith({
    String? id,
    dynamic sons,
  }) {
    return Chain(
      id: id ?? this.id,
      sons: sons ?? this.sons,
    );
  }
  // -----------------------------------------------------------------------------

  /// REAL CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> cipherBldrsChains({
    required List<Chain>? chains,
  }) {
    Map<String, dynamic> _map = {
      'id': bldrsChainsMapID,
    };

    if (Lister.checkCanLoop(chains) == true) {

      final List<String> paths = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: chains,
      );

      // Stringer.blogStrings(strings: paths);

      for (int i = 0; i < paths.length; i++) {
        final String _path = paths[i];

        final String _key = Phider.generatePhidPathUniqueKey(
          path: _path,
        );
        // final String _pathWithPhidIndex =

        /// THIS KEY IS UNIQUE
        if (_map[_key] == null) {
          _map = Mapper.insertPairInMap(
            map: _map,
            key: _key,
            value: _path,
            overrideExisting: true,
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
  /// TESTED : WORKS PERFECT
  static List<Chain>? decipherBldrsChains({
    required Map<String, dynamic>? map,
  }) {
    List<Chain>? _bldrsChains;

    if (map != null) {
      final List<dynamic> _dynamicsValues = map.values.toList();
      _dynamicsValues.remove(RealColl.bldrsChains);

      final List<String> _paths = Stringer.getStringsFromDynamics(_dynamicsValues,);

      _bldrsChains = ChainPathConverter.createChainsFromPaths(
        paths: Phider.removePathsIndexes(_paths),
      );
    }

    return _bldrsChains;
  }
  // -----------------------------------------------------------------------------

  /// OLD FIRE CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMapOLD() {
    return {
      'id': id,
      'sons': _cipherSonsOLD(sons),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static dynamic _cipherSonsOLD(dynamic sons) {
    /// can either be DataCreator or List<String> or List<Chain>
    final bool _sonsAreChains = checkIsChains(sons);
    final bool _sonsArePhids = Phider.checkIsPhids(sons);
    final bool _sonsAreDataCreator = DataCreation.checkIsDataCreator(sons);

    if (_sonsAreChains == true) {
      return cipherChainsOLD(sons); // List<Map<String, dynamic>>
    }

    else if (_sonsArePhids == true) {
      return sons; // List<String>
    }

    else if (_sonsAreDataCreator == true) {
      return DataCreation.cipherDataCreator(sons);
    }

    else {
      return null;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Map<String, dynamic>> cipherChainsOLD(List<Chain>? chains) {
    final List<Map<String, dynamic>> _maps = <Map<String, dynamic>>[];

    if (Lister.checkCanLoop(chains) == true) {
      for (final Chain chain in chains!) {
        final Map<String, dynamic> _map = chain.toMapOLD();
        _maps.add(_map);
      }
    }

    return _maps;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain? decipherChainOLD(Map<String, dynamic>? map) {
    Chain? _chain;

    if (map != null) {
      _chain = Chain(
        id: map['id'],
        sons: _decipherSonsOLD(map['sons']),
      );
    }

    return _chain;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static dynamic _decipherSonsOLD(dynamic sons) {
    dynamic _output;

    if (sons != null) {
      // blog('_decipherSons  : sons type (${sons.runtimeType.toString()}) : son ($sons)');

      /// CHAINS AND STRINGS ARE LIST<dynamic>
      if (sons is List<dynamic>) {
        /// FIRST SON IS STRING => SONS ARE STRINGS
        if (sons[0] is String) {
          _output = Stringer.getStringsFromDynamics(sons);
        }

        /// FIRST SON IS NOT STRING => SONS ARE CHAINS
        else {
          _output = decipherChainsOLD(sons);
        }
      }

      /// DATA CREATOR IS STRING
      else if (sons is String) {

        final String? _text = TextMod.removeTextAfterFirstSpecialCharacter(
            text: sons,
            specialCharacter: '_',
        );

        final bool _isDataCreator = _text == 'DataCreator';

        if (_isDataCreator == true) {
          _output = DataCreation.decipherDataCreator(sons);
        }

      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Chain> decipherChainsOLD(List<dynamic>? maps) {
    final List<Chain> _chains = <Chain>[];

    if (Lister.checkCanLoop(maps) == true) {
      for (final Map<String, dynamic> map in maps!) {
        final Chain? _chain = decipherChainOLD(map);
        if (_chain != null){
          _chains.add(_chain);
        }
      }
    }

    return _chains;
  }
  // -----------------------------------------------------------------------------

  /// FILTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain? filterSpecPickerChainRange({
    required PickerModel? picker,
    required bool onlyUseZoneChains,
  }) {
    final List<String> _filteredIDs = <String>[];

    Chain? _filteredChain = ChainsProvider.proFindChainByID(
      chainID: picker?.chainID,
      onlyUseZoneChains: onlyUseZoneChains,
    );

    if (
        Lister.checkCanLoop(_filteredChain?.sons) == true
        &&
        Lister.checkCanLoop(picker?.range) == true
    ) {

      final List<String> _rangeIDs = Stringer.getStringsFromDynamics(picker?.range);

      for (final String son in _filteredChain!.sons) {
        final bool _rangeContainsThisID = Stringer.checkStringsContainString(
              strings: _rangeIDs,
              string: son,
            ) ==
            true;

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
  static bool checkIsChains(dynamic sons) {
    bool _areChains = false;

    if (sons.runtimeType.toString() == 'List<Chain>') {
      _areChains = true;
    }

    else if (
        sons is List<Chain>
        ||
        sons is List<Chain?>
        ||
        sons is List<Chain>?
        ||
        sons is List<Chain?>?
    ){
      _areChains = true;
    }

    else if (ObjectCheck.objectIsMinified(sons) == true){
      if (sons is List && sons.isNotEmpty == true){
        final List<dynamic> dynamics = sons;
        if (dynamics[0] is Chain){
          _areChains = true;
        }
      }
    }

    return _areChains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainsAreIdentical({
    required Chain? chain1,
    required Chain? chain2,
    bool blogDifferences = false,
  }) {
    bool _areIdentical = false;

    if (chain1 != null && chain2 != null) {
      if (chain1.id == chain2.id) {
        final bool _chainsSonsAreIdentical = checkChainsSonsAreIdentical(
          chain1: chain1,
          chain2: chain2,
          blogDifferences: blogDifferences,
        );

        if (_chainsSonsAreIdentical == true) {
          _areIdentical = true;
        }
      }
    }

    return _areIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainsSonsAreIdentical({
    required Chain? chain1,
    required Chain? chain2,
    bool blogDifferences = false,
  }) {
    bool _sonsAreIdentical = false;

    final bool sonsAisChains = checkIsChains(chain1?.sons);
    final bool sonsAisDataCreator = DataCreation.checkIsDataCreator(chain1?.sons);
    final bool sonsAisPhids = Phider.checkIsPhids(chain1?.sons);

    final bool sonsBisChains = checkIsChains(chain2?.sons);
    final bool sonsBisDataCreator = DataCreation.checkIsDataCreator(chain2?.sons);
    final bool sonsBIsPhids = Phider.checkIsPhids(chain2?.sons);

    if (sonsAisChains == sonsBisChains &&
        sonsAisDataCreator == sonsBisDataCreator &&
        sonsBIsPhids == sonsAisPhids) {
      /// IF SONS ARE CHAINS
      if (sonsAisChains == true) {
        _sonsAreIdentical = checkChainsListsAreIdentical(
          chains1: chain1?.sons,
          chains2: chain2?.sons,
        );
      }

      /// IF SONS ARE PHIDS
      if (sonsAisPhids == true) {
        _sonsAreIdentical = Lister.checkListsAreIdentical(list1: chain1?.sons, list2: chain2?.sons);
      }

      /// IF SONS ARE DATA CREATORS
      if (sonsAisDataCreator == true) {
        _sonsAreIdentical = chain1?.sons?.toString() == chain2?.sons?.toString();
      }
    }

    if (_sonsAreIdentical == false && blogDifferences == true) {
      blog('xxx ~~~> checkChainsSonsAreIdentical : TAKE CARE : _sonsAreIdentical : $_sonsAreIdentical');
      blog('xxx ~~~> sonsAisChains : $sonsAisChains : sonsAisDataCreator : $sonsAisDataCreator : sonsAisPhids : $sonsAisPhids');
      blog('xxx ~~~> sonsBisChains : $sonsBisChains : sonsBisDataCreator : $sonsBisDataCreator : sonsBIsPhids : $sonsBIsPhids');
      blog('xxx ~~~> chain1.sons : ${chain1?.sons}');
      blog('xxx ~~~> chain2.sons : ${chain2?.sons}');
      blog('xxx ~~~> checkChainsSonsAreIdentical - TAMAM KEDA !');
    }

    return _sonsAreIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainsListsAreIdentical({
    required List<Chain>? chains1,
    required List<Chain>? chains2,
    bool blogDifferences = false,
  }) {
    bool _listsAreIdentical = false;

    if (Lister.checkCanLoop(chains1) == true && Lister.checkCanLoop(chains2) == true) {
      if (chains1!.length == chains2!.length) {
        blog('checkChainsListsAreIdentical : chains1.length (${chains1.length}) == chains2.length (${chains2.length})');

        for (int i = 0; i < chains1.length; i++) {
          final bool _twoChainsAreIdentical = checkChainsAreIdentical(
            chain1: chains1[i],
            chain2: chains2[i],
          );

          if (_twoChainsAreIdentical == false) {
            final String _areIdentical = _twoChainsAreIdentical ? 'ARE IDENTICAL' : 'ARE NOT IDENTICAL ------------ X OPS X';
            blog('($i : ${chains1[i].id} ) <=> ( ${chains2[i].id} ) : $_areIdentical');
            _listsAreIdentical = false;
            break;
          } else {
            _listsAreIdentical = true;
          }
        }
      }
    }

    if (_listsAreIdentical == false && blogDifferences == true) {
      blogChainsDifferences(
        chains1: chains1,
        chains2: chains2,
      );
    }

    return _listsAreIdentical;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainsListPathsAreIdentical({
    required List<Chain>? chains1,
    required List<Chain>? chains2,
    bool blogDifferences = true,
  }) {
    final List<String> _pathsA = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: chains1,
    );

    final List<String> _pathsB = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: chains2,
    );

    // Stringer.blogStrings(strings: _pathsA, invoker: '_pathsA');
    // Stringer.blogStrings(strings: _pathsB, invoker: '_pathsB');
    // blog('checkChainsListPathsAreIdentical : _pathsA.length (${_pathsA.length}) == _pathsB.length (${_pathsB.length})');

    final bool _identical = Lister.checkListsAreIdentical(
      list1: _pathsA,
      list2: _pathsB,
    );

    if (_identical == false && blogDifferences == true) {
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
    required Chain chain1,
    required Chain chain2,
  }) {
    return checkChainsListPathsAreIdentical(
      chains1: [chain1],
      chains2: [chain2],
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainIncludeThisPhid({
    required Chain? chain,
    required String? phid,
  }) {
    bool _includes = false;

    if (chain != null && phid != null) {
      /// IF ITS CHAIN ID
      if (Phider.removeIndexFromPhid(phid: chain.id) == Phider.removeIndexFromPhid(phid: phid)) {
        _includes = true;
        // blog('boss : chain ${chain.id} includes $phid : $_includes');
      }

      /// IF NOT CHAIN ID SEARCH STRINGS SONS
      else if (Phider.checkIsPhids(chain.sons) == true) {
        _includes = Stringer.checkStringsContainString(
          strings: Phider.removePhidsIndexes(chain.sons),
          string: Phider.removeIndexFromPhid(phid: phid),
        );
        // blog('boss : chain ${chain.id} STRINGS SONS includes $phid : $_includes');
      }

      /// IF NOT CHAIN ID SEARCH CHAINS SONS
      else if (checkIsChains(chain.sons) == true) {
        _includes = checkChainsIncludeThisPhid(
          chains: chain.sons,
          phid: Phider.removeIndexFromPhid(phid: phid),
        );
        // blog('boss : chain ${chain.id} CHAINS SONS includes $phid : $_includes');
      }
    } else {
      blog('boss : chain NULL includes $phid : $_includes');
    }

    return _includes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkChainsIncludeThisPhid({
    required List<Chain>? chains,
    required String? phid,
  }) {
    bool _includes = false;

    if (Lister.checkCanLoop(chains) == true && phid != null) {
      for (final Chain chain in chains!) {
        final bool _chainIncludes = checkChainIncludeThisPhid(
            chain: chain,
            phid: Phider.removeIndexFromPhid(phid: phid),
        );

        if (_chainIncludes == true) {
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
  static String getChainBlogTreeSpacing(int level) {
    final String _space = level == 0
        ? '-->'
        : level == 1
            ? '---->'
            : level == 2
                ? '------>'
                : level == 3
                    ? '-------->'
                    : level == 4
                        ? '---------->'
                        : level == 5
                            ? '------------>'
                            : level == 6
                                ? '-------------->'
                                : level == 7
                                    ? '---------------->'
                                    : '---------------->';

    return _space;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void blogChain({
    int level = 0,
  }) {
    final String _space = getChainBlogTreeSpacing(level);

    if (id != null) {
      if (DataCreation.checkIsDataCreator(sons) == true) {
        blog('$_space $level : $id : sonsDataCreator :  $sons');
        // blogChains(sons, level: level + 1);
      } else if (Phider.checkIsPhids(sons) == true) {
        blog('$_space $level : $id : <Phid>$sons');
        // blogChains(sons, level: level + 1);
      } else if (checkIsChains(sons) == true) {
        blog('$_space $level : <Chain>{$id} :-');
        blogChains(sons, level: level);
      } else {
        blog('$_space $level : $id : sons |${sons.runtimeType}| :  $sons');
      }
    } else {
      blog('chain is null');
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogChains(List<Chain>? chains, {int level = 0}) {
    if (Lister.checkCanLoop(chains) == true) {
      // int _count = 1;
      for (final Chain chain in chains!) {
        // blog('--- --- --- --- --->>> BLOGGING CHAIN : $_count / ${chains.length} chains');

        chain.blogChain(level: level + 1);

        // _count++;
      }
    } else {
      final String _space = getChainBlogTreeSpacing(level);
      blog('$_space $level : NO CHAINS TO BLOG');
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogChainsPaths(List<Chain> chains) {
    if (Lister.checkCanLoop(chains) == true) {

      final List<String> _paths = ChainPathConverter.generateChainsPaths(
          parentID: '',
          chains: chains,
      );

      Pathing.blogPaths(_paths);
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogChainsDifferences({
    required List<Chain>? chains1,
    required List<Chain>? chains2,
    String? invoker,
  }) {
    blog('blogChainsDifferences : $invoker :  START');

    if (chains1 == null) {
      blog('--> chains1 is null');
    }
    if (chains1 != null && chains1.isEmpty == true) {
      blog('--> chains1 is empty');
    }
    if (chains2 == null) {
      blog('--> chains2 is null');
    }
    if (chains2 != null && chains2.isEmpty == true) {
      blog('--> chains2 is empty');
    }
    if (Lister.checkCanLoop(chains1) == true && Lister.checkCanLoop(chains2) == true) {
      if (chains1!.length != chains2!.length) {
        blog('--> chains1.length (${chains1.length}) != chains2.length (${chains2.length})');
      }

      for (int i = 0; i < chains1.length; i++) {
        final bool _twoChainsAreIdentical = checkChainsAreIdentical(
          chain1: chains1[i],
          chain2: chains2[i],
        );

        if (_twoChainsAreIdentical == false) {
          final String _areIdentical =
              _twoChainsAreIdentical ? 'ARE IDENTICAL' : 'ARE NOT IDENTICAL ------------ X OPS X';
          blog('($i : ${chains1[i].id} ) <=> ( ${chains2[i].id} ) : $_areIdentical');
        }
      }
    }

    blog('blogChainsDifferences : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogChainsPathsDifferences({
    required List<Chain> chains1,
    required List<Chain> chains2,
  }) {

    final List<String> _paths1 = ChainPathConverter.generateChainsPaths(
            parentID: '',
            chains: chains1,
        );

    final List<String> _paths2 = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: chains2,
    );

    Stringer.blogStringsListsDifferences(
      strings1: _paths1,
      strings2: _paths2,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogSon(dynamic son) {
    final bool _isChain = son is Chain;
    final bool _isChains = Chain.checkIsChains(son);
    final bool _isPhid = Phider.checkIsPhid(son);
    final bool _isPhids = Phider.checkIsPhids(son);
    final bool _isDataCreator = DataCreation.checkIsDataCreator(son);

    /// BLOGGING
    if (_isChains) {
      final List<Chain> chains = son;
      blog('Chains : ${chains.length} chains');
    } else if (_isChain) {
      final Chain chain = son;
      blog('chain : ${chain.id}');
    } else if (_isPhids) {
      final List<String> _phids = son;
      blog('Phids : $_phids');
    } else if (_isPhid) {
      final String phid = son;
      blog('Phid : $phid');
    } else if (_isDataCreator) {
      final DataCreator dataCreator = son;
      blog('DataCreator : $dataCreator');
    }
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT (mirrored_in_keyworder)
  static List<String> getChainsRootsIDs(List<Chain>? chains) {
    final List<String> chainsIDs = <String>[];

    if (Lister.checkCanLoop(chains) == true) {
      for (final Chain chain in chains!) {
        if (chain.id != null){
          chainsIDs.add(chain.id!);
        }
      }
    }

    return chainsIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getChainSonsIDs({
    required Chain? chain,
  }) {
    /// NOTE : THIS GETS IDS OF ONLY "CHAIN SONS" OF THE GIVEN CHAIN
    final List<String> _chainSonsIDs = <String>[];

    if (chain != null && Lister.checkCanLoop(chain.sons) == true) {
      for (final dynamic son in chain.sons) {
        if (son is Chain) {
          final Chain _chain = son;
          if (_chain.id != null){
            _chainSonsIDs.add(_chain.id!);
          }
        }
      }
    }

    return _chainSonsIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getChainsRootsAndSonsIDs(List<Chain>? chains){
    List<String> _output = [];

    if (Lister.checkCanLoop(chains) == true){

      final List<String> _paths = ChainPathConverter.generateChainsPaths(
          parentID: '',
          chains: chains
      );

      if (Lister.checkCanLoop(_paths) == true){

        for (final path in _paths){

          final List<String> _nodes = Pathing.splitPathNodes(path);

          _output = Stringer.addStringsToStringsIfDoNotContainThem(
              listToTake: _output,
              listToAdd: _nodes,
          );

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain? getChainFromChainsByID({
    required String? chainID,
    required List<Chain>? chains,
  }) {
    /// gets first matching "either parent or nested chain" in the input chains trees,

    Chain? _chain;

    if (Lister.checkCanLoop(chains) == true) {
      for (final Chain chain in chains!) {

        if (Phider.removeIndexFromPhid(phid: chain.id) == Phider.removeIndexFromPhid(phid: chainID)
        ) {
          _chain = chain;
          break;
        }

        else if (checkIsChains(chain.sons) == true) {
          final Chain? _son = getChainFromChainsByID(
            chainID: Phider.removeIndexFromPhid(phid: chainID),
            chains: chain.sons,
          );

          if (_son != null) {
            _chain = _son;
            break;
          }
        }
      }
    }

    return _chain;
  }
  // --------------------
  /// TESTED : WORKS PERFECT FOR [ FlyerTyper.concludeFlyerTypeByChainID() ] (mirrored_in_keyworder)
  static String? getRootChainIDOfPhid({
    required List<Chain>? allChains,
    required String? phid,
  }) {
    String? _chainID;

    if (Lister.checkCanLoop(allChains) == true && phid != null) {

      final List<Chain> _chains = ChainPathConverter.findPhidRelatedChains(
          chains: allChains,
          phid: phid,
      );

      if (Lister.checkCanLoop(_chains) == true) {
        final Chain _chain = _chains.first;
        _chainID = _chain.id;
      }
    }

    return _chainID;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getOnlyChainsIDsFromPhids({
    required List<Chain>? allChains,
    required List<String>? phids,
  }) {
    final List<String> _chainsIDs = <String>[];

    if (Lister.checkCanLoop(allChains) == true && Lister.checkCanLoop(phids) == true) {
      for (final String phid in phids!) {
        final String? _chainID = getRootChainIDOfPhid(allChains: allChains, phid: phid);

        if (_chainID != null) {
          _chainsIDs.add(_chainID);
        }
      }
    }

    return _chainsIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Chain> getChainsFromChainsByIDs({
    List<String>? phids,
    List<Chain>? allChains,
  }) {
    final List<Chain> _foundChains = <Chain>[];

    if (Lister.checkCanLoop(phids) == true && Lister.checkCanLoop(allChains) == true) {
      for (final String id in phids!) {

        final Chain? _chain = getChainFromChainsByID(
            chainID: id,
            chains: allChains,
        );

        if (_chain != null) {
          _foundChains.add(_chain);
        }
      }
    }

    return _foundChains;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> getOnlyPhidsSonsFromChain({
    required Chain? chain,
  }) {
    final List<String> _phids = <String>[];

    if (chain != null) {

      if (Phider.checkIsPhids(chain.sons) == true) {
        _phids.addAll(chain.sons);
      }

      else if (checkIsChains(chain.sons) == true) {
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
    required List<Chain> chains,
  }) {
    final List<String> _phids = <String>[];

    if (Lister.checkCanLoop(chains) == true) {
      for (final Chain chain in chains) {
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
  static Chain? addChainsToSonsIfPossible({
    required List<Chain>? chainsToAdd,
    required Chain? chainToTake,
  }) {
    Chain? _output = chainToTake;

    if (
        Lister.checkCanLoop(chainsToAdd) == true
        &&
        chainToTake != null
        &&
        checkIsChains(chainToTake.sons) == true
    ) {
      final List<Chain> _newSons = <Chain>[
        ...chainToTake.sons,
        ...chainsToAdd!,
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
    required List<Chain> allChains,
    required List<String> phids,
  }) {
    /// GET ALL CHAINS IDS
    final List<String> _chainsIDs = getOnlyChainsIDsFromPhids(
      allChains: allChains,
      phids: phids,
    );

    blog('chains IDs are : $_chainsIDs');

    /// REMOVE CHAINS IDS FROM PHIDKS
    final List<String> _cleaned = Stringer.removeStringsFromStrings(
      removeFrom: Phider.removePhidsIndexes(phids),
      removeThis: Phider.removePhidsIndexes(_chainsIDs),
    );

    blog('after removing ${_chainsIDs.length} chainsIDs from '
        '${phids.length} input phrases : _cleaned IDs are : $_cleaned');

    return _cleaned;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Chain?> updateNode({
    required BuildContext context,
    required String oldPhid,
    required String newPhid,
    required Chain sourceChain,
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

    if (Lister.checkCanLoop(_chainPaths)) {
      for (int i = 0; i < _chainPaths.length; i++) {
        final String _path = _chainPaths[i];

        final bool _pathContainOldPhid = TextCheck.stringContainsSubString(
          string: _path,
          subString: oldPhid,
        );

        /// PATH CONTAINS OLD PHID
        if (_pathContainOldPhid == true) {
          final List<String> _nodes = Pathing.splitPathNodes(_path);

          /// get level / index of the old phid
          final int _index = _nodes.indexOf(oldPhid);

          /// loop in all paths
          if (_index != -1) {
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
            final String _combinedPath = Pathing.combinePathNodes(_nodes);

            _modifiedPaths = Pathing.addPathToPaths(
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
          _modifiedPaths = Pathing.addPathToPaths(
            paths: _modifiedPaths,
            path: _path,
          );
        }
      }
    }

    final List<Chain> _output = ChainPathConverter.createChainsFromPaths(paths: _modifiedPaths);

    return Lister.checkCanLoop(_output) == true ? _output.first : null;
  }
  // --------------------
  /// TASK : TEST ME
  static List<Chain> replaceChainInChains({
    required List<Chain>? chains,
    required Chain? chainToReplace,
  }) {
    List<Chain> _output = <Chain>[];

    if (Lister.checkCanLoop(chains) == true && chainToReplace != null) {

      final int _index = chains!.indexWhere((chain) => chainToReplace.id == chain.id);

      /// WHEN NO CHAIN TO UPDATE FOUND
      if (_index == -1) {
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
  /// TASK : TEST ME
  static List<Chain>? removeAllPhidsNotUsedInThisList({
    required List<Chain>? chains,
    required List<String>? usedPhids,
  }) {
    List<Chain>? _output;

    if (chains != null) {
      if (Lister.checkCanLoop(usedPhids) == true) {
        final List<Chain> _foundPathsChains = ChainPathConverter.findPhidsRelatedChains(
          chains: chains,
          phids: usedPhids,
        );

        _output = _foundPathsChains;
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain? addPathToChain({
    required Chain? chain,
    required String? path,
  }) {
    // blog('addPathToChain : START');

    Chain? _output = chain;

    if (chain != null && path != null) {
      final List<String> _chainPaths = ChainPathConverter.generateChainsPaths(
        parentID: chain.id,
        chains: chain.sons,
      );

      final List<String> _updated = Pathing.addPathToPaths(
          paths: _chainPaths,
          path: path,
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
  /// TASK : TEST ME
  static List<Chain>? addPathToChains({
    required List<Chain>? chains,
    required String? path,
  }) {
    blog('addPathToChains : START');

    List<Chain>? _output = chains;

    // blog('addPathToChains : _output.length : ${_output?.length}');

    if (chains != null && path != null) {
      final List<String> _chainPaths = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: chains,
      );

      // blog('addPathToChains : _chainPaths.length : ${_chainPaths.length}');

      final List<String> _updated = Pathing.addPathToPaths(
          paths: _chainPaths,
          path: path,
      );

      // blog('addPathToChains : _updated.length : ${_updated.length}');

      _output = ChainPathConverter.createChainsFromPaths(
        paths: _updated,
      );

      // blog('addPathToChains : _output.length : ${_output.length}');

    }

    // blog('addPathToChains : _output.length : ${_output.length}');

    blog('addPathToChains : END');
    return _output;
  }
  // --------------------
  /// TASK : TEST ME
  static List<Chain>? addPathsToChains({
    required List<Chain>? chains,
    required List<String>? paths,
  }) {
    List<Chain>? _output = <Chain>[];

    if (Lister.checkCanLoop(chains) == true) {
      _output = chains;

      if (Lister.checkCanLoop(paths) == true) {
        for (final String path in paths!) {
          _output = addPathToChains(
            chains: chains,
            path: path,
          );
        }
      }
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain? removePathFromChain({
    required Chain? chain,
    required String? path,
  }) {
    // blog('addPathToChain : START');

    Chain? _output = chain;

    if (chain != null && path != null) {
      final List<String> _chainPaths = ChainPathConverter.generateChainsPaths(
        parentID: chain.id,
        chains: chain.sons,
      );

      final String? _fixedPath = Pathing.fixPathFormatting(path);

      final List<String> _updated = Stringer.removeStringsFromStrings(
        removeFrom: _chainPaths,
        removeThis: _fixedPath == null ? [] : <String>[_fixedPath],
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
  /// TESTED : WORKS PERFECT
  static List<Chain>? removePathFromChains({
    required List<Chain>? chains,
    required String? path,
  }) {
    // blog('addPathToChain : START');

    List<Chain>? _output = chains;

    if (Lister.checkCanLoop(chains) == true && path != null) {
      final List<String> _chainsPaths = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: chains,
      );

      final String? _fixedPath = Pathing.fixPathFormatting(path);

      final List<String> _updated = Stringer.removeStringsFromStrings(
        removeFrom: _chainsPaths,
        removeThis: _fixedPath == null ? [] : <String>[_fixedPath],
      );

      _output = ChainPathConverter.createChainsFromPaths(
        paths: _updated,
      );
    }

    // blog('addPathToChain : END');
    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Chain>? removePathsFromChains({
    required List<Chain>? chains,
    required List<String>? paths,
  }) {
    List<Chain>? _chains = chains;

    if (Lister.checkCanLoop(_chains) == true && Lister.checkCanLoop(paths) == true) {
      for (final String path in paths!) {
        _chains = removePathFromChains(
            chains: _chains,
            path: path,
        );
      }
    }

    return _chains;
  }
  // --------------------
  /// TEST : WORKS PERFECT
  static Chain? replaceChainPathWithPath({
    required Chain? chain,
    required String? pathToRemove,
    required String? pathToReplace,
  }) {
    Chain? _output = chain;

    if (chain != null &&
        pathToRemove != null &&
        pathToReplace != null &&
        pathToRemove != pathToReplace) {

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
  // --------------------
  /// TASK : TEST ME
  static List<Chain>? replaceChainsPathWithPath({
    required List<Chain>? chains,
    required String? pathToRemove,
    required String? pathToReplace,
  }) {
    List<Chain>? _output = chains;

    if (Lister.checkCanLoop(chains) == true &&
        pathToRemove != null &&
        pathToReplace != null &&
        pathToRemove != pathToReplace) {
      final List<String> _chainPaths = ChainPathConverter.generateChainsPaths(
        parentID: '',
        chains: chains,
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

      _output = ChainPathConverter.createChainsFromPaths(
        paths: _afterInsert,
      );
    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// DUMMY

  // --------------------
  /// TEST : WORKS PERFECT
  static Chain dummyChain() {
    return const Chain(
      id: 'dummyx',
      sons: <Chain>[
        Chain(
          id: 'phid_A',
          sons: <String>['phid_A0', 'phid_A2', 'phid_A1'],
        ),

        Chain(
          id: 'phid_B',
          sons: <Chain>[
            Chain(
              id: 'phid_BB0',
              sons: <String>['phid_BB00', 'phid_BB01'],
            ),
            Chain(
              id: 'phid_BB1',
              sons: <String>['phid_BB10', 'phid_BB11'],
            ),
            Chain(
              id: 'phid_BB2',
              sons: <String>['phid_BB20', 'phid_BB21', 'phid_BB22'],
            ),
          ],
        ),

        Chain(
          id: 'phid_C',
          sons: <String>['phid_C2', 'phid_C0', 'phid_C1'],
        ),

        // Chain(
        //   id: 'DataCreator',
        //   sons: DataCreator.doubleKeyboard,
        // ),
        //
        // Chain(
        //   id: 'sons strings keda test',
        //   sons: <String>['phidXX', 'phidYY', 'phidZZ'],
        // ),
      ],
    );
  }
  // -----------------------------------------------------------------------------

  /// SORTING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Chain? sortChainAlphabetically({
    required Chain? chain,
  }) {
    Chain? _output = chain;

    if (chain != null && chain.sons != null) {

      final dynamic sons = chain.sons;
      final bool _sonsAreChains = checkIsChains(sons);
      final bool _sonsArePhids = Phider.checkIsPhids(sons);
      final bool _sonsAreDataCreator = DataCreation.checkIsDataCreator(sons);

      if (_sonsAreChains == true) {
        final List<Chain> _newSons = sortChainsAlphabetically(
          chains: sons,
        );
        _output = Chain(
          id: chain.id,
          sons: _newSons,
        );
      }

      else if (_sonsArePhids == true) {
        _output = Chain(id: chain.id, sons: Phider.sortPhidsAlphabetically(
          phids: sons,
        ));
      }

      else if (_sonsAreDataCreator == true) {
        _output = chain;
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Chain> sortChainsAlphabetically({
    required List<Chain>? chains,
  }) {
    final List<Chain> _output = <Chain>[];

    if (Lister.checkCanLoop(chains) == true){

      List<String> _ids = getChainsRootsIDs(chains);
      _ids = Phider.sortPhidsAlphabetically(
        phids: _ids,
      );

      for (final String id in _ids){

        Chain? _chain = getChainFromChainsByID(
            chainID: id,
            chains: chains
        );

        _chain = sortChainAlphabetically(
          chain: _chain,
        );

        if (_chain != null){
          _output.add(_chain);
        }

      }

    }

    return _output;
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
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is Chain) {
      _areIdentical = checkChainsPathsAreIdentical(
        chain1: this,
        chain2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode => id.hashCode ^ sons.hashCode;
  // -----------------------------------------------------------------------------
}

/// DEPRECATED
/*
  // --------------------
  static Map<String, dynamic> cipherBigChainK({
    required Chain chainK,
  }){

    final List<String> chainKPaths = ChainPathConverter.generateChainsPaths(
      parentID: '',
      chains: chainK.sons,
    );

    Map<String, dynamic> _map = {};

    if (Lister.checkCanLoop(chainKPaths) == true){

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
  /// DEPRECATED
  static Chain decipherBigChainK({
    required Map<String, dynamic> bigChainKMap,
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
  /// DEPRECATED
  static Map<String, dynamic> cipherBigChainS({
    required Chain chainS,
  }){

    /// NOTE : CHAIN S HAS DUPLICATE LAST NODES IN THEIR PATHS

    final List<String> chainSPaths = ChainPathConverter.generateChainsPaths(
      parentID: '',
      chains: chainS.sons,
    );

    Map<String, dynamic> _map = {};

    if (Lister.checkCanLoop(chainSPaths) == true){

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
    required Map<String, dynamic> bigChainSMap,
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

 */
