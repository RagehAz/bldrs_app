import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
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

  List<Chain> chains = [];

  addPathsToChains(
    allChains: chains,
  );

  Chain.blogChains(chains);

}

void addPathsToChains({
  @required List<Chain> allChains,
}){

  const List<String> paths = [
    'cars/sport/ferrari/Competizione/',
    'cars/sport/ferrari/Monza/',
    'cars/sport/chevrolet/corvette',
    'cars/4wheel/jeep/wrangler/',
    'cars/4wheel/hummer/h2/',
    'cars/4wheel/hummer/h3/',
    'bikes/race/honda/cbr/',
    'bikes/cruiser/harley/sportster/',
  ];

  for (final String path in paths) {

    final List<String> divided = path.split('/');
    divided.removeWhere((element) => element == '');

    blog('adding path of [ $path ]');

    addDividedPathToAllChains(
      allChains: allChains,
      chainID: divided[0], /// first phid
      nestedSonsIDs: divided.sublist(1), /// remaining IDs without the first
    );

  }

}

void addDividedPathToAllChains({
  @required List<Chain> allChains,
  @required String chainID,
  @required List<String> nestedSonsIDs
}) {

  // 'cars/sport/ferrari/Competizione/',


  /// check if root chain ID already exists
  final int index = allChains.indexWhere((chain) => chain.id == chainID);

  /// when found : then add nestedSonsIDs to sub tree
  if (index != -1) {
    blog('found $chainID');
    addChainSons(
      parentChain: allChains[index],
      nestedSonsIDs: nestedSonsIDs,
    );
    blog('added $chainID sons : $nestedSonsIDs');
  }

  /// when not found : doesn't exist => create new root chain then add sons
  else {

    blog('did not find [ $chainID ]');

    // final bool _lastPhidRemaining = nestedSonsIDs.length == 1;

    /// add new chain
    allChains.add(
        Chain(
          id: chainID,
          icon: null,
          sons: <Chain>[],
        )
    );

    blog('added $chainID');

    /// add sons to the new chain just added at the end of the list
    addChainSons(
      parentChain: allChains[allChains.length - 1],
      nestedSonsIDs: nestedSonsIDs,
    );

    blog('created $chainID son : $nestedSonsIDs');

  }
}

void addChainSons({
  @required Chain parentChain,
  @required List<String> nestedSonsIDs
}) {

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

  blog('adding sons $nestedSonsIDs to ${parentChain.id}');

  if (canLoopList(nestedSonsIDs) == true){

    /// get index of the son in parent chain sons
    final int index = parentChain.sons.indexWhere((son){
      if (son is String){
        return son == nestedSonsIDs.first;
      }
      else if (son is Chain){
        return son.id == nestedSonsIDs.first;
      }
    });

    /// the first son doesn't exist => we add a new [ChainSon or stings] from this node to the end of the list
    if (index == -1) {

      blog('did not find ${nestedSonsIDs?.first} in sons');

      //subTree root
      final Chain followedNestedChain = Chain(
        id: nestedSonsIDs?.first,
        icon: null,
        sons:  <Chain>[],
      );

      blog('created sub chain ${nestedSonsIDs?.first}');

      addChainSons(
          parentChain: followedNestedChain,
          nestedSonsIDs: nestedSonsIDs.sublist(1),
        );

      blog('added sons ${nestedSonsIDs.sublist(1)} to chain ${followedNestedChain.id}');

      /// adding the subTree to root
        parentChain.addSon(followedNestedChain);


      // for (int i = 1; i < nestedSonsIDs.length; i++) {
      //   head.sons.add(
      //       Chain(
      //         id: nestedSonsIDs[i],
      //         icon: null,
      //         sons: [],
      //       )
      //   );
      // followedNestedChain = followedNestedChain.sons.last;
      }

    /// son already exists in parentChain => add remaining sons to it
    else {
      blog('found ${nestedSonsIDs?.first} in sons');
      addChainSons(
            parentChain: parentChain.sons[index],
            nestedSonsIDs: nestedSonsIDs.sublist(1)
        );
      blog('added sons ${nestedSonsIDs.sublist(1)} to chain ${parentChain.sons[index].id}');
    }

  }

  }



// class ChainInstance {
//
//   final List<Chain> _chaingz = [];
//
//
//
//   void blogChainz() {
//     Chaing.blogChaingz(_chaingz);
//   }
//
// }

// class Chaing {
//
//   Chaing({
//     @required this.id,
//   });
//
//   String id = "";
//   List<Chaing> sons = [];
//
//   void addChild(Chaing child) {
//     sons.add(child);
//   }
//
//   void blogChaing(){
//     blog('CHAIN id : $id and sons are :-');
//     for (final Chaing chaing in sons){
//       chaing.blogChaing();
//     }
//     blog('CHAIN BLOG -------------------------- END');
//   }
//
//   static blogChaingz(List<Chaing> chaings){
//     for (final Chaing chaing in chaings){
//       chaing.blogChaing();
//     }
//   }
// }
