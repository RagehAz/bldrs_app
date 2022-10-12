import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/d_spec_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_utilities/alert_model.dart';
import 'package:bldrs/a_models/x_secondary/contact_model.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/x_bz_editor_screen_controllers.dart';
import 'package:bldrs/b_views/f_bz/b_bz_editor_screen/z_components/scope_selector_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/editor_confirm_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/night_sky.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pic_bubble/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/contacts_bubble/contact_field_editor_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
    if (mounted == true){
      if (_canValidate != true){
        setState(() {
          _canValidate = true;
        });
      }
    }
  }  // --------------------
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
  /// LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
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
      pageTitleVerse: Verse(
        text: widget.firstTimer == true ? 'phid_createBzAccount' : 'phid_edit_bz_info',
        translate: true,
      ),
      appBarRowWidgets: [
        AppBarButton(
          verse: Verse.plain('BOM'),
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
          firstLine: const Verse(
            text: 'phid_confirm',
            translate: true,
          ),
          secondLine: Verse(
            text: widget.firstTimer == true ? 'phid_create_new_bz_profile' : 'phid_update_bz_profile',
            translate: true,
          ),
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

                      /// SECTION
                      ValueListenableBuilder(
                          key: const ValueKey<String>('section_selection_bubble'),
                          valueListenable: _selectedBzSection,
                          builder: (_, BzSection selectedSection, Widget child){

                            final String _selectedButton = BzModel.getBzSectionPhid(
                              context: context,
                              bzSection: selectedSection,
                            );

                            final List<String> _allSectionsPhids = BzModel.getBzSectionsPhids(
                              context: context,
                              bzSections: BzModel.bzSectionsList,
                            );

                            return MultipleChoiceBubble(
                              titleVerse: const Verse(
                                text: 'phid_sections',
                                translate: true,
                              ),
                              buttonsVerses: Verse.createVerses(strings: _allSectionsPhids, translate: true),
                              selectedButtonsPhids: <String>[_selectedButton],
                              onButtonTap: (int index) => onSelectBzSection(
                                context: context,
                                index: index,
                                tempBz: _tempBz,
                                selectedBzSection: _selectedBzSection,
                                inactiveBzTypes: _inactiveBzTypes,
                                inactiveBzForms: _inactiveBzForms,
                                selectedScopes: _selectedScopes,
                              ),
                              bulletPoints: const <Verse>[
                                Verse(text: 'phid_select_only_one_section', translate: true,),
                                Verse(text: 'phid_bz_section_selection_info', translate: true,),
                              ],
                              validator: () => Formers.bzSectionValidator(
                                selectedSection: selectedSection,
                                canValidate: _canValidate
                              ),
                            );

                          }
                      ),

                      /// BZ TYPE
                      ValueListenableBuilder(
                          valueListenable: _inactiveBzTypes,
                          builder: (_, List<BzType> inactiveTypes, Widget child){

                            final List<String> _allButtons = BzModel.getBzTypesPhids(
                              context: context,
                              bzTypes: BzModel.bzTypesList,
                              pluralTranslation: false,
                            );
                            final List<String> _inactiveButtons = BzModel.getBzTypesPhids(
                              context: context,
                              bzTypes: inactiveTypes,
                              pluralTranslation: false,
                            );
                            final List<String> _selectedButtons = BzModel.getBzTypesPhids(
                              context: context,
                              bzTypes: bzModel?.bzTypes,
                              pluralTranslation: false,
                            );

                            return MultipleChoiceBubble(
                              titleVerse: const Verse(
                                text: 'phid_bz_entity_type',
                                translate: true,
                              ),
                              buttonsVerses: Verse.createVerses(strings: _allButtons, translate: true),
                              selectedButtonsPhids: _selectedButtons,
                              inactiveButtons: Verse.createVerses(strings: _inactiveButtons, translate: true),
                              onButtonTap: (int index) => onSelectBzType(
                                context: context,
                                index: index,
                                tempBz: _tempBz,
                                inactiveBzForms: _inactiveBzForms,
                                inactiveBzTypes: _inactiveBzTypes,
                                selectedBzSection: _selectedBzSection,
                                selectedScopes: _selectedScopes,
                              ),
                              bulletPoints: const <Verse>[
                                Verse(text: 'phid_select_bz_type', translate: true,),
                              ],
                              validator: () => Formers.bzTypeValidator(
                                  selectedTypes: bzModel?.bzTypes,
                                  canValidate: _canValidate
                              ),
                            );

                          }
                      ),

                      /// BZ FORM
                      ValueListenableBuilder(
                        valueListenable: _inactiveBzForms,
                        builder: (_, List<BzForm> inactiveBzForms, Widget child){

                          final List<String> _buttonsList = BzModel.getBzFormsPhids(
                            context: context,
                            bzForms: BzModel.bzFormsList,
                          );

                          final String _selectedButton = BzModel.getBzFormPhid(
                            context: context,
                            bzForm: bzModel?.bzForm,
                          );

                          final List<String> _inactiveButtons = BzModel.getBzFormsPhids(
                            context: context,
                            bzForms: inactiveBzForms,
                          );

                          return MultipleChoiceBubble(
                            titleVerse: const Verse(
                              text: 'phid_businessForm',
                              translate: true,
                            ),
                            // description: superPhrase(context, 'phid_businessForm_description'),
                            buttonsVerses: Verse.createVerses(strings: _buttonsList, translate: true),
                            selectedButtonsPhids: <String>[_selectedButton],
                            inactiveButtons: Verse.createVerses(strings: _inactiveButtons, translate: true),
                            onButtonTap: (int index) => onSelectBzForm(
                              index: index,
                              tempBz: _tempBz,
                            ),
                            bulletPoints: const <Verse>[
                              Verse(text: 'phid_bz_form_pro_description', translate: true,),
                              Verse(text: 'phid_bz_form_company_description', translate: true,),
                            ],
                            validator: () => Formers.bzFormValidator(
                              bzForm: bzModel?.bzForm,
                              canValidate: _canValidate,
                            ),
                          );

                        },
                      ),

                      /// SEPARATOR
                      const DotSeparator(),

                      /// ADD LOGO
                      AddImagePicBubble(
                        key: const ValueKey<String>('add_logo_bubble'),
                        fileModel: bzModel?.logo,
                        titleVerse: const Verse(
                          text: 'phid_businessLogo',
                          translate: true,
                        ),
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

                      /// BZ NAME
                      TextFieldBubble(
                        globalKey: _formKey,
                        headerViewModel: BubbleHeaderVM(
                          headlineVerse: Verse(
                            text: _companyNameBubbleTitle,
                            translate: true,
                          ),
                          redDot: true,

                        ),
                        focusNode: _nameNode,
                        appBarType: AppBarType.basic,
                        isFormField: true,
                        key: const ValueKey('bzName'),
                        counterIsOn: true,
                        maxLength: 72,
                        maxLines: 2,
                        keyboardTextInputType: TextInputType.name,
                        keyboardTextInputAction: TextInputAction.next,
                        initialText: bzModel?.name,
                        textOnChanged: (String text) => onBzNameChanged(
                          text: text,
                          tempBz: _tempBz,
                        ),
                        // autoValidate: true,
                        validator: (String text) => Formers.companyNameValidator(
                          companyName: bzModel?.name,
                          canValidate: _canValidate,
                        ),
                      ),

                      /// BZ ABOUT
                      TextFieldBubble(
                          globalKey: _formKey,
                          headerViewModel: const BubbleHeaderVM(
                            headlineVerse: Verse(
                              text: 'phid_about',
                              translate: true,
                            ),
                          ),
                          focusNode: _aboutNode,
                          appBarType: AppBarType.basic,
                          key: const ValueKey<String>('bz_about_bubble'),
                          counterIsOn: true,
                          maxLength: 1000,
                          maxLines: 20,
                          keyboardTextInputType: TextInputType.multiline,
                          initialText: bzModel?.about,
                          textOnChanged: (String text) => onBzAboutChanged(
                            text: text,
                            tempBz: _tempBz,
                          ),
                          // autoValidate: true,
                          validator: (String text) => Formers.bzAboutValidator(
                            bzAbout: bzModel?.about,
                            canValidate: _canValidate,
                          ),
                      ),

                      /// SEPARATOR
                      const DotSeparator(),

                      /// PHONE
                      ContactFieldEditorBubble(
                        key: const ValueKey<String>('phone'),
                        globalKey: _formKey,
                        focusNode: _phoneNode,
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
                        validator: (String text) => Formers.contactsPhoneValidator(
                          contacts: bzModel?.contacts,
                          zoneModel: bzModel?.zone,
                          canValidate: _canValidate,
                          isRequired: true,
                          context: context,
                        ),
                      ),

                      /// EMAIL
                      ContactFieldEditorBubble(
                        key: const ValueKey<String>('email'),
                        globalKey: _formKey,
                        focusNode: _emailNode,
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
                        validator: (String text) => Formers.contactsEmailValidator(
                          contacts: bzModel?.contacts,
                          canValidate: _canValidate,
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
                        validator: (String text) => Formers.contactsWebsiteValidator(
                          contacts: bzModel?.contacts,
                          canValidate: _canValidate,
                        ),
                      ),

                      const DotSeparator(),

                      /// SCOPES SELECTOR
                      ValueListenableBuilder(
                        valueListenable: _selectedScopes,
                        builder: (_, List<SpecModel> selectedSpecs, Widget child){

                          return ScopeSelectorBubble(
                            headlineVerse: const Verse(
                              text: 'phid_scopeOfServices',
                              translate: true,
                            ),
                            flyerTypes: FlyerTyper.concludePossibleFlyerTypesByBzTypes(bzTypes: bzModel?.bzTypes),
                            selectedSpecs: selectedSpecs,
                            bulletPoints: const <Verse>[
                              Verse(
                                pseudo: 'Select at least 1 keyword to help search engines show your content in its dedicated place',
                                text: '##Select at least 1 keyword to help search engines show your content in its dedicated place',
                                translate: true,
                              )
                            ],
                            onAddScope: (FlyerType flyerType) => onAddScopesTap(
                              context: context,
                              selectedSpecs: selectedSpecs,
                              flyerType: flyerType,
                              zone: bzModel.zone,
                              onlyChainKSelection: true,
                              onFinish: (List<SpecModel> specs){
                                if (specs != null){
                                  _selectedScopes.value = specs;
                                }
                              }
                            ),
                          );

                        },
                      ),

                      const DotSeparator(),

                      /// BZ ZONE
                      ZoneSelectionBubble(
                        titleVerse: const Verse(
                          text: 'phid_hqCity',
                          translate: true,
                        ),
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

                      /// BZ POSITION
                      //

                      /// BZ CONTACTS
                      // ContactsEditorsBubbles(
                      //   globalKey: formKey,
                      //   appBarType: appBarType,
                      //   contacts: bzModel.contacts,
                      //   contactsOwnerType: ContactsOwnerType.bz,
                      // ),

                      /// SEPARATOR
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
