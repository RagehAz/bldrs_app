import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/a_slides_shelf_bubble.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/bubbles/b_variants/text_field_bubble/text_field_bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/editors_buttons/editor_swiping_buttons.dart';
import 'package:bldrs/b_views/z_components/layouts/custom_layouts/bldrs_floating_list.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/horizon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

class FlyerEditorPage0SlidesHeadlines extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const FlyerEditorPage0SlidesHeadlines({
    required this.canValidate,
    required this.onHeadlineTextChanged,
    required this.draftNotifier,
    required this.onNext,
    required this.shelfScrollController,
    required this.onAddSlides,
    required this.onReorderSlide,
    required this.onDeleteSlide,
    required this.onSlideTap,
    required this.loadingSlides,
    required this.canGoFrom0to1,
    super.key,
  });
  // -----------------------------------------------------------------------------
  final bool canValidate;
  final ValueChanged<String?>? onHeadlineTextChanged;
  final ValueNotifier<DraftFlyer?> draftNotifier;
  final Function? onNext;
  final ScrollController shelfScrollController;
  final Function(DraftSlide draft) onSlideTap;
  final Function(DraftSlide draft) onDeleteSlide;
  final Function(PicMakerType picMakerType) onAddSlides;
  final Function(int oldIndex, int newIndex) onReorderSlide;
  final ValueNotifier<bool> loadingSlides;
  final bool Function(DraftFlyer? draft) canGoFrom0to1;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    blog('FlyerEditorPage0SlidesHeadlines.build() x');

    return BldrsFloatingList(
      columnChildren: <Widget>[

        /// SHELVES
        SlidesShelfBubble(
          canValidate: canValidate,
          onSlideTap: onSlideTap,
          onDeleteSlide: onDeleteSlide,
          onAddSlides: onAddSlides,
          loadingSlides: loadingSlides,
          onReorderSlide: onReorderSlide,
          scrollController: shelfScrollController,
          draftNotifier: draftNotifier,
        ),

        /// FLYER HEADLINE
        BldrsTextFieldBubble(
          key: const ValueKey<String>('flyer_headline_text_field_x'),
          bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
            context: context,
            headlineVerse: const Verse(
              id: 'phid_flyer_headline',
              translate: true,
            ),
            redDot: true,
          ),
          formKey: draftNotifier.value?.formKey,
          focusNode: draftNotifier.value?.headlineNode,
          appBarType: AppBarType.non,
          isFormField: true,
          counterIsOn: true,
          maxLength: Standards.flyerHeadlineMaxLength,
          maxLines: 5,
          keyboardTextInputType: TextInputType.multiline,
          // onTextChanged: onHeadlineTextChanged,
          textController: draftNotifier.value?.headline,
          validator: (String? text) => Formers.flyerHeadlineValidator(
            headline: text,
            canValidate: canValidate,
          ),
          autoCorrect: Keyboard.autoCorrectIsOn(),
          enableSuggestions: Keyboard.suggestionsEnabled(),
          bulletPoints: const <Verse>[
            Verse(id: 'phid_flyer_headline_is_from_first_slide', translate: true),
          ],
        ),

        /// SWIPING BUTTONS
        ValueListenableBuilder(
          valueListenable: draftNotifier,
          builder: (_, DraftFlyer? draft, Widget? child){
            return EditorSwipingButtons (
              onNext: onNext,
              canGoNext: canGoFrom0to1(draft),
            );
          }
        ),

        /// KEYBOARD PUSHER
        const Horizon(heightFactor: 0),

      ],
    );

  }

}
