import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:flutter/material.dart';
// import 'package:dart_application_1/dart_application_1.dart' as dart_application_1;

const List<String> carsPaths = <String>[
  'cars/sport/ferrari/Competizione/',
  'cars/sport/ferrari/Monza/',
  'cars/sport/chevrolet/corvette',
  'cars/4wheel/jeep/wrangler/',
  'cars/4wheel/hummer/h2/',
  'cars/4wheel/hummer/h3/',
  'bikes/race/honda/honda/',
  'bikes/cruiser/harley/sportster/',
];
//
const Map _hashMap = {
  'cars': {
    'sports' : {
      'ferrari' : ['Competizione'],
      'chevrolet' : ['corvette'],
    },
    '4wheel' : {
      'jeep' : ['wrangler'],
      'hummer' : ['h2', 'h3'],
    },
  },
  'bikes': {
    'race' : {
      'honda': ['honda'],
    },
    'cruiser' : {
      'harley' : ['sportster'],
    }
  },
};
//
// const List<Tree> trees = <Tree>[
//   Tree(id: 'cars', subTree: <Tree>[
//     Tree(id: 'sport', subTree: <Tree>[
//       Tree(id: 'ferrari', subTree: <String>['Competizione', 'Monza',],),
//       Tree(id: 'chevrolet', subTree: <String>['corvette'],)
//     ],
//     ),
//     Tree(id: '4wheel', subTree: <Tree>[
//       Tree(id: 'jeep', subTree: <String>['wrangler'],),
//       Tree(id: 'hummer', subTree: <String>['h2','h3'],),
//     ],
//     ),
//   ],
//   ),
//   Tree(id: 'bikes', subTree: <Tree>[
//     Tree(id: 'race', subTree: <Tree>[
//       Tree(id: 'honda', subTree: <String>['cbr']),
//     ],
//     ),
//     Tree(id: 'cruiser', subTree: <Tree>[
//       Tree(id: 'harley', subTree: <String>['sportster']),
//     ],
//     ),
//   ],
//   ),
// ];
//
// class Tree {
//
//   const Tree({
//     @required this.id,
//     @required this.subTree,
// });
//
//   final String id;
//   final List<dynamic> subTree;
//
//   List<Tree> generateTreesFromPaths(List<String> paths){
//     // MAGICAL CODE GOES HERE TO GENERATE THE TREES...
//
//     final Map<String, dynamic> _bigMap = {};
//
//
//
//     final List<Tree> _subTrees = <Tree>[];
//     return _subTrees;
//   }
// }


void khaled() {

  final List<Chain> chains = [];

  addPathsToChains(
    allChains: chains,
    pathsToAdd: carsPaths,
  );

  blog('finished all ops of addPathsToChains and will print the ( ${chains.length} ) chains now' );

  Chain.blogChains(chains);

}
// -------------------------------------------
void addPathsToChains({
  @required List<Chain> allChains,
  @required List<String> pathsToAdd,
}){

  for (final String path in pathsToAdd) {

    addPathToChains(
      allChains: allChains,
      pathToAdd: path,
    );

  }

}
// -------------------------------------------
void addPathToChains({
@required List<Chain> allChains,
@required String pathToAdd,
}){

  final List<String> divided = pathToAdd.split('/');
  divided.removeWhere((element) => element == '');

  blog('XXX - adding path of ( $pathToAdd )');

  addDividedPathToAllChains(
    allChains: allChains,
    dividedPath: divided,
  );

  blog('zzz - added path to chain :-');
  Chain.blogChains(allChains);

}
// -------------------------------------------
Chain getRootChainFromAllChains({
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
List<String> getNestedSonsIDsFromDividedPath({
  @required List<String> dividedPath,
}){

  List<String> _output;

  if (Mapper.canLoopList(dividedPath) == true){
    _output = dividedPath.sublist(1);
  }

  return _output;
}
// -------------------------------------------
Chain createNewEmptyChainForPath({
  @required List<String> dividedPath,
}){

  final Chain _chain = Chain(
    id: dividedPath.first,
    icon: null,
    sons: dividedPath.length == 2 ? <String>[dividedPath.last] : <Chain>[],
  );

  return _chain;

}
// -------------------------------------------
void addDividedPathToAllChains({
  @required List<Chain> allChains,
  @required List<String> dividedPath,
}) {

  /// GET ROOT CHAIN IF EXISTED OR NULL IF NOT
  final String _rootChainID = dividedPath.first;
  final Chain _rooChain = getRootChainFromAllChains(
      chains: allChains,
      rootChainID: _rootChainID,
  );
  final List<String> _nestedSonsIDs = getNestedSonsIDsFromDividedPath(
    dividedPath: dividedPath,
  );

  /// ROOT CHAIN FOUND => add nestedSonsIDs to sub tree
  if (_rooChain != null) {

    blog('1 - found chainID ( $_rootChainID )');


    addNestedSonsIDsToChain(
      parentChain: _rooChain,
      nestedSonsIDs: _nestedSonsIDs,
      level: 1,
    );

    blog('2 - added sons ( $_nestedSonsIDs ) to chainID ( $_rootChainID )');
  }

  /// when not found : doesn't exist => create new root chain then add sons
  else {

    blog('1 - did not find chainID ( $_rootChainID )');

    final Chain _chain = createNewEmptyChainForPath(
        dividedPath: dividedPath
    );

    /// add new chain
    allChains.add(_chain);

    blog('2 - created new chainID ( ${dividedPath.first} )');

    /// add sons to the new chain just added at the end of the list
    addNestedSonsIDsToChain(
      parentChain: allChains[allChains.length - 1],
      nestedSonsIDs: _nestedSonsIDs,
      level: 1,
    );

    blog('3 - added sons ( $_nestedSonsIDs ) to chainID ( $_rootChainID )');

  }
}
// -------------------------------------------
bool chainSonsIncludeID({
  @required Chain chain,
  @required String sonID,
}){
  bool _include = false;

  if (Chain != null && sonID != null){

    if (Chain.sonsAreChains(chain.sons) == true){
      final List<Chain> _sonsChains = chain.sons;
      final int _index = _sonsChains.indexWhere((sonChain) => sonChain.id == sonID);
      _include = _index != -1;
    }
    else if (Chain.sonsAreStrings(chain.sons) == true){
      final List<String> _sonsStrings = chain.sons;
      final int _index = _sonsStrings.indexWhere((sonString) => sonString == sonID);
      _include = _index != -1;
    }
    else if (Chain.sonsAreDataCreator(chain.sons) == true){
      _include = chain.sons == sonID;
    }

  }

  return _include;
}
// -------------------------------------------
void addNestedSonsIDsToChain({
  @required Chain parentChain, // has sons type defined already
  @required List<String> nestedSonsIDs, // does not include parent chain id
  @required int level,
}) {

  final String _space = Chain.getChainBlogTreeSpacing(level);

  if (Mapper.canLoopList(nestedSonsIDs) == true && parentChain != null){
    blog('$_space A - starting to add nested sons IDs ( $nestedSonsIDs ) to chainID ( ${parentChain.id} )');

    /// A - CHECK IF PARENT CHAIN HAS THIS SON ID
    final bool _parentChainHasThisSon = chainSonsIncludeID(
      chain: parentChain,
      sonID: nestedSonsIDs.first,
    );
    // blog('$_space B - parent chainID ( ${parentChain.id} ) ${_parentChainHasThisSon? 'has' : 'does not have'} This Son ( ${nestedSonsIDs.first} )');
    blog('$_space B - parent chainID ( ${parentChain.id} ) sons are ( ${parentChain.sons.runtimeType} )');

    /// B - IF SONS ARE DEFINED STRINGS
    if (Chain.sonsAreStrings(parentChain.sons) == true){

      /// C - IF STRING IS ALREADY ADDED
      if (_parentChainHasThisSon == true){
        blog('$_space C - chainID ( ${parentChain.id} ) already have this son string ( ${nestedSonsIDs.first} )');
        // DO NOTHING
      }
      /// C - IS STRING IS NOT ADDED
      else {
        blog('$_space C - Adding son string ( ${nestedSonsIDs.first} ) to chainID ( ${parentChain.id} )');
        parentChain.addPathSon(
            son: nestedSonsIDs.first,
            isLastSonInPath: true,
        );
      }

    }

    /// B - IF SONS ARE DEFINED CHAINS
    if (Chain.sonsAreChains(parentChain.sons) == true){

      /// C - IF CHAIN HAS THIS SON ADDED
      if (_parentChainHasThisSon == true){
        blog('$_space C - chainID ( ${parentChain.id} ) already have this son chain ( ${nestedSonsIDs.first} )');

        final List<Chain> _parentChainSons = parentChain.sons;
        final Chain _chainOfFirstNestedID = _parentChainSons.firstWhere((chain) => chain.id == nestedSonsIDs.first);

        /// D - ADD REMAINING NESTED IDS IN THIS CHAIN
        addNestedSonsIDsToChain(
          parentChain: _chainOfFirstNestedID,
          nestedSonsIDs: nestedSonsIDs.sublist(1),
          level: level + 1,
        );

        blog('$_space D - chainID ( ${_chainOfFirstNestedID.id} ) had ( ${nestedSonsIDs.sublist(1)} ) added');
      }

      /// C - IF CHAIN DID HAVE THIS SON ADDED
      else {
        blog('$_space D - chainID ( ${parentChain.id} ) does not have this son chain ( ${nestedSonsIDs.first} )');

        /// D - CREATE NEW EMPTY CHAIN
        final Chain _newNestedChain = createNewEmptyChainForPath(
            dividedPath: nestedSonsIDs,
        );
        blog('$_space E - created new chainID ( ${nestedSonsIDs.first} )');

        /// E - ADD REMAINING NESTED IDS IN THIS CHAIN
        addNestedSonsIDsToChain(
          parentChain: _newNestedChain,
          nestedSonsIDs: nestedSonsIDs.sublist(1),
          level: level + 1,
        );
        blog('$_space E - chainID ( ${nestedSonsIDs.first} ) had ( ${nestedSonsIDs.sublist(1)} ) added');

        /// F - ADD REMAINING NESTED IDS IN THIS CHAIN
        parentChain.addPathSon(
          isLastSonInPath: false,
          son: _newNestedChain,
        );
        blog('$_space F - chainID ( ${parentChain.id} ) had ( $_newNestedChain ) added');

      }

    }






    // /// subTree root
    // dynamic  _sonToAdd;
    // _sonToAdd = nestedSonsIDs.length != 1 ?
    // Chain(
    //   id: nestedSonsIDs?.first,
    //   icon: null,
    //   sons: nestedSonsIDs.length == 2 ? <String>[nestedSonsIDs?.last] : <Chain>[],
    // )
    //     :
    // null
    // ;

    // blog('$_space C - created son to add ( $_sonToAdd ) of type ( ${_sonToAdd.runtimeType} )');
    //
    // /// SON EXISTS => add remaining nested Ids to that chain
    // if (_parentChainHasThisSon == true){
    //   blog('$_space D - found ${nestedSonsIDs?.first} in sons of chainID ( ${parentChain.id} )');
    //
    //   addNestedSonsIDsToChain(
    //     parentChain: nestedSonsIDs.length != 1 ? _sonToAdd : parentChain,
    //     nestedSonsIDs: nestedSonsIDs.length != 1 ? nestedSonsIDs.sublist(1) : _sonToAdd,
    //     level: level + 1,
    //   );
    //
    //   blog('$_space E - added sons ${nestedSonsIDs.sublist(1)} to chain ');
    // }
    //
    // /// SON DOES NOT EXIST => CREATE NEW SON AND ADD IT
    // else {
    //   blog('$_space D - did not find son ( ${nestedSonsIDs.first} )  in chainID ( ${parentChain.id} )');
    //
    //   addNestedSonsIDsToChain(
    //     parentChain: nestedSonsIDs.length != 1 ? _sonToAdd : parentChain,
    //     nestedSonsIDs: nestedSonsIDs.length != 1 ? nestedSonsIDs.sublist(1) : _sonToAdd,
    //     level: level + 1,
    //   );
    //   blog('$_space F - added sons ( ${nestedSonsIDs.sublist(1)} ) to chainID ( ${nestedSonsIDs?.first} )');
    //
    //   parentChain.addPathSon(
    //     isLastSonInPath: false,
    //     son: _sonToAdd,
    //   );
    //   blog('$_space G - added chainID ( ${nestedSonsIDs?.first} ) to ( ${parentChain.id} )');
    //
    // }

    // / the first son doesn't exist => we add a new [ChainSon or stings] from this node to the end of the list
    // if (index == -1) {
    //
    //   // if (nestedSonsIDs.length != 1){
    //     blog('$_space E - ${nestedSonsIDs.length} sons remaining to add under chainID ( ${parentChain.id} )');
    //
    //
    //
    //
    //
    //   // }
    //
    //   // /// adding last word the subTree to root
    //   // else {
    //   //   blog('D - only this ( ${nestedSonsIDs.first} )  is remaining to add to chainID ( ${parentChain.id} )');
    //   //   _sonToAdd = nestedSonsIDs?.first;
    //   //   blog('E - assigned string ( ${nestedSonsIDs.first} ) to be added to sons');
    //   //   parentChain.addPathSon(
    //   //     isLastSonInPath: true,
    //   //     son: _sonToAdd,
    //   //   );
    //   //   blog('F - added string ( $_sonToAdd ) to chainID ( ${_sonToAdd.id} )');
    //   // }
    //
    //
    //   // final dynamic  _add = nestedSonsIDs.length == 1 ? nestedSonsIDs?.first : followedNestedChain;
    //   //   parentChain.addSon(_sonToAdd);
    //
    //   // for (int i = 1; i < nestedSonsIDs.length; i++) {
    //   //   head.sons.add(
    //   //       Chain(
    //   //         id: nestedSonsIDs[i],
    //   //         icon: null,
    //   //         sons: [],
    //   //       )
    //   //   );
    //   // followedNestedChain = followedNestedChain.sons.last;
    //
    //   }


  }

  }
// -------------------------------------------

/*
/// check if Parent chain already has the root of subTree
/// example:
/// *you added at first
///  cars
///    |
///  sport
///    |
///  ferrari
///    |
///  Comp
///
///  now you want to add
///  'cars/sport/ferrari/Monza/'
///  now n is cars ,and subTree is [sport,ferrari,Monza]
///  so you check if subTree already has node sport so you don't add it twice
///  if it has it call the function recursively this time your root (Tree n) is sport and subTree is [ferrari,Monza]
///  check again sport already has ferrari so you call the function recursively now root (Tree n) is ferrari and subTree is [Monza]
///  now ferrari doesn't has Monza so you add it now after the second path the tree is like this
///  cars
///    |
///  sport
///    |
///  ferrari
///    |   |
///  Comp  Monza
 */
