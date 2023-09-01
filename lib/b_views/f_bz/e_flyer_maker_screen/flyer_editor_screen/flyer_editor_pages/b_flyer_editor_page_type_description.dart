import 'package:basics/helpers/classes/strings/text_clip_board.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/phids_bubble/multiple_choice_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editors_buttons/editor_swiping_buttons.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:flutter/material.dart';

class FlyerEditorPage1TypeDescription extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlyerEditorPage1TypeDescription({
    required this.canGoNext,
    required this.onNextTap,
    required this.onPreviousTap,
    required this.draft,
    required this.onSelectFlyerType,
    required this.canValidate,
    super.key,
  });
  /// --------------------------------------------------------------------------
  final bool canGoNext;
  final Function onNextTap;
  final Function onPreviousTap;
  final DraftFlyer? draft;
  final Function(int index) onSelectFlyerType;
  final bool canValidate;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsFloatingList(
      columnChildren: <Widget>[

        /// FLYER TYPE SELECTOR
        MultipleChoiceBubble(
          titleVerse: const Verse(
            id: 'phid_flyer_type',
            translate: true,
          ),
          // bulletPoints: <Verse>[
          // Verse(
          //   text: '#!# Business accounts of types '
          //       '${_bzTypeTranslation.toString()} can publish '
          //       '${_flyerTypesTranslation.toString()} flyers.',
          //   translate: true,
          //   variables: [_bzTypeTranslation.toString(), _flyerTypesTranslation.toString()],
          // ),
          //
          // const Verse(
          //   text: '#!# Each Flyer Should have one flyer type',
          //   translate: true,
          // ),
          // ],
          buttonsVerses: Verse.createVerses(
            strings: FlyerTyper.translateFlyerTypes(
              context: context,
              flyerTypes: FlyerTyper.flyerTypesList,
              pluralTranslation: false,
            ),
            translate: false,
          ),
          selectedButtonsPhids: FlyerTyper.translateFlyerTypes(
            context: context,
            flyerTypes: draft?.flyerType == null ? [] : <FlyerType>[draft!.flyerType!],
            pluralTranslation: false,
          ),
          onButtonTap: onSelectFlyerType,
          inactiveButtons: <Verse>[
            ...Verse.createVerses(
              strings: FlyerTyper.translateFlyerTypes(
                context: context,
                flyerTypes: FlyerTyper.concludeInactiveFlyerTypesByBzModel(
                  bzModel: draft?.bzModel,
                ),
                pluralTranslation: false,
              ),
              translate: false,
            ),
          ],
          validator: () => Formers.flyerTypeValidator(
            draft: draft,
            canValidate: canValidate,
          ),
        ),

        /// FLYER DESCRIPTION
        BldrsTextFieldBubble(
          key: const ValueKey<String>('bz_scope_bubble'),
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(
              id: 'phid_flyer_description',
              translate: true,
            ),
          ),
          formKey: draft?.formKey,
          focusNode: draft?.descriptionNode,
          appBarType: AppBarType.non,
          isFormField: true,
          counterIsOn: true,
          maxLength: 5000,
          maxLines: 7,
          keyboardTextInputType: TextInputType.multiline,
          textController: draft?.description,
          bulletPoints: const <Verse>[
            Verse(id: 'phid_optional_field', translate: true),
            Verse(id: 'phid_its_good_to_add_description', translate: true),
          ],
          validator: (String? text) => Formers.paragraphValidator(
            text: draft?.description?.text,
            canValidate: canValidate,
          ),
          autoCorrect: Keyboard.autoCorrectIsOn(),
          enableSuggestions: Keyboard.suggestionsEnabled(),
          pasteFunction: () async {
            final String? _text = await TextClipBoard.paste();
            if (_text != null){
              draft?.description?.text = _text;
            }
          },
        ),

        /// SWIPING BUTTONS
        EditorSwipingButtons(
          onNext: onNextTap,
          onPrevious: onPreviousTap,
          canGoNext: canGoNext,
        ),

        /// KEYBOARD PUSHER
        const Horizon(heightFactor: 0),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
