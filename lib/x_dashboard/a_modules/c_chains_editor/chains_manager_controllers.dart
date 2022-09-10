import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/ui/keyboard_model.dart';
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

    initialChains.value = editedChains;

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
    parentID: 'OriginalPaths',
    chains: originalChains,
  );

  final List<String> _editedPaths = ChainPathConverter.generateChainsPaths(
    parentID: 'EditedPaths',
    chains: editedChains,
  );

  final List<String> _differencesLog = Stringer.blogStringsListsDifferences(
    strings1: _originalPaths,
    strings2: _editedPaths,
    list1Name: 'OriginalPaths',
    list2Name: 'EditedPaths',
  );

  final bool _continue = await CenterDialog.showCenterDialog(
    context: context,
    height: 600,
    titleVerse:  'Chains Differences',
    bodyVerse:  'Below is a comparison result of Chain changed\n'
        'Wish to upload the edited Chain',
    boolDialog: true,
    child: BubbleBulletPoints(
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
        secondLine: 'in ( Real/chains/ )',
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
      numberOfWidgets: 7,
      draggable: true,
      title: phid,
      buttonHeight: 50,
      builder: (_, PhraseProvider phrasePro){

        return <Widget>[

          /// PATH SPLIT
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: BubbleBulletPoints(
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
///
Future<void> onAddNewPath ({
  @required BuildContext context,
  @required String path,
  @required ValueNotifier<List<Chain>> tempChains,
}) async {

  final String _path = ChainPathConverter.fixPathFormatting(path);

  final String _typedPath = await _pathKeyboardDialog(
    context: context,
    path: _path,
    title: 'Add to path',
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

    blog('xx - old chains : -');
    Chain.blogChains(tempChains.value);
    blog('xx - updated chains : -');
    Chain.blogChains(_updated);

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

  final bool _continue = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse:  'Delete $phid ?',
    bodyVerse:  'this path will be deleted :-'
        '\n[ $path ]',
    boolDialog: true,
  );

  if (_continue == true){

    final List<Chain> _updated = Chain.removePathFromChains(
      chains: tempChains.value,
      path: path,
    );

    tempChains.value = _updated;

    await Dialogs.showSuccessDialog(
      context: context,
      firstLine: '( $phid ) has been deleted',
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onEditPhid({
  @required BuildContext context,
  @required ValueNotifier<List<Chain>> tempChains,
  @required String phid,
  @required String path,
}) async {

  Nav.goBack(context: context, invoker: 'onEditPhid');

  final String _typedPath = await _pathKeyboardDialog(
    context: context,
    path: path,
    title: 'Edit path',
  );

  if (path != _typedPath){

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
Future<String> _pathKeyboardDialog({
  @required BuildContext context,
  @required String path,
  @required String title,
}) async {

  String _typedPath;
  final TextEditingController _controller = TextEditingController(text: path);

  void doneWithPath(String text){
    _typedPath = ChainPathConverter.fixPathFormatting(text);
  }

  final GlobalKey _globalKey = GlobalKey<FormState>();

  await Dialogs.keyboardDialog(
    context: context,
    validator: () => _pathCreationValidator(_controller.text),
    keyboardModel: KeyboardModel.standardModel().copyWith(
      globalKey: _globalKey,
      titleVerse: title,
      translateTitle: false,
      hintVerse: path,
      controller: _controller,
      // focusNode: _node,
      minLines: 2,
      maxLines: 5,
      maxLength: 1000,
      isFloatingField: false,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.url,
      onChanged: (String text){
        // _globalKey.currentS;
      },
      onSubmitted: doneWithPath,
      // onEditingComplete: doneWithPath,
      counterIsOn: true,
      isFormField: true,

    ),
  );

  return _typedPath;
}
// --------------------
/// TESTED : WORKS PERFECT
String _pathCreationValidator(String path){

  final List<String> _nodes = ChainPathConverter.splitPathNodes(path);

  String _message;

  for (int i = 0; i < _nodes.length; i++){

    final String _node = _nodes[i];
    final bool _startsWith = TextCheck.textStartsExactlyWith(
        text: _node,
        startsWith: 'phid_',
    );

    if (_startsWith == false){
      _message = 'node ${i+1} : ( $_node ) : should start with "phid_"';
    }

  }

  blog('_pathCreationValidator : _message : $_message');

  return _message;
}
// --------------------
