import 'package:bldrs/a_models/chain/data_creator.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_list_model.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/material.dart';

class Chain {
  /// --------------------------------------------------------------------------
  const Chain({
    @required this.id,
    @required this.icon,
    @required this.sons,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String icon;
  final dynamic sons;
// -----------------------------------------------------------------------------

  /// CYPHERS

// --------------------------------------------
  Map<String, dynamic> toMap(){
    return
        {
          'id': id,
          'icon': icon,
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
      return _cipherDataCreator(sons);
    }
    else {
      return null;
    }

  }
// --------------------------------------------
  static String _cipherDataCreator(dynamic sons){
    switch (sons){
      case DataCreator.price:               return 'price';               break;
      case DataCreator.currency:            return 'currency';            break;
      case DataCreator.country:             return 'country';             break;
      case DataCreator.boolSwitch:          return 'boolSwitch';          break;
      case DataCreator.doubleCreator:       return 'doubleCreator';       break;
      case DataCreator.doubleRangeSlider:   return 'doubleRangeSlider';   break;
      case DataCreator.doubleSlider:        return 'doubleSlider';        break;
      case DataCreator.integerIncrementer:  return 'integerIncrementer';  break;
      default: return null;
    }
  }
// --------------------------------------------
  static DataCreator _decipherDataCreator(String string){
    switch (string){
      case 'price':               return DataCreator.price;               break;
      case 'currency':            return DataCreator.currency;            break;
      case 'country':             return DataCreator.country;             break;
      case 'boolSwitch':          return DataCreator.boolSwitch;          break;
      case 'doubleCreator':       return DataCreator.doubleCreator;       break;
      case 'doubleRangeSlider':   return DataCreator.doubleRangeSlider;   break;
      case 'doubleSlider':        return DataCreator.doubleSlider;        break;
      case 'integerIncrementer':  return DataCreator.integerIncrementer;  break;
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
        icon: map['icon'],
        sons: _decipherSons(map['sons']),
      );
    }

    return _chain;
  }
// --------------------------------------------
  static dynamic _decipherSons(dynamic sons){
    dynamic _output;

    if (sons != null){

      if (sons is List<Map<String, dynamic>>){
        _output = decipherChains(sons);
      }
      else if (sons is List<String>){
        _output = Mapper.getStringsFromDynamics(dynamics: sons);
      }
      else if (sons is String){
        _output = _decipherDataCreator(sons);
      }


    }

    return  _output;
  }
// --------------------------------------------
  static List<Chain> decipherChains(List<Map<String, dynamic>> maps){
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
    @required SpecList specList,
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
        icon: _filteredChain.icon,
        sons: _filteredIDs,
      );
    }

    return _filteredChain;
  }
// -----------------------------------------------------------------------------

/// CHECKERS

// --------------------------------------------
  static bool sonsAreChains(dynamic sons){
    final bool _areChains = sons is List<Chain>;
    return _areChains;
  }
// --------------------------------------------
  static bool sonsAreDataCreator(dynamic sons){
    final bool _sonsAreChain = sonsAreChains(sons);
    final bool _sonsAreStrings = sonsAreStrings(sons);
    final bool _areDataCreator = _sonsAreChain == false && _sonsAreStrings == false;
    return _areDataCreator;
  }
// --------------------------------------------
  static bool sonsAreStrings(dynamic sons){
    final bool _areString = sons.runtimeType.toString() == 'List<String>';
    return _areString;
  }
// --------------------------------------------
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

    final bool sonsAisChains = sonsAreChains(chainA);
    final bool sonsAisDataCreator = sonsAreDataCreator(chainA);
    final bool sonsAIsStrings = sonsAreStrings(chainA);

    final bool sonsBisChains = sonsAreChains(chainB);
    final bool sonsBisDataCreator = sonsAreDataCreator(chainB);
    final bool sonsBIsStrings = sonsAreStrings(chainB);

    if (
    sonsAisChains == sonsBisChains
    &&
    sonsAisDataCreator == sonsBisDataCreator
    &&
    sonsBIsStrings == sonsAIsStrings
    ){

      /// IF SONS ARE CHAINS
      if (sonsAisChains == true){
        _sonsAreTheSame = chainsListsAreTheSame(
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
  static bool chainsListsAreTheSame({
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
// -----------------------------------------------------------------------------

  /// BLOGGERS

// --------------------------------------------
  void blogChain(){

    blog('Chain : $id : icon : $icon : sons :  $sons');

  }
// --------------------------------------------
  static void blogChains(List<Chain> chains){

    int _count = 1;
    blog('Blogging ${chains.length} chains ------------------------------------------------ START');
    for (final Chain chain in chains){

      blog('Number : $_count');
      chain.blogChain();
      _count++;
    }
    blog('Blogging ${chains.length} chains ------------------------------------------------ END');
  }
// -----------------------------------------------------------------------------

  /// GETTERS

// --------------------------------------------
  static Chain getChainFromChainsByID({
    @required String chainID,
    @required List<Chain> chains,
}){

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
// -----------------------------------------------------------------------------

/// MODIFIERS

// --------------------------------------------
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
        icon: chainToTake.icon,
        sons: _newSons,
      );

    }

    return _output;
  }
// --------------------------------------------
}
