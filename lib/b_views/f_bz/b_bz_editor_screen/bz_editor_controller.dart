import 'dart:async';
import 'dart:typed_data';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/draft/draft_bz.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/i_pic/pic_meta_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/b_views/i_phid_picker/phids_picker_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------

/// LAST SESSION

// --------------------
/// TASK : TEST ME
Future<void> loadBzEditorLastSession({
  @required BuildContext context,
  @required ValueNotifier<DraftBz> draftNotifier,
}) async {

  final DraftBz _lastSessionDraft = await BzLDBOps.loadBzEditorSession(
    context: context,
    bzID: draftNotifier.value.id,
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

      draftNotifier.value = DraftBz.reAttachNodes(
        draftFromLDB: _lastSessionDraft,
        draftWithNodes: draftNotifier.value,
      );

    }

  }

}
// --------------------
/// TASK : TEST ME
Future<void> saveBzEditorSession(ValueNotifier<DraftBz> draftNotifier) async {

  triggerCanValidateDraftBz(draftNotifier: draftNotifier, setTo: true,);

  await BzLDBOps.saveBzEditorSession(
      draft: draftNotifier.value,
  );

}
// -----------------------------------------------------------------------------

/// CONFIRMATION

// --------------------
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
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
        text: 'phid_you_want_to_continue',
        translate: true,
      ),
      boolDialog: true,
    );


  }

  return _canContinue;
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _uploadDraftBz({
  @required BuildContext context,
  @required ValueNotifier<DraftBz> draftNotifier,
  @required BzModel oldBz,
}) async {

  /// CREATING NEW BZ
  if (draftNotifier.value.firstTimer == true){
    await BzProtocols.composeBz(
      context: context,
      newDraft: draftNotifier.value,
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
      newBz: DraftBz.toBzModel(draftNotifier.value),
      oldBz: oldBz,
      showWaitDialog: true,
      navigateToBzInfoPageOnEnd: true,
      newLogo: draftNotifier.value.hasNewLogo == true ? draftNotifier.value.logoPicModel : null,
    );
  }


}
// -----------------------------------------------------------------------------

/// MODIFIERS

// --------------------
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
Future<void> onChangeBzSection({
  @required BuildContext context,
  @required int index,
  @required ValueNotifier<DraftBz> draftNotifier,
}) async {

  bool _canContinue = true;

  if (Mapper.checkCanLoopList(draftNotifier.value.scope) == true){
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
      scope: [],
    );

    _newDraft = _newDraft.nullifyField(
      bzForm: true,
      inactiveBzForms: true,
      bzTypes: true,
      scope: true,
    );

    draftNotifier.value = _newDraft;

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onChangeBzType({
  @required BuildContext context,
  @required int index,
  @required ValueNotifier<DraftBz> draftNotifier,
}) async {

  bool _canContinue = true;

  if (Mapper.checkCanLoopList(draftNotifier.value.scope) == true){
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
    );

    draftNotifier.value = _newDraft;

  }

}
// --------------------
/// TESTED : WORKS PERFECT
void onChangeBzForm({
  @required int index,
  @required ValueNotifier<DraftBz> draftNotifier,
}){

  draftNotifier.value = draftNotifier.value.copyWith(
    bzForm: BzTyper.bzFormsList[index],
  );

}
// --------------------
/// TASK : TEST ME
Future<void> onChangeBzLogo({
  @required BuildContext context,
  @required ValueNotifier<DraftBz> draftNotifier,
  @required PicMakerType imagePickerType,
}) async {

  if (draftNotifier.value.canPickImage == true) {

    draftNotifier.value = draftNotifier.value.copyWith(canPickImage: false,);

    Uint8List _bytes;

    if(imagePickerType == PicMakerType.galleryImage){
      _bytes = await PicMaker.pickAndCropSinglePic(
        context: context,
        cropAfterPick: true,
        aspectRatio: 1,
        resizeToWidth: Standards.userPictureWidthPixels,
      );
    }

    else if (imagePickerType == PicMakerType.cameraImage){
      _bytes = await PicMaker.shootAndCropCameraPic(
        context: context,
        cropAfterPick: true,
        aspectRatio: 1,
        resizeToWidth: Standards.userPictureWidthPixels,
      );
    }

    /// IF DID NOT PIC ANY IMAGE
    if (_bytes == null) {
      draftNotifier.value = draftNotifier.value.copyWith(canPickImage: true,);
    }

    /// IF PICKED AN IMAGE
    else {

      final String _path = draftNotifier.value.getLogoPath();

      draftNotifier.value = draftNotifier.value.copyWith(
        canPickImage: true,
        hasNewLogo: true,
        logoPicModel: PicModel(
            bytes: _bytes,
            path: _path,
            meta: PicMetaModel(
              dimensions: await Dimensions.superDimensions(_bytes),
              ownersIDs: draftNotifier.value.getLogoOwners()
            )
        ),
      );

    }

  }

}
// --------------------
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
Future<void> onChangeBzScope({
  @required BuildContext context,
  @required ValueNotifier<DraftBz> draftNotifier,
  @required FlyerType flyerType,
}) async {

  Keyboard.closeKeyboard(context);

  final List<String> _phids = await Nav.goToNewScreen(
    context: context,
    pageTransitionType: Nav.superHorizontalTransition(context),
    screen: PhidsPickerScreen(
      multipleSelectionMode: true,
      selectedPhids: draftNotifier.value.scope,
      chainsIDs: FlyerTyper.getChainsIDsPerViewingEvent(
        context: context,
        flyerType: flyerType,
        event: ViewingEvent.bzEditor,
      ),
    ),
  );

  if (Mapper.checkCanLoopList(_phids) == true){
    draftNotifier.value = draftNotifier.value.copyWith(
      scope: _phids,
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
