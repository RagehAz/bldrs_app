import 'dart:async';

import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_utilities/pdf_model.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/a_pickers_screen.dart';
import 'package:bldrs/b_views/i_phid_picker/phids_picker_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:mapper/mapper.dart';
import 'package:stringer/stringer.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> loadFlyerMakerLastSession({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draft,
  @required bool mounted,
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

      draft.value.headline.text = _lastSessionDraft.headline.text;
      _lastSessionDraft.headline.dispose();

      setNotifier(
          notifier: draft,
          mounted: mounted,
          value: _lastSessionDraft.copyWith(
            headlineNode: draft.value.headlineNode,
            descriptionNode: draft.value.descriptionNode,
            formKey: draft.value.formKey,
            headline: draft.value.headline,
          ),
      );


    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
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
  @required bool mounted,
}){

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: DraftFlyer.updateHeadline(
        draft: draftNotifier.value,
        newHeadline: text,
        slideIndex: 0,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onUpdateFlyerDescription({
  @required ValueNotifier<DraftFlyer> draftNotifier,
  @required String text,
  @required bool mounted,
}) {

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value.copyWith(
        description: text,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectFlyerType({
  @required BuildContext context,
  @required int index,
  @required ValueNotifier<DraftFlyer> draftNotifier,
  @required bool mounted,
}) async {

  final FlyerType _selectedFlyerType = FlyerTyper.flyerTypesList[index];

  // blog('_selectedFlyerType : $_selectedFlyerType : Mapper.checkCanLoopList(draft.value.specs) : ${draftNotifier.value.specs}' );

  draftNotifier.value.blogDraft(
    invoker: 'onSelectFlyerType',
  );

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

      setNotifier(
          notifier: draftNotifier,
          mounted: mounted,
          value: draftNotifier.value.copyWith(
            flyerType: _selectedFlyerType,
            specs: <SpecModel>[],
          ),
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAddSpecsToDraftTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draft,
  @required bool mounted,
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

    setNotifier(
        notifier: draft,
        mounted: mounted,
        value: draft.value.copyWith(
          specs: _receivedSpecs,
        ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onZoneChanged({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draftNotifier,
  @required ZoneModel zone,
  @required bool mounted,
}) async {

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value.copyWith(
        zone: zone,
      ),
  );

}
// --------------------
/// TASK : TEST ME
void onChangeFlyerPDF({
  @required PDFModel pdfModel,
  @required ValueNotifier<DraftFlyer> draftNotifier,
  @required bool mounted,
}){

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value.copyWith(
        pdfModel: pdfModel,
      ),
  );

}
// --------------------
/// TASK : TEST ME
void onRemoveFlyerPDF({
  @required ValueNotifier<DraftFlyer> draftNotifier,
  @required bool mounted,
}){

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value.nullifyField(
        pdfModel: true,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onSwitchFlyerShowsAuthor({
  @required ValueNotifier<DraftFlyer> draftNotifier,
  @required bool value,
  @required bool mounted,
}){

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value.copyWith(
        showsAuthor: value,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onFlyerPhidLongTap({
  @required String phid,
  @required ValueNotifier<DraftFlyer> draftNotifier,
  @required bool mounted,
}){

  final List<String> _newPhids = Stringer.addOrRemoveStringToStrings(
    strings: draftNotifier.value.keywordsIDs,
    string: phid,
  );

  setNotifier(
    notifier: draftNotifier,
    mounted: mounted,
    value: draftNotifier.value.copyWith(
      keywordsIDs: _newPhids,
    ),
  );


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onFlyerPhidTap({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draftNotifier,
  @required bool mounted,
}) async {

  Keyboard.closeKeyboard(context);

  final List<String> _phids = await Nav.goToNewScreen(
    context: context,
    pageTransitionType: Nav.superHorizontalTransition(context),
    screen: PhidsPickerScreen(
      multipleSelectionMode: true,
      selectedPhids: draftNotifier.value.keywordsIDs,
      chainsIDs: FlyerTyper.getChainsIDsPerViewingEvent(
        context: context,
        flyerType: draftNotifier.value.flyerType,
        event: ViewingEvent.flyerEditor,
      ),
      onlyUseCityChains: false,
    ),
  );

  if (Mapper.checkCanLoopList(_phids) == true){

    setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value.copyWith(
        keywordsIDs: _phids,
      ),
    );

  }

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

        if (draft.value.headline.text.length < Standards.flyerHeadlineMinLength){
          await TopDialog.showTopDialog(
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
/// TESTED : WORKS PERFECT
Future<void> _publishFlyerOps({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draft,
}) async {

  pushWaitDialog(
    context: context,
    verse: const Verse(
      text: 'phid_uploading_flyer',
      translate: true,
    ),
  );

  await FlyerProtocols.composeFlyer(
    context: context,
    draftFlyer: draft.value,
  );

  await WaitDialog.closeWaitDialog(context);

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _updateFlyerOps({
  @required BuildContext context,
  @required ValueNotifier<DraftFlyer> draft,
  @required FlyerModel oldFlyer,
}) async {

  pushWaitDialog(
    context: context,
    verse: const Verse(
      text: 'phid_uploading_flyer',
      translate: true,
    ),
  );

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
