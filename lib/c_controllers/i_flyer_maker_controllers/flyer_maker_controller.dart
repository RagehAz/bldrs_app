import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/specs_selector_screen/keywords_picker_screen.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/specs_selector_screen/specs_pickers_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart' as FlyerOps;
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// -----------------------------------------------------------------------------
/// OLD MULTIPLE SHELVES METHODS
/*
// -----------------------------------------------------------------------------
const int _maxDraftsCount = Standards.maxDraftsAtOnce;
const Curve _animationCurve = Curves.easeOut;
const Duration _animationDuration = Ratioz.duration150ms;
// -----------------------------------------------------------------------------
int _createKeyValue(List<ValueKey> keys){
  final Random _random = Random();
  int _randomNumber = _random.nextInt(100000); // from 0 upto 99 included

  if(keys.contains(ValueKey(_randomNumber))){
    _randomNumber = _createKeyValue(keys);
  }

  return _randomNumber;
}
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
*/
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
// -----------------------------------------------------------------------------
void onUpdateFlyerHeadline({
  @required ValueNotifier<DraftFlyerModel> draft,
  @required TextEditingController headlineController,
}){

  draft.value = DraftFlyerModel.updateHeadline(
    controller : headlineController,
    draft: draft.value,
  );

}
// -----------------------------------------------------------------------------
String flyerHeadlineValidator({
  @required TextEditingController headlineController,
}){

  final bool _isEmpty = headlineController.text.trim() == '';
  final bool _isShort = headlineController.text.length < 10;

  if (_isEmpty){
    return "Can not publish a flyer without a title as it's used in the search engine";
  }
  else if (_isShort){
    return 'Flyer title can not be less than 10 characters';
  }
  else {
    return null;
  }
}
// -----------------------------------------------------------------------------
void onSelectFlyerType({
  @required int index,
  @required ValueNotifier<DraftFlyerModel> draft,
}){

  blog('tapped on index : $index');

  final FlyerType _selectedFlyerType = flyerTypesList[index];

  draft.value = draft.value.copyWith(
    flyerType: _selectedFlyerType,
  );
}
// -----------------------------------------------------------------------------
Future<void> onAddKeywordsTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
}) async {

  final dynamic _result = await Nav.goToNewScreen(
      context: context,
      screen: KeywordsPickerScreen(
        flyerTypes: <FlyerType>[draft.value.flyerType],
        selectedKeywordsIDs: draft.value.keywordsIDs,
      )
  );

  final List<String> receivedKeywordsIds = _result;

  if (canLoopList(receivedKeywordsIds) == true){

    draft.value = draft.value.copyWith(
      keywordsIDs: receivedKeywordsIds,
    );

  }

}
// -----------------------------------------------------------------------------
Future<void> onAddSpecsTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
}) async {

  final dynamic _result = await Nav.goToNewScreen(
      context: context,
      screen: SpecsPickersScreen(
        flyerType: draft.value.flyerType,
        selectedSpecs: draft.value.specs,
      )
  );

  final List<SpecModel> _receivedSpecs = _result;

  if (canLoopList(_receivedSpecs) == true){

    SpecModel.blogSpecs(_receivedSpecs);

    draft.value = draft.value.copyWith(
      specs: _receivedSpecs,
    );

  }

}
// -----------------------------------------------------------------------------
Future<void> onZoneChanged({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
  @required ZoneModel zone,
}) async {

  draft.value = draft.value.copyWith(
    zone: zone,
  );

}
// -----------------------------------------------------------------------------
Future<void> onPublishFlyer({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
  @required BzModel bzModel,
  @required GlobalKey<FormState> formKey,
}) async {

  unawaited(
      WaitDialog.showWaitDialog(
        context: context,
        canManuallyGoBack: false,
        loadingPhrase: 'Uploading flyer',
      )
  );

  blog('onPublish flyer : Starting flyer publish ops');

  blog('onPublish flyer : Draft flyer model is : -');
  draft.value.blogDraft();

  formKey.currentState.validate();

  blog('onPublish flyer : fields are valid');

  final FlyerModel _flyerModel = draft.value.toFlyerModel();
  _flyerModel.blogFlyer(methodName: '_onPublish');

  blog('onPublish flyer : new flyer created');

  /// upload to firebase
  final FlyerModel _uploadedFlyer = await FlyerOps.createFlyerOps(
      context: context,
      inputFlyerModel: _flyerModel,
      bzModel: bzModel
  );

  blog('onPublish flyer : new flyer uploaded and bzModel updated on firebase');

  /// update ldb
  final List<String> _newBzFlyersIDsList = <String>[... bzModel.flyersIDs, _uploadedFlyer.id];
  final BzModel _newBzModel = bzModel.copyWith(
    flyersIDs: _newBzFlyersIDsList,
  );
  await LDBOps.updateMap(
    objectID: _newBzModel.id,
    docName: LDBDoc.bzz,
    input: _newBzModel.toMap(toJSON: true),
  );
  blog('onPublish flyer : bz model updated on LDB');
  await LDBOps.insertMap(
    primaryKey: 'id',
    docName: LDBDoc.flyers,
    input: _flyerModel.toMap(toJSON: true),
  );
  blog('onPublish flyer : new flyer stored on LDB');

  /// update providers
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  _bzzProvider.setActiveBzFlyers(
    flyers: <FlyerModel>[..._bzzProvider.myActiveBzFlyers, _uploadedFlyer],
    notify: false,
  );
  blog('onPublish flyer : myActiveBzFlyers on provider updated');
  _bzzProvider.setActiveBz(
    bzModel: _newBzModel,
    notify: true,
  );
  blog('onPublish flyer : _newBzModel on provider updated');

  WaitDialog.closeWaitDialog(context);

  await TopDialog.showTopDialog(
    context: context,
    title: 'Flyer Has been Published',
    color: Colorz.green255,
  );

  Nav.goBack(context);


}
// -----------------------------------------------------------------------------
