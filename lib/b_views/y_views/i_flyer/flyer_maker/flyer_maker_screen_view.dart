import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/mutables/draft_flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/flyer_type_class.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer_maker/flyer_maker_structure/b_draft_shelf/b_draft_shelf.dart';
import 'package:bldrs/b_views/z_components/profile_editors/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/profile_editors/zone_selection_bubble.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/text_field_bubble.dart';
import 'package:bldrs/c_controllers/i_flyer_maker_controllers/flyer_maker_controller.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlyerMakerScreenView extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerMakerScreenView({
    @required this.formKey,
    @required this.scrollController,
    @required this.bzModel,
    @required this.draft,
    @required this.headlineController,
    @required this.onPublish,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final GlobalKey<FormState> formKey;
  final ScrollController scrollController;
  final BzModel bzModel;
  final ValueNotifier<DraftFlyerModel> draft;
  final TextEditingController headlineController;
  final Function onPublish;
// -----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {

    return Form(
      key: formKey,
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
                bzModel: bzModel,
                shelfNumber: 1,
                draft: draft,
                headlineController: headlineController,
              ),
            ],
          ),

          /// FLYER HEADLINE
          TextFieldBubble(
            key: const ValueKey<String>('flyer_headline_text_field'),
            isFormField: true,
            textController: headlineController,
            title: 'Flyer Headline',
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

          /// FLYER TYPE SELECTOR
          ValueListenableBuilder(
              valueListenable: draft,
              builder: (_, DraftFlyerModel _draft, Widget child){

                blog('building draft flyer type bubble with ${_draft.flyerType}');

                final List<String> _bzTypeTranslation = BzModel.translateBzTypes(
                    context: context,
                    bzTypes: bzModel.bzTypes
                );

                final List<FlyerType> _allowableTypes = concludePossibleFlyerTypesByBzTypes(
                  bzTypes: bzModel.bzTypes,
                );

                final List<String> _flyerTypesTranslation = translateFlyerTypes(
                    context: context,
                    flyerTypes: _allowableTypes,
                );


                return MultipleChoiceBubble(
                  title: 'Flyer type',
                  notes: <String>[
                    'Business accounts of types ${_bzTypeTranslation.toString()} can publish ${_flyerTypesTranslation.toString()} flyers.',
                    'Each Flyer Should have one flyer type',
                  ],
                  buttonsList: translateFlyerTypes(
                    context: context,
                    flyerTypes: flyerTypesList,
                    pluralTranslation: false,
                  ),
                  selectedButtons: <String>[
                    translateFlyerType(
                      context: context,
                      flyerType: _draft.flyerType,
                      pluralTranslation: false,
                    ),
                  ],
                  onButtonTap: (int index) => onSelectFlyerType(
                    index: index,
                    draft: draft,
                  ),
                  isInError: false,
                  inactiveButtons: <String>[
                    ...translateFlyerTypes(
                      context: context,
                      flyerTypes: concludeInactiveFlyerTypesByBzModel(
                        bzModel: bzModel,
                      ),
                      pluralTranslation: false,
                    )
                  ],
                );

              }
          ),

          /// FLYER DESCRIPTION
          TextFieldBubble(
            key: const ValueKey<String>('bz_scope_bubble'),
            textController: TextEditingController(),
            title: 'Flyer Description',
            counterIsOn: true,
            maxLength: 1000,
            maxLines: 5,
            keyboardTextInputType: TextInputType.multiline,
            // bubbleColor: _bzScopeError ? Colorz.red125 : Colorz.white20,
          ),

          /// KEYWORDS SELECTOR
          Bubble(
            width: Bubble.bubbleWidth(context: context, stretchy: false),
            title: 'Search Keywords',
            columnChildren: const <Widget>[],
          ),

          /// SPECS SELECTOR
          Bubble(
            width: Bubble.bubbleWidth(context: context, stretchy: false),
            title: 'Specifications',
            columnChildren: const <Widget>[],
          ),

          /// ZONE SELECTOR
          const ZoneSelectionBubble(
            title: 'Flyer Target city',
            // description: 'Select The city you would like this '
            //     'flyer to target, each flyer can target only'
            //     ' one city, and selecting district  increases '
            //     'the probability of this flyer to gain more '
            //     'views in that district',
            onZoneChanged: null,
            currentZone: null,
          ),

          /// SHOW FLYER AUTHOR
          Bubble(
            width: Bubble.bubbleWidth(context: context, stretchy: false),
            title: 'Show Flyer author on Flyer',
            columnChildren: const <Widget>[],
          ),

          Align(
            alignment: superCenterAlignment(context),
            child: DreamBox(
              height: 50,
              color: Colorz.yellow255,
              verseColor: Colorz.black255,
              verse: superPhrase(context, 'phid_publish'),
              margins: Ratioz.appBarMargin,
              onTap: onPublish,
            ),
          ),

        ],

      ),
    );

  }
}
