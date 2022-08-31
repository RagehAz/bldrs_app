import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/chain/d_spec_model.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/secondary_models/alert_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
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
    @required this.missingFields,
    @required this.selectedBzSection,
    @required this.selectedBzTypes,
    @required this.inactiveBzTypes,
    @required this.inactiveBzForms,
    @required this.selectedBzForm,
    @required this.selectedScopes,
    @required this.bzLogo,
    @required this.bzNameTextController,
    @required this.bzAboutTextController,
    @required this.selectedBzZone,
    @required this.bzZone,
    @required this.userModel,
    @required this.bzContacts,
    @required this.appBarType,
    @required this.nameNode,
    @required this.aboutNode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final ValueNotifier<List<AlertModel>> missingFields;
  final ValueNotifier<BzSection> selectedBzSection;
  final ValueNotifier<List<BzType>> selectedBzTypes;
  final ValueNotifier<List<BzType>> inactiveBzTypes;
  final ValueNotifier<List<BzForm>> inactiveBzForms;
  final ValueNotifier<BzForm> selectedBzForm;
  final ValueNotifier<List<SpecModel>> selectedScopes;
  final ValueNotifier<FileModel> bzLogo;
  final TextEditingController bzNameTextController;
  final TextEditingController bzAboutTextController;
  final ValueNotifier<ZoneModel> selectedBzZone;
  final ValueNotifier<ZoneModel> bzZone;
  final UserModel userModel;
  final ValueNotifier<List<ContactModel>> bzContacts;
  final AppBarType appBarType;
  final FocusNode nameNode;
  final FocusNode aboutNode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Form(
      key: formKey,
      child: ValueListenableBuilder(
        valueListenable: missingFields,
        builder: (_, List<AlertModel> missingFields, Widget child){

          // final List<String> _missingFieldsKeys = MapModel.getKeysFromMapModels(missingFields);

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
                        selectedBzTypes: selectedBzTypes,
                        selectedBzSection: selectedBzSection,
                        inactiveBzTypes: inactiveBzTypes,
                        inactiveBzForms: inactiveBzForms,
                        selectedBzForm: selectedBzForm,
                        selectedScopes: selectedScopes,
                      ),
                    );

                  }
              ),

              /// --- BZ TYPE SELECTION
              ValueListenableBuilder(
                  key: const ValueKey<String>('bzType_selection_bubble'),
                  valueListenable: selectedBzTypes,
                  builder: (_, List<BzType> selectedTypes, Widget child){

                    final List<String> _selectedButtons = BzModel.translateBzTypes(
                      context: context,
                      bzTypes: selectedTypes,
                      pluralTranslation: false,
                    );

                    final List<String> _allButtons = BzModel.translateBzTypes(
                      context: context,
                      bzTypes: BzModel.bzTypesList,
                      pluralTranslation: false,
                    );

                    return ValueListenableBuilder(
                        valueListenable: inactiveBzTypes,
                        builder: (_, List<BzType> inactiveTypes, Widget child){

                          final List<String> _inactiveButtons = BzModel.translateBzTypes(
                            context: context,
                            bzTypes: inactiveTypes,
                            pluralTranslation: false,
                          );

                          return MultipleChoiceBubble(
                            title: '##Business Entity type',
                            buttonsList: _allButtons,
                            selectedButtons: _selectedButtons,
                            inactiveButtons: _inactiveButtons,
                            isInError: false,
                            onButtonTap: (int index) => onSelectBzType(
                              context: context,
                              index: index,
                              selectedBzForm: selectedBzForm,
                              inactiveBzForms: inactiveBzForms,
                              inactiveBzTypes: inactiveBzTypes,
                              selectedBzSection: selectedBzSection,
                              selectedBzTypes: selectedBzTypes,
                              selectedScopes: selectedScopes,
                            ),
                          );

                        }
                    );

                  }
              ),

              /// --- BZ FORM SELECTION
              ValueListenableBuilder(
                  key: const ValueKey<String>('bzForm_selection_bubble'),
                  valueListenable: selectedBzForm,
                  builder: (_, BzForm selectedForm, Widget child){

                    final List<String> _buttonsList = BzModel.translateBzForms(
                      context: context,
                      bzForms: BzModel.bzFormsList,
                    );

                    final String _selectedButton = BzModel.translateBzForm(
                      context: context,
                      bzForm: selectedForm,
                    );

                    return ValueListenableBuilder(
                      valueListenable: inactiveBzForms,
                      builder: (_, List<BzForm> inactiveBzForms, Widget child){

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
                            selectedBzForm: selectedBzForm,
                          ),
                        );

                      },
                    );

                  }
              ),

              const DotSeparator(),

              /// --- ADD LOGO
              OLDAddImagePicBubble(
                key: const ValueKey<String>('add_logo_bubble'),
                fileModel: bzLogo,
                titleVerse: 'phid_businessLogo',
                redDot: true,
                bubbleType: BubbleType.bzLogo,
                onAddPicture: (ImagePickerType imagePickerType) => takeBzLogo(
                  context: context,
                  bzLogo: bzLogo,
                  imagePickerType: imagePickerType,
                ),
              ),

              /// --- BZ NAME
              ValueListenableBuilder(
                key: const ValueKey<String>('bz_name_bubble'),
                valueListenable: selectedBzForm,
                builder: (_, BzForm selectedBzForm, Widget child){

                  final String _title =
                  selectedBzForm == BzForm.individual ?
                  'phid_business_entity_name'
                      :
                  'phid_companyName';

                  return TextFieldBubble(
                    globalKey: formKey,
                    focusNode: nameNode,
                    appBarType: appBarType,
                    isFormField: true,
                    key: const Key('bzName'),
                    textController: bzNameTextController,
                    titleVerse: _title,
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
                  );

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
                  valueListenable: selectedBzTypes,
                  builder: (_, List<BzType> bzTypes, Widget child){

                    return ValueListenableBuilder(
                      valueListenable: selectedScopes,
                      builder: (_, List<SpecModel> selectedSpecs, Widget child){

                        final List<String> _phids = SpecModel.getSpecsIDs(selectedSpecs);

                        return WidgetFader(
                          fadeType: Mapper.checkCanLoopList(bzTypes) == true ? FadeType.stillAtMax : FadeType.stillAtMin,
                          min: 0.35,
                          absorbPointer: Mapper.checkCanLoopList(bzTypes) == false,
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
                                  selectedBzTypes: selectedBzTypes,
                                  bzZone: bzZone,
                                ),
                              ),

                            ],
                          ),
                        );
                      },
                    );

                  }
              ),

              const DotSeparator(),

              /// --- BZ ZONE
              ValueListenableBuilder(
                  key: const ValueKey<String>('bz_zone_bubble'),
                  valueListenable: selectedBzZone,
                  builder: (_, ZoneModel bzZone, Widget child){

                    return ZoneSelectionBubble(
                      titleVerse: '##Headquarters zone', //Wordz.hqCity(context),
                      currentZone: bzZone,
                      onZoneChanged: (ZoneModel zone) => onBzZoneChanged(
                        zoneModel: zone,
                        bzZone: selectedBzZone,
                      ),
                    );

                  }
              ),

              /// --- BZ POSITION
              //

              /// --- BZ CONTACTS
              ValueListenableBuilder(
                  valueListenable: bzContacts,
                  builder: (_, List<ContactModel> contacts, Widget child){

                    return ContactsEditorsBubbles(
                      globalKey: formKey,
                      appBarType: appBarType,
                      contacts: contacts,
                      contactsOwnerType: ContactsOwnerType.bz,
                    );

                  },
              ),

              const DotSeparator(),

              const Horizon(),

            ],
          );

        },
      ),
    );

  }
}
