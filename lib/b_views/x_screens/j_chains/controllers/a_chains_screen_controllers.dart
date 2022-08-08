import 'package:bldrs/a_models/chain/chain.dart';
import 'package:bldrs/a_models/chain/chain_path_converter/chain_path_converter.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/e_flyer_maker/d_spec_picker_screen.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// SEARCHING

// --------------------------------
Future<void> onChainsSearchChanged({
  @required String text,
  @required ValueNotifier<bool> isSearching,
  @required ValueNotifier<List<Chain>> foundChains,
  @required List<Chain> chains,
}) async {

  TextChecker.triggerIsSearchingNotifier(
    text: text,
    isSearching: isSearching,
  );

  if (isSearching.value == true){
    _searchChainsOps(
      chains: chains,
      text: text,
      foundChains: foundChains,
    );
  }

}
// ------------------------------------------------
Future<void> onChainsSearchSubmitted({
  @required String text,
  @required ValueNotifier<bool> isSearching,
}) async {



}
// ------------------------------------------------
void _searchChainsOps({
  @required List<Chain> chains,
  @required String text,
  @required ValueNotifier<List<Chain>> foundChains,
}){

  final List<Chain> _foundPathsChains = ChainPathConverter.findPhidRelatedChains(
    allChains: chains,
    phid: text,
  );

  /// SET FOUND CHAINS AS SEARCH RESULT
  foundChains.value = _foundPathsChains;

}
// -----------------------------------------------------------------------------

/// SELECTION

// --------------------------------
void onSelectPhid({
  @required String phid,
}){

  blog('selected phid is : $phid');

}
// -----------------------------------------------------------------------------

/// NAVIGATION

// --------------------------------
Future<void> goToKeywordsScreen({
  @required BuildContext context,
  @required SpecPicker specPicker,
}) async {

  final String _phid = await Nav.goToNewScreen(
    context: context,
    transitionType: Nav.superHorizontalTransition(context),
    screen: SpecPickerScreen(
      specPicker: specPicker,
      showInstructions: false,
      inSelectionMode: false,
    ),
  );

  blog('selected this phid : $_phid');

}
// -----------------------------------------------------------------------------
