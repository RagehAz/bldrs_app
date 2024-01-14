// ignore_for_file: avoid_positional_boolean_parameters
import 'dart:async';

import 'package:basics/bldrs_theme/night_sky/night_sky.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/draft/draft_bz.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/bz_editor_controller.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/bubbles/b_variants/contacts_bubble/contact_field_editor_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/contacts_bubble/social_field_editor_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/phids_bubble/multiple_choice_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/pic_bubble/add_gallery_pic_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
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
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

class BzEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzEditorScreen({
    this.bzModel,
    this.checkLastSession = true,
    this.validateOnStartup = false,
    super.key
  });
  /// --------------------------------------------------------------------------
  final BzModel? bzModel;
  final bool checkLastSession;
  final bool validateOnStartup;
  /// --------------------------------------------------------------------------
  @override
  _BzEditorScreenState createState() => _BzEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _BzEditorScreenState extends State<BzEditorScreen> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel?> _progressBarModel = ValueNotifier(null);
  final PageController _pageController = PageController();
  // --------------------
  final ValueNotifier<DraftBz?> draftNotifier = ValueNotifier(null);
  DraftBz? _originalDraft;
  final ScrollController scrollController = ScrollController();
  // -----------------------------------------------------------------------------
  /// LOADING
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

    setNotifier(
      notifier: _progressBarModel,
      mounted: mounted,
      value: ProgressBarModel.initialModel(
        numberOfStrips: 6,
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
        /// INITIALIZE DRAFT
        await _initializeDraft();
        // -----------------------------
        /// LOAD LAST SESSION
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
        /// VALIDATION SWITCH
        if (widget.validateOnStartup == true){
          triggerCanValidateDraftBz(
            draftNotifier: draftNotifier,
            setTo: true,
            mounted: mounted,
          );
          Formers.validateForm(draftNotifier.value?.formKey);
        }
        // -----------------------------
        /// ADD SESSION LISTENERS
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
    _removeSessionListeners();
    draftNotifier.value?.disposeDraftBzFocusNodes();
    draftNotifier.value?.nameController?.dispose();
    draftNotifier.value?.aboutController?.dispose();
    draftNotifier.dispose();
    _loading.dispose();
    _progressBarModel.dispose();
    _pageController.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------

  /// INITIALIZATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _initializeDraft() async {

    final DraftBz _newDraft = await DraftBz.createDraftBz(
      oldBz: widget.bzModel,
    );
        setNotifier(
          notifier: draftNotifier,
          mounted: mounted,
          value: _newDraft,
        );
        _originalDraft = _newDraft;


    final BzModel? _bz = await BzFireOps.readBz(bzID: widget.bzModel?.id);
    _originalDraft = await DraftBz.createDraftBz(
      oldBz: _bz,
    );

  }
  // -----------------------------------------------------------------------------

  /// LISTENERS

  // --------------------
  /// TESTED : WORKS PERFECT
  void _addSessionListeners(){
    /// REMOVED
    draftNotifier.addListener(_draftListener);
    /// REMOVED
    draftNotifier.value?.nameController?.addListener(_nameControllerListener);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _removeSessionListeners(){
    draftNotifier.removeListener(_draftListener);
    draftNotifier.value?.nameController?.removeListener(_nameControllerListener);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _nameControllerListener() async {
    setState(() {});
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _draftListener() async {
    unawaited(_onDraftChanged());
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> _onDraftChanged() async {
    _stripsListener();
    await saveBzEditorSession(
      draftNotifier: draftNotifier,
      mounted: mounted,
    );
  }
  // -----------------------------------------------------------------------------

  /// STRIPS

  // --------------------
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
    // final bool _scopeIsValid = Formers.bzScopeValidator(
    //   scope: draftNotifier.value?.scope,
    //   canValidate: true,
    // ) == null;

    if (_aboutIsValid == false){ // || _scopeIsValid == false){
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

    final bool _contactsAreValid = Formers.contactsAreValid(
        contacts: draftNotifier.value?.contacts,
        zoneModel: draftNotifier.value?.zone,
        phoneIsMandatory: Standards.bzPhoneIsMandatory,
        websiteIsMandatory: Standards.bzWebsiteIsMandatory,
    );

    if (_contactsAreValid == false){
      setStripIsValid(4, false);
    }
    else {
      setStripIsValid(4, true);
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
    return _hasError == false && _bzHasChanged() == true;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _bzHasChanged(){
    return !DraftBz.checkDraftsAreIdentical(
      draft1: _originalDraft,
      draft2: draftNotifier.value,
      blogDiffs: true,
    );
  }
  // -----------------------------------------------------------------------------

  /// SWIPING

  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom0to1({
    required DraftBz? draft,
  }){
    final bool _can = Formers.picValidator(pic: draft?.logoPicModel, canValidate: true,) == null
           &&
           Formers.companyNameValidator(companyName: draft?.nameController?.text, canValidate: true,) == null
           &&
           _isInit == false;

    blog('can : $_can');

    return _can;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom1To2({
    required DraftBz? draft,
  }){
    return Formers.bzSectionValidator(selectedSection: draft?.bzSection, canValidate: true,) == null
           &&
           Formers.bzTypeValidator(selectedTypes: draft?.bzTypes, canValidate: true,) == null
           &&
           Formers.bzFormValidator(bzForm: draft?.bzForm, canValidate: true,) == null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom2to3({
    required DraftBz? draft,
  }){

    return Formers.bzAboutValidator(bzAbout: draft?.aboutController?.text, canValidate: true,) == null;
          // &&
          // Formers.bzScopeValidator(
          //   scope: draft?.scope,
          //   canValidate: true,
          // ) == null

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom3To4({
    required DraftBz? draft,
  }){
    return Formers.zoneValidator(
      zoneModel: draft?.zone,
      selectCountryIDOnly: false,
      canValidate: true,
    ) == null;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  bool _canGoFrom4To5({
    required DraftBz? draft,
  }){

    return Formers.contactsAreValid(
      contacts: draft?.contacts,
      zoneModel: draft?.zone,
      phoneIsMandatory: Standards.bzPhoneIsMandatory,
      websiteIsMandatory: Standards.bzWebsiteIsMandatory,
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

    await onConfirmBzEdits(
      draftNotifier: draftNotifier,
      oldBz: widget.bzModel,
      mounted: mounted,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  Verse _createConfirmVerse(){

    if (widget.bzModel == null){
      return const Verse(id: 'phid_createBzAccount', translate: true);
    }

    else {
      return const Verse(id: 'phid_edit_bz_info', translate: true);
    }

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
      bzForms: BzTyper.bzFormsList,
    );
    // --------------------
    return MainLayout(
      canSwipeBack: false,
      pyramidsAreOn: true,
      appBarType: AppBarType.basic,
      title: _createConfirmVerse(),
      skyType: SkyType.grey,
      loading: _loading,
      progressBarModel: _progressBarModel,
      onBack: () => Dialogs.goBackDialog(
        goBackOnConfirm: true,
        titleVerse: const Verse(id: 'phid_exit_this_editor_page?', translate: true),
        bodyVerse: const Verse(id: 'phid_draft_is_temp_stored', translate: true),
        confirmButtonVerse: const Verse(id: 'phid_exit', translate: true),
      ),
      appBarRowWidgets: <Widget>[

        ValueListenableBuilder(
          valueListenable: draftNotifier,
          builder: (_, DraftBz? draft, Widget? child){

            return AppBarButton(
            icon: draft?.logoPicModel?.bytes,
            bigIcon: true,
            bubble: false,
            onTap: () async {

              draftNotifier.value?.blogDraft();

              await EditorSwipingButtons.onGoToIndexPage(
                context: context,
                progressBarModel: _progressBarModel,
                pageController: _pageController,
                mounted: mounted,
                toIndex: 0,
              );

              },
          );

          },
        ),

      ],
      child: ValueListenableBuilder(
        valueListenable: draftNotifier,
        builder: (_, DraftBz? draft, Widget? child){

            final String _companyNameBubbleTitle = draft?.bzForm == BzForm.individual ?
            'phid_business_entity_name'
                :
            'phid_companyName';

            final String _selectedBzSectionPhid = BzTyper.getBzSectionPhid(
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

            final String? _selectedBzFormPhid = BzTyper.getBzFormPhid(draft?.bzForm);

            final List<String> _inactiveBzFormsPhids = BzTyper.getBzFormsPhids(
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

                /// 0 - LOGO - NAME
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
                      autoCorrect: Keyboard.autoCorrectIsOn(),
                      enableSuggestions: Keyboard.suggestionsEnabled(),
                      // autoValidate: true,
                      validator: (String? text) => Formers.companyNameValidator(
                        companyName: text,
                        canValidate: true, //draft?.canValidate,
                      ),
                      onTextChanged: (String? text) async {
                        blog('the text is $text');
                        await _onDraftChanged();
                      },
                    ),

                    /// SWIPING BUTTONS
                    EditorSwipingButtons(
                      onNext: _onNextTap,
                      canGoNext: _canGoFrom0to1(
                        draft: draft,
                      ),
                    ),

                    const Horizon(
                      heightFactor: 0,
                    ),

                  ],
                ),

                /// 1 - SECTIONS - BZ TYPE - FORM
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
                      buttonsVerses: Verse.createVerses(strings: _allBzzFormsButtons, translate: true),
                      selectedButtonsPhids: _selectedBzFormPhid == null ? [] : <String>[_selectedBzFormPhid],
                      inactiveButtons: Verse.createVerses(strings: _inactiveBzFormsPhids, translate: true),
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

                    /// SWIPING BUTTONS
                    EditorSwipingButtons(
                      onNext: _onNextTap,
                      onPrevious: _onPreviousTap,
                      canGoNext: _canGoFrom1To2(draft: draft,),
                    ),

                  ],
                ),

                /// 2 - ABOUT - SCOPE
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
                      bulletPoints: const <Verse>[
                        Verse(id: 'phid_optional_field', translate: true),
                      ],
                      autoCorrect: Keyboard.autoCorrectIsOn(),
                      enableSuggestions: Keyboard.suggestionsEnabled(),
                      // autoValidate: true,
                      validator: (String? text) => Formers.bzAboutValidator(
                        bzAbout: text,
                        canValidate: draft?.canValidate,
                      ),
                      onTextChanged: (String? text) async {
                        await _onDraftChanged();
                      },
                    ),

                    /// SCOPES SELECTOR
                    // ScopeSelectorBubble(
                    //   headlineVerse: const Verse(
                    //     id: 'phid_scopeOfServices',
                    //     translate: true,
                    //   ),
                    //   flyerTypes: FlyerTyper.concludePossibleFlyerTypesByBzTypes(bzTypes: draft?.bzTypes),
                    //   selectedSpecs: SpecModel.generateSpecsByPhids(
                    //     phids: draft?.scope,
                    //   ),
                    //   bulletPoints: const <Verse>[
                    //     Verse(
                    //       id: 'phid_select_atleast_one_scope_phid',
                    //       translate: true,
                    //     )
                    //   ],
                    //   onFlyerTypeBubbleTap: (FlyerType flyerType) => onChangeBzScope(
                    //     context: context,
                    //     draftNotifier: draftNotifier,
                    //     flyerType: flyerType,
                    //     mounted: mounted,
                    //   ),
                    //   validator: () => Formers.bzScopeValidator(
                    //     scope: draft?.scope,
                    //     canValidate: draft?.canValidate,
                    //   ),
                    // ),

                    /// SWIPING BUTTONS
                    EditorSwipingButtons(
                      onNext: _onNextTap,
                      onPrevious: _onPreviousTap,
                      canGoNext: _canGoFrom2to3(draft: draft,),
                    ),

                  ],
                ),

                /// 3 - ZONE
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
                        viewerZone: draft?.zone,
                        onZoneChanged: (ZoneModel? zone) {
                          setNotifier(
                            notifier: draftNotifier,
                            mounted: mounted,
                            value: draft?.copyWith(
                              zone: zone,
                            ),
                          );
                        }),

                    /// SWIPING BUTTONS
                    EditorSwipingButtons(
                      onNext: _onNextTap,
                      onPrevious: _onPreviousTap,
                      canGoNext: _canGoFrom3To4(draft: draft),
                    ),

                  ],
                ),

                /// 4 - PHONE - EMAIL - WEBSITE
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
                      contactsArePublic: true,
                      initialTextValue: ContactModel.getInitialContactValue(
                        type: ContactType.phone,
                        countryID: draft?.zone?.countryID,
                        existingContacts: draft?.contacts,
                      ),
                      bulletPoints: const <Verse>[
                        Verse(id: 'phid_optional_field', translate: true),
                      ],
                      canPaste: false,
                      // autoValidate: true,
                      validator: (String? text) => Formers.phoneValidator(
                        phone: text,
                        zoneModel: draft?.zone,
                        canValidate: true, //draft?.canValidate,
                        isMandatory: Standards.bzPhoneIsMandatory,
                      ),
                      textOnChanged: (String? text) => onChangeBzContact(
                        contactType: ContactType.phone,
                        value: text,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                      hintVerse: Verse.plain(
                        '${Flag.getCountryPhoneCode(draft?.zone?.countryID) ?? '00'} 000 00 ...'
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
                      contactsArePublic: true,
                      // autoValidate: true,
                      validator: (String? text) => Formers.emailValidator(
                        email: text,
                        canValidate: true, //draft?.canValidate,
                      ),
                      textOnChanged: (String? text) => onChangeBzContact(
                        contactType: ContactType.email,
                        value: text,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                      hintVerse: Verse.plain('bldr@bldrs.net'),
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
                      contactsArePublic: true,
                      // keyboardTextInputType: TextInputType.url,
                      keyboardTextInputAction: TextInputAction.done,
                      initialTextValue: ContactModel.getInitialContactValue(
                        type: ContactType.website,
                        countryID: draft?.zone?.countryID,
                        existingContacts: draft?.contacts,
                      ),
                      bulletPoints: const <Verse>[
                        Verse(id: 'phid_optional_field', translate: true),
                      ],
                      // canPaste: true,
                      // autoValidate: true,
                      validator: (String? text) => Formers.webSiteValidator(
                        website: text,
                        isMandatory: Standards.bzWebsiteIsMandatory,
                        excludedDomains: <String>[
                          'facebook.com',
                          'linkedin.com',
                          'youtube.com',
                          'instagram.com',
                          'pinterest.com',
                          'tiktok.com',
                          'twitter.com',
                        ],
                      ),
                      textOnChanged: (String? text) => onChangeBzContact(
                        contactType: ContactType.website,
                        value: text,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                    ),

                    /// FACEBOOK - INSTAGRAM - TWITTER - LINKEDIN - YOUTUBE - TIKTOK - SNAPCHAT
                    SocialFieldEditorBubble(
                      contacts: draft?.contacts,
                      onContactChanged: (ContactModel contact) => onChangeBzContact(
                        contactType: contact.type!,
                        value: contact.value,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                    ),

                    /// SWIPING BUTTONS
                    EditorSwipingButtons(
                      onNext: _onNextTap,
                      canGoNext: _canGoFrom4To5(draft: draft),
                      onPrevious: _onPreviousTap,
                    ),

                    // NO NEED FOR NEXT BUTTON HERE
                    const Horizon(
                      heightFactor: 0,
                    ),

                  ],
                ),

                /// 5 - CONFIRM
                EditorConfirmPage(
                  verse: _createConfirmVerse(),
                  onConfirmTap: _onConfirmTap,
                  canConfirm: _canConfirmEdits(),
                  modelHasChanged: _bzHasChanged(),
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
