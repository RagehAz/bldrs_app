import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/f_flyer/draft/draft_flyer_model.dart';
import 'package:bldrs/b_views/f_bz/e_flyer_maker_screen/z_components/slides_shelf/b_draft_shelf.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bldrs_bubble_header_vm.dart';
import 'package:bldrs/b_views/z_components/texting/bldrs_text_field/bldrs_validator.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';

class SlidesShelfBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SlidesShelfBubble({
    @required this.bzModel,
    @required this.draftNotifier,
    @required this.canValidate,
    @required this.focusNode,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final ValueNotifier<DraftFlyer> draftNotifier;
  final bool canValidate;
  final FocusNode focusNode;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Bubble(
      bubbleColor: Formers.validatorBubbleColor(
        canErrorize: canValidate,
        validator: () => Formers.slidesValidator(
          draftFlyer: draftNotifier.value,
          canValidate: canValidate,
        ),
      ),
      bubbleHeaderVM: BldrsBubbleHeaderVM.bake(
        context: context,
        headlineVerse: const Verse(
          id: 'phid_flyerSlides',
          translate: true,
        ),
      ),
      width: Bubble.bubbleWidth(context: context),
      columnChildren: <Widget>[

        /// SLIDES SHELF
        SlidesShelf(
          /// PLAN : ADD FLYER LOCATION SLIDE
          bzModel: bzModel,
          shelfNumber: 1,
          draftNotifier: draftNotifier,
        ),

        BldrsValidator(
          width: Bubble.clearWidth(context: context),
          validator: () => Formers.slidesValidator(
            draftFlyer: draftNotifier.value,
            canValidate: canValidate,
          ),
          focusNode: focusNode,
        ),

      ],
    );

  }
  // -----------------------------------------------------------------------------
}
