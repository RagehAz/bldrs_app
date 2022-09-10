import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/a_slides_shelf_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/specs_selector/a_specs_selector_bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/profile_editors/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/pdf_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/bubbles/text_field_bubble.dart';
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

                  final List<String> _bzTypeTranslation = BzModel.translateBzTypes(
                      context: context,
                      bzTypes: _bzModel.bzTypes
                  );
                  final List<FlyerType> _allowableTypes = FlyerTyper.concludePossibleFlyerTypesByBzTypes(
                    bzTypes: _bzModel.bzTypes,
                  );
                  final List<String> _flyerTypesTranslation = FlyerTyper.translateFlyerTypes(
                    context: context,
                    flyerTypes: _allowableTypes,
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
                            globalKey: formKey,
                            focusNode: _draft.headlineNode,
                            appBarType: appBarType,
                            isFormField: true,
                            titleVerse: 'phid_flyer_headline',
                            fieldIsRequired: true,
                            counterIsOn: true,
                            maxLength: 50,
                            maxLines: 3,
                            keyboardTextInputType: TextInputType.multiline,
                            textOnChanged: (String text) => onUpdateFlyerHeadline(
                              draft: draft,
                              text: text,
                            ),
                            initialTextValue: _draft.headline,
                            validator: () => Formers.flyerHeadlineValidator(
                              headline: _draft.headline,
                              canValidate: canValidate,
                            ),
                          ),

                          /// FLYER DESCRIPTION
                          TextFieldBubble(
                            key: const ValueKey<String>('bz_scope_bubble'),
                            globalKey: formKey,
                            focusNode: _draft.descriptionNode,
                            appBarType: appBarType,
                            isFormField: true,
                            titleVerse: 'phid_flyer_description',
                            counterIsOn: true,
                            maxLength: 1000,
                            maxLines: 7,
                            keyboardTextInputType: TextInputType.multiline,
                            initialTextValue: _draft.description,
                            validator: () => Formers.paragraphValidator(
                              text: _draft.description,
                              canValidate: canValidate,
                            ),
                            textOnChanged: (String text) => onUpdateFlyerDescription(
                              draft: draft,
                              text: text,
                            ),
                          ),

                          /// SEPARATOR
                          const DotSeparator(),

                          /// FLYER TYPE SELECTOR
                          MultipleChoiceBubble(
                            title: 'phid_flyer_type',
                            bulletPoints: <String>[
                              '##Business accounts of types ${_bzTypeTranslation.toString()} can publish ${_flyerTypesTranslation.toString()} flyers.',
                              '##Each Flyer Should have one flyer type',
                            ],
                            buttonsList: FlyerTyper.translateFlyerTypes(
                              context: context,
                              flyerTypes: FlyerTyper.flyerTypesList,
                              pluralTranslation: false,
                            ),
                            selectedButtons: <String>[
                              FlyerTyper.translateFlyerType(
                                context: context,
                                flyerType: _draft.flyerType,
                                pluralTranslation: false,
                              ),
                            ],
                            onButtonTap: (int index) => onSelectFlyerType(
                              context: context,
                              index: index,
                              draft: draft,
                            ),
                            inactiveButtons: <String>[
                              ...FlyerTyper.translateFlyerTypes(
                                context: context,
                                flyerTypes: FlyerTyper.concludeInactiveFlyerTypesByBzModel(
                                  bzModel: _bzModel,
                                ),
                                pluralTranslation: false,
                              )
                            ],

                            validator: () => Formers.flyerTypeValidator(
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
                            onChangePDF: (FileModel pdf){
                              blog('onChangePDF : aho with ${pdf.fileName}');
                              draft.value = draft.value.copyWith(
                                pdf: pdf,
                              );
                            },
                            onDeletePDF: (){
                              draft.value = DraftFlyerModel.removePDF(draft.value);
                            },
                          ),

                          /// SEPARATOR
                          const DotSeparator(),

                          /// ZONE SELECTOR
                          ZoneSelectionBubble(
                            titleVerse: '##Flyer Target city',
                            bulletPoints: const <String>[
                              '##Select The city you would like this flyer to target',
                              '##each flyer can target only one city',
                              '##Selecting district increases the probability of this flyer to gain more views in that district',
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
                          Bubble(
                            headerViewModel: const BubbleHeaderVM(
                              headlineVerse: 'phid_show_author_on_flyer',
                            ),
                            screenWidth: Bubble.bubbleWidth(context: context, stretchy: false),
                            columnChildren: const <Widget>[],
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
