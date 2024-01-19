import 'package:basics/components/bubbles/bubble/bubble.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_slide.dart';
import 'package:bldrs/b_screens/c_bz_screens/e_flyer_maker_screen/flyer_editor_screen/z_components/slides_shelf/b_draft_shelf.dart';
import 'package:bldrs/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/z_components/texting/bldrs_text_field/bldrs_validator.dart';
import 'package:bldrs/z_components/texting/bullet_points/bldrs_bullet_points.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:flutter/material.dart';

class SlidesShelfBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlidesShelfBubble({
    required this.draftNotifier,
    required this.canValidate,
    required this.scrollController,
    required this.onAddSlides,
    required this.onReorderSlide,
    required this.onDeleteSlide,
    required this.onSlideTap,
    required this.loadingSlides,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ValueNotifier<DraftFlyer?> draftNotifier;
  final bool canValidate;
  final ScrollController scrollController;
  final Function(DraftSlide draft) onSlideTap;
  final Function(DraftSlide draft) onDeleteSlide;
  final Function(PicMakerType picMakerType) onAddSlides;
  final Function(int oldIndex, int newIndex) onReorderSlide;
  final ValueNotifier<bool> loadingSlides;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: draftNotifier,
        builder: (_, DraftFlyer? draft, Widget? child){

          return Bubble(
            bubbleColor: Formers.validatorBubbleColor(
              canErrorize: canValidate,
              validator: () => Formers.slidesValidator(
                draftFlyer: draft,
                canValidate: canValidate,
              ),
            ),
            bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
              context: context,
              headlineVerse: const Verse(
                id: 'phid_flyerSlides',
                translate: true,
              ),
              redDot: true,
            ),
            width: Bubble.bubbleWidth(context: context),
            columnChildren: <Widget>[

              /// BULLETS
              const BldrsBulletPoints(
                bulletPoints: <Verse>[
                  Verse(id: 'phid_can_remove_slides_or_flyer_only', translate: true),
                  Verse(id: 'phid_drag_header_to_reorder', translate: true),
                ],
                showBottomLine: false,
              ),

              /// SLIDES SHELF
              SlidesShelf(
                /// PLAN : ADD FLYER LOCATION SLIDE
                shelfNumber: 1,
                draft: draft,
                scrollController: scrollController,
                onReorderSlide: onReorderSlide,
                loadingSlides: loadingSlides,
                onAddSlides: onAddSlides,
                onDeleteSlide: onDeleteSlide,
                onSlideTap: onSlideTap,
              ),

              /// VALIDATOR
              BldrsValidator(
                width: Bubble.clearWidth(context: context),
                validator: () => Formers.slidesValidator(
                  draftFlyer: draft,
                  canValidate: canValidate,
                ),
              ),

            ],
          );

        }
        );

  }
  // -----------------------------------------------------------------------------
}
