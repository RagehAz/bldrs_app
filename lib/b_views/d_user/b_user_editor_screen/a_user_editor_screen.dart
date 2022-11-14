import 'dart:async';

import 'package:bldrs/a_models/a_user/draft_user.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/x_user_editor_controllers.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pic_bubble/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/contact_field_editor_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/gender_bubble/gender_editor_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const EditProfileScreen({
    @required this.userModel,
    @required this.onFinish,
    @required this.canGoBack,
    @required this.reAuthBeforeConfirm,
    @required this.validateOnStartup,
    this.checkLastSession = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final UserModel userModel;
  final Function onFinish;
  final bool canGoBack;
  final bool reAuthBeforeConfirm;
  final bool checkLastSession;
  final bool validateOnStartup;
  /// --------------------------------------------------------------------------
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
  /// --------------------------------------------------------------------------
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // -----------------------------------------------------------------------------
  bool _canValidate = false;
  void _switchOnValidation(){
    if (mounted == true){
      if (_canValidate != true){
        setState(() {
          _canValidate = true;
        });
      }
    }
  }
  // --------------------
  final ValueNotifier<DraftUser> _draftUser = ValueNotifier(null);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        setNotifier(
          notifier: _draftUser,
          mounted: mounted,
          value: await DraftUser.createDraftUser(
            context: context,
            userModel: widget.userModel,
          ),
        );
        // -------------------------------
        if (widget.checkLastSession == true){
          await loadUserEditorLastSession(
            context: context,
            draft: _draftUser,
            // userID: widget.userModel.id,
            // onFinish: widget.onFinish,
            // canGoBack: widget.canGoBack,
            // reAuthBeforeConfirm: widget.reAuthBeforeConfirm,
          );
          setState(() {
            _canValidate = true;
          });
        }
        // -----------------------------
        if (widget.validateOnStartup == true){
          _switchOnValidation();
          Formers.validateForm(_draftUser.value.formKey);
        }
        // -----------------------------
        if (mounted == true){
          _draftUser.addListener(() async {
            // _switchOnValidation();
            await UserLDBOps.saveEditorSession(
              draft: _draftUser.value,
            );

          });
        }
        // -----------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  /// tamam
  @override
  void dispose() {

    _loading.dispose();
    _draftUser.value.dispose();
    _draftUser.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _onConfirmTap() async {

    _switchOnValidation();

    await confirmEdits(
      context: context,
      draft: _draftUser,
      mounted: mounted,
      onFinish: widget.onFinish,
      loading: _loading,
      forceReAuthentication: widget.reAuthBeforeConfirm,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      canGoBack: widget.canGoBack,
      skyType: SkyType.black,
      historyButtonIsOn: false,
      appBarType: AppBarType.basic,
      pageTitleVerse: const Verse(text: 'phid_updateProfile', translate: true),
      loading: _loading,
      confirmButtonModel: ConfirmButtonModel(
        firstLine: const Verse(text: 'phid_updateProfile', translate: true),
        onTap: () => _onConfirmTap(),
      ),
      layoutWidget: ValueListenableBuilder(
        valueListenable: _draftUser,
        builder: (_, DraftUser draft, Widget child){

          return Form(
            key: draft?.formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              children: <Widget>[

                const Stratosphere(),

                /// PICTURE
                AddImagePicBubble(
                  formKey: draft?.formKey,
                  titleVerse: const Verse(
                    text: 'phid_picture',
                    translate: true,
                  ),
                  redDot: true,
                  picModel: draft?.picModel,
                  bubbleType: BubbleType.userPic,
                  onAddPicture: (PicMakerType imagePickerType) => takeUserPicture(
                    context: context,
                    draft: _draftUser,
                    picMakerType: imagePickerType,
                    mounted: mounted,
                  ),
                  validator: () => Formers.picValidator(
                    pic: draft?.picModel,
                    canValidate: _canValidate,
                  ),
                ),

                /// GENDER
                GenderBubble(
                  draftUser: draft,
                  canValidate: _canValidate,
                  onTap: (Gender gender) => onChangeGender(
                    selectedGender: gender,
                    draft: _draftUser,
                  ),
                ),

                /// NAME
                TextFieldBubble(
                  key: const ValueKey<String>('name'),
                  headerViewModel: const BubbleHeaderVM(
                    headlineVerse: Verse(
                      text: 'phid_name',
                      translate: true,
                    ),
                    redDot: true,
                  ),
                  formKey: draft?.formKey,
                  focusNode: draft?.nameNode,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  initialText: draft?.name,
                  onTextChanged: (String text) => onUserNameChanged(
                    text: text,
                    draft: _draftUser,
                  ),
                  // autoValidate: true,
                  validator: (String text) => Formers.personNameValidator(
                    name: draft?.name,
                    canValidate: _canValidate,
                  ),
                ),

                /// JOB TITLE
                TextFieldBubble(
                  key: const ValueKey<String>('title'),
                  headerViewModel: const BubbleHeaderVM(
                    headlineVerse: Verse(
                      text: 'phid_occupation',
                      translate: true,
                    ),
                    redDot: true,
                  ),
                  formKey: draft?.formKey,
                  focusNode: draft?.titleNode,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  initialText: draft?.title,
                  onTextChanged: (String text) => onUserJobTitleChanged(
                    draft: _draftUser,
                    text: text,
                  ),
                  // autoValidate: true,
                  validator: (String text) => Formers.jobTitleValidator(
                    jobTitle: draft?.title,
                    canValidate: _canValidate,
                  ),
                ),

                /// COMPANY NAME
                TextFieldBubble(
                  key: const ValueKey<String>('company'),
                  headerViewModel: const BubbleHeaderVM(
                    headlineVerse: Verse(
                      text: 'phid_companyName',
                      translate: true,
                    ),
                    redDot: true,
                  ),
                  formKey: draft?.formKey,
                  focusNode: draft?.companyNode,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  keyboardTextInputType: TextInputType.name,
                  keyboardTextInputAction: TextInputAction.next,
                  initialText: draft?.company,
                  // autoValidate: true,
                  onTextChanged: (String text) => onUserCompanyNameChanged(
                    text: text,
                    draft: _draftUser,
                  ),
                  validator: (String text) => Formers.companyNameValidator(
                    companyName: draft?.company,
                    canValidate: _canValidate,
                  ),
                ),

                const DotSeparator(),

                /// PHONE
                ContactFieldEditorBubble(
                  key: const ValueKey<String>('phone'),
                  formKey: draft?.formKey,
                  focusNode: draft?.phoneNode,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  headerViewModel: const BubbleHeaderVM(
                    headlineVerse: Verse(
                      text: 'phid_phone',
                      translate: true,
                    ),
                    redDot: true,
                  ),
                  keyboardTextInputType: TextInputType.phone,
                  keyboardTextInputAction: TextInputAction.next,
                  initialTextValue: ContactModel.getInitialContactValue(
                    type: ContactType.phone,
                    countryID: draft?.zone?.countryID,
                    existingContacts: draft?.contacts,
                  ),
                  textOnChanged: (String text) => onUserContactChanged(
                    contactType: ContactType.phone,
                    value: text,
                    draft: _draftUser,
                  ),
                  canPaste: false,
                  // autoValidate: true,
                  validator: (String text) => Formers.contactsPhoneValidator(
                    contacts: draft?.contacts,
                    zoneModel: draft?.zone,
                    canValidate: _canValidate,
                    context: context,
                    isRequired: false,
                  ),
                ),

                /// EMAIL
                ContactFieldEditorBubble(
                  key: const ValueKey<String>('email'),
                  formKey: draft?.formKey,
                  focusNode: draft?.emailNode,
                  appBarType: AppBarType.basic,
                  isFormField: true,
                  headerViewModel: const BubbleHeaderVM(
                    headlineVerse: Verse(
                      text: 'phid_emailAddress',
                      translate: true,
                    ),
                    redDot: true,
                  ),
                  keyboardTextInputType: TextInputType.emailAddress,
                  keyboardTextInputAction: TextInputAction.done,
                  initialTextValue: ContactModel.getInitialContactValue(
                    type: ContactType.email,
                    countryID: draft?.zone?.countryID,
                    existingContacts: draft?.contacts,
                  ),
                  textOnChanged: (String text) => onUserContactChanged(
                    contactType: ContactType.email,
                    value: text,
                    draft: _draftUser,
                  ),
                  canPaste: false,
                  // autoValidate: true,
                  validator: (String text) => Formers.contactsEmailValidator(
                    contacts: draft?.contacts,
                    canValidate: _canValidate,
                  ),
                ),

                const DotSeparator(),

                /// ZONE
                ZoneSelectionBubble(
                  currentZone: draft?.zone,
                  onZoneChanged: (ZoneModel zoneModel) => onUserZoneChanged(
                    selectedZone: zoneModel,
                    draft: _draftUser,
                  ),
                  // selectCountryAndCityOnly: true,
                  // selectCountryIDOnly: false,
                  validator: () => Formers.zoneValidator(
                    zoneModel: draft?.zone,
                    selectCountryAndCityOnly: true,
                    selectCountryIDOnly: false,
                    canValidate: _canValidate,
                  ),
                ),

                /// CONTACTS
                // ContactsEditorsBubbles(
                //   globalKey: formKey,
                //   contacts: userModel.contacts,
                //   contactsOwnerType: ContactsOwnerType.user,
                //   appBarType: appBarType,
                // ),

                const Horizon(),

              ],
            ),
          );

        },
      ),

    );

  }
  // -----------------------------------------------------------------------------
}
