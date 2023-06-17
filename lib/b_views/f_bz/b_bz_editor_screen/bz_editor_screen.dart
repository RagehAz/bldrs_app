// ignore_for_file: avoid_positional_boolean_parameters
import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/draft/draft_bz.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/staging_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/bz_editor_controller.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/z_components/scope_selector_bubble.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/contact_field_editor_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pic_bubble/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/buttons/next_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/pages_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mediators/mediators.dart';
import 'package:night_sky/night_sky.dart';

class BzEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzEditorScreen({
    this.bzModel,
    this.checkLastSession = true,
    this.validateOnStartup = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final bool checkLastSession;
  final bool validateOnStartup;
  /// --------------------------------------------------------------------------
  @override
  _BzEditorScreenState createState() => _BzEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _BzEditorScreenState extends State<BzEditorScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
  final PageController _pageController = PageController();
  ConfirmButtonModel _confirmButtonModel;
  // --------------------
  final ValueNotifier<DraftBz> draftNotifier = ValueNotifier(null);
  final ScrollController scrollController = ScrollController();
  // -----------------------------------------------------------------------------
  /// LOADING
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
        numberOfStrips: 5,
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
        /// PREPARE (PIC - ZONE - CONTACTS)
        setNotifier(
          notifier: draftNotifier,
          mounted: mounted,
          value: await DraftBz.createDraftBz(
            oldBz: widget.bzModel,
          ),
        );
        // -----------------------------
        if (widget.checkLastSession == true) {
          await loadBzEditorLastSession(
            context: context,
            draftNotifier: draftNotifier,
            mounted: mounted,
          );
          triggerCanValidateDraftBz(
            draftNotifier: draftNotifier,
            setTo: true,
            mounted: mounted,
          );
        }
        // -----------------------------
        if (widget.validateOnStartup == true){
          triggerCanValidateDraftBz(
            draftNotifier: draftNotifier,
            setTo: true,
            mounted: mounted,
          );
          Formers.validateForm(draftNotifier.value.formKey);
        }
        // -----------------------------
        if (mounted == true){
          _addSessionListeners();
        }
        // -------------------------------

        draftNotifier.value.nameController.addListener(() {

          blog('the fucking name is : ${draftNotifier.value.nameController.text}');

        });

        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {
    draftNotifier.value.disposeDraftBzFocusNodes();
    draftNotifier.value.nameController.dispose();
    draftNotifier.value.aboutController.dispose();
    draftNotifier.dispose();
    _loading.dispose();
    _progressBarModel.dispose();
    _pageController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _addSessionListeners(){

    blog('adding session listeners');

    draftNotifier.addListener(() async {
      await _onDraftChanged();
    });

  }
  // --------------------
  ///
  Future<void> _onDraftChanged() async {
    _stripsListener();
    await saveBzEditorSession(
      draftNotifier: draftNotifier,
      mounted: mounted,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onConfirmTap() async {

    await onConfirmBzEdits(
      context: context,
      draftNotifier: draftNotifier,
      oldBz: widget.bzModel,
      mounted: mounted,
    );

  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _stripsListener(){

    // -----------------
    /// STRIP 1 : LOGO - NAME

    final bool _logoIsValid = Formers.picValidator(
      pic: draftNotifier.value?.logoPicModel,
      canValidate: true,
    ) == null;
    final bool _nameIsValid = Formers.companyNameValidator(
      companyName: draftNotifier.value?.nameController?.text,
      canValidate: true,
    ) == null;

    if (_logoIsValid == false || _nameIsValid == false){
      setStripIsValid(0, false);
    }
    else {
      setStripIsValid(0, true);
    }


    // -----------------
    /// STRIP 2 : SECTION - TYPE - FORM

    final bool _sectionIsValid = Formers.bzSectionValidator(
      selectedSection: draftNotifier.value?.bzSection,
      canValidate: true,
    ) == null;
    final bool _typeIsValid = Formers.bzTypeValidator(
      selectedTypes: draftNotifier.value?.bzTypes,
      canValidate: true,
    ) == null;
    final bool _formIsValid = Formers.bzFormValidator(
      bzForm: draftNotifier.value?.bzForm,
      canValidate: true,
    ) == null;

    if (_sectionIsValid == false || _typeIsValid == false || _formIsValid == false){
      setStripIsValid(1, false);
    }
    else {
      setStripIsValid(1, true);
    }

    // -----------------
    /// STRIP 3 : ABOUT - SCOPE
    final bool _aboutIsValid = Formers.bzAboutValidator(
      bzAbout: draftNotifier.value?.aboutController?.text,
      canValidate: true,
    ) == null;
    final bool _scopeIsValid = Formers.bzScopeValidator(
      scope: draftNotifier.value?.scope,
      canValidate: true,
    ) == null;

    if (_aboutIsValid == false || _scopeIsValid == false){
      setStripIsValid(2, false);
    }
    else {
      setStripIsValid(2, true);
    }

    // -----------------
    /// STRIP 4 : ZONE

    final bool _zoneIsValid = Formers.zoneValidator(
      zoneModel: draftNotifier.value?.zone,
      selectCountryIDOnly: false,
      canValidate: true,
    ) == null;

    if (_zoneIsValid == false){
      setStripIsValid(3, false);
    }
    else {
      setStripIsValid(3, true);
    }

    // -----------------
    /// STRIP 5 : PHONE - EMAIL - WEBSITE

    final bool _phoneIsValid = Formers.contactsPhoneValidator(
      contacts: draftNotifier.value?.contacts,
      zoneModel: draftNotifier.value?.zone,
      canValidate: true,
      isRequired: false,
    ) == null;
    final bool _emailIsValid = Formers.contactsEmailValidator(
      contacts: draftNotifier.value?.contacts,
      canValidate: true,
    ) == null;
    final bool _websiteIsValid = Formers.contactsWebsiteValidator(
      contacts: draftNotifier.value?.contacts,
      canValidate: true,
    ) == null;

    if (_phoneIsValid == false || _emailIsValid == false || _websiteIsValid == false){
      setStripIsValid(4, false);
    }
    else {
      setStripIsValid(4, true);
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

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<String> _allSectionsPhids = BzTyper.getBzSectionsPhids(
      context: context,
      bzSections: BzTyper.bzSectionsList,
    );

    final List<String> _allBzTypesButtons = BzTyper.getBzTypesPhids(
      context: context,
      bzTypes: BzTyper.bzTypesList,
      pluralTranslation: false,
    );

    final List<String> _allBzzFormsButtons = BzTyper.getBzFormsPhids(
      context: context,
      bzForms: BzTyper.bzFormsList,
    );
    // --------------------
    return MainLayout(
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      title: Verse(
        id: widget.bzModel == null ? 'phid_createBzAccount' : 'phid_edit_bz_info',
        translate: true,
      ),
      skyType: SkyType.black,
      loading: _loading,
      progressBarModel: _progressBarModel,
      onBack: () => Dialogs.goBackDialog(
        goBackOnConfirm: true,
      ),
      confirmButtonModel: _confirmButtonModel,
      // appBarRowWidgets: [
      //
      //   AppBarButton(
      //     verse: Verse.plain('blog'),
      //     onTap: (){
      //
      //       draftNotifier.value.blogDraft();
      //
      //     },
      //   ),
      //
      // ],
      child: ValueListenableBuilder(
        valueListenable: draftNotifier,
        builder: (_, DraftBz draft, Widget child){

            final String _companyNameBubbleTitle = draft?.bzForm == BzForm.individual ?
            'phid_business_entity_name'
                :
            'phid_companyName';

            final String _selectedBzSectionPhid = BzTyper.getBzSectionPhid(
              context: context,
              bzSection: draft?.bzSection,
            );

            final List<String> _inactiveBzTypesPhids = BzTyper.getBzTypesPhids(
              context: context,
              bzTypes: draft?.inactiveBzTypes,
              pluralTranslation: false,
            );

            final List<String> _selectedBzTypesPhids = BzTyper.getBzTypesPhids(
              context: context,
              bzTypes: draft?.bzTypes,
              pluralTranslation: false,
            );

            final String _selectedBzFormPhid = BzTyper.getBzFormPhid(draft?.bzForm);

            final List<String> _inactiveBzFormsPhids = BzTyper.getBzFormsPhids(
              context: context,
              bzForms: draft?.inactiveBzForms,
            );

            // blog('draft?.logoPicModel : ${draft?.logoPicModel?.bytes}');
            // blog('canValidate : ${draft?.canValidate}');

          return Form(
            key: draft?.formKey,
            child: PagerBuilder(
              progressBarModel: _progressBarModel,
              pageController: _pageController,
              pageBubbles: <Widget>[

                /// LOGO - NAME
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// ADD LOGO
                    AddImagePicBubble(
                      key: const ValueKey<String>('add_logo_bubble'),
                      picModel: draft?.logoPicModel,
                      titleVerse: const Verse(
                        id: 'phid_businessLogo',
                        translate: true,
                      ),
                      redDot: true,
                      bubbleType: BubbleType.bzLogo,
                      // autoValidate: true,
                      validator: () => Formers.picValidator(
                        pic: draft?.logoPicModel,
                        canValidate: draft?.canValidate,
                      ),
                      onAddPicture: (PicMakerType imagePickerType) => onChangeBzLogo(
                        draftNotifier: draftNotifier,
                        imagePickerType: imagePickerType,
                        mounted: mounted,
                      ),
                    ),

                    /// BZ NAME
                    BldrsTextFieldBubble(
                      formKey: draft?.formKey,
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: Verse(
                          id: _companyNameBubbleTitle,
                          translate: true,
                        ),
                        redDot: true,
                      ),
                      focusNode: draft?.nameNode,
                      appBarType: AppBarType.basic,
                      isFormField: true,
                      key: const ValueKey('bzName'),
                      counterIsOn: true,
                      maxLength: 72,
                      maxLines: 2,
                      // keyboardTextInputType: TextInputType.text,
                      keyboardTextInputAction: TextInputAction.next,
                      textController: draftNotifier.value?.nameController,

                      // autoValidate: true,
                      validator: (String text) => Formers.companyNameValidator(
                        companyName: text,
                        canValidate: draft?.canValidate,
                      ),
                      onTextChanged: (String text) async {
                        blog('the text is $text');
                        await _onDraftChanged();
                      },
                    ),

                    /// NEXT
                    NextButton(
                      onTap: _onNextTap,
                      canGoNext: Formers.picValidator(
                                pic: draft?.logoPicModel,
                                canValidate: true,
                              ) == null
                          &&
                          Formers.companyNameValidator(
                                companyName: draft?.nameController?.text,
                                canValidate: true,
                              ) == null &&
                          _isInit == false,
                    ),

                    const Horizon(
                      heightFactor: 0,
                    ),

                  ],
                ),

                /// SECTIONS - BZ TYPE - FORM
                BldrsFloatingList(
                  columnChildren: <Widget>[
                    
                    /// SECTION
                    MultipleChoiceBubble(
                      titleVerse: const Verse(
                        id: 'phid_sections',
                        translate: true,
                      ),
                      buttonsVerses:
                          Verse.createVerses(strings: _allSectionsPhids, translate: true),
                      selectedButtonsPhids: <String>[_selectedBzSectionPhid],
                      bulletPoints: const <Verse>[
                        Verse(
                          id: 'phid_select_only_one_section',
                          translate: true,
                        ),
                        // Verse(text: 'phid_bz_section_selection_info', translate: true,),
                      ],
                      validator: () => Formers.bzSectionValidator(
                        selectedSection: draft?.bzSection,
                        canValidate: draft?.canValidate,
                      ),
                      onButtonTap: (int index) => onChangeBzSection(
                        context: context,
                        index: index,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                      // focusNode: ,
                    ),

                    /// BZ TYPE
                    MultipleChoiceBubble(
                      titleVerse: const Verse(
                        id: 'phid_bz_entity_type',
                        translate: true,
                      ),
                      buttonsVerses:
                          Verse.createVerses(strings: _allBzTypesButtons, translate: true),
                      selectedButtonsPhids: _selectedBzTypesPhids,
                      inactiveButtons:
                          Verse.createVerses(strings: _inactiveBzTypesPhids, translate: true),
                      bulletPoints: const <Verse>[
                        Verse(
                          id: 'phid_select_bz_type',
                          translate: true,
                        ),
                      ],
                      validator: () => Formers.bzTypeValidator(
                        selectedTypes: draft?.bzTypes,
                        canValidate: draft?.canValidate,
                      ),
                      onButtonTap: (int index) => onChangeBzType(
                        context: context,
                        index: index,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                    ),

                    /// BZ FORM
                    MultipleChoiceBubble(
                      titleVerse: const Verse(
                        id: 'phid_businessForm',
                        translate: true,
                      ),
                      // description: superPhrase(context, 'phid_businessForm_description'),
                      buttonsVerses:
                          Verse.createVerses(strings: _allBzzFormsButtons, translate: true),
                      selectedButtonsPhids: <String>[_selectedBzFormPhid],
                      inactiveButtons:
                          Verse.createVerses(strings: _inactiveBzFormsPhids, translate: true),
                      bulletPoints: const <Verse>[
                        Verse(
                          id: 'phid_bz_form_pro_description',
                          translate: true,
                        ),
                        Verse(
                          id: 'phid_bz_form_company_description',
                          translate: true,
                        ),
                      ],
                      validator: () => Formers.bzFormValidator(
                        bzForm: draft?.bzForm,
                        canValidate: draft?.canValidate,
                      ),
                      onButtonTap: (int index) => onChangeBzForm(
                        index: index,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                    ),

                    /// NEXT
                    NextButton(
                      onTap: _onNextTap,
                      canGoNext: Formers.bzSectionValidator(
                                selectedSection: draft?.bzSection,
                                canValidate: true,
                              ) == null
                          &&
                          Formers.bzTypeValidator(
                                selectedTypes: draft?.bzTypes,
                                canValidate: true,
                              ) == null
                          &&
                          Formers.bzFormValidator(
                                bzForm: draft?.bzForm,
                                canValidate: true,
                              ) == null,
                    ),
                  ],
                ),

                /// ABOUT - SCOPE
                BldrsFloatingList(
                  columnChildren: <Widget>[

                    /// BZ ABOUT
                    BldrsTextFieldBubble(
                      formKey: draft?.formKey,
                      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_about',
                          translate: true,
                        ),
                      ),
                      focusNode: draft?.aboutNode,
                      appBarType: AppBarType.basic,
                      key: const ValueKey<String>('bz_about_bubble'),
                      counterIsOn: true,
                      maxLength: 1000,
                      maxLines: 20,
                      keyboardTextInputType: TextInputType.multiline,
                      textController: draft?.aboutController,

                      // autoValidate: true,
                      validator: (String text) => Formers.bzAboutValidator(
                        bzAbout: text,
                        canValidate: draft?.canValidate,
                      ),
                      onTextChanged: (String text) async {
                        await _onDraftChanged();
                      },
                    ),

                    /// SCOPES SELECTOR
                    ScopeSelectorBubble(
                      headlineVerse: const Verse(
                        id: 'phid_scopeOfServices',
                        translate: true,
                      ),
                      flyerTypes: FlyerTyper.concludePossibleFlyerTypesByBzTypes(bzTypes: draft?.bzTypes),
                      selectedSpecs: SpecModel.generateSpecsByPhids(
                        phids: draft?.scope,
                      ),
                      bulletPoints: const <Verse>[
                        Verse(
                          id: 'phid_select_atleast_one_scope_phid',
                          translate: true,
                        )
                      ],
                      onFlyerTypeBubbleTap: (FlyerType flyerType) => onChangeBzScope(
                        context: context,
                        draftNotifier: draftNotifier,
                        flyerType: flyerType,
                        mounted: mounted,
                      ),
                      validator: () => Formers.bzScopeValidator(
                        scope: draft?.scope,
                        canValidate: draft?.canValidate,
                      ),
                    ),

                    /// NEXT
                    NextButton(
                      onTap: _onNextTap,
                      canGoNext: Formers.bzAboutValidator(
                                bzAbout: draft?.aboutController?.text,
                                canValidate: true,
                              ) ==
                              null &&
                          Formers.bzScopeValidator(
                                scope: draft?.scope,
                                canValidate: true,
                              ) ==
                              null,
                    ),

                  ],
                ),

                /// ZONE
                BldrsFloatingList(
                  columnChildren: <Widget>[
                    /// BZ ZONE
                    ZoneSelectionBubble(
                        zoneViewingEvent: ViewingEvent.bzEditor,
                        titleVerse: const Verse(
                          id: 'phid_hqCity',
                          translate: true,
                        ),
                        currentZone: draft?.zone,
                        depth: ZoneDepth.city,
                        validator: () => Formers.zoneValidator(
                              zoneModel: draft?.zone,
                              selectCountryIDOnly: false,
                              canValidate: draft?.canValidate,
                            ),
                        viewerCountryID: draft?.zone?.countryID,
                        onZoneChanged: (ZoneModel zone) {
                          setNotifier(
                            notifier: draftNotifier,
                            mounted: mounted,
                            value: draft?.copyWith(
                              zone: zone,
                            ),
                          );
                        }),

                    /// NEXT
                    NextButton(
                      onTap: _onNextTap,
                      canGoNext: Formers.zoneValidator(
                            zoneModel: draft?.zone,
                            selectCountryIDOnly: false,
                            canValidate: true,
                          ) ==
                          null,
                    ),
                  ],
                ),

                /// PHONE - EMAIL - WEBSITE
                BldrsFloatingList(
                  columnChildren: <Widget>[
                    /// PHONE
                    ContactFieldEditorBubble(
                      key: const ValueKey<String>('phone'),
                      formKey: draft?.formKey,
                      focusNode: draft?.phoneNode,
                      appBarType: AppBarType.basic,
                      isFormField: true,
                      headerViewModel: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_phone',
                          translate: true,
                        ),
                      ),
                      keyboardTextInputType: TextInputType.phone,
                      keyboardTextInputAction: TextInputAction.next,
                      initialTextValue: ContactModel.getInitialContactValue(
                        type: ContactType.phone,
                        countryID: draft?.zone?.countryID,
                        existingContacts: draft?.contacts,
                      ),
                      canPaste: false,
                      // autoValidate: true,
                      validator: (String text) => Formers.contactsPhoneValidator(
                        contacts: draft?.contacts,
                        zoneModel: draft?.zone,
                        canValidate: draft?.canValidate,
                        isRequired: false,
                      ),
                      textOnChanged: (String text) => onChangeBzContact(
                        contactType: ContactType.phone,
                        value: text,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                    ),

                    /// EMAIL
                    ContactFieldEditorBubble(
                      key: const ValueKey<String>('email'),
                      formKey: draft?.formKey,
                      focusNode: draft?.emailNode,
                      appBarType: AppBarType.basic,
                      isFormField: true,
                      headerViewModel: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_emailAddress',
                          translate: true,
                        ),
                        redDot: true,
                      ),
                      keyboardTextInputType: TextInputType.emailAddress,
                      keyboardTextInputAction: TextInputAction.next,
                      initialTextValue: ContactModel.getInitialContactValue(
                        type: ContactType.email,
                        countryID: draft?.zone?.countryID,
                        existingContacts: draft?.contacts,
                      ),

                      canPaste: false,
                      // autoValidate: true,
                      validator: (String text) => Formers.contactsEmailValidator(
                        contacts: draft?.contacts,
                        canValidate: draft?.canValidate,
                      ),
                      textOnChanged: (String text) => onChangeBzContact(
                        contactType: ContactType.email,
                        value: text,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                    ),

                    /// WEBSITE
                    ContactFieldEditorBubble(
                      key: const ValueKey<String>('website'),
                      headerViewModel: BldrsBubbleHeaderVM.bake(
                        context: context,
                        headlineVerse: const Verse(
                          id: 'phid_website',
                          translate: true,
                        ),
                      ),
                      formKey: draft?.formKey,
                      focusNode: draft?.websiteNode,
                      appBarType: AppBarType.basic,
                      isFormField: true,
                      // keyboardTextInputType: TextInputType.url,
                      keyboardTextInputAction: TextInputAction.done,
                      initialTextValue: ContactModel.getInitialContactValue(
                        type: ContactType.website,
                        countryID: draft?.zone?.countryID,
                        existingContacts: draft?.contacts,
                      ),
                      // canPaste: true,
                      // autoValidate: true,
                      validator: (String text) => Formers.contactsWebsiteValidator(
                        contacts: draft?.contacts,
                        canValidate: draft?.canValidate,
                      ),
                      textOnChanged: (String text) => onChangeBzContact(
                        contactType: ContactType.website,
                        value: text,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                    ),

                    // NO NEED FOR NEXT BUTTON HERE

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
