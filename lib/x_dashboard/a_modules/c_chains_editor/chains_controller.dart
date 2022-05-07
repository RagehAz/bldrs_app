import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/e_db/fire/ops/chain_ops.dart' as ChainOps;

// -----------------------------------------------------------------------------
Future<void> onAddMoreSpecsChainsToExistingSpecsChains({
  @required BuildContext context,
  @required List<Chain> chainsToAdd,
}) async {

  if (Mapper.canLoopList(chainsToAdd) == true){

    final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);

    await ChainOps.addChainsToSpecsChainSons(
      context: context,
      chainsToAdd: chainsToAdd,
    );

    await _chainsProvider.reloadAllChains(context);

  }

}
// -----------------------------------------------------------------------------
/// TESTED : WORKS PERFECT
Future<void> onBackupAllChains(BuildContext context) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    boolDialog: true,
    title: 'Back up All Chains ?',
    body: 'Please confirm',
  );

  if (_result == true){
    await ChainOps.backupChainsOps(context);
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
  @required ValueNotifier<List<Chain>> allChains,
  @required ValueNotifier<List<Chain>> foundChains,
}) async {

  searchValue.value = text;

  triggerIsSearchingNotifier(
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
// ------------------------------------------------
void _searchChainsOps({
  @required ValueNotifier<List<Chain>> chains,
  @required String text,
  @required ValueNotifier<List<Chain>> foundChains,
}){

  final List<Chain> _foundPathsChains = ChainPathConverter.findRelatedChains(
    allChains: chains.value,
    phid: text,
  );

  /// SET FOUND CHAINS AS SEARCH RESULT
  foundChains.value = _foundPathsChains;

}
// ------------------------------------------------
Future<void> onUpdateNode({
  @required BuildContext context,
  @required String path,
  @required ValueNotifier<List<Chain>> chains,
  // @required List<Chain> oldChains,
  @required String newPhid,
  @required PageController pageController,
  @required ValueNotifier<String> searchValue,
  @required ValueNotifier<bool> isSearching,
  @required TextEditingController searchController,
}) async {

  minimizeKeyboardOnTapOutSide(context);

  if (stringIsEmpty(newPhid) == true){
    blog('new phid value is empty man');
  }

  else {

    blog('lineeeeeeeeeeeeeeeeeeeeeeeeeee-------------------');

    final String _rootChainID = ChainPathConverter.getFirstPathNode(
      path: path,
    );
    final Chain _chain = Chain.getChainFromChainsByID(
      chainID: _rootChainID,
      chains: chains.value,
    );

    _chain.blogChain();

    blog('lineeeeeeeeeeeeeeeeeeeeeeeeeee-------------------');

    final String _phid = ChainPathConverter.getLastPathNode(path);

    final Chain _newChain = await Chain.updateNode(
      context: context,
      oldPhid: _phid,
      newPhid: newPhid,
      sourceChain: _chain,
    );

    _newChain.blogChain();

    blog('lineeeeeeeeeeeeeeeeeeeeeeeeeee-------------------');

    final List<Chain> _newChains = Chain.replaceChainInChains(
      chains: chains.value,
      chainToReplace: _newChain,
    );

    chains.value = _newChains;
    searchController.text = newPhid;
    searchValue.value = newPhid;
    isSearching.value = true;

    await Sliders.slideToBackFrom(
        pageController: pageController,
        currentSlide: 1,
    );

  }


}
// ------------------------------------------------
Future<void> onSync({
  @required BuildContext context,
  @required List<Chain> originalChains,
  @required ValueNotifier<List<Chain>> updatedChains,
}) async {

  final bool _chainsListsAreTheSame = Chain.chainsListsAreTheSame(
    chainsA: originalChains,
    chainsB: updatedChains.value,
  );

  /// WHEN THERE ARE NO CHANGES
  if (_chainsListsAreTheSame == true){

    await TopDialog.showTopDialog(
      context: context,
      verse: 'Chains were not modified',
      secondLine: 'No Sync required',
    );

  }

  /// WHEN A CHAIN NODE CHANGED
  else {

    final bool _result = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Sync Chains to DB ?',
      body: 'This will check which Chain was modified and automatically update it on database',
      boolDialog: true,
    );

    if (_result == true){

      blog('Here we go');

    }

  }

}
// ------------------------------------------------
