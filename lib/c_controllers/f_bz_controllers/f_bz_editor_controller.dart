import 'dart:io';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/a_models/secondary_models/alert_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/specs_selector_screen/keywords_picker_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final List<BzType> _generatedInactiveBzTypes = BzModel.generateInactiveBzTypesBySection(
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
  selectedBzTypes.value = BzModel.editSelectedBzTypes(
    selectedBzTypes: selectedBzTypes.value,
    newSelectedBzType: _selectedBzType,
  );

  /// INACTIVE OTHER BZ TYPES
  inactiveBzTypes.value = BzModel.generateInactiveBzTypesBasedOnCurrentSituation(
    newSelectedType: _selectedBzType,
    selectedBzTypes: selectedBzTypes.value,
    selectedBzSection: selectedBzSection.value,
  );

  /// INACTIVATE BZ FORMS
  inactiveBzForms.value = BzModel.generateInactiveBzForms(selectedBzTypes.value);

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
  @required ValueNotifier<dynamic> bzLogo,
}) async {

  final File _imageFile = await Imagers.takeGalleryPicture(
      picType: Imagers.PicType.bzLogo
  );

  bzLogo.value = _imageFile;

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

  final dynamic _result = await Nav.goToNewScreen(context, KeywordsPickerScreen(
    flyerTypes: concludePossibleFlyerTypesByBzTypes(bzTypes: selectedBzTypes.value),
    selectedKeywordsIDs: selectedScopes.value,
  ));

  final List<String> receivedKeywordsIds = _result;

  if (Mapper.canLoopList(receivedKeywordsIds) == true){
    selectedScopes.value = receivedKeywordsIds;
  }

}
// -----------------------------------------------------------------------------

/// VALIDATION - UPLOADING - CONFIRMATION

// ----------------------------------
Future<void> onConfirmTap({
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
}) async {

  final BzModel _bzModel = createBzModelFromLocalVariables(
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
    bzModel: _bzModel,
    formKey: formKey,
    missingFields: missingFields,
  );

  if (_inputsAreValid == true){

    final bool _canContinue = await _showConfirmationDialog(
      context: context,
    );

    if (_canContinue == true){

      final BzModel _uploadedBzModel = await _uploadBzModel(_bzModel);

      final bool _opSuccess = _uploadOpsSucceeded(_uploadedBzModel);

      await _setNewBzModelLocally(
        context: context,
        uploadedBzModel: _uploadedBzModel,
        uploadOpsSucceeded: _opSuccess,
      );

      await _onUploadOpsEnd(
        context: context,
        onOpSuccess: _opSuccess,
      );

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

  Keyboarders.minimizeKeyboardOnTapOutSide(context);

  bool _inputsAreValid = formKey.currentState.validate();
  final List<AlertModel> _missingFieldsFound = BzModel.requiredFields(bzModel);

  if (_missingFieldsFound.isNotEmpty == true){

    missingFields.value = _missingFieldsFound;

    final List<String> _missingFieldsValues = AlertModel.getAlertsIDs(_missingFieldsFound);
    final List<String> _missingFieldsStrings = Mapper.getStringsFromDynamics(dynamics: _missingFieldsValues);
    final String _missingFieldsString = TextGen.generateStringFromStrings(_missingFieldsStrings);

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Complete Your Business profile',
      body: 'Required fields :\n''$_missingFieldsString',
    );

    _inputsAreValid = false;
  }

  return _inputsAreValid;
}
// ----------------------------------
Future<BzModel> _uploadBzModel(BzModel bzModel) async {
  final BzModel _uploadedBzModel = bzModel; /// TEMP

  // /// FIRST TIME TO CREATE BZ MODEL
  // if (widget.firstTimer == true){
  //   _uploadedBzModel = await FireBzOps.createBz(
  //         context: context,
  //         inputBz: bzModel,
  //         userModel: widget.userModel,
  //     );
  // }
  //
  // /// UPDATING EXISTING BZ MODEL
  // else {
  //     _uploadedBzModel = await FireBzOps.updateBz(
  //       context: context,
  //       modifiedBz: bzModel,
  //       originalBz: _initialBzModel,
  //       bzLogoFile: _currentBzLogoFile,
  //       authorPicFile: _currentAuthorPicFile,
  //     );
  // }

  /// SHOULD BE NULL IF FAILED TO UPLOAD
  return _uploadedBzModel;
}
// ----------------------------------
bool _uploadOpsSucceeded(BzModel uploadedBzModel){
  bool _opsSucceeded;

  if (uploadedBzModel == null){
    _opsSucceeded = false;
  }

  else {
    _opsSucceeded = true;
  }

  return _opsSucceeded;
}
// ----------------------------------
Future<void> _setNewBzModelLocally({
  @required BuildContext context,
  @required BzModel uploadedBzModel,
  @required bool uploadOpsSucceeded,
}) async {

  if (uploadOpsSucceeded == true){

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

    await _bzzProvider.updateBzInUserBzz(
      modifiedBz: uploadedBzModel,
      notify: true,
    );
  }

}
// ----------------------------------
Future<bool> _showConfirmationDialog({
  @required BuildContext context,
}) async {

  final bool _continueOps = await CenterDialog.showCenterDialog(
    context: context,
    title: '',
    body: 'Are you sure you want to continue ?',
    boolDialog: true,
  );

  return _continueOps;
}
// ----------------------------------
Future<void> _onUploadOpsEnd({
  @required BuildContext context,
  @required bool onOpSuccess,
}) async {

  /// ON SUCCESS
  if (onOpSuccess == true){

    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Great !',
      body: 'Successfully updated your Business Account',
    );

    Nav.goBack(context,
      /// TASK : need to check this
      // argument: widget.firstTimer ? null : true,
    );

  }

  /// ON FAILURE
  else {
    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Ops !',
      body: 'Something went wrong, Please try again',
    );
  }

}
// ----------------------------------
bool _errorIsOn({
  @required List<String> missingFieldsKeys,
  @required String fieldKey,
}){

  final bool _isError = Mapper.stringsContainString(
    strings: missingFieldsKeys,
    string: fieldKey,
  );

  return _isError;
}
// -----------------------------------------------------------------------------
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
    totalFollowers: initialBzModel.totalFollowers, /// NEVER CHANGED
    totalSaves: initialBzModel.totalSaves, /// NEVER CHANGED
    totalShares: initialBzModel.totalShares, /// NEVER CHANGED
    totalSlides: initialBzModel.totalSlides, /// NEVER CHANGED
    totalViews: initialBzModel.totalViews, /// NEVER CHANGED
    totalCalls: initialBzModel.totalCalls, /// NEVER CHANGED
    flyersIDs: initialBzModel.flyersIDs, /// NEVER CHANGED
    totalFlyers: initialBzModel.totalFlyers, /// NEVER CHANGED
  );

  return _bzModel;
}
