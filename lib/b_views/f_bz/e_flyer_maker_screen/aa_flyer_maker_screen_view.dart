import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/file_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/c_phid_button.dart';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_bullet_points.dart';
import 'package:bldrs/b_views/z_components/bubble/bubbles_separator.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/info_button/expanded_info_page_parts/info_page_specs.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/b_draft_shelf.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
import 'package:bldrs/b_views/z_components/profile_editors/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/pdf_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/x_flyer_maker_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerMakerScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerMakerScreenView({
    @required this.formKey,
    @required this.scrollController,
    @required this.draft,
    @required this.headlineController,
    @required this.loading,
    @required this.isEditingFlyer,
    @required this.originalFlyer,
    @required this.appBarType,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final ScrollController scrollController;
  final ValueNotifier<DraftFlyerModel> draft;
  final TextEditingController headlineController;
  final ValueNotifier<bool> loading;
  final bool isEditingFlyer;
  final FlyerModel originalFlyer;
  final AppBarType appBarType;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// TASK : SHOULD BE ABLE TO DELETE A SLIDE FROM THE SHELF WHILE EDITING WITHOUT
    /// GOING INTO THE FUCKING GALLERY BITCH

    final BzModel _bzModel = BzzProvider.proGetActiveBzModel(
        context: context,
        listen: true,
    );

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
                  final String _translatedFlyerType = FlyerTyper.translateFlyerType(
                    context: context,
                    flyerType: _draft.flyerType,
                    pluralTranslation: false,
                  );


                  return Form(
                    key: formKey,
                    child: Scroller(
                      controller: scrollController,
                      child: ListView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(top: Ratioz.stratosphere, bottom: Ratioz.horizon),
                        children: <Widget>[

                          /// SHELVES
                          Bubble(
                            width: Bubble.bubbleWidth(context: context, stretchy: false),
                            title: 'Flyer Slides',
                            columnChildren: <Widget>[

                              SlidesShelf(
                                /// PLAN : ADD FLYER LOCATION SLIDE
                                bzModel: _bzModel,
                                shelfNumber: 1,
                                draft: draft,
                                headlineController: headlineController,
                                isEditingFlyer: isEditingFlyer,
                              ),

                            ],
                          ),

                          const DotSeparator(),

                          /// FLYER HEADLINE
                          TextFieldBubble(
                            appBarType: appBarType,
                            key: const ValueKey<String>('flyer_headline_text_field'),
                            isFormField: true,
                            textController: headlineController,
                            titleVerse: '##Flyer Headline',
                            fieldIsRequired: true,
                            counterIsOn: true,
                            maxLength: 50,
                            maxLines: 3,
                            keyboardTextInputType: TextInputType.multiline,
                            // fieldIsRequired: false,
                            textOnChanged: (String text) => onUpdateFlyerHeadline(
                              draft: draft,
                              headlineController: headlineController,
                            ),
                            validator: () => flyerHeadlineValidator(
                              headlineController: headlineController,
                            ),
                            // bubbleColor: _bzScopeError ? Colorz.red125 : Colorz.white20,
                          ),

                          /// FLYER DESCRIPTION
                          TextFieldBubble(
                            appBarType: appBarType,
                            key: const ValueKey<String>('bz_scope_bubble'),
                            textController: _draft.descriptionController,
                            titleVerse: '##Flyer Description',
                            counterIsOn: true,
                            maxLength: 1000,
                            maxLines: 7,
                            keyboardTextInputType: TextInputType.multiline,
                            // bubbleColor: _bzScopeError ? Colorz.red125 : Colorz.white20,
                          ),

                          const DotSeparator(),

                          /// FLYER TYPE SELECTOR
                          MultipleChoiceBubble(
                            title: '##Flyer type',
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
                            isInError: false,
                            inactiveButtons: <String>[
                              ...FlyerTyper.translateFlyerTypes(
                                context: context,
                                flyerTypes: FlyerTyper.concludeInactiveFlyerTypesByBzModel(
                                  bzModel: _bzModel,
                                ),
                                pluralTranslation: false,
                              )
                            ],
                          ),

                          /// SPECS SELECTOR
                          WidgetFader(
                            fadeType: _draft.flyerType == null ? FadeType.stillAtMin : FadeType.stillAtMax,
                            min: 0.35,
                            absorbPointer: _draft.flyerType == null,
                            child: Bubble(
                              width: Bubble.bubbleWidth(context: context, stretchy: false),
                              title: 'Specifications',
                              columnChildren: <Widget>[

                                BubbleBulletPoints(
                                  bulletPoints: <String>[
                                    '##Add $_translatedFlyerType specification to describe and allow advanced search criteria',
                                  ],
                                  translateBullets: true,
                                ),

                                InfoPageSpecs(
                                  pageWidth: Bubble.clearWidth(context),
                                  specs: _draft.specs,
                                  flyerType: _draft.flyerType,
                                ),

                                DreamBox(
                                  height: PhidButton.getHeight(),
                                  // width: Bubble.clearWidth(context),
                                  verse: Mapper.checkCanLoopList(_draft.keywordsIDs) ? 'Edit Specifications' : 'Add Specifications',
                                  bubble: false,
                                  color: Colorz.white20,
                                  verseScaleFactor: 1.5,
                                  verseWeight: VerseWeight.thin,
                                  icon: Iconz.plus,
                                  iconSizeFactor: 0.4,
                                  iconColor: Colorz.white20,
                                  onTap: () => onAddSpecsTap(
                                    context: context,
                                    draft: draft,
                                  ),
                                ),

                              ],
                            ),
                          ),

                          const DotSeparator(),

                          PDFSelectionBubble(
                            appBarType: appBarType,
                            formKey: formKey,
                            existingPDF: _draft.pdf,
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
                          ),

                          const DotSeparator(),

                          /// SHOW FLYER AUTHOR
                          Bubble(
                            width: Bubble.bubbleWidth(context: context, stretchy: false),
                            title: 'Show Flyer author on Flyer',
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

  }

}
