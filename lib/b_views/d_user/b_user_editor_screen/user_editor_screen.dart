// ignore_for_file: avoid_positional_boolean_parameters
import 'dart:async';
import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:basics/super_box/super_box.dart';
import 'package:bldrs/a_models/a_user/draft/draft_user.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/x_user_editor_controllers.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/contact_field_editor_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/social_field_editor_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/gender_bubble/gender_editor_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pic_bubble/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/tile_bubble/tile_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editors_buttons/editor_confirm_page.dart';
import 'package:bldrs/b_views/z_components/buttons/editors_buttons/editor_swiping_buttons.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/pages_builder.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';

enum UserEditorTab{
  pic,
  info,
  location,
  contacts,
  confirm,
}

class UserEditorScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const UserEditorScreen({
    required this.initialTab,
    required this.firstTimer,
    required this.userModel,
    required this.onFinish,
    required this.canGoBack,
    required this.reAuthBeforeConfirm,
    required this.validateOnStartup,
    this.checkLastSession = true,
    super.key
  });
  // --------------------------------------------------------------------------
  final UserEditorTab initialTab;
  final bool firstTimer;
  final UserModel? userModel;
  final Function onFinish;
  final bool canGoBack;
  final bool reAuthBeforeConfirm;
  final bool checkLastSession;
  final bool validateOnStartup;
  // --------------------------------------------------------------------------
  @override
  _UserEditorScreenState createState() => _UserEditorScreenState();
  // --------------------------------------------------------------------------
}

class _UserEditorScreenState extends State<UserEditorScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel?> _progressBarModel = ValueNotifier(null);
  PageController _pageController = PageController();
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
  final ValueNotifier<DraftUser?> _draftUser = ValueNotifier(null);
  DraftUser? _originalDraft;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
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

    final int _initialIndex = _getInitialTabIndex(widget.initialTab);

    _pageController = PageController(
      initialPage: _initialIndex,
    );

    setNotifier(
        notifier: _progressBarModel,
        mounted: mounted,
        value: ProgressBarModel.initialModel(
          numberOfStrips: 5,
          index: _initialIndex,
        ),
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        await _initializeDraft();
        // -------------------------------
        if (widget.checkLastSession == true){
          await loadUserEditorLastSession(
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
          /// REMOVED
          _draftUser.addListener(_draftUserListener);
        }
        // -----------------------------
        await _triggerLoading(setTo: false);
      });

    }

    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    _draftUser.removeListener(_draftUserListener);
    _loading.dispose();
    _draftUser.value?.dispose();
    _draftUser.dispose();
    _pageController.dispose();
    _progressBarModel.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  int _getInitialTabIndex(UserEditorTab tab){

    switch(tab){
      case UserEditorTab.pic:
        return 0;
      case UserEditorTab.info:
        return 1;
      case UserEditorTab.location:
        return 2;
      case UserEditorTab.contacts:
        return 3;
      case UserEditorTab.confirm:
        return 4;
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _initializeDraft() async {
    final DraftUser? _newDraft = await DraftUser.createDraftUser(
      context: context,
      userModel: widget.userModel,
      firstTimer: widget.firstTimer,
    );
    setNotifier(
      notifier: _draftUser,
      mounted: mounted,
      value: _newDraft,
    );
    final UserModel? _user = await UserFireOps.readUser(userID: widget.userModel?.id);
    _originalDraft = await DraftUser.createDraftUser(
      context: context,
      userModel: _user,
      firstTimer: widget.firstTimer,
    );
  }
  // -----------------------------------------------------------------------------

  /// LISTENERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _draftUserListener() async {

    // _switchOnValidation();

    _stripsListener();

    await UserLDBOps.saveEditorSession(draft: _draftUser.value,);

  }
  // -----------------------------------------------------------------------------

  /// STRIPS

  // --------------------
  /// TESTED : WORKS PERFECT
  void _stripsListener(){

    // -----------------
    /// STRIP 1 : PICTURE - GENDER

    final bool _picIsValid = Formers.picValidator(
        pic: _draftUser.value?.picModel,
        canValidate: true,
    ) == null;
    final bool _genderIsValid = Formers.genderValidator(
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
        name: _draftUser.value?.name,
        canValidate: true,
    ) == null;
    final bool _titleIsValid = Formers.jobTitleValidator(
        jobTitle: _draftUser.value?.title,
        canValidate: true,
    ) == null;
    final bool _companyIsValid = Formers.companyNameValidator(
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
      zoneModel: _draftUser.value?.zone,
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

    final bool _contactsAreValid = Formers.contactsAreValid(
        contacts: _draftUser.value?.contacts,
        zoneModel: _draftUser.value?.zone,
        phoneIsMandatory: false,
        websiteIsMandatory: false,
    );

    if (_contactsAreValid == false){
      setStripIsValid(3, false);
    }
    else {
      setStripIsValid(3, true);
    }

    // ------->

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
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canConfirmEdits(){
    final bool _hasError = Mapper.boolIsTrue(_progressBarModel.value?.stripsColors?.contains(ProgressBarModel.errorStripColor));
    return _hasError == false && _userHasChange() == true;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _userHasChange(){
     return !DraftUser.checkAreIdentical(
          draft1: _originalDraft,
          draft2: _draftUser.value,
      );
  }
  // -----------------------------------------------------------------------------

  /// SWIPING

  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom0to1({
    required DraftUser? draft,
  }){
    return Formers.picValidator(pic: draft?.picModel, canValidate: true,) == null
           &&
           Formers.genderValidator(gender: draft?.gender, canValidate: true,) == null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom1To2({
    required DraftUser? draft,
  }){

     return Formers.personNameValidator(
              name: draft?.nameController?.text,
              canValidate: true,
              // focusNode: draft?.nameNode,
            ) == null
            &&
            Formers.jobTitleValidator(
              jobTitle: draft?.titleController?.text,
              canValidate: true,
              // focusNode: draft?.titleNode,
            ) == null
            &&
            Formers.companyNameValidator(
              companyName: draft?.companyController?.text,
              canValidate: true,
              // focusNode: draft?.companyNode,
            ) == null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom2to3({
    required DraftUser? draft,
  }){
    return Formers.zoneValidator(
      zoneModel: draft?.zone,
      selectCountryIDOnly: false,
      canValidate: true,
    ) == null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom3To4({
    required DraftUser? draft
  }){
    return Formers.contactsAreValid(
        contacts: draft?.contacts,
        zoneModel: draft?.zone,
        phoneIsMandatory: false,
        websiteIsMandatory: false,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onNextTap() async {

    await EditorSwipingButtons.onNextTap(
      context: context,
      mounted: mounted,
      pageController: _pageController,
      progressBarModel: _progressBarModel,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onPreviousTap() async {

    await EditorSwipingButtons.onPreviousTap(
      context: context,
      mounted: mounted,
      pageController: _pageController,
      progressBarModel: _progressBarModel,
    );

  }
  // -----------------------------------------------------------------------------

  /// CONFIRMATION

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onConfirmTap() async {

    blog('CONFIRM TAPPED');

    _switchOnValidation();

    await confirmEdits(
      draft: _draftUser,
      mounted: mounted,
      onFinish: widget.onFinish,
      oldUser: widget.userModel,
      loading: _loading,
      forceReAuthentication: widget.reAuthBeforeConfirm,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Verse _createConfirmVerse(){

    if (UserModel.userIsSignedUp(widget.userModel) == true){
       return const Verse(id: 'phid_updateProfile', translate: true);
    }

    else {
      return const Verse(id: 'phid_createProfile', translate: true);
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      canSwipeBack: false,
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      title: _createConfirmVerse(),
      skyType: SkyType.grey,
      loading: _loading,
      progressBarModel: _progressBarModel,
      onBack: () async {

        if (widget.canGoBack == true){
          await Dialogs.goBackDialog(
            goBackOnConfirm: true,
            titleVerse: const Verse(id: 'phid_exit_this_editor_page?', translate: true),
            bodyVerse: const Verse(id: 'phid_draft_is_temp_stored', translate: true),
            confirmButtonVerse: const Verse(id: 'phid_exit', translate: true),
          );
        }

        else {
          blog('can not go back');
        }

      },
      appBarRowWidgets: <Widget>[

        ValueListenableBuilder(
            valueListenable: _draftUser,
            builder: (_, DraftUser? draft, Widget? child){

              return AppBarButton(
                icon: draft?.picModel?.bytes ?? draft?.picModel?.path ?? Iconz.anonymousUser,
                bigIcon: true,
                bubble: false,
                onTap: () async {

                  _draftUser.value?.blogDraftUser();

                  await EditorSwipingButtons.onGoToIndexPage(
                    context: context,
                    progressBarModel: _progressBarModel,
                    pageController: _pageController,
                    mounted: mounted,
                    toIndex: 0,
                  );

                  },
              );

            }
            ),

      ],
      canGoBack: widget.canGoBack,
      child: ValueListenableBuilder(
        valueListenable: _draftUser,
        builder: (_, DraftUser? draft, Widget? child){

          final bool _contactsArePublic = Mapper.boolIsTrue(draft?.contactsArePublic);

          return Form(
            key: draft?.formKey,
            child: PagerBuilder(
              progressBarModel: _progressBarModel,
              pageController: _pageController,
              pageBubbles: <Widget>[

                /// 0 - PIC - GENDER
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// PICTURE
                    AddImagePicBubble(
                      formKey: draft?.formKey,
                      titleVerse: const Verse(
                        id: 'phid_picture',
                        translate: true,
                      ),
                      redDot: true,
                      picModel: draft?.picModel,
                      bubbleType: BubbleType.userPic,
                      onAddPicture: (PicMakerType imagePickerType) => takeUserPicture(
                        draft: _draftUser,
                        picMakerType: imagePickerType,
                        mounted: mounted,
                      ),
                      validator: () => Formers.picValidator(
                        pic: draft?.picModel,
                        canValidate: _canValidate,
                      ),
                      onPicLongTap: (){

                        setNotifier(
                          notifier: _draftUser,
                          mounted: mounted,
                          value: draft?.nullifyField(
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

                    /// SWIPING BUTTONS
                    EditorSwipingButtons(
                      onNext: _onNextTap,
                      canGoNext: _canGoFrom0to1(draft: draft),
                    ),

                  ],
                ),

                /// 1 - NAME - OCCUPATION - COMPANY
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// NAME
                    BldrsTextFieldBubble(
                      key: const ValueKey<String>('name'),
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_name',
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
                      onTextChanged: (String? text) => onUserNameChanged(
                        text: text,
                        draft: _draftUser,
                        mounted: mounted,
                      ),
                      autoCorrect: Keyboard.autoCorrectIsOn(),
                      enableSuggestions: Keyboard.suggestionsEnabled(),
                      // autoValidate: true,
                      validator: (String? text) => Formers.personNameValidator(
                        name: text,
                        canValidate: _canValidate,
                        // focusNode: draft?.nameNode,
                      ),
                    ),

                    /// JOB TITLE
                    BldrsTextFieldBubble(
                      key: const ValueKey<String>('title'),
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_occupation',
                          translate: true,
                        ),
                        redDot: true,
                      ),
                      formKey: draft?.formKey,
                      focusNode: draft?.titleNode,
                      appBarType: AppBarType.basic,
                      isFormField: true,
                      // keyboardTextInputType: TextInputType.text,
                      keyboardTextInputAction: TextInputAction.next,
                      textController: draft?.titleController,
                      onTextChanged: (String? text) => onUserJobTitleChanged(
                        draft: _draftUser,
                        text: text,
                        mounted: mounted,
                      ),
                      autoCorrect: Keyboard.autoCorrectIsOn(),
                      enableSuggestions: Keyboard.suggestionsEnabled(),
                      // autoValidate: false,
                      validator: (String? text) => Formers.jobTitleValidator(
                        jobTitle: text,
                        canValidate: _canValidate,
                        // focusNode: draft?.titleNode,
                      ),
                    ),

                    /// COMPANY NAME
                    BldrsTextFieldBubble(
                      key: const ValueKey<String>('company'),
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_companyName',
                          translate: true,
                        ),
                        redDot: true,
                      ),
                      formKey: draft?.formKey,
                      focusNode: draft?.companyNode,
                      appBarType: AppBarType.basic,
                      isFormField: true,
                      // keyboardTextInputType: TextInputType.text,
                      keyboardTextInputAction: TextInputAction.next,
                      textController: draft?.companyController,
                      bulletPoints: const [
                        Verse(
                          id: 'phid_company_name_u_work_for',
                          translate: true,
                        ),
                      ],
                      // autoValidate: true,
                      onTextChanged: (String? text) => onUserCompanyNameChanged(
                        text: text,
                        draft: _draftUser,
                        mounted: mounted,
                      ),
                      autoCorrect: Keyboard.autoCorrectIsOn(),
                      enableSuggestions: Keyboard.suggestionsEnabled(),
                      // autoValidate: false,
                      validator: (String? text) => Formers.companyNameValidator(
                        companyName: text,
                        canValidate: _canValidate,
                        // focusNode: draft?.companyNode,
                      ),
                    ),

                    /// SWIPING BUTTONS
                    EditorSwipingButtons(
                      onNext: _onNextTap,
                      onPrevious: _onPreviousTap,
                      canGoNext: _canGoFrom1To2(draft: draft),
                    ),

                    const Horizon(
                      heightFactor: 0,
                    ),

                  ],
                ),

                /// 2 - LOCATION
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// ZONE
                    ZoneSelectionBubble(
                      currentZone: draft?.zone,
                      zoneViewingEvent: ViewingEvent.userEditor,
                      onZoneChanged: (ZoneModel? zoneModel) => onUserZoneChanged(
                        selectedZone: zoneModel,
                        draft: _draftUser,
                        mounted: mounted,
                      ),
                      depth: ZoneDepth.city,
                      viewerZone: draft?.zone,
                      // autoValidate: false,
                      validator: () => Formers.zoneValidator(
                        zoneModel: draft?.zone,
                        selectCountryIDOnly: false,
                        canValidate: _canValidate,
                      ),
                    ),

                    /// SWIPING BUTTONS
                    EditorSwipingButtons(
                      onNext: _onNextTap,
                      onPrevious: _onPreviousTap,
                      canGoNext: _canGoFrom2to3(draft: draft),
                    ),

                  ],
                ),

                /// 3 - CONTACTS
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// SHOW / HIDE CONTACTS
                    if (draft != null)
                    BldrsTileBubble(
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: Verse(
                          id: Mapper.boolIsTrue(draft.contactsArePublic) == true ?
                          'phid_contacts_are_public'
                          :
                          'phid_contacts_are_hidden'
                          ,
                          translate: true,
                        ),
                        switchValue: draft.contactsArePublic,
                        hasSwitch: true,
                        leadingIcon: _contactsArePublic == true ? Iconz.viewsIcon : Iconz.hidden,
                        leadingIconSizeFactor: 0.7,
                        leadingIconBoxColor: Colorz.nothing,
                        onSwitchTap: (bool value) {

                            setNotifier(
                              notifier: _draftUser,
                              mounted: mounted,
                              value: draft.copyWith(
                                contactsArePublic: value,
                              ),
                            );

                        },
                      ),
                    ),

                    /// PHONE
                    if (draft != null)
                    ContactFieldEditorBubble(
                      key: const ValueKey<String>('phone'),
                      formKey: draft.formKey,
                      focusNode: draft.phoneNode,
                      appBarType: AppBarType.basic,
                      isFormField: true,
                      headerViewModel: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_phone',
                          translate: true,
                        ),
                        // redDot: false,
                        leadingIcon: _contactsArePublic == true ? Iconz.comPhone : Iconz.hidden,
                        leadingIconSizeFactor: 0.7,
                        leadingIconBoxColor: Colorz.nothing,
                      ),
                      contactsArePublic : _contactsArePublic,
                      keyboardTextInputType: TextInputType.phone,
                      bulletPoints: <Verse>[

                        const Verse(id: 'phid_optional_field', translate: true),

                        ...ContactFieldEditorBubble.privacyPoint(
                          contactsArePublic: _contactsArePublic,
                        ),

                      ],
                      keyboardTextInputAction: TextInputAction.next,
                      // initialTextValue: ContactModel.getInitialContactValue(
                      //   type: ContactType.phone,
                      //   countryID: draft?.zone?.countryID,
                      //   existingContacts: draft?.contacts,
                      // ),
                      textController: draft.phoneController,
                      textOnChanged: (String? text) => onUserContactChanged(
                        contactType: ContactType.phone,
                        value: text,
                        draft: _draftUser,
                        mounted: mounted,
                      ),
                      canPaste: false,
                      // autoValidate: false,
                      validator: (String? text) => Formers.phoneValidator(
                        phone: text,
                        zoneModel: draft.zone,
                        canValidate: _canValidate,
                        isMandatory: false,
                      ),
                      hintVerse: Verse.plain(
                          '${Flag.getCountryPhoneCode(draft.zone?.countryID) ?? '00'} 000 00 ...'
                      ),
                    ),

                    /// EMAIL
                    if (draft != null)
                    Disabler(
                      isDisabled: Authing.checkIsSocialSignInMethod(draft.signInMethod),
                      child: ContactFieldEditorBubble(
                        key: const ValueKey<String>('email'),
                        formKey: draft.formKey,
                        focusNode: draft.emailNode,
                        appBarType: AppBarType.basic,
                        isFormField: true,
                        headerViewModel: BldrsBubbleHeaderVM.bake(
                          context: context,
                          headlineVerse: const Verse(
                            id: 'phid_emailAddress',
                            translate: true,
                          ),
                          redDot: true,
                          leadingIcon: _contactsArePublic == true ? Iconz.comEmail : Iconz.hidden,
                          leadingIconSizeFactor: 0.7,
                          leadingIconBoxColor: Colorz.nothing,
                        ),
                        bulletPoints: [
                          ...ContactFieldEditorBubble.privacyPoint(
                          contactsArePublic: _contactsArePublic,
                        ),
                          if (Authing.checkIsSocialSignInMethod(draft.signInMethod) == true)
                            const Verse(
                              id: 'phid_social_auth_email_is_fixed',
                              translate: true,
                            ),
                        ],
                        contactsArePublic: _contactsArePublic,
                        keyboardTextInputType: TextInputType.emailAddress,
                        keyboardTextInputAction: TextInputAction.done,
                        // initialTextValue: ContactModel.getInitialContactValue(
                        //   type: ContactType.email,
                        //   countryID: draft?.zone?.countryID,
                        //   existingContacts: draft?.contacts,
                        // ),
                        textController: draft.emailController,
                        textOnChanged: (String? text) => onUserContactChanged(
                          contactType: ContactType.email,
                          value: text,
                          draft: _draftUser,
                          mounted: mounted,
                        ),
                        canPaste: false,
                        // autoValidate: false,
                        validator: (String? text) => Formers.emailValidator(
                          email: text,
                          canValidate: _canValidate,
                        ),
                        hintVerse: Verse.plain('bldr@bldrs.net'),
                      ),
                    ),

                    /// FACEBOOK - INSTAGRAM - TWITTER - LINKEDIN - YOUTUBE - TIKTOK - SNAPCHAT
                    if (draft != null)
                    Disabler(
                      isDisabled: !_contactsArePublic,
                      child: SocialFieldEditorBubble(
                        contacts: draft.contacts,
                        onContactChanged: (ContactModel contact) => onUserContactChanged(
                          contactType: contact.type!,
                          value: contact.value,
                          draft: _draftUser,
                          mounted: mounted,
                        ),
                      ),
                    ),

                    /// SWIPING BUTTONS
                    EditorSwipingButtons(
                      onNext: _onNextTap,
                      onPrevious: _onPreviousTap,
                      canGoNext: _canGoFrom3To4(draft: draft),
                    ),

                    const Horizon(
                      heightFactor: 0,
                    ),

                  ],
                ),

                /// 4 - CONFIRM
                EditorConfirmPage(
                  verse: _createConfirmVerse(),
                  onConfirmTap: _onConfirmTap,
                  canConfirm: _canConfirmEdits(),
                  modelHasChanged: _userHasChange(),
                  onPreviousTap: _onPreviousTap,
                  previewWidget: Container(),
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
