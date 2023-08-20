import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/f_flyer/sub/slide_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
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
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/strings/stringer.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> loadFlyerMakerLastSession({
  required BuildContext context,
  required ValueNotifier<DraftFlyer?>? draft,
  required bool mounted,
}) async {

  final DraftFlyer? _lastSessionDraft = await FlyerLDBOps.loadFlyerMakerSession(
    flyerID: draft?.value?.id ?? DraftFlyer.newDraftID,
    bzID: draft?.value?.bzID,
  );

  if (_lastSessionDraft != null){

    final bool _continue = await CenterDialog.showCenterDialog(
      titleVerse: const Verse(
        id: 'phid_load_last_session_data_q',
        translate: true,
      ),
      // bodyVerse: const Verse(
      //   text: 'phid_want_to_load_last_session_q',
      //   translate: true,
      // ),
      boolDialog: true,
    );

    if (_continue == true){

      draft?.value?.headline?.text = _lastSessionDraft.headline?.text ?? '';
      _lastSessionDraft.headline?.dispose();

      setNotifier(
          notifier: draft,
          mounted: mounted,
          value: _lastSessionDraft.copyWith(
            headlineNode: draft?.value?.headlineNode,
            descriptionNode: draft?.value?.descriptionNode,
            formKey: draft?.value?.formKey,
            headline: draft?.value?.headline,
          ),
      );


    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> saveFlyerMakerSession({
  required ValueNotifier<DraftFlyer?> draft,
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
    boolDialog: true,
    titleVerse: const Verse(
      id: 'phid_cancel_flyer',
      translate: true,
    ),
    bodyVerse: const Verse(
      id: 'phid_all_progress_will_be_lost',
      translate: true,
    ),
    confirmButtonVerse: const Verse(
      id: 'phid_yes_cancel',
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
  required ValueNotifier<DraftFlyer?> draftNotifier,
  required String? text,
  required bool mounted,
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
  required ValueNotifier<DraftFlyer?> draftNotifier,
  required String? text,
  required bool mounted,
}) {

  draftNotifier.value?.description?.text = text ?? '';
  draftNotifier.value?.copyWith();

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectFlyerType({
  required BuildContext context,
  required int index,
  required ValueNotifier<DraftFlyer?> draftNotifier,
  required bool mounted,
}) async {

  final FlyerType _selectedFlyerType = FlyerTyper.flyerTypesList[index];

  // blog('_selectedFlyerType : $_selectedFlyerType : Mapper.checkCanLoopList(draft.value.specs) : ${draftNotifier.value.specs}' );

  draftNotifier.value?.blogDraft(
    invoker: 'onSelectFlyerType',
  );

  if (draftNotifier.value?.flyerType != _selectedFlyerType){

    bool _canUpdate = true;

    /// SOME SPECS ARE SELECTED
    if (Mapper.checkCanLoopList(draftNotifier.value?.phids) == true){

      _canUpdate = await CenterDialog.showCenterDialog(
        titleVerse: const Verse(
          id: 'phid_reset_selected_keywords_?',
          translate: true,
        ),
        boolDialog: true,
      );

    }

    if (_canUpdate == true){

      setNotifier(
          notifier: draftNotifier,
          mounted: mounted,
          value: draftNotifier.value?.copyWith(
            flyerType: _selectedFlyerType,
            /// KEEP THEM, NO NEED TO DELETE THEM
            // specs: <SpecModel>[],
            // keywordsIDs: <String>[],
          ),
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAddSpecsToDraftTap({
  required BuildContext context,
  required ValueNotifier<DraftFlyer?> draft,
  required bool mounted,
}) async {

  final dynamic _result = await Nav.goToNewScreen(
      context: context,
      screen: PickersScreen(
        pageTitleVerse: const Verse(
          id: 'phid_flyer_specs',
          translate: true,
        ),
        selectedSpecs: draft.value?.specs,
        isMultipleSelectionMode: true,
        onlyUseZoneChains: false,
        flyerTypeFilter: draft.value?.flyerType,
        zone: draft.value?.zone,
      )
  );

  final List<SpecModel>? _receivedSpecs = _result;

  if (Mapper.checkCanLoopList(_receivedSpecs) == true){

    SpecModel.blogSpecs(_receivedSpecs);

    setNotifier(
        notifier: draft,
        mounted: mounted,
        value: draft.value?.copyWith(
          specs: _receivedSpecs,
        ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onZoneChanged({
  required BuildContext context,
  required ValueNotifier<DraftFlyer?> draftNotifier,
  required ZoneModel? zone,
  required bool mounted,
}) async {

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value?.copyWith(
        zone: zone,
      ),
  );

}
// --------------------
/// TASK : TEST ME
void onChangeFlyerPDF({
  required PDFModel? pdfModel,
  required ValueNotifier<DraftFlyer?> draftNotifier,
  required bool mounted,
}){

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value?.copyWith(
        pdfModel: pdfModel,
      ),
  );

}
// --------------------
/// TASK : TEST ME
void onRemoveFlyerPDF({
  required ValueNotifier<DraftFlyer?> draftNotifier,
  required bool mounted,
}){

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value?.nullifyField(
        pdfModel: true,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onSwitchFlyerShowsAuthor({
  required ValueNotifier<DraftFlyer?> draftNotifier,
  required bool value,
  required bool mounted,
}){

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value?.copyWith(
        showsAuthor: value,
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onPosterChanged({
  required ValueNotifier<DraftFlyer?> draftNotifier,
  required PicModel? poster,
  required bool mounted,
}) async {

  final bool _identical = PicModel.checkPicsAreIdentical(
      pic1: poster,
      pic2: draftNotifier.value?.poster,
  );

  if (poster != null && draftNotifier.value != null && _identical == false){

    setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value?.copyWith(
        poster: poster,
      ),
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onFlyerPhidLongTap({
  required String phid,
  required ValueNotifier<DraftFlyer?> draftNotifier,
  required bool mounted,
}){

  final List<String> _newPhids = Stringer.addOrRemoveStringToStrings(
    strings: draftNotifier.value?.phids,
    string: phid,
  );

  setNotifier(
    notifier: draftNotifier,
    mounted: mounted,
    value: draftNotifier.value?.copyWith(
      phids: _newPhids,
    ),
  );


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAddPhidsToFlyerTap({
  required BuildContext context,
  required ValueNotifier<DraftFlyer?> draftNotifier,
  required bool mounted,
}) async {

  Keyboard.closeKeyboard();

  final List<String> _phids = await PhidsPickerScreen.goPickPhids(
    context: context,
    flyerType: draftNotifier.value?.flyerType,
    event: ViewingEvent.flyerEditor,
    onlyUseZoneChains: false,
    selectedPhids: draftNotifier.value?.phids,
    slideScreenFromEnLeftToRight: true,
  );

  if (Mapper.checkCanLoopList(_phids) == true){

    setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value?.copyWith(
        phids: _phids,
      ),
    );

  }

}
// -----------------------------------------------------------------------------

/// PUBLISHING FLYER

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onConfirmPublishFlyerButtonTap({
  required DraftFlyer? draft,
  required FlyerModel? oldFlyer,
}) async {

  if (Mapper.boolIsTrue(draft?.firstTimer) == true){
    await onPublishNewFlyerTap(
      draft: draft,
    );
  }

  else {
    await _onPublishFlyerUpdatesTap(
      draft: draft,
      originalFlyer: oldFlyer,
    );
  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onPublishNewFlyerTap({
  required DraftFlyer? draft,
}) async {

  final bool _canContinue = await _preFlyerUpdateCheck(
    draft: draft,
    originalFlyer: null,
  );

  if (_canContinue == true){

    await _publishFlyerOps(
      draft: draft,
    );

    await FlyerLDBOps.deleteFlyerMakerSession(flyerID: draft?.id);

    UiProvider.proSetAfterHomeRoute(
      routeName: Routing.myBzFlyersPage,
      arguments: draft!.bzID,
      notify: true,
    );

    await BldrsNav.goToLogoScreenAndRemoveAllBelow(
      animatedLogoScreen: false,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _onPublishFlyerUpdatesTap({
  required DraftFlyer? draft,
  required FlyerModel? originalFlyer,
}) async {

  final bool _canContinue = await _preFlyerUpdateCheck(
    draft: draft,
    originalFlyer: originalFlyer,
  );

  if (_canContinue == true){

    await _updateFlyerOps(
      draft: draft,
      oldFlyer: originalFlyer,
    );

    await FlyerLDBOps.deleteFlyerMakerSession(flyerID: draft?.id);

    await Nav.goBack(
      context: getMainContext(),
      invoker: 'onPublishFlyerUpdatesTap',
      passedData: true,
    );

    // await TopDialog.showTopDialog(
    //   context: context,
    //   firstVerse: const Verse(
    //     id: 'phid_flyer_has_been_updated',
    //     translate: true,
    //   ),
    //   color: Colorz.green255,
    //   textColor: Colorz.white255,
    // );

  }

}
// -----------------------------------------------------------------------------

/// PRE-PUBLISH CHECKUPS

// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _preFlyerUpdateCheck({
  required DraftFlyer? draft,
  required FlyerModel? originalFlyer,
}) async {

  final FlyerModel? flyerFromDraft = await DraftFlyer.draftToFlyer(
    draft: draft,
    slidePicType: SlidePicType.small,
    toLDB: false,

  );

  final bool _areIdentical = FlyerModel.checkFlyersAreIdentical(
    flyer1: originalFlyer,
    flyer2: flyerFromDraft,
  );

  bool? _canContinue;

  if (_areIdentical == true){

    await CenterDialog.showCenterDialog(
      titleVerse: const Verse(
        pseudo: 'Flyer was not changed',
        id: 'phid_flyer_was_not_changed',
        translate: true,
      ),
    );

    _canContinue = false;

  }

  else {
    if (Mapper.checkCanLoopList(draft?.draftSlides) == false){

      await CenterDialog.showCenterDialog(
        titleVerse: const Verse(
          id: 'phid_add_images',
          translate: true,
        ),
        bodyVerse: const Verse(
          pseudo: 'Add at least one image to the flyer',
          id: 'phid_add_flyer_images_notice',
          translate: true,
        ),
      );

    }

    else {

      final bool _isValid = Formers.validateForm(draft?.formKey);
      blog('_publishFlyerOps : fields are valid : $_isValid');

      if (_isValid == false){

        if ((draft?.headline?.text.length ?? 0) < Standards.flyerHeadlineMinLength){
          await TopDialog.showTopDialog(
            firstVerse: const Verse(
              pseudo: 'Flyer headline can not be less than ${Standards.flyerHeadlineMinLength} characters long',
              id: 'phid_flyer_headline_length_notice',
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

  if (Mapper.boolIsTrue(_canContinue) == true){

    _canContinue = await Dialogs.confirmProceed(
      titleVerse: const Verse(
        id: 'phid_confirm_upload_flyer',
        translate: true,
      ),
    );

  }

  return _canContinue ?? false;
}
// -----------------------------------------------------------------------------

/// PUBLISHING

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _publishFlyerOps({
  required DraftFlyer? draft,
}) async {

  WaitDialog.showUnawaitedWaitDialog(
    verse: const Verse(
      id: 'phid_uploading_flyer',
      translate: true,
    ),
  );

  await FlyerProtocols.composeFlyer(
    draftFlyer: draft,
  );

  await WaitDialog.closeWaitDialog();

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _updateFlyerOps({
  required DraftFlyer? draft,
  required FlyerModel? oldFlyer,
}) async {

  WaitDialog.showUnawaitedWaitDialog(
    verse: const Verse(
      id: 'phid_uploading_flyer',
      translate: true,
    ),
  );

  final bool _imALoneAuthor = await AuthorModel.checkImALoneAuthor(
    bzID: draft?.bzID,
  );

  await FlyerProtocols.renovateDraft(
    newDraft: draft,
    oldFlyer: oldFlyer,
    sendFlyerUpdateNoteToItsBz: !_imALoneAuthor,
    updateFlyerLocally: _imALoneAuthor,
    resetActiveBz: _imALoneAuthor,
  );

  await WaitDialog.closeWaitDialog();

}
// -----------------------------------------------------------------------------
