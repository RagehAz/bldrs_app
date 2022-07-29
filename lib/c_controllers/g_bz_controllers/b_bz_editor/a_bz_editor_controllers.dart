import 'dart:async';
import 'dart:io';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/secondary_models/alert_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/e_flyer_maker/e_keywords_picker_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

  /// BZ MODEL EDITORS

// ----------------------------------
void onSelectBzSection({
  @required int index,
  @required ValueNotifier<BzSection> selectedBzSection,
  @required ValueNotifier<List<BzType>> inactiveBzTypes,
  @required ValueNotifier<List<BzType>> selectedBzTypes,
  @required ValueNotifier<BzForm> selectedBzForm,
  @required ValueNotifier<List<BzForm>> inactiveBzForms,
}){

  final BzSection _selectedSection = BzModel.bzSectionsList[index];
  final List<BzType> _generatedInactiveBzTypes = BzModel.concludeInactiveBzTypesBySection(
    bzSection: _selectedSection,
  );

  selectedBzSection.value = _selectedSection;
  inactiveBzTypes.value = _generatedInactiveBzTypes;
  selectedBzTypes.value = <BzType>[];
  selectedBzForm.value = null;
  inactiveBzForms.value = null;

}
// ----------------------------------
void onSelectBzType({
  @required int index,
  @required ValueNotifier<List<BzType>> selectedBzTypes,
  @required ValueNotifier<List<BzType>> inactiveBzTypes,
  @required ValueNotifier<BzSection> selectedBzSection,
  @required ValueNotifier<List<BzForm>> inactiveBzForms,
  @required ValueNotifier<BzForm> selectedBzForm,
  @required ValueNotifier<List<String>> selectedScopes,
}){

  final BzType _selectedBzType = BzModel.bzTypesList[index];

  /// UPDATE SELECTED BZ TYPES
  selectedBzTypes.value = BzModel.addOrRemoveBzTypeToBzzTypes(
    selectedBzTypes: selectedBzTypes.value,
    newSelectedBzType: _selectedBzType,
  );

  /// INACTIVE OTHER BZ TYPES
  inactiveBzTypes.value = BzModel.concludeInactiveBzTypesBasedOnSelectedBzTypes(
    newSelectedType: _selectedBzType,
    selectedBzTypes: selectedBzTypes.value,
    selectedBzSection: selectedBzSection.value,
  );

  /// INACTIVATE BZ FORMS
  inactiveBzForms.value = BzModel.concludeInactiveBzFormsByBzTypes(selectedBzTypes.value);

  /// UN SELECT BZ FORM
  selectedBzForm.value = null;

  /// BZ SCOPE
  selectedScopes.value = <String>[];

}
// ----------------------------------
void onSelectBzForm({
  @required int index,
  @required ValueNotifier<BzForm> selectedBzForm,
}){

  selectedBzForm.value = BzModel.bzFormsList[index];

}
// ----------------------------------
Future<void> takeBzLogo({
  @required BuildContext context,
  @required ValueNotifier<dynamic> bzLogo,
}) async {

  final File _file = await Imagers.pickAndCropSingleImage(
    context: context,
    isFlyerRatio: false,
    cropAfterPick: true,
  );

  if (_file != null){
    bzLogo.value = _file;
  }

}
// ----------------------------------
void onDeleteLogo({
  @required ValueNotifier<dynamic> bzLogo,
}){
  bzLogo.value = null;
}
// ----------------------------------
void onBzZoneChanged({
  @required ZoneModel zoneModel,
  @required ValueNotifier<ZoneModel> bzZone,
}){
  bzZone.value = zoneModel;
}
// ----------------------------------
Future<void> onAddScopesTap({
  @required BuildContext context,
  @required ValueNotifier<List<BzType>> selectedBzTypes,
  @required ValueNotifier<List<String>> selectedScopes,
}) async {

  Keyboarders.closeKeyboard(context);

  final List<String> _result = await Nav.goToNewScreen(
      context: context,
      screen: KeywordsPickerScreen(
        flyerTypes: FlyerTyper.concludePossibleFlyerTypesByBzTypes(bzTypes: selectedBzTypes.value),
        selectedKeywordsIDs: selectedScopes.value,
      )
  );

  if (_result != null){
    selectedScopes.value = _result;
  }

}
// -----------------------------------------------------------------------------

/// VALIDATION - UPLOADING - CONFIRMATION

// ----------------------------------
Future<void> onBzEditsConfirmTap({
  @required BuildContext context,
  @required GlobalKey<FormState> formKey,
  @required ValueNotifier<List<AlertModel>> missingFields,
  @required ValueNotifier<List<BzType>> selectedBzTypes,
  @required ValueNotifier<List<String>> selectedScopes,
  @required ValueNotifier<BzForm> selectedBzForm,
  @required TextEditingController bzNameTextController,
  @required ValueNotifier<dynamic> bzLogo,
  @required ValueNotifier<ZoneModel> bzZone,
  @required TextEditingController bzAboutTextController,
  @required ValueNotifier<GeoPoint> bzPosition,
  @required ValueNotifier<List<ContactModel>> bzContacts,
  @required BzModel initialBzModel,
  @required bool firstTimer,
  @required UserModel userModel,
}) async {

  final BzModel _newBzModel = createBzModelFromLocalVariables(
    selectedBzTypes: selectedBzTypes,
    selectedScopes: selectedScopes,
    selectedBzForm: selectedBzForm,
    initialBzModel: initialBzModel,
    bzNameTextController: bzNameTextController,
    bzLogo: bzLogo,
    bzZone: bzZone,
    bzAboutTextController: bzAboutTextController,
    bzPosition: bzPosition,
    bzContacts: bzContacts,
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
      title: '',
      body: 'Are you sure you want to continue ?',
      boolDialog: true,
    );

    if (_canContinue == true){

      if (firstTimer == true){
        await BzProtocols.composeBz(
          context: context,
          newBzModel: _newBzModel,
          userModel: userModel,
        );
      }

      else {
        await BzProtocols.renovateBz(
          context: context,
          newBzModel: _newBzModel,
          oldBzModel: initialBzModel,
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

  Keyboarders.closeKeyboard(context);

  final bool _inputsAreValid = formKey.currentState.validate();
  final List<AlertModel> _missingFieldsFound = BzModel.requiredFields(bzModel);

  if (_inputsAreValid == false){

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Please check your inputs',
      body: 'Some fields might require more info to be able to continue',
    );

  }

  if (_missingFieldsFound.isNotEmpty == true){

    missingFields.value = _missingFieldsFound;

    final List<String> _missingFieldsValues = AlertModel.getAlertsIDs(_missingFieldsFound);
    final List<String> _missingFieldsStrings = Mapper.getStringsFromDynamics(dynamics: _missingFieldsValues);
    final String _missingFieldsString = TextGen.generateStringFromStrings(
        strings: _missingFieldsStrings,
    );

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Complete Your Business profile',
      body: 'Required fields :\n''$_missingFieldsString',
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
// ----------------------------------
BzModel createBzModelFromLocalVariables({
  @required ValueNotifier<List<BzType>> selectedBzTypes,
  @required ValueNotifier<List<String>> selectedScopes,
  @required ValueNotifier<BzForm> selectedBzForm,
  @required BzModel initialBzModel,
  @required TextEditingController bzNameTextController,
  @required ValueNotifier<dynamic> bzLogo,
  @required ValueNotifier<ZoneModel> bzZone,
  @required TextEditingController bzAboutTextController,
  @required ValueNotifier<GeoPoint> bzPosition,
  @required ValueNotifier<List<ContactModel>> bzContacts,
}){

  final BzModel _bzModel = BzModel(
    id: initialBzModel.id, /// WILL BE OVERRIDDEN IN CREATE BZ OPS
    bzTypes: selectedBzTypes.value,
    bzForm: selectedBzForm.value,
    createdAt: initialBzModel.createdAt, /// WILL BE OVERRIDDEN
    accountType: initialBzModel.accountType, /// NEVER CHANGED
    name: bzNameTextController.text,
    trigram: TextGen.createTrigram(input: bzNameTextController.text),
    logo: bzLogo.value, /// WILL CHECK DATA TYPE
    scope: selectedScopes.value,
    zone: bzZone.value,
    about: bzAboutTextController.text,
    position: bzPosition.value,
    contacts: bzContacts.value,
    authors: initialBzModel.authors, /// NEVER CHANGED
    showsTeam: initialBzModel.showsTeam, /// NEVER CHANGED
    isVerified: initialBzModel.isVerified, /// NEVER CHANGED
    bzState: initialBzModel.bzState, /// NEVER CHANGED
    flyersIDs: initialBzModel.flyersIDs, /// NEVER CHANGED
  );

  return _bzModel;
}
// ----------------------------------
