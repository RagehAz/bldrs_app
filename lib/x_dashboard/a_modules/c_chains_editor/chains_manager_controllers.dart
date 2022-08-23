import 'package:bldrs/a_models/chain/a_chain.dart';
import 'package:bldrs/a_models/chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/ui/keyboard_model.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/c_protocols/chain_protocols/a_chain_protocols.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/e_db/real/foundation/real_colls.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// SYNCING

// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onSyncChain({
  @required BuildContext context,
  @required ValueNotifier<Chain> initialChain,
  @required Chain editedChain,
}) async {

  blog('onSyncChain : ---------------- START : originalChain.id : ${initialChain.value.id}');

  final bool _continue = await _preSyncCheckups(
    context: context,
    originalChain: initialChain.value,
    editedChain: editedChain,
  );

  if (_continue == true){

    await _updateChain(
      context: context,
      initialChain: initialChain.value,
      editedChain: editedChain,
    );

    initialChain.value = editedChain;

  }

  blog('onSyncChain : ---------------- END');
}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<bool> _preSyncCheckups({
  @required BuildContext context,
  @required Chain originalChain,
  @required Chain editedChain,
}) async {

  final List<String> _originalPaths = ChainPathConverter.generateChainsPaths(
    parentID: originalChain.id,
    chains: originalChain.sons,
  );

  final List<String> _editedPaths = ChainPathConverter.generateChainsPaths(
    parentID: editedChain.id,
    chains: editedChain.sons,
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
    title: 'Chains Differences',
    body: 'Below is a comparison result of Chain changed\n'
        'Wish to upload the edited Chain',
    boolDialog: true,
    child: BubbleBulletPoints(
      bubbleWidth: CenterDialog.clearWidth(context),
      bulletPoints: _differencesLog,
    ),
  );

  return _continue;
}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> _updateChain({
  @required BuildContext context,
  @required Chain initialChain,
  @required Chain editedChain,
}) async {

  final String _realChainDoc =
  initialChain.id == 'chainK' ?
  RealDoc.chains_bigChainK
      :
  initialChain.id == 'chainS' ?
  RealDoc.chains_bigChainS
      :
  null;

  bool _success = false;

  /// BIG CHAIN K RENOVATION
  if (_realChainDoc == RealDoc.chains_bigChainK) {

    await ChainProtocols.renovateBigChainK(
        context: context,
        bigChainK: editedChain
    );

    _success = true;
  }

  /// BIG CHAIN S RENOVATION
  else if (_realChainDoc == RealDoc.chains_bigChainS) {

    await ChainProtocols.renovateBigChainS(
        context: context,
        bigChainS: editedChain
    );

    _success = true;
  }

  /// SUCCESS DIALOG
  if (_success == true){
    await TopDialog.showSuccessDialog(
      context: context,
      firstLine: '${initialChain.id} updated successfully',
      secondLine: 'in ( Real/chains/$_realChainDoc)',
    );
  }

}
// -----------------------------------------------------------------------------

  /// SELECTION

// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onPhidTap({
  @required BuildContext context,
  @required String path,
  @required String phid,
  @required ValueNotifier<Chain> tempChain,
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
            ),
          ),

          /// EDIT
          BottomDialog.wideButton(
            context: context,
            verse: 'Edit',
            onTap: () => onEditPhid(
              context: context,
              tempChain: tempChain,
              path: _path,
              phid: phid,
            ),
          ),

          /// DELETE
          BottomDialog.wideButton(
            context: context,
            verse: 'Delete',
            onTap: () => onDeleteThePhid(
              context: context,
              tempChain: tempChain,
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

// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onAddNewPath ({
  @required BuildContext context,
  @required String path,
  @required ValueNotifier<Chain> tempChain,
}) async {

  final String _path = ChainPathConverter.fixPathFormatting(path);

  final String _typedPath = await _pathKeyboardDialog(
    context: context,
    path: _path,
    title: 'Add to path',
  );

  final Chain _updated = Chain.addPathToChain(
    chain: tempChain.value,
    path: _typedPath,
  );

  // _updated.blogChain();

  tempChain.value = _updated;

  await TopDialog.showSuccessDialog(
    context: context,
    firstLine: 'New Path has been deleted',
    secondLine: _path,
  );


}
// ----------------------------------
/// TESTED : WORKS PERFECT
  Future<void> onDeleteThePhid ({
    @required BuildContext context,
    @required String phid,
    @required String path,
    @required ValueNotifier<Chain> tempChain,
  }) async {

    Nav.goBack(
      context: context,
      invoker: 'onDeletePhid delete button',
    );

    final bool _continue = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Delete $phid ?',
      body: 'this path will be deleted :-'
          '\n[ $path ]',
      boolDialog: true,
    );

    if (_continue == true){

      final Chain _updated = Chain.removePathFromChain(
        chain: tempChain.value,
        path: path,
      );

      tempChain.value = _updated;

      await TopDialog.showSuccessDialog(
        context: context,
        firstLine: '( $phid ) has been deleted',
      );

    }

  }
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onEditPhid({
  @required BuildContext context,
  @required ValueNotifier<Chain> tempChain,
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
      title: 'Edit this path ?',
      body: 'old\n$path'
          '\n\n'
          'new\n$_typedPath',
      boolDialog: true,
    );

    if (_continue == true){

      final Chain _updated = Chain.replaceChainPathWithPath(
        chain: tempChain.value,
        pathToRemove: path,
        pathToReplace: _typedPath,
      );

      tempChain.value = _updated;

      await TopDialog.showSuccessDialog(
        context: context,
        firstLine: 'Edit Successful',
      );

    }

  }

}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<String> _pathKeyboardDialog({
  @required BuildContext context,
  @required String path,
  @required String title,
}) async {

  String _typedPath;
  // _controller.text = ChainPathConverter.fixPathFormatting(path);
  final TextEditingController _controller = TextEditingController(text: path);

  void doneWithPath(String text){
    _typedPath = ChainPathConverter.fixPathFormatting(text);
  }

  _typedPath = await Dialogs.keyboardDialog(
    context: context,
    keyboardModel: KeyboardModel.standardModel().copyWith(
      title: title,
      hintText: path,
      controller: _controller,
      // focusNode: _node,
      minLines: 3,
      maxLines: 8,
      maxLength: 1000,
      isFloatingField: false,
      textInputAction: TextInputAction.done,
      textInputType: TextInputType.url,
      // onChanged: (String text){},
      onSubmitted: doneWithPath,
      onEditingComplete: doneWithPath,
    ),
  );

  _typedPath = ChainPathConverter.fixPathFormatting(_typedPath);

  return _typedPath;
}
// ----------------------------------
