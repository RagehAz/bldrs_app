// ignore_for_file: avoid_positional_boolean_parameters
import 'dart:async';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/x_author_editor_screen_controller.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/contacts_bubble/contact_field_editor_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/contacts_bubble/social_field_editor_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/pic_bubble/add_gallery_pic_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/z_components/buttons/editors_buttons/editor_confirm_page.dart';
import 'package:bldrs/z_components/buttons/editors_buttons/editor_swiping_buttons.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/z_components/layouts/custom_layouts/pages_builder.dart';
import 'package:bldrs/z_components/layouts/main_layout/app_bar/bldrs_app_bar.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/horizon.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';

class AuthorEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthorEditorScreen({
    required this.author,
    required this.bzModel,
    this.checkLastSession = true,
    this.validateOnStartup = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final AuthorModel? author;
  final BzModel? bzModel;
  final bool checkLastSession;
  final bool validateOnStartup;
  /// --------------------------------------------------------------------------
  @override
  _AuthorEditorScreenState createState() => _AuthorEditorScreenState();
/// --------------------------------------------------------------------------
}

class _AuthorEditorScreenState extends State<AuthorEditorScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel?> _progressBarModel = ValueNotifier(null);
  final PageController _pageController = PageController();
  // --------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --------------------
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
  final ValueNotifier<bool> _canPickImage = ValueNotifier(true);
  // --------------------
  final ValueNotifier<AuthorModel?> _draftAuthor = ValueNotifier(null);
  AuthorModel? _originalDraft;
  // --------------------
  final ScrollController _scrollController = ScrollController();
  // --------------------
  final FocusNode _nameNode = FocusNode();
  final FocusNode _titleNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(true);
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

    setNotifier(
        notifier: _draftAuthor,
        mounted: mounted,
        value: widget.author,
    );

    setNotifier(
      notifier: _progressBarModel,
      mounted: mounted,
      value: ProgressBarModel.initialModel(
        numberOfStrips: 3,
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
          await loadAuthorEditorSession(
            mounted: mounted,
            context: context,
            oldAuthor: widget.author,
            bzModel: widget.bzModel,
            draftAuthor: _draftAuthor,
          );
        }
        // -----------------------------
        if (widget.validateOnStartup == true){
          _switchOnValidation();
          Formers.validateForm(_formKey);
        }
        // -----------------------------
        if (mounted == true){
          _addSessionListeners();
        }
        // -------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {

    _removeDraftAuthorListener();

    _loading.dispose();
    _canPickImage.dispose();

    _nameNode.dispose();
    _titleNode.dispose();
    _phoneNode.dispose();
    _emailNode.dispose();

    _draftAuthor.dispose();
    _pageController.dispose();
    _progressBarModel.dispose();

    // _fuckingNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _initializeDraft() async {

    final AuthorModel? _author = await prepareAuthorForEditing(
      mounted: mounted,
      context: context,
      draftAuthor: _draftAuthor,
      oldAuthor: widget.author,
      bzModel: widget.bzModel,
    );

     setNotifier(
        notifier: _draftAuthor,
        mounted: mounted,
        value: _author,
    );

     _originalDraft = _author;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _addSessionListeners(){
    /// REMOVED
    _draftAuthor.addListener(_draftAuthorListener);
  }
  // --------------------
  void _removeDraftAuthorListener(){
    _draftAuthor.removeListener(_draftAuthorListener);
  }
  // --------------------
  Future<void> _draftAuthorListener() async {
    _stripsListener();

    _switchOnValidation();

    await saveAuthorEditorSession(
      context: context,
      draftAuthor: _draftAuthor,
      bzModel: widget.bzModel,
      oldAuthor: _originalDraft,
      mounted: mounted,
    );
  }
  // -----------------------------------------------------------------------------

  /// STRIPS

  // --------------------
  /// TESTED : WORKS PERFECT
  void _stripsListener(){

    // -----------------
    /// STRIP 1 : PIC - NAME - TITLE

    final bool _picIsValid = Formers.picValidator(
      pic: _draftAuthor.value?.picModel,
      canValidate: true,
    ) == null;
    final bool _nameIsValid = Formers.personNameValidator(
        name: _draftAuthor.value?.name,
        canValidate: true
    ) == null;
    final bool _titleIsValid = Formers.jobTitleValidator(
        jobTitle: _draftAuthor.value?.title,
        canValidate: true
    ) == null;

    if (_picIsValid == false || _nameIsValid == false || _titleIsValid == false){
      setStripIsValid(0, false);
    }
    else {
      setStripIsValid(0, true);
    }

    // -----------------
    /// STRIP 5 : PHONE - EMAIL

    final bool _contactsAreValid = Formers.contactsAreValid(
        contacts: _draftAuthor.value?.contacts,
        zoneModel: widget.bzModel?.zone,
        phoneIsMandatory: Standards.authorPhoneIsMandatory,
        websiteIsMandatory: false,
    );

    if (_contactsAreValid == false){
      setStripIsValid(1, false);
    }
    else {
      setStripIsValid(1, true);
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
    return _hasError == false && _authorHasChange() == true;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _authorHasChange(){
     return !AuthorModel.checkAuthorsAreIdentical(
          author1: _originalDraft,
          author2: _draftAuthor.value,
      );
  }
  // -----------------------------------------------------------------------------

  /// SWIPING

  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom0To1({
    required AuthorModel? authorModel,
  }){
    return Formers.picValidator(pic: authorModel?.picModel, canValidate: true,) == null
           &&
           Formers.personNameValidator(name: authorModel?.name, canValidate: true) == null
           &&
           Formers.jobTitleValidator(jobTitle: authorModel?.title, canValidate: true,) == null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom1To2({
    required AuthorModel? authorModel,
  }){

    return Formers.contactsAreValid(
        contacts: authorModel?.contacts,
        zoneModel: widget.bzModel?.zone,
        phoneIsMandatory: Standards.authorPhoneIsMandatory,
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

    await Keyboard.closeKeyboard();

    _switchOnValidation();

    await onConfirmAuthorUpdates(
      draftAuthor: _draftAuthor,
      oldBz: widget.bzModel,
      oldAuthor: _originalDraft,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      canSwipeBack: false,
      key: const ValueKey<String>('AuthorEditorScreen'),
      loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      searchButtonIsOn: false,
      skyType: SkyType.grey,
      title: const Verse(
        id: 'phid_edit_author_details',
        translate: true,
      ),
      progressBarModel: _progressBarModel,
      onBack: () => Dialogs.goBackDialog(
        goBackOnConfirm: true,
        titleVerse: const Verse(id: 'phid_exit_this_editor_page?', translate: true),
        bodyVerse: const Verse(id: 'phid_draft_is_temp_stored', translate: true),
        confirmButtonVerse: const Verse(id: 'phid_exit', translate: true),
      ),
      appBarRowWidgets: [

        AppBarButton(
          icon: widget.bzModel?.logoPath,
          bigIcon: true,
          bubble: false,
        ),
      ],
      child: ValueListenableBuilder(
        valueListenable: _draftAuthor,
        builder: (_, AuthorModel? authorModel, Widget? child){

          return Form(
            key: _formKey,
            child: PagerBuilder(
              progressBarModel: _progressBarModel,
              pageController: _pageController,
              pageBubbles: <Widget>[

                /// 0. PIC - NAME - TITLE
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// PIC
                    AddImagePicBubble(
                      // width: BldrsAppBar.width(context),
                      picModel: authorModel?.picModel,
                      titleVerse: const Verse(
                        id: 'phid_author_picture',
                        translate: true,
                      ),
                      redDot: true,
                      bubbleType: BubbleType.authorPic,
                      onAddPicture: (PicMakerType imagePickerType) => takeAuthorImage(
                        author: _draftAuthor,
                        bzModel: widget.bzModel,
                        picMakerType: imagePickerType,
                        canPickImage: _canPickImage,
                        mounted: mounted,
                      ),
                      bulletPoints:const  <Verse>[
                        Verse(id: 'phid_author_pic_is_not_user_pic', translate: true),
                      ],
                      validator: () => Formers.picValidator(
                        pic: authorModel?.picModel,
                        canValidate: _canValidate,
                      ),
                    ),

                    /// NAME
                    BldrsTextFieldBubble(
                      key: const ValueKey<String>('name'),
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_author_name',
                          translate: true,
                        ),
                        redDot: true,
                      ),
                      formKey: _formKey,
                      focusNode: _nameNode,
                      appBarType: AppBarType.basic,
                      isFormField: true,
                      counterIsOn: true,
                      maxLength: 72,
                      keyboardTextInputType: TextInputType.name,
                      keyboardTextInputAction: TextInputAction.next,
                      bulletPoints: const <Verse>[
                        Verse(
                          id: 'phid_author_name_changing_note',
                          translate: true,
                        ),
                      ],
                      initialText: authorModel?.name,
                      onTextChanged: (String? text) => onAuthorNameChanged(
                        tempAuthor: _draftAuthor,
                        text: text,
                        mounted: mounted,
                      ),
                      autoCorrect: Keyboard.autoCorrectIsOn(),
                      enableSuggestions: Keyboard.suggestionsEnabled(),
                      // autoValidate: true,
                      validator: (String? text) => Formers.personNameValidator(
                          name: authorModel?.name,
                          canValidate: _canValidate
                      ),

                    ),

                    /// TITLE
                    BldrsTextFieldBubble(
                      formKey: _formKey,
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_job_title',
                          translate: true,
                        ),
                        redDot: true,
                      ),
                      focusNode: _titleNode,
                      appBarType: AppBarType.basic,
                      isFormField: true,
                      counterIsOn: true,
                      maxLength: 72,
                      keyboardTextInputType: TextInputType.name,
                      keyboardTextInputAction: TextInputAction.next,
                      onTextChanged: (String? text) => onAuthorTitleChanged(
                        text: text,
                        tempAuthor: _draftAuthor,
                        mounted: mounted,
                      ),
                      initialText: authorModel?.title,
                      bulletPoints: const [
                        Verse(id: 'phid_author_job_title_for_this_bz', translate: true),
                      ],
                      autoCorrect: Keyboard.autoCorrectIsOn(),
                      enableSuggestions: Keyboard.suggestionsEnabled(),
                      validator: (String? text) => Formers.jobTitleValidator(
                          jobTitle: authorModel?.title,
                          canValidate: _canValidate
                      ),
                    ),

                    /// SWIPING BUTTONS
                    EditorSwipingButtons(
                      onNext: _onNextTap,
                      canGoNext: _canGoFrom0To1(
                        authorModel: authorModel,
                      ),
                    ),

                    const Horizon(
                      heightFactor: 0,
                    ),

                  ],
                ),

                /// 1. PHONE - EMAIL - SOCIAL MEDIA
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// PHONE
                    ContactFieldEditorBubble(
                      key: const ValueKey<String>('phone'),
                      formKey: _formKey,
                      focusNode: _phoneNode,
                      hintVerse: Verse.plain(
                        '${Flag.getCountryPhoneCode(widget.bzModel?.zone?.countryID) ?? '00'} 000 00 ...'
                      ),
                      appBarType: AppBarType.non,
                      isFormField: true,
                      contactsArePublic: true,
                      headerViewModel: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_phone',
                          translate: true,
                        ),
                      ),
                      canPaste: false,
                      keyboardTextInputType: TextInputType.phone,
                      keyboardTextInputAction: TextInputAction.next,
                      bulletPoints: const <Verse>[
                        Verse(id: 'phid_optional_field', translate: true),
                      ],
                      initialTextValue: ContactModel.getInitialContactValue(
                        type: ContactType.phone,
                        countryID: widget.bzModel?.zone?.countryID,
                        existingContacts: authorModel?.contacts,
                      ),
                      textOnChanged: (String? text) => onAuthorContactChanged(
                        contactType: ContactType.phone,
                        value: text,
                        tempAuthor: _draftAuthor,
                        mounted: mounted,
                      ),
                      validator: (String? text) => Formers.phoneValidator(
                        phone: text,
                        zoneModel: widget.bzModel?.zone,
                        canValidate: true,
                        isMandatory: Standards.authorPhoneIsMandatory,
                      ),
                    ),

                    /// EMAIL
                    ContactFieldEditorBubble(
                      key: const ValueKey<String>('email'),
                      formKey: _formKey,
                      focusNode: _emailNode,
                      appBarType: AppBarType.basic,
                      isFormField: true,
                      contactsArePublic: true,
                      headerViewModel: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_emailAddress',
                          translate: true,
                        ),
                        redDot: true,
                      ),
                      keyboardTextInputType: TextInputType.emailAddress,
                      keyboardTextInputAction: TextInputAction.done,
                      initialTextValue: ContactModel.getInitialContactValue(
                        type: ContactType.email,
                        countryID: widget.bzModel?.zone?.countryID,
                        existingContacts: authorModel?.contacts,
                      ),
                      textOnChanged: (String? text) => onAuthorContactChanged(
                        contactType: ContactType.email,
                        value: text,
                        tempAuthor: _draftAuthor,
                        mounted: mounted,
                      ),
                      canPaste: false,
                      validator: (String? text) => Formers.emailValidator(
                          email: text,
                          canValidate: _canValidate
                      ),
                      hintVerse: Verse.plain('bldr@bldrs.net'),
                    ),

                    /// FACEBOOK - INSTAGRAM - TWITTER - LINKEDIN - YOUTUBE - TIKTOK - SNAPCHAT
                    SocialFieldEditorBubble(
                      contacts: authorModel?.contacts,
                      onContactChanged: (ContactModel contact) => onAuthorContactChanged(
                        contactType: contact.type!,
                        value: contact.value,
                        tempAuthor: _draftAuthor,
                        mounted: mounted,
                      ),
                    ),

                    /// SWIPING BUTTONS
                    EditorSwipingButtons(
                      onNext: _onNextTap,
                      canGoNext: _canGoFrom1To2(
                        authorModel: authorModel,
                      ),
                      onPrevious: _onPreviousTap,
                    ),

                    const Horizon(
                      heightFactor: 0,
                    ),

                  ],
                ),

                /// 2 - CONFIRM
                EditorConfirmPage(
                  verse:  const Verse(id: 'phid_updateProfile', translate: true),
                  onConfirmTap: _onConfirmTap,
                  canConfirm: _canConfirmEdits(),
                  modelHasChanged: _authorHasChange(),
                  onPreviousTap: _onPreviousTap,
                  previewWidget: Container(),
                  onSkipTap: () async {
                    await Nav.goBack(
                      context: getMainContext(),
                      invoker: 'onSkipAuthorEdits',
                    );
                    },
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
