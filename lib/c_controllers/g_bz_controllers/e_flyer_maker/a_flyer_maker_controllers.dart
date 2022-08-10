import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/j_chains/a_chains_screen.dart';
import 'package:bldrs/b_views/x_screens/j_chains/a_no_need_no_more_isa/e_keywords_picker_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// ----------------------------------
/// TESTED : WORKS PERFECT
ValueNotifier<DraftFlyerModel> initializeDraft({
  @required BuildContext context,
}){

  final BzModel _activeBZ = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
  );

  final DraftFlyerModel _draft = DraftFlyerModel.createNewDraft(
    bzModel: _activeBZ,
    authorID: AuthFireOps.superUserID(),
  );

  return ValueNotifier(_draft);
}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> initializeExistingFlyerDraft({
  @required FlyerModel flyerToEdit,
  @required ValueNotifier<DraftFlyerModel> draft,
}) async {

  /// ON CREATING A NEW DRAFT
  if (flyerToEdit != null){
    draft.value = await DraftFlyerModel.createDraftFromFlyer(flyerToEdit);
  }

}
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

/// CANCEL FLYER EDITING

// ----------------------------------
/// TESTED : WORKS PERFECT
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

/// FLYER EDITING

// ----------------------------------
/// TESTED : WORKS PERFECT
void onUpdateFlyerHeadline({
  @required ValueNotifier<DraftFlyerModel> draft,
  @required TextEditingController headlineController,
}){

  draft.value = DraftFlyerModel.updateHeadline(
    controller : headlineController,
    draft: draft.value,
  );

}
// ----------------------------------
String flyerHeadlineValidator({
  @required TextEditingController headlineController,
}){

  final bool _isEmpty = headlineController.text.trim() == '';
  final bool _isShort = headlineController.text.length < Standards.flyerHeadlineMinLength;

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
// ----------------------------------
/// TESTED : WORKS PERFECT
void onSelectFlyerType({
  @required int index,
  @required ValueNotifier<DraftFlyerModel> draft,
}){

  blog('tapped on index : $index');

  final FlyerType _selectedFlyerType = FlyerTyper.flyerTypesList[index];

  draft.value = draft.value.copyWith(
    flyerType: _selectedFlyerType,
  );
}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onAddKeywordsTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
}) async {

  final List<String> _result = await Nav.goToNewScreen(
      context: context,
      screen: KeywordsPickerScreen(
        flyerTypes: <FlyerType>[draft.value.flyerType],
        selectedKeywordsIDs: draft.value.keywordsIDs,
      )
  );

  blog('onAddKeywordsTap : _result : $_result');

  if (_result != null){

    draft.value = draft.value.copyWith(
      keywordsIDs: _result,
    );

  }

}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onAddSpecsTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
}) async {

  final String _flyerTypeString = FlyerTyper.translateFlyerType(
    context: context,
    flyerType: draft.value.flyerType,
    pluralTranslation: false,
  );

  final dynamic _result = await Nav.goToNewScreen(
      context: context,
      screen: ChainsScreen(
        pageTitle: '$_flyerTypeString Specifications',
        selectedSpecs: draft.value.specs,
        isMultipleSelectionMode: true,
        onlyUseCityChains: false,
        flyerTypeChainFilter: draft.value.flyerType,
      )
  );

  final List<SpecModel> _receivedSpecs = _result;

  if (Mapper.checkCanLoopList(_receivedSpecs) == true){

    SpecModel.blogSpecs(_receivedSpecs);

    draft.value = draft.value.copyWith(
      specs: _receivedSpecs,
    );

  }

}
// ----------------------------------
/// TESTED : WORKS PERFECT
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

/// PUBLISHING FLYER

// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onPublishNewFlyerTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
  @required GlobalKey<FormState> formKey,
}) async {

  final bool _canContinue = await _prePublishFlyerCheck(
    context: context,
    draft: draft,
    formKey: formKey,
  );

  if (_canContinue == true){

    await _publishFlyerOps(
      context: context,
      draft: draft,
    );

    Nav.goBack(context);

    await TopDialog.showTopDialog(
      context: context,
      firstLine: 'Flyer Has been Published',
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onPublishFlyerUpdatesTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
  @required GlobalKey<FormState> formKey,
  @required FlyerModel originalFlyer,
}) async {

  bool _canContinue = await _prePublishFlyerCheck(
    context: context,
    draft: draft,
    formKey: formKey,
  );

  _canContinue = await _preFlyerUpdateCheck(
    context: context,
    draft: draft,
    originalFlyer: originalFlyer,
  );

  if (_canContinue == true){

    blog('cool you can go fuck yourself now');

    await _updateFlyerOps(
      context: context,
      draft: draft,
      oldFlyer: originalFlyer,
    );

    Nav.goBack(context);

    await TopDialog.showTopDialog(
      context: context,
      firstLine: 'Flyer Has been Updated',
      color: Colorz.green255,
      textColor: Colorz.white255,
    );


  }

}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<bool> _preFlyerUpdateCheck({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
  @required FlyerModel originalFlyer,
}) async {

  final FlyerModel flyerFromDraft = draft.value.toFlyerModel();

  final bool _areIdentical = FlyerModel.checkFlyersAreIdentical(
    flyer1: originalFlyer,
    flyer2: flyerFromDraft,
  );

  bool _canContinue;

  if (_areIdentical == true){

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Flyer was not changed',
    );

    _canContinue = false;

  }
  else {
    _canContinue = true;
  }

  return _canContinue;
}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<bool> _prePublishFlyerCheck({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
  @required ValueNotifier<DraftFlyerModel> draft,
}) async {

  bool _canContinue = false;


  if (draft.value.mutableSlides.isEmpty){

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Add Images',
      body: 'Add at least one image to the flyer',
    );

  }

  else {

    final bool _isValid = formKey.currentState.validate();
    blog('_publishFlyerOps : fields are valid : $_isValid');

    if (_isValid == false){

      if (draft.value.headlineController.text.length < 10){
        TopDialog.showUnawaitedTopDialog(
          context: context,
          firstLine: 'Flyer headline can not be less than 10 characters long',
        );
      }

    }

    else {
      _canContinue = true;
    }

  }

  return _canContinue;
}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> _publishFlyerOps({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
}) async {

  unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingPhrase: 'Uploading flyer',
      ));

  final FlyerModel _flyerToPublish = draft.value.toFlyerModel().copyWith(
    publishState: PublishState.published,
  );

  final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: false,
  );

  await FlyerProtocols.composeFlyer(
    context: context,
    flyerModel: _flyerToPublish,
    bzModel: _bzModel,
  );

  WaitDialog.closeWaitDialog(context);

}
// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> _updateFlyerOps({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
  @required FlyerModel oldFlyer,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Update Flyer ?',
    boolDialog: true,
    confirmButtonText: 'Update',
  );

  if (_result == true){

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Uploading flyer',
    ));

    final FlyerModel _flyerToUpdate = draft.value.toFlyerModel();

    final BzModel _bzModel = await BzProtocols.fetchBz(
        context: context,
        bzID: oldFlyer.bzID,
    );

    await FlyerProtocols.renovateFlyer(
      context: context,
      newFlyer: _flyerToUpdate,
      oldFlyer: oldFlyer,
      bzModel: _bzModel,
      sendFlyerUpdateNoteToItsBz: _bzModel.authors.length > 1,
      updateFlyerLocally: _bzModel.authors.length == 1,
      resetActiveBz: _bzModel.authors.length == 1,
    );

    WaitDialog.closeWaitDialog(context);

  }

}
// -----------------------------------------------------------------------------
