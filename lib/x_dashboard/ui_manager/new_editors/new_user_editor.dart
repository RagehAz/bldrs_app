// ignore_for_file: avoid_positional_boolean_parameters
import 'dart:async';

import 'package:bldrs/a_models/a_user/draft/draft_user.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/x_user_editor_controllers.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/contact_field_editor_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/gender_bubble/gender_editor_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pic_bubble/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/pages_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class NewUserEditor extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NewUserEditor({
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
  _NewUserEditorState createState() => _NewUserEditorState();
  /// --------------------------------------------------------------------------
}

class _NewUserEditorState extends State<NewUserEditor> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  ConfirmButtonModel _confirmButtonModel;
  // -----------------------------------------------------------------------------
  bool _canValidate = true;
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

    setNotifier(
        notifier: _progressBarModel,
        mounted: mounted,
        value: ProgressBarModel.initialModel(
            numberOfStrips: 4,
        ),
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        final DraftUser _newDraft = await DraftUser.createDraftUser(
          context: context,
          userModel: widget.userModel,
        );
        setNotifier(
          notifier: _draftUser,
          mounted: mounted,
          value: _newDraft,
        );
        // -------------------------------
        if (widget.checkLastSession == true){
          await loadUserEditorLastSession(
            context: context,
            draft: _draftUser,
            mounted: mounted,
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
          Formers.validateForm(_draftUser.value?.formKey);
        }
        // -----------------------------
        if (mounted == true){
          _addSessionListeners();
        }
        // -----------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {

    _loading.dispose();
    _draftUser.value?.dispose();
    _draftUser?.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _addSessionListeners(){

    /// ON DRAFT
    _draftUser.addListener(() async {
      // _switchOnValidation();

      _stripsListener();

      await UserLDBOps.saveEditorSession(draft: _draftUser.value,);

    });

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onConfirmTap() async {

    blog('CONFIRM TAPPED');

    _switchOnValidation();

    await confirmEdits(
      context: context,
      draft: _draftUser,
      mounted: mounted,
      onFinish: widget.onFinish,
      oldUser: widget.userModel,
      loading: _loading,
      forceReAuthentication: widget.reAuthBeforeConfirm,
    );

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _stripsListener(){

    // -----------------
    /// STRIP 1 : PICTURE - GENDER

    final bool _picIsValid = Formers.picValidator(
        context: context,
        pic: _draftUser.value?.picModel,
        canValidate: true,
    ) == null;
    final bool _genderIsValid = Formers.genderValidator(
        context: context,
        gender: _draftUser.value?.gender,
        canValidate: true,
    ) == null;

    if (_picIsValid == false || _genderIsValid == false){
      setStripIsValid(0, false);
    }
    else {
      setStripIsValid(0, true);
    }

    // -----------------
    /// STRIP 2 : NAME - TITLE - COMPANY

    final bool _nameIsValid = Formers.personNameValidator(
        context: context,
        name: _draftUser.value?.name,
        canValidate: true,
    ) == null;
    final bool _titleIsValid = Formers.jobTitleValidator(
        context: context,
        jobTitle: _draftUser.value?.title,
        canValidate: true,
    ) == null;
    final bool _companyIsValid = Formers.companyNameValidator(
        context: context,
        companyName: _draftUser.value?.company,
        canValidate: true,
    ) == null;

    if (_nameIsValid == false || _titleIsValid == false || _companyIsValid == false){
      setStripIsValid(1, false);
    }
    else {
      setStripIsValid(1, true);
    }

    // -----------------
    /// STRIP 3 : ZONE

    final bool _zoneIsValid = Formers.zoneValidator(
      context: context,
      zoneModel: _draftUser.value?.zone,
      selectCountryAndCityOnly: true,
      selectCountryIDOnly: false,
      canValidate: true,
    ) == null;

    if (_zoneIsValid == false){
      setStripIsValid(2, false);
    }
    else {
      setStripIsValid(2, true);
    }

    // -----------------
    /// STRIP 4 : PHONE - EMAIL

    final bool _phoneIsValid = Formers.contactsPhoneValidator(
      contacts: _draftUser.value?.contacts,
      zoneModel: _draftUser.value?.zone,
      canValidate: true,
      context: context,
      isRequired: false,
      // focusNode: draft?.phoneNode,
    ) == null;
    final bool _emailIsValid = Formers.contactsEmailValidator(
      context: context,
      contacts: _draftUser.value?.contacts,
      canValidate: true,
      // focusNode: draft?.emailNode,
    ) == null;

    if (_phoneIsValid == false || _emailIsValid == false){
      setStripIsValid(3, false);
    }
    else {
      setStripIsValid(3, true);
    }

    // ------->

    _controlConfirmButton();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void setStripIsValid(int index, bool isValid){
    ProgressBarModel.setStripColor(
      notifier: _progressBarModel,
      mounted: mounted,
      index: index,
      color: isValid == true ? ProgressBarModel.goodStripColor : ProgressBarModel.errorStripColor,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _controlConfirmButton(){

    if (_progressBarModel.value.stripsColors.contains(ProgressBarModel.errorStripColor) == true){
      setState(() {
        _confirmButtonModel = null;
      });
    }

    else {
      setState(() {
        _confirmButtonModel = ConfirmButtonModel(
          firstLine: const Verse(text: 'phid_updateProfile', translate: true),
          onTap: _onConfirmTap,
          isWide: true,
        );
      });
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      title: const Verse(text: 'phid_updateProfile', translate: true),
      skyType: SkyType.black,
      loading: _loading,
      progressBarModel: _progressBarModel,
      onBack: () => Dialogs.goBackDialog(
        context: context,
        goBackOnConfirm: true,
      ),
      confirmButtonModel: _confirmButtonModel,
      child: ValueListenableBuilder(
        valueListenable: _draftUser,
        builder: (_, DraftUser draft, Widget child){

          return Form(
            key: draft?.formKey,
            child: PagerBuilder(
              progressBarModel: _progressBarModel,
              pageBubbles: <Widget>[

                /// PIC - GENDER
                FloatingList(
                  columnChildren: <Widget>[

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
                        context: context,
                        pic: draft?.picModel,
                        canValidate: _canValidate,
                      ),
                      onPicLongTap: (){

                        setNotifier(
                          notifier: _draftUser,
                          mounted: mounted,
                          value: draft.nullifyField(
                            picModel: true,
                          ),
                        );

                      },
                    ),

                    /// GENDER
                    GenderBubble(
                      draftUser: draft,
                      canValidate: _canValidate,
                      onTap: (Gender gender) => onChangeGender(
                        selectedGender: gender,
                        draft: _draftUser,
                        mounted: mounted,
                      ),
                    ),

                  ],
                ),

                /// NAME - OCCUPATION - COMPANY
                FloatingList(
                  columnChildren: <Widget>[

                    /// NAME
                    TextFieldBubble(
                      key: const ValueKey<String>('name'),
                      bubbleHeaderVM: const BubbleHeaderVM(
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
                      textController: draft?.nameController,
                      onTextChanged: (String text) => onUserNameChanged(
                        text: text,
                        draft: _draftUser,
                        mounted: mounted,
                      ),
                      // autoValidate: true,
                      validator: (String text) => Formers.personNameValidator(
                        context: context,
                        name: text,
                        canValidate: _canValidate,
                        // focusNode: draft?.nameNode,
                      ),
                    ),

                    /// JOB TITLE
                    TextFieldBubble(
                      key: const ValueKey<String>('title'),
                      bubbleHeaderVM: const BubbleHeaderVM(
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
                      textController: draft?.titleController,
                      onTextChanged: (String text) => onUserJobTitleChanged(
                        draft: _draftUser,
                        text: text,
                        mounted: mounted,
                      ),
                      // autoValidate: false,
                      validator: (String text) => Formers.jobTitleValidator(
                        context: context,
                        jobTitle: text,
                        canValidate: _canValidate,
                        // focusNode: draft?.titleNode,
                      ),
                    ),

                    /// COMPANY NAME
                    TextFieldBubble(
                      key: const ValueKey<String>('company'),
                      bubbleHeaderVM: const BubbleHeaderVM(
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
                      textController: draft?.companyController,
                      // autoValidate: true,
                      onTextChanged: (String text) => onUserCompanyNameChanged(
                        text: text,
                        draft: _draftUser,
                        mounted: mounted,
                      ),
                      // autoValidate: false,
                      validator: (String text) => Formers.companyNameValidator(
                        context: context,
                        companyName: text,
                        canValidate: _canValidate,
                        // focusNode: draft?.companyNode,
                      ),
                    ),

                  ],
                ),

                /// LOCATION
                FloatingList(
                  columnChildren: <Widget>[

                    /// ZONE
                    ZoneSelectionBubble(
                      currentZone: draft?.zone,
                      zoneViewingEvent: ViewingEvent.userEditor,
                      onZoneChanged: (ZoneModel zoneModel) => onUserZoneChanged(
                        selectedZone: zoneModel,
                        draft: _draftUser,
                        mounted: mounted,
                      ),
                      // selectCountryAndCityOnly: true,
                      // selectCountryIDOnly: false,
                      depth: ZoneDepth.district,
                      // autoValidate: false,
                      validator: () => Formers.zoneValidator(
                        context: context,
                        zoneModel: draft?.zone,
                        selectCountryAndCityOnly: true,
                        selectCountryIDOnly: false,
                        canValidate: _canValidate,
                      ),
                    ),

                  ],
                ),

                /// CONTACTS
                FloatingList(
                  columnChildren: <Widget>[

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
                        // redDot: false,
                      ),
                      keyboardTextInputType: TextInputType.phone,
                      keyboardTextInputAction: TextInputAction.next,
                      // initialTextValue: ContactModel.getInitialContactValue(
                      //   type: ContactType.phone,
                      //   countryID: draft?.zone?.countryID,
                      //   existingContacts: draft?.contacts,
                      // ),
                      textController: draft?.phoneController,
                      textOnChanged: (String text) => onUserContactChanged(
                        contactType: ContactType.phone,
                        value: text,
                        draft: _draftUser,
                        mounted: mounted,
                      ),
                      canPaste: false,
                      // autoValidate: false,
                      validator: (String text) => Formers.contactsPhoneValidator(
                        contacts: draft?.contacts,
                        zoneModel: draft?.zone,
                        canValidate: _canValidate,
                        context: context,
                        isRequired: false,
                        // focusNode: draft?.phoneNode,
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
                      // initialTextValue: ContactModel.getInitialContactValue(
                      //   type: ContactType.email,
                      //   countryID: draft?.zone?.countryID,
                      //   existingContacts: draft?.contacts,
                      // ),
                      textController: draft?.emailController,
                      textOnChanged: (String text) => onUserContactChanged(
                        contactType: ContactType.email,
                        value: text,
                        draft: _draftUser,
                        mounted: mounted,
                      ),
                      canPaste: false,
                      // autoValidate: false,
                      validator: (String text) => Formers.contactsEmailValidator(
                        context: context,
                        contacts: draft?.contacts,
                        canValidate: _canValidate,
                        // focusNode: draft?.emailNode,
                      ),
                    ),

                  ],
                ),

              ],
            ),
          );

        },
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
