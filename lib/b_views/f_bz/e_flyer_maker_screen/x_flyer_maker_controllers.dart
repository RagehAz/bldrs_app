import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/mutable_slide.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/a_chains_screen/a_chains_picking_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/a_flyer_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/e_db/ldb/ops/flyer_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
void initializeFlyerMakerLocalVariables({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draftFlyer,
  @required FlyerModel oldFlyer,
  @required bool mounted,
}){

  final BzModel _activeBZ = BzzProvider.proGetActiveBzModel(
    context: context,
    listen: false,
  );

  final DraftFlyerModel _draft = DraftFlyerModel.initializeDraftForEditing(
    oldFlyer: oldFlyer,
    bzModel: _activeBZ,
    currentAuthorID: AuthFireOps.superUserID(),
  );

  draftFlyer.value = _draft;


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> prepareMutableSlidesForEditing({
  @required FlyerModel flyerToEdit,
  @required ValueNotifier<DraftFlyerModel> draft,
}) async {

  /// ON CREATING A NEW DRAFT
  if (flyerToEdit != null){
    draft.value = draft.value.copyWith(
      mutableSlides: await MutableSlide.createMutableSlidesFromSlides(
        slides: flyerToEdit.slides,
        flyerID: flyerToEdit.id,
      ),
      pdf: await FileModel.preparePicForEditing(
        pic: flyerToEdit.pdf,
        fileName: flyerToEdit.pdf?.fileName,
      ),
    );
  }

}
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
Future<void> loadFlyerMakerLastSession({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
  @required FlyerModel oldFlyer,
  @required ValueNotifier<bool> isEditingFlyer,
}) async {

  final FlyerModel _lastSessionFlyer = await FlyerLDBOps.loadFlyerMakerSession(
    flyerID: draft?.value?.id ?? 'newFlyer',
  );

  if (_lastSessionFlyer != null){

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
      // -------------------------
      final BzModel _activeBZ = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: false,
      );
      // -------------------------
      final DraftFlyerModel _draft = DraftFlyerModel.initializeDraftForEditing(
        oldFlyer: _lastSessionFlyer,
        bzModel: _activeBZ,
        currentAuthorID: AuthFireOps.superUserID(),
      );

      draft.value = _draft.copyWith(
        mutableSlides: await MutableSlide.createMutableSlidesFromSlides(
          slides: _lastSessionFlyer.slides,
          flyerID: _lastSessionFlyer.id,
        ),
        pdf: await FileModel.preparePicForEditing(
          pic: _lastSessionFlyer.pdf,
          fileName: _lastSessionFlyer.pdf?.fileName,
        ),
      );
      isEditingFlyer.value = true;

    }

  }


}
// --------------------
Future<void> saveFlyerMakerSession({
  @required ValueNotifier<DraftFlyerModel> draft,
  @required ValueNotifier<DraftFlyerModel> lastDraft,
  @required bool mounted,
}) async {


  final bool _draftHasChanged = DraftFlyerModel.checkDraftsAreIdentical(
    draft1: draft.value,
    draft2: lastDraft.value,
  ) == false;

  /// => SHOULD BAKE ALL FILES IN MUTABLE SLIDES FOR LDB

  blog('saveFlyerMakerSession : _draftHasChanged : $_draftHasChanged');

  if (_draftHasChanged == true){

    final FlyerModel flyerFromDraft = await DraftFlyerModel.bakeDraftToUpload(
      draft: draft.value,
      toLDB: true,

    );

    await FlyerLDBOps.saveFlyerMakerSession(
      flyerModel: flyerFromDraft,
    );

    lastDraft.value = draft.value;

  }


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
  @required ValueNotifier<DraftFlyerModel> draft,
  @required String text,
}){

  draft.value = DraftFlyerModel.updateHeadline(
    draft: draft.value,
    newHeadline: text,
  );

}
void onUpdateFlyerDescription({
  @required ValueNotifier<DraftFlyerModel> draft,
  @required String text,
}) {
  draft.value = draft.value.copyWith(
    description: text,
  );
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectFlyerType({
  @required BuildContext context,
  @required int index,
  @required ValueNotifier<DraftFlyerModel> draft,
}) async {

  final FlyerType _selectedFlyerType = FlyerTyper.flyerTypesList[index];

  if (draft.value.flyerType != _selectedFlyerType){

    bool _canUpdate = true;

    /// SOME SPECS ARE SELECTED
    if (Mapper.checkCanLoopList(draft.value.specs) == true){

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
      draft.value = draft.value.copyWith(
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
  @required ValueNotifier<DraftFlyerModel> draft,
}) async {

  final dynamic _result = await Nav.goToNewScreen(
      context: context,
      screen: ChainsPickingScreen(
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
  @required ValueNotifier<DraftFlyerModel> draft,
  @required ZoneModel zone,
}) async {

  draft.value = draft.value.copyWith(
    zone: zone,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onChangeFlyerPDF({
  @required FileModel pdf,
  @required ValueNotifier<DraftFlyerModel> draft,
}){

  draft.value = draft.value.copyWith(
    pdf: pdf,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onRemoveFlyerPDF({
  @required ValueNotifier<DraftFlyerModel> draft,
}){
  draft.value = DraftFlyerModel.removePDF(draft.value);
}
// --------------------
/// TESTED : WORKS PERFECT
void onSwitchFlyerShowsAuthor({
  @required ValueNotifier<DraftFlyerModel> draft,
  @required bool value,
}){

  draft.value = draft.value.copyWith(
    showsAuthor: value,
  );

}
// -----------------------------------------------------------------------------

/// PUBLISHING FLYER

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onConfirmPublishFlyerButtonTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
  @required FlyerModel oldFlyer,
  @required GlobalKey<FormState> formKey,
}) async {

  if (oldFlyer != null){
    await _onPublishFlyerUpdatesTap(
      context: context,
      draft: draft,
      formKey: formKey,
      originalFlyer: oldFlyer,
    );
  }

  else {
    await _onPublishNewFlyerTap(
      context: context,
      draft: draft,
      formKey: formKey,
      originalFlyer: oldFlyer,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onPublishNewFlyerTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
  @required GlobalKey<FormState> formKey,
  @required FlyerModel originalFlyer,
}) async {

  final bool _canContinue = await _preFlyerUpdateCheck(
    context: context,
    draft: draft,
    originalFlyer: originalFlyer,
    formKey: formKey,
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
  @required ValueNotifier<DraftFlyerModel> draft,
  @required GlobalKey<FormState> formKey,
  @required FlyerModel originalFlyer,
}) async {

  final bool _canContinue = await _preFlyerUpdateCheck(
    context: context,
    draft: draft,
    originalFlyer: originalFlyer,
    formKey: formKey,
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
  @required ValueNotifier<DraftFlyerModel> draft,
  @required FlyerModel originalFlyer,
  @required GlobalKey<FormState> formKey,
}) async {

  final FlyerModel flyerFromDraft = await DraftFlyerModel.bakeDraftToUpload(
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
    if (draft.value.mutableSlides.isEmpty){

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

      final bool _isValid = formKey.currentState.validate();
      blog('_publishFlyerOps : fields are valid : $_isValid');

      if (_isValid == false){

        if (draft.value.headline.length < 10){
          TopDialog.showUnawaitedTopDialog(
            context: context,
            firstVerse: const Verse(
              pseudo: 'Flyer headline can not be less than 10 characters long',
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
/// TESTED : WORKS PERFECT
Future<void> _publishFlyerOps({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
}) async {

  unawaited(WaitDialog.showWaitDialog(
    context: context,
    loadingVerse: const Verse(
      text: 'phid_uploading_flyer',
      translate: true,
    ),
  ));

  final FlyerModel _flyerToPublish = await DraftFlyerModel.bakeDraftToUpload(
    draft: draft.value,
    overridePublishState: PublishState.published,
    toLDB: false,
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

  await WaitDialog.closeWaitDialog(context);

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _updateFlyerOps({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyerModel> draft,
  @required FlyerModel oldFlyer,
}) async {

  unawaited(WaitDialog.showWaitDialog(
    context: context,
    loadingVerse: const Verse(
      text: 'phid_uploading_flyer',
      translate: true,
    ),
  ));

  final FlyerModel _flyerToUpdate = await DraftFlyerModel.bakeDraftToUpload(
    draft: draft.value,
    toLDB: false,
  );

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
