import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/secondary_models/alert_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/x_bz_editor_screen_controllers.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/c_phid_button.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/contact_field_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class BzEditorScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const BzEditorScreen({
    this.firstTimer = false,
    this.bzModel,
    this.checkLastSession = true,
    this.validateOnStartup = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool firstTimer;
  final BzModel bzModel;
  final bool checkLastSession;
  final bool validateOnStartup;
  /// --------------------------------------------------------------------------
  @override
  _BzEditorScreenState createState() => _BzEditorScreenState();
  /// --------------------------------------------------------------------------
}

class _BzEditorScreenState extends State<BzEditorScreen> with TickerProviderStateMixin {
  // -----------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // --------------------
  bool _canValidate = false;
  void _switchOnValidation(){
    if (_canValidate != true){
      setState(() {
        _canValidate = true;
      });
    }
  }
  // --------------------
  final ValueNotifier<bool> _canPickImage = ValueNotifier(true);
  // --------------------
  final ValueNotifier<BzModel> _tempBz = ValueNotifier<BzModel>(null);
  final ValueNotifier<BzModel> _lastTempBz = ValueNotifier(null);
  // --------------------
  final FocusNode _nameNode = FocusNode();
  final FocusNode _aboutNode = FocusNode();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _websiteNode = FocusNode();
  final FocusNode _phoneNode = FocusNode();
  // --------------------
  final ValueNotifier<List<SpecModel>> _selectedScopes = ValueNotifier([]);
  // --------------------
  final ValueNotifier<BzSection> _selectedBzSection = ValueNotifier<BzSection>(null);
  final ValueNotifier<List<BzType>> _inactiveBzTypes = ValueNotifier<List<BzType>>(null);
  final ValueNotifier<List<BzForm>> _inactiveBzForms = ValueNotifier<List<BzForm>>(null);
  final ValueNotifier<List<AlertModel>> _missingFields = ValueNotifier(<AlertModel>[]);
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
  // --------------------
  Future<void> _triggerLoading({bool setTo}) async {
    if (mounted == true){
      if (setTo == null){
        _loading.value = !_loading.value;
      }
      else {
        _loading.value = setTo;
      }
      blogLoading(loading: _loading.value, callerName: 'EditProfileScreen',);
    }
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    initializeBzEditorLocalVariables(
      context: context,
      tempBz: _tempBz,
      oldBz: widget.bzModel,
      inactiveBzForms: _inactiveBzForms,
      inactiveBzTypes: _inactiveBzTypes,
      selectedBzSection: _selectedBzSection,
      selectedScopes: _selectedScopes,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {

      _triggerLoading(setTo: true).then((_) async {
        // -------------------------------
        await prepareBzForEditing(
          mounted: mounted,
          context: context,
          tempBz: _tempBz,
          oldBz: widget.bzModel,
          firstTimer: widget.firstTimer,
        );
        // -------------------------------
        if (widget.checkLastSession == true) {
          await loadBzEditorLastSession(
            context: context,
            oldBz: widget.bzModel,
            firstTimer: widget.firstTimer,
          );
        }
        // -----------------------------
        if (widget.validateOnStartup == true){
          _switchOnValidation();
          Formers.validateForm(_formKey);
        }
        // -----------------------------
        if (mounted == true){
          _tempBz.addListener(() => _saveSession());
          _selectedScopes.addListener(() => _saveSession());
        }
        // -------------------------------
        await _triggerLoading(setTo: false);
      });

    }
    _isInit = false;
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    _canPickImage.dispose();

    _nameNode.dispose();
    _aboutNode.dispose();
    _emailNode.dispose();
    _websiteNode.dispose();
    _phoneNode.dispose();

    _selectedScopes.dispose();

    _selectedBzSection.dispose();
    _inactiveBzTypes.dispose();
    _inactiveBzForms.dispose();
    _missingFields.dispose();

    _loading.dispose();

    _tempBz.dispose();
    _lastTempBz.dispose();

    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> _saveSession() async {
    _switchOnValidation();
    await saveBzEditorSession(
        tempBz: _tempBz,
        lastTempBz: _lastTempBz,
        selectedScopes: _selectedScopes,
        oldBz: widget.bzModel,
        mounted: mounted,
    );
  }
  // --------------------
  Future<void> _onConfirmTap() async {

    _switchOnValidation();

    await onBzEditsConfirmTap(
      context: context,
      formKey: _formKey,
      missingFields: _missingFields,
      selectedScopes: _selectedScopes,
      oldBz: widget.bzModel,
      firstTimer: widget.firstTimer,
      tempBz: _tempBz,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MainLayout(
      key: const ValueKey<String>('BzEditorScreen'),
      loading: _loading,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      historyButtonIsOn: false,
      sectionButtonIsOn: false,
      skyType: SkyType.black,
      pageTitleVerse: widget.firstTimer == true ? 'phid_createBzAccount' : 'phid_edit_bz_info',
      appBarRowWidgets: [
        AppBarButton(
          verse: 'BOM',
          onTap: (){

            Formers.validateForm(_formKey);

            // _tempBz.value = _tempBz.value.nullifyField(
            //   zone: true,
            // );

            // _tempBz.value = _tempBz.value.copyWith(
            //   bz: [],
            // );

          },
        ),
      ],
      confirmButtonModel: ConfirmButtonModel(
          firstLine: 'phid_confirm',
          secondLine: widget.firstTimer == true ? 'phid_create_new_bz_profile' : 'phid_update_bz_profile',
          onTap: () => _onConfirmTap(),
      ),
      layoutWidget: Form(
        key: _formKey,
        child: ValueListenableBuilder(
          valueListenable: _missingFields,
          builder: (_, List<AlertModel> missingFields, Widget child){

            // final List<String> _missingFieldsKeys = MapModel.getKeysFromMapModels(missingFields);

            return ValueListenableBuilder(
                valueListenable: _tempBz,
                builder: (_, BzModel bzModel, Widget child){

                  final String _companyNameBubbleTitle = bzModel?.bzForm == BzForm.individual ?
                  'phid_business_entity_name'
                      :
                  'phid_companyName';

                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    children: <Widget>[

                      const Stratosphere(),

                      /// --- SECTION
                      ValueListenableBuilder(
                          key: const ValueKey<String>('section_selection_bubble'),
                          valueListenable: _selectedBzSection,
                          builder: (_, BzSection selectedSection, Widget child){

                            final String _selectedButton = BzModel.translateBzSection(
                              context: context,
                              bzSection: selectedSection,
                            );

                            final List<String> _allSections = BzModel.translateBzSections(
                              context: context,
                              bzSections: BzModel.bzSectionsList,
                            );

                            return MultipleChoiceBubble(
                              title: 'phid_sections',
                              buttonsList: _allSections,
                              selectedButtons: <String>[_selectedButton],
                              onButtonTap: (int index) => onSelectBzSection(
                                context: context,
                                index: index,
                                tempBz: _tempBz,
                                selectedBzSection: _selectedBzSection,
                                inactiveBzTypes: _inactiveBzTypes,
                                inactiveBzForms: _inactiveBzForms,
                                selectedScopes: _selectedScopes,
                              ),
                              bulletPoints: const <String>[
                                'phid_select_only_one_section',
                                'phid_bz_section_selection_info',
                              ],
                              validator: () => Formers.bzSectionValidator(
                                selectedSection: selectedSection,
                                canValidate: _canValidate
                              ),
                            );

                          }
                      ),

                      /// --- BZ TYPE
                      ValueListenableBuilder(
                          valueListenable: _inactiveBzTypes,
                          builder: (_, List<BzType> inactiveTypes, Widget child){

                            final List<String> _allButtons = BzModel.translateBzTypes(
                              context: context,
                              bzTypes: BzModel.bzTypesList,
                              pluralTranslation: false,
                            );
                            final List<String> _inactiveButtons = BzModel.translateBzTypes(
                              context: context,
                              bzTypes: inactiveTypes,
                              pluralTranslation: false,
                            );
                            final List<String> _selectedButtons = BzModel.translateBzTypes(
                              context: context,
                              bzTypes: bzModel?.bzTypes,
                              pluralTranslation: false,
                            );

                            return MultipleChoiceBubble(
                              title: 'phid_bz_entity_type',
                              buttonsList: _allButtons,
                              selectedButtons: _selectedButtons,
                              inactiveButtons: _inactiveButtons,
                              onButtonTap: (int index) => onSelectBzType(
                                context: context,
                                index: index,
                                tempBz: _tempBz,
                                inactiveBzForms: _inactiveBzForms,
                                inactiveBzTypes: _inactiveBzTypes,
                                selectedBzSection: _selectedBzSection,
                                selectedScopes: _selectedScopes,
                              ),
                              bulletPoints: const <String>[
                                'phid_select_bz_type',
                              ],
                              validator: () => Formers.bzTypeValidator(
                                  selectedTypes: bzModel?.bzTypes,
                                  canValidate: _canValidate
                              ),
                            );

                          }
                      ),

                      /// --- BZ FORM
                      ValueListenableBuilder(
                        valueListenable: _inactiveBzForms,
                        builder: (_, List<BzForm> inactiveBzForms, Widget child){

                          final List<String> _buttonsList = BzModel.translateBzForms(
                            context: context,
                            bzForms: BzModel.bzFormsList,
                          );

                          final String _selectedButton = BzModel.translateBzForm(
                            context: context,
                            bzForm: bzModel?.bzForm,
                          );

                          final List<String> _inactiveButtons = BzModel.translateBzForms(
                            context: context,
                            bzForms: inactiveBzForms,
                          );

                          return MultipleChoiceBubble(
                            title: 'phid_businessForm',
                            // description: superPhrase(context, 'phid_businessForm_description'),
                            buttonsList: _buttonsList,
                            selectedButtons: <String>[_selectedButton],
                            inactiveButtons: _inactiveButtons,
                            onButtonTap: (int index) => onSelectBzForm(
                              index: index,
                              tempBz: _tempBz,
                            ),
                            bulletPoints: const <String>[
                              'phid_bz_form_pro_description',
                              'phid_bz_form_company_description',
                            ],
                            validator: () => Formers.bzFormValidator(
                              bzForm: bzModel?.bzForm,
                              canValidate: _canValidate,
                            ),
                          );

                        },
                      ),

                      const DotSeparator(),

                      /// --- ADD LOGO
                      AddImagePicBubble(
                        key: const ValueKey<String>('add_logo_bubble'),
                        fileModel: bzModel?.logo,
                        titleVerse: 'phid_businessLogo',
                        redDot: true,
                        bubbleType: BubbleType.bzLogo,
                        onAddPicture: (ImagePickerType imagePickerType) => takeBzLogo(
                          context: context,
                          tempBz: _tempBz,
                          imagePickerType: imagePickerType,
                          canPickImage: _canPickImage,
                        ),
                        // autoValidate: true,
                        validator: () => Formers.picValidator(
                          pic: bzModel?.logo,
                          canValidate: _canValidate,
                        ),
                      ),

                      /// --- BZ NAME
                      TextFieldBubble(
                        globalKey: _formKey,
                        focusNode: _nameNode,
                        appBarType: AppBarType.basic,
                        isFormField: true,
                        key: const ValueKey('bzName'),
                        titleVerse: _companyNameBubbleTitle,
                        counterIsOn: true,
                        maxLength: 72,
                        maxLines: 2,
                        keyboardTextInputType: TextInputType.name,
                        keyboardTextInputAction: TextInputAction.next,
                        fieldIsRequired: true,
                        initialTextValue: bzModel?.name,
                        textOnChanged: (String text) => onBzNameChanged(
                          text: text,
                          tempBz: _tempBz,
                        ),
                        // autoValidate: true,
                        validator: () => Formers.companyNameValidator(
                          companyName: bzModel?.name,
                          canValidate: _canValidate,
                        ),
                      ),

                      /// --- BZ ABOUT
                      TextFieldBubble(
                          globalKey: _formKey,
                          focusNode: _aboutNode,
                          appBarType: AppBarType.basic,
                          key: const ValueKey<String>('bz_about_bubble'),
                          titleVerse: 'phid_about',
                          counterIsOn: true,
                          maxLength: 1000,
                          maxLines: 20,
                          keyboardTextInputType: TextInputType.multiline,
                          initialTextValue: bzModel?.about,
                          textOnChanged: (String text) => onBzAboutChanged(
                            text: text,
                            tempBz: _tempBz,
                          ),
                          // autoValidate: true,
                          validator: () => Formers.bzAboutValidator(
                            bzAbout: bzModel?.about,
                            canValidate: _canValidate,
                          ),
                      ),

                      const DotSeparator(),

                      /// PHONE
                      ContactFieldBubble(
                        key: const ValueKey<String>('phone'),
                        globalKey: _formKey,
                        focusNode: _phoneNode,
                        appBarType: AppBarType.basic,
                        isFormField: true,
                        headerViewModel: const BubbleHeaderVM(
                          headlineVerse: 'phid_phone',
                          redDot: true,
                        ),
                        keyboardTextInputType: TextInputType.phone,
                        keyboardTextInputAction: TextInputAction.next,
                        initialTextValue: ContactModel.getInitialContactValue(
                          type: ContactType.phone,
                          countryID: bzModel?.zone?.countryID,
                          existingContacts: bzModel?.contacts,
                        ),
                        textOnChanged: (String text) => onBzContactChanged(
                          contactType: ContactType.phone,
                          value: text,
                          tempBz: _tempBz,
                        ),
                        canPaste: false,
                        // autoValidate: true,
                        validator: () => Formers.contactsPhoneValidator(
                          contacts: bzModel?.contacts,
                          zoneModel: bzModel?.zone,
                          canValidate: _canValidate,
                        ),
                      ),

                      /// EMAIL
                      ContactFieldBubble(
                        key: const ValueKey<String>('email'),
                        globalKey: _formKey,
                        focusNode: _emailNode,
                        appBarType: AppBarType.basic,
                        isFormField: true,
                        headerViewModel: const BubbleHeaderVM(
                          headlineVerse: 'phid_email',
                          redDot: true,
                        ),
                        keyboardTextInputType: TextInputType.emailAddress,
                        keyboardTextInputAction: TextInputAction.next,
                        initialTextValue: ContactModel.getInitialContactValue(
                          type: ContactType.email,
                          countryID: bzModel?.zone?.countryID,
                          existingContacts: bzModel?.contacts,
                        ),
                        textOnChanged: (String text) => onBzContactChanged(
                          contactType: ContactType.email,
                          value: text,
                          tempBz: _tempBz,
                        ),
                        canPaste: false,
                        // autoValidate: true,
                        validator: () => Formers.contactsEmailValidator(
                          contacts: bzModel?.contacts,
                          canValidate: _canValidate,
                        ),
                      ),

                      /// WEBSITE
                      ContactFieldBubble(
                        key: const ValueKey<String>('website'),
                        headerViewModel: const BubbleHeaderVM(
                          headlineVerse: 'phid_website',
                        ),
                        globalKey: _formKey,
                        focusNode: _websiteNode,
                        appBarType: AppBarType.basic,
                        isFormField: true,
                        // keyboardTextInputType: TextInputType.url,
                        keyboardTextInputAction: TextInputAction.done,
                        initialTextValue: ContactModel.getInitialContactValue(
                          type: ContactType.website,
                          countryID: bzModel?.zone?.countryID,
                          existingContacts: bzModel?.contacts,
                        ),
                        textOnChanged: (String text) => onBzContactChanged(
                          contactType: ContactType.website,
                          value: text,
                          tempBz: _tempBz,
                        ),
                        // canPaste: true,
                        // autoValidate: true,
                        validator: () => Formers.contactsWebsiteValidator(
                          contacts: bzModel?.contacts,
                          canValidate: _canValidate,
                        ),
                      ),

                      const DotSeparator(),

                      /// SCOPES SELECTOR
                      ValueListenableBuilder(
                        valueListenable: _selectedScopes,
                        builder: (_, List<SpecModel> selectedSpecs, Widget child){

                          final List<String> _phids = SpecModel.getSpecsIDs(selectedSpecs);

                          return WidgetFader(
                            fadeType: Mapper.checkCanLoopList(bzModel?.bzTypes) == true ? FadeType.stillAtMax : FadeType.stillAtMin,
                            min: 0.35,
                            absorbPointer: Mapper.checkCanLoopList(bzModel?.bzTypes) == false,
                            child: Bubble(
                              headerViewModel: const BubbleHeaderVM(
                                headlineVerse: 'phid_scope_of_services',
                              ),
                              screenWidth: Bubble.bubbleWidth(
                                context: context,
                                stretchy: false,
                              ),
                              columnChildren: <Widget>[

                                const BubbleBulletPoints(
                                  bulletPoints:  <String>[
                                    '##Select at least 1 keyword to help search engines show your content in its dedicated place',
                                  ],
                                  translateBullets: true,
                                ),

                                if (Mapper.checkCanLoopList(_phids))
                                  PhidsViewer(
                                    pageWidth: Bubble.clearWidth(context),
                                    phids: _phids,
                                  ),

                                DreamBox(
                                  height: PhidButton.getHeight(),
                                  // width: Bubble.clearWidth(context),
                                  verse: Mapper.checkCanLoopList(_phids) ? '##Edit Scopes' : '##Add Scopes',
                                  bubble: false,
                                  color: Colorz.white20,
                                  verseScaleFactor: 1.5,
                                  verseWeight: VerseWeight.thin,
                                  icon: Iconz.plus,
                                  iconSizeFactor: 0.4,
                                  iconColor: Colorz.white20,
                                  onTap: () => onAddScopesTap(
                                    context: context,
                                    selectedScopes: _selectedScopes,
                                    tempBz: _tempBz,
                                  ),
                                ),

                              ],
                            ),
                          );
                        },
                      ),

                      const DotSeparator(),

                      /// --- BZ ZONE
                      ZoneSelectionBubble(
                        titleVerse: 'phid_hqCity',
                        currentZone: bzModel?.zone,
                        onZoneChanged: (ZoneModel zone) => onBzZoneChanged(
                          zoneModel: zone,
                          tempBz: _tempBz,
                        ),
                        // selectCountryAndCityOnly: true,
                        // selectCountryIDOnly: false,
                        validator: () => Formers.zoneValidator(
                          zoneModel: bzModel?.zone,
                          selectCountryAndCityOnly: true,
                          selectCountryIDOnly: false,
                          canValidate: _canValidate,
                        ),
                      ),

                      /// --- BZ POSITION
                      //

                      /// --- BZ CONTACTS
                      // ContactsEditorsBubbles(
                      //   globalKey: formKey,
                      //   appBarType: appBarType,
                      //   contacts: bzModel.contacts,
                      //   contactsOwnerType: ContactsOwnerType.bz,
                      // ),

                      const DotSeparator(),

                      const Horizon(),

                    ],
                  );

                }
            );

          },
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
