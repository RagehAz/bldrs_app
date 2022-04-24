import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/a_shelf_box.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/theme/standards.dart' as Standards;


const int _maxDraftsCount = Standards.maxDraftsAtOnce;
const Curve _animationCurve = Curves.easeOut;
const Duration _animationDuration = Ratioz.duration150ms;
// -----------------------------------------------------------------------------
/*
int _createKeyValue(List<ValueKey> keys){
  final Random _random = Random();
  int _randomNumber = _random.nextInt(100000); // from 0 upto 99 included

  if(keys.contains(ValueKey(_randomNumber))){
    _randomNumber = _createKeyValue(keys);
  }

  return _randomNumber;
}
 */
// -----------------------------------------------------------------------------
Future<void> createNewShelf({
  @required BuildContext context,
  @required ValueNotifier<List<ValueNotifier<ShelfUI>>> shelvesUIs,
  @required BzModel bzModel,
  @required ScrollController scrollController,
}) async {

  /// A - if less than max drafts drafts possible
  if (shelvesUIs.value.length < _maxDraftsCount){

    final DraftFlyerModel _newDraft = DraftFlyerModel.createNewDraft(
      bzModel: bzModel,
      authorID: superUserID(),
    );

    final int _newIndex = shelvesUIs.value.length;

    final ShelfUI _newShelfUI = ShelfUI(
      height: 0,
      opacity: 0,
      index: _newIndex,
    );

    shelvesUIs.value = <ValueNotifier<ShelfUI>>[
      ...shelvesUIs.value,
      ValueNotifier<ShelfUI>(_newShelfUI),
    ];

    await _fadeInAndExpandShelf(
      context: context,
      index: _newIndex,
      shelvesUIs: shelvesUIs,
    );

    await _scrollToBottom(
      scrollController: scrollController,
    );

  }

  /// A - if max drafts reached
  else {

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Too many Draft flyers',
      body: 'Please Publish or remove any of the previous draft flyers to be able to add a new flyer',
    );

  }

}
// -----------------------------------------------------------------------------
Future<void> deleteShelf({
  @required BuildContext context,
  @required int index,
  @required ValueNotifier<List<ValueNotifier<ShelfUI>>> shelvesUIs,
  @required ScrollController scrollController,
}) async {

  await _fadeOutAndShrinkShelf(
    index: index,
    shelvesUIs: shelvesUIs
  );

  await Future.delayed(_animationDuration, () async {

    if (index != 0 ){
      await scrollToShelf(
        context: context,
        index: index - 1,
        scrollController: scrollController,
      );
    }


    final List<ValueNotifier<ShelfUI>> _newShelves = shelvesUIs.value;
    _newShelves.removeAt(index);
    shelvesUIs.value = <ValueNotifier<ShelfUI>>[..._newShelves];

  });

}
// -----------------------------------------------------------------------------
double _getShelfPosition({
  @required BuildContext context,
  @required int index,
}){

  final double _verticalOffsetFromScreenTop =
      (ShelfBox.height(context) * index)
          +
          Ratioz.appBarMargin;

  return _verticalOffsetFromScreenTop;

}
// -----------------------------------------------------------------------------
Future <void> scrollToShelf({
  @required BuildContext context,
  @required int index,
  @required ScrollController scrollController,
}) async {

  final double _position = _getShelfPosition(
    index: index,
    context: context,
  );

  await scrollController.animateTo(
    _position,
    duration: Ratioz.durationFading200,
    curve: ShelfBox.animationCurve,
  );

}
// -----------------------------------------------------------------------------
Future<void> _fadeOutAndShrinkShelf({
  @required int index,
  @required ValueNotifier<List<ValueNotifier<ShelfUI>>> shelvesUIs,
}) async {

  /// FADE OUT
  await Future.delayed( _animationDuration, () async {
    shelvesUIs.value[index].value = shelvesUIs.value[index].value.copyWith(
      opacity: 0,
    );
  });

  /// SHRINK
  shelvesUIs.value[index].value = shelvesUIs.value[index].value.copyWith(
    height: 0,
  );

}
// -----------------------------------------------------------------------------
Future<void> _fadeInAndExpandShelf({
  @required BuildContext context,
  @required int index,
  @required ValueNotifier<List<ValueNotifier<ShelfUI>>> shelvesUIs,
}) async {

  /// FADE IN
  shelvesUIs.value[index].value = shelvesUIs.value[index].value.copyWith(
    opacity: 1,
  );

  /// EXPAND
  await Future.delayed(_animationDuration, () async {
    shelvesUIs.value[index].value = shelvesUIs.value[index].value.copyWith(
      height: ShelfBox.height(context),
    );
  });

}
// -----------------------------------------------------------------------------
Future<void> _scrollToBottom({
  @required ScrollController scrollController,
}) async {

  await Future.delayed(_animationDuration, () async {
    await scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: _animationDuration,
      curve: _animationCurve,
    );
  });

}
// -----------------------------------------------------------------------------
Future<void> onCancelFlyerCreation(BuildContext context) async {

  final bool result = await CenterDialog.showCenterDialog(
    context: context,
    boolDialog: true,
    title: 'Cancel Flyer',
    body: 'All progress in this flyer will be lost',
    confirmButtonText: 'Yes Cancel',
  );

  if (result == true){
    Nav.goBack(context);
  }

}
