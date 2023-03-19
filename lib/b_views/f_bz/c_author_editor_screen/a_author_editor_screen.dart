// ignore_for_file: avoid_positional_boolean_parameters
import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/f_bz/c_author_editor_screen/x_author_editor_screen_controller.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/contact_field_editor_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pic_bubble/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/buttons/next_button.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/pages_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:night_sky/night_sky.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';

class AuthorEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const AuthorEditorScreen({
    @required this.author,
    @required this.bzModel,
    this.checkLastSession = true,
    this.validateOnStartup = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AuthorModel author;
  final BzModel bzModel;
  final bool checkLastSession;
  final bool validateOnStartup;
  /// --------------------------------------------------------------------------
  @override
  _AuthorEditorScreenState createState() => _AuthorEditorScreenState();
/// --------------------------------------------------------------------------
}

class _AuthorEditorScreenState extends State<AuthorEditorScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  final PageController _pageController = PageController();
  ConfirmButtonModel _confirmButtonModel;
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
  final ValueNotifier<AuthorModel> _draftAuthor = ValueNotifier(null);
  // --------------------
  final ScrollController _scrollController = ScrollController();
  // --------------------
  final FocusNode _nameNode = FocusNode();
  final FocusNode _titleNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
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
        notifier: _draftAuthor,
        mounted: mounted,
        value: widget.author,
    );

    setNotifier(
      notifier: _progressBarModel,
      mounted: mounted,
      value: ProgressBarModel.initialModel(
        numberOfStrips: 2,
      ),
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        await prepareAuthorPicForEditing(
          mounted: mounted,
          context: context,
          draftAuthor: _draftAuthor,
          oldAuthor: widget.author,
          bzModel: widget.bzModel,
        );
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

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
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
  /// TESTED : WORKS PERFECT
  void _addSessionListeners(){

    _draftAuthor.addListener(() async {

      _stripsListener();

      _switchOnValidation();

      await saveAuthorEditorSession(
        context: context,
        draftAuthor: _draftAuthor,
        bzModel: widget.bzModel,
        oldAuthor: widget.author,
        mounted: mounted,
      );

    });

  }
  // --------------------
  Future<void> _onConfirmTap() async {

    Keyboard.closeKeyboard(context);

    await Future.delayed(const Duration(milliseconds: 100), () async {

      _switchOnValidation();

      await onConfirmAuthorUpdates(
        context: context,
        draftAuthor: _draftAuthor,
        oldBz: widget.bzModel,
        oldAuthor: widget.author,
      );

    });

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _stripsListener(){

    // -----------------
    /// STRIP 1 : PIC - NAME - TITLE

    final bool _picIsValid = Formers.picValidator(
      context: context,
      pic: _draftAuthor.value?.picModel,
      canValidate: true,
    ) == null;
    final bool _nameIsValid = Formers.personNameValidator(
        context: context,
        name: _draftAuthor.value?.name,
        canValidate: true
    ) == null;
    final bool _titleIsValid = Formers.jobTitleValidator(
        context: context,
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

    final bool _phoneIsValid = Formers.contactsPhoneValidator(
      contacts: _draftAuthor.value.contacts,
      zoneModel: widget.bzModel.zone,
      canValidate: true,
      context: context,
      isRequired: false,

    ) == null;
    final bool _emailIsValid = Formers.contactsEmailValidator(
      context: context,
      contacts: _draftAuthor.value?.contacts,
      canValidate: true,
    ) == null;

    if (_phoneIsValid == false || _emailIsValid == false){
      setStripIsValid(1, false);
    }
    else {
      setStripIsValid(1, true);
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
          firstLine: const Verse(id: 'phid_updateProfile', translate: true),
          onTap: _onConfirmTap,
          isWide: true,
        );
      });
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onNextTap() async {

    await NextButton.onNextTap(
      context: context,
      mounted: mounted,
      pageController: _pageController,
      progressBarModel: _progressBarModel,
    );

    _controlConfirmButton();

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      key: const ValueKey<String>('AuthorEditorScreen'),
      loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      historyButtonIsOn: false,
      skyType: SkyType.black,
      title: const Verse(
        id: 'phid_edit_author_details',
        translate: true,
      ),
      confirmButtonModel: _confirmButtonModel,
      progressBarModel: _progressBarModel,
      child: ValueListenableBuilder(
        valueListenable: _draftAuthor,
        builder: (_, AuthorModel authorModel, Widget child){

          return Form(
            key: _formKey,
            child: PagerBuilder(
              progressBarModel: _progressBarModel,
              pageController: _pageController,
              pageBubbles: <Widget>[

                /// PIC - NAME - TITLE
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// PIC
                    Center(
                      child: AddImagePicBubble(
                        // width: BldrsAppBar.width(context),
                        picModel: authorModel.picModel,
                        titleVerse: const Verse(
                          id: 'phid_author_picture',
                          translate: true,
                        ),
                        redDot: true,
                        bubbleType: BubbleType.authorPic,
                        onAddPicture: (PicMakerType imagePickerType) => takeAuthorImage(
                          context: context,
                          author: _draftAuthor,
                          bzModel: widget.bzModel,
                          imagePickerType: imagePickerType,
                          canPickImage: _canPickImage,
                          mounted: mounted,
                        ),
                        validator: () => Formers.picValidator(
                          context: context,
                          pic: authorModel?.picModel,
                          canValidate: _canValidate,
                        ),
                      ),
                    ),

                    /// NAME
                    BldrsTextFieldBubble(
                      key: const ValueKey<String>('name'),
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
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
                      initialText: authorModel.name,
                      onTextChanged: (String text) => onAuthorNameChanged(
                        tempAuthor: _draftAuthor,
                        text: text,
                        mounted: mounted,
                      ),
                      // autoValidate: true,
                      validator: (String text) => Formers.personNameValidator(
                          context: context,
                          name: authorModel.name,
                          canValidate: _canValidate
                      ),

                    ),

                    /// TITLE
                    BldrsTextFieldBubble(
                      formKey: _formKey,
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
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
                      onTextChanged: (String text) => onAuthorTitleChanged(
                        text: text,
                        tempAuthor: _draftAuthor,
                        mounted: mounted,
                      ),
                      initialText: authorModel.title,
                      validator: (String text) => Formers.jobTitleValidator(
                          context: context,
                          jobTitle: authorModel.title,
                          canValidate: _canValidate
                      ),
                    ),

                    /// NEXT
                    NextButton(
                      onTap: _onNextTap,
                      canGoNext: Formers.picValidator(
                          context: context,
                          pic: authorModel?.picModel,
                          canValidate: true,
                        ) == null &&
                      Formers.personNameValidator(
                          context: context,
                          name: authorModel.name,
                          canValidate: true
                      ) == null &&
                      Formers.jobTitleValidator(
                          context: context,
                          jobTitle: authorModel.title,
                          canValidate: true,
                      ) == null,
                    ),

                    const Horizon(
                      heightFactor: 0,
                    ),

                  ],
                ),

                /// PHONE - EMAIL
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// PHONE
                    ContactFieldEditorBubble(
                      key: const ValueKey<String>('phone'),
                      formKey: _formKey,
                      focusNode: _phoneNode,
                      appBarType: AppBarType.basic,
                      isFormField: true,
                      headerViewModel: BldrsBubbleHeaderVM.bake(
                        headlineVerse: const Verse(
                          id: 'phid_phone',
                          translate: true,
                        ),
                      ),
                      canPaste: false,
                      keyboardTextInputType: TextInputType.phone,
                      keyboardTextInputAction: TextInputAction.next,
                      initialTextValue: ContactModel.getInitialContactValue(
                        type: ContactType.phone,
                        countryID: widget.bzModel.zone.countryID,
                        existingContacts: authorModel.contacts,
                      ),
                      textOnChanged: (String text) => onAuthorContactChanged(
                        contactType: ContactType.phone,
                        value: text,
                        tempAuthor: _draftAuthor,
                        mounted: mounted,
                      ),
                      validator: (String text) => Formers.contactsPhoneValidator(
                        contacts: authorModel.contacts,
                        zoneModel: widget.bzModel.zone,
                        canValidate: _canValidate,
                        context: context,
                        isRequired: false,

                      ),
                    ),

                    /// EMAIL
                    ContactFieldEditorBubble(
                      key: const ValueKey<String>('email'),
                      formKey: _formKey,
                      focusNode: _emailNode,
                      appBarType: AppBarType.basic,
                      isFormField: true,
                      headerViewModel: BldrsBubbleHeaderVM.bake(
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
                        countryID: widget.bzModel.zone.countryID,
                        existingContacts: authorModel.contacts,
                      ),
                      textOnChanged: (String text) => onAuthorContactChanged(
                        contactType: ContactType.email,
                        value: text,
                        tempAuthor: _draftAuthor,
                        mounted: mounted,
                      ),
                      canPaste: false,
                      validator: (String text) => Formers.contactsEmailValidator(
                          context: context,
                          contacts: authorModel.contacts,
                          canValidate: _canValidate
                      ),
                    ),

                    const Horizon(
                      heightFactor: 0,
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
