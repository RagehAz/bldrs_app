import 'dart:async';

import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/a_pickers_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
///
Future<void> loadFlyerMakerLastSession({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draft,
}) async {

  final DraftFlyer _lastSessionDraft = await FlyerLDBOps.loadFlyerMakerSession(
    flyerID: draft?.value?.id ?? DraftFlyer.newDraftID,
  );

  if (_lastSessionDraft != null){

    final bool _continue = await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_load_last_session_data_q',
        translate: true,
      ),
      // bodyVerse: const Verse(
      //   text: 'phid_want_to_load_last_session_q',
      //   translate: true,
      // ),
      boolDialog: true,
    );

    if (_continue == true){

      draft.value = _lastSessionDraft.copyWith(
        headlineNode: draft.value.headlineNode,
        descriptionNode: draft.value.descriptionNode,
        formKey: draft.value.formKey,
      );

    }

  }


}
// --------------------
///
Future<void> saveFlyerMakerSession({
  @required ValueNotifier<DraftFlyer> draft,
}) async {

  await FlyerLDBOps.saveFlyerMakerSession(
    draftFlyer: draft.value,
  );

}
// -----------------------------------------------------------------------------

/// CANCEL FLYER EDITING

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onCancelFlyerCreation(BuildContext context) async {

  final bool result = await CenterDialog.showCenterDialog(
    context: context,
    boolDialog: true,
    titleVerse: const Verse(
      text: 'phid_cancel_flyer',
      translate: true,
    ),
    bodyVerse: const Verse(
      text: 'phid_all_progress_will_be_lost',
      translate: true,
    ),
    confirmButtonVerse: const Verse(
      text: 'phid_yes_cancel',
      translate: true,
    ),
  );

  if (result == true){
    await Nav.goBack(
      context: context,
      invoker: 'onCancelFlyerCreation',
    );
  }

}
// -----------------------------------------------------------------------------

/// FLYER EDITING

// --------------------
/// TESTED : WORKS PERFECT
void onUpdateFlyerHeadline({
  @required ValueNotifier<DraftFlyer> draftNotifier,
  @required String text,
}){

  draftNotifier.value = DraftFlyer.updateHeadline(
    draft: draftNotifier.value,
    newHeadline: text,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onUpdateFlyerDescription({
  @required ValueNotifier<DraftFlyer> draftNotifier,
  @required String text,
}) {
  draftNotifier.value = draftNotifier.value.copyWith(
    description: text,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectFlyerType({
  @required BuildContext context,
  @required int index,
  @required ValueNotifier<DraftFlyer> draftNotifier,
}) async {

  final FlyerType _selectedFlyerType = FlyerTyper.flyerTypesList[index];

  blog('_selectedFlyerType : $_selectedFlyerType : Mapper.checkCanLoopList(draft.value.specs) : ${draftNotifier.value.specs}' );

  draftNotifier.value.blogDraft();

  if (draftNotifier.value.flyerType != _selectedFlyerType){

    bool _canUpdate = true;

    /// SOME SPECS ARE SELECTED
    if (Mapper.checkCanLoopList(draftNotifier.value.specs) == true){

      _canUpdate = await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: const Verse(
          pseudo: 'Delete selected Specifications ?',
          text: 'phid_delete_selected_specs_?',
          translate: true,
        ),
        bodyVerse: const Verse(
          pseudo: 'All selected specifications will be deleted\nDo you wish to continue ?',
          text: 'phid_delete_selected_specs_warning',
          translate: true,
        ),
        boolDialog: true,
      );

    }

    if (_canUpdate == true){
      draftNotifier.value = draftNotifier.value.copyWith(
        flyerType: _selectedFlyerType,
        specs: <SpecModel>[],
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAddSpecsToDraftTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draft,
}) async {

  final dynamic _result = await Nav.goToNewScreen(
      context: context,
      screen: PickersScreen(
        pageTitleVerse: const Verse(
          text: 'phid_flyer_specs',
          translate: true,
        ),
        selectedSpecs: draft.value.specs,
        isMultipleSelectionMode: true,
        onlyUseCityChains: false,
        flyerTypeFilter: draft.value.flyerType,
        zone: draft.value.zone,
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
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onZoneChanged({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draftNotifier,
  @required ZoneModel zone,
}) async {

  draftNotifier.value = draftNotifier.value.copyWith(
    zone: zone,
  );

}
// --------------------
///
void onChangeFlyerPDF({
  @required PDFModel pdfModel,
  @required ValueNotifier<DraftFlyer> draftNotifier,
}){

  draftNotifier.value = draftNotifier.value.copyWith(
    pdfModel: pdfModel,
  );

}
// --------------------
///
void onRemoveFlyerPDF({
  @required ValueNotifier<DraftFlyer> draftNotifier,
}){
  draftNotifier.value = draftNotifier.value.nullifyField(
    pdfModel: true,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
void onSwitchFlyerShowsAuthor({
  @required ValueNotifier<DraftFlyer> draftNotifier,
  @required bool value,
}){

  draftNotifier.value = draftNotifier.value.copyWith(
    showsAuthor: value,
  );

}
// -----------------------------------------------------------------------------

/// PUBLISHING FLYER

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onConfirmPublishFlyerButtonTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draft,
  @required FlyerModel oldFlyer,
}) async {

  if (draft.value.firstTimer == true){
    await _onPublishNewFlyerTap(
      context: context,
      draft: draft,
      originalFlyer: oldFlyer,
    );
  }

  else {
    await _onPublishFlyerUpdatesTap(
      context: context,
      draft: draft,
      originalFlyer: oldFlyer,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onPublishNewFlyerTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draft,
  @required FlyerModel originalFlyer,
}) async {

  final bool _canContinue = await _preFlyerUpdateCheck(
    context: context,
    draft: draft,
    originalFlyer: originalFlyer,
  );

  if (_canContinue == true){

    await _publishFlyerOps(
      context: context,
      draft: draft,
    );

    await FlyerLDBOps.deleteFlyerMakerSession(flyerID: draft.value.id);

    await Nav.goBack(
      context: context,
      invoker: 'onPublishNewFlyerTap',
    );

    await TopDialog.showTopDialog(
      context: context,
      firstVerse: const Verse(
        text: 'phid_flyer_has_been_published',
        translate: true,
      ),
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onPublishFlyerUpdatesTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draft,
  @required FlyerModel originalFlyer,
}) async {

  final bool _canContinue = await _preFlyerUpdateCheck(
    context: context,
    draft: draft,
    originalFlyer: originalFlyer,
  );

  if (_canContinue == true){

    await _updateFlyerOps(
      context: context,
      draft: draft,
      oldFlyer: originalFlyer,
    );

    await FlyerLDBOps.deleteFlyerMakerSession(flyerID: draft.value.id);

    await Nav.goBack(
      context: context,
      invoker: 'onPublishFlyerUpdatesTap',
    );

    await TopDialog.showTopDialog(
      context: context,
      firstVerse: const Verse(
        text: 'phid_flyer_has_been_updated',
        translate: true,
      ),
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// -----------------------------------------------------------------------------

/// PRE-PUBLISH CHECKUPS

// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _preFlyerUpdateCheck({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draft,
  @required FlyerModel originalFlyer,
}) async {

  final FlyerModel flyerFromDraft = await DraftFlyer.draftToFlyer(
    draft: draft.value,
    toLDB: false,

  );

  final bool _areIdentical = FlyerModel.checkFlyersAreIdentical(
    flyer1: originalFlyer,
    flyer2: flyerFromDraft,
  );

  bool _canContinue;

  if (_areIdentical == true){

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        pseudo: 'Flyer was not changed',
        text: 'phid_flyer_was_not_changed',
        translate: true,
      ),
    );

    _canContinue = false;

  }

  else {
    if (draft.value.draftSlides.isEmpty){

      await CenterDialog.showCenterDialog(
        context: context,
        titleVerse: const Verse(
          text: 'phid_add_images',
          translate: true,
        ),
        bodyVerse: const Verse(
          pseudo: 'Add at least one image to the flyer',
          text: 'phid_add_flyer_images_notice',
          translate: true,
        ),
      );

    }

    else {

      final bool _isValid = Formers.validateForm(draft.value.formKey);
      blog('_publishFlyerOps : fields are valid : $_isValid');

      if (_isValid == false){

        if (draft.value.headline.length < Standards.flyerHeadlineMinLength){
          TopDialog.showUnawaitedTopDialog(
            context: context,
            firstVerse: const Verse(
              pseudo: 'Flyer headline can not be less than ${Standards.flyerHeadlineMinLength} characters long',
              text: 'phid_flyer_headline_length_notice',
              translate: true,
            ),
          );
        }

      }

      else {
        _canContinue = true;
      }

    }

  }

  if (_canContinue == true){

    _canContinue = await Dialogs.confirmProceed(
      context: context,
      titleVerse: const Verse(
        text: 'phid_confirm_upload_flyer',
        translate: true,
      ),
    );

  }

  return _canContinue;
}
// -----------------------------------------------------------------------------

/// PUBLISHING

// --------------------
///
Future<void> _publishFlyerOps({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draft,
}) async {

  unawaited(WaitDialog.showWaitDialog(
    context: context,
    loadingVerse: const Verse(
      text: 'phid_uploading_flyer',
      translate: true,
    ),
  ));

  await FlyerProtocols.composeFlyer(
    context: context,
    draftFlyer: draft.value,
  );

  await WaitDialog.closeWaitDialog(context);

}
// --------------------
///
Future<void> _updateFlyerOps({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draft,
  @required FlyerModel oldFlyer,
}) async {

  unawaited(WaitDialog.showWaitDialog(
    context: context,
    loadingVerse: const Verse(
      text: 'phid_uploading_flyer',
      translate: true,
    ),
  ));

  final bool _imALoneAuthor = await AuthorModel.checkImALoneAuthor(
    context: context,
    bzID: oldFlyer.bzID,
  );

  await FlyerProtocols.renovate(
    context: context,
    newDraft: draft.value,
    oldFlyer: oldFlyer,
    sendFlyerUpdateNoteToItsBz: !_imALoneAuthor,
    updateFlyerLocally: _imALoneAuthor,
    resetActiveBz: _imALoneAuthor,
  );

  await WaitDialog.closeWaitDialog(context);

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
