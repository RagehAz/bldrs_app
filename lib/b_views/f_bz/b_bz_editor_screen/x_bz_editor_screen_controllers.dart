import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/secondary_models/alert_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/a_chains_screen/a_chains_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/zone_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// ---------------------------------
/// TESTED : WORKS PERFECT
void initializeLocalVariables({
  @required BuildContext context,
  @required BzModel oldBzModel,
  @required ValueNotifier<BzModel> initialBzModel,
  @required ValueNotifier<BzModel> tempBz,
  @required bool firstTimer,
  @required TextEditingController nameController,
  @required TextEditingController aboutController,
  @required ValueNotifier<List<SpecModel>> selectedScopes,
  @required ValueNotifier<BzSection> selectedBzSection,
  @required ValueNotifier<List<BzType>> inactiveBzTypes,
  @required ValueNotifier<List<BzForm>> inactiveBzForms,
}){
  // -------------------------
  final UserModel _userModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );
  // -------------------------
  final BzModel _initialBzModel = BzModel.initializeModelForEditing(
      oldBzModel: oldBzModel,
      firstTimer: firstTimer,
      userModel: _userModel,
  );
  // -------------------------
  tempBz.value = _initialBzModel;
  // -------------------------
  nameController.text = _initialBzModel.name;
  aboutController.text = _initialBzModel.about;
  // -------------------------
  selectedScopes.value = SpecModel.generateSpecsByPhids(
    context: context,
    phids: _initialBzModel.scope,
  );
  // -------------------------
  selectedBzSection.value   = BzModel.concludeBzSectionByBzTypes(_initialBzModel.bzTypes);
  inactiveBzTypes.value  = BzModel.concludeDeactivatedBzTypesBySection(
    bzSection: selectedBzSection.value,
    initialBzTypes: _initialBzModel.bzTypes,
  );
  initialBzModel.value = _initialBzModel;
  inactiveBzForms.value = BzModel.concludeInactiveBzFormsByBzTypes(inactiveBzTypes.value);
  // -------------------------
}
// ---------------------------------
/// TESTED : WORKS PERFECT
Future<void> prepareBzZoneAndLogoForEditing({
  @required BuildContext context,
  @required ValueNotifier<BzModel> tempBz,
}) async {

  BzModel _bzModel = tempBz.value.copyWith(
    logo: await FileModel.completeModel(tempBz.value.logo),
  );

  if (_bzModel.zone == null || _bzModel.zone.countryID == null){
    _bzModel = _bzModel.copyWith(
      zone: await ZoneFireOps.superGetZoneByIP(context),
    );
  }


  tempBz.value = _bzModel;

}
// -----------------------------------------------------------------------------

  /// BZ MODEL EDITORS

// ---------------------------------
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
      bzModel: tempBz.value.copyWith(
        bzTypes: <BzType>[],
      ),
      bzForm: true,
      scope: true,
    );
    tempBz.value = _updatedBzModel;

  }

}
// ---------------------------------
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
      bzModel: tempBz.value.copyWith(
        /// UPDATE SELECTED BZ TYPES
        bzTypes: _newBzTypes,
      ),
      /// UN SELECT BZ FORM
      bzForm: true,
      /// BZ SCOPE
      scope: true,
    );
    tempBz.value = _updatedBzModel;

  }

}
// ---------------------------------
/// TESTED : WORKS PERFECT
void onSelectBzForm({
  @required int index,
  @required ValueNotifier<BzModel> tempBz,
}){

  tempBz.value = tempBz.value.copyWith(
    bzForm: BzModel.bzFormsList[index],
  );

}
// ---------------------------------
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
// ---------------------------------
/// TESTED : WORKS PERFECT
void onBzZoneChanged({
  @required ZoneModel zoneModel,
  @required ValueNotifier<BzModel> tempBz,
}){
  tempBz.value = tempBz.value.copyWith(
    zone: zoneModel,
  );
}
// ---------------------------------
/// TESTED : WORKS PERFECT
Future<void> onAddScopesTap({
  @required BuildContext context,
  @required ValueNotifier<BzModel> tempBz,
  @required ValueNotifier<List<SpecModel>> selectedScopes,
}) async {

  Keyboard.closeKeyboard(context);

  final List<SpecModel> _result = await Nav.goToNewScreen(
    context: context,
    transitionType: Nav.superHorizontalTransition(context),
    screen: ChainsScreen(
      flyerTypesChainFilters: FlyerTyper.concludePossibleFlyerTypesByBzTypes(bzTypes: tempBz.value.bzTypes),
      onlyUseCityChains: false,
      isMultipleSelectionMode: true,
      pageTitleVerse: 'phid_select_keywords',
      selectedSpecs: selectedScopes.value,
      onlyChainKSelection: true,
      zone: tempBz.value.zone,
    ),
  );

  if (_result != null){
    selectedScopes.value = _result;
  }

}
// -----------------------------------------------------------------------------

/// DIALOGS

// ---------------------------------
/// TESTED : WORKS PERFECT
Future<bool> _resetScopeDialog(BuildContext context) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    titleVerse:  '##Reset Scope',
    bodyVerse:  '##This will delete all selected business scope keywords',
    boolDialog: true,
    confirmButtonVerse:  '##Reset',

  );

  return _result;
}
// -----------------------------------------------------------------------------

/// VALIDATION - UPLOADING - CONFIRMATION

// ---------------------------------
/// TESTED : WORKS PERFECT
Future<void> onBzEditsConfirmTap({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
  @required ValueNotifier<List<AlertModel>> missingFields,
  @required ValueNotifier<List<SpecModel>> selectedScopes,
  @required TextEditingController bzNameTextController,
  @required TextEditingController bzAboutTextController,
  @required BzModel oldBz,
  @required bool firstTimer,
  @required ValueNotifier<BzModel> tempBz,
}) async {

  final BzModel _newBzModel = BzModel.backEditorVariablesToUpload(
    selectedScopes: selectedScopes,
    oldBzModel: oldBz,
    bzNameController: bzNameTextController,
    bzAboutController: bzAboutTextController,
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
      titleVerse:  '',
      bodyVerse:  '##Are you sure you want to continue ?',
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

    }

  }

}
// ----------------------------------
Future<bool> _validateInputs({
  @required BuildContext context,
  @required BzModel bzModel,
  @required GlobalKey<FormState> formKey,
  @required ValueNotifier<List<AlertModel>> missingFields,
}) async {

  Keyboard.closeKeyboard(context);

  final bool _inputsAreValid = formKey.currentState.validate();
  final List<AlertModel> _missingFieldsFound = BzModel.requiredFields(bzModel);

  if (_inputsAreValid == false){

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse:  '##Please check your inputs',
      bodyVerse:  '##Some fields might require more info to be able to continue',
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
      titleVerse:  '##Complete Your Business profile',
      bodyVerse:  '##Required fields :\n''$_missingFieldsString',
    );

    // _inputsAreValid = false;
  }

  return _inputsAreValid;
}
// ----------------------------------
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
// ---------------------------------