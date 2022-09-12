import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/chain/aaa_phider.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/a_chains_screen/a_chains_picking_screen.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/c_protocols/chain_protocols/a_chain_protocols.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/b_chain_editor_screen.dart';
import 'package:bldrs/x_dashboard/a_modules/c_chains_editor/c_path_editor_screen.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// NAVIGATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> goToChainsEditorScreen({
  @required BuildContext context,
  @required List<Chain> chains,
}) async {

  await Nav.goToNewScreen(
    context: context,
    screen: ChainsEditorScreen(
      chains: chains,
    ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<dynamic> goToChainsPickingScreen({
  @required BuildContext context,
  @required List<FlyerType> flyerTypes,
  @required bool onlyUseCityChains,
  @required bool isMultipleSelectionMode,
  @required String pageTitleVerse,
  @required ZoneModel zone,
}) async {

  final dynamic _received =  await Nav.goToNewScreen(
      context: context,
      screen: ChainsPickingScreen(
        flyerTypesChainFilters: flyerTypes,
        onlyUseCityChains: onlyUseCityChains,
        isMultipleSelectionMode: isMultipleSelectionMode,
        pageTitleVerse: pageTitleVerse,
        // onlyChainKSelection: false, /// TASK : WTF IS THIS DOING
        zone: zone,
      )
  );

  if (isMultipleSelectionMode == true){
    final List<SpecModel> _specs = _received;
    SpecModel.blogSpecs(_specs);
  }
  else {
    final String _phid = _received;
    blog(_phid);
  }

  return dynamic;
}
// -----------------------------------------------------------------------------

/// SYNCING

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSyncChain({
  @required BuildContext context,
  @required ValueNotifier<List<Chain>> initialChains,
  @required List<Chain> editedChains,
}) async {

  blog('onSyncChain : ---------------- START ');

  final bool _continue = await _preSyncCheckups(
    context: context,
    originalChains: initialChains.value,
    editedChains: editedChains,
  );

  if (_continue == true){

    await _updateChain(
      context: context,
      initialChains: initialChains.value,
      editedChains: editedChains,
    );

    // initialChains.value = editedChains;

  }

  blog('onSyncChain : ---------------- END');
}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _preSyncCheckups({
  @required BuildContext context,
  @required List<Chain> originalChains,
  @required List<Chain> editedChains,
}) async {

  final List<String> _originalPaths = ChainPathConverter.generateChainsPaths(
    parentID: '',
    chains: originalChains,
  );

  final List<String> _editedPaths = ChainPathConverter.generateChainsPaths(
    parentID: '',
    chains: editedChains,
  );

  final List<String> _differencesLog = Stringer.blogStringsListsDifferences(
    strings1: Phider.removePathsIndexes(_originalPaths),
    list1Name: 'OriginalPaths',
    strings2: Phider.removePathsIndexes(_editedPaths),
    list2Name: 'EditedPaths',
  );

  final bool _continue = await CenterDialog.showCenterDialog(
    context: context,
    height: 600,
    titleVerse:  'Chains Differences',
    bodyVerse:  'Below is a comparison result of Chain changed\n'
        'Wish to upload the edited Chain',
    boolDialog: true,
    child: BulletPoints(
      bubbleWidth: CenterDialog.clearWidth(context),
      bulletPoints: _differencesLog,
      translateBullets: false,
    ),
  );

  return _continue;
}
// --------------------
///
Future<void> _updateChain({
  @required BuildContext context,
  @required List<Chain> initialChains,
  @required List<Chain> editedChains,
}) async {

  await ChainProtocols.renovateBldrsChains(
      context: context,
      newChains: editedChains
  ).whenComplete(
          () => Dialogs.showSuccessDialog(
            context: context,
            firstLine: 'updated Bldrs chain successfully',
            secondLine: 'in ( Real/bldrsChains/ )',
          )
  );

}
// -----------------------------------------------------------------------------

/// SELECTION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onPhidTap({
  @required BuildContext context,
  @required String path,
  @required String phid,
  @required ValueNotifier<List<Chain>> tempChains,
}) async {

  final String _path = ChainPathConverter.fixPathFormatting(path);

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      numberOfWidgets: 5,
      draggable: true,
      title: phid,
      buttonHeight: 50,
      builder: (_, PhraseProvider phrasePro){

        return <Widget>[

          /// PATH SPLIT
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: BulletPoints(
              bulletPoints: ChainPathConverter.splitPathNodes(_path),
              bubbleWidth: BottomDialog.clearWidth(context),
              translateBullets: false,
            ),
          ),

          /// EDIT
          BottomDialog.wideButton(
            context: context,
            verse:  'Edit',
            onTap: () => onEditPhid(
              context: context,
              tempChains: tempChains,
              path: _path,
              phid: phid,
            ),
          ),

          /// DELETE
          BottomDialog.wideButton(
            context: context,
            verse:  'Delete',
            onTap: () => onDeleteThePhid(
              context: context,
              tempChains: tempChains,
              path: _path,
              phid: phid,
            ),
          ),

        ];

      }
  );

}
// -----------------------------------------------------------------------------

/// MODIFIERS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAddNewPath ({
  @required BuildContext context,
  @required String path,
  @required ValueNotifier<List<Chain>> tempChains,
}) async {

  final String _path = ChainPathConverter.fixPathFormatting(path);

  final String _typedPath = await Nav.goToNewScreen(
    context: context,
    screen: PathEditorScreen(path: _path),
  );

  if (TextCheck.isEmpty(_typedPath) == false){

    final List<Chain> _updated = Chain.addPathToChains(
      chains: tempChains.value,
      path: _typedPath,
    );

    // final bool _areIdentical = Chain.checkChainsListPathsAreIdentical(
    //   chains1: _updated,
    //   chains2: tempChains.value,
    // );

    // blog('xx - old chains : -');
    // Chain.blogChains(tempChains.value);
    // blog('xx - updated chains : -');
    // Chain.blogChains(_updated);

    // blog('onAddNewPath : shoof keda chains have changed : $_areIdentical');

    tempChains.value = _updated;

    await Dialogs.showSuccessDialog(
      context: context,
      firstLine: 'New Path has been deleted',
      secondLine: _typedPath,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onDeleteThePhid ({
  @required BuildContext context,
  @required String phid,
  @required String path,
  @required ValueNotifier<List<Chain>> tempChains,
}) async {

  Nav.goBack(
    context: context,
    invoker: 'onDeletePhid delete button',
  );

  final List<String> _relatedPaths = ChainPathConverter.findPathsStartingWith(
    startsWith: path,
    chains: tempChains.value,
  );

  final bool _continue = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse:  'Delete Paths ?',
    translateTitle: false,
    translateBody: false,
    bodyVerse:  '${_relatedPaths.length} paths will be deleted',
    boolDialog: true,
    child: BulletPoints(
        bulletPoints: _relatedPaths,
        translateBullets: false
    ),
  );

  if (_continue == true){

    final List<Chain> _updated = Chain.removePathsFromChains(
      chains: tempChains.value,
      paths: _relatedPaths,
    );

    tempChains.value = _updated;

    await Dialogs.showSuccessDialog(
      context: context,
      firstLine: '( $phid ) has been deleted',
    );

  }

}
// --------------------
///
Future<void> onEditPhid({
  @required BuildContext context,
  @required ValueNotifier<List<Chain>> tempChains,
  @required String phid,
  @required String path,
}) async {

  Nav.goBack(context: context, invoker: 'onEditPhid');

  final String _typedPath = await Nav.goToNewScreen(
    context: context,
    screen: PathEditorScreen(path: path),
  );

  if (TextCheck.isEmpty(_typedPath?.trim()) == false && path != _typedPath){

    final bool _continue = await CenterDialog.showCenterDialog(
      context: context,
      height: 500,
      titleVerse:  'Edit this path ?',
      bodyVerse:  'old\n$path'
          '\n\n'
          'new\n$_typedPath',
      boolDialog: true,
    );

    if (_continue == true){

      final List<Chain> _updated = Chain.replaceChainsPathWithPath(
        chains: tempChains.value,
        pathToRemove: path,
        pathToReplace: _typedPath,
      );

      tempChains.value = _updated;

      await Dialogs.showSuccessDialog(
        context: context,
        firstLine: 'Edit Successful',
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onReorderSon({
  @required ValueNotifier<List<Chain>> tempChains,
  @required int newIndex,
  @required int oldIndex,
  @required String previousPath,
  @required int level,
  /// the list of objects built in list builder along with the selected phid
  @required List<dynamic> sons, // phid brothers
}){

  final dynamic son = sons[oldIndex];
  final String _previousPath = ChainPathConverter.fixPathFormatting(previousPath);
  // blog('oldIndex : $oldIndex : newIndex : $newIndex : level : $level : _previousPath : $_previousPath');

  // Chain.blogSon(son);

  final bool _isChain = son is Chain;
  final bool _isPhid = Phider.checkIsPhid(son);
  // final bool _isDataCreator = DataCreation.checkIsDataCreator(son);

  final String _previousNode = ChainPathConverter.getLastPathNode(_previousPath);
  final List<String> _allPaths = ChainPathConverter.generateChainsPaths(
    parentID: '',
    chains: tempChains.value,
  );

  /// A - RE-ORDER PHIDS
  if (_isPhid){

    final List<String> _phids = <String>[...sons];
    final String _phid = son;

    blog('_previousNode : $_previousNode');
    _phids.removeAt(oldIndex);
    _phids.insert(newIndex, _phid);

    final List<String> _indexed = Phider.createPhidsIndexes(_phids);
    final List<String> _newPaths = <String>[];
    for (final String _indexedPhid in _indexed){
      final String _newPath = '$_previousPath/$_indexedPhid/';
      _newPaths.add(_newPath);
    }
    final List<String> _relatedPaths = TextCheck.getStringsStartingExactlyWith(
      strings: _allPaths,
      startWith: _previousPath,
    );
    final List<String> _afterRemove = Stringer.removeStringsFromStrings(
      removeFrom: _allPaths,
      removeThis: _relatedPaths,
    );

    final List<String> _afterAdd = Stringer.addStringsToStringsIfDoNotContainThem(
      listToTake: _afterRemove,
      listToAdd: _newPaths,
    );
    final List<Chain> _reChains = ChainPathConverter.createChainsFromPaths(
      paths: _afterAdd,
    );
    final List<Chain> _ordered = Phider.sortChainsByIndexes(_reChains);

    tempChains.value = _ordered;

  }

  /// B - RE-ORDER CHAINS
  else if (_isChain){

    final List<Chain> _brothers = <Chain>[...sons];
    final Chain chain = son;

    _brothers.removeAt(oldIndex);
    _brothers.insert(newIndex, chain);

    final List<Chain> _indexedBrothers = Phider.createChainsIndexes(_brothers);

    if (level == 0){
      tempChains.value = Phider.sortChainsByIndexes(_indexedBrothers);
    }
    else {

      final List<Chain> _chains = Chain.replaceChainInChains(
          chains: tempChains.value,
          chainToReplace: Chain(
            id: _previousNode,
            sons: _indexedBrothers,
          ),
      );

      tempChains.value = Phider.sortChainsByIndexes(_chains);

    }

  }

}
// --------------------
