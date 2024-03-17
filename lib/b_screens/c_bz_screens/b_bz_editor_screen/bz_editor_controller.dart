import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/strings/stringer.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/draft/draft_bz.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:basics/mediator/models/media_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/d_authorship_responding.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_media_maker.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> loadBzEditorLastSession({
  required BuildContext context,
  required ValueNotifier<DraftBz?>? draftNotifier,
  required bool mounted,
}) async {

  final DraftBz? _lastSessionDraft = await BzLDBOps.loadBzEditorSession(
    context: context,
    bzID: draftNotifier?.value?.id,
  );

  if (_lastSessionDraft != null){

    final bool _continue = await BldrsCenterDialog.showCenterDialog(
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

      draftNotifier?.value?.nameController?.text = _lastSessionDraft.nameController?.text ?? '';
      draftNotifier?.value?.aboutController?.text = _lastSessionDraft.aboutController?.text ?? '';

      setNotifier(
          notifier: draftNotifier,
          mounted: mounted,
          value: DraftBz.reAttachNodes(
            draftFromLDB: _lastSessionDraft,
            originalDraft: draftNotifier?.value,
          ),
      );


    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> saveBzEditorSession({
  required ValueNotifier<DraftBz?>? draftNotifier,
  required bool mounted,
}) async {

  triggerCanValidateDraftBz(
    draftNotifier: draftNotifier,
    setTo: true,
    mounted: mounted,
  );

  // blog('saving bz name : ${draftNotifier?.value?.nameController?.text} : ${draftNotifier?.value?.aboutController?.text}');

  await BzLDBOps.saveBzEditorSession(
      draft: draftNotifier?.value,
  );

}
// -----------------------------------------------------------------------------

/// CONFIRMATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onConfirmBzEdits({
  required ValueNotifier<DraftBz?> draftNotifier,
  required BzModel? oldBz,
  required bool mounted,
}) async {

  triggerCanValidateDraftBz(
    draftNotifier: draftNotifier,
    setTo: true,
    mounted: mounted,
  );

  await Keyboard.closeKeyboard();

  final bool _canContinue = await _preUploadCheckups(
    draftNotifier: draftNotifier,
  );

  if (_canContinue == true){

    BzModel? _uploadedBz = await _uploadDraftBz(
      draftNotifier: draftNotifier,
      oldBz: oldBz,
    );

    if (_uploadedBz == null){
      await Dialogs.centerNotice(
        verse: Verse.plain('Could not continue'),
        body: Verse.plain('Something went wrong, please try again'),
      );
    }

    else {

      await Future.wait(<Future>[
        BzLDBOps.deleteBzEditorSession(_uploadedBz.id),
        if (_uploadedBz.id != draftNotifier.value?.id)
        BzLDBOps.deleteBzEditorSession(draftNotifier.value?.id),
      ]);

      if (Mapper.boolIsTrue(draftNotifier.value?.firstTimer) == true){
        _uploadedBz = await AuthorshipRespondingProtocols.goToAuthorEditor(
          bzID: _uploadedBz.id,
        );
      }

      await Routing.restartToAfterHomeRoute(
        routeName: TabName.bid_MyBz_Info,
        arguments: _uploadedBz?.id,
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _preUploadCheckups({
  required ValueNotifier<DraftBz?> draftNotifier,
}) async {

  bool _canContinue = Formers.validateForm(draftNotifier.value?.formKey);

  if (_canContinue == true){

    /// REQUEST CONFIRMATION
    _canContinue = await BldrsCenterDialog.showCenterDialog(
      bodyVerse: const Verse(
        id: 'phid_you_want_to_continue',
        translate: true,
      ),
      boolDialog: true,
    );

  }

  return _canContinue;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<BzModel?> _uploadDraftBz({
  required ValueNotifier<DraftBz?> draftNotifier,
  required BzModel? oldBz,
}) async {

  BzModel?_output;

  /// CREATING NEW BZ
  if (Mapper.boolIsTrue(draftNotifier.value?.firstTimer) == true){
    _output = await BzProtocols.composeBz(
      newDraft: draftNotifier.value,
      userModel: UsersProvider.proGetMyUserModel(
        context: getMainContext(),
        listen: false,
      ),
    );
  }

  /// EDITING EXISTING BZ
  else {

    // blog('draftNotifier.value.hasNewLogo : ${draftNotifier.value?.hasNewLogo}');
    // DraftBz.toBzModel(draftNotifier.value).blogBz(invoker: 'what the bz');
    // blog('draftNotifier.value.logoPicModel.bytes.length : ${draftNotifier.value?.logoPicModel?.bytes?.length}');

    _output = await BzProtocols.renovateBz(
      newBz: DraftBz.toBzModel(draftNotifier.value),
      oldBz: oldBz,
      showWaitDialog: true,
      newLogo: Mapper.boolIsTrue(draftNotifier.value?.hasNewLogo) == true ?
      draftNotifier.value?.logoPicModel
          :
      null,
    );

  }

  // setNotifier(
  //     notifier: notifier,
  //     mounted: mounted,
  //     value: value
  // );

  return _output;
}
// -----------------------------------------------------------------------------

/// MODIFIERS

// --------------------
/// TESTED : WORKS PERFECT
void triggerCanValidateDraftBz({
  required bool setTo,
  required ValueNotifier<DraftBz?>? draftNotifier,
  required bool mounted,
}){

  if (draftNotifier?.value?.canValidate == setTo){
    // nothing
  }
  else {

    setNotifier(
        notifier: draftNotifier,
        mounted: mounted,
        value: draftNotifier?.value?.copyWith(
          canValidate: setTo,
        ),
    );

  }
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChangeBzSection({
  required BuildContext context,
  required int index,
  required ValueNotifier<DraftBz?>? draftNotifier,
  required bool mounted,
}) async {

  final BzSection _selectedSection = BzTyper.bzSectionsList[index];
  final List<BzType> _generatedInactiveBzTypes = BzTyper.concludeDeactivatedBzTypesBySection(
    bzSection: _selectedSection,
  );

  DraftBz? _newDraft = draftNotifier?.value?.copyWith(
    bzSection: _selectedSection,
    inactiveBzTypes: _generatedInactiveBzTypes,
    inactiveBzForms: [],
    bzTypes: [],
  );

  _newDraft = _newDraft?.nullifyField(
    bzForm: true,
    inactiveBzForms: true,
    bzTypes: true,
  );

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: _newDraft
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChangeBzType({
  required BuildContext context,
  required int index,
  required ValueNotifier<DraftBz?> draftNotifier,
  required bool mounted,
}) async {

  final BzType _selectedBzType = BzTyper.bzTypesList[index];

  /// UPDATE SELECTED BZ TYPES
  final List<BzType> _newBzTypes = BzTyper.addOrRemoveBzTypeToBzzTypes(
    selectedBzTypes: draftNotifier.value?.bzTypes,
    newSelectedBzType: _selectedBzType,
  );

  /// INACTIVE OTHER BZ TYPES
  final List<BzType> _inactiveBzTypes = BzTyper.concludeDeactivatedBzTypesBasedOnSelectedBzTypes(
    newSelectedType: _selectedBzType,
    selectedBzTypes: _newBzTypes,
    selectedBzSection: draftNotifier.value?.bzSection,
  );

  /// INACTIVATE BZ FORMS
  final List<BzForm> _inactiveBzForms = BzTyper.concludeInactiveBzFormsByBzTypes(_newBzTypes);

  DraftBz? _newDraft = draftNotifier.value?.copyWith(
    bzTypes: _newBzTypes,
    inactiveBzTypes: _inactiveBzTypes,
    inactiveBzForms: _inactiveBzForms,
  );

  _newDraft = _newDraft?.nullifyField(
    bzForm: true,
  );

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: _newDraft
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onChangeBzForm({
  required int index,
  required ValueNotifier<DraftBz?> draftNotifier,
  required bool mounted,
}){

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value?.copyWith(
        bzForm: BzTyper.bzFormsList[index],
      ),
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChangeBzLogo({
  required ValueNotifier<DraftBz?> draftNotifier,
  required MediaOrigin mediaSource,
  required bool mounted,
}) async {

  if (draftNotifier.value != null && Mapper.boolIsTrue(draftNotifier.value?.canPickImage) == true) {

    final String? _bzID = draftNotifier.value?.id;
    final String? _path = StoragePath.bzz_bzID_logo(_bzID);
    // draftNotifier.value!.getLogoPath();
    final List<String>? _ownersIDs = draftNotifier.value?.getLogoOwners();

    if (_path != null && _ownersIDs != null){


      final bool _canPick = await _checkAndNotifyShouldPicLogo(
        draftNotifier: draftNotifier,
      );

      if (_canPick == true){

        setNotifier(
          notifier: draftNotifier,
          mounted: mounted,
          value: draftNotifier.value?.copyWith(
            canPickImage: false,
          ),
        );

        final MediaModel? _pic = await BldrsMediaMaker.makePic(
          mediaOrigin: mediaSource,
          cropAfterPick: true,
          aspectRatio: 1,
          compressWithQuality: Standards.bzLogoPicQuality,
          resizeToWidth: Standards.bzLogoPicWidth,
          uploadPath: _path,
          ownersIDs: _ownersIDs,
          fileName: 'bz_logo_$_bzID',
        );

        /// IF DID NOT PIC ANY IMAGE
        if (_pic == null) {
          setNotifier(
            notifier: draftNotifier,
            mounted: mounted,
            value: draftNotifier.value?.copyWith(canPickImage: true,),
          );
        }

        /// IF PICKED AN IMAGE
        else {
          setNotifier(
            notifier: draftNotifier,
            mounted: mounted,
            value: draftNotifier.value?.copyWith(
              canPickImage: true,
              hasNewLogo: true,
              logoPicModel: _pic,
            ),
          );
        }

      }

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _checkAndNotifyShouldPicLogo({
  required ValueNotifier<DraftBz?> draftNotifier,
}) async {
  bool _canPick = true;

  if (draftNotifier.value?.firstTimer == false){

    WaitDialog.showUnawaitedWaitDialog();

      final List<String> _flyersIDs = AuthorModel.getAllFlyersIDs(
        authors: draftNotifier.value?.authors,
      );

    if (Lister.checkCanLoop(_flyersIDs) == true){

      _canPick = await Dialogs.postersDialogs(
        titleVerse: getVerse('phid_change_bz_logo_?')!,
        bodyVerse: getVerse('phid_bz_logo_change_will_not_change_posters'),
        flyersIDs: Stringer.getRandomUniqueStrings(
          strings: _flyersIDs,
          count: 5,
        ),
        picsHeights: 70,
      );
    }

    else {
      _canPick = true;
    }

    await WaitDialog.closeWaitDialog();

  }

  return _canPick;
}
// --------------------
/// TESTED : WORKS PERFECT
void onChangeBzContact({
  required ValueNotifier<DraftBz?> draftNotifier,
  required ContactType contactType,
  required String? value,
  required bool mounted,
}){

  final List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
    contacts: draftNotifier.value?.contacts,
    contactToReplace: ContactModel(
      value: value,
      type: contactType,
    ),
  );

  setNotifier(
      notifier: draftNotifier,
      mounted: mounted,
      value: draftNotifier.value?.copyWith(
        contacts: _contacts,
      ),
  );

}
// --------------------
/// DEPRECATED
/*
/// TESTED : WORKS PERFECT
Future<void> onChangeBzScope({
  required BuildContext context,
  required ValueNotifier<DraftBz> draftNotifier,
  required FlyerType flyerType,
  required bool mounted,
}) async {

  await Keyboard.closeKeyboard();

  /// KEYWORDS_PICKER_SCREEN
  final List<String> _phids = await PhidsPickerScreen.goPickPhids(
    context: context,
    flyerType: flyerType,
    event: ViewingEvent.bzEditor,
    onlyUseZoneChains: false,
    selectedPhids: draftNotifier.value.scope,
    slideScreenFromEnLeftToRight: false,
  );

  if (Lister.checkCanLoop(_phids) == true){

    setNotifier(
        notifier: draftNotifier,
        mounted: mounted,
        value: draftNotifier.value.copyWith(
          scope: _phids,
        ),
    );

  }

}
 */
// -----------------------------------------------------------------------------
