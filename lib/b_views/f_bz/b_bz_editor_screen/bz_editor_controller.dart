import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/mutables/draft_bz.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/a_pickers_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_back_end/x_ops/ldb_ops/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
///
void initializeDraftBz({
  @required BuildContext context,
  @required BzModel oldBz,
  @required ValueNotifier<DraftBz> draftNotifier,
}){

  /// FIRST TIMER
  if (oldBz == null){

    final UserModel creatorUser = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
    );

    draftNotifier.value = DraftBz.createNewDraftBz(
        creatorUser: creatorUser
    );

  }

  /// EDITING BZ
  else {

    draftNotifier.value = DraftBz.createDraftFromBz(
        context: context,
        bzModel: oldBz,
    );

  }

}
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
///
Future<void> loadBzEditorLastSession({
  @required BuildContext context,
  @required ValueNotifier<DraftBz> draftNotifier,
}) async {

  final BzModel _lastSessionBz = await BzLDBOps.loadBzEditorSession(
    bzID: draftNotifier.value.id,
  );

  if (_lastSessionBz != null){

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

      initializeDraftBz(
        context: context,
        oldBz: _lastSessionBz,
        draftNotifier: draftNotifier,
      );

    }

  }

}
// --------------------
///
Future<void> saveBzEditorSession(ValueNotifier<DraftBz> draftNotifier) async {

  triggerCanValidateDraftBz(draftNotifier: draftNotifier, setTo: true,);

  final BzModel _bzModel = DraftBz.bakeDraftForLDB(
      draft: draftNotifier.value,
  );

  await BzLDBOps.saveBzEditorSession(
      bzModel: _bzModel,
  );

}
// -----------------------------------------------------------------------------

/// CONFIRMATION

// --------------------
///
Future<void> onConfirmBzEdits({
  @required BuildContext context,
  @required ValueNotifier<DraftBz> draftNotifier,
  @required BzModel oldBz,
}) async {

  triggerCanValidateDraftBz(draftNotifier: draftNotifier, setTo: true,);
  Keyboard.closeKeyboard(context);

  final bool _canContinue = await _preUploadCheckups(
    context: context,
    draftNotifier: draftNotifier,
  );

  if (_canContinue == true){

    await _uploadDraftBz(
      context: context,
      draftNotifier: draftNotifier,
      oldBz: oldBz,
    );

    await BzLDBOps.deleteBzEditorSession(draftNotifier.value.id);

  }

}
// --------------------
///
Future<bool> _preUploadCheckups({
  @required BuildContext context,
  @required ValueNotifier<DraftBz> draftNotifier,
}) async {

  bool _canContinue = false;

  _canContinue = Formers.validateForm(draftNotifier.value.formKey);

  if (_canContinue == true){

    /// REQUEST CONFIRMATION
    _canContinue = await CenterDialog.showCenterDialog(
      context: context,
      bodyVerse: const Verse(
        pseudo: 'Are you sure you want to continue ?',
        text: 'phid_confirm_continue',
        translate: true,
      ),
      boolDialog: true,
    );


  }

  return _canContinue;
}
// --------------------
///
Future<void> _uploadDraftBz({
  @required BuildContext context,
  @required ValueNotifier<DraftBz> draftNotifier,
  @required BzModel oldBz,
}) async {

  final BzModel _newBzModel = DraftBz.bakeDraftForFirestore(
      draft: draftNotifier.value,
  );

  /// CREATING NEW BZ
  if (draftNotifier.value.firstTimer == true){
    await BzProtocols.composeBz(
      context: context,
      newBzModel: _newBzModel,
      userModel: UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
      ),
    );
  }

  /// EDITING EXISTING BZ
  else {
    await BzProtocols.renovateBz(
      context: context,
      newBzModel: _newBzModel,
      oldBzModel: oldBz,
      showWaitDialog: true,
      navigateToBzInfoPageOnEnd: true,
    );
  }


}
// -----------------------------------------------------------------------------

/// MODIFIERS

// --------------------
///
void triggerCanValidateDraftBz({
  @required bool setTo,
  @required ValueNotifier<DraftBz> draftNotifier,
}){

  if (draftNotifier.value.canValidate == setTo){
    // nothing
  }
  else {
    draftNotifier.value = draftNotifier.value.copyWith(
      canValidate: setTo,
    );

  }
}
// --------------------
///
Future<void> onChangeBzSection({
  @required BuildContext context,
  @required int index,
  @required ValueNotifier<DraftBz> draftNotifier,
}) async {

  bool _canContinue = true;

  if (Mapper.checkCanLoopList(draftNotifier.value.scopeSpecs) == true){
    _canContinue = await _resetScopeDialog(context);
  }

  if (_canContinue == true){

    final BzSection _selectedSection = BzTyper.bzSectionsList[index];
    final List<BzType> _generatedInactiveBzTypes = BzTyper.concludeDeactivatedBzTypesBySection(
      bzSection: _selectedSection,
    );

    DraftBz _newDraft = draftNotifier.value.copyWith(
      bzSection: _selectedSection,
      inactiveBzTypes: _generatedInactiveBzTypes,
      inactiveBzForms: [],
      bzTypes: [],
      scopeSpecs: [],
      scope: [],
    );

    _newDraft = _newDraft.nullifyField(
      bzForm: true,
      inactiveBzForms: true,
      bzTypes: true,
      scopeSpecs: true,
      scope: true,
    );

    draftNotifier.value = _newDraft;

  }

}
// --------------------
///
Future<void> onChangeBzType({
  @required BuildContext context,
  @required int index,
  @required ValueNotifier<DraftBz> draftNotifier,
}) async {

  bool _canContinue = true;

  if (Mapper.checkCanLoopList(draftNotifier.value.scopeSpecs) == true){
    _canContinue = await _resetScopeDialog(context);
  }

  if (_canContinue == true){

    final BzType _selectedBzType = BzTyper.bzTypesList[index];

    /// UPDATE SELECTED BZ TYPES
    final List<BzType> _newBzTypes = BzTyper.addOrRemoveBzTypeToBzzTypes(
      selectedBzTypes: draftNotifier.value.bzTypes,
      newSelectedBzType: _selectedBzType,
    );

    /// INACTIVE OTHER BZ TYPES
    final List<BzType> _inactiveBzTypes = BzTyper.concludeDeactivatedBzTypesBasedOnSelectedBzTypes(
      newSelectedType: _selectedBzType,
      selectedBzTypes: _newBzTypes,
      selectedBzSection: draftNotifier.value.bzSection,
    );

    /// INACTIVATE BZ FORMS
    final List<BzForm> _inactiveBzForms = BzTyper.concludeInactiveBzFormsByBzTypes(_newBzTypes);


    DraftBz _newDraft = draftNotifier.value.copyWith(
      bzTypes: _newBzTypes,
      inactiveBzTypes: _inactiveBzTypes,
      inactiveBzForms: _inactiveBzForms,

    );

    _newDraft = _newDraft.nullifyField(
      bzForm: true,
      scope: true,
      scopeSpecs: true,
    );

    draftNotifier.value = _newDraft;

  }

}
// --------------------
///
void onChangeBzForm({
  @required int index,
  @required ValueNotifier<DraftBz> draftNotifier,
}){

  draftNotifier.value = draftNotifier.value.copyWith(
    bzForm: BzTyper.bzFormsList[index],
  );

}
// --------------------
///
Future<void> onChangeBzLogo({
  @required BuildContext context,
  @required ValueNotifier<DraftBz> draftNotifier,
  @required ImagePickerType imagePickerType,
}) async {

  if (draftNotifier.value.canPickImage == true) {

    draftNotifier.value = draftNotifier.value.copyWith(canPickImage: false,);

    FileModel _imageFileModel;

    if(imagePickerType == ImagePickerType.galleryImage){
      _imageFileModel = await Imagers.pickAndCropSingleImage(
        context: context,
        cropAfterPick: true,
        aspectRatio: 1,
        resizeToWidth: Standards.userPictureWidthPixels,
      );
    }

    else if (imagePickerType == ImagePickerType.cameraImage){
      _imageFileModel = await Imagers.shootAndCropCameraImage(
        context: context,
        cropAfterPick: true,
        aspectRatio: 1,
        resizeToWidth: Standards.userPictureWidthPixels,
      );
    }

    /// IF DID NOT PIC ANY IMAGE
    if (_imageFileModel == null) {
      draftNotifier.value = draftNotifier.value.copyWith(canPickImage: true,);
    }

    /// IF PICKED AN IMAGE
    else {

      draftNotifier.value = draftNotifier.value.copyWith(
        newLogoFile: _imageFileModel,
        canPickImage: true,
      );

    }

  }

}
// --------------------
///
void onChangeBzContact({
  @required ValueNotifier<DraftBz> draftNotifier,
  @required ContactType contactType,
  @required String value,
}){

  final List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
    contacts: draftNotifier.value.contacts,
    contactToReplace: ContactModel(
      value: value,
      type: contactType,
    ),
  );

  draftNotifier.value = draftNotifier.value.copyWith(
    contacts: _contacts,
  );

}
// --------------------
///
Future<void> onChangeBzScope({
  @required BuildContext context,
  @required ValueNotifier<DraftBz> draftNotifier,
  @required FlyerType flyerType,
}) async {

  Keyboard.closeKeyboard(context);

  final List<SpecModel> _result = await Nav.goToNewScreen(
    context: context,
    transitionType: Nav.superHorizontalTransition(context),
    screen: PickersScreen(
      flyerTypeFilter: flyerType,
      onlyUseCityChains: false,
      isMultipleSelectionMode: true,
      pageTitleVerse: const Verse(
        text: 'phid_select_keywords',
        translate: true,
      ),
      selectedSpecs: draftNotifier.value.scopeSpecs,
      onlyChainKSelection: true,
      zone: draftNotifier.value.zone,
    ),
  );

  if (_result != null){
    draftNotifier.value = draftNotifier.value.copyWith(
      scopeSpecs: _result,
      scope: SpecModel.getSpecsIDs(_result),
    );
  }

}

// -----------------------------------------------------------------------------

/// DIALOGS

// --------------------
/// TESTED : WORKS PERFECT
Future<bool> _resetScopeDialog(BuildContext context) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse: const Verse(
      text: 'phid_reset_scope',
      translate: true,
    ),
    bodyVerse: const Verse(
      pseudo: 'This will delete all selected business scope keywords',
      translate: true,
      text: 'phid_reset_scope_warning',
    ),
    boolDialog: true,
    confirmButtonVerse: const Verse(
      text: 'phid_reset',
      translate: true,
    ),

  );

  return _result;
}
// -----------------------------------------------------------------------------
