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
import 'package:bldrs/b_views/z_components/editors/contacts_editor_bubbles.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_keywords.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/profile_editors/add_gallery_pic_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/f_helpers/drafters/imagers.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class BzEditorScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzEditorScreenView({
    @required this.formKey,
    @required this.tempBz,
    @required this.missingFields,
    @required this.selectedBzSection,
    @required this.inactiveBzTypes,
    @required this.inactiveBzForms,
    @required this.selectedScopes,
    @required this.bzNameTextController,
    @required this.bzAboutTextController,
    @required this.appBarType,
    @required this.nameNode,
    @required this.aboutNode,
    @required this.canPickImage,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final ValueNotifier<BzModel> tempBz;
  final ValueNotifier<List<AlertModel>> missingFields;
  final ValueNotifier<BzSection> selectedBzSection;
  final ValueNotifier<List<BzType>> inactiveBzTypes;
  final ValueNotifier<List<BzForm>> inactiveBzForms;
  final ValueNotifier<List<SpecModel>> selectedScopes;
  final TextEditingController bzNameTextController;
  final TextEditingController bzAboutTextController;
  final AppBarType appBarType;
  final FocusNode nameNode;
  final FocusNode aboutNode;
  final ValueNotifier<bool> canPickImage;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Form(
      key: formKey,
      child: ValueListenableBuilder(
        valueListenable: missingFields,
        builder: (_, List<AlertModel> missingFields, Widget child){

          // final List<String> _missingFieldsKeys = MapModel.getKeysFromMapModels(missingFields);

          return ValueListenableBuilder(
              valueListenable: tempBz,
              builder: (_, BzModel bzModel, Widget child){

                final String _companyNameBubbleTitle = bzModel.bzForm == BzForm.individual ?
                'phid_business_entity_name'
                    :
                'phid_companyName';

                return ListView(
                  physics: const BouncingScrollPhysics(),
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  children: <Widget>[

                    const Stratosphere(),

                    /// --- SECTION SELECTION
                    ValueListenableBuilder(
                        key: const ValueKey<String>('section_selection_bubble'),
                        valueListenable: selectedBzSection,
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
                            isInError: false,
                            onButtonTap: (int index) => onSelectBzSection(
                              context: context,
                              index: index,
                              tempBz: tempBz,
                              selectedBzSection: selectedBzSection,
                              inactiveBzTypes: inactiveBzTypes,
                              inactiveBzForms: inactiveBzForms,
                              selectedScopes: selectedScopes,
                            ),
                          );

                        }
                    ),

                    /// --- BZ TYPE SELECTION
                    ValueListenableBuilder(
                        valueListenable: inactiveBzTypes,
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
                            bzTypes: bzModel.bzTypes,
                            pluralTranslation: false,
                          );

                          return MultipleChoiceBubble(
                            title: 'phid_bz_entity_type',
                            buttonsList: _allButtons,
                            selectedButtons: _selectedButtons,
                            inactiveButtons: _inactiveButtons,
                            isInError: false,
                            onButtonTap: (int index) => onSelectBzType(
                              context: context,
                              index: index,
                              tempBz: tempBz,
                              inactiveBzForms: inactiveBzForms,
                              inactiveBzTypes: inactiveBzTypes,
                              selectedBzSection: selectedBzSection,
                              selectedScopes: selectedScopes,
                            ),
                          );

                        }
                    ),

                    /// --- BZ FORM SELECTION
                    ValueListenableBuilder(
                      valueListenable: inactiveBzForms,
                      builder: (_, List<BzForm> inactiveBzForms, Widget child){

                        final List<String> _buttonsList = BzModel.translateBzForms(
                          context: context,
                          bzForms: BzModel.bzFormsList,
                        );

                        final String _selectedButton = BzModel.translateBzForm(
                          context: context,
                          bzForm: bzModel.bzForm,
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
                          isInError: false,
                          onButtonTap: (int index) => onSelectBzForm(
                            index: index,
                            tempBz: tempBz,
                          ),
                        );

                      },
                    ),

                    const DotSeparator(),

                    /// --- ADD LOGO
                    AddImagePicBubble(
                      key: const ValueKey<String>('add_logo_bubble'),
                      fileModel: bzModel.logo,
                      titleVerse: 'phid_businessLogo',
                      redDot: true,
                      bubbleType: BubbleType.bzLogo,
                      onAddPicture: (ImagePickerType imagePickerType) => takeBzLogo(
                        context: context,
                        tempBz: tempBz,
                        imagePickerType: imagePickerType,
                        canPickImage: canPickImage,
                      ),
                    ),

                    /// --- BZ NAME
                    TextFieldBubble(
                      globalKey: formKey,
                      focusNode: nameNode,
                      appBarType: appBarType,
                      isFormField: true,
                      key: const Key('bzName'),
                      textController: bzNameTextController,
                      titleVerse: _companyNameBubbleTitle,
                      counterIsOn: true,
                      maxLength: 72,
                      maxLines: 2,
                      keyboardTextInputType: TextInputType.name,
                      keyboardTextInputAction: TextInputAction.next,
                      fieldIsRequired: true,
                      validator: (){

                        if (Stringer.checkStringIsEmpty(bzNameTextController.text) == true){
                          return '##Business Entity name can not be empty';
                        }
                        else if (bzNameTextController.text.length <= 3){
                          return '##Business Entity name should be more than 3 characters';
                        }
                        else {
                          return null;
                        }

                      },
                    ),

                    /// --- BZ ABOUT
                    TextFieldBubble(
                      globalKey: formKey,
                      focusNode: aboutNode,
                      appBarType: appBarType,
                      key: const ValueKey<String>('bz_about_bubble'),
                      textController: bzAboutTextController,
                      titleVerse: 'phid_about',
                      counterIsOn: true,
                      maxLength: 1000,
                      maxLines: 20,
                      keyboardTextInputType: TextInputType.multiline,
                      validator: (){return null;},
                    ),

                    /// SCOPES SELECTOR
                    ValueListenableBuilder(
                      valueListenable: selectedScopes,
                      builder: (_, List<SpecModel> selectedSpecs, Widget child){

                        final List<String> _phids = SpecModel.getSpecsIDs(selectedSpecs);

                        return WidgetFader(
                          fadeType: Mapper.checkCanLoopList(bzModel.bzTypes) == true ? FadeType.stillAtMax : FadeType.stillAtMin,
                          min: 0.35,
                          absorbPointer: Mapper.checkCanLoopList(bzModel.bzTypes) == false,
                          child: Bubble(
                            headerViewModel: const BubbleHeaderVM(
                              headlineVerse: 'phid_scope_of_services',
                            ),
                            width: Bubble.bubbleWidth(
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
                                  selectedScopes: selectedScopes,
                                  tempBz: tempBz,
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
                      currentZone: bzModel.zone,
                      onZoneChanged: (ZoneModel zone) => onBzZoneChanged(
                        zoneModel: zone,
                        tempBz: tempBz,
                      ),
                    ),

                    /// --- BZ POSITION
                    //

                    /// --- BZ CONTACTS
                    ContactsEditorsBubbles(
                      globalKey: formKey,
                      appBarType: appBarType,
                      contacts: bzModel.contacts,
                      contactsOwnerType: ContactsOwnerType.bz,
                    ),

                    const DotSeparator(),

                    const Horizon(),

                  ],
                );

              }
          );

        },
      ),
    );

  }
}
