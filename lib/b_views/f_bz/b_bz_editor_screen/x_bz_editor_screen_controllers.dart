import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/secondary_models/alert_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/a_bz_editor_screen.dart';
import 'package:bldrs/b_views/i_chains/a_chains_screen/a_chains_picking_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
void initializeBzEditorLocalVariables({
  @required BuildContext context,
  @required BzModel oldBz,
  @required ValueNotifier<BzModel> tempBz,
  @required ValueNotifier<List<SpecModel>> selectedScopes,
  @required ValueNotifier<BzSection> selectedBzSection,
  @required ValueNotifier<List<BzType>> inactiveBzTypes,
  @required ValueNotifier<List<BzForm>> inactiveBzForms,
}){
  // -------------------------
  final BzModel _initialBzModel = oldBz?.copyWith(
    logo: FileModel.initializePicForEditing(
      pic: oldBz?.logo,
      fileName: oldBz?.id,
    ),

  );
  // -------------------------
  selectedScopes.value = SpecModel.generateSpecsByPhids(
    context: context,
    phids: _initialBzModel?.scope,
  );
  // -------------------------
  selectedBzSection.value   = BzModel.concludeBzSectionByBzTypes(_initialBzModel?.bzTypes);
  inactiveBzTypes.value  = BzModel.concludeDeactivatedBzTypesBySection(
    bzSection: selectedBzSection.value,
    initialBzTypes: _initialBzModel?.bzTypes,
  );
  // initialBzModel.value = _initialBzModel;
  inactiveBzForms.value = BzModel.concludeInactiveBzFormsByBzTypes(inactiveBzTypes.value);
  // -------------------------
  tempBz.value = _initialBzModel;
  // -------------------------
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> prepareBzForEditing({
  @required BuildContext context,
  @required ValueNotifier<BzModel> tempBz,
  @required bool firstTimer,
  @required BzModel oldBz,
  @required bool mounted,
}) async {

  final BzModel _bzModel = await BzModel.initializeModelForEditing(
    context: context,
    oldBz: oldBz,
    firstTimer: firstTimer,
    userModel: UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    ),
  );

  setNotifier(
      notifier: tempBz,
      mounted: mounted,
      value: _bzModel,
  );
}
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> loadBzEditorLastSession({
  @required BuildContext context,
  @required BzModel oldBz,
  @required bool firstTimer,
}) async {

  final BzModel _lastSessionBz = await BzLDBOps.loadBzEditorSession(
    bzID: oldBz?.id,
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
      // -------------------------
      final UserModel _userModel = UsersProvider.proGetMyUserModel(
        context: context,
        listen: false,
      );
      // -------------------------
      final BzModel _initialBzModel = await BzModel.initializeModelForEditing(
        context: context,
        oldBz: _lastSessionBz,
        firstTimer: false,
        userModel: _userModel,
      );
      await Nav.replaceScreen(
        context: context,
        screen: BzEditorScreen(
          bzModel: _initialBzModel,
          firstTimer: firstTimer,
          checkLastSession: false,
          validateOnStartup: true,
        ),
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> saveBzEditorSession({
  @required ValueNotifier<BzModel> tempBz,
  @required ValueNotifier<BzModel> lastTempBz,
  @required ValueNotifier<List<SpecModel>> selectedScopes,
  @required BzModel oldBz,
  @required bool mounted,
}) async {

  BzModel newBz = BzModel.backEditorVariablesToUpload(
    tempBz: tempBz,
    oldBz: oldBz,
    selectedScopes: selectedScopes,
  );

  /// USER PICTURE
  newBz = newBz.copyWith(
    logo: FileModel.bakeFileForLDB(newBz.logo),
  );

  if (BzModel.checkBzzAreIdentical(bz1: lastTempBz.value, bz2: newBz) == false){

    await BzLDBOps.saveBzEditorSession(
        bzModel: newBz
    );

    // setNotifier(
    //     notifier: lastTempBz,
    //     mounted: mounted,
    //     value: newBz,
    //     );

  }

}
// -----------------------------------------------------------------------------

  /// BZ MODEL EDITORS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectBzSection({
  @required BuildContext context,
  @required int index,
  @required ValueNotifier<BzSection> selectedBzSection,
  @required ValueNotifier<List<BzType>> inactiveBzTypes,
  @required ValueNotifier<List<BzForm>> inactiveBzForms,
  @required ValueNotifier<List<SpecModel>> selectedScopes,
  @required ValueNotifier<BzModel> tempBz,
}) async {

  bool _canContinue = true;

  if (Mapper.checkCanLoopList(selectedScopes.value) == true){
    _canContinue = await _resetScopeDialog(context);
  }

  if (_canContinue == true){

    final BzSection _selectedSection = BzModel.bzSectionsList[index];
    final List<BzType> _generatedInactiveBzTypes = BzModel.concludeDeactivatedBzTypesBySection(
      bzSection: _selectedSection,
    );

    selectedBzSection.value = _selectedSection;
    inactiveBzTypes.value = _generatedInactiveBzTypes;

    inactiveBzForms.value = null;
    selectedScopes.value = <SpecModel>[];

    final BzModel _updatedBzModel = tempBz.value.nullifyField(
      // bzModel: tempBz.value.copyWith(
      //   bzTypes: <BzType>[],
      // ),
      bzTypes: true,
      bzForm: true,
      scope: true,
    );
    tempBz.value = _updatedBzModel;

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSelectBzType({
  @required BuildContext context,
  @required int index,
  @required ValueNotifier<List<BzType>> inactiveBzTypes,
  @required ValueNotifier<BzSection> selectedBzSection,
  @required ValueNotifier<List<BzForm>> inactiveBzForms,
  @required ValueNotifier<List<SpecModel>> selectedScopes,
  @required ValueNotifier<BzModel> tempBz,
}) async {

  bool _canContinue = true;

  if (Mapper.checkCanLoopList(selectedScopes.value) == true){
    _canContinue = await _resetScopeDialog(context);
  }

  if (_canContinue == true){

    final BzType _selectedBzType = BzModel.bzTypesList[index];

    /// UPDATE SELECTED BZ TYPES
    final List<BzType> _newBzTypes = BzModel.addOrRemoveBzTypeToBzzTypes(
      selectedBzTypes: tempBz.value.bzTypes,
      newSelectedBzType: _selectedBzType,
    );

    /// INACTIVE OTHER BZ TYPES
    inactiveBzTypes.value = BzModel.concludeDeactivatedBzTypesBasedOnSelectedBzTypes(
      newSelectedType: _selectedBzType,
      selectedBzTypes: _newBzTypes,
      selectedBzSection: selectedBzSection.value,
    );

    /// INACTIVATE BZ FORMS
    inactiveBzForms.value = BzModel.concludeInactiveBzFormsByBzTypes(_newBzTypes);

    /// BZ SCOPE
    selectedScopes.value = <SpecModel>[];

    final BzModel _updatedBzModel = tempBz.value.nullifyField(
      /// UN SELECT BZ FORM
      bzForm: true,
      /// BZ SCOPE
      scope: true,
    );

    tempBz.value = _updatedBzModel.copyWith(
      /// UPDATE SELECTED BZ TYPES
      bzTypes: _newBzTypes,

    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onSelectBzForm({
  @required int index,
  @required ValueNotifier<BzModel> tempBz,
}){

  tempBz.value = tempBz.value.copyWith(
    bzForm: BzModel.bzFormsList[index],
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> takeBzLogo({
  @required BuildContext context,
  @required ValueNotifier<BzModel> tempBz,
  @required ImagePickerType imagePickerType,
  @required ValueNotifier<bool> canPickImage,
}) async {

  if (canPickImage.value == true) {

    canPickImage.value = false;

    FileModel _imageFileModel;

    if(imagePickerType == ImagePickerType.galleryImage){
      _imageFileModel = await Imagers.pickAndCropSingleImage(
        context: context,
        cropAfterPick: true,
        isFlyerRatio: false,
        resizeToWidth: Standards.userPictureWidthPixels,
      );
    }
    else if (imagePickerType == ImagePickerType.cameraImage){
      _imageFileModel = await Imagers.shootAndCropCameraImage(
        context: context,
        cropAfterPick: true,
        isFlyerRatio: false,
        resizeToWidth: Standards.userPictureWidthPixels,
      );
    }

    /// IF DID NOT PIC ANY IMAGE
    if (_imageFileModel == null) {
      canPickImage.value = true;
    }

    /// IF PICKED AN IMAGE
    else {

      tempBz.value = tempBz.value.copyWith(
        logo: _imageFileModel,
      );

      canPickImage.value = true;
    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onBzNameChanged({
  @required ValueNotifier<BzModel> tempBz,
  @required String text,
}){

  tempBz.value = tempBz.value.copyWith(
    name: text,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
void onBzAboutChanged({
  @required ValueNotifier<BzModel> tempBz,
  @required String text,
}) {
  tempBz.value = tempBz.value.copyWith(
    about: text,
  );
}
// --------------------
  /// TESTED : WORKS PERFECT
  void onBzContactChanged({
    @required ValueNotifier<BzModel> tempBz,
    @required ContactType contactType,
    @required String value,
  }){

    final List<ContactModel> _contacts = ContactModel.insertOrReplaceContact(
      contacts: tempBz.value.contacts,
      contactToReplace: ContactModel(
        value: value,
        type: contactType,
      ),
    );

    tempBz.value = tempBz.value.copyWith(
      contacts: _contacts,
    );

  }
// --------------------
/// TESTED : WORKS PERFECT
void onBzZoneChanged({
  @required ZoneModel zoneModel,
  @required ValueNotifier<BzModel> tempBz,
}){

  tempBz.value = tempBz.value.copyWith(
    zone: zoneModel,
  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onAddScopesTap({
  @required BuildContext context,
  @required List<SpecModel> selectedSpecs,
  @required FlyerType flyerType,
  @required ZoneModel zone,
  @required ValueChanged<List<SpecModel>> onFinish,
  @required bool onlyChainKSelection,
}) async {

  Keyboard.closeKeyboard(context);

  final List<SpecModel> _result = await Nav.goToNewScreen(
    context: context,
    transitionType: Nav.superHorizontalTransition(context),
    screen: ChainsPickingScreen(
      flyerTypeFilter: flyerType,
      onlyUseCityChains: false,
      isMultipleSelectionMode: true,
      pageTitleVerse: const Verse(
        text: 'phid_select_keywords',
        translate: true,
      ),
      selectedSpecs: selectedSpecs,
      onlyChainKSelection: onlyChainKSelection,
      zone: zone,
    ),
  );

  onFinish(_result);

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

/// VALIDATION - UPLOADING - CONFIRMATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onBzEditsConfirmTap({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
  @required ValueNotifier<List<AlertModel>> missingFields,
  @required ValueNotifier<List<SpecModel>> selectedScopes,
  @required BzModel oldBz,
  @required bool firstTimer,
  @required ValueNotifier<BzModel> tempBz,
}) async {


  final BzModel _newBzModel = BzModel.backEditorVariablesToUpload(
    selectedScopes: selectedScopes,
    oldBz: oldBz,
    tempBz: tempBz,
  );

  /// ONLY VALIDATION TO INPUTS
  final bool _inputsAreValid = await _validateInputs(
    context: context,
    bzModel: _newBzModel,
    formKey: formKey,
    missingFields: missingFields,
  );

  if (_inputsAreValid == true){

    /// REQUEST CONFIRMATION
    final bool _canContinue = await CenterDialog.showCenterDialog(
      context: context,
      bodyVerse: const Verse(
        pseudo: 'Are you sure you want to continue ?',
        text: 'phid_confirm_continue',
        translate: true,
      ),
      boolDialog: true,
    );

    if (_canContinue == true){

      if (firstTimer == true){
        await BzProtocols.composeBz(
          context: context,
          newBzModel: _newBzModel,
          userModel: UsersProvider.proGetMyUserModel(
            context: context,
            listen: false,
          ),
        );
      }

      else {
        await BzProtocols.renovateBz(
          context: context,
          newBzModel: _newBzModel,
          oldBzModel: oldBz,
          showWaitDialog: true,
          navigateToBzInfoPageOnEnd: true,
        );
      }

      await BzLDBOps.deleteBzEditorSession(_newBzModel.id);

    }

  }

}
// --------------------
Future<bool> _validateInputs({
  @required BuildContext context,
  @required BzModel bzModel,
  @required GlobalKey<FormState> formKey,
  @required ValueNotifier<List<AlertModel>> missingFields,
}) async {

  Keyboard.closeKeyboard(context);

  final bool _inputsAreValid = Formers.validateForm(formKey);

  final List<AlertModel> _missingFieldsFound = BzModel.requiredFields(bzModel);

  if (_inputsAreValid == false){

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        pseudo: 'Please check your inputs',
        text: 'phid_check_inputs',
        translate: true,
      ),
      bodyVerse: const Verse(
        pseudo: 'Some fields might require more info to be able to continue',
        text: 'phid_fields_require_info_to_continue',
        translate: true,
      ),
    );

  }

  if (_missingFieldsFound.isNotEmpty == true){

    missingFields.value = _missingFieldsFound;

    final List<String> _missingFieldsValues = AlertModel.getAlertsIDs(_missingFieldsFound);
    final List<String> _missingFieldsStrings = Stringer.getStringsFromDynamics(dynamics: _missingFieldsValues);
    final String _missingFieldsString = Stringer.generateStringFromStrings(
        strings: _missingFieldsStrings,
    );

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        pseudo: 'Complete Your Business profile',
        text: 'phid_complete_bz_profile',
        translate: true,
      ),
      bodyVerse: Verse(
        text: '##Required fields :\n''$_missingFieldsString',
        translate: true,
        variables: _missingFieldsString,
      ),
    );

    // _inputsAreValid = false;
  }

  return _inputsAreValid;
}
// --------------------
/*
bool _errorIsOn({
  @required List<String> missingFieldsKeys,
  @required String fieldKey,
}){

  final bool _isError = Mapper.stringsContainString(
    strings: missingFieldsKeys,
    string: fieldKey,
  );

  return _isError;

 */
// -----------------------------------------------------------------------------
