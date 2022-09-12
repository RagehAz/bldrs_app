import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/sliders.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/old_editor/old_chain_methods/chain_fire_ops.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
Future<void> onAddMoreSpecsChainsToExistingSpecsChains({
  @required BuildContext context,
  @required List<Chain> chainsToAdd,
}) async {

  if (Mapper.checkCanLoopList(chainsToAdd) == true){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    await ChainFireOpsOLD.addChainsToSpecsChainSons(
      context: context,
      chainsToAdd: chainsToAdd,
    );

    await _chainsProvider.reInitializeAllChains(context);

  }

}
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> onBackupAllChains(BuildContext context) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    boolDialog: true,
    titleVerse:  'Back up All Chains ?',
    bodyVerse:  'Please confirm',
  );

  if (_result == true){
    await ChainFireOpsOLD.backupChainsOps(context);
  }

}
// -----------------------------------------------------------------------------
Future<void> onUploadChains() async {

  // final Chain _keywordsChain = _chainsProvider.keywordsChain;
  // final Chain _specsChain = _chainsProvider.specsChain;

  // final Chain _keywordsChain = await ChainOps.readKeywordsChain(context);

  // _keywordsChain?.blogChain();
  //
  // final List<Chain> _newSpecsChains = <Chain>[
  //   propertySalePrice,
  //   propertyRentPrice,
  //   propertyDecorationStyle,
  //   designType,
  //   projectCost,
  //   constructionDuration,
  // ];
  //
  // await onAddMoreSpecsChainsToExistingSpecsChains(
  //   context: context,
  //   chainsToAdd: _newSpecsChains,
  // );


  // return 'b';
}
// -----------------------------------------------------------------------------
Future<void> onSearchChains({
  @required String text,
  @required ValueNotifier<String> searchValue,
  @required ValueNotifier<bool> isSearching,
  @required List<Chain> allChains,
  @required ValueNotifier<List<Chain>> foundChains,
}) async {

  searchValue.value = text;

  TextCheck.triggerIsSearchingNotifier(
    text: text,
    isSearching: isSearching,

  );

  blog('text is : $text : isSearching : ${isSearching.value}');

  if (isSearching.value == true){
    _searchChainsOps(
      chains: allChains,
      text: text,
      foundChains: foundChains,
    );
  }

}
// -----------------------------------------------------------------------------
void _searchChainsOps({
  @required List<Chain> chains,
  @required String text,
  @required ValueNotifier<List<Chain>> foundChains,
}){

  final List<Chain> _foundPathsChains = ChainPathConverter.findPhidRelatedChains(
    chains: chains,
    phid: text,
  );

  /// SET FOUND CHAINS AS SEARCH RESULT
  foundChains.value = _foundPathsChains;

}
// -----------------------------------------------------------------------------
Future<void> onUpdateNode({
  @required BuildContext context,
  @required String path,
  @required List<Chain> chains,
  @required ValueNotifier<List<Chain>> chainsNotifier,
  // @required List<Chain> oldChains,
  @required String newPhid,
  @required PageController pageController,
  @required ValueNotifier<String> searchValue,
  @required ValueNotifier<bool> isSearching,
  @required TextEditingController searchController,
  @required ValueNotifier<List<Chain>> foundChains,
}) async {

  Keyboard.closeKeyboard(context);

  if (TextCheck.isEmpty(newPhid) == true){
    blog('new phid value is empty man');
  }

  else {

    final String _phid = ChainPathConverter.getLastPathNode(path);

    // blog('onUpdateNode : updating ( $newPhid ) instead of ( $_phid ) : in path ( $path )');

    final String _rootChainID = ChainPathConverter.getFirstPathNode(
      path: path,
    );

    final Chain _chain = Chain.getChainFromChainsByID(
      chainID: _rootChainID,
      chains: chains,
    );

    // _chain.blogChain();
    // blog('onUpdateNode : creating new chain with this ( $newPhid )');

    final Chain _newChain = await Chain.updateNode(
      context: context,
      oldPhid: _phid,
      newPhid: newPhid,
      sourceChain: _chain,
    );

    // _newChain.blogChain();
    // blog('lineeeeeeeeeeeeeeeeeeeeeeeeeee-------------------');

    final List<Chain> _newChains = Chain.replaceChainInChains(
      chains: chains,
      chainToReplace: Chain(
        id: _rootChainID,
        sons: _newChain,
      ),
    );

    chainsNotifier.value = _newChains;

    await Sliders.slideToBackFrom(
      pageController: pageController,
      currentSlide: 1,
    );

    searchController.text = newPhid;
    await onSearchChains(
        text: newPhid,
        searchValue: searchValue,
        isSearching: isSearching,
        allChains: chains,
        foundChains: foundChains
    );

  }

}
// -----------------------------------------------------------------------------
Future<void> onSync({
  @required BuildContext context,
  @required List<Chain> originalChains,
  @required List<Chain> updatedChains,
}) async {

  // final bool _chainsListsAreTheSame = Chain.checkChainsListPathsAreIdentical(
  //   chains1: originalChains,
  //   chains2: updatedChains,
  // );
  //
  // /// WHEN THERE ARE NO CHANGES
  // if (_chainsListsAreTheSame == true){
  //
  //   await TopDialog.showTopDialog(
  //     context: context,
  //     firstLine: 'Chains were not modified',
  //     secondLine: 'No Sync required',
  //   );
  //
  // }
  //
  // /// WHEN A CHAIN NODE CHANGED
  // else {
  //
  //   final bool _result = await CenterDialog.showCenterDialog(
  //     context: context,
  //     titleVerse:  'Sync Chains to DB ?',
  //     bodyVerse:  'This will check which Chain was modified and automatically update it on database',
  //     boolDialog: true,
  //   );
  //
  //   if (_result == true){
  //
  //     for (int i = 0; i < updatedChains.length; i++){
  //
  //       final Chain _updatedChain = updatedChains[i];
  //       final Chain _originalChain = originalChains[i];
  //       final bool _chainsAreTheSame = Chain.checkChainsPathsAreIdentical(
  //           chain1: _updatedChain,
  //           chain2: _originalChain
  //       );
  //
  //       if (_chainsAreTheSame == false){
  //
  //         /// IF KEYWORDS CHAIN
  //         if (chainIsKeywordsChain(_updatedChain) == true){
  //           await _updateKeywordsChainOps(
  //             context: context,
  //             chain: _updatedChain,
  //           );
  //
  //           await _syncSuccessDialog(context);
  //         }
  //         /// IF SPECS CHAIN
  //         else if (chainIsSpecsChain(_updatedChain) == true){
  //           await _updateSpecsChainOps(
  //               context: context,
  //               chain: _updatedChain
  //           );
  //           await _syncSuccessDialog(context);
  //         }
  //         /// IF OTHER NEW CHAIN
  //         else {
  //           blog('this Chain ${_updatedChain.id} was not synced');
  //           _updatedChain.blogChain();
  //           await _syncFailureDialog(context);
  //         }
  //       }
  //
  //     }
  //
  //
  //
  //   }
  //
  // }

}
// -----------------------------------------------------------------------------
// Future<void> _syncSuccessDialog(BuildContext context) async {
//
//   await CenterDialog.showCenterDialog(
//     context: context,
//     titleVerse:  'Chains Are Synced on database Successfully',
//     bodyVerse:  'you need to restart this screen to update the red button ma3lesh',
//     confirmButtonVerse:  'I Understand mashi',
//   );
//
// }
// -----------------------------------------------------------------------------
// Future<void> _syncFailureDialog(BuildContext context) async {
//
//   await CenterDialog.showCenterDialog(
//     context: context,
//     titleVerse:  'nothing Synced',
//     bodyVerse:  'Something went wrong',
//     color: Colorz.bloodTest,
//   );
//
// }
// -----------------------------------------------------------------------------
bool chainIsKeywordsChain(Chain chain){
  return chain.id == 'phid_sections';
}
// -----------------------------------------------------------------------------
bool chainIsSpecsChain(Chain chain){
  return chain.id == 'phid_s_specs_chain';
}
// -----------------------------------------------------------------------------
// Future<void> _updateKeywordsChainOps({
//   @required BuildContext context,
//   @required Chain chain,
// }) async {
//
//   if (chainIsKeywordsChain(chain) == true){
//
//     /// 1 - UPDATE ON FIREBASE
//     await ChainFireOpsOLD.updateKeywordsChain(
//       context: context,
//       newKeywordsChain: chain,
//     );
//
//     /// 2 - UPDATE ON LDB
//     await LDBOps.insertMap(
//       input: chain.toMapOLD(),
//       docName: LDBDoc.bldrsChains,
//     );
//
//     /// 3 - UPDATE PROVIDER
//     final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
//     await _chainsProvider.updateBldrsChainsOps(
//       context: context,
//       bldrsChains: chain,
//       notify: true,
//     );
//
//     /// 4 - UPDATE APP STATE (KEYWORDS VERSION)
//     await AppStateFireOps.updateGlobalChainsVersion(context);
//   }
//
// }
// -----------------------------------------------------------------------------
// Future<void> _updateSpecsChainOps({
//   @required BuildContext context,
//   @required Chain chain,
// }) async {
//
//   // /// 1 - UPDATE ON FIREBASE
//   // await ChainFireOpsOLD.updateSpecsChain(
//   //   context: context,
//   //   newSpecsChain: chain,
//   // );
//   //
//   // /// 2 - UPDATE ON LDB
//   // await LDBOps.insertMap(
//   //   input: chain.toMapOLD(),
//   //   docName: LDBDoc.bigChainS,
//   // );
//   //
//   // /// 3 - UPDATE PROVIDER
//   // final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
//   // _chainsProvider.setBigChainS(
//   //     bigChainS: chain,
//   //     notify: true
//   // );
//   //
//   // /// 4 - UPDATE APP STATE (KEYWORDS VERSION)
//   // await AppStateOps.updateSpecsChainVersion(context);
// }
// -----------------------------------------------------------------------------
