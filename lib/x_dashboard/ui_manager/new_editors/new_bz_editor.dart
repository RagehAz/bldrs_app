// ignore_for_file: avoid_positional_boolean_parameters
import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/draft/draft_bz.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/bz_editor_controller.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/z_components/scope_selector_bubble.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/contact_field_editor_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pic_bubble/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/floating_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/pages_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/pic_maker.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class NewBzEditor extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const NewBzEditor({
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
  _NewBzEditorState createState() => _NewBzEditorState();
/// --------------------------------------------------------------------------
}

class _NewBzEditorState extends State<NewBzEditor> {
  // -----------------------------------------------------------------------------
  final ValueNotifier<ProgressBarModel> _progressBarModel = ValueNotifier(null);
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
            context: context,
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
    draftNotifier.dispose();
    _loading.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  void _addSessionListeners(){

    draftNotifier.addListener(() async {

      _stripsListener();

      await saveBzEditorSession(
        draftNotifier: draftNotifier,
        mounted: mounted,
      );

    });

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
  /// TASK : WRITE ME
  void _stripsListener(){

    // -----------------
    /// STRIP 1 : SECTION - TYPE - FORM

    final bool _sectionIsValid = Formers.bzSectionValidator(
      context: context,
      selectedSection: draftNotifier.value?.bzSection,
      canValidate: true,
    ) == null;
    final bool _typeIsValid = Formers.bzTypeValidator(
      context: context,
      selectedTypes: draftNotifier.value?.bzTypes,
      canValidate: true,
    ) == null;
    final bool _formIsValid = Formers.bzFormValidator(
      context: context,
      bzForm: draftNotifier.value?.bzForm,
      canValidate: true,
    ) == null;

    if (_sectionIsValid == false || _typeIsValid == false || _formIsValid == false){
      setStripIsValid(0, false);
    }
    else {
      setStripIsValid(0, true);
    }

    // -----------------
    /// STRIP 2 : LOGO - NAME

    final bool _logoIsValid = Formers.picValidator(
      context: context,
      pic: draftNotifier.value?.logoPicModel,
      canValidate: true,
    ) == null;
    final bool _nameIsValid = Formers.companyNameValidator(
      context: context,
      companyName: draftNotifier.value?.name,
      canValidate: true,
    ) == null;

    if (_logoIsValid == false || _nameIsValid == false){
      setStripIsValid(1, false);
    }
    else {
      setStripIsValid(1, true);
    }

    // -----------------
    /// STRIP 3 : ABOUT - SCOPE

    final bool _aboutIsValid = Formers.bzAboutValidator(
      context: context,
      bzAbout: draftNotifier.value?.about,
      canValidate: true,
    ) == null;
    final bool _scopeIsValid = Formers.bzScopeValidator(
      context: context,
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
      context: context,
      zoneModel: draftNotifier.value?.zone,
      selectCountryAndCityOnly: true,
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
      context: context,
    ) == null;
    final bool _emailIsValid = Formers.contactsEmailValidator(
      context: context,
      contacts: draftNotifier.value?.contacts,
      canValidate: true,
    ) == null;
    final bool _websiteIsValid = Formers.contactsWebsiteValidator(
      context: context,
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
        text: widget.bzModel == null ? 'phid_createBzAccount' : 'phid_edit_bz_info',
        translate: true,
      ),
      skyType: SkyType.black,
      loading: _loading,
      progressBarModel: _progressBarModel,
      onBack: () => Dialogs.goBackDialog(
        context: context,
        goBackOnConfirm: true,
      ),
      confirmButtonModel: _confirmButtonModel,
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

          final String _selectedBzFormPhid = BzTyper.getBzFormPhid(
            context: context,
            bzForm: draft?.bzForm,
          );

          final List<String> _inactiveBzFormsPhids = BzTyper.getBzFormsPhids(
            context: context,
            bzForms: draft?.inactiveBzForms,
          );

          return Form(
            key: draft?.formKey,
            child: PagerBuilder(
              progressBarModel: _progressBarModel,
              pageBubbles: <Widget>[

                /// SECTIONS - BZ TYPE - FORM
                FloatingList(
                  columnChildren: <Widget>[

                    /// SECTION
                    MultipleChoiceBubble(
                      titleVerse: const Verse(
                        text: 'phid_sections',
                        translate: true,
                      ),
                      buttonsVerses: Verse.createVerses(strings: _allSectionsPhids, translate: true),
                      selectedButtonsPhids: <String>[_selectedBzSectionPhid],
                      bulletPoints: const <Verse>[
                        Verse(text: 'phid_select_only_one_section', translate: true,),
                        // Verse(text: 'phid_bz_section_selection_info', translate: true,),
                      ],
                      validator: () => Formers.bzSectionValidator(
                        context: context,
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
                        text: 'phid_bz_entity_type',
                        translate: true,
                      ),
                      buttonsVerses: Verse.createVerses(strings: _allBzTypesButtons, translate: true),
                      selectedButtonsPhids: _selectedBzTypesPhids,
                      inactiveButtons: Verse.createVerses(strings: _inactiveBzTypesPhids, translate: true),

                      bulletPoints: const <Verse>[
                        Verse(text: 'phid_select_bz_type', translate: true,),
                      ],
                      validator: () => Formers.bzTypeValidator(
                        context: context,
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
                        text: 'phid_businessForm',
                        translate: true,
                      ),
                      // description: superPhrase(context, 'phid_businessForm_description'),
                      buttonsVerses: Verse.createVerses(strings: _allBzzFormsButtons, translate: true),
                      selectedButtonsPhids: <String>[_selectedBzFormPhid],
                      inactiveButtons: Verse.createVerses(strings: _inactiveBzFormsPhids, translate: true),
                      bulletPoints: const <Verse>[
                        Verse(text: 'phid_bz_form_pro_description', translate: true,),
                        Verse(text: 'phid_bz_form_company_description', translate: true,),
                      ],
                      validator: () => Formers.bzFormValidator(
                        context: context,
                        bzForm: draft?.bzForm,
                        canValidate: draft?.canValidate,
                      ),
                      onButtonTap: (int index) => onChangeBzForm(
                        index: index,
                        draftNotifier: draftNotifier,
                        mounted: mounted,
                      ),
                    ),

                  ],
                ),

                /// LOGO - NAME
                FloatingList(
                  columnChildren: <Widget>[

                    /// ADD LOGO
                    AddImagePicBubble(
                      key: const ValueKey<String>('add_logo_bubble'),
                      picModel: draft?.logoPicModel,
                      titleVerse: const Verse(
                        text: 'phid_businessLogo',
                        translate: true,
                      ),
                      redDot: true,
                      bubbleType: BubbleType.bzLogo,

                      // autoValidate: true,
                      validator: () => Formers.picValidator(
                        context: context,
                        pic: draft?.logoPicModel,
                        canValidate: draft?.canValidate,
                      ),
                      onAddPicture: (PicMakerType imagePickerType) => onChangeBzLogo(
                        context: context,
                        draftNotifier: draftNotifier,
                        imagePickerType: imagePickerType,
                        mounted: mounted,
                      ),
                    ),

                    /// BZ NAME
                    TextFieldBubble(
                      formKey: draft?.formKey,
                      bubbleHeaderVM: BubbleHeaderVM(
                        headlineVerse: Verse(
                          text: _companyNameBubbleTitle,
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
                      keyboardTextInputType: TextInputType.name,
                      keyboardTextInputAction: TextInputAction.next,
                      initialText: draft?.name,

                      // autoValidate: true,
                      validator: (String text) => Formers.companyNameValidator(
                        context: context,
                        companyName: draft?.name,
                        canValidate: draft?.canValidate,
                      ),
                      onTextChanged: (String text){

                        setNotifier(
                          notifier: draftNotifier,
                          mounted: mounted,
                          value: draft?.copyWith(name: text,),
                        );

                      },
                    ),

                  ],
                ),

                /// ABOUT - SCOPE
                FloatingList(
                  columnChildren: <Widget>[

                    /// BZ ABOUT
                    TextFieldBubble(
                      formKey: draft?.formKey,
                      bubbleHeaderVM: const BubbleHeaderVM(
                        headlineVerse: Verse(
                          text: 'phid_about',
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
                      initialText: draft?.about,

                      // autoValidate: true,
                      validator: (String text) => Formers.bzAboutValidator(
                        context: context,
                        bzAbout: draft?.about,
                        canValidate: draft?.canValidate,
                      ),
                      onTextChanged: (String text){

                        setNotifier(
                          notifier: draftNotifier,
                          mounted: mounted,
                          value: draft?.copyWith(
                            about: text,
                          ),
                        );

                      },
                    ),

                    /// SCOPES SELECTOR
                    ScopeSelectorBubble(
                      headlineVerse: const Verse(
                        text: 'phid_scopeOfServices',
                        translate: true,
                      ),
                      flyerTypes: FlyerTyper.concludePossibleFlyerTypesByBzTypes(
                          bzTypes: draft?.bzTypes
                      ),
                      selectedSpecs: SpecModel.generateSpecsByPhids(
                        context: context,
                        phids: draft?.scope,
                      ),
                      bulletPoints: const <Verse>[
                        Verse(
                          text: 'phid_select_atleast_one_scope_phid',
                          translate: true,
                        )
                      ],
                      onAddScope: (FlyerType flyerType) => onChangeBzScope(
                        context: context,
                        draftNotifier: draftNotifier,
                        flyerType: flyerType,
                        mounted: mounted,
                      ),
                      validator: () => Formers.bzScopeValidator(
                        context: context,
                        scope: draft?.scope,
                        canValidate: draft?.canValidate,
                      ),
                    ),

                  ],
                ),

                /// ZONE
                FloatingList(
                  columnChildren: <Widget>[

                    /// BZ ZONE
                    ZoneSelectionBubble(
                        zoneViewingEvent: ViewingEvent.bzEditor,
                        titleVerse: const Verse(
                          text: 'phid_hqCity',
                          translate: true,
                        ),
                        currentZone: draft?.zone,
                        depth: ZoneDepth.district,
                        // selectCountryAndCityOnly: true,
                        // selectCountryIDOnly: false,
                        validator: () => Formers.zoneValidator(
                          context: context,
                          zoneModel: draft?.zone,
                          selectCountryAndCityOnly: true,
                          selectCountryIDOnly: false,
                          canValidate: draft?.canValidate,
                        ),
                        onZoneChanged: (ZoneModel zone){

                          setNotifier(
                            notifier: draftNotifier,
                            mounted: mounted,
                            value: draft?.copyWith(zone: zone,),
                          );

                        }
                    ),

                  ],
                ),

                /// PHONE - EMAIL - WEBSITE
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
                        context: context,
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
                      headerViewModel: const BubbleHeaderVM(
                        headlineVerse: Verse(
                          text: 'phid_emailAddress',
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
                        context: context,
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
                      headerViewModel: const BubbleHeaderVM(
                        headlineVerse: Verse(
                          text: 'phid_website',
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
                        context: context,
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
