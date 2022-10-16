import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/x_utilities/file_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/show_author_switcher/show_author_switch_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/a_slides_shelf_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/specs_selector/a_specs_selector_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/pdf_bubble/pdf_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/zone_bubble/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerMakerScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerMakerScreenView({
    @required this.formKey,
    @required this.scrollController,
    @required this.draft,
    @required this.loading,
    @required this.isEditingFlyer,
    @required this.originalFlyer,
    @required this.appBarType,
    @required this.canValidate,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final ScrollController scrollController;
  final ValueNotifier<DraftFlyerModel> draft;
  final ValueNotifier<bool> loading;
  final ValueNotifier<bool> isEditingFlyer;
  final FlyerModel originalFlyer;
  final AppBarType appBarType;
  final bool canValidate;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    /// TASK : SHOULD BE ABLE TO DELETE A SLIDE FROM THE SHELF WHILE EDITING WITHOUT GOING INTO THE FUCKING GALLERY BITCH
    // --------------------
    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
      context: context,
      listen: true,
    );
    // --------------------
    return ValueListenableBuilder(
        valueListenable: loading,
        builder: (_, bool isLoading, Widget child){

          if (isLoading == true){
            return const SizedBox();
          }

          else {

            return ValueListenableBuilder(
                valueListenable: draft,
                builder: (_, DraftFlyerModel _draft, Widget child){

                  final List<String> _bzTypeTranslation = BzModel.getBzTypesPhids(
                      context: context,
                      bzTypes: _bzModel.bzTypes
                  );
                  final List<FlyerType> _allowableTypes = FlyerTyper.concludePossibleFlyerTypesByBzTypes(
                    bzTypes: _bzModel.bzTypes,
                  );
                  final List<Verse> _flyerTypesTranslation = Verse.createVerses(
                    strings: FlyerTyper.translateFlyerTypes(
                      context: context,
                      flyerTypes: _allowableTypes,
                    ),
                    translate: false,
                  );

                  return Form(
                    key: formKey,
                    child: Scroller(
                      controller: scrollController,
                      child: ListView(
                        controller: scrollController,
                        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
                        children: <Widget>[

                          /// SHELVES
                          SlidesShelfBubble(
                            canValidate: canValidate,
                            draft: draft,
                            bzModel: _bzModel,
                            isEditingFlyer: isEditingFlyer,
                          ),

                          /// SEPARATOR
                          const DotSeparator(),

                          /// FLYER HEADLINE
                          TextFieldBubble(
                            key: const ValueKey<String>('flyer_headline_text_field'),
                            headerViewModel: const BubbleHeaderVM(
                              headlineVerse: Verse(
                                text: 'phid_flyer_headline',
                                translate: true,
                              ),
                              redDot: true,
                            ),
                            globalKey: formKey,
                            focusNode: _draft.headlineNode,
                            appBarType: appBarType,
                            isFormField: true,
                            counterIsOn: true,
                            maxLength: 50,
                            maxLines: 3,
                            keyboardTextInputType: TextInputType.multiline,
                            onTextChanged: (String text) => onUpdateFlyerHeadline(
                              draft: draft,
                              text: text,
                            ),
                            initialText: _draft.headline,
                            validator: (String text) => Formers.flyerHeadlineValidator(
                              context: context,
                              headline: _draft.headline,
                              canValidate: canValidate,
                            ),
                          ),

                          /// FLYER DESCRIPTION
                          TextFieldBubble(
                            key: const ValueKey<String>('bz_scope_bubble'),
                            headerViewModel: const BubbleHeaderVM(
                              headlineVerse: Verse(
                                text: 'phid_flyer_description',
                                translate: true,
                              ),
                            ),
                            globalKey: formKey,
                            focusNode: _draft.descriptionNode,
                            appBarType: appBarType,
                            isFormField: true,
                            counterIsOn: true,
                            maxLength: 1000,
                            maxLines: 7,
                            keyboardTextInputType: TextInputType.multiline,
                            initialText: _draft.description,
                            validator: (String text) => Formers.paragraphValidator(
                              text: _draft.description,
                              canValidate: canValidate,
                            ),
                            onTextChanged: (String text) => onUpdateFlyerDescription(
                              draft: draft,
                              text: text,
                            ),
                          ),

                          /// SEPARATOR
                          const DotSeparator(),

                          /// FLYER TYPE SELECTOR
                          MultipleChoiceBubble(
                            titleVerse: const Verse(
                              text: 'phid_flyer_type',
                              translate: true,
                            ),
                            bulletPoints: <Verse>[

                              Verse(
                                text: '##Business accounts of types '
                                    '${_bzTypeTranslation.toString()} can publish '
                                    '${_flyerTypesTranslation.toString()} flyers.',
                                translate: true,
                                variables: [_bzTypeTranslation.toString(), _flyerTypesTranslation.toString()],
                              ),

                              const Verse(
                                text: '##Each Flyer Should have one flyer type',
                                translate: true,
                              ),

                            ],
                            buttonsVerses: Verse.createVerses(
                              strings: FlyerTyper.translateFlyerTypes(
                                context: context,
                                flyerTypes: FlyerTyper.flyerTypesList,
                                pluralTranslation: false,
                              ),
                              translate: false,
                            ),
                            selectedButtonsPhids: <String>[
                              FlyerTyper.getFlyerTypePhid(
                                flyerType: _draft.flyerType,
                                pluralTranslation: false,
                              ),
                            ],
                            onButtonTap: (int index) => onSelectFlyerType(
                              context: context,
                              index: index,
                              draft: draft,
                            ),
                            inactiveButtons: <Verse>[
                              ...Verse.createVerses(
                                  strings: FlyerTyper.translateFlyerTypes(
                                    context: context,
                                    flyerTypes: FlyerTyper.concludeInactiveFlyerTypesByBzModel(
                                      bzModel: _bzModel,
                                    ),
                                    pluralTranslation: false,
                                  ),
                                  translate: false,
                              ),
                            ],

                            validator: () => Formers.flyerTypeValidator(
                              context: context,
                              draft: draft.value,
                              canValidate: canValidate,
                            ),
                          ),

                          /// SPECS SELECTOR
                          SpecsSelectorBubble(
                            bzModel: _bzModel,
                            draft: _draft,
                            draftNotifier: draft,
                          ),

                          /// SEPARATOR
                          const DotSeparator(),

                          /// PDF SELECTOR
                          PDFSelectionBubble(
                            appBarType: appBarType,
                            formKey: formKey,
                            existingPDF: _draft.pdf,
                            canValidate: canValidate,
                            onChangePDF: (FileModel pdf) => onChangeFlyerPDF(
                              draft: draft,
                              pdf: pdf,
                            ),
                            onDeletePDF: () => onRemoveFlyerPDF(
                              draft: draft
                            ),
                          ),

                          /// SEPARATOR
                          const DotSeparator(),

                          /// ZONE SELECTOR
                          ZoneSelectionBubble(
                            titleVerse: const Verse(
                              text: 'phid_flyer_target_city',
                              translate: true,
                            ),
                            bulletPoints: const <Verse>[
                              Verse(
                                pseudo: 'Select The city you would like this flyer to target',
                                text: 'phid_select_city_you_want_to_target',
                                translate: true,
                              ),
                              Verse(
                                pseudo: 'Each flyer can target only one city',
                                text: 'phid_each_flyer_target_one_city',
                                translate: true,
                              ),
                              Verse(
                                pseudo: 'Selecting district increases the probability of this flyer to gain more views in that district',
                                text: 'phid_selecting_district_focuses_search',
                                translate: true,
                              ),
                            ],
                            currentZone: _draft.zone,
                            onZoneChanged: (ZoneModel zone) => onZoneChanged(
                              context: context,
                              draft: draft,
                              zone: zone,
                            ),
                            validator: () => Formers.zoneValidator(
                              zoneModel: _draft.zone,
                              selectCountryAndCityOnly: true,
                              selectCountryIDOnly: false,
                              canValidate: canValidate,
                            ),
                          ),

                          /// SEPARATOR
                          const DotSeparator(),

                          /// SHOW FLYER AUTHOR
                          ShowAuthorSwitchBubble(
                            draft: _draft,
                            bzModel: _bzModel,
                            onSwitch: (bool value) => onSwitchFlyerShowsAuthor(
                              value: value,
                              draft: draft,
                            ),
                          ),

                        ],

                      ),
                    ),
                  );

                });

          }

        }
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
