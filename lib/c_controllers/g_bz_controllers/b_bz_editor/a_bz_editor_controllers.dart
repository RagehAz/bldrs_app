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
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/x_screens/g_bz/a_bz_profile/a_my_bz_screen.dart';
import 'package:bldrs/c_controllers/g_bz_controllers/a_bz_profile/a_my_bz_screen_controllers.dart';
import 'package:bldrs/c_protocols/bz_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart' as Imagers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
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
        await _firstTimerCreateNewBzOps(
          context: context,
          newBzModel: _newBzModel,
          userModel: userModel,
        );
      }

      else {
        await _updateBzOps(
          context: context,
          newBzModel: _newBzModel,
          oldBzModel: initialBzModel,
        );
      }



      // /// ON SUCCESS
      // if (_uploadedBzModel != null){
      //
      //
      // }
      //
      // /// ON FAILURE
      // else {
      //
      //   /// CLOSE WAIT DIALOG
      //   WaitDialog.closeWaitDialog(context);
      //
      //   /// FAILURE DIALOG
      //   await CenterDialog.showCenterDialog(
      //     context: context,
      //     title: 'Ops !',
      //     body: 'Something went wrong, Please try again',
      //   );
      //
      // }

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
Future<void> _firstTimerCreateNewBzOps({
  @required BuildContext context,
  @required BzModel newBzModel,
  @required UserModel userModel,
}) async {

  unawaited(WaitDialog.showWaitDialog(
    context: context,
    loadingPhrase: 'Creating a new Business Account',
  ));

  /// FIREBASE CREATE BZ OPS
  final BzModel _uploadedBzModel = await BzFireOps.createBz(
    context: context,
    draftBz: newBzModel,
    userModel: userModel,
  );

  /// ON SUCCESS
  if (_uploadedBzModel != null){

    /// LDB CREATE BZ OPS
    await BzLDBOps.insertBz(
      bzModel: _uploadedBzModel,
    );
    /// LDB UPDATE USER MODEL
    await UserLDBOps.addBzIDToMyBzzIDs(
      userModel: userModel,
      bzIDToAdd: _uploadedBzModel.id,
    );

    /// SET BZ MODEL LOCALLY
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

    final BzModel _bzModelWithCompleteZoneModel = await completeBzZoneModel(
        context: context,
        bzModel: _uploadedBzModel
    );

    _bzzProvider.addBzToMyBzz(
      bzModel: _bzModelWithCompleteZoneModel,
      notify: false,
    );

    _bzzProvider.setActiveBz(
      bzModel: _bzModelWithCompleteZoneModel,
      notify: true,
    );

    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    _usersProvider.addBzIDToMyBzzIDs(
        bzIDToAdd: _bzModelWithCompleteZoneModel.id,
        notify: true,
    );

    /// CLOSE WAIT DIALOG
    WaitDialog.closeWaitDialog(context);

    /// NAVIGATE
    Nav.goBackToHomeScreen(context);
    unawaited(
        Nav.goToNewScreen(
          context: context,
          transitionType: PageTransitionType.fade,
          screen: const MyBzScreen(),
        )
    );

    /// SHOW SUCCESS DIALOG
    await TopDialog.showTopDialog(
      context: context,
      firstLine: 'Great !',
      secondLine: 'Successfully created your Business Account',
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

  /// ON FAILURE
  else {

    /// CLOSE WAIT DIALOG
    WaitDialog.closeWaitDialog(context);

    await _failureDialog(context);

  }


}
// ----------------------------------
Future<void> _updateBzOps({
  @required BuildContext context,
  @required BzModel newBzModel,
  @required BzModel oldBzModel,
}) async {

  unawaited(WaitDialog.showWaitDialog(
    context: context,
    loadingPhrase: 'Updating Business account',
  ));

  /// FIREBASE UPDATE BZ OPS
  final BzModel _uploadedBzModel = await BzFireOps.updateBz(
    context: context,
    newBzModel: newBzModel,
    oldBzModel: oldBzModel,
    authorPicFile: null,
  );

  /// ON SUCCESS
  if (_uploadedBzModel != null){

    await BzProtocol.myActiveBzLocalUpdateProtocol(
        context: context,
        newBzModel: _uploadedBzModel,
        oldBzModel: oldBzModel
    );

    /// CLOSE WAIT DIALOG
    WaitDialog.closeWaitDialog(context);

    /// NAVIGATE
    Nav.goBackToHomeScreen(context);
    unawaited(
        Nav.goToNewScreen(
          context: context,
          transitionType: PageTransitionType.fade,
          screen: const MyBzScreen(
            initialTab: BzTab.about,
          ),
        )
    );

    /// SHOW SUCCESS DIALOG
    unawaited(TopDialog.showTopDialog(
      context: context,
      firstLine: 'Great !',
      secondLine: 'Successfully updated your Business Account',
      color: Colorz.green255,
      textColor: Colorz.white255,
    ));

    // /// GO BACK
    // Nav.goBack(context);
    // await Nav.replaceScreen(
    //     context: context,
    //     transitionType: PageTransitionType.fade,
    //     screen: const MyBzScreen(
    //       initialTab: BzTab.about,
    //     ),
    // );

  }

  /// OF FAILURE
  else {

  /// CLOSE WAIT DIALOG
  WaitDialog.closeWaitDialog(context);

  await _failureDialog(context);

  }

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
// ----------------------------------
Future<void> _failureDialog(BuildContext context) async {

    /// FAILURE DIALOG
    await CenterDialog.showCenterDialog(
      context: context,
      title: 'Ops !',
      body: 'Something went wrong, Please try again',
    );

}
// ----------------------------------
